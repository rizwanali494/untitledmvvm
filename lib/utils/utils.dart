import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  static void fieldFocusChange(BuildContext context, FocusNode currect, FocusNode next){
    currect.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static toastMessag(String message){
    Fluttertoast.showToast(msg: message);
  }

  static void flushBarErrorMessages(String message, BuildContext context){

    showFlushbar(context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(15),
          reverseAnimationCurve: Curves.easeInOut,
          flushbarPosition: FlushbarPosition.TOP,
          positionOffset: 20,
          borderRadius: BorderRadius.circular(20),
          icon: const Icon(Icons.error, color: Colors.white, size: 28,),
          message: message,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        )..show(context)
    );
  }

  static snackBar(String message, BuildContext context){

    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(message)));
  }
}