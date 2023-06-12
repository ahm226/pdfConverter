import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagetopdfconverter/classes/ConvertScreenAppBar.dart';
import 'package:imagetopdfconverter/screens/Converting.dart';
import 'package:imagetopdfconverter/screens/ImagesList.dart';

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
                      "camera",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFF0000),
                      shadowColor: Color(0xFFFF5722),
                      elevation: 20,
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
                      "gallery",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFF0000),
                      shadowColor: Color(0xFFFF5722),
                      elevation: 20,
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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.60,
              child: ImagesList(files: files),
            ),
            const SizedBox(
              height: 16,
            ),
            Card(
              shadowColor: Color(0xFFFF0000),
              elevation: 40,
              color: Color(0xFFFF0000),
              child: Container(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.2,
                  minHeight: MediaQuery.of(context).size.height * 0.075,
                ),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  onPressed: () {
                    if (files.isEmpty) {
                      showMessage(
                          "No image selected, kindly choose images", context);
                    } else {
                      fileNameDailog(context, files, status);
                      setState(() {});
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      "Convert",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
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
        // files.addAll(duplicates.map((e) => File(e!)).toList());
        files.addAll(selectedImages as Iterable<CroppedFile>);
      } else {
        // files.add(result.path.map((e) => File(e!)).toList());
        files.addAll(selectedImages as Iterable);
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
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
            ),
          ],
        );
        if (files.isNotEmpty) {
          // files.addAll(duplicates.map((e) => File(e!)).toList());
          files.add(croppedFile!);
        } else {
          // files.add(result.path.map((e) => File(e!)).toList());
          files.add(croppedFile!);
        }
      }
    }

    setState(() {});
  }
}
