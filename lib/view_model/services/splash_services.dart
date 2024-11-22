import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:untitledmvvm/model/user_model.dart';
import 'package:untitledmvvm/utils/routes/routes_name.dart';
import 'package:untitledmvvm/view_model/user_view_model.dart';

class SplashServices{

  Future<UserModel> getUserData() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserData().then((value) async{
      if (value.token == 'null' || value.token == '') {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
       await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print("Error during authentication check: ${error.toString()}");
      }
    });
  }
}