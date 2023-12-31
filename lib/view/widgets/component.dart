import 'package:flutter/material.dart';

// Future<bool?> showToast({required String message, Color color = Colors.green}) {
//   return Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_LONG,
//
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor: color,
//     textColor: Colors.white,
//     fontSize: 16.0,
//   );
// }

void navigatorAndRemove(context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (Route<dynamic> route) => false,
  );
}

void navigator(context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}