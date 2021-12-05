import 'package:flutter/material.dart';
import '../../../../widgets/widgets.dart';
import '../../../../utilities/utilities.dart';
import '../../../screens.dart';

class SignInBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SignInBody({Key? key, required this.scaffoldKey}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: DeviceConfig.screenHeight! * 0.04),
                  const Text('Welcome Back'),
                  SizedBox(height: DeviceConfig.screenHeight! * 0.005),
                  const Text(
                    'Sign in with your email and password',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: DeviceConfig.screenHeight! * 0.08),
                  SignInForm(scaffoldKey: scaffoldKey),
                  SizedBox(height: DeviceConfig.screenHeight! * 0.04),
                  GlobalMultiInfoActionButton(
                    primaryText: 'Don\'t have an account ? ',
                    secondaryText: 'Sign Up',
                    onTap: () => Navigator.of(context).push(
                      SlideLeftTransition(
                        page: const SignUpScreen(),
                        routeName: 'sign_up_screen',
                      ),
                    ),
                  ),
                  SizedBox(height: DeviceConfig.screenHeight! * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
