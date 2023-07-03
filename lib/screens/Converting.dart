// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:permission_handler/permission_handler.dart';
//
// import '../widgets/message_widget_success.dart';
// import 'converted_files_screen.dart';
//
// var pdf = pw.Document();
// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// final TextEditingController _userfilename = TextEditingController();
// const String folername = "convertfiles";
// String _dropDownValue = 'a4';
//
// Future<void> fileNameDailog(
//     BuildContext context, List<dynamic> files, bool status) async {
//   return showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//             elevation: 30,
//             content: Form(
//               key: _formKey,
//               child: Container(
//                 height: 160,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       child: TextFormField(
//                         controller: _userfilename,
//                         validator: (val) =>
//                             val!.isEmpty ? "enter a valid name" : null,
//                         decoration: InputDecoration(
//                           label: Text(
//                             "File name",
//                             style: TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: BorderSide(
//                               width: 1,
//                               color: Color(0xFFD50000),
//                             ), //<-- SEE HERE
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: BorderSide(
//                               width: 1,
//                               color: Colors.grey,
//                             ), //<-- SEE HERE
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: const BorderSide(
//                               width: 1,
//                               color: Colors.grey,
//                             ), //<-- SEE HERE
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: BorderSide(
//                               width: 1,
//                               color: Colors.grey,
//                             ), //<-- SEE HERE
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           "Page size",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         Container(
//                           width: 100,
//                           child: DropdownButton(
//                             hint: _dropDownValue == null
//                                 ? const Text('A4')
//                                 : Text(
//                                     _dropDownValue,
//                                   ),
//                             isExpanded: true,
//                             iconSize: 30.0,
//                             items: ['A3', 'A4', 'A5', 'A6'].map(
//                               (val) {
//                                 return DropdownMenuItem<String>(
//                                   value: val,
//                                   child: Text(val),
//                                 );
//                               },
//                             ).toList(),
//                             onChanged: (val) {
//                               setState(
//                                 () {
//                                   _dropDownValue = (val as String?)!;
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               MaterialButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 color: const Color(0xff000000),
//                 textColor: Colors.white,
//                 child: const Text(
//                   "CANCEL",
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//               MaterialButton(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 child: const Text(
//                   "OK",
//                 ),
//                 textColor: Colors.white,
//                 color: Color.fromARGB(255, 226, 51, 51),
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     pdf = pw.Document();
//                     createPDF(files);
//                     await savePDF(_userfilename.text, files);
//
//                     Navigator.of(context).pop();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const ConvertedFilesScreen(),
//                       ),
//                     );
//                     _userfilename.clear();
//                     showMessageForSuccess(
//                       "File converted Successfully ",
//                       context,
//                     );
//                   }
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
//
// createPDF(List<dynamic> files) async {
//   for (var img in files) {
//     String pathFile = img.path;
//     File file = File(pathFile);
//     try {
//       final image = pw.MemoryImage(file.readAsBytesSync());
//
//       pdf.addPage(
//         pw.Page(
//           pageFormat: _dropDownValue == 'a4'
//               ? PdfPageFormat.a4
//               : _dropDownValue == 'a3'
//                   ? PdfPageFormat.a3
//                   : _dropDownValue == 'a5'
//                       ? PdfPageFormat.a5
//                       : PdfPageFormat.a6, //a4,a3,a6,a5
//           build: (pw.Context context) {
//             return pw.Center(
//               child: pw.Image(image),
//             );
//           },
//         ),
//       );
//     } catch (e) {
//       print(e);
//     }
//   }
// }
//
// savePDF(String userfilename, List<dynamic> files) async {
//   String filePath = await createFolder(folername);
//
//   try {
//     final file = File('$filePath/$userfilename.pdf');
//     await file.writeAsBytes(await pdf.save());
//   } catch (e) {
//     // showMessage('error', e.toString());
//   }
// }
//
// /////////////////////////////////////////////
// Future<String> createFolder(String name) async {
//   Directory? directory = Platform.isAndroid
//       ? await getExternalStorageDirectory()
//       : await getApplicationSupportDirectory();
//
//   final subdir = Directory('/storage/emulated/0/Download/$name');
//   //Directory((directory)!.path + '/$name');
//
//   var status = await Permission.storage.status;
//   if (!status.isGranted) {
//     await Permission.storage.request();
//   }
//   if ((await subdir.exists())) {
//     return subdir.path;
//   } else {
//     subdir.create();
//     return subdir.path;
//   }
// }
//
// removeConvertfiles(List<dynamic> files) {
//   files.clear();
// }
