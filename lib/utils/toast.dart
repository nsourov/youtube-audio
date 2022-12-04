import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_audio/utils/types.dart';

void showToast({String message = '', ToastType type = ToastType.success}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: type == ToastType.error ? Colors.red : Colors.green,
    textColor: Colors.white,
    fontSize: 20.0,
  );
}
