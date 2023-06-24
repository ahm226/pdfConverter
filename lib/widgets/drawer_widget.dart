import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Widget drawerWidget() {
  return Drawer(
    backgroundColor: Colors.white,
    elevation: 20,
    width: 250,
    child: ListView(
      children: <Widget>[
        Column(children: <Widget>[
          DrawerHeader(
              child: Container(
            color: Colors.white,
            //Color(0xFFD50000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Card(
                    elevation: 20,
                    child: Center(
                      child: Image.asset("assets/appIcon.png"),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 12),
                  child: Text(
                    "Image to PDF",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          )),
          ListTile(
              leading: Icon(Icons.privacy_tip_outlined),
              title: Text("Privacy Policy"),
              onTap: () {
                _launchUrl(Uri.parse(
                    "https://sites.google.com/view/zeroskillteam/home"));
              }),
          ListTile(
              leading: Icon(Icons.people_outline),
              title: Text("About Us"),
              onTap: () {
                // setState((){
                //   text = "save pressed";
                // });
              }),
          ListTile(
              leading: Icon(Icons.share),
              title: Text("Share"),
              onTap: () {
                Share.share(
                    "http://play.google.com/store/apps/details?id=com.imagetopdfconverter.app");
              }),
        ]),
      ],
    ),
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.only(
    //     bottomRight: Radius.circular(400),
    //   ),
    // ),
  );
}

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
