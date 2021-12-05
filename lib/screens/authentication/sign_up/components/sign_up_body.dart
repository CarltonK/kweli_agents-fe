import 'package:flutter/material.dart';
import '../../../../screens/screens.dart';
import '../../../../utilities/utilities.dart';

class SignUpBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SignUpBody({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => KeyboardUtil.hideKeyboard(context),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: DeviceConfig.screenHeight! * 0.04), // 4%
                  const Text('Register Account'),
                  SizedBox(height: DeviceConfig.screenHeight! * 0.005),
                  const Text(
                    'Enter your details to get started',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: DeviceConfig.screenHeight! * 0.08),
                  SignUpForm(scaffoldKey: scaffoldKey),
                  SizedBox(height: DeviceConfig.screenHeight! * 0.04),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
