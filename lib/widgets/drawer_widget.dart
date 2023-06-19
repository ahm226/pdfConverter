import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

Widget drawerWidget() {
  return Drawer(
    backgroundColor: Colors.white,
    elevation: 100,
    width: 250,
    surfaceTintColor: Colors.red,
    child: ListView(
      children: <Widget>[
        Column(children: <Widget>[
          DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Container(
                color: Colors.black,
                //Color(0xFFD50000),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 8.0, 8.0, 18.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Image.asset("assets/appIcon.png"),
                            height: 70,
                            width: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Container(
                              child: Text(
                                "Image to pdf",
                                style: TextStyle(color: Colors.white),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              width: 150,
                            ),
                          ),
                        ],
                      ),
                    ),
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
