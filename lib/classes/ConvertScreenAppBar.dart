import 'package:flutter/material.dart';

class ConvertScreenAppBarClass {
  static getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        "Choose Images",
        style: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      leading: const BackButton(
        color: Color(0xFF000000),
      ),
    );
  }
}
