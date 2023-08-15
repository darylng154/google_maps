/* **********************************************************************
    File: google_maps_button.dart
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
    Handles the states for GoogleMapsButtons
 *************************************************************************/

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/map_screen.dart';

class GoogleMapsButton extends StatefulWidget
{
  Map<String, LatLng> addresses = {};
  double initialZoom = 14;
  int whichController;

  GoogleMapsButton(this.addresses, this.whichController, {super.key});

  /* **********************************************************************
      Function Name:  State<StatefulWidget> createState
      Input Parameters:
      None
      Output Parameter:
      GoogleMapsButtonState - class that handles the states of the Google Maps
          Button
      Description :
      Handles the building & states for the Google Maps Button
   *************************************************************************/
  @override
  State<StatefulWidget> createState() => GoogleMapsButtonState();
}

class GoogleMapsButtonState extends State<GoogleMapsButton>
{
  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      IconButton - all widgets that make up the Google Maps Button
      Description :
      Handles the building, states, and navigation for the Google Maps Button
   *************************************************************************/
  @override
  Widget build(BuildContext context)
  {
    if(widget.addresses.isEmpty)
    {
      return const CircularProgressIndicator
      (
        color: Colors.white,
      );
    }
    else
    {
      return IconButton
      (
        alignment: Alignment.center,
        icon: Image.asset('assets/images/googleMaps.png'),
        onPressed: ()
        {
          Navigator.of(context).push
          (
              MaterialPageRoute
              (
                builder: (context) =>
                MapScreen(widget.addresses.values.toSet().first,
                    widget.initialZoom,
                    widget.addresses.keys.toList(growable: true),
                    widget.addresses.values.toList(growable: true),
                    whichController: widget.whichController),
              )
          );
        },
      );
    }
  }
}