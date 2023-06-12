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
      borderRadius: BorderRadius.all(
        Radius.circular(90),
      ),
    ),
    margin: const EdgeInsets.all(
      20,
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
      splashColor: Colors.black,
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(90),
        topLeft: Radius.circular(90),
      ),
      child: Card(
        shadowColor: Color(0xFFFF5722),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(90),
          ),
        ),
        elevation: 50,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF0000),
                Color(0xFFFF0000),
                // Colors.orange,
                // Color(0xFFE65100)
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40),
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
                      fontSize: 22,
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
