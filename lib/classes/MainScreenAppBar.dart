import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:imagetopdfconverter/MainScreen.dart';

class MainScreenAppBarClass {
  static getAppBar() {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xff428AE0),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () async {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),
      title: Text(
        "Welcome".tr,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: "DM Sans",
        ),
      ),
      elevation: 0,
    );
  }
}
