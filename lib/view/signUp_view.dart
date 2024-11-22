import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitledmvvm/utils/routes/routes_name.dart';

import '../res/colors.dart';
import '../res/components/round_button.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  ValueNotifier<bool> _obscurePassword = ValueNotifier(true);
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confPasswordController = TextEditingController();

  FocusNode fNameFocusNode = FocusNode();
  FocusNode lNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _obscurePassword.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _lNameController.dispose();
    _fNameController.dispose();
    lNameFocusNode.dispose();
    fNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confPasswordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "SignIn",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _fNameController,
                keyboardType: TextInputType.text,
                focusNode: fNameFocusNode,
                decoration: InputDecoration(
                  hintText: "First Name",
                  fillColor: AppColors.textFieldColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "First Name",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: const Icon(Icons.person),
                ),
                onFieldSubmitted: (valu) {
                  Utils.fieldFocusChange(
                      context, emailFocusNode, lNameFocusNode);
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
              TextFormField(
                controller: _lNameController,
                keyboardType: TextInputType.text,
                focusNode: lNameFocusNode,
                decoration: InputDecoration(
                  hintText: "Last Name",
                  fillColor: AppColors.textFieldColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Last Name",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  prefixIcon: const Icon(Icons.person),
                ),
                onFieldSubmitted: (valu) {
                  Utils.fieldFocusChange(
                      context, emailFocusNode, emailFocusNode);
                },
              ),
              SizedBox(
                height: height * 0.02,
              ),
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
                      onFieldSubmitted: (valu) {
                        Utils.fieldFocusChange(
                            context, emailFocusNode, confPasswordFocusNode);
                      },
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
                height: height * 0.02,
              ),
              ValueListenableBuilder(
                  valueListenable: _obscurePassword,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: _confPasswordController,
                      focusNode: confPasswordFocusNode,
                      obscureText: _obscurePassword.value,
                      obscuringCharacter: "*",
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          labelText: "Confirm Password",
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
                  title: "SignUp",
                  loading: authViewModel.sgnUpLoading,
                  onPress: () {
                    if(_fNameController.text.isEmpty){
                      Utils.flushBarErrorMessages("Please Enter Your First Name", context);
                    }else if(_lNameController.text.isEmpty){
                      Utils.flushBarErrorMessages("Please Enter Your Last Name", context);
                    }else if(_emailController.text.isEmpty){
                      Utils.flushBarErrorMessages("Please Enter Email", context);
                    }else if(_passwordController.text.isEmpty){
                      Utils.flushBarErrorMessages("Please Enter Password", context);
                    }else if(_passwordController.text.length < 6 ){
                      Utils.flushBarErrorMessages("Password must be greater then 6", context);
                    }else if(_confPasswordController.text.isEmpty){
                      Utils.flushBarErrorMessages("Please Confirm Your Password", context);
                    }else if(_passwordController.text != _confPasswordController.text){
                      Utils.flushBarErrorMessages("Password is not matched", context);
                    }else{
                      Map data = {
                        'email' : _emailController.text,
                        'password' : _passwordController.text
                      };
                      authViewModel.signUpApi(data, context);
                      if (kDebugMode) {
                        print("Signup API Hit");
                      }
                    }
                  }
              ),
              SizedBox(
                height: height*0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Have an account?", style: TextStyle(color: Colors.black54 , fontSize: 14),),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, RoutesName.login);
                    },
                    child: RichText(
                        text: const TextSpan(
                            text: "Login",
                            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15)
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
