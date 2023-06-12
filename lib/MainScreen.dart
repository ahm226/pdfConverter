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
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
            child: Column(
          children: [
            mainOptions(
              context,
              "I WANT TO CONVERT",
              Icons.cached_outlined,
              "1",
            ),
            const SizedBox(
              height: 30,
            ),
            mainOptions(
              context,
              "MY CONVERTED FILES",
              Icons.folder,
              "2",
            ),
          ],
        )),
      ),
    );
  }
}
