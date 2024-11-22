import 'package:untitledmvvm/data/network/BaseApiServices.dart';
import 'package:untitledmvvm/data/network/NetworkApiService.dart';
import 'package:untitledmvvm/res/app_urls.dart';

class AuthRepository {
  final BaseApiServices _apiServices = Networkapiservice();

  Future<dynamic> loginApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrls.loginUrl, data);
      return response;
    }catch(e){
      rethrow;
    }
  }

  Future<dynamic> signUpApi(dynamic data) async{
    try{
      dynamic response = await _apiServices.getPostApiResponse(AppUrls.registerUrl, data);
      return response;
    }catch(e){
      rethrow;
    }
  }

}