/* **********************************************************************
    File: nav_state.dart
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
    Handles the states for Nav Button.
 *************************************************************************/
import 'package:flutter/material.dart';
import 'nav_button.dart';

class NavButtonState extends State<NavButton>
{
  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      FractionallySizedBox - all widgets that make up NavButton class
      Description :
      Handles the building & states for the NavButton
   *************************************************************************/
  @override
  Widget build(BuildContext context)
  {
    return FractionallySizedBox
    (
      widthFactor: widget.getWidth(),

      child: ElevatedButton
      (
        onPressed: ()
        {
          Navigator.pushNamed(context, widget.route, arguments: widget.arguments);
        },
        child: Text(widget.text),
      ),
    );
  }
}