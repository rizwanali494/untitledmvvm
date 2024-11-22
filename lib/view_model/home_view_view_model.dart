  import 'package:flutter/foundation.dart';
  import 'package:untitledmvvm/data/response/api_response.dart';
  import 'package:untitledmvvm/model/new_list_model.dart';
  import '../repository/home_repository.dart';

  class HomeViewViewModel with ChangeNotifier{

    final _myRepo = HomeRepository();

    ApiResponse<NewListModel> list = ApiResponse.loading();

    setList(ApiResponse<NewListModel> response){
      list = response;
      notifyListeners();
    }

    Future<void> fetchData()async{
      setList(ApiResponse.loading());
      _myRepo.listApi().then((value){
        setList(ApiResponse.completed(value));
        if(kDebugMode){
          print('Response1234: ${value.toString()}');
        }
      }).onError((error, stackTrace){
        setList(ApiResponse.error(error.toString()));
        if(kDebugMode){
          print('error1234: ${error.toString()}');
        }
      });
    }

  }