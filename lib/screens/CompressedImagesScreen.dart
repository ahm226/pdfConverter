import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:imagetopdfconverter/classes/customDialog.dart';
import 'package:share_plus/share_plus.dart';

import '../MainScreen.dart';
import '../classes/Helper.dart';

class CompressedImages extends StatefulWidget {
  const CompressedImages({Key? key}) : super(key: key);

  @override
  State<CompressedImages> createState() => _CompressedImagesState();
}

class _CompressedImagesState extends State<CompressedImages> {
  String folername = "compressedImages";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Compressed Images".tr,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "DM Sans",
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            compressedFiles.clear();
            Get.offAll(const MainScreen());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              StatefulBuilder(
                builder: ((context, setState) {
                  return compressedFiles.isEmpty
                      ? Center(
                          child: Text(
                            "No Compressed Image Available".tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "DM Sans",
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: compressedFiles.length,
                          itemBuilder: (context, int index) {
                            final kb = compressedFiles[index]!
                                    .readAsBytesSync()
                                    .lengthInBytes /
                                1024;
                            final mb = kb / 1024;
                            final size = (mb >= 1)
                                ? '${mb.toStringAsFixed(2)} MB'
                                : '${kb.toStringAsFixed(2)} KB';
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 5.0),
                              child: InkWell(
                                onTap: () {
                                  //    viewConvertedFiles(compressedFiles[index].path);
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 7,
                                  shadowColor: Colors.white70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      height: 70,
                                      color: Colors.white,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 59,
                                            height: 70,
                                            child: Image.file(
                                              File(compressedFiles[index]!
                                                  .path
                                                  .toString()),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  compressedFiles[index]
                                                      .path
                                                      .toString()
                                                      .split("/")
                                                      .last,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "DM Sans",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  size,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              Share.shareFiles([
                                                '${compressedFiles[index].path}'
                                              ],
                                                  text: compressedFiles[index]
                                                      .path
                                                      .toString()
                                                      .split("/")
                                                      .last);
                                            },
                                            icon: const Icon(
                                              Icons.share,
                                            ),
                                            color: Color(0xFF0A9C19),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await saveCompressedImage(
                                                  compressedFiles[index].path);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CustomDialog(
                                                        context,
                                                        'Images saved Successfully in "compressedImages" in downloads'
                                                            .tr);
                                                  });
                                              compressedFiles.clear();
                                            },
                                            icon: const Icon(
                                              Icons.download,
                                            ),
                                            color: Color(0xFF1C2978),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveCompressedImage(String userfilename) async {
    String filePath;
    final subdir = Directory('/storage/emulated/0/Download/$folername');
    filePath = subdir.path;
    filePath = filePath + "/" + userfilename.split('/').last;
    await File(userfilename).copy(filePath);
  }
}
