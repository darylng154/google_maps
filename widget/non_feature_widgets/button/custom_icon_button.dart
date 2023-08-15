/* **********************************************************************
    File: custom_icon_button.dart
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
    Main class for CustomIconButton's Fields, Constructor, and Functions
 *************************************************************************/

import 'package:flutter/material.dart';
import 'custom_icon_button_state.dart';

double _defaultIconSize = 30;

class CustomIconButton extends StatefulWidget
{
  // static bool _isPressed = false;
  // bool isPressed;
  bool _isPressed;
  String text;

  double? width;
  // double? height;  // causes infinite height error

  Color? textColor;
  Color? bkgndColor;

  // double? iconSize;
  Icon icon;
  Icon offIcon;
  Icon onIcon;

  /* **********************************************************************
      Function Name:  CustomIconButton
      Input Parameters:
      bool _isPressed - on and off state
      String text - text on button
      double? width - width factor of button's FractionallySizedBox
      Color? textColor - button's text color
      Color? bkgndColor - button's background color
      Icon icon - icon on the right of the button
      Icon offIcon - icon in the off state
      Icon onIcon - icon in the on state
      Output Parameter:
      CustomIconButton - Object for the CustomIconButton class
      Description :
      Constructor of the CustomIconButton used to initialize the object.
   *************************************************************************/
  CustomIconButton(this.text, this.icon, this.offIcon, this.onIcon, {super.key,  this.width, /*this.height,*/ this.textColor, this.bkgndColor, /*this.iconSize*/})
  :_isPressed = false
  {
    width = width == null ? width = 1 : width = width;
    // this.height = this.height == null ? this.height = 1 : this.height = this.height;
    textColor = textColor == null ? textColor = Colors.white : textColor = textColor;
    bkgndColor = bkgndColor == null ? bkgndColor = Colors.green : bkgndColor = bkgndColor;

    // this.iconSize = this.iconSize == null ? this.iconSize = _defaultIconSize : this.iconSize = this.iconSize;

    // this.icon = this.icon == null ? this.icon = Icon(Icons.check_box_outline_blank_rounded, size: this.iconSize) : this.icon = this.icon;
    // this.offIcon = this.offIcon == null ? this.offIcon = this.icon : this.offIcon = this.offIcon;
    // this.onIcon = this.onIcon == null ? this.onIcon = Icon(Icons.check_box_outlined, size: this.iconSize) : this.onIcon = this.onIcon;
  }

  @override
  State<StatefulWidget> createState() => CustomIconButtonState();

  // static bool getIsPressed() {return _isPressed;}
  bool getIsPressed() {return _isPressed;}
  void setIsPressed(bool isPressed) => _isPressed = isPressed;

  String getText() {return text;}
  void setText(String text) => text = text;
  double getTextSize() {return (text.length).toDouble();}

  double? getWidth() {return width;}
  void setWidth(double? width) => width = width;

  // double? getHeight() {return height;}
  // void setHeight(double? height) => height = height;

  Color? getTextColor() {return textColor;}
  void setTextColor(Color? color) => textColor = color;

  Color? getBkgndColor() {return bkgndColor;}
  void setBkgndColor(Color? color) => bkgndColor = color;

  Icon getIcon() {return icon;}
  void setIcon(Icon icon) => this.icon = icon;

  Icon getOffIcon() {return offIcon;}
  void setOffIcon(Icon offIcon) => this.offIcon = offIcon;

  Icon getOnIcon() {return onIcon;}
  void setOnIcon(Icon onIcon) => this.onIcon = onIcon;
}