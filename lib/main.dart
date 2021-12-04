import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kweli_agents_fe/widgets/widgets.dart';
import 'utilities/utilities.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Initialize firebase outside build to avoid future builder triggers
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Agents',
      debugShowCheckedModeBanner: false,
      theme: Constants.appTheme,
      home: FutureBuilder<FirebaseApp>(
        future: _initialization,
        builder: (context, snapshot) {
          DeviceConfig().init(context);
          if (snapshot.hasError) {
            return GlobalErrorContained(
              errorMessage: snapshot.error.toString(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return const Scaffold();
          }
          return const GlobalLoader();
        },
      ),
    );
  }
}
