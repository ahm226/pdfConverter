import 'package:flutter/material.dart';
import 'package:imagetopdfconverter/screens/CompressedImagesScreen.dart';
import 'package:imagetopdfconverter/screens/CompressingImagesScreen.dart';
import 'package:imagetopdfconverter/screens/convert_screen.dart';
import 'package:imagetopdfconverter/screens/converted_files_screen.dart';

Widget mainOptionsTop(
  BuildContext context,
  String title1,
  String title2,
  IconData icon1,
  IconData icon2,
  IconData icon3,
  String cardId,
) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 10,
    shadowColor: Colors.white60,
    color: Colors.white,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      splashColor: Colors.transparent,
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
              builder: (context) => const CompressImagesScreen(),
            ),
          );
        }
      },
      child: Container(
        height: 110,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Icon(
                      icon1,
                      size: 50,
                      color: Color(0xFF0336ff),
                    ),
                  ),
                  Text(
                    title1,
                    style: TextStyle(color: Color(0xFF0336ff)),
                  )
                ],
              ),
              Icon(
                icon2,
                size: 30,
                color: Colors.black,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Icon(
                      icon3,
                      size: 50,
                      color: Color(0xFFD50000),
                    ),
                  ),
                  Text(
                    title2,
                    style: TextStyle(color: Color(0xFFD50000)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget mainOptionsBottom(
  BuildContext context,
  String title,
  IconData icon,
  String cardId,
) {
  return Column(
    children: [
      InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          if (cardId == "3") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ConvertedFilesScreen(),
              ),
            );
          } else if (cardId == "4") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const CompressedImages(),
              ),
            );
          }
        },
        child: Icon(
          icon,
          color: Colors.amber,
          size: 60,
        ),
      ),
      Text(title)
    ],
  );
}
