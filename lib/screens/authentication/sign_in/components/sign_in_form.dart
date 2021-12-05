import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/widgets.dart';
import '../../../../provider/provider.dart';
import '../../../../models/models.dart';
import '../../../../utilities/utilities.dart';

class SignInForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SignInForm({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _signInFormKey = GlobalKey<FormState>();

  AgentModel? user;
  String? emailValue;
  String? passwordValue;
  TextEditingController? _editingController;
  bool canRemember = false;
  final List<String> errors = [];

  final _focusPassword = FocusNode();

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

  TextFormField buildEmailAddressField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      controller: _editingController,
      onSaved: (newValue) => emailValue = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Constants.kInvalidEmailError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Constants.kInvalidEmailError);
          return '';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_focusPassword);
      },
      decoration: const InputDecoration(
        labelText: 'Email Address',
        hintText: 'Enter your email address',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      focusNode: _focusPassword,
      onFieldSubmitted: (value) {
        KeyboardUtil.hideKeyboard(context);
        loginButtonPressed();
      },
      onSaved: (newValue) => passwordValue = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Constants.kPassNullError);
        } else if (value.length < 6) {
          removeError(error: Constants.kShortPassError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Constants.kPassNullError);
          return '';
        } else if (value.length < 6) {
          addError(error: Constants.kShortPassError);
          return '';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Future loginHandler(AgentModel userModel) async {
    return await context.read<AuthProvider>().signInEmailPass(userModel);
  }

  loginButtonPressed() {
    final FormState _formState = _signInFormKey.currentState!;
    if (_formState.validate()) {
      _formState.save();

      KeyboardUtil.hideKeyboard(context);

      user = AgentModel(email: emailValue, password: passwordValue);

      loginHandler(user!).then((value) {
        if (value.runtimeType == String) {
          Future.delayed(Constants.veryFluidDuration, () {
            dialogInfo(
              widget.scaffoldKey.currentContext!,
              value,
              'Error',
            );
          });
        }
      }).catchError((error) {
        Future.delayed(Constants.veryFluidDuration, () {
          dialogInfo(
            widget.scaffoldKey.currentContext!,
            error.toString(),
            'Error',
          );
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _signInFormKey,
      child: Column(
        children: [
          buildEmailAddressField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          GlobalActionButton(
            action: 'Login',
            onPressed: loginButtonPressed,
          ),
          SizedBox(height: DeviceConfig.screenHeight! * 0.01),
        ],
      ),
    );
  }
}
