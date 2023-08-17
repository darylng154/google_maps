/* **********************************************************************
    File: ButtonContainer.dart
    Date: 01-14-2023
    Author Daryl Ng
    Copyright Information:
    Information contained herein is proprietary to and constitutes valuable
    confidential trade secrets of Top Run , or its licensors, and
    is subject to restrictions on use and disclosure.
    Copyright (c)  2023 Top Run Inc. All rights reserved.
    The copyright notices above do not evidence any actual or
    intended publication of this material.
    Description :
    Constructs a Container Widget that wraps around the DealButton class.
    To get the overlapping feature, make this class the title of a ListTile
    Widget with onTap.
 *************************************************************************/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toprun_application/features/google_maps/data/models/location_service.dart';
import 'package:toprun_application/features/google_maps/domain/interface/google_maps_api_interface.dart';
import 'package:toprun_application/features/google_maps/presentation/widget/google_maps_button.dart';
import 'package:toprun_application/widget/non_feature_widgets/TextFunc.dart';

import '../../../../features/delivery/domain/entities/delivery.dart';
import 'DealButton.dart';
import 'package:toprun_application/utilities/SafeFunctionConverter.dart';

String _strDollar = "\$";
String _strMiles = " mi @ ";
String _strMiles2 = "/mi";
String _strType = " Package";

double _pkgInfoWidth = 94;
double _pkgInfoBotPadding = 2;
double _dealButtonWidth = 108;
double _dealButtonHeight = 25;
double _offerButtonHeight = 25;
double _buttonLeftPadding = 8;
double _btwButtonsPadding = 7.5;

double _priceSize = 25;
double _textSize = 11;

double _originColWidth = 82;
double _originColLeftPadding = 14;

double _destColWidth = 87;

double _itemHeight = 150;

class ButtonContainer extends StatelessWidget {
  final BuildContext _context;
  final DeliveryDetails _deliveryObj;
  int _index;
  double _offer;
  int _miles;
  String _type;

  final String _pickUpDate;

  final String _origin;
  final String _dest;
  final String _cargo;

  final DealButton _dealButton;
  final DealButton _offerButton;
  final IconButton _mapsButton;

  /* **********************************************************************
      Function Name:  ButtonContainer
      Input Parameters:
      int _index - Index of the ButtonContainer object in the array or map
      double _offer - Package's offer amount
      int _miles - Package's miles for delivery
      String _type - Package's type
      DateTime _pickUpDate - Package's pickup date
      String _origin - Package's origin location
      String _dest - Package's destination location
      String _cargo - Package's cargo company
      DealButton _dealButton - DealButton for selecting the deal
      DealButton _offerButton - DealButton for to make an offer
      IconButton _mapsButton - IconButton for the Google Maps
      Output Parameter:
      ButtonContainer - Object for the ButtonContainer class
      Description :
      Constructor of the ButtonContainer used to initialize the ButtonContainer
      object.
   *************************************************************************/
  ButtonContainer(
      this._context,
      this._deliveryObj,
      this._index,
      this._offer,
      this._miles,
      this._type,
      this._pickUpDate,
      this._origin,
      this._dest,
      this._cargo,
      {super.key})
      : _dealButton = DealButton(
            _context,
            _deliveryObj,
            "Take \$${_offer.toStringAsFixed(2)}",
            _dealButtonWidth,
            _dealButtonHeight,
            Colors.black,
            Colors.green.shade100,
            Colors.white,
            Colors.green),
        _offerButton = DealButton(
            _context,
            _deliveryObj,
            "Make Offer",
            _dealButtonWidth,
            _dealButtonHeight,
            Colors.black,
            Colors.green.shade100,
            Colors.white,
            Colors.green),

        // preferred Button for Maps
        _mapsButton = IconButton(
          alignment: Alignment.bottomRight,
          icon: Image.asset('assets/images/googleMaps.png'),
          onPressed: () {
            // route using google maps
          },
        );

  int getIndex() {
    return _index;
  }

  void setIndex(int index) => _index = index;

  double getOffer() {
    return _offer;
  }

  void setOffer(double offer) => _offer = offer;
  String getOfferText() {
    return _offer.toStringAsFixed(2);
  }

  int getMiles() {
    return _miles;
  }

  void setMiles(int miles) => _miles = miles;
  double getCostPerMiles() {
    return _offer / _miles.toDouble();
  }

  String getType() {
    return _type;
  }

  void setType(String type) => _type = type;

  DealButton getDealButton() {
    return _dealButton;
  }

  DealButton getOfferButton() {
    return _offerButton;
  }

  IconButton getMapsButton() {
    return _mapsButton;
  }

  /***********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      Container - all widgets that make up ButtonContainer
      Description :
      Handles the building & states for the ButtonContainer.
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(width: 1, color: Colors.black),
                right: BorderSide(width: 1, color: Colors.black),
                left: BorderSide(width: 1, color: Colors.black),
                bottom: BorderSide(width: 1, color: Colors.black))),
        height: _itemHeight,
        child: Row(
          children: [
            pkgCol(),
            Expanded(child: originCol()),
            Expanded(child: destCol()),
            buttonsCol(context),
          ],
        ));
  }

  /***********************************************************************
      Function Name:  Widget pkgCol
      Input Parameters:
      None
      Output Parameter:
      Container - all widgets that make up the package info row
      Description :
      Handles all widgets and their states in the in the package info row.
   *************************************************************************/
  Widget pkgCol() {
    return SizedBox(
        width: _pkgInfoWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(1.0),
              child: TextFunc.printText(
                  "$_strDollar${getOfferText()}", _priceSize, true),
            ),

            Container(
              padding: const EdgeInsets.all(1.0),
              child: TextFunc.printText(
                  "${getMiles()}"
                  "$_strMiles"
                  "$_strDollar${getCostPerMiles().toStringAsFixed(2)}"
                  "$_strMiles2",
                  _textSize,
                  false),
            ),

            Container(
              padding: const EdgeInsets.all(1.0),
              child: TextFunc.printText(
                  "${getType()}"
                  "$_strType",
                  _textSize,
                  false),
            ),

            // check index
            // Container
            // (
            //   child: printText(_index.toString(), 15, true),
            // ),
          ],
        ));
  }

  /***********************************************************************
      Function Name:  Widget originCol
      Input Parameters:
      None
      Output Parameter:
      Container - all widgets that make up the origin row
      Description :
      Handles all widgets and their states in the origin row.
   *************************************************************************/
  Widget originCol() {
    DateTime date = SafeFunctionConverter.toStaticDateFormat('MM-dd-yyyy',_pickUpDate);
    return Container(
        width: _originColWidth,
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFunc.printClippedText(_origin, _textSize, false),
            Expanded(
              child: _isToday(date) == true
                  ? TextFunc.printAutoSizeText("Ready Now",
                      size: _textSize, bold: true)
                  : TextFunc.printAutoSizeText(_pickUpDate,
                      size: _textSize, bold: true),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: TextFunc.printNoWrapText(_cargo, _textSize, false),
            ),
          ],
        ));
  }

  /***********************************************************************
      Function Name:  Widget destCol
      Input Parameters:
      None
      Output Parameter:
      Container - all widgets that make up the destination row
      Description :
      Handles all widgets and their states in the destination row.
   *************************************************************************/
  Widget destCol() {
    return SizedBox(
        height: _itemHeight,
        width: _destColWidth,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: TextFunc.printClippedText(_dest, _textSize, false),
              ),

              Container
              (
                alignment: Alignment.bottomRight,
                // padding: const EdgeInsets.all(0),
                child: GoogleMapsButton(GoogleMapsAPIInterface.getAddresses(_deliveryObj), 1),
              ),
            ]));
  }

  /***********************************************************************
      Function Name:  Widget buttonsCol
      Input Parameters:
      None
      Output Parameter:
      Container - all widgets that make up the buttons row
      Description :
      Handles all widgets and their states in the buttons row.
   *************************************************************************/
  Widget buttonsCol(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(5.0),
              child: _dealButton,
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: _offerButton,
            ),
          ]),
    );
  }

  /***********************************************************************
      Function Name:  bool _isToday
      Input Parameters:
      DateTime date - package's available date
      Output Parameter:
      Boolean - true if the date is today, else false
      Description :
      Checks if the date is today and will return true if it is, but false
      if it isn't.
   *************************************************************************/
  bool _isToday(DateTime date) {
    if (date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year) {
      return true;
    } else {
      return false;
    }
  }

  /***********************************************************************
      Function Name:  String _isReady
      Input Parameters:
      DateTime date - package's available date
      Output Parameter:
      String - String that says either the package's available date
      (formatted in Month, Day, Year) or "Ready Now"
      Description :
      Handles what String to return for the package's available date. If the
      date is today, it will return "Ready Now". Otherwise returns the date.
   *************************************************************************/
  String _isReady(DateTime date) {
    if (_isToday(date)) {
      return "Ready Now";
    } else {
      // return date.toString();
      return DateFormat.yMMMd('en_US').format(date);
    }
  }
}
