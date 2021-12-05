import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'provider/provider.dart';
import 'utilities/utilities.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => AuthProvider.instance()),
  ];
  runApp(MultiProvider(providers: providers, child: const MyApp()));
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
            return Consumer<AuthProvider>(
              builder: (context, value, child) {
                if (value.status == Status.Authenticated) {
                  return const BaseHomeScreen();
                }
                if (value.status == Status.Authenticating) {
                  return const GlobalLoader();
                }
                return child!;
              },
              child: const SignInScreen(),
            );
          }
          return const GlobalLoader();
        },
      ),
    );
  }
}
