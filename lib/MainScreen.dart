import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:imagetopdfconverter/classes/MainScreenAppBar.dart';
import 'package:imagetopdfconverter/widgets/drawer_widget.dart';
import 'package:imagetopdfconverter/widgets/mainOptions.dart';

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
      drawer: drawerWidget(),
      appBar: MainScreenAppBarClass.getAppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 110),
              child: useMobileLayout
                  ? Column(
                      children: [
                        mainOptionsTop(
                          context,
                          "Convert Image to PDF",
                          "Use Now",
                          const AssetImage("assets/gallery.png"),
                          const AssetImage("assets/pdficon.png"),
                          "1",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        mainOptionsTop(
                          context,
                          "Compress Images",
                          "Use Now",
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
                          "Convert Image to PDF",
                          "Use Now",
                          const AssetImage("assets/gallery.png"),
                          const AssetImage("assets/pdficon.png"),
                          "1",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        mainOptionsTopForTabs(
                          context,
                          "Compress Images",
                          "Use Now",
                          const AssetImage("assets/gallery.png"),
                          const AssetImage("assets/compressicon.png"),
                          "2",
                        ),
                      ],
                    ),
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
                      "PDF Images",
                      const AssetImage("assets/pdfcompletedicon.png"),
                      "3",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    mainOptionsBottom(
                      context,
                      "Compressed Images",
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
                      "PDF Images",
                      const AssetImage("assets/pdfcompletedicon.png"),
                      "3",
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    mainOptionsBottomForTabs(
                      context,
                      "Compressed Images",
                      const AssetImage("assets/compressImagescompleteIcon.png"),
                      "4",
                    ),
                  ],
                ),
        ]),
      ),
    );
  }
}
