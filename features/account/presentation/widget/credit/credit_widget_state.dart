/* **********************************************************************
    File: credit_widget_state.dart
    Date: 02-22-2023
    Author: Daryl Ng
    Copyright Information:
    Information contained herein is proprietary to and constitutes valuable
    confidential trade secrets of Top Run , or its licensors, and
    is subject to restrictions on use and disclosure.
    Copyright (c)  2023 Top Run Inc. All rights reserved.
    The copyright notices above do not evidence any actual or
    intended publication of this material.
    Description :
    Handles the states for credit.dart.
 *************************************************************************/

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../widget/non_feature_widgets/TextFunc.dart';
import '/utilities/formatter.dart';
import '/utilities/strDictionary.dart';
import '/utilities/validators/validation.dart';
import '/widget/non_feature_widgets/dropdownMenu/CustomDropDown.dart';
import '/widget/non_feature_widgets/dropdownMenu/dropdown_listvalues.dart';
import '/widget/non_feature_widgets/textField/CustomTextField.dart';
import '/widget/user_singleton/user_singleton.dart';

import 'credit.dart';
import '../account/account.dart';

import '/core/config/authentication.dart';

import 'dart:convert';


import '/features/account/data/account_urls.dart';
import 'package:http/http.dart';



// import '../controller/my_isolates.dart';
// import '../domain/entities/account.dart';
// import '../features/account/presentation/bloc/account_widget_state.dart';

double _createAccountButtonWidth = 0.6;

double _creditTextBotPadding = 10;
double _chargeTextBotPadding = 10;
double _buttonPadding = 40;

double _zipRightPadding = 2;

int _firstYear = DateTime.now().year;
int _lastYear = DateTime.now().year + 20;

class CreditState extends ConsumerState<Credit> {
  final Account _accountSingleton = Account();
  final UserSingleton _existingUser = UserSingleton();

  final _formKey = GlobalKey<FormState>();

  final _creditCardNumberControl = TextEditingController();
  final _cardholderNameControl = TextEditingController();
  final _addressControl = TextEditingController();
  final _cityControl = TextEditingController();
  final _zipcodeControl = TextEditingController();
  final _countryControl = TextEditingController();
  final _billingCompanyNameControl = TextEditingController();
  final _accountPayEmailControl = TextEditingController();
  final _accountReceiveEmailControl = TextEditingController();

  final _bankAccountNumberControl = TextEditingController();
  final _bankRoutingNumberControl = TextEditingController();
  final _bankAccountTypeOptions = DropDownVar.getBankAccountTypeList();

  final _paymentSettingOptions = DropDownVar.getPaymentSettingList();
  final _expirationMonthOptions = DropDownVar.getMonthList();
  final _expirationYearOptions = DropDownVar.getYearList(_firstYear, _lastYear);
  final _stateOptions = DropDownVar.getStateList();

  final _verifyCodeControl = TextEditingController();

  String? _paymentSettingInput;
  String? _expirationMonthInput;
  String? _expirationYearInput;
  String? _stateFieldInput;
  String? _bankAccountTypeInput;

  final _creditSnackBar = SnackBar(
    content: Text(creditSnackBarText),
    action: SnackBarAction(
      label: creditSnackBarActionText,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  final _creditCardSnackBar = SnackBar(
    content: Text(creditCardSnackBarText),
    action: SnackBarAction(
      label: creditCardSnackBarActionText,
      onPressed: () {},
    ),
  );

  /* **********************************************************************
      Function Name: void initState
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Initializing function before Credit is built.
   *************************************************************************/
  @override
  void initState() {
    super.initState();

    if (!_existingUser.getExistingUser())
    {
      _paymentSettingInput = _paymentSettingOptions.first;
      _expirationMonthInput = _expirationMonthOptions.first;
      _expirationYearInput = _expirationYearOptions.first;
      _stateFieldInput = _stateOptions.first;
      _bankAccountTypeInput = _bankAccountTypeOptions.first;
    } else
    {
      _paymentSettingInput = widget.getPaymentSetting();
      _bankAccountTypeInput = widget.getBankAccountType();
      _billingCompanyNameControl.text = widget.getBillingCompanyName() as String;
      _accountPayEmailControl.text = widget.getAccountPayEmail() as String;
      _accountReceiveEmailControl.text = widget.getAccountReceiveEmail() as String;
    }
  }

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      _creditForm - all widgets that make up the Credit class
      Description :
      Handles the building & states for the Credit
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return _creditForm();
  }

  /* **********************************************************************
      Function Name:  Widget _creditForm
      Input Parameters:
      None
      Output Parameter:
      Form - all widgets that make up the Credit Form
      Description :
      All widgets that make up the Credit Form
   *************************************************************************/
  Widget _creditForm() {
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: _creditTextBotPadding),
              alignment: Alignment.centerLeft,
              child: TextFunc.printAutoSizeTextBox(creditInfoText),
            ),

            Container(
              padding: EdgeInsets.only(bottom: _chargeTextBotPadding),
              alignment: Alignment.centerLeft,
              child: TextFunc.printAutoSizeTextBox(creditChargeText),
            ),

            CustomDropDown(
              name: paymentSettingText,
              onChangedCallback: (String? value) {
                setState(() {
                  // widget.setPaymentSetting(value);
                  _paymentSettingInput = value;
                });
              },
              value: _paymentSettingInput,
              values: _paymentSettingOptions,
            ),

            // commented line is Credit Card Fields. also uncomment "Credit Card" in lib/widget/non_feature_widgets/dropdownMenu/dropdown_listvalues.dart
            // _paymentSettingInput == _paymentSettingOptions.first ? _bankTransferFields() : _creditCardFields(),
            _bankTransferFields(),

            CustomTextField(
              fieldName: billingCompanyNameText,
              myController: _billingCompanyNameControl,
              validator: (val) {
                return ValidateFunc.requiredField(val);
              },
            ),

            CustomTextField(
              fieldName: accountPayEmailText,
              myController: _accountPayEmailControl,
              validator: (val) {
                return ValidateFunc.emailValidate(val);
              },
            ),

            CustomTextField(
              fieldName: accountReceiveEmailText,
              myController: _accountReceiveEmailControl,
              validator: (val) {
                return ValidateFunc.emailValidate(val);
              },
            ),

            Padding(padding: EdgeInsets.only(top: _buttonPadding)),

            FractionallySizedBox(
              widthFactor: _createAccountButtonWidth,
              child: ElevatedButton(
                onPressed: () {
                  _submitFields();
                },
                child: Text(createAccountButtonText),
              ),
            ),
          ],
        ));
  }

  /* **********************************************************************
      Function Name:  Widget _creditCardFields
      Input Parameters:
      None
      Output Parameter:
      Column - all widgets that make up the Credit Card Fields
      Description :
      All widgets that make up the Credit Card Fields
   *************************************************************************/
  Widget _creditCardFields() {
    return Column(
      children: [
        CustomTextField(
          // readOnly: _enableCreditCardFields,
          fieldName: creditCardNumberText,
          myController: _creditCardNumberControl,
          inputFormatters: [InputFormatter.getNumOnlyInput()],
          validator: (val) {
            return ValidateFunc.requiredField(val);
          },
        ),
        CustomTextField(
          // readOnly: _enableCreditCardFields,
          fieldName: cardholderNameText,
          myController: _cardholderNameControl,
          validator: (val) {
            return ValidateFunc.requiredField(val);
          },
        ),
        CustomDropDown(
          name: expirationMonthText,
          onChangedCallback: (String? value) {
            setState(() {
              _expirationMonthInput = value;
              // widget.setExpirationMonth(value);
            });
          },
          value: _expirationMonthInput,
          values: _expirationMonthOptions,
        ),
        CustomDropDown(
          name: expirationYearText,
          onChangedCallback: (String? value) {
            setState(() {
              // widget.setExpirationYear(value);
              _expirationYearInput = value;
            });
          },
          value: _expirationYearInput,
          values: _expirationYearOptions,
        ),
        CustomTextField(
          // readOnly: _enableCreditCardFields,
          fieldName: addressFieldText,
          myController: _addressControl,
          validator: (val) {
            return ValidateFunc.requiredField(val);
          },
        ),
        CustomTextField(
          // readOnly: _enableCreditCardFields,
          fieldName: cityFieldText,
          myController: _cityControl,
          validator: (val) {
            return ValidateFunc.requiredField(val);
          },
        ),
        Row(children: [
          Expanded(
            child: CustomDropDown(
              name: stateFieldText,
              onChangedCallback: (String? value) {
                setState(() {
                  // widget.setStateField(value);
                  _stateFieldInput = value;
                });
              },
              value: _stateFieldInput,
              values: _stateOptions,
            ),
          ),
          Expanded(
            child: CustomTextField(
              // readOnly: _enableCreditCardFields,
              fieldName: zipcodeFieldText,
              myController: _zipcodeControl,
              inputFormatters: [InputFormatter.getNumOnlyInput()],
              validator: (val) {
                return ValidateFunc.requiredField(val);
              },
            ),
          ),
          Padding(padding: EdgeInsets.only(right: _zipRightPadding)),
          Expanded(
            child: CustomTextField(
              // readOnly: _enableCreditCardFields,
              fieldName: countryFieldText,
              myController: _countryControl,
              validator: (val) {
                return ValidateFunc.requiredField(val);
              },
            ),
          ),
        ]),
      ],
    );
  }

  /* **********************************************************************
      Function Name:  Widget _bankTransferFields
      Input Parameters:
      None
      Output Parameter:
      Column - all widgets that make up the Bank Transfer Fields
      Description :
      All widgets that make up the Bank Transfer Fields
   *************************************************************************/
  Widget _bankTransferFields() {
    return Column(
      children: [
        CustomTextField(
          fieldName: bankAccountNumberText,
          myController: _bankAccountNumberControl,
          inputFormatters: [InputFormatter.getNumOnlyInput()],
          validator: (val) {
            if(!_existingUser.getExistingUser()) {
              return ValidateFunc.requiredField(val);
            return null;
            }
            return null;
          },
        ),
        CustomTextField(
          fieldName: bankRoutingNumberText,
          myController: _bankRoutingNumberControl,
          inputFormatters: [InputFormatter.getNumOnlyInput()],
          validator: (val) {
            if(!_existingUser.getExistingUser()) {
              return ValidateFunc.requiredField(val);
            return null;
            }
            return null;
          },
        ),
        CustomDropDown(
          name: bankAccountTypeText,
          onChangedCallback: (String? value) {
            setState(() {
              if(!_existingUser.getExistingUser()) {
                _bankAccountTypeInput = value;
              }
            });
          },
          value: _bankAccountTypeInput,
          values: _bankAccountTypeOptions,
        ),
      ],
    );
  }

  Future<void> _inputVerify() async
  {
    AmplifyAuthentication auth = AmplifyAuthentication();
    return showDialog<void>
    (
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(verifyAlertDialogText),
          content: CustomTextField
            (
            fieldName: verifyCodeText,
            myController: _verifyCodeControl,
            inputFormatters: [InputFormatter.getNumOnlyInput()],
            validator: (val)
            {
                return ValidateFunc.requiredField(val);
            },
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('CANCEL'),
              onPressed: () {
                setState(()
                {
                  auth.deleteUser();
                  Navigator.pop(context);
                });
              },
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                setState(()
                {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      }
    );
  }

  /* **********************************************************************
      Function Name:  Future addAccount
      Input Parameters:
      Map<String, dynamic> body - JSON Map of Account & Credit Details for
                                  the Backend
      String token - authentication token for Amplify
      Output Parameter:
      Response response - JSON response from the backend when Adding Account
                          & Credit Details
      Description :
      Work around to add account & credit details to the Backend with a
      REST API POST call.
   *************************************************************************/
  Future addAccount(Map<String, dynamic> body, String token) async {
    final response = await post(
        Uri.parse(AccountUrls.addAccount()),
        body: jsonEncode(body),
        headers:
        {
          'Authorization': token,
        }
    );
    print("got to repo");
    print(jsonEncode(body));
    if (response.statusCode == 200) {
      return response;
    }
    else
    {
      print("addAccount error ");
      print(response.statusCode);
      print(response.body);
      throw Exception();
    }
  }

  /* **********************************************************************
      Function Name:  void _submitFields
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Sets and Validates Credit Fields when clicking the "Create New
      Account" Button. Also creates and verifies account in the backend.
   *************************************************************************/
  void _submitFields() async {
    print("#### Credit Screen Submitted Fields ####");
    if (_formKey.currentState!.validate())
    {
      print("payment setting: $_paymentSettingInput");
      if (_paymentSettingInput == _paymentSettingOptions.first)
      {
        widget.setPaymentSetting(_paymentSettingInput);
        widget.setBankAccountNumber(_bankAccountNumberControl.text);
        widget.setBankRoutingNumber(_bankRoutingNumberControl.text);
        widget.setBankAccountType(_bankAccountTypeInput);
      }
      else
      {
        print("#### Credit Screen in Credit Card ####");
        widget.setCreditCardNumber(_creditCardNumberControl.text);
        widget.setCardholderName(_cardholderNameControl.text);
        widget.setAddress(_addressControl.text);
        widget.setCity(_cityControl.text);
        widget.setZipcode(_zipcodeControl.text);
        widget.setCountry(_countryControl.text);

        // unsupported atm = show snackbar
        ScaffoldMessenger.of(context).showSnackBar(_creditCardSnackBar);
        return;
      }

      widget.setBillingCompanyName(_billingCompanyNameControl.text);
      widget.setAccountPayEmail(_accountPayEmailControl.text);
      widget.setAccountReceiveEmail(_accountReceiveEmailControl.text);

      _accountSingleton.printAccountInfo();
      widget.printCreditInfo();

      bool isSignedIn = false;
      print("inside credit before login: _isSignedIn: $isSignedIn");

      AmplifyAuthentication auth = AmplifyAuthentication();

      if(!_existingUser.getExistingUser())
      {
        await auth.signUpUser(_accountSingleton.getEmail() as String,
            _accountSingleton.getUsername() as String,
            _accountSingleton.getPassword() as String);
        isSignedIn = await auth.isUserSignedIn();
        print("inside credit: _isSignedIn: $isSignedIn");

        await _inputVerify();
        print("Verification Code: ${_verifyCodeControl.text}");
        auth.confirmUser(_accountSingleton.getUsername() as String, _verifyCodeControl.text);
      }

      await auth.signInUser(_accountSingleton.getEmail() as String, _accountSingleton.getPassword() as String);
      isSignedIn = await auth.isUserSignedIn();

      final token = await auth.getIdToken();
      _verifyCodeControl.text = "";

      // new controller uses JSON and not Object (AccountDetails)
      Map<String, dynamic> creditInfo =
      {
        "accountType": _accountSingleton.getAccountType()!.toUpperCase(),
        "givenName": _accountSingleton.getFirstName(),
        "familyName": _accountSingleton.getLastName(),
        "phoneNum": _accountSingleton.getPhone() as String,
        "payEmail": widget.getAccountPayEmail(),
        "receiveEmail": widget.getAccountReceiveEmail(),
        "payDetails":
        {
          "name": "${_accountSingleton.getFirstName()} ${_accountSingleton.getLastName()}",
          "bankInfo":
          {
            "routingType": "ABA",
            "routingNum": widget.getBankRoutingNumber(),
            "accountType": widget.getBankAccountType()!.toUpperCase(),
            "accountNum": widget.getBankAccountNumber()
          }
        },
        "insuranceDetails":
        {
          "dotNum": "12345678",
          "agent": "Insure America",
          "policyNum": "ABCD1234",
          "policyStart": "2000-01-01",
          "policyEnd": "2030-12-31",
          "liabilityAmount": 1000000,
          "cargoInsureAmount": 1000000
        }
      };

      final accountResponse = await addAccount(creditInfo, token);
      print("accountResponse: status: ${accountResponse.statusCode}"
          "\n response: ${accountResponse.body}");

      if (accountResponse.statusCode == 200)
      {
        print("backend response");
        _existingUser.setExistingUser(false);
        await auth.signOutUser();
        Navigator.pushNamed(context, loginRoute); // will route to login
      }
      else
      {
        print("backend response: failed account creation");
        auth.deleteUser();
      }

      // {
      //   'accountUID': "asdf",
      //   'firstName': _accountSingleton.getFirstName(),
      //   'lastName': _accountSingleton.getLastName(),
      //   'email': _accountSingleton.getEmail(),
      //   'password': _accountSingleton.getPassword(),
      //   'phone': _accountSingleton.getPhone(),
      //   'guarantorFirstName': "none",
      //   'guarantorLastName': "none",
      //   'bankRoutingNumber': widget.getBankRoutingNumber(),
      //   'bankIDType': "none",
      //   'bankAccountNumber': widget.getBankAccountNumber(),
      //   'bankAccountType': widget.getBankAccountType(),
      //   'accountPaymentEmail': widget.getAccountPayEmail(),
      //   'accountReceiveEmail': widget.getAccountReceiveEmail(),
      //   'billingCompanyName': widget.getBillingCompanyName(),
      //   // 'dotNum': _accountSingleton.getDotNumber() ?? "none",
      //   // 'coiAgent': _accountSingleton.getCoiBroker() ?? "none",
      //   // 'coiPolicyNum': _accountSingleton.getCoiPolicyNumber() ?? "none",
      //   // 'coiPolicyEffDate': _accountSingleton.getCoiCoverageDateFrom() ?? "none",
      //   // 'coiPolicyExpDate': _accountSingleton.getCoiCoverageDateTo() ?? "none",
      //   // 'liabilityAmount': _accountSingleton.getLiabilityCoverage() ?? "none",
      //   // 'cargoInsuranceAmount': _accountSingleton.getCargoInsurance() ?? "none",
      //   'dotNum': "none",
      //   'coiAgent': "none",
      //   'coiPolicyNum': "none",
      //   'coiPolicyEffDate': "none",
      //   'coiPolicyExpDate': "none",
      //   'liabilityAmount': "none",
      //   'cargoInsuranceAmount': "none",
      //   'signedW9': "none",
      // };

      // if (event is AccountInitialState)
      // {
      //   print("delivery state initialized");
      // }
      // else if (event is AccountAddedState)
      // {
      //   print("backend response: ${event.result}");
      //   _existingUser.setExistingUser(true);
      //   Navigator.pushNamed(context, loginRoute); // will route to login
      // }
      // else if(event is AccountFailedState)
      // {
      //   print("backend response: failed account creation");
      //   auth.deleteUser();
      // }


      // ControllerInstance().sendtoBlocController([AccountMessage.fromAccountDetails(AccountModel.fromMap(_creditInfo).toEntity()), 'account/add']);

      // listener for JSON msg
      // state = state function like bloc on<>
      // state.result = JSON response data
      // replace DeliveriesStates w/ my Login States
      // Get the stream from the controller provider
      // final controllerStream = ref.read(controllerCurrentStreamProvider);
      // // Listen to the stream and update the UI accordingly
      // final subscription = controllerStream.listen((event)
      // {
      //   if (event is AccountInitialState)
      //   {
      //     print("delivery state initialized");
      //   }
      //   else if (event is AccountAddedState)
      //   {
      //     print("backend response: ${event.result}");
      //     _existingUser.setExistingUser(true);
      //     Navigator.pushNamed(context, loginRoute); // will route to login
      //   }
      //   else if(event is AccountFailedState)
      //   {
      //     print("backend response: failed account creation");
      //     auth.deleteUser();
      //   }
      // });

      // _existingUser.setExistingUser(true);
      // Navigator.pushNamed(context, accountRoute);
      // Navigator.pushNamed(context, loginRoute); // will route to login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_creditSnackBar);
    }
  }

  /* **********************************************************************
      Function Name:  void disposed
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Clean up function for TextEditingController.
   *************************************************************************/
  void disposed() {
    _addressControl.dispose();
    _cityControl.dispose();
    _zipcodeControl.dispose();
    _countryControl.dispose();

    _creditCardNumberControl.dispose();
    _cardholderNameControl.dispose();
    _addressControl.dispose();
    _cityControl.dispose();
    _zipcodeControl.dispose();
    _countryControl.dispose();

    _bankAccountNumberControl.dispose();
    _bankRoutingNumberControl.dispose();

    _billingCompanyNameControl.dispose();
    _accountPayEmailControl.dispose();
    _accountReceiveEmailControl.dispose();
    super.dispose;
  }
}
