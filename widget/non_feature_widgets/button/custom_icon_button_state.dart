/* **********************************************************************
    File: custom_icon_button_state.dart
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
    Handles the states for custom_icon_button.dart.
 *************************************************************************/

import 'package:flutter/material.dart';
import 'custom_icon_button.dart';

double _textSize = 12;
double _buttonRightPadding = 28;

class CustomIconButtonState extends State<CustomIconButton>
{
  /* **********************************************************************
      Function Name: void initState
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Initializing function before CustomIconButtonState is built.
   *************************************************************************/
  @override
  void initState()
  {
    super.initState();

    if(widget.getIsPressed())
    {
      widget.setIcon(widget.getOnIcon());
    }
    else
    {
      widget.setIcon(widget.getOffIcon());
    }
  }

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      _accountForm - all widgets that make up the CustomIconButton class
      Description :
      Handles the building & states for the CustomIconButton
   *************************************************************************/
  @override
  Widget build(BuildContext context)
  {
    return Row
    (
      children:
      [
        // Expanded(child: checkbox),
        widget.getIcon(),
        Expanded
        (
          child: FractionallySizedBox
          (
            widthFactor: widget.getWidth(),

            // child: Expanded(
            child: Container
            (
              padding: EdgeInsets.only(right: _buttonRightPadding),
              child: ElevatedButton
              (
                style: ElevatedButton.styleFrom
                (
                  // background color
                  backgroundColor: widget.getBkgndColor(),
                  // text color
                  foregroundColor: widget.getTextColor(),
                  shape: RoundedRectangleBorder
                  (
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide
                    (
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),

                onPressed:()
                {
                  _toggleButton();
                },

                child: Text
                (
                  widget.getText(),
                  // allows Text to go outside of Button but is not centered
                  // softWrap: false,
                  // style: const TextStyle
                  // (
                  //   overflow: TextOverflow.visible
                  // ),
                  style: TextStyle
                  (
                    fontSize: _textSize,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /* **********************************************************************
      Function Name:  void _toggleButton
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Toggles isPressed, offIcon, and onIcon fields for the CustomIconButton
   *************************************************************************/
  void _toggleButton()
  {
    // print("inside button: ${widget.getIsPressed()}");
    // print("inside button, icon: ${widget.getIcon()}");
    // print("inside button, offIcon: ${widget.offIcon}");
    // print("inside button, onIcon: ${widget.onIcon}");

    setState(()
    {
      // if(CustomIconButton.getIsPressed())
      if(widget.getIsPressed())
      {
        widget.setIcon(widget.getOffIcon());
        widget.setIsPressed(false);
      }
      else
      {
        widget.setIcon(widget.getOnIcon());
        widget.setIsPressed(true);
      }
    });
  }
}