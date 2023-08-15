/* **********************************************************************
    File: buttons_screen.dart
    Date: 06-03-2023
    Author: Daryl Ng
    Copyright Information:
    Information contained herein is proprietary to and constitutes valuable
    confidential trade secrets of Top Run , or its licensors, and
    is subject to restrictions on use and disclosure.
    Copyright (c)  2023 Top Run Inc. All rights reserved.
    The copyright notices above do not evidence any actual or
    intended publication of this material.
    Description :
    Screen of GoogleMapsButtons to display my Google Map's Functionality.
    There are 3 buttons:
    Top: Displays only markers on the map
    Middle: Displays markers and route on the map
    Middle: Displays markers, route, and user's location on the map
 *************************************************************************/

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/models/location_service.dart';
import '../widget/google_maps_button.dart';
import '../../../../main_google_maps.dart';

class ButtonsScreen extends StatelessWidget
{
  String route;
  Map<String, LatLng> addresses = {};

  ButtonsScreen(this.route, this.addresses, {super.key});

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      Scaffold widget - all widgets that make up the Button Screen
      Description :
      Handles the building & states for the Button Screen.
   *************************************************************************/
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
      title: const Text('Google Maps'),
      backgroundColor: Colors.green[700],
      ),

      body: Column
      (
        children:
        [
          Expanded
          (
            child: GoogleMapsButton(addresses, 0),
          ),

          Expanded
          (
            child: GoogleMapsButton(addresses, 1),
          ),

          Expanded
          (
            child: GoogleMapsButton(addresses, 2),
          ),
        ],
      )
    );
  }

}