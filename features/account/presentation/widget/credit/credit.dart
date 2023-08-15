/* **********************************************************************
    File: credit.dart
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
    Main class for Credit's Fields, Constructor, and Functions
 *************************************************************************/

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toprun_application/widget/non_feature_widgets/dropdownMenu/dropdown_listvalues.dart';
import 'credit_widget_state.dart';

class Credit extends ConsumerStatefulWidget {
  // credit card fields
  String? paymentSetting;
  String? creditCardNumber;
  String? expirationMonth;
  String? expirationYear;
  String? cardholderName;

  // bank transfer fields
  String? bankAccountNumber;
  String? bankRoutingNumber;
  String? bankAccountType;

  String? address;
  String? city;
  String? state;
  String? zipcode;
  String? country;
  String? billingCompanyName;
  String? accountPayEmail;
  String? accountReceiveEmail;

  static final Credit _creditSingleton = Credit._internal();

  factory Credit() {
    return Credit._creditSingleton;
  }

  /* **********************************************************************
      Function Name:  Credit
      Input Parameters:
      String? accountType - account type field
      String? email - email field
      String? password - password field
      String? verify - verify field
      String? phone - phone field
      String? address - address field
      String? city - city field
      String? state - state field
      String? zipcode - zipcode field
      String? country - country field
      String? dotNumber - dot number field
      String? coiBroker - coi broker field
      String? coiPolicyNumber - coi policy number field
      String? coiCoverageDateFrom - coi coverage date from field
      String? coiCoverageDateTo - coi coverage date to field
      String? liabilityCoverage - liability coverage field
      String? cargoInsurance - cargo insurance field
      Output Parameter:
      Account - Object for the Account class
      Description :
      Constructor of the Account used to initialize the object.
   *************************************************************************/
  Credit._internal();

  /* **********************************************************************
      Function Name:  State<StatefulWidget> createState
      Input Parameters:
      None
      Output Parameter:
      CreditState - class that handles the states for Credit
      Description :
      Handles the building & states for Credit
   *************************************************************************/
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CreditState();

  // credit helper methods
  String? getPaymentSetting() {
    return paymentSetting;
  }

  void setPaymentSetting(String? paymentSetting) =>
      this.paymentSetting = paymentSetting;

  String? getCreditCardNumber() {
    return creditCardNumber;
  }

  void setCreditCardNumber(String? creditCardNumber) =>
      this.creditCardNumber = creditCardNumber;

  String? getExpirationMonth() {
    return expirationMonth;
  }

  void setExpirationMonth(String? expirationMonth) =>
      this.expirationMonth = expirationMonth;

  String? getExpirationYear() {
    return expirationYear;
  }

  void setExpirationYear(String? expirationYear) =>
      this.expirationYear = expirationYear;

  String? getCardholderName() {
    return cardholderName;
  }

  void setCardholderName(String? cardholderName) =>
      this.cardholderName = cardholderName;

  String? getBankAccountNumber() {
    return bankAccountNumber;
  }

  void setBankAccountNumber(String? bankAccountNumber) =>
      this.bankAccountNumber = bankAccountNumber;

  String? getBankRoutingNumber() {
    return bankRoutingNumber;
  }

  void setBankRoutingNumber(String? bankRoutingNumber) =>
      this.bankRoutingNumber = bankRoutingNumber;

  String? getBankAccountType() {
    return bankAccountType;
  }

  void setBankAccountType(String? bankAccountType) =>
      this.bankAccountType = bankAccountType;

  String? getAddress() {
    return address;
  }

  void setAddress(String? address) => this.address = address;

  String? getCity() {
    return city;
  }

  void setCity(String? city) => this.city = city;

  String? getStateField() {
    return state;
  }

  void setStateField(String? state) => this.state = state;

  String? getZipcode() {
    return zipcode;
  }

  void setZipcode(String? zipcode) => this.zipcode = zipcode;

  String? getCountry() {
    return country;
  }

  void setCountry(String? country) => this.country = country;

  String? getBillingCompanyName() {
    return billingCompanyName;
  }

  void setBillingCompanyName(String? billingCompanyName) =>
      this.billingCompanyName = billingCompanyName;

  String? getAccountPayEmail() {
    return accountPayEmail;
  }

  void setAccountPayEmail(String? accountPayEmail) =>
      this.accountPayEmail = accountPayEmail;

  String? getAccountReceiveEmail() {
    return accountReceiveEmail;
  }

  void setAccountReceiveEmail(String? accountReceiveEmail) =>
      this.accountReceiveEmail = accountReceiveEmail;

  void printCreditInfo() {
    if (paymentSetting == DropDownVar.getPaymentSettingList().first) {
      printBankAccountInfo();
    } else {
      printCreditCardInfo();
    }

    print("billing company name: ${getBillingCompanyName()}");
    print("account payment email: ${getAccountPayEmail()}");
    print("account receive email: ${getAccountReceiveEmail()}");
  }

  void printCreditCardInfo() {
    print("payment setting: ${getPaymentSetting()}");
    print("credit card number: ${getCreditCardNumber()}");
    print("credit card name: ${getCardholderName()}");
    print("expiration month: ${getExpirationMonth()}");
    print("expiration year: ${getExpirationYear()}");
    print("credit address: ${getAddress()}");
    print("credit city: ${getCity()}");
    print("credit state: ${getStateField()}");
    print("credit zipcode: ${getZipcode()}");
    print("credit country: ${getCountry()}");
  }

  void printBankAccountInfo() {
    print("bank account number: ${getBankAccountNumber()}");
    print("bank routing number: ${getBankRoutingNumber()}");
    print("bank account type: ${getBankAccountType()}");
  }
}
