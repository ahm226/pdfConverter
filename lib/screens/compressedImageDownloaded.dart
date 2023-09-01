import 'dart:io' as io;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class CompressedDownloaded extends StatefulWidget {
  const CompressedDownloaded({Key? key}) : super(key: key);

  @override
  State<CompressedDownloaded> createState() => _ConvertedFilesScreenState();
}

class _ConvertedFilesScreenState extends State<CompressedDownloaded> {
  final String folername = "compressedImages";
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
          "Compressed Images",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: "DM Sans",
          ),
        ),
        elevation: 0,
        leading: const BackButton(
          color: Color(0xFF000000),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 550,
                      child: StatefulBuilder(
                        builder: ((context, setState) {
                          return file.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No Compressed Images Available",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: file.length,
                                  itemBuilder: (context, int index) {
                                    final kb = file[index]!
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
                                                  SizedBox(
                                                    width: 59,
                                                    height: 70,
                                                    child: Image.file(
                                                      File(file[index]!
                                                          .path
                                                          .toString()),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
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
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          size,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
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
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            "Do you want to delete this Image?",
          ),
          content: Text(
            path.toString().split("/").last,
            style: const TextStyle(
              color: Color(0xFFD50000),
            ),
          ),
          actions: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color(0xff000000),
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("NO"),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              textColor: Colors.white,
              color: const Color.fromARGB(255, 226, 51, 51),
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
