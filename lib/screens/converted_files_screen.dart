import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:imagetopdfconverter/classes/convertedFilesScreenAppBar.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

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
  bool isList = true;

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
      appBar: ConvertedScreenAppBarClass.getAppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (isList == true) {
                                  isList = false;
                                } else {
                                  isList = true;
                                }
                              });
                            },
                            child: Icon(isList
                                ? Icons.list_alt
                                : Icons.grid_on_outlined),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 550,
                      child: StatefulBuilder(
                        builder: ((context, setState) {
                          return isList
                              ? GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: file.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const SizedBox(
                                            width: 59,
                                            height: 70,
                                            child: Icon(
                                              Icons.picture_as_pdf_sharp,
                                              color: Colors.redAccent,
                                              size: 60,
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(file[index]
                                                      .path
                                                      .toString()
                                                      .split("/")
                                                      .last),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
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
                                                        ),
                                                        color: Colors.grey,
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
                                                        ),
                                                        color: Colors.grey,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: file.length,
                                  itemBuilder: (context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 5.0),
                                      child: InkWell(
                                        onTap: () => viewConvertedFiles(
                                            file[index].path),
                                        child: Card(
                                          shadowColor: Colors.white54,
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
                                                          .picture_as_pdf_sharp,
                                                      color: Colors.redAccent,
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
                                                        Text(file[index]
                                                            .path
                                                            .toString()
                                                            .split("/")
                                                            .last),
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
                                                    ),
                                                    color: Colors.grey,
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
                                                    ),
                                                    color: Colors.grey,
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text(
            "Do you really want to delete this file?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text(
            path.toString().split("/").last,
            style: const TextStyle(color: Colors.redAccent),
          ),
          actions: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color(0xff263238),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("NO"),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textColor: Colors.white,
              color: const Color(0xff0336ff),
              onPressed: () async {
                setState(() {
                  file.removeAt(index);
                });
                await deletefile.delete();
                setState(() {});
                Navigator.of(context).pop(true);
              },
              child: const Text("YES"),
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
