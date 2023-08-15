/* **********************************************************************
    File: nav_button.dart
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
    Main class for NavButton's Fields, Constructor, and Functions
 *************************************************************************/
import 'package:flutter/cupertino.dart';
import 'nav_button_state.dart';

class NavButton extends StatefulWidget
{
  String route;
  String text;
  double? width;
  Object? arguments;

  /* **********************************************************************
      Function Name:  NavButton
      Input Parameters:
      String route - route to navigate to
      String text - text on the NavButton
      double? width - width factor of button's FractionallySizedBox
      Object? arguments - data to pass to the routed screen
      Output Parameter - 
      NavButton - Object for the NavButton class
      Description :
      Constructor of the NavButton used to initialize the object.
   *************************************************************************/
  NavButton(this.route, this.text, {super.key, this.width, this.arguments})
  {
    width = width ?? 1;
    arguments = arguments;
  }

  @override
  State<StatefulWidget> createState() => NavButtonState();

  double? getWidth() {return width;}
  void setWidth(double? width) => this.width = width;
}