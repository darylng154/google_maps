/* **********************************************************************
    File: directions.dart
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
    Functions from the Location Package that provides location services
 *************************************************************************/

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationService
{
  static LatLng currentLocation = const LatLng(0,0);
  // static late LatLng currentLocation;

  /* **********************************************************************
      Function Name:  static Future<void> enableLocation() async
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Checks to see if service & permission is enabled to use location
      services. If they are not, it will prompt and ask for permission.

      *IMPORTANT* I noticed if the user has disabled permissions, it will
      not prompt and ask for permission
   *************************************************************************/
  static Future<void> enableLocation() async
  {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied)
    {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  /* **********************************************************************
      Function Name:  static Future<void> enableLocation() async
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Gets the user's current location and sets it to a local variable
   *************************************************************************/
  // works but could not get the map initialized with currentLocation due to build() issues
  static Future<void> getCurrentLocation() async
  {
    Location location = Location();

    LocationData data = await location.getLocation();
    currentLocation = LatLng(data!.latitude as double, data!.longitude as double);
  }
}