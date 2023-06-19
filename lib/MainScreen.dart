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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 60,
          ),
          child: Column(
            children: [
              mainOptions(
                context,
                "I want to CONVERT",
                Icons.cached_outlined,
                "1",
              ),
              const SizedBox(
                height: 30,
              ),
              mainOptions(
                context,
                "My Converted Images",
                Icons.folder,
                "2",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
