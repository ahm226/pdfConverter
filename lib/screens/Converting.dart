import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../widgets/message_widget.dart';

var pdf = pw.Document();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final TextEditingController _userfilename = TextEditingController();
const String folername = "convertfiles";
String _dropDownValue = 'a4';

Future<void> fileNameDailog(
    BuildContext context, List<dynamic> files, bool status) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 30,
            content: Form(
              key: _formKey,
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: 200,
                      child: TextFormField(
                        controller: _userfilename,
                        validator: (value) {
                          return value!.isNotEmpty
                              ? null
                              : "File name can't be empty";
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter the file Name",
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: DropdownButton(
                        hint: _dropDownValue == null
                            ? const Text('a4')
                            : Text(
                                _dropDownValue,
                              ),
                        isExpanded: true,
                        iconSize: 30.0,
                        items: ['a3', 'a4', 'a5', 'a6'].map(
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
                      // TextFormField(
                      //   controller: _userfilename,
                      //   validator: (value) {
                      //     return value!.isNotEmpty
                      //         ? null
                      //         : "File name can't be empty";
                      //   },
                      //   decoration: const InputDecoration(
                      //     hintText: "Enter the file Name",
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            title: const Text(
              "File Name",
            ),
            actions: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: const Color(0xff263238),
                textColor: Colors.white,
                child: const Text(
                  "CANCEL",
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "OK",
                ),
                textColor: Colors.white,
                color: Color(0xFFFF0000),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    pdf = pw.Document();
                    createPDF(files);
                    savePDF(_userfilename.text, files);

                    Navigator.of(context).pop();
                    _userfilename.clear();

                    Navigator.of(context).pop();
                    showMessage("File converted Successfully ", context);
                    //   MaterialPageRoute(
                    //     builder: (context) => const ConvertedFilesScreen(),
                    //   ),
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
    removeConvertfiles(files);
    // showMessage('Successfully Converted', BuildContext);
  } catch (e) {
    // showMessage('error', e.toString());
  }
}

/////////////////////////////////////////////
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
