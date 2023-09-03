import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
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
              return CustomDialog(
                  context, "limit exceeded , 10 images max allowed");
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
          "Compress Images",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "DM Sans",
          ),
        ),
        elevation: 0,
        leading: const BackButton(
          color: Color(0xFF000000),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 50, right: 50, bottom: 5),
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.2,
          minHeight: MediaQuery.of(context).size.height * 0.075,
        ),
        child: ElevatedButton(
          onPressed: () async {
            if (_imageFiles.isEmpty) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                        context, "No image selected, kindly choose images");
                  });
            } else {
              await compress();
              setState(() {});
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CompressedImages(),
                ),
              );
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                        context, "Images Compressed Successfully ");
                  });
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color.fromARGB(255, 226, 51, 51),
            shadowColor: const Color(0xFFD50000),
          ),
          child: Text(
            "Compress",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontFamily: "DM Sans",
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.2,
                    minHeight: MediaQuery.of(context).size.height * 0.075,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.sd_storage_sharp,
                      size: 20,
                    ),
                    label: Text(
                      "Select Images",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "DM Sans",
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Color(0xFF1C2978),
                      shadowColor: Colors.white,
                      elevation: 4,
                    ),
                    onPressed: () async {
                      permit.value
                          ? await pickImage()
                          : checkPermission(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 8, top: 8),
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
              child: ListView.builder(
                itemCount: _imageFiles.length,
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  final kb =
                      _imageFiles[i]!.readAsBytesSync().lengthInBytes / 1024;
                  final mb = kb / 1024;
                  final size = (mb >= 1)
                      ? '${mb.toStringAsFixed(2)} MB'
                      : '${kb.toStringAsFixed(2)} KB';
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 5.0),
                    child: InkWell(
                      onTap: () => viewFile(_imageFiles[i]),
                      child: Card(
                        shape: Border.all(
                          color: Colors.white70,
                        ),
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
                                    File(_imageFiles[i]!.path.toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _imageFiles[i]!.path.split("/").last,
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
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      compressImagelimit.value--;
                                      _imageFiles.remove(_imageFiles[i]);
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
