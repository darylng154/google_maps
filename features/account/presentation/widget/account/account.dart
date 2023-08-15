/* **********************************************************************
    File: account.dart
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
    Main class for Account's Fields, Constructor, and Functions
 *************************************************************************/

import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/widget/non_feature_widgets/dropdownMenu/dropdown_listvalues.dart';
import 'account_widget_state.dart';

class Account extends ConsumerStatefulWidget {
  String? accountType;
  String? email;
  String? username;
  String? password;
  String? verify;
  String? firstName;
  String? lastName;
  String? phone;
  String? address;
  String? city;
  String? state;
  String? zipcode;
  String? country;

  // transporter fields
  String? dotNumber;
  String? coiBroker;
  String? coiPolicyNumber;
  String? coiCoverageDateFrom;
  String? coiCoverageDateTo;
  String? liabilityCoverage;
  String? cargoInsurance;

  static final Account _accountSingleton = Account._internal();

  factory Account() {
    return _accountSingleton;
  }

  /* **********************************************************************
      Function Name:  Account._internal
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
  Account._internal();

  /* **********************************************************************
      Function Name:  State<StatefulWidget> createState
      Input Parameters:
      None
      Output Parameter:
      DealButtonState - class that handles the states for Account
      Description :
      Handles the building & states for Account
   *************************************************************************/
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AccountState();

  String? getAccountType() {
    return accountType;
  }

  void setAccountType(String? accountType) => accountType = accountType;

  String? getUsername() {
    return username;
  }

  void setUsername(String? username) => this.username = username;

  String? getEmail() {
    return email;
  }

  void setEmail(String? email) => this.email = email;

  String? getPassword() {
    return password;
  }

  void setPassword(String? password) => this.password = password;

  String? getVerify() {
    return verify;
  }

  void setVerify(String? verify) => this.verify = verify;

  String? getFirstName() {
    return firstName;
  }

  void setFirstName(String? firstname) => firstName = firstname;

  String? getLastName() {
    return lastName;
  }

  void setLastName(String? lastName) => this.lastName = lastName;

  String? getPhone() {
    return phone;
  }

  void setPhone(String? phone) => this.phone = phone;

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

  String? getDotNumber() {
    return dotNumber;
  }

  void setDotNumber(String? dotNumber) => this.dotNumber = dotNumber;

  String? getCoiBroker() {
    return coiBroker;
  }

  void setCoiBroker(String? coiBroker) => this.coiBroker = coiBroker;

  String? getCoiPolicyNumber() {
    return coiPolicyNumber;
  }

  void setCoiPolicyNumber(String? coiPolicyNumber) =>
      this.coiPolicyNumber = coiPolicyNumber;

  String? getCoiCoverageDateFrom() {
    return coiCoverageDateFrom;
  }

  void setCoiCoverageDateFrom(String? coiCoverageDateFrom) =>
      this.coiCoverageDateFrom = coiCoverageDateFrom;

  String? getCoiCoverageDateTo() {
    return coiCoverageDateTo;
  }

  void setCoiCoverageDateTo(String? coiCoverageDateTo) =>
      this.coiCoverageDateTo = coiCoverageDateTo;

  String? getLiabilityCoverage() {
    return liabilityCoverage;
  }

  void setLiabilityCoverage(String? liabilityCoverage) =>
      this.liabilityCoverage = liabilityCoverage;

  String? getCargoInsurance() {
    return cargoInsurance;
  }

  void setCargoInsurance(String? cargoInsurance) =>
      this.cargoInsurance = cargoInsurance;

  void printAccountInfo() {
    print("accountType: ${getAccountType()}");
    print("email: ${getEmail()}");
    print("username: ${getUsername()}");
    print("password: ${getPassword()}");
    print("verify: ${getVerify()}");
    print("firstName: ${getFirstName()}");
    print("lastName: ${getLastName()}");
    print("phone: ${getPhone()}");
    print("address: ${getAddress()}");
    print("city: ${getCity()}");
    print("state: ${getStateField()}");
    print("zipcode: ${getZipcode()}");
    print("country: ${getCountry()}");

    if (accountType == DropDownVar.getAccountTypeList()[2]) {
      printTransporterInfo();
    }
  }

  void printTransporterInfo() {
    print("dotNumber: ${getDotNumber()}");
    print("CoiBroker: ${getCoiBroker()}");
    print("CoiPolicyNumber: ${getCoiPolicyNumber()}");
    print("CoiCoverageDateFrom: ${getCoiCoverageDateFrom()}");
    print("CoiCoverageDateTo: ${getCoiCoverageDateTo()}");
    print("LiabilityCoverage: ${getLiabilityCoverage()}");
    print("CargoInsurance: ${getCargoInsurance()}");
  }
}
