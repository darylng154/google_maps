/* **********************************************************************
    File: login_event.dart
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

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// notifies the bloc that the username has been modified
class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

// notifies the bloc that the password has been modified.
class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

// notifies the bloc that the form has been submitted.
class LoginSubmitted extends LoginEvent {
  const LoginSubmitted(this.context);

  final BuildContext context;

  @override
  List<Object> get props => [context];
}

// notifies the bloc the screen to route to
class LoginRouteToScreen extends LoginEvent {
  const LoginRouteToScreen(this.context, this.accountType, this.notifier);

  final BuildContext context;
  final String accountType;
  final UserAccountStateNotifier notifier;

  @override
  List<Object> get props => [context, accountType];
}
