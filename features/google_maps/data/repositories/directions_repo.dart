/* **********************************************************************
    File: directions_repo.dart
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
    Handles the parsing of data after calling Google's Directions API.
 *************************************************************************/

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/directions.dart';
import '../../key.dart';

class DirectionsRepo
{
  /* **********************************************************************
      Function Name:  static Future<Directions?> getDirections
      Input Parameters:
      List<LatLng> coordinates - coordinates of our entire route
      Output Parameter:
      Exception
      OR
      Directions nameless - object with data from the JSON response's body
      Description :
      Calls Google's Directions API and on success, returns my Directions
      object with data from the JSON response's body. There are 2 different
      status codes, 1 is the normal JSON/HTTP (200), and 2 is Google's which
      is a field in the JSON/HTTP response's body (OK).

      Issues:
      There is a CORS issue with Google's Directions API call only on web.
      The terminal says its XMLHttpRequest error. Use the following command to
      bypass it. It is also noted Polylines (displaying routing lines) is not
      working on the web.
      Running Web Command:
      flutter run -t lib/main_google_maps.dart -d chrome --web-browser-flag "--disable-web-security"

      Exceptions:
      1. Line 51: When the argument is empty, more than 25, or
                  less than 2 locations.
      2. Line 112: Google response's status was not a success (not a OK status
                  code)
      3. Line 120: JSON response's status was not a success (not a 200 status
                  code)

      *Caution*: Requests using more than 10 waypoints (between 11 and 25),
      or waypoint optimization, are billed at a higher rate.
   *************************************************************************/
  static Future<Directions?> getDirections(List<LatLng> coordinates) async
  {
    const String baseURL = 'https://maps.googleapis.com/maps/api/directions/json?';

    late http.Response response;
    String status;

    if(coordinates.isEmpty || coordinates.length > 25 || coordinates.length < 2)
    {
      // print("DirectionsRepo: getDirections inputted coordinates is empty or over 25 coordinates");
      // return null;
      throw Exception('DirectionsRepo: getDirections input coordinates require at least 2-25 coordinates');
    }

    if(coordinates.length == 2)
    {
      response = await http.get
      (
          Uri.parse(
              '$baseURL'
                  'origin=${coordinates.first.latitude},${coordinates.first.longitude}'
                  '&destination=${coordinates.last.latitude},${coordinates.last.longitude}'
                  '&key=$googleMapsAPIKey')
      );
    }
    else if(coordinates.length > 2)
    {
      String waypoints = "";
      // parse coordinates into waypoint string
      for(int i = 1; i < coordinates.length - 2; i++)
      {
        waypoints += "${coordinates.elementAt(i).latitude.toString()}"
                     ","
                     "${coordinates.elementAt(i).longitude.toString()}"
                     "|";
      }
      waypoints += "${coordinates.elementAt(coordinates.length - 2).latitude.toString()}"
                   ","
                   "${coordinates.elementAt(coordinates.length - 2).longitude.toString()}";


      print("DirectionsRepo: getDirections parsed waypoints: $waypoints");

      response = await http.get
      (
        Uri.parse(
          '$baseURL'
          'origin=${coordinates.first.latitude},${coordinates.first.longitude}'
          '&destination=${coordinates.last.latitude},${coordinates.last.longitude}'
          '&waypoints=$waypoints'
          '&key=$googleMapsAPIKey')
      );
    }

    status = json.decode(response.body)['status'];
    print("DirectionsRepo status: $status");

    if (response.statusCode == 200)
    {
      if(status == "OK")
      {
        print("DirectionsRepo Success: \n"
              "origin: ${coordinates.first}, dest: ${coordinates.last}\n"
              "coordinates: \n$coordinates"
              // "${response.body}\n");
              "");

        return Directions.fromMap(json.decode(response.body));
      }
      else
      {
        throw Exception('DirectionsRepo: getDirections Failed | status: $status | coordinates: $coordinates | \nresponse: ${response.body}');
      }
    }
    else
    {
      // If the request was not successful, throw an error
      throw Exception('DirectionsRepo: getDirections No Response');
    }
  }
}