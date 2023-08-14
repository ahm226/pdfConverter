import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagetopdfconverter/widgets/message_widget_error.dart';
import 'package:imagetopdfconverter/widgets/message_widget_infromation.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

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
  String folername = "convertfiles";
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
    pdfImagelimit.value = 0;
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
          "Choose Images",
          // style: GoogleFonts.dmSans(
          //   color: Colors.black,
          //   fontWeight: FontWeight.bold,
          // ),
        ),
        elevation: 0,
        leading: const BackButton(
          color: Color(0xFF000000),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      minHeight: MediaQuery.of(context).size.height * 0.075,
                    ),
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.camera_alt,
                        size: 22,
                      ),
                      label: Text(
                        "Camera",
                        // style: GoogleFonts.dmSans(
                        //   color: Colors.white,
                        //   fontSize: 18,
                        // ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Color(0xff1C2978),
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
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      minHeight: MediaQuery.of(context).size.height * 0.075,
                    ),
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.sd_storage_sharp,
                        size: 22,
                      ),
                      label: Text(
                        "Storage",
                        // style: GoogleFonts.dmSans(
                        //   color: Colors.white,
                        //   fontSize: 18,
                        // ),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Color(0xff1C2978),
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
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    pdfImagelimit.value.toString() + "/100",
                    // style: GoogleFonts.dmSans(
                    //   color: Colors.black,
                    // ),
                  ),
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
                                    shape: Border.all(color: Colors.white70),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    file.path.split("/").last,
                                                    maxLines: 1,
                                                    // style: GoogleFonts.dmSans(
                                                    //     color: Colors.black,
                                                    //     fontWeight:
                                                    //         FontWeight.w500),
                                                  ),
                                                  Text(
                                                    file.path
                                                        .toString()
                                                        .split(".")
                                                        .last,
                                                    // style: GoogleFonts.dmSans(
                                                    //     color: Colors.grey,
                                                    //     fontWeight:
                                                    //         FontWeight.w500),
                                                  ),
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
                                                color: const Color(0xFFD50000),
                                              ),
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
                        : Center(
                            child: Text(
                              "No image selected",
                              // style: GoogleFonts.dmSans(
                              //   color: Colors.black,
                              //   fontSize: 18,
                              // ),
                            ),
                          ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * 0.5,
                minHeight: MediaQuery.of(context).size.height * 0.065,
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (files.isEmpty) {
                    showMessageForError(
                      "No image selected, kindly choose images",
                      context,
                    );
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color.fromARGB(255, 226, 51, 51),
                  shadowColor: const Color(0xFFD50000),
                ),
                child: Text(
                  "Convert",
                  textAlign: TextAlign.center,
                  // style: GoogleFonts.dmSans(
                  //   color: Colors.white,
                  //   fontWeight: FontWeight.w500,
                  //   fontSize: 22,
                  // ),
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
                  height: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: TextFormField(
                          controller: _userfilename,
                          validator: (val) =>
                              val!.isEmpty ? "enter a valid name" : null,
                          decoration: InputDecoration(
                            label: Text(
                              "File name",
                              // style: GoogleFonts.dmSans(
                              //   color: Colors.black,
                              // ),
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
                            "Page size",
                            // style: GoogleFonts.dmSans(
                            //   fontWeight: FontWeight.bold,
                            //   fontSize: 15,
                            //   color: Colors.black,
                            // ),
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
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: const Color.fromARGB(255, 226, 51, 51),
                  textColor: Colors.white,
                  child: Text(
                    "Cancel",
                    // style: GoogleFonts.dmSans(),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "Done",
                    // style:
                    // GoogleFonts.dmSans()
                  ),
                  textColor: Colors.white,
                  color: Color(0xFF1C2978),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      pdf = pw.Document();
                      createPDF(files);
                      await savePDF(_userfilename.text, files);

                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ConvertedFilesScreen(),
                        ),
                      );
                      _userfilename.clear();
                      files.clear();
                      // showMessageForSuccess(
                      //   "File converted Successfully ",
                      //   context,
                      // );
                    }
                  },
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
            pageFormat: _dropDownValue == 'a4'
                ? PdfPageFormat.a4
                : _dropDownValue == 'a3'
                    ? PdfPageFormat.a3
                    : _dropDownValue == 'a5'
                        ? PdfPageFormat.a5
                        : PdfPageFormat.a6, //a4,a3,a6,a5
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
    String filePath = await createFolder(folername);

    try {
      final file = File('$filePath/$userfilename.pdf');
      await file.writeAsBytes(await pdf.save());
    } catch (e) {
      // showMessage('error', e.toString());
    }
  }

  Future<String> createFolder(String name) async {
    Directory? directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();

    final subdir = Directory('/storage/emulated/0/Download/$name');
    //Directory((directory)!.path + '/$name');

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await subdir.exists())) {
      return subdir.path;
    } else {
      subdir.create();
      return subdir.path;
    }
  }

  removeConvertfiles(List<dynamic> files) {
    files.clear();
  }
}
