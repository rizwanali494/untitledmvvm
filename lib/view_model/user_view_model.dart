import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitledmvvm/model/user_model.dart';

class UserViewModel with ChangeNotifier{

  Future<bool> saveUser(UserModel user)async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<UserModel> getUser() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString('token');
    if (kDebugMode) {
      print('token; ${sp.getString('token').toString()}');
    }
    return UserModel(token: token.toString());
  }

  Future<bool> remove() async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('token');
    return true;
  }

  Future<Object?> loadToken()async{
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('token').toString();
  }
}