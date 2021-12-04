import 'dart:developer' show log;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../provider/provider.dart';
import '../utilities/utilities.dart';

class BaseLoginScreen extends StatefulWidget {
  const BaseLoginScreen({Key? key}) : super(key: key);

  @override
  State<BaseLoginScreen> createState() => _BaseLoginScreenState();
}

class _BaseLoginScreenState extends State<BaseLoginScreen> {
  _loginHandler() {
    context
        .read<AuthProvider>()
        .signInWithGoogle()
        .then((value) => {log('${value}')})
        .catchError((error, stackTrace) {
      dialogInfo(context, '$error', 'Error');
    });
  }

  Widget _buildGoogleSignInButton() {
    return GestureDetector(
      child: Container(
        height: DeviceConfig.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logos/google.png'),
          ),
        ),
      ),
      onTap: _loginHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SizedBox(
          height: DeviceConfig.screenHeight,
          child: Center(
            child: _buildGoogleSignInButton(),
          ),
        ),
      ),
    );
  }
}
