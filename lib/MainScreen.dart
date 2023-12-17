import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/get_utils.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:imagetopdfconverter/classes/MainScreenAppBar.dart';
import 'package:imagetopdfconverter/classes/languageDialog.dart';
import 'package:imagetopdfconverter/widgets/drawer_widget.dart';
import 'package:imagetopdfconverter/widgets/mainOptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? selectedOption;
  String? selectedCard;

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    var useMobileLayout = shortestSide < 600;

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: drawerWidget(context),
      appBar: MainScreenAppBarClass.getAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.only(top: 100),
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: useMobileLayout
                ? Column(
                    children: [
                      mainOptionsTop(
                        context,
                        "Convert Image to PDF".tr,
                        "Use Now".tr,
                        const AssetImage("assets/gallery.png"),
                        const AssetImage("assets/pdficon.png"),
                        "1",
                      ),
                      mainOptionsTop(
                        context,
                        "Compress Images".tr,
                        "Use Now".tr,
                        const AssetImage("assets/gallery.png"),
                        const AssetImage("assets/compressicon.png"),
                        "2",
                      ),
                    ],
                  )
                : Column(
                    children: [
                      mainOptionsTopForTabs(
                        context,
                        "Convert Image to PDF".tr,
                        "Use Now".tr,
                        const AssetImage("assets/gallery.png"),
                        const AssetImage("assets/pdficon.png"),
                        "1",
                      ),
                      mainOptionsTopForTabs(
                        context,
                        "Compress Images".tr,
                        "Use Now".tr,
                        const AssetImage("assets/gallery.png"),
                        const AssetImage("assets/compressicon.png"),
                        "2",
                      ),
                    ],
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          useMobileLayout
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainOptionsBottom(
                      context,
                      "PDF Images".tr,
                      const AssetImage("assets/pdfcompletedicon.png"),
                      "3",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    mainOptionsBottom(
                      context,
                      "Compressed Images".tr,
                      const AssetImage("assets/compressImagescompleteIcon.png"),
                      "4",
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    mainOptionsBottomForTabs(
                      context,
                      "PDF Images".tr,
                      const AssetImage("assets/pdfcompletedicon.png"),
                      "3",
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    mainOptionsBottomForTabs(
                      context,
                      "Compressed Images".tr,
                      const AssetImage("assets/compressImagescompleteIcon.png"),
                      "4",
                    ),
                  ],
                ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.language_rounded,
              size: 22,
            ),
            label: Text(
              "Change Language".tr,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "DM Sans",
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.black,
            ),
            onPressed: () {
              LanguageChangeDialog.buildDialog(context);
            },
          ),
        ]),
      ),
    );
  }
}
