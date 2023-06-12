import 'package:flutter/material.dart';

Widget drawerWidget() {
  return Drawer(
    backgroundColor: Colors.white,
    elevation: 100,
    surfaceTintColor: Colors.red,
    child: ListView(
      children: <Widget>[
        Column(children: <Widget>[
          DrawerHeader(
              child: Container(
            color: Colors.red,
          )),
          ListTile(
              leading: new Icon(Icons.info),
              title: Text("info pressed"),
              onTap: () {
                // setState((){
                //   text = "info pressed";
                // });
              }),
          new ListTile(
              leading: new Icon(Icons.save),
              title: Text("save pressed"),
              onTap: () {
                // setState((){
                //   text = "save pressed";
                // });
              }),
          new ListTile(
              leading: new Icon(Icons.settings),
              title: Text("settings pressed"),
              onTap: () {
                // setState((){
                //   text = "settings pressed";
                // });
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
