import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitledmvvm/utils/routes/routes_name.dart';
import 'package:untitledmvvm/view_model/auth_view_model.dart';

import '../res/colors.dart';
import '../res/components/round_button.dart';
import '../utils/utils.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final ValueNotifier<bool> _obscurePassword = ValueNotifier(true);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obscurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Login",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    hintText: "Email",
                    fillColor: AppColors.textFieldColor,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: "Email",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: const Icon(Icons.email),
                  ),
                  onFieldSubmitted: (valu) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, passwordFocusNode);
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                ValueListenableBuilder(
                    valueListenable: _obscurePassword,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _passwordController,
                        focusNode: passwordFocusNode,
                        obscureText: _obscurePassword.value,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: const Icon(Icons.password),
                            fillColor: AppColors.textFieldColor,
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            suffixIcon: InkWell(
                                onTap: () {
                                  _obscurePassword.value =
                                      !_obscurePassword.value;
                                },
                                child: Icon(_obscurePassword.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility))),
                      );
                    }),
                SizedBox(
                  height: height * 0.085,
                ),
                RoundButton(
                    title: "Login",
                    loading: authViewModel.loading,
                    onPress: () {
                      if (_emailController.text.isEmpty) {
                        Utils.flushBarErrorMessages(
                            "Please enter Email", context);
                      } else if (_passwordController.text.isEmpty) {
                        Utils.flushBarErrorMessages(
                            "Please enter Password", context);
                      } else if (_passwordController.text.length < 6) {
                        Utils.flushBarErrorMessages(
                            "Password must be greater then 6", context);
                      } else {
                        Map data = {
                          'email': _emailController.text.toString(),
                          'password': _passwordController.text.toString()
                        };
                        authViewModel.loginApi(data, context);
                        if (kDebugMode) {
                          print("API hit");
                        }
                      }
                    }),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?", style: TextStyle(color: Colors.black54 , fontSize: 14),),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.signUp);
                      },
                      child: RichText(
                          text: const TextSpan(
                              text: "SignUp",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
