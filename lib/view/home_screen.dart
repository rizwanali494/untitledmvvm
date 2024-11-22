import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitledmvvm/utils/routes/routes_name.dart';
import 'package:untitledmvvm/view_model/home_view_view_model.dart';
import 'package:untitledmvvm/view_model/user_view_model.dart';
import '../data/response/status.dart';
import '../res/components/reusable_row.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewViewModel.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width*1;
    final userPrefrences = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Home', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          InkWell(
            onTap: (){
              userPrefrences.remove().then((value){
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
              child: const Center(child: Text("LogOut",  style: TextStyle(color: Colors.white),))
          ),
          SizedBox(
            width: width*.02,
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, child){
            switch(value.list.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Center(child: Text(value.list.message.toString()));
              case Status.COMPLETED:
                return ListView.builder(
                    itemCount: value.list.data!.data.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Column(
                                      children: [
                                        ReuseableRow(title: "ID",value: value.list.data!.data[index].id.toString()),
                                        ReuseableRow(title: "First Name",value: value.list.data!.data[index].firstName),
                                        ReuseableRow(title: "Last Name",value: value.list.data!.data[index].lastName),
                                        ReuseableRow(title: "Email",value: value.list.data!.data[index].email),
                                      ],
                                    ),
                                  )
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                    height: 75,
                                    width: 75,
                                    child: Image.network(value.list.data!.data[index].avatar,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,
                                    ),
                                ),
                              ),
                            ],
                          ),
                        )
                      );
                    }
                );
              default:
                return const Center(child: Text("Unexpected status"));
            }
          }
        )
      )
    );
  }
}
