import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagetopdfconverter/classes/ConvertScreenAppBar.dart';
import 'package:imagetopdfconverter/screens/Converting.dart';
import 'package:imagetopdfconverter/widgets/message_widget_error.dart';
import 'package:imagetopdfconverter/widgets/message_widget_infromation.dart';
import 'package:open_file_plus/open_file_plus.dart';

import '../classes/Helper.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({Key? key}) : super(key: key);

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
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
                      size: 22,
                    ),
                    label: const Text(
                      "Camera",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color.fromARGB(255, 49, 89, 245),
                      shadowColor: Colors.white38,
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
                      size: 22,
                    ),
                    label: const Text(
                      "Storage",
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Color.fromARGB(255, 49, 89, 245),
                      shadowColor: Colors.white38,
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
                  Text(pdfImagelimit.value.toString() + "/100"),
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
                                    elevation: 10,
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
                                                  pdfImagelimit.value--;
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
                    showMessageForError(
                      "No image selected, kindly choose images",
                      context,
                    );
                  } else {
                    fileNameDailog(context, files, status);
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: const Color.fromARGB(255, 226, 51, 51),
                  shadowColor: const Color(0xFFD50000),
                  elevation: 10,
                ),
                child: const Text(
                  "Convert",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
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
        pdfImagelimit.value < 100
            ? {
                files.addAll(selectedImages as Iterable),
                setState(() {
                  pdfImagelimit.value = pdfImagelimit.value +
                      int.parse(selectedImages!.length.toString());
                })
              }
            : showMessageForInformation("limit exceeded", context);
      } else {
        pdfImagelimit.value < 100
            ? {
                files.addAll(selectedImages as Iterable),
                setState(() {
                  pdfImagelimit.value = pdfImagelimit.value +
                      int.parse(selectedImages!.length.toString());
                })
              }
            : showMessageForInformation("limit exceeded", context);
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

          pdfImagelimit.value < 100
              ? {
                  files.add(croppedFile!),
                  setState(() {
                    pdfImagelimit.value++;
                  })
                }
              : showMessageForInformation("limit exceeded", context);
        } else {
          // files.add(result.path.map((e) => File(e!)).toList());
          pdfImagelimit.value < 100
              ? {
                  files.add(croppedFile!),
                  setState(() {
                    pdfImagelimit.value++;
                  })
                }
              : showMessageForInformation("limit exceeded", context);
        }
      }
    }

    setState(() {});
  }
}
