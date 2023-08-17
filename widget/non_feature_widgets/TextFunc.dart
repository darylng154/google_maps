/* **********************************************************************
    File: TextFunc.dart
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
    Handles the functionality and states of Text widgets. States such as
    it's text, color, weight, clipping/wrapping, and overflow.
 *************************************************************************/

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TextFunc {
  /* **********************************************************************
      Function Name:  Text printText
      Input Parameters:
      String str - Text's string
      double size - Text's size
      bool bold - argument to turn on the Text's bold
      Output Parameter:
      Text - Handles the states of the Text widget
      Description :
      Prints regular text widget.
   *************************************************************************/
  static Text printText(String str, double size, bool bold) {
    if (!bold) {
      return Text(
        str,
        style: TextStyle(
          color: Colors.black,
          fontSize: size,
          fontWeight: FontWeight.normal,
        ),
      );
    } else {
      return Text(
        str,
        style: TextStyle(
          color: Colors.black,
          fontSize: size,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  /* **********************************************************************
      Function Name:  Text printNoWrapText
      Input Parameters:
      String str - Text's string
      double size - Text's size
      bool bold - argument to turn on the Text's bold
      Output Parameter:
      Text - Handles the states of the Text widget
      Description :
      Prints text widget with wrapping behavior.
   *************************************************************************/
  static Text printNoWrapText(String str, double size, bool bold) {
    if (!bold) {
      return Text(
        str,
        softWrap: false,
        style: TextStyle(
          color: Colors.black,
          fontSize: size,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.visible,
        ),
      );
    } else {
      return Text(
        str,
        softWrap: false,
        style: TextStyle(
          color: Colors.black,
          fontSize: size,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible,
        ),
      );
    }
  }

  /* **********************************************************************
      Function Name:  Text printNoWrapText
      Input Parameters:
      String str - Text's string
      double size - Text's size
      bool bold - argument to turn on the Text's bold
      Output Parameter:
      Text - Handles the states of the Text widget
      Description :
      Prints text widget with ellipsis clipping behavior.
   *************************************************************************/
  // prints Text with Ellipsis Clipping
  static Text printClippedText(String str, double size, bool bold) {
    if (!bold) {
      return Text(
        str,
        style: TextStyle(
          color: Colors.black,
          fontSize: size,
          fontWeight: FontWeight.normal,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      return Text(
        str,
        style: TextStyle(
          color: Colors.black,
          fontSize: size,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
  }

  // =======================================================================
  //    Function Name:  FractionallySizedBox printAutoSizeText
  //    Input Parameters:
  //    String str - Text's string
  //    double? width - widthFractor of the FractionallySizedBox
  //    double? size - Text's size
  //    bool? bold - argument to turn on the Text's bold
  //    int? maximumLines - Number of lines to print the text
  //    Output Parameter:
  //    Widget FractionallySizedBox - Handles the states of the Text widget
  //    Description :
  //    Prints text by performing an auto size feature. If text size is too
  //     large than a smaller font is used to fit the text.
  // =======================================================================
  static Widget printAutoSizeTextBox(String str,
      {double? width, double? textSize, bool? bold, int? maximumLines}) {
    bold = bold ?? false;
    if (!bold) {
      return FractionallySizedBox(
        widthFactor: width,
        child: AutoSizeText(
          str,
          style: TextStyle(
            color: Colors.black,
            fontSize: textSize ?? 12,
            fontWeight: FontWeight.normal,
          ),
          maxLines: maximumLines ?? 1,
        ),
      );
    } else {
      return FractionallySizedBox(
        widthFactor: width,
        child: AutoSizeText(
          str,
          style: TextStyle(
            color: Colors.black,
            fontSize: textSize,
            fontWeight: FontWeight.bold,
          ),
          maxLines: maximumLines,
        ),
      );
    }
  }

  /* **********************************************************************
      Function Name:  AutoSizeText printAutoSizeText
      Input Parameters:
      String str - Text's string
      double? size - Text's size
      bool? bold - argument to turn on the Text's bold
      int? maximumLines - Number of lines to print the text
      Color? color - color of the text
      Output Parameter:
      AutoSizeText FractionallySizedBox - Handles the states of the Text widget
      Description :
      Prints text by performing an auto size feature. If text size is too
       large than a smaller font is used to fit the text.
   *************************************************************************/
  static AutoSizeText printAutoSizeText(String str,
      {double? size, bool? bold, int? maximumLines, Color? color}) {
    bold = bold ?? false;
    if (!bold) {
      return AutoSizeText(
        str,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 12,
          fontWeight: FontWeight.normal,
        ),
        maxLines: maximumLines ?? 1,
      );
    } else {
      return AutoSizeText(
        str,
        style: TextStyle(
          color: color ?? Colors.black,
          fontSize: size ?? 12,
          fontWeight: FontWeight.bold,
        ),
        maxLines: maximumLines ?? 1,
      );
    }
  }
}
