/* **********************************************************************
    File: marker_function.dart
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
    Functions to create and initialize marker object(s)
 *************************************************************************/

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerFunction
{
  /* **********************************************************************
      Function Name:  static Marker initMarker
      Input Parameters:
      String id - Marker's identification
      String address - text that displays when marker is clicked
      LatLng coordinate - where to display the marker
      String title - name of the marker when marker is clicked (above address)
      Output Parameter:
      Marker nameless - Marker object with the above fields initialized
      Description :
      Creates and initializes a Marker object with the corresponding arguments.
   *************************************************************************/
  static Marker initMarker(String id, String address, LatLng coordinate, String title)
  {
    return Marker
    (
      markerId: MarkerId(id),
      position: coordinate,
      infoWindow: InfoWindow
      (
        title: title,
        snippet: address,
      ),
    );
  }

  /* **********************************************************************
      Function Name:  static Map<String, Marker> initMarkers
      Input Parameters:
      List<String> addresses - addresses that we want the markers to display
                              when clicked
      List<LatLng> coordinates - coordinates of where each marker is
      Output Parameter:
      Map<String, Marker> markers - map of all the Markers we want to display
      Description :
      Creates and initializes a Map of makers (wit the key = address & value
      = Marker object corresponding to the address) using the provided
      list of addresses and coordinates as arguments.
   *************************************************************************/
  static Map<String, Marker> initMarkers(List<String> addresses, List<LatLng> coordinates)
  {
    Map<String, Marker> markers = {};

    for(int i = 0; i < coordinates.length; i++)
    {
      LatLng coordinate = coordinates.elementAt(i);
      String address = addresses.elementAt(i);

      Marker marker = initMarker(i.toString(), address, coordinate, MarkerFunction.markerTitle(i, coordinates.length));
      markers[address] = marker;
    }

    return markers;
  }

  /* **********************************************************************
      Function Name:  static String markerTitle
      Input Parameters:
      int index - index of the coordinate in the list
      int length - length of the list
      Output Parameter:
      String nameless - returns "Origin"/"Destination"/ or index as a String
      Description :
      Returns the a String for the title a marker depending on its index.
      If its index is the:
      - 1st, its called Origin
      - Last, its called Destination
      - Anything else, its called it's index
   *************************************************************************/
  static String markerTitle(int index, int length)
  {
    if(index == 0)
    {
      return "Origin";
    }
    else if(index == length - 1)
    {
      return "Destination";
    }

    return index.toString();
  }

  /* **********************************************************************
      Function Name:  static Marker? initCurrentLocationMarker
      Input Parameters:
      LatLng? currentLocation -
      Output Parameter:
      null - argument is null/empty
      OR
      Marker object - initialized Marker for the user's current location
      Description :
      Returns null if the argument is null/empty. Otherwise it will return
      a Marker object for the user's current location.
   *************************************************************************/
  static Marker? initCurrentLocationMarker(LatLng? currentLocation)
  {
    LatLng coordinate;

    if(currentLocation?.latitude == null || currentLocation?.longitude == null)
    {
      return null;
    }
    else
    {
      coordinate = LatLng(currentLocation?.latitude as double, currentLocation?.longitude as double);
    }

    return initMarker("user", "LatLng: ${coordinate.latitude},${coordinate.longitude}", coordinate, "Current Location");
  }
}