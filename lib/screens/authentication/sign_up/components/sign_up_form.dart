import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/widgets.dart';
import '../../../../provider/provider.dart';
import '../../../../models/models.dart';
import '../../../../utilities/utilities.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const SignUpForm({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _signInFormKey = GlobalKey<FormState>();

  AgentModel? user;
  String? emailValue;
  String? phoneNumber;
  String? fullName;
  String? passwordValue;
  String? confirmPasswordValue;
  bool canRemember = false;
  final List<String> errors = [];

  TextEditingController? _editingController;
  TextEditingController? _confirmPasswordTextController;

  final _focusEmail = FocusNode();
  final _focusPhoneNumber = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();

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

  TextFormField buildFullNameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => fullName = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Constants.kNamelNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Constants.kNamelNullError);
          return '';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_focusPhoneNumber);
      },
      decoration: const InputDecoration(
        labelText: 'Full Name',
        hintText: 'Enter your full name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPhoneNumberField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.phone,
      focusNode: _focusPhoneNumber,
      onSaved: (newValue) => phoneNumber = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Constants.kPhoneNumberNullError);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Constants.kPhoneNumberNullError);
          return '';
        }
        return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_focusEmail);
      },
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter your phone number',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailAddressField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      focusNode: _focusEmail,
      onSaved: (newValue) => emailValue = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Constants.kInvalidEmailError);
        } else if (!Constants.emailValidatorRegExp.hasMatch(value)) {
          addError(error: Constants.kInvalidEmailError);
          return;
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: Constants.kInvalidEmailError);
          return '';
        } else if (!Constants.emailValidatorRegExp.hasMatch(value)) {
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
      controller: _editingController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      focusNode: _focusPassword,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_focusConfirmPassword);
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

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      controller: _confirmPasswordTextController,
      focusNode: _focusConfirmPassword,
      onFieldSubmitted: (value) {
        KeyboardUtil.hideKeyboard(context);
        registrationButtonPressed();
      },
      onSaved: (newValue) => confirmPasswordValue = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: Constants.kPassNullError);
        } else if (value.length < 6) {
          removeError(error: Constants.kShortPassError);
        } else if (value != _editingController!.text) {
          removeError(error: Constants.kMatchPassError);
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
        } else if (value != _editingController!.text) {
          addError(error: Constants.kMatchPassError);
          return '';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Enter your password again',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  Future registrationHandler(AgentModel userModel) async {
    return await context.read<AuthProvider>().createUser(userModel);
  }

  registrationButtonPressed() {
    final FormState _formState = _signInFormKey.currentState!;
    if (_formState.validate()) {
      _formState.save();

      KeyboardUtil.hideKeyboard(context);

      user = AgentModel(
        email: emailValue,
        password: passwordValue,
        joinedOn: DateTime.now(),
        fullName: fullName,
        phone: phoneNumber,
      );

      registrationHandler(user!).then((value) {
        if (value.runtimeType == String) {
          Future.delayed(Constants.veryFluidDuration, () {
            dialogInfo(
              widget.scaffoldKey.currentContext!,
              value,
              'Error',
            );
          });
        } else {
          Navigator.of(context).pop();
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
    _confirmPasswordTextController = TextEditingController();
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
          buildFullNameField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailAddressField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          GlobalActionButton(
            action: 'Register',
            onPressed: registrationButtonPressed,
          ),
          SizedBox(height: DeviceConfig.screenHeight! * 0.01),
        ],
      ),
    );
  }
}
