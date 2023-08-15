/* **********************************************************************
    File: credit_screen.dart
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
    Builds the screen for credit.dart.
 *************************************************************************/

import 'package:flutter/material.dart';
import '../../../../../main.dart';
import '../../../../../widget/non_feature_widgets/overlay/widgets/universal_app_bar.dart';
import '/utilities/strDictionary.dart';
import '../../widget/credit/credit.dart';

double _leftRightPadding = 20;
double _topPadding = 10;

class CreditScreen extends StatelessWidget {
  /* **********************************************************************
      Function Name:  CreditScreen
      Input Parameters:
      None
      Output Parameter:
      CreditScreen - Object for the CreditScreen class
      Description :
      Constructor of the CreditScreen used to initialize the object.
   *************************************************************************/
  const CreditScreen({super.key});

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      Container - all widgets that make up CreditScreen
      Description :
      Handles the building & states for the CreditScreen.
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UniversalAppBar(title: creditAppBarText, isAdmin: isAdmin),
      body: Container(
        padding: EdgeInsets.only(
            top: _topPadding,
            bottom: 0,
            left: _leftRightPadding,
            right: _leftRightPadding),
        child: Credit(),
      ),
    );
  }
}
