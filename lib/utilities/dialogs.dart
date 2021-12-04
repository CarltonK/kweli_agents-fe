import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

Future dialogInfo(BuildContext context, String message,
    [String? status, String? buttonText, VoidCallback? onPress]) {
  return showCupertinoModalPopup(
    context: context,
    builder: (context) => AlertDialog(
      content: InfoDialog(
        buttonPressed: () {
          Navigator.of(context).pop();
          if (onPress != null) {
            onPress();
          }
        },
        detail: message,
        status: status ?? 'Warning',
        buttonText: buttonText ?? 'Cancel',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
