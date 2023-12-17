import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagetopdfconverter/classes/customDialog.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../classes/Helper.dart';
import 'converted_files_screen.dart';

class ConvertScreen extends StatefulWidget {
  const ConvertScreen({Key? key}) : super(key: key);

  @override
  State<ConvertScreen> createState() => _ConvertScreenState();
}

class _ConvertScreenState extends State<ConvertScreen> {
  var pdf = pw.Document();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userfilename = TextEditingController();
  String folername = "ImagetoPDF";
  late String _dropDownValueO = 'landscape';
  late String _dropDownValue = 'a4';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    files.clear();
    pdfImagelimit.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Select Images from".tr,
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.2,
                    minHeight: MediaQuery.of(context).size.height * 0.060,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 22,
                    ),
                    label: Text(
                      "Camera".tr,
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
                    ),
                    onPressed: () async {
                      permit.value
                          ? getImagesFromStorage("camera")
                          : checkPermission(context);
                    },
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * 0.2,
                    minHeight: MediaQuery.of(context).size.height * 0.060,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.sd_storage_sharp,
                      size: 22,
                    ),
                    label: Text(
                      "Storage".tr,
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
                    ),
                    onPressed: () {
                      print(permit.value);
                      permit.value
                          ? getImagesFromStorage("gallery")
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
                    onPressed: () {
                      if (files.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialog(context,
                                  "No image selected, kindly choose images".tr);
                            });
                      } else {
                        Random random = Random();
                        randomNumber.value = random.nextInt(100000000);
                        _userfilename.text =
                            "imagetopdf_" + randomNumber.value.toString();
                        fileNameDailog(context, files, status);
                        setState(() {});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      backgroundColor: Color(0xff1C2978),
                    ),
                    child: Text(
                      "Done".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "DM Sans",
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  pdfImagelimit.value.toString() + "/100",
                  style: const TextStyle(
                    fontFamily: "DM Sans",
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: files.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 7.0,
                        crossAxisSpacing: 7.0,
                      ),
                      shrinkWrap: true,
                      itemCount: files.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final file = files[index];
                        return Stack(
                          fit: StackFit.passthrough,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                onTap: () {
                                  viewFile(file);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(file.path.toString()),
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
                                    pdfImagelimit.value--;
                                    files.remove(file);
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
                      })
                  : Center(
                      child: Text(
                        "No image selected".tr,
                        style: TextStyle(
                          fontFamily: "DM Sans",
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
            ),
          ),
        ],
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
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(context, "limit exceeded".tr);
                });
      } else {
        pdfImagelimit.value < 100
            ? {
                files.addAll(selectedImages as Iterable),
                setState(() {
                  pdfImagelimit.value = pdfImagelimit.value +
                      int.parse(selectedImages!.length.toString());
                })
              }
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(context, "limit exceeded");
                });
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
                toolbarTitle: 'Crop Image'.tr,
                toolbarColor: Color(0xFF0336ff),
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Crop Image'.tr,
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
              : showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(context, "limit exceeded".tr);
                  });
        } else {
          // files.add(result.path.map((e) => File(e!)).toList());
          pdfImagelimit.value < 100
              ? {
                  files.add(croppedFile!),
                  setState(() {
                    pdfImagelimit.value++;
                  })
                }
              : showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(context, "limit exceeded".tr);
                  });
        }
      }
    }

    setState(() {});
  }

  Future<void> fileNameDailog(
      BuildContext context, List<dynamic> files, bool status) async {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 30,
              content: Form(
                key: _formKey,
                child: Container(
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: _userfilename,
                          validator: (val) =>
                              val!.isEmpty ? "enter a valid name".tr : null,
                          decoration: InputDecoration(
                            label: Text(
                              "File name".tr,
                              style: TextStyle(
                                fontFamily: "DM Sans",
                                color: Colors.black,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Color(0xFFD50000),
                              ), //<-- SEE HERE
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ), //<-- SEE HERE
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ), //<-- SEE HERE
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ), //<-- SEE HERE
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Page Size".tr,
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            width: 100,
                            child: DropdownButton(
                              hint: _dropDownValue == null
                                  ? const Text('A4')
                                  : Text(
                                      _dropDownValue,
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              items: ['A3', 'A4', 'A5', 'A6'].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropDownValue = (val as String?)!;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Orientation".tr,
                            style: TextStyle(
                              fontFamily: "DM Sans",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          Container(
                            width: 100,
                            child: DropdownButton(
                              hint: _dropDownValueO == null
                                  ? const Text('landscape')
                                  : Text(
                                      _dropDownValueO,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              isExpanded: true,
                              iconSize: 30.0,
                              items: ['landscape', 'portrait'].map(
                                (val) {
                                  return DropdownMenuItem<String>(
                                    value: val,
                                    child: Text(val),
                                  );
                                },
                              ).toList(),
                              onChanged: (val) {
                                setState(
                                  () {
                                    _dropDownValueO = (val as String?)!;
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * 0.4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        color: Colors.black,
                        textColor: Colors.white,
                        child: Text(
                          "Cancel".tr,
                          style: TextStyle(
                            fontFamily: "DM Sans",
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * 0.4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Text("Convert".tr,
                            style: TextStyle(
                              fontFamily: "DM Sans",
                            )),
                        textColor: Colors.white,
                        color: Color(0xFF1C2978),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            pdf = pw.Document();
                            createPDF(files);
                            await savePDF(_userfilename.text, files);

                            Navigator.of(context).pop();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ConvertedFilesScreen(),
                              ),
                            );
                            _userfilename.clear();
                            files.clear();
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialog(context,
                                      "File converted Successfully".tr);
                                });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  createPDF(List<dynamic> files) async {
    for (var img in files) {
      String pathFile = img.path;
      File file = File(pathFile);
      try {
        final image = pw.MemoryImage(file.readAsBytesSync());

        pdf.addPage(
          pw.Page(
            orientation: _dropDownValueO == 'landscape'
                ? pw.PageOrientation.landscape
                : pw.PageOrientation.portrait,
            pageFormat: _dropDownValueO == 'landscape'
                ? (_dropDownValue == 'a4'
                    ? PdfPageFormat.a4.landscape
                    : _dropDownValue == 'a3'
                        ? PdfPageFormat.a3.landscape
                        : _dropDownValue == 'a5'
                            ? PdfPageFormat.a5.landscape
                            : PdfPageFormat.a6.landscape)
                : (_dropDownValue == 'a4'
                    ? PdfPageFormat.a4.portrait
                    : _dropDownValue == 'a3'
                        ? PdfPageFormat.a3.portrait
                        : _dropDownValue == 'a5'
                            ? PdfPageFormat.a5.portrait
                            : PdfPageFormat.a6.portrait), //a4,a3,a6,a5
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Image(image),
              );
            },
          ),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  savePDF(String userfilename, List<dynamic> files) async {
    String filePath = Directory('/storage/emulated/0/Download/$folername').path;
    try {
      final file = File('$filePath/$userfilename.pdf');
      await file.writeAsBytes(await pdf.save());
    } catch (e) {
      // showMessage('error', e.toString());
    }
  }

  removeConvertfiles(List<dynamic> files) {
    files.clear();
  }
}
