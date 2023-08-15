/* **********************************************************************
    File: login_state.dart
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
    Event classes for Login that notifies the BLoC for events
 *************************************************************************/

part of 'login_bloc.dart';

// contains the status of the form as well as the username and password input states
class LoginState extends Equatable
{
  /* **********************************************************************
      Function Name:  LoginState
      Input Parameters:
      final FormzStatus status - status of the form
      final Username username - username or email field
      final Password password - password field
      Output Parameter:
      LoginState - Object for the LoginState class
      Description :
      Constructor of the LoginState used to initialize the object.
   *************************************************************************/
  const LoginState
  ({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
  });

  final FormzStatus status;
  final Username username;
  final Password password;

  /* **********************************************************************
      Function Name:  LoginState copyWith
      Input Parameters:
      LoginState - updates the status, username, or password model
      Output Parameter:
      None
      Description :
      Copys BLoC's created models to update the form's fields
   *************************************************************************/
  LoginState copyWith({FormzStatus? status, Username? username, Password? password, int? failCount})
  {
    return LoginState
    (
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}