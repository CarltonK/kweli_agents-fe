// ignore_for_file: unused_field

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

  final List<String> errors = [];

  final _focusOwnerName = FocusNode();
  final _focusOwnerMobile = FocusNode();

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error!);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  String? _shopName, _ownerName, _ownerMobile;

  TextFormField buildWholesalerShopNameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => _shopName = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Constants.kRequiredField);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Constants.kRequiredField);
          return;
        }
        return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_focusOwnerName);
      },
      decoration: const InputDecoration(
        helperText: 'Wholesaler shop name',
      ),
    );
  }

  TextFormField buildWholesalerOwnerNameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      focusNode: _focusOwnerName,
      onSaved: (newValue) => _ownerName = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Constants.kRequiredField);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Constants.kRequiredField);
          return;
        }
        return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_focusOwnerMobile);
      },
      decoration: const InputDecoration(
        helperText: 'Owner name',
      ),
    );
  }

  TextFormField buildWholesalerOwnerMobileField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      focusNode: _focusOwnerMobile,
      onSaved: (newValue) => _ownerMobile = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Constants.kRequiredField);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Constants.kRequiredField);
          return;
        }
        return null;
      },
      onFieldSubmitted: (value) {},
      decoration: const InputDecoration(
        helperText: 'Owner mobile',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _wholesalerFormKey,
      child: Column(
        children: [
          buildWholesalerShopNameField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildWholesalerOwnerNameField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildWholesalerOwnerMobileField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          GlobalActionButton(
            action: 'Create',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
