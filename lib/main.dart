import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:imagetopdfconverter/MainScreen.dart';
import 'package:imagetopdfconverter/classes/localStrings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'classes/Helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  final selectedLocale = await getSelectedLocale();

  runApp(MyApp(selectedLocale: selectedLocale));
}

Future<Locale?> getSelectedLocale() async {
  final preferences = await SharedPreferences.getInstance();
  final localeString = preferences.getString('selected_locale');
  if (localeString != null) {
    final parts = localeString.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    }
  }
  return null;
}

class MyApp extends StatefulWidget {
  final Locale? selectedLocale;

  const MyApp({Key? key, this.selectedLocale}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getData() async {
    await checkPermission(context);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      translations: LocalString(),
      locale: widget.selectedLocale ?? Locale('english', 'ln'),
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
