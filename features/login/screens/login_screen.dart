/* **********************************************************************
    File: login_screen.dart
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
    Builds the screen for login_form.dart.
 *************************************************************************/

// import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '/utilities/strDictionary.dart';
import '/features/login/login.dart';

import '/widget/non_feature_widgets/overlay/overlay.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      Scaffold - all widgets that make up the LoginScreen class
      Description :
      Handles the building & states for the LoginScreen
   *************************************************************************/
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: UniversalAppBar(title: loginButtonText, isAdmin: false),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc();
          },
          child: const LoginForm(),
        ),
      ),
    );
  }
}
