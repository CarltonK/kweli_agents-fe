import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../provider/provider.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';
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
      _personRunning,
      _creditAllowed,
      _outlet,
      _mpesaAgentNumber,
      _computerSystem,
      _currentSystemImprovements,
      _generalFeedback,
      _personRunningMobile;

  int genderGroupValue = -1;
  int businessDurationGroupValue = -1;
  int locationDurationGroupValue = -1;

  bool _isOwned = true;
  bool _doesAcceptMpesaPayment = true;
  bool _isInterestedInCredit = true;
  bool _isOwnerRunning = true;
  bool _doesSellOnCredit = true;
  bool _doesHaveOtherOutlets = false;
  bool _wouldUseAppToRecord = true;
  bool _wouldLikeDelivery = true;
  bool _doesRecordAlready = false;
  bool _wouldNeedCreditForFloat = true;

  final List<String> _goodsSoldSelection = [];
  final List<String> _paymentOptions = [];
  final List<String> _shopPaymentOptions = [];
  final List<String> _otherProducts = [];

  KioskModel? _kioskModel;
  Location? _location;

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
        helperText: 'Kiosk name',
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
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => _favWholeSaler = newValue!.trim(),
      onChanged: (newValue) => _favWholeSaler = newValue.trim(),
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
          Checkbox(
            value: _doesAcceptMpesaPayment,
            onChanged: (value) {
              _doesAcceptMpesaPayment = value!;
              setState(() {});
            },
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
          Checkbox(
            value: _isInterestedInCredit,
            onChanged: (value) {
              _isInterestedInCredit = value!;
              setState(() {});
            },
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
          ...genderOptions
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: RadioListTile<int>(
                      title: Text(e.title!),
                      value: e.value!,
                      groupValue: genderGroupValue,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (newValue) {
                        genderGroupValue = newValue!;
                        setState(() {});
                      },
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  _buildOwnedRented() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Kiosk owned or rented(Owned=checked)'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _isOwned,
            onChanged: (value) {
              _isOwned = value!;
              setState(() {});
            },
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
          ...durationOptions
              .map(
                (e) => RadioListTile<int>(
                  title: Text(e.title!),
                  value: e.value!,
                  groupValue: businessDurationGroupValue,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (newValue) {
                    businessDurationGroupValue = newValue!;
                    setState(() {});
                  },
                ),
              )
              .toList(),
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
          ...durationOptions
              .map((e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: RadioListTile<int>(
                      title: Text(e.title!),
                      value: e.value!,
                      groupValue: locationDurationGroupValue,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (newValue) {
                        locationDurationGroupValue = newValue!;
                        setState(() {});
                      },
                    ),
                  ))
              .toList(),
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
      keyboardType: TextInputType.text,
      onChanged: (newValue) => _mpesaPaybillAccountNumber = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Mpesa Paybill Account Number',
      ),
    );
  }

  _buildOwnerRun() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Is the owner running the kiosk?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _isOwnerRunning,
            onChanged: (value) {
              _isOwnerRunning = value!;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  _notOwnerRunSelection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: !_isOwnerRunning
          ? Column(
              children: [
                buildPersonRunningNameField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildPersonRunningMobileField(),
              ],
            )
          : Container(),
    );
  }

  TextFormField buildPersonRunningNameField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _personRunning ?? ''),
      keyboardType: TextInputType.text,
      onChanged: (newValue) => _personRunning = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Employee name',
      ),
    );
  }

  TextFormField buildPersonRunningMobileField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _personRunningMobile ?? ''),
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _personRunningMobile = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Employee mobile number',
      ),
    );
  }

  _buildCreditOption() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Do you sell on credit?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _doesSellOnCredit,
            onChanged: (value) {
              _doesSellOnCredit = value!;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  _creditAcceptedSelection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _doesSellOnCredit
          ? Column(
              children: [
                buildCreditDaysField(),
              ],
            )
          : Container(),
    );
  }

  TextFormField buildCreditDaysField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _creditAllowed ?? ''),
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _creditAllowed = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'How long do people take to pay you(days)?',
      ),
    );
  }

  _buildOtherOutlets() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Do you have other outlets?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _doesHaveOtherOutlets,
            onChanged: (value) {
              _doesHaveOtherOutlets = value!;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  _otherOutletsSelection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _doesHaveOtherOutlets
          ? Column(
              children: [
                buildotherOutletsLocationField(),
              ],
            )
          : Container(),
    );
  }

  TextFormField buildotherOutletsLocationField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _outlet ?? ''),
      keyboardType: TextInputType.text,
      onChanged: (newValue) => _outlet = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Location of the other outlet',
      ),
    );
  }

  _buildOtherProducts() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('What other products/services do you offer?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Wrap(
            direction: Axis.horizontal,
            children: Constants.otherProducts
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text(e),
                        selected: isChecked(e, _otherProducts),
                        onSelected: (newValue) {
                          if (!_otherProducts.contains(e)) {
                            _otherProducts.add(e);
                          } else {
                            _otherProducts.remove(e);
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

  _mpesaAgentSelection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _otherProducts.contains('Mpesa Withdrawal/deposit')
          ? Column(
              children: [
                buildMpesaAgentNumberField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildFinancingOptionField()
              ],
            )
          : Container(),
    );
  }

  TextFormField buildMpesaAgentNumberField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _mpesaAgentNumber ?? ''),
      keyboardType: TextInputType.number,
      onChanged: (newValue) => _mpesaAgentNumber = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'Mpesa Agent number',
      ),
    );
  }

  buildFinancingOptionField() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Would you need credit for your float?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _wouldNeedCreditForFloat,
            onChanged: (value) {
              _wouldNeedCreditForFloat = value!;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  _buildDeliveryOption() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Would you like your purchases delivereed at a fee?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _wouldLikeDelivery,
            onChanged: (value) {
              _wouldLikeDelivery = value!;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  _buildRecordSalesOption() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Would you use the app to record sales and expenditure?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _wouldUseAppToRecord,
            onChanged: (value) {
              _wouldUseAppToRecord = value!;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  _buildcComputerizedSystemOptions() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text(
              'Do you keep computerized records of daily sales/expenditure/customers who owe you ?'),
          SizedBox(height: getProportionateScreenHeight(5)),
          Checkbox(
            value: _doesRecordAlready,
            onChanged: (value) {
              _doesRecordAlready = value!;
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  _computerizedSystemSelection() {
    return AnimatedSwitcher(
      duration: Constants.veryFluidDuration,
      switchInCurve: Curves.easeInCubic,
      switchOutCurve: Curves.easeOutCubic,
      child: _doesRecordAlready
          ? Column(
              children: [
                buildSystemField(),
                SizedBox(height: getProportionateScreenHeight(20)),
                buildSystemImprovementsField(),
              ],
            )
          : Container(),
    );
  }

  TextFormField buildSystemField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _computerSystem ?? ''),
      keyboardType: TextInputType.text,
      onChanged: (newValue) => _computerSystem = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'What system/application do you use?',
      ),
    );
  }

  TextFormField buildSystemImprovementsField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      controller: TextEditingController(text: _currentSystemImprovements ?? ''),
      keyboardType: TextInputType.text,
      onChanged: (newValue) => _currentSystemImprovements = newValue.trim(),
      decoration: const InputDecoration(
        helperText:
            'What improvements would you want to see on the currecnt system you use',
      ),
    );
  }

  TextFormField buildGeneralFeedbackField() {
    return TextFormField(
      textInputAction: TextInputAction.done,
      maxLines: 4,
      controller: TextEditingController(text: _currentSystemImprovements ?? ''),
      keyboardType: TextInputType.text,
      onChanged: (newValue) => _currentSystemImprovements = newValue.trim(),
      decoration: const InputDecoration(
        helperText: 'General feedback',
      ),
    );
  }

  Future _onSubmitHandler() async {
    return await context.read<DatabaseProvider>().saveKiosk(_kioskModel!);
  }

  _onSubmitButtonPressed() {
    getDevicePosition().then((value) {
      _location = Location(
        latitude: value.latitude,
        longitude: value.longitude,
      );

      final FormState _form = _kioskFormKey.currentState!;
      if (_form.validate()) {
        _form.save();

        _kioskModel = KioskModel(
          kioskName: _kioskName,
          kioskOwnerName: _kioskOwnerName,
          kioskOwnerMobile: _kioskOwnerMobile,
          isOwned: _isOwned,
          favWholeseller: _favWholeSaler,
          kioskGoods: _goodsSoldSelection,
          kioskWholesellerPaymentOptions: _paymentOptions,
          doesAcceptMpesa: _doesAcceptMpesaPayment,
          howDoCustomersPayYou: _shopPaymentOptions,
          mpesaTillNumber: _mpesaTillNumber,
          mpesaPaybillNumber: _mpesaPaybillNumber,
          mpesaPaybillAccountNumber: _mpesaPaybillAccountNumber,
          mpesaAgentNumbers: [_mpesaAgentNumber],
          isInterestedInProduct: _isInterestedInCredit,
          equityTillNumber: _equityTill,
          kcbTillNumber: _kcbTill,
          isOwnerRunningKiosk: _isOwnerRunning,
          personRunningKioskName: _personRunning,
          personRunningKioskMobile: _personRunningMobile,
          doesSellOnCredit: _doesSellOnCredit,
          howLongTillPeoplePayYouBack: _creditAllowed,
          hasOtherOutlets: _doesHaveOtherOutlets,
          otherOutletLocation: _outlet,
          otherServices: _otherProducts,
          wouldUseProductToRecord: _wouldUseAppToRecord,
          wouldLikePurchasesDelivered: _wouldLikeDelivery,
          doesKeepComputerizedRecords: _doesRecordAlready,
          systemInUse: _computerSystem,
          location: _location,
          improvementsToCurrentSystemNeeded: _currentSystemImprovements,
          generalFeedback: _generalFeedback,
          addedAt: DateTime.now(),
          isMpesaAgent: _otherProducts.contains('Mpesa Withdrawal/deposit'),
          needsCreditForFloat: _wouldNeedCreditForFloat,
          kioskOwnerGender: genderGroupValue == -1
              ? null
              : genderOptions[genderGroupValue].title,
          howLongInBusiness: businessDurationGroupValue == -1
              ? null
              : durationOptions[businessDurationGroupValue].title,
          howLongInLocation: locationDurationGroupValue == -1
              ? null
              : durationOptions[locationDurationGroupValue].title,
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
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildOwnerRun(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _notOwnerRunSelection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildCreditOption(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _creditAcceptedSelection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildOtherOutlets(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _otherOutletsSelection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildOtherProducts(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _mpesaAgentSelection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildRecordSalesOption(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildDeliveryOption(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _buildcComputerizedSystemOptions(),
          SizedBox(height: getProportionateScreenHeight(20)),
          _computerizedSystemSelection(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildGeneralFeedbackField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          GlobalActionButton(
            action: 'Submit',
            onPressed: _onSubmitButtonPressed,
          ),
        ],
      ),
    );
  }
}
