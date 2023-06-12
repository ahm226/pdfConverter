import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

// ignore: camel_case_types, must_be_immutable
class ImagesList extends StatefulWidget {
  List<dynamic> files = [];

  ImagesList({
    Key? key,
    required this.files,
  }) : super(key: key);

  @override
  _ImagesListState createState() => _ImagesListState();
}

// ignore: camel_case_types
class _ImagesListState extends State<ImagesList> {
  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  @override
  Widget build(BuildContext context) {
    return widget.files.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: widget.files.length,
            itemBuilder: (context, index) {
              final file = widget.files[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                child: InkWell(
                  onTap: () => viewFile(file),
                  child: Card(
                    shadowColor: Colors.white60,
                    elevation: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 70,
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 59,
                              height: 70,
                              child: Image.file(
                                File(file.path.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    file.path.split("/").last,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),

                                  // Text(formatBytes(filelength, 1)),
                                  Text(file.path.toString().split(".").last),
                                  //Text('${file.extension}'),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.files.remove(file);
                                  });
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                ),
                                color: Colors.indigoAccent),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Text("No image selected"),
          );
  }

  void viewFile(dynamic file) {
    OpenFile.open(file.path);
  }
}
