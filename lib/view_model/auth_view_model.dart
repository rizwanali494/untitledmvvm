import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:untitledmvvm/utils/routes/routes_name.dart';
import 'package:untitledmvvm/view_model/user_view_model.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../utils/utils.dart';

class AuthViewModel with ChangeNotifier {

  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _sgnUpLoading = false;
  bool get sgnUpLoading => _sgnUpLoading;

  setLoading(bool value){
    _loading= value;
    notifyListeners();
  }

  setSignUpLoading(bool value){
    _sgnUpLoading= value;
    notifyListeners();
  }

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(data).then((value) async {
      setLoading(false);
      String token = value['token'];
      UserViewModel userViewModel = UserViewModel();
      await userViewModel.saveUser(UserModel(token: token));
      Utils.flushBarErrorMessages("Login Successfully", context);
      Navigator.pushNamed(context, RoutesName.home);
      if(kDebugMode){
        print('Response: ${value.toString()}');
      }
    }).onError((error, stackTrace){
      setLoading(false);
      Utils.flushBarErrorMessages(error.toString(), context);
      if(kDebugMode){
        print('Error: ${error.toString()}');
      }
    });

  }

  Future<void> signUpApi(dynamic data, BuildContext context)async{
    setSignUpLoading(true);
    _myRepo.signUpApi(data).then((value){
      setSignUpLoading(false);

      Navigator.pushNamed(context, RoutesName.home);
      Utils.flushBarErrorMessages("SignUp Successfully", context);
      if(kDebugMode){
        print("error ${value.toString()}");
      }
    }).onError((error, stackTrace){
      setSignUpLoading(false);
      Utils.flushBarErrorMessages(error.toString(), context);
      if(kDebugMode){
        print("error ${error.toString()}");
      }
    });
  }
}