import 'package:flutter/material.dart';
import 'package:untitledmvvm/utils/routes/routes_name.dart';
import 'package:untitledmvvm/view/signUp_view.dart';
import 'package:untitledmvvm/view/splash_view.dart';
import '../../view/home_screen.dart';
import '../../view/login_view.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){
    // final argum = settings.arguments;
    switch (settings.name){
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext) => const HomeScreen());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext) => SignUpView());
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext) => const SplashView());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text("NO ROUTE DEFINE"),
            ),
          );
        }
      );
    }
  }
}