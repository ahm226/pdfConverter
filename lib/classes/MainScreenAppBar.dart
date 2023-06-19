import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreenAppBarClass {
  static getAppBar() {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              size: 30,
              color: Color(0xFFD50000),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: const Text(
        "Image to PDF",
        style: TextStyle(
          color: Color(0xFF000000),
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
    );
  }
}
