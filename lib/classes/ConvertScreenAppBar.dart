import 'package:flutter/material.dart';

class ConvertScreenAppBarClass {
  static getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        "CONVERT",
        style: TextStyle(
          color: Color(0xFFFF0000),
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      leading: const BackButton(
        color: Color(0xFFFF0000),
      ),
    );
  }
}
