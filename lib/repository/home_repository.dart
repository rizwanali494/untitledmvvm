import 'package:untitledmvvm/res/app_urls.dart';
import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/new_list_model.dart';

class HomeRepository {

  final BaseApiServices _apiServices = Networkapiservice();

  Future<NewListModel> listApi() async {
   try{
     dynamic response = await _apiServices.getGetApiResponse(AppUrls.list);
     return response = NewListModel.fromJson(response);
   }catch(e){
     rethrow;
   }
  }
}