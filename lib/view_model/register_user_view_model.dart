import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/new_user_model.dart';

class RegisterUserViewModel with ChangeNotifier{

  Future<bool> saveUser(NewUserModel user) async{
    final SharedPreferences nsp = await SharedPreferences.getInstance();
    nsp.setString('id', user.id.toString());
    nsp.setString('token', user.token.toString());
    notifyListeners();
    return true;
  }

  Future<NewUserModel> getUser() async{
    final SharedPreferences nsp = await SharedPreferences.getInstance();
    final int id = nsp.getInt('id') ?? 0;
    final String? token = nsp.getString('token');
    return NewUserModel(id: id, token: token.toString());

  }

  Future<bool> remove()async{
    final SharedPreferences nsp = await SharedPreferences.getInstance();
    nsp.remove('token');
    nsp.remove('id');
    return true;
  }
}