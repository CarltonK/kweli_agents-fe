import 'package:flutter/material.dart';
import '../../utilities/utilities.dart';

class KioskScreen extends StatelessWidget {
  const KioskScreen({Key? key}) : super(key: key);

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
                  'Fill in this form with details captured from kiosks',
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: DeviceConfig.screenHeight! * 0.04),
                const KioskForm(),
                SizedBox(height: DeviceConfig.screenHeight! * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class KioskForm extends StatefulWidget {
  const KioskForm({Key? key}) : super(key: key);

  @override
  _KioskFormState createState() => _KioskFormState();
}

class _KioskFormState extends State<KioskForm> {
  final _kioskFormKey = GlobalKey<FormState>();

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

  String? _kioskName,
      _kioskOwnerName,
      _kioskOwnerMobile,
      _favWholeSaler,
      _mpesaTillNumber,
      _mpesaPaybillNumber,
      _mpesaPaybillAccountNumber,
      _equityTill,
      _kcbTill,
      _otherPaymentInfo;

  final List<String> _goodsSoldSelection = [];
  final List<String> _paymentOptions = [];
  final List<String> _shopPaymentOptions = [];
  final List<String> _mpesaAccepted = [];
  final List<String> _buyFromAppOptions = [];
  final List<String> _genderOptions = [];
  final List<String> _ownershipOptions = [];
  final List<String> _businessDuration = [];
  final List<String> _locationDuration = [];
  bool isChecked(String value, List<String> custom) {
    return custom.contains(value) ? true : false;
  }

  TextFormField buildKioskNameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => _kioskName = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Kiosk name' + Constants.kRequiredField);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: 'Kiosk name' + Constants.kRequiredField);
          return;
        }
        return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_focusOwnerName);
      },
      decoration: const InputDecoration(
        helperText: 'Kiosk  name',
      ),
    );
  }

  TextFormField buildKioskOwnerNameField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      focusNode: _focusOwnerName,
      onSaved: (newValue) => _kioskOwnerName = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Kiosk owner name' + Constants.kRequiredField);
        }
        return;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: 'Kiosk owner name' + Constants.kRequiredField);
          return;
        }
        return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_focusOwnerMobile);
      },
      decoration: const InputDecoration(
        helperText: 'Kiosk owner name',
      ),
    );
  }

  TextFormField buildKioskOwnerMobileField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.number,
      focusNode: _focusOwnerMobile,
      onSaved: (newValue) => _kioskOwnerMobile = newValue!.trim(),
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

  TextFormField buildFavWholesalerField() {
    return TextFormField(
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => _favWholeSaler = newValue!.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: 'Kiosk owner name' + Constants.kRequiredField);
        }
        return;
      },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: 'Kiosk owner name' + Constants.kRequiredField);
      //     return;
      //   }
      //   return null;
      // },
      // onFieldSubmitted: (value) {
      //   FocusScope.of(context).requestFocus(_focusOwnerName);
      // },
      decoration: const InputDecoration(
        helperText: 'Favorite wholesaler name',
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
            children: Constants.kioskGoodsSold
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _goodsSoldSelection),
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
          const Text('How do you pay suppliers?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.kioskSupplierPaymentOptions
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _paymentOptions),
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

  _buildMpesaPayment() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Do you accept Mpesa payments?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.yesNoOptions
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _mpesaAccepted),
                        onSelected: (newValue) {
                          if (!_mpesaAccepted.contains(e)) {
                            _mpesaAccepted.add(e);
                          } else {
                            _mpesaAccepted.remove(e);
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

  _buildBuyfromAppOption() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(
              'Would you be interested to access credit through app to make purchases directly from your wholesalers?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.yesNoOptions
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _buyFromAppOptions),
                        onSelected: (newValue) {
                          if (!_buyFromAppOptions.contains(e)) {
                            _buyFromAppOptions.add(e);
                          } else {
                            _buyFromAppOptions.remove(e);
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

  _buildGenderOptions() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text("Kiosk owner's gender"),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.genderOptions
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _genderOptions),
                        onSelected: (newValue) {
                          if (!_genderOptions.contains(e)) {
                            _genderOptions.add(e);
                          } else {
                            _genderOptions.remove(e);
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

  _buildOwnedRented() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Kiosk owned or rented'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.ownedRented
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _ownershipOptions),
                        onSelected: (newValue) {
                          if (!_ownershipOptions.contains(e)) {
                            _ownershipOptions.add(e);
                          } else {
                            _ownershipOptions.remove(e);
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

  _buildBusinessDuration() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('How long have you been in business?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.businessDuration
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _businessDuration),
                        onSelected: (newValue) {
                          if (!_businessDuration.contains(e)) {
                            _businessDuration.add(e);
                          } else {
                            _businessDuration.remove(e);
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

  _buildLocationDuration() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('How long have you been at this location?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.businessDuration
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _locationDuration),
                        onSelected: (newValue) {
                          if (!_locationDuration.contains(e)) {
                            _locationDuration.add(e);
                          } else {
                            _locationDuration.remove(e);
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

  _buildShopPaymentOptionsSelector() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('How do your customers pay you?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.shopPaymentOptions
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _shopPaymentOptions),
                        onSelected: (newValue) {
                          if (!_shopPaymentOptions.contains(e)) {
                            _shopPaymentOptions.add(e);
                          } else {
                            _shopPaymentOptions.remove(e);
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

  _kcbTillSection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _shopPaymentOptions.contains('KCB till')
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
      child: _shopPaymentOptions.contains('Equity till')
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
      child: _shopPaymentOptions.contains('Mpesa till')
          ? buildTillNumberField()
          : Container(),
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
      child: _shopPaymentOptions.contains('Mpesa paybill')
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
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _mpesaPaybillAccountNumber = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Mpesa Paybill Account Number',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _kioskFormKey,
      child: Column(
        children: [
          buildKioskNameField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildKioskOwnerNameField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildKioskOwnerMobileField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildGenderOptions(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildGoodsSoldSelector(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildPaymentOptionsSelector(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildMpesaPayment(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildOwnedRented(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildBusinessDuration(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildLocationDuration(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildBuyfromAppOption(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildFavWholesalerField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildShopPaymentOptionsSelector(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _mpesaTillNumberSection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _mpesaPaybillNumberSection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _equityTillSection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _kcbTillSection(),
        ],
      ),
    );
  }
}
