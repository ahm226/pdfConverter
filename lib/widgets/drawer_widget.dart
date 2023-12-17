import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagetopdfconverter/classes/languageDialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Widget drawerWidget(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    elevation: 10,
    width: 250,
    child: ListView(
      children: <Widget>[
        Column(children: <Widget>[
          DrawerHeader(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: Center(
                      child: Image.asset("assets/appIcon.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.black,
              ),
              title: Text(
                "Change Language".tr,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  color: Colors.black,
                ),
              ),
              onTap: () {
                LanguageChangeDialog.buildDialog(context);
              }),
          ListTile(
              leading: Icon(
                Icons.privacy_tip_outlined,
                color: Colors.black,
              ),
              title: Text(
                "Privacy Policy".tr,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  color: Colors.black,
                ),
              ),
              onTap: () {
                _launchUrl(Uri.parse(
                    "https://sites.google.com/view/zeroskillteam/home"));
              }),
          // ListTile(
          //     leading: Icon(
          //       Icons.people_outline,
          //       color: Colors.black,
          //     ),
          //     title: Text(
          //       "About Us",
          //        style: GoogleFonts.dmSans(color: Colors.black),
          //     ),
          //     onTap: () {
          //       // setState((){
          //       //   text = "save pressed";
          //       // });
          //     }),
          ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.black,
              ),
              title: Text(
                "Share".tr,
                style: TextStyle(
                  fontFamily: "DM Sans",
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Share.share(
                    "http://play.google.com/store/apps/details?id=com.imagetopdfconverter.app");
              }),
        ]),
      ],
    ),
  );
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
