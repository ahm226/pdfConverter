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
              Icons.apps,
              size: 30,
              color: Color(0xFFFF5722),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: const Text(
        "IMAGE TO PDF",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
    );
  }
}
