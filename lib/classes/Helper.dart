import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:permission_handler/permission_handler.dart';

final pdfImagelimit = ValueNotifier(0);
final compressImagelimit = ValueNotifier(0);
final RxBool permit = false.obs;
final RxList compressedFiles = [].obs;
RxInt randomNumber = 0.obs;
List<dynamic> files = [];

String folername = "ImagetoPDF";
String folername1 = "compressedImages";
Future<bool> checkPermission(BuildContext context) async {
  final plugin = DeviceInfoPlugin();
  final android = await plugin.androidInfo;

  Map<Permission, PermissionStatus> statues = await [
    Permission.camera,
    Permission.storage,
    Permission.photos,
  ].request();
  print(statues);
  PermissionStatus? statusCamera = statues[Permission.camera];
  PermissionStatus? statusPhotos = android.version.sdkInt < 33
      ? PermissionStatus.granted
      : statues[Permission.photos];
  PermissionStatus? statusStorage = android.version.sdkInt < 33
      ? statues[Permission.storage]
      : PermissionStatus.granted;
  // PermissionStatus? statusExternalStorage =
  //     statues[Permission.manageExternalStorage];
  bool isGranted = statusCamera == PermissionStatus.granted &&
      statusStorage == PermissionStatus.granted &&
      statusPhotos == PermissionStatus.granted;
  // &&
  // statusExternalStorage == PermissionStatus.granted;
  if (isGranted) {
    permit.value = true;
    await createFolder(folername);
    await createFolder(folername1);
    return true;
  }
  bool isPermanentlyDenied =
      statusCamera == PermissionStatus.permanentlyDenied ||
          statusStorage == PermissionStatus.permanentlyDenied ||
          statusPhotos == PermissionStatus.permanentlyDenied;
  // ||
  // statusExternalStorage == PermissionStatus.permanentlyDenied;
  if (isPermanentlyDenied) {
    await openAppSettings();
    print("bbb");
    permit.value = false;
    return false;
    //_showSettingsDialog(context);
  }
  return false;
}

Future<String> createFolder(String name) async {
  // Directory? directory = Platform.isAndroid
  //     ? await getExternalStorageDirectory()
  //     : await getApplicationSupportDirectory();
  final subdir = Directory("/storage/emulated/0/Download/$name");

  if (await subdir.exists()) {
    return subdir.path;
  } else {
    await subdir.create();
    return subdir.path;
  }
}
