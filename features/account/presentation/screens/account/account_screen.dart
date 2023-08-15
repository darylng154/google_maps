/* **********************************************************************
    File: account_screen.dart
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
    Builds the screen for account.dart.
 *************************************************************************/

import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../../../../../widget/non_feature_widgets/overlay/widgets/universal_app_bar.dart';
import '../../widget/account/account.dart';
import '/utilities/strDictionary.dart';

double _leftRightPadding = 20;
double _topPadding = 10;

class AccountScreen extends StatelessWidget {
  /* **********************************************************************
      Function Name:  AccountScreen
      Input Parameters:
      None
      Output Parameter:
      AccountScreen - Object for the AccountScreen class
      Description :
      Constructor of the AccountScreen used to initialize the object.
   *************************************************************************/
  const AccountScreen({super.key});

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      Container - all widgets that make up ButtonContainer
      Description :
      Handles the building & states for the AccountScreen.
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(title: accountAppBarText, isAdmin: isAdmin),
      body: Container(
        padding: EdgeInsets.only(
            top: _topPadding,
            bottom: 0,
            left: _leftRightPadding,
            right: _leftRightPadding),
        child: Account(),
      ),
    );
  }
}
