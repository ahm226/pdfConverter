import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

showMessage(
  String title,
  BuildContext context,
) {
  showTopSnackBar(
    context,
    CustomSnackBar.error(
      message: title,
    ),
  );
}
