import 'package:flutter/material.dart';

import 'utilities/utilities.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Agents',
      debugShowCheckedModeBanner: false,
      theme: Constants.appTheme,
      home: Container(),
    );
  }
}
