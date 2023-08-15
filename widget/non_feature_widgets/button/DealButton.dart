/* **********************************************************************
    File: DealButton.dart
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
    Constructs an ElevatedButton Widget that can toggle On & Off between it's
    Text and Background Color between the On & Off colors.
 *************************************************************************/

import 'package:flutter/material.dart';
import 'DealButtonState.dart';

class DealButton extends StatefulWidget {
  bool _isPressed;
  String _text;
  // String _offText;
  // String _onText;

  double _width;
  double _height;

  Color _textColor;
  Color _bkgndColor;

  Color _offTextColor;
  Color _offBkgndColor;

  Color _onTextColor;
  Color _onBkgndColor;

  /***********************************************************************
      Function Name:  DealButton
      Input Parameters:
      bool _isPressed - On & Off State
      String _text - Text on the DealButton
      double _width - Width of the DealButton
      double _height - Height of the DealButton
      Color _textColor - Text color of the DealButton
      Color _bkgndColor - Current background color of the DealButton
      Color _offTextColor - Text of the DealButton's Off State
      Color _offBkgndColor - Background color of the DealButton's Off State
      Color _onTextColor - Text of the DealButton's On State
      Color _onBkgndColor - Background color of the DealButton's On State
      Output Parameter:
      DealButton - Object for the DealButton class
      Description :
      Constructor of the DealButton used to initialize the DealButton object.
   *************************************************************************/
  DealButton(this._text, this._width, this._height, this._textColor,
      this._bkgndColor, this._onTextColor, this._onBkgndColor,
      {super.key})
      : _isPressed = false,
        _offTextColor = _textColor,
        _offBkgndColor = _bkgndColor;

  /***********************************************************************
      Function Name:  State<StatefulWidget> createState
      Input Parameters:
      None
      Output Parameter:
      DealButtonState - class that handles the states of the DealButton
      Description :
      Handles the building & states for the DealButton
   *************************************************************************/
  @override
  State<StatefulWidget> createState() => DealButtonState();

  bool getIsPressed() {
    return _isPressed;
  }

  void setIsPressed(bool isPressed) => _isPressed = isPressed;

  String getText() {
    return _text;
  }

  void setText(String text) => _text = text;
  double getTextSize() {
    return (_text.length).toDouble();
  }

  // String getOffText() {return _offText;}
  // String setOffText(String text) => _offText = text;
  //
  // String getOnText() {return _onText;}
  // String setOnText(String text) => _onText = text;

  double getWidth() {
    return _width;
  }

  void setWidth(double width) => _width = width;

  double getHeight() {
    return _height;
  }

  void setHeight(double height) => _height = height;

  Color getTextColor() {
    return _textColor;
  }

  void setTextColor(Color color) => _textColor = color;

  Color getBkgndColor() {
    return _bkgndColor;
  }

  void setBkgndColor(Color color) => _bkgndColor = color;

  Color getOnTextColor() {
    return _onTextColor;
  }

  void setOnTextColor(Color color) => _onTextColor = color;

  Color getOnBkgndColor() {
    return _onBkgndColor;
  }

  void setOnBkgndColor(Color color) => _onBkgndColor = color;

  Color getOffTextColor() {
    return _offTextColor;
  }

  void setOffTextColor(Color color) => _offTextColor = color;

  Color getOffBkgndColor() {
    return _offBkgndColor;
  }

  void setOffBkgndColor(Color color) => _offBkgndColor = color;
}
