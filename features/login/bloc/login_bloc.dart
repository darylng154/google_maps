/* **********************************************************************
    File: login_bloc.dart
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
    BLoC class for Login that updates the username or password model or 
    submits the login information
 *************************************************************************/

// import 'package:authentication_repository/authentication_repository.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

// import 'dart:js' as js;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';
import 'package:toprun_application/features/account/domain/entities/optional/metadata_info.dart';
import 'package:toprun_application/features/account/presentation/bloc/account_state.dart';

import '/core/config/authentication.dart';
import '/core/controller/my_isolates.dart';
import '/features/account/data/account_urls.dart';
import '/features/login/login.dart';
import '/utilities/strDictionary.dart';
import '../../../core/controller/state/account/user_account_state_notifier.dart';
import '../../../widget/user_singleton/user_singleton.dart';

part 'login_event.dart';
part 'login_state.dart';

String _shipperEmail = "shipper@toprunapp.com";
String _transporterEmail = "transporter@toprunapp.com";
String _dispatcherEmail = "dispatcher@toprunapp.com";
String _employeeEmail = "employee@toprunapp.com";

String _password = "password";

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginRouteToScreen>(_onRouteToScreen);
  }

  final int _numTries = 3;
  int _count = 0;

  /* **********************************************************************
      Function Name:  void _onUsernameChanged
      Input Parameters:
      LoginUsernameChanged event
      Output Parameter:
      None
      Description :
      Creates username model and updates the form's password field
   *************************************************************************/
  void _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([state.password, username]),
      ),
    );
  }

  /* **********************************************************************
      Function Name:   void _onPasswordChanged
      Input Parameters:
      LoginUsernameChanged event
      Output Parameter:
      None
      Description :
      Creates password model and updates the form's password field
   *************************************************************************/
  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.username]),
      ),
    );
  }

/* **********************************************************************
      Function Name:   Future<void> _onSubmitted
      Input Parameters:
      LoginUsernameChanged event
      Output Parameter:
      None
      Description :
      If the current status of the form is valid, bloc makes a call to login.
      There were issues with getting the app to close on web using other
      API calls for the 4 failed login attempts. Currently only closes app
      on Android. Makes Amplify call to login and enables the existing
      user features in the UserSingleton.
   *************************************************************************/
  Future<void> _onSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        UserSingleton existingUser = UserSingleton();
        AmplifyAuthentication auth = AmplifyAuthentication();
        existingUser.setExistingUser(false);

        print(
            'inside login bloc: username: ${state.username.value}\tpassword: ${state.password.value}');
        await auth.signInUser(state.username.value, state.password.value);
        existingUser.setExistingUser(await auth.isUserSignedIn());
        print(
            "inside login bloc: _isSignedIn: ${existingUser.getExistingUser()}");
        // await auth.getCurrentUser();
        // await auth.signOutUser();
        // _isSignedIn = await auth.isUserSignedIn();
        // print("inside login bloc: _isSignedIn: $_isSignedIn");

        // if ((state.username.value == _shipperEmail ||
        //             state.username.value == _transporterEmail ||
        //             state.username.value == _dispatcherEmail ||
        //             state.username.value == _employeeEmail) &&
        //         state.password.value == _password ||
        //     _existingUser.getExistingUser())
        if (existingUser.getExistingUser()) {
          print("login success");
          // auth.deleteUser();
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        } else {
          if (_count >= _numTries) {
            // failed attempts to close on web
            // js.context.callMethod('close');
            // SystemNavigator.pop();
            // window.close();
            exit(0); // android works
          } else {
            _count++;
          }

          print("login failed");
          print("count: $_count");
          emit(state.copyWith(status: FormzStatus.submissionFailure));
        }
      } catch (_) {
        if (_count >= _numTries) {
          // js.context.callMethod('close');
          // SystemNavigator.pop();
          // window.close();
          exit(0);
        } else {
          _count++;
        }

        print("login failed");
        print("count: $_count");
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  /* **********************************************************************
      Function Name:  Future getAccount
      Input Parameters:
      String token - authentication token for Amplify
      Output Parameter:
      Response response - JSON response from the backend when Adding Account
                          & Credit Details
      Description :
      Work around to get account & credit details from the Backend with a
      REST API GET call.
   *************************************************************************/
  Future getAccount(String token) async {
    final response = await get(Uri.parse(AccountUrls.getAccount()), headers: {
      'Authorization': token,
    });
    print("got to repo");
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    } else {
      print("getAccount error ");
      print(response.statusCode);
      print(response.body);
      throw Exception();
    }
  }

  /* **********************************************************************
      Function Name:   Future<void> _onRouteToScreen
      Input Parameters:
      LoginUsernameChanged event
      Output Parameter:
      None
      Description :
      If the current status of the form is submitted successfully, bloc
      makes a call to change screens. Gets the login token to get the
      account type from the backend.
   *************************************************************************/
  void _onRouteToScreen(
      LoginRouteToScreen event, Emitter<LoginState> emit) async {
    print(
        'inside_onRouteToScreen: username: ${state.username.value}\tpassword: ${state.password.value}');

    AmplifyAuthentication auth = AmplifyAuthentication();
    final token = await auth.getIdToken();
    // Add a one-shot listener here to wait for the token to be available
    MetadataInfo metadata;
    event.notifier.getUserAccountInfo(token);
    event.notifier.accountStream.listen((response) {
      if (response is AccountLoadedState) {
        final message = response.result;
        metadata = MetadataInfo.fromMap(message['metadata']);
        print(
            "accountResponse: $metadata | accountType: ${message['metadata']['accountType']}");
        ControllerInstance().addMetadataInfo(metadata);
        final accountType = metadata.accountType;
        // if ((state.username.value == _shipperEmail && state.password.value == _password) || _accountType == "SHIPPER" || _accountType == "CUSTOMER")
        if (accountType == "SHIPPER" || accountType == "CUSTOMER") {
          Navigator.pushNamed(event.context, shipperRoute);
        }
        // else if ((state.username.value == _transporterEmail && state.password.value == _password) || _accountType == "TRANSPORTER")
        else if (accountType == "TRANSPORTER") {
          Navigator.pushNamed(event.context, transporterRoute);
        } else if (accountType == "DISPATCHER")
        // else if ((state.username.value == _dispatcherEmail && state.password.value == _password) || _accountType == "DISPATCHER")
        {
          Navigator.pushNamed(event.context, dispatcherRoute);
        }
        // else if ((state.username.value == _employeeEmail && state.password.value == _password) || _accountType == "EMPLOYEE")
        else if (accountType == "EMPLOYEE") {
          Navigator.pushNamed(event.context, employeeRoute);
        }
      }
    });
    // MetadataInfo metadata = MetadataInfo.fromMap(accountResponse['metadata']);
    emit(state.copyWith(status: FormzStatus.valid));
    // print(
    //     "accountResponse: $accountResponse | accountType: ${accountResponse['metadata']['accountType']}");
    // final _accountType = accountResponse['metadata']['accountType'];

    // attempt to connect with the controller
    // final _accountInfo = AccountDetails
    // (
    //   accountUID: null,
    //   firstName: "",
    //   lastName: "",
    //   email: state.username.value,
    //   password: state.password.value,
    //   phone: "",
    //   guarantorFirstName: "",
    //   guarantorLastName: "",
    //   bankRoutingNumber: "",
    //   bankIDType: "",
    //   bankAccountNumber: "",
    //   bankAccountType: "",
    //   accountPaymentEmail: "",
    //   accountReceiveEmail: "",
    //   billingCompanyName: "",
    //   dotNum: "",
    //   coiAgent: "",
    //   coiPolicyNum: "",
    //   coiPolicyEffDate: "",
    //   coiPolicyExpDate: "",
    //   liabilityAmount: "",
    //   cargoInsuranceAmount: "",
    //   signedW9: "",
    // );

    // StreamController streamController = StreamController.broadcast();
    // if (ControllerInstance().blocIsReady) {
    //   ControllerInstance().subscribeToBlocController('account/get', streamController);
    //   streamController.stream.listen((response) {
    //     if (response is AccountLoadedState) {
    //       print('UserAccountStateNotifier: ${response.result}');
    //     } else if (response is AccountFailedState) {
    //       print('UserAccountStateNotifier: ${response.message}');
    //     }
    //   });
    // ControllerInstance().sendtoBlocController(['account/get', _accountInfo]);

    // listener for JSON msg
    // state = state function like bloc on<>
    // state.result = JSON response data
    // replace DeliveriesStates w/ my Login States
    // subscribeToController('account/login', (state)
    // {
    //   if (state is AccountInitialState)
    //   {
    //     print("delivery state initialized");
    //   }
    //   else if (state is AccountAddedState)
    //   {
    //     print("backend response: ${state.result}");
    //     Navigator.pushNamed(event.context, loginRoute); // will route to login
    //   }
    //   else if(state is AccountFailedState)
    //   {
    //     print("backend response: failed account creation");
    //   }
    // });

    // // if ((state.username.value == _shipperEmail && state.password.value == _password) || _accountType == "SHIPPER" || _accountType == "CUSTOMER")
    // if (_accountType == "SHIPPER" || _accountType == "CUSTOMER") {
    //   Navigator.pushNamed(event.context, shipperRoute);
    // }
    // // else if ((state.username.value == _transporterEmail && state.password.value == _password) || _accountType == "TRANSPORTER")
    // else if (_accountType == "TRANSPORTER") {
    //   Navigator.pushNamed(event.context, transporterRoute);
    // } else if (_accountType == "DISPATCHER")
    // // else if ((state.username.value == _dispatcherEmail && state.password.value == _password) || _accountType == "DISPATCHER")
    // {
    //   Navigator.pushNamed(event.context, dispatcherRoute);
    // }
    // // else if ((state.username.value == _employeeEmail && state.password.value == _password) || _accountType == "EMPLOYEE")
    // else if (_accountType == "EMPLOYEE") {
    //   Navigator.pushNamed(event.context, employeeRoute);
    // }
    //
    // emit(state.copyWith(status: FormzStatus.valid));
  }
}
