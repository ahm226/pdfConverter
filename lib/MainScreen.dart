import 'package:flutter/material.dart';
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
    return Scaffold(
      drawer: drawerWidget(),
      appBar: MainScreenAppBarClass.getAppBar(),
      body: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
                right: 50,
                left: 50,
              ),
              child: Column(
                children: [
                  mainOptionsTop(
                    context,
                    "Image",
                    "PDF",
                    Icons.image,
                    Icons.keyboard_arrow_right_rounded,
                    Icons.picture_as_pdf,
                    "1",
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  mainOptionsTop(
                    context,
                    "Image",
                    "Compress",
                    Icons.image,
                    Icons.keyboard_arrow_right_rounded,
                    Icons.compress_rounded,
                    "2",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      mainOptionsBottom(
                        context,
                        "PDF Images",
                        Icons.folder,
                        "3",
                      ),
                      mainOptionsBottom(
                        context,
                        "Compress Images",
                        Icons.folder,
                        "4",
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
