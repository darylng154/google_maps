/* **********************************************************************
    File: login_form.dart
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
    Builds the form for login_bloc.dart.
 *************************************************************************/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:toprun_application/core/controller/state/account/user_account_state_notifier.dart';

import '/features/login/login.dart';
import '/utilities/strDictionary.dart';
import '/widget/non_feature_widgets/button/nav_button.dart';

double _textFontSize = 12;
int _textMaxLines = 1;

double _navButtonWidth = 0.4;

int _numTries = 3;

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      BlocListener<LoginBloc, LoginState> - all widgets that make up the 
      LoginForm class with a condition when submission fails
      Description :
      Handles the building & states for the LoginForm and displays a 
      Snackbar when submission fails
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(failSnackBarText)),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // _UsernameRow(),
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
            const Padding(padding: EdgeInsets.all(12)),
            _AccountButton(),
            _LoginRoute(),
          ],
        ),
      ),
    );
  }
}

// notifies the LoginBloc of changes to username/email
class _UsernameInput extends StatelessWidget {
  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      BlocBuilder<LoginBloc, LoginState> - all widgets that make up the 
      Username TextField
      Description :
      Handles the building & states for the Username TextField and notifies
      the LoginBloc of changes to username/email
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: Key(usernameKey),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: emailText,
            errorText: state.username.invalid ? usernameErrorText : null,
          ),
        );
      },
    );
  }
}

// notifies the LoginBloc of changes to password
class _PasswordInput extends StatelessWidget {
  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      BlocBuilder<LoginBloc, LoginState> - all widgets that make up the 
      Password TextField
      Description :
      Handles the building & states for the Password TextField and notifies
      the LoginBloc of changes to password.
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: Key(textFieldPasswordKey),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: passwordText,
            errorText: state.password.invalid ? passwordErrorText : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends ConsumerWidget {
  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      BlocBuilder<LoginBloc, LoginState> - all widgets that make up the 
      Login Button
      Description :
      Handles the building & states for the Login Button and notifies
      the LoginBloc of login submission.
   *************************************************************************/
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: Key(loginButtonKey),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(LoginSubmitted(context));
                      }
                    : null,
                child: Text(loginButtonText),
              );
      },
    );
  }
}

/* **********************************************************************
      Function Name:  final accountMetadataProvider
      Input Parameters:
      Output Parameter:
      controllerState.accountMetadata - metadata for Account's Type
      Description :
      Updates the controller's state to retrieve the account's metadata.
   *************************************************************************/
// final accountMetadataProvider = Provider<Map<String, dynamic>>((ref) {
//   // Get the controller state from the provider
//   final controllerState = ref.watch(controllerStateProvider);
//   // Retrieve the metadata from the controller state
//   return controllerState.accountMetadata;
// });

class _LoginRoute extends ConsumerWidget {
  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      BlocBuilder<LoginBloc, LoginState> - all widgets that make up the
      Login Button
      Description :
      Handles the building & states for the Login Button and notifies
      the LoginBloc of routing to another screen after a login submission
      is successful.
   *************************************************************************/
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // listen to controller's state
    // final accountMetadata = ref.watch(accountMetadataProvider);
    final accountNotifier = ref.read(userAccountStateProvider.notifier);

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        print("Login bloc route");
        print("builder status: ${state.status}");
        if (state.status.isSubmissionSuccess) {
          print("state == SubmissionSuccess");
          // ref.read(userAccountStateProvider.notifier).getUserAccountInfo();
          // final _userAccountState = ref.watch(userAccountProvider);
          // final _accountType = _userAccountState['accountType'];
          // print("accountType: ${_accountType}");
          const accountType = "";

          context
              .read<LoginBloc>()
              .add(LoginRouteToScreen(context, accountType, accountNotifier));
          // context.read<LoginBloc>().add(LoginRouteToScreen(context));
        }

        return state.status.isSubmissionSuccess
            ? const CircularProgressIndicator()
            : const SizedBox.shrink();

        return const SizedBox.shrink();
      },
    );
  }
}

class _AccountButton extends StatelessWidget {
  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      BlocBuilder<LoginBloc, LoginState> - all widgets that make up the 
      Open New Account Button
      Description :
      Handles the building & states for the Open New Account Button and 
      navigates to the Account Screen when clicked.
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return NavButton(accountRoute, accountNavButtonText,
            width: _navButtonWidth);
      },
    );
  }
}
