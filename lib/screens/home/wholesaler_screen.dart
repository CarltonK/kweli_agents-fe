import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../../utilities/utilities.dart';

class WholesalerScreen extends StatelessWidget {
  const WholesalerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                SizedBox(height: DeviceConfig.screenHeight! * 0.025),
                const Text(
                  'Fill in this form with details captured from wholesalers',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: DeviceConfig.screenHeight! * 0.04),
                const WholesalerForm(),
                SizedBox(height: DeviceConfig.screenHeight! * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WholesalerForm extends StatefulWidget {
  const WholesalerForm({Key? key}) : super(key: key);

  @override
  _WholesalerFormState createState() => _WholesalerFormState();
}

class _WholesalerFormState extends State<WholesalerForm> {
  final _wholesalerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _wholesalerFormKey,
      child: Column(
        children: [
          GlobalActionButton(
            action: 'Create',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
