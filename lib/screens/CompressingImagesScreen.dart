import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagetopdfconverter/classes/customDialog.dart';
import 'package:imagetopdfconverter/screens/CompressedImagesScreen.dart';
import 'package:open_file_plus/open_file_plus.dart';

import '../classes/Helper.dart';

class CompressImagesScreen extends StatefulWidget {
  const CompressImagesScreen({Key? key}) : super(key: key);

  @override
  State<CompressImagesScreen> createState() => _CompressImagesScreenState();
}

class _CompressImagesScreenState extends State<CompressImagesScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<File?> _imageFiles = [];

  Future<void> compress() async {
    for (var imageFile in _imageFiles) {
      var result = await FlutterImageCompress.compressAndGetFile(
        imageFile!.absolute.path,
        imageFile.path + 'compressed.jpg',
        quality: 90,
      );
      compressedFiles.add(result);
    }
    setState(() {});
  }

  Future<void> pickImage() async {
    final List<XFile?> images = await _picker.pickMultiImage(imageQuality: 100);
    compressImagelimit.value < 100
        ? {
            for (int i = 0; i < images.length; i++)
              {_imageFiles.add(File(images[i]!.path))}
          }
        : showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(context, "limit exceeded".tr);
            });

    setState(() {
      compressImagelimit.value = _imageFiles.length;
    });
  }

  void viewFile(dynamic file) {
    OpenFile.open(file.path);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    compressImagelimit.value = 0;
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
          "Compress Images".tr,
          style: TextStyle(
            color: Colors.black,
            fontFamily: "DM Sans",
          ),
        ),
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.6,
                    minHeight: MediaQuery.of(context).size.height * 0.060,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.sd_storage_sharp,
                      size: 18,
                    ),
                    label: Text(
                      "Select Images".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "DM Sans",
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.black,
                      elevation: 4,
                    ),
                    onPressed: () async {
                      permit.value
                          ? await pickImage()
                          : checkPermission(context);
                    },
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.2,
                    minHeight: MediaQuery.of(context).size.height * 0.060,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_imageFiles.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(context,
                                  "No image selected, kindly choose images".tr);
                            });
                      } else {
                        await compress();
                        setState(() {});
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const CompressedImages(),
                          ),
                        );
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(
                                  context, "Images Compressed Successfully".tr);
                            });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color(0xFF1C2978),
                    ),
                    child: Text(
                      "Compress".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 8, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    compressImagelimit.value.toString() + "/100",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "DM Sans",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 7.0,
                    crossAxisSpacing: 7.0,
                  ),
                  shrinkWrap: true,
                  itemCount: _imageFiles.length,
                  itemBuilder: (BuildContext ctx, index) {
                    final kb =
                        _imageFiles[index]!.readAsBytesSync().lengthInBytes /
                            1024;
                    final mb = kb / 1024;
                    final size = (mb >= 1)
                        ? '${mb.toStringAsFixed(2)} MB'
                        : '${kb.toStringAsFixed(2)} KB';

                    return Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: InkWell(
                            onTap: () {
                              viewFile(_imageFiles[index]);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(_imageFiles[index]!.path.toString()),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                compressImagelimit.value--;
                                _imageFiles.remove(_imageFiles[index]);
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 5, top: 5),
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
