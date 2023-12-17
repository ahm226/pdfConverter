import 'package:flutter/material.dart';
import 'package:imagetopdfconverter/screens/CompressingImagesScreen.dart';
import 'package:imagetopdfconverter/screens/convert_screen.dart';
import 'package:imagetopdfconverter/screens/converted_files_screen.dart';

import '../classes/Helper.dart';
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
        bottom: 23,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontFamily: "Poppins"),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 45,
                        maxWidth: 45,
                        minHeight: 37,
                        minWidth: 37,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff1C2978),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image(
                        image: assetImage1,
                      ),
                    ),
                    Text(
                      "----------------->",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 45,
                        maxWidth: 45,
                        minHeight: 37,
                        minWidth: 37,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff1C2978),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image(
                        image: assetImage2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
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
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: "Poppins",
                ),
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
        permit.value
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ConvertedFilesScreen(),
                ),
              )
            : checkPermission(context);
      } else if (cardId == "4") {
        permit.value
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CompressedDownloaded(),
                ),
              )
            : checkPermission(context);
      }
    },
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      constraints: BoxConstraints(
        minHeight: 135,
        maxHeight: 150,
        maxWidth: 150,
        minWidth: 135,
      ),
      child: Card(
        elevation: 15,
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
              style: TextStyle(
                color: Colors.black,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget mainOptionsTopForTabs(
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
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.13,
        maxHeight: MediaQuery.of(context).size.height * 0.16,
      ),
      margin: EdgeInsets.only(
        right: 45,
        left: 45,
        bottom: 45,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffFFFFFF).withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF1C2978),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image(
                        image: assetImage1,
                      ),
                    ),
                    Text(
                      "-------------------------------->",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF1C2978),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image(
                        image: assetImage2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
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
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: "Poppins",
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget mainOptionsBottomForTabs(
  BuildContext context,
  String title,
  AssetImage assetImage,
  String cardId,
) {
  return InkWell(
    onTap: () {
      if (cardId == "3") {
        permit.value
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ConvertedFilesScreen(),
                ),
              )
            : checkPermission(context);
      } else if (cardId == "4") {
        permit.value
            ? Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CompressedDownloaded(),
                ),
              )
            : checkPermission(context);
      }
    },
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      constraints: BoxConstraints(
        minHeight: 200,
        maxHeight: 200,
        maxWidth: 200,
        minWidth: 200,
      ),
      child: Card(
        elevation: 15,
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
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
              ),
            )
          ],
        ),
      ),
    ),
  );
}
