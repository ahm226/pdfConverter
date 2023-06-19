import 'package:flutter/material.dart';
import 'package:imagetopdfconverter/screens/convert_screen.dart';
import 'package:imagetopdfconverter/screens/converted_files_screen.dart';

Widget mainOptions(
  BuildContext context,
  String title,
  IconData icon,
  String cardId,
) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(110),
        topLeft: Radius.circular(110),
      ),
    ),
    margin: const EdgeInsets.only(
      left: 30,
      right: 30,
    ),
    constraints: BoxConstraints(
      minWidth: MediaQuery.of(context).size.width * 1,
      minHeight: MediaQuery.of(context).size.height * 0.20,
      maxHeight: MediaQuery.of(context).size.height * 0.60,
    ),

    // margin: const EdgeInsets.only(left: 20, right: 20),
    child: InkWell(
      onTap: () {
        if (cardId == "1") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ConvertScreen(),
            ),
          );
        } else if (cardId == "2") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ConvertedFilesScreen(),
            ),
          );
        }
      },
      splashColor: Color(0xFFD50000),
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(110),
        topLeft: Radius.circular(110),
        bottomLeft: Radius.circular(110),
        topRight: Radius.circular(110),
      ),
      child: Card(
        shadowColor: Color(0xFFD50000),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(110),
            topLeft: Radius.circular(110),
            bottomLeft: Radius.circular(110),
            topRight: Radius.circular(110),
          ),
        ),
        elevation: 20,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFD50000),
                Color(0xFFD50000),
                // Color(0xFFE65100)
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(110),
              topLeft: Radius.circular(110),
              bottomLeft: Radius.circular(110),
              topRight: Radius.circular(110),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Column(
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 60,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
