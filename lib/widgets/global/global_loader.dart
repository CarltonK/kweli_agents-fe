import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../utilities/utilities.dart';

class GlobalLoader extends StatelessWidget {
  const GlobalLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: const SpinKitWave(
        color: Palette.ksmartPrimary,
        size: 200,
      ),
    );
  }
}
