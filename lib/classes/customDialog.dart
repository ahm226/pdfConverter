import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget CustomDialog(BuildContext context, String title) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    title: Text(
      title,
      style: TextStyle(
        fontFamily: "DM Sans",
        fontWeight: FontWeight.w500,
        fontSize: 17,
        color: Colors.black,
      ),
    ),
    actions: [
      Align(
        alignment: Alignment.bottomCenter,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width * 0.5,
          color: Color(0xFF1C2978),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "OK".tr,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "DM Sans",
            ),
          ),
        ),
      )
    ],
  );
}
