import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/services.dart';
import '../../provider/provider.dart';
import '../../models/models.dart';
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

  WholesellerModel? _wholesellerModel;
  Location? _location;

  String? _shopName,
      _ownerName,
      _ownerMobile,
      _mpesaTillNumber,
      _mpesaPaybillNumber,
      _mpesaPaybillAccountNumber,
      _equityTill,
      _kcbTill,
      _otherPaymentInfo,
      _minPurchaseAmount,
      _otherDeliveryInfo;

  bool _isHappy = false;
  bool _doesDeliver = true;

  final List<String> _goodsSoldSelection = [];
  final List<String> _paymentOptions = [];

  bool isIncluded(String value, List<String> custom) {
    return custom.contains(value) ? true : false;
  }

  TextFormField buildWholesalerShopNameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => _shopName = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Wholesaler shop name' + Constants.kRequiredField);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: 'Wholesaler shop name' + Constants.kRequiredField);
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
          removeError(error: 'Owner name' + Constants.kRequiredField);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: 'Owner name' + Constants.kRequiredField);
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
          removeError(error: 'Owner mobile' + Constants.kRequiredField);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: 'Owner mobile' + Constants.kRequiredField);
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

  _buildGoodsSoldSelector() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Which goods are sold?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.wholesalerGoodsSold
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isIncluded(e, _goodsSoldSelection),
                        onSelected: (newValue) {
                          if (!_goodsSoldSelection.contains(e)) {
                            _goodsSoldSelection.add(e);
                          } else {
                            _goodsSoldSelection.remove(e);
                          }
                          setState(() {});
                        },
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  _buildPaymentOptionsSelector() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('How do your customers pay you?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.wholesalerPaymentOptions
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isIncluded(e, _paymentOptions),
                        onSelected: (newValue) {
                          if (!_paymentOptions.contains(e)) {
                            _paymentOptions.add(e);
                          } else {
                            _paymentOptions.remove(e);
                          }
                          setState(() {});
                        },
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }

  TextFormField buildOtherPaymentInfoField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _otherPaymentInfo ?? ''),
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _otherPaymentInfo = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Other payment information',
      ),
    );
  }

  _othersPaymentSection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _paymentOptions.contains('Others')
          ? buildOtherPaymentInfoField()
          : Container(),
    );
  }

  _kcbTillSection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _paymentOptions.contains('KCB till')
          ? buildKCBTillNumberField()
          : Container(),
    );
  }

  TextFormField buildKCBTillNumberField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _kcbTill ?? ''),
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _kcbTill = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'KCB Till Number',
      ),
    );
  }

  _equityTillSection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _paymentOptions.contains('Equity till')
          ? buildEquityTillNumberField()
          : Container(),
    );
  }

  TextFormField buildEquityTillNumberField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _equityTill ?? ''),
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _equityTill = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Equity Till Number',
      ),
    );
  }

  _mpesaTillNumberSection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _paymentOptions.contains('Mpesa till')
          ? buildTillNumberField()
          : Container(),
    );
  }

  _doesDeliverySection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _doesDeliver
          ? Column(
              children: [
                buildMinPurchaseAmountForDeliveryField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildRadiusandChargeDeliveryField(),
              ],
            )
          : Container(),
    );
  }

  TextFormField buildMinPurchaseAmountForDeliveryField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: TextEditingController(text: _minPurchaseAmount ?? ''),
      keyboardType: TextInputType.text,
      onChanged: (newValue) => _minPurchaseAmount = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Minimum purchase amount eligible for delivery',
      ),
    );
  }

  TextFormField buildRadiusandChargeDeliveryField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _otherDeliveryInfo ?? ''),
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _otherDeliveryInfo = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Other notes about delivery charges and radius',
      ),
    );
  }

  TextFormField buildTillNumberField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _mpesaTillNumber ?? ''),
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _mpesaTillNumber = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Mpesa Till Number',
      ),
    );
  }

  _mpesaPaybillNumberSection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _paymentOptions.contains('Mpesa paybill')
          ? Column(
              children: [
                buildMpesaPaybillNumberField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildMpesaPaybillAccountNumberField(),
              ],
            )
          : Container(),
    );
  }

  TextFormField buildMpesaPaybillNumberField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _mpesaPaybillNumber ?? ''),
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _mpesaPaybillNumber = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Mpesa Paybill Number',
      ),
    );
  }

  TextFormField buildMpesaPaybillAccountNumberField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _mpesaPaybillAccountNumber ?? ''),
      keyboardType: TextInputType.text,
      onChanged: (newValue) => _mpesaPaybillAccountNumber = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Mpesa Paybill Account Number',
      ),
    );
  }

  _buildViabilitySelector() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(Constants.viabilityForWholesaler),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _isHappy,
            onChanged: (value) {
              _isHappy = value!;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  _buildDeliverySelector() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Do you deliver?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _doesDeliver,
            onChanged: (value) {
              _doesDeliver = value!;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Future _onSubmitHandler() async {
    return await context
        .read<DatabaseProvider>()
        .saveWholeseller(_wholesellerModel!);
  }

  _onSubmitButtonPressed() {
    getDevicePosition().then((value) {
      _location = Location(
        latitude: value.latitude,
        longitude: value.longitude,
      );

      final FormState _form = _wholesalerFormKey.currentState!;
      if (_form.validate()) {
        _form.save();

        _wholesellerModel = WholesellerModel(
          doesDeliver: _doesDeliver,
          equityTillNumber: _equityTill,
          location: _location,
          goodsSold: _goodsSoldSelection,
          isHappyForProduct: _isHappy,
          kcbTillNumber: _kcbTill,
          minPurchaseAmountForDelivery: _minPurchaseAmount,
          mpesaPaybillAccountNumber: _mpesaPaybillAccountNumber,
          mpesaPaybillNumber: _mpesaPaybillNumber,
          mpesaTillNumber: _mpesaTillNumber,
          otherDeliveryInfo: _otherDeliveryInfo,
          otherPaymentInfo: _otherPaymentInfo,
          ownerMobile: _ownerMobile,
          ownerName: _ownerName,
          paymentOptions: _paymentOptions,
          shopName: _shopName,
        );

        _onSubmitHandler().then((value) {
          if (value.runtimeType == String) {
            Future.delayed(Constants.veryFluidDuration, () {
              dialogInfo(context, value, 'Error');
            });
          } else {
            _form.reset();
            Future.delayed(Constants.veryFluidDuration, () {
              dialogSuccess(context, 'Data saved');
            });
          }
        }).catchError((error, trace) {
          Future.delayed(Constants.veryFluidDuration, () {
            dialogInfo(
              context,
              error.toString(),
              'Error',
            );
          });
        });
      }
    }).catchError((error, trace) {
      Future.delayed(Constants.veryFluidDuration, () {
        dialogInfo(context, error.toString(), 'Error');
      });
    });
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
          _buildGoodsSoldSelector(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildPaymentOptionsSelector(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _mpesaTillNumberSection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _mpesaPaybillNumberSection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _equityTillSection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _kcbTillSection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _othersPaymentSection(),
          const Divider(color: Palette.ksmartPrimary),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildViabilitySelector(),
          const Divider(color: Palette.ksmartPrimary),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildDeliverySelector(),
          _doesDeliverySection(),
          const Divider(color: Palette.ksmartPrimary),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          GlobalActionButton(
            action: 'Create',
            onPressed: _onSubmitButtonPressed,
          ),
        ],
      ),
    );
  }
}
