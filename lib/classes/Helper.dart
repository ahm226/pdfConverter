import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final pdfImagelimit = ValueNotifier(0);
final compressImagelimit = ValueNotifier(0);
final RxBool permit = false.obs;
final RxList compressedFiles = [].obs;
RxInt randomNumber = 0.obs;
List<dynamic> files = [];

final String folername = "ImagetoPDF";
String folername1 = "compressedImages";

Future<bool> checkPermission(BuildContext context) async {
  Map<Permission, PermissionStatus> statues = await [
    Permission.camera,
    Permission.storage,
  ].request();
  PermissionStatus? statusCamera = statues[Permission.camera];
  PermissionStatus? statusStorage = statues[Permission.storage];
  bool isGranted = statusCamera == PermissionStatus.granted &&
      statusStorage == PermissionStatus.granted;
  if (isGranted) {
    permit.value = true;
    print("aaa");
    createFolder(folername);
    createFolder(folername1);
    return true;
  }
  bool isPermanentlyDenied =
      statusCamera == PermissionStatus.permanentlyDenied ||
          statusStorage == PermissionStatus.permanentlyDenied;
  if (isPermanentlyDenied) {
    await openAppSettings();
    print("bbb");
    permit.value = false;
    return false;
    //_showSettingsDialog(context);
  }
  permit.value = false;
  return false;
}

Future<String> createFolder(String name) async {
  Directory? directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationSupportDirectory();
  final subdir = Directory("/storage/emulated/0/Download/$name");
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
