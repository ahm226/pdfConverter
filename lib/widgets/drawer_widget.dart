import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Widget drawerWidget() {
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
                  // Padding(
                  //   padding: EdgeInsets.only(top: 12),
                  //   child: Text(
                  //     "Welcome !",
                  //     style: GoogleFonts.dmSans(
                  //         color: Colors.black,
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          ListTile(
              leading: Icon(
                Icons.privacy_tip_outlined,
                color: Colors.black,
              ),
              title: Text(
                "Privacy Policy",
                // style: GoogleFonts.dmSans(color: Colors.black),
              ),
              onTap: () {
                _launchUrl(Uri.parse(
                    "https://sites.google.com/view/zeroskillteam/home"));
              }),
          ListTile(
              leading: Icon(
                Icons.people_outline,
                color: Colors.black,
              ),
              title: Text(
                "About Us",
                // style: GoogleFonts.dmSans(color: Colors.black),
              ),
              onTap: () {
                // setState((){
                //   text = "save pressed";
                // });
              }),
          ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.black,
              ),
              title: Text(
                "Share",
                // style: GoogleFonts.dmSans(color: Colors.black),
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
