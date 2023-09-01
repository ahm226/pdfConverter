import 'package:flutter/material.dart';

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
      MaterialButton(
        color: Color(0xFF1C2978),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "OK",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "DM Sans",
          ),
        ),
      )
    ],
  );
}
