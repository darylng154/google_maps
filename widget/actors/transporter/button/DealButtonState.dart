/***********************************************************************
    File: DealButtonState.dart
    Date: 01-16-2023
    Author Daryl Ng
    Copyright Information:
    Information contained herein is proprietary to and constitutes valuable
    confidential trade secrets of Top Run , or its licensors, and
    is subject to restrictions on use and disclosure.
    Copyright (c)  2023 Top Run Inc. All rights reserved.
    The copyright notices above do not evidence any actual or
    intended publication of this material.
    Description :
    Handles the toggling of the On & Off states of the DealButton.
 *************************************************************************/

import 'package:flutter/material.dart';
import 'DealButton.dart';

String buttonText1 = "Button 1 Here";
String buttonText2 = "Button 2 Here";

double _textSize = 12;

class DealButtonState extends State<DealButton> {
  /***********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      SizedBox - all widgets that make up DealButton
      Description :
      Handles the building & states for the DealButton
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.getWidth(),
      height: widget.getHeight(),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // background color
          backgroundColor: widget.getBkgndColor(),
          // text color
          foregroundColor: widget.getTextColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
        ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
        onPressed: () {
          _toggleButton();
        },
        child: Text(
          widget.getText(),
          // allows Text to go outside of Button but is not centered
          // softWrap: false,
          // style: const TextStyle
          // (
          //   overflow: TextOverflow.visible
          // ),
          style: TextStyle(
            fontSize: _textSize,
          ),
        ),
      ),
    );
  }

  /***********************************************************************
      Function Name:  _toggleButton
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Toggles the Text, Background Color, and isPressed field when the
      DealButton is pressed.
   *************************************************************************/
  void _toggleButton() {
    setState(() {
      if (widget.getIsPressed()) {
        widget.setTextColor(widget.getOffTextColor());
        widget.setBkgndColor(widget.getOffBkgndColor());
        widget.setIsPressed(false);
      } else {
        widget.setTextColor(widget.getOnTextColor());
        widget.setBkgndColor(widget.getOnBkgndColor());
        widget.setIsPressed(true);
      }
    });
  }
}
