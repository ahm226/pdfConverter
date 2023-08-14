import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:imagetopdfconverter/screens/CompressingImagesScreen.dart';
import 'package:imagetopdfconverter/screens/convert_screen.dart';
import 'package:imagetopdfconverter/screens/converted_files_screen.dart';

import '../screens/compressedImageDownloaded.dart';

Widget mainOptionsTop(
  BuildContext context,
  String title1,
  String title2,
  AssetImage assetImage1,
  AssetImage assetImage2,
  String selectedId,
) {
  return InkWell(
    onTap: () {
      if (selectedId == "1") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ConvertScreen(),
          ),
        );
      } else if (selectedId == "2") {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const CompressImagesScreen(),
          ),
        );
      }
    },
    child: Container(
      margin: EdgeInsets.only(
        right: 20,
        left: 20,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffFFFFFF).withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  title1,
                  // style: GoogleFonts.poppins(
                  //   fontSize: 15,
                  //   fontWeight: FontWeight.w500,
                  //   color: Colors.white,
                  // ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image(
                      image: assetImage1,
                    ),
                    Text(
                      "--------------->",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Image(
                      image: assetImage2,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 40,
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Text(
                title2,
                // style: GoogleFonts.poppins(
                //   fontSize: 17,
                //   fontWeight: FontWeight.w500,
                //   color: Colors.black,
                // ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget mainOptionsBottom(
  BuildContext context,
  String title,
  AssetImage assetImage,
  String cardId,
) {
  return InkWell(
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
            builder: (context) => const CompressedDownloaded(),
          ),
        );
      }
    },
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      constraints: BoxConstraints(
        minHeight: 130,
        maxHeight: 150,
        maxWidth: 150,
        minWidth: 150,
      ),
      child: Card(
        elevation: 10,
        shadowColor: Colors.white54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: assetImage,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              // style: GoogleFonts.poppins(
              //     color: Colors.black,
              //     fontSize: 14,
              //     fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    ),
  );
}
