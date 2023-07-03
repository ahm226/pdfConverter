import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

final pdfImagelimit = ValueNotifier(0);
final compressImagelimit = ValueNotifier(0);
final RxList compressedFiles = [].obs;
RxInt randomNumber = 0.obs;
List<dynamic> files = [];
