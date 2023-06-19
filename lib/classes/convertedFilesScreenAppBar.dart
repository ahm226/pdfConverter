import 'package:flutter/material.dart';

class ConvertedScreenAppBarClass {
  static getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        "Converted Images",
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
