import 'package:flutter/material.dart';

class ConvertedScreenAppBarClass {
  static getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        "CONVERTED FILES",
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
