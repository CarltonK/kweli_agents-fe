import 'package:flutter/material.dart';
import '../widgets.dart';

class GlobalErrorContained extends StatelessWidget {
  final String errorMessage;

  const GlobalErrorContained({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: InfoDialog(
          buttonPressed: () {},
          buttonText: '',
          status: 'Error',
          detail: errorMessage,
        ),
      ),
    );
  }
}
