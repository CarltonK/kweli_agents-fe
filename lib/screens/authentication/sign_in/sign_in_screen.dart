import 'package:flutter/material.dart';

import '../../screens.dart';

final GlobalKey<ScaffoldState> _scaffoldLoginKey = GlobalKey<ScaffoldState>();

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldLoginKey,
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: SignInBody(scaffoldKey: _scaffoldLoginKey),
    );
  }
}
