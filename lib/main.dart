import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:imagetopdfconverter/MainScreen.dart';
import 'package:path_provider/path_provider.dart';

import 'classes/Helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String folername = "ImagetoPDF";
  String folername1 = "compressedImages";
  Future<String> createFolder(String name) async {
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    final subdir = Directory("/storage/emulated/0/Download/$name");
    if ((await subdir.exists())) {
      return subdir.path;
    } else {
      subdir.create();
      return subdir.path;
    }
  }

  getData() async {
    await checkPermission(context);
    if (permit.value) {
      createFolder(folername);
      createFolder(folername1);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image to pdf: Image compressor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        // textTheme: GoogleFonts.ubuntuTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
      home: const MainScreen(),
    );
  }
}
