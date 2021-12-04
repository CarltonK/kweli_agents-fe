import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogOutDialog extends StatelessWidget {
  final Function yesClick;
  const LogOutDialog({Key? key, required this.yesClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('EXIT'),
      content: const Text('Are you sure ? '),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('NO'),
        ),
        TextButton(
          onPressed: () {
            // Pop the dialog first
            Navigator.of(context).pop();
            // Perform the action
            yesClick();
          },
          child: const Text('YES'),
        )
      ],
    );
  }
}
