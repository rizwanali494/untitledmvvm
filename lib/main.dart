import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitledmvvm/utils/routes/routes.dart';
import 'package:untitledmvvm/utils/routes/routes_name.dart';
import 'package:untitledmvvm/view_model/auth_view_model.dart';
import 'package:untitledmvvm/view_model/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        //initialRoute: RoutesName.splash,
        initialRoute: RoutesName.login,
        onGenerateRoute: Routes.generateRoute,
      )
    );
  }
}
