import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilities{

  static void mytoast(String msg, String? toastType, Color? color) {
    Fluttertoast.showToast(

        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: toastType == ToastKind.success
            ? Colors.amber
            : toastType == ToastKind.error
            ? Colors.red
            : Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }


}



class ToastKind {
  static const String success = "success";
  static const String error = "error";
}