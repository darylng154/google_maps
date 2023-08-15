/* **********************************************************************
    File: account_widget_state.dart
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
    Handles the states for account.dart.
 *************************************************************************/

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../../../core/controller/state/controller_state.dart';
import '../../../../../widget/non_feature_widgets/TextFunc.dart';
import '/utilities/formatter.dart';
import '/utilities/strDictionary.dart';
import '/utilities/validators/validation.dart';
import 'account.dart';
import '/widget/non_feature_widgets/button/custom_icon_button.dart';
import '/widget/non_feature_widgets/dropdownMenu/CustomDropDown.dart';
import '/widget/non_feature_widgets/dropdownMenu/dropdown_listvalues.dart';
import '/widget/non_feature_widgets/textField/CustomTextField.dart';
import '/widget/user_singleton/user_singleton.dart';

import 'package:extended_masked_text/extended_masked_text.dart';


double _agreeButtonWidthPerc = 0.4;
double _nextButtonWidth = 0.4;

double _setupBotPadding = 10;
double _zipRightPadding = 2;
double _buttonPadding = 40;
double _coverageDatePadding = 10;

/* **********************************************************************
      Function Name:  final accountMetadataProvider
      Input Parameters:
      Output Parameter:
      controllerState.accountMetadata - metadata for Account's Type
      Description :
      Updates the controller's state to retrieve the account's metadata
      to submit.
   *************************************************************************/
final controllerCurrentStreamProvider = Provider<Stream>((ref) {
  // Get the controller state from the provider
  final controllerState = ref.watch(controllerStateProvider);
  // Retrieve the stream from the controller state
  return controllerState.currentStream;
});

class AccountState extends ConsumerState<Account> {
  final UserSingleton _existingUser = UserSingleton();

  final _formKey = GlobalKey<FormState>();

  double _accountTypePadding = 0;

  final _emailControl = TextEditingController();
  final _usernameControl = TextEditingController();
  final _passwordControl = TextEditingController();
  final _verifyControl = TextEditingController();
  final _firstNameControl = TextEditingController();
  final _lastNameControl = TextEditingController();
  final _phoneControl = MaskedTextController(mask: '(000)-000-0000');
  final _addressControl = TextEditingController();
  final _cityControl = TextEditingController();
  final _zipcodeControl = TextEditingController();
  final _countryControl = TextEditingController();

  // transporter TextController
  final _dotNumberControl = TextEditingController();
  final _coiBrokerControl = TextEditingController();
  final _coiPolicyNumberControl = TextEditingController();
  final _coiCoverageDateFromControl = TextEditingController();
  final _coiCoverageDateToControl = TextEditingController();
  final _liabilityCoverageControl = TextEditingController();
  final _cargoInsuranceControl = TextEditingController();

  final _stateOptions = DropDownVar.getStateList();
  final _accountTypeOptions = DropDownVar.getAccountTypeList();
  final _customerAccountTypeOptions = DropDownVar.getCustomerAccountTypeList();

  String? _accountTypeInput;
  String? _stateFieldInput;
  final bool _bold = true;

  final _accountSnackBar = SnackBar(
    content: Text(accountSnackBarText),
    action: SnackBarAction(
      label: accountSnackBarActionText,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  final _agreeSnackBar = SnackBar(
    content: Text(agreeSnackBarText),
    action: SnackBarAction(
      label: agreeSnackBarActionText,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  final _passwordSnackBar = SnackBar(
    content: Text(passwordSnackBarText),
    action: SnackBarAction(
      label: passwordSnackBarActionText,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  final CustomIconButton _agreeButton = CustomIconButton(
      agreeButtonText,
      const Icon(Icons.check_box_outline_blank_rounded),
      const Icon(Icons.check_box_outline_blank_rounded),
      const Icon(Icons.check_box_outlined),
      width: _agreeButtonWidthPerc);

  /* **********************************************************************
      Function Name: void initState
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Initializing function before Account is built.
   *************************************************************************/
  @override
  void initState() {
    super.initState();

    print("#### Account Screen Existing User ####");
    print("existing user: ${_existingUser.getExistingUser()}");
    print("isPressed: ${_agreeButton.getIsPressed()}");
    print("isPressed True?: ${_agreeButton.getIsPressed() == true}");

    if (!_existingUser.getExistingUser()) {
      _accountTypePadding = 0;

      _stateFieldInput = _stateOptions.first;
      _accountTypeInput = _accountTypeOptions.first;
    } else {
      _accountTypePadding = 10;

      _emailControl.text = widget.getEmail() as String;
      _usernameControl.text = widget.getUsername() as String;
      _passwordControl.text = widget.getPassword() as String;
      _verifyControl.text = widget.getVerify() as String;
      _firstNameControl.text = widget.getFirstName() as String;
      _lastNameControl.text = widget.getLastName() as String;
      _phoneControl.text = widget.getPhone() as String;
      _addressControl.text = widget.getAddress() as String;
      _cityControl.text = widget.getCity() as String;
      _zipcodeControl.text = widget.getZipcode() as String;
      _countryControl.text = widget.getCountry() as String;

      // transporter TextController
      _dotNumberControl.text = widget.getDotNumber() as String;
      _coiBrokerControl.text = widget.getCoiBroker() as String;
      _coiPolicyNumberControl.text = widget.getCoiPolicyNumber() as String;
      _coiCoverageDateFromControl.text = widget.getCoiCoverageDateFrom() as String;
      _coiCoverageDateToControl.text = widget.getCoiCoverageDateTo() as String;
      _liabilityCoverageControl.text = widget.getLiabilityCoverage() as String;
      _cargoInsuranceControl.text = widget.getCargoInsurance() as String;

      _accountTypeInput = widget.getAccountType();
      _stateFieldInput = widget.getStateField();

      _agreeButton.setIsPressed(true);
    }
  }

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      _accountForm - all widgets that make up the Account class
      Description :
      Handles the building & states for the Account
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return _accountForm();
  }

  /* **********************************************************************
      Function Name:  Widget _accountForm
      Input Parameters:
      None
      Output Parameter:
      Form - all widgets that make up the Account Form
      Description :
      All widgets that make up the Account Form
   *************************************************************************/
  Widget _accountForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: _setupBotPadding),
            alignment: Alignment.centerLeft,
            child: TextFunc.printAutoSizeText(accountSetupText),
          ),

          _accountType(_existingUser.getExistingUser()),
          Padding(padding: EdgeInsets.only(bottom: _accountTypePadding)),

          CustomTextField(
            fieldName: emailFieldText,
            myController: _emailControl,
            validator: (val) {
              return ValidateFunc.emailValidate(val);
            },
          ),

          CustomTextField(
            fieldName: usernameFieldText,
            myController: _usernameControl,
            validator: (val) {
              return ValidateFunc.requiredField(val);
            },
          ),

          CustomTextField(
            fieldName: passwordFieldText,
            myController: _passwordControl,
            validator: (val) {
              return ValidateFunc.requiredField(val);
            },
          ),

          CustomTextField(
            fieldName: verifyFieldText,
            myController: _verifyControl,
            validator: (val) {
                return ValidateFunc.requiredField(val);
            },
          ),

          CustomTextField(
            fieldName: firstNameFieldText,
            myController: _firstNameControl,
            validator: (val) {
              return ValidateFunc.requiredField(val);
            },
          ),

          CustomTextField(
            fieldName: lastNameFieldText,
            myController: _lastNameControl,
            validator: (val) {
              return ValidateFunc.requiredField(val);
            },
          ),

          CustomTextField(
            fieldName: phoneFieldText,
            myController: _phoneControl,
            validator: (val) {
              return ValidateFunc.phoneValidate(val);
            },
          ),

          CustomTextField(
            fieldName: addressFieldText,
            myController: _addressControl,
            validator: (val) {
              return ValidateFunc.requiredField(val);
            },
          ),

          CustomTextField(
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
                    _stateFieldInput = value;
                  });
                },
                value: _stateFieldInput,
                values: _stateOptions,
              ),
            ),
            Expanded(
              child: CustomTextField(
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
                fieldName: countryFieldText,
                myController: _countryControl,
                validator: (val) {
                  return ValidateFunc.requiredField(val);
                },
              ),
            ),
          ]),

          _accountTypeInput == _accountTypeOptions[2] ? _transporterFields() : const SizedBox.shrink(),

          Padding(padding: EdgeInsets.only(top: _buttonPadding)),
          _agreeButton,

          Padding(padding: EdgeInsets.only(top: _buttonPadding)),

          FractionallySizedBox(
            widthFactor: _nextButtonWidth,
            child: ElevatedButton(
              onPressed: () {
                _submitFields(_agreeButton);
              },
              child: Text(nextButtonText),
            ),
          ),
        ],
      ),
    );
  }

  /* **********************************************************************
      Function Name:  Widget _transporterFields
      Input Parameters:
      None
      Output Parameter:
      Column - all widgets that make up the Transporter Fields
      Description :
      All widgets that make up the Transporter Fields
   *************************************************************************/
  Widget _transporterFields() {
    return Column(
      children: [
        CustomTextField(
          fieldName: dotNumTextField,
          myController: _dotNumberControl,
          inputFormatters: [InputFormatter.getNumOnlyInput()],
          validator: (val) {
            return ValidateFunc.requiredField(val);
          },
        ),
        CustomTextField(
          fieldName: coiBrokerTextField,
          myController: _coiBrokerControl,
          validator: (val) {
            return ValidateFunc.requiredField(val);
          },
        ),
        CustomTextField(
          fieldName: coiPolicyNumTextField,
          myController: _coiPolicyNumberControl,
          inputFormatters: [InputFormatter.getNumOnlyInput()],
          validator: (val) {
            return ValidateFunc.requiredField(val);
          },
        ),
        Row(children: [
          Expanded(
            child: CustomTextField(
              fieldName: coiCoverageDateFromTextField,
              myController: _coiCoverageDateFromControl,
              validator: (val) {
                return ValidateFunc.requiredField(val);
              },
              onTap: true,
            ),
          ),
          Padding(padding: EdgeInsets.only(right: _coverageDatePadding)),
          Expanded(
            child: CustomTextField(
              fieldName: coiCoverageDateToTextField,
              myController: _coiCoverageDateToControl,
              validator: (val) {
                return ValidateFunc.requiredField(val);
              },
              onTap: true,
            ),
          ),
        ]),
        CustomTextField(
          fieldName: liabilityCoverageTextField,
          myController: _liabilityCoverageControl,
          validator: (val) {
            return ValidateFunc.requiredField(val);
          },
        ),
        CustomTextField(
          fieldName: cargoInsuranceTextField,
          myController: _cargoInsuranceControl,
          validator: (val) {
            return ValidateFunc.requiredField(val);
          },
        ),
      ],
    );
  }

  /* **********************************************************************
      Function Name:  Widget _accountType
      Input Parameters:
      bool existingUser - tells whether a user is logged in or not
      Output Parameter:
      CustomDropDown - all available account type options
      or CustomDropDown - only Customer and Shipper account type options
      or Row - Text of account type
      Description :
      If the current user is not an existing user, all account types are
      available as a Drop Down Menu.
      If the current user is an existing user and a Customer, they can change
      to become a Customer or Shipper.
      Otherwise, the user cannot change the account type.
   *************************************************************************/
  Widget _accountType(bool existingUser)
  {
    print("isLoggedIn: $existingUser \t Account Type: ${widget.getAccountType()}");
    if (!existingUser)
    {
      return CustomDropDown
      (
        name: accountTypeFieldText,
        onChangedCallback: (String? value) {
          setState(() {
            _accountTypeInput = value;
          });
        },
        value: _accountTypeInput,
        values: _accountTypeOptions,
      );
    }
    // if Existing Account & Customer => let them change to Customer or Shipper
    else if (existingUser && widget.getAccountType() == _accountTypeOptions.first)
    {
      return CustomDropDown(
        name: accountTypeFieldText,
        onChangedCallback: (String? value)
        {
          setState(() {
            _accountTypeInput = value;
          });
        },
        value: _accountTypeInput,
        values: _customerAccountTypeOptions,
      );
    }
    else
    {
      return Row
      (
        children:
        [
          TextFunc.printAutoSizeText(accountTypeFieldText, bold: _bold),
          TextFunc.printAutoSizeText(': ', bold: _bold),
          TextFunc.printAutoSizeText(widget.getAccountType() as String),
        ],
      );
    }
  }

  /* **********************************************************************
      Function Name:  void _submitFields
      Input Parameters:
      CustomIconButton _agreeButton
      Output Parameter:
      None
      Description :
      Sets and Validates Account Fields when clicking the "Next" Button.
   *************************************************************************/
  void _submitFields(CustomIconButton agreeButton) {
    print("#### Account Screen Submitted Fields ####");
    // print("isPressed: ${_agreeButton.getIsPressed()}");
    // print("isPressed True?: ${_agreeButton.getIsPressed() == true}");
    if (_formKey.currentState!.validate() && agreeButton.getIsPressed() == true && _passwordControl.text == _verifyControl.text)
    // if (agreeButton.getIsPressed() == true)
    {
      widget.setAccountType(_accountTypeInput);
      widget.setUsername(_usernameControl.text);
      widget.setEmail(_emailControl.text);
      widget.setPassword(_passwordControl.text);
      widget.setVerify(_verifyControl.text);
      widget.setFirstName(_firstNameControl.text);
      widget.setLastName(_lastNameControl.text);
      widget.setPhone(_phoneControl.text);
      widget.setAddress(_addressControl.text);
      widget.setCity(_cityControl.text);
      widget.setStateField(_stateFieldInput);
      widget.setZipcode(_zipcodeControl.text);
      widget.setCountry(_countryControl.text);
      widget.setDotNumber(_dotNumberControl.text);
      widget.setCoiBroker(_coiBrokerControl.text);
      widget.setCoiPolicyNumber(_coiPolicyNumberControl.text);
      widget.setCoiCoverageDateFrom(_coiCoverageDateFromControl.text);
      widget.setCoiCoverageDateTo(_coiCoverageDateToControl.text);
      widget.setLiabilityCoverage(_liabilityCoverageControl.text);
      widget.setCargoInsurance(_cargoInsuranceControl.text);

      widget.printAccountInfo();

      final subscriptionID = ref.read(controllerStateProvider.notifier).createSubscription("account/add");
      Navigator.of(context).pushNamed(creditRoute);
      // Navigator.of(context).pushNamed(creditRoute, arguments: widget);
    } else if (agreeButton.getIsPressed() == false) {
      ScaffoldMessenger.of(context).showSnackBar(_agreeSnackBar);
    }
    else if(_passwordControl.text != _verifyControl.text)
    {
      ScaffoldMessenger.of(context).showSnackBar(_passwordSnackBar);
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(_accountSnackBar);
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
    _emailControl.dispose();
    _usernameControl.dispose();
    _passwordControl.dispose();
    _verifyControl.dispose();
    _firstNameControl.dispose();
    _lastNameControl.dispose();
    _phoneControl.dispose();
    _addressControl.dispose();
    _cityControl.dispose();
    _zipcodeControl.dispose();
    _countryControl.dispose();

    _dotNumberControl.dispose();
    _coiBrokerControl.dispose();
    _coiPolicyNumberControl.dispose();
    _coiCoverageDateFromControl.dispose();
    _coiCoverageDateToControl.dispose();
    _liabilityCoverageControl.dispose();
    _cargoInsuranceControl.dispose();
    super.dispose;
  }
}
