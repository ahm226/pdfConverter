import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagetopdfconverter/classes/ConvertScreenAppBar.dart';
import 'package:imagetopdfconverter/screens/Converting.dart';
import 'package:open_file_plus/open_file_plus.dart';

import '../classes/Helper.dart';
import '../widgets/message_widget.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({Key? key}) : super(key: key);

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  List<dynamic> files = [];
  List<dynamic>? selectedImages = [];
  bool isLoading = false;
  bool status = false;
  final picker = ImagePicker();
  late final imagesPathCropped;
  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) +
        ' ' +
        suffixes[i];
  }

  void viewFile(dynamic file) {
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConvertScreenAppBarClass.getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.2,
                    minHeight: MediaQuery.of(context).size.height * 0.075,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 25,
                    ),
                    label: const Text(
                      "Camera",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFF0336ff),
                      shadowColor: Color(0xFF0336ff),
                      elevation: 10,
                    ),
                    onPressed: () async {
                      getImagesFromStorage("camera");
                    },
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.2,
                    minHeight: MediaQuery.of(context).size.height * 0.075,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.sd_storage_sharp,
                      size: 25,
                    ),
                    label: const Text(
                      "Storage",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color(0xFF0336ff),
                      shadowColor: Color(0xFF0336ff),
                      elevation: 10,
                    ),
                    onPressed: () {
                      getImagesFromStorage("gallery");
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(limit.value.toString() + "/100"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child:
                    //ImagesList(files: files),
                    files.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              final file = files[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 5.0),
                                child: InkWell(
                                  onTap: () => viewFile(file),
                                  child: Card(
                                    shadowColor: Colors.white60,
                                    elevation: 15,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    file.path.split("/").last,
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),

                                                  // Text(formatBytes(filelength, 1)),
                                                  Text(file.path
                                                      .toString()
                                                      .split(".")
                                                      .last),
                                                  //Text('${file.extension}'),
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  limit.value--;
                                                  files.remove(file);
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.cancel,
                                              ),
                                              color: const Color(0xFFD50000),
                                            ),
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
                            child: Text(
                              "No image selected",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.2,
                minHeight: MediaQuery.of(context).size.height * 0.075,
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (files.isEmpty) {
                    showMessage(
                        "No image selected, kindly choose images", context);
                  } else {
                    fileNameDailog(context, files, status);
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color(0xFFD50000),
                  shadowColor: const Color(0xFFD50000),
                  elevation: 10,
                ),
                child: const Text(
                  "Convert",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  getImagesFromStorage(inputSource) async {
    if (inputSource == 'gallery') {
      selectedImages = await picker.pickMultiImage();
      if (files.isNotEmpty) {
        limit.value < 5
            ? {
                files.addAll(selectedImages as Iterable),
                setState(() {
                  limit.value = limit.value +
                      int.parse(selectedImages!.length.toString());
                })
              }
            : showMessage("limit exceeded", context);
      } else {
        limit.value < 5
            ? {
                files.addAll(selectedImages as Iterable),
                setState(() {
                  limit.value = limit.value +
                      int.parse(selectedImages!.length.toString());
                })
              }
            : showMessage("limit exceeded", context);
      }
    }
    if (inputSource != 'gallery') {
      final result =
          await picker.pickImage(source: ImageSource.camera, maxWidth: 1920);
      if (result != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: result.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Crop Image',
                toolbarColor: Color(0xFF0336ff),
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Crop Image',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        );
        if (files.isNotEmpty) {
          // files.addAll(duplicates.map((e) => File(e!)).toList());

          limit.value < 5
              ? {
                  files.add(croppedFile!),
                  setState(() {
                    limit.value++;
                  })
                }
              : showMessage("limit exceeded", context);
        } else {
          // files.add(result.path.map((e) => File(e!)).toList());
          limit.value < 5
              ? {
                  files.add(croppedFile!),
                  setState(() {
                    limit.value++;
                  })
                }
              : showMessage("limit exceeded", context);
        }
      }
    }

    setState(() {});
  }
}
