import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../MainScreen.dart';

class ConvertedFilesScreen extends StatefulWidget {
  const ConvertedFilesScreen({Key? key}) : super(key: key);

  @override
  State<ConvertedFilesScreen> createState() => _ConvertedFilesScreenState();
}

class _ConvertedFilesScreenState extends State<ConvertedFilesScreen> {
  final String folername = "convertfiles";
  late String directory;
  List file = [];
  bool isLoading = false;
  bool isList = false;

  getData() {
    setState(() {
      isLoading = true;
    });
    _listofFiles();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  void _listofFiles() async {
    Directory? directory1 = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();

    directory = (directory1!).path;
    final subdir =
        await Directory('/storage/emulated/0/Download/$folername').path;
    setState(
      () {
        file = io.Directory("$subdir/").listSync();
      },
    );
  }

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
          "Converted Images",
          style: TextStyle(color: Colors.green),
          // style: GoogleFonts.dmSans(
          //   color: Color(0xFF000000),
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.offAll(const MainScreen());
          },
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 550,
                      child: StatefulBuilder(
                        builder: ((context, setState) {
                          return file.isEmpty
                              ? Center(
                                  child: Text(
                                    "No Converted PDFs Available",
                                    // style: GoogleFonts.dmSans(
                                    //   fontSize: 18,
                                    // ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: file.length,
                                  itemBuilder: (context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 5.0),
                                      child: InkWell(
                                        onTap: () {
                                          print(file[index].path);
                                          viewConvertedFiles(file[index].path);
                                        },
                                        child: Card(
                                          shape:
                                              Border.all(color: Colors.white70),
                                          elevation: 8,
                                          shadowColor: Colors.white60,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Container(
                                              height: 70,
                                              color: Colors.white,
                                              child: Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 59,
                                                    height: 70,
                                                    child: Icon(
                                                      Icons
                                                          .picture_as_pdf_rounded,
                                                      color: Color(0xFFFF0000),
                                                      size: 45,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          file[index]
                                                              .path
                                                              .toString()
                                                              .split("/")
                                                              .last,
                                                          // style: GoogleFonts
                                                          //     .dmSans(
                                                          //         fontWeight:
                                                          //             FontWeight
                                                          //                 .w500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      Share.shareFiles([
                                                        '${file[index].path}'
                                                      ],
                                                          text: file[index]
                                                              .path
                                                              .toString()
                                                              .split("/")
                                                              .last);
                                                    },
                                                    icon: const Icon(
                                                      Icons.share,
                                                      color: Color(0xFF0A9C19),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await deleteConvertedFileDailog(
                                                          context,
                                                          file[index].path,
                                                          index);
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: Color(0xFFD50000),
                                                    ),
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
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  deleteConvertedFileDailog(context, path, index) async {
    String pathFile = await path;
    File deletefile = File(pathFile);
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(
            "Do you want to delete this file?",
            // style: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
          ),
          content: Text(
            path.toString().split("/").last,
            // style: GoogleFonts.dmSans(
            //   color: Color(0xFFD50000),
            // ),
          ),
          actions: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Color.fromARGB(255, 226, 51, 51),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "NO",
                // style: GoogleFonts.dmSans(),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              textColor: Colors.white,
              color: Color(0xFF1C2978),
              onPressed: () async {
                setState(() {
                  file.removeAt(index);
                });
                await deletefile.delete();
                setState(() {});
                Navigator.of(context).pop(true);
              },
              child: Text(
                "YES",
                // style: GoogleFonts.dmSans(),
              ),
            ),
          ],
        );
      },
    );
  }
}

void viewConvertedFiles(path) {
  OpenFile.open(path);
}

// void removeConvertedfiles(path) async {
//   String pathFile = await path;
//   File deletefile = File(pathFile);
//   deletefile.delete();
//   //setState(() {});
// }
