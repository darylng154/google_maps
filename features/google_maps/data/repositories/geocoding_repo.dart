/* **********************************************************************
    File: geocoding_repo.dart
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
    Handles the parsing of data after calling Google's Geocoding API.
 *************************************************************************/

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../key.dart';

class GeocodingRepo
{
  /* **********************************************************************
      Function Name:  static Future<LatLng> getCoordinates
      Input Parameters:
      String address - address we want to get LatLng coordinates of
      Output Parameter:
      LatLng nameless - LatLng object with the address' latitude & longitude
      Description :
      Calls Google's Geocoding API and on success, returns a LatLng object
      with corresponding to that String address from the JSON response's body.
      There are 2 different status codes, 1 is the normal JSON/HTTP (200),
      and 2is Google's which is a field in the JSON/HTTP response's body (OK).
   *************************************************************************/
  static Future<LatLng> getCoordinates(String address) async
  {
    const String baseURL = 'https://maps.googleapis.com/maps/api/geocode/json?';

    final response = await http.get
    (
      Uri.parse(
        '$baseURL'
        'address=$address'
        '&key=$googleMapsAPIKey')
    );

    if (response.statusCode == 200)
    {
      String status = json.decode(response.body)['status'];
      print("GeocodeRepo Success | status: $status");

      if(status == "OK")
      {
        // If the request was successful, parse the JSON
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        List<dynamic> results = jsonResponse['results'];
        Map<String, dynamic> firstResult = results[0];
        Map<String, dynamic> geometry = firstResult['geometry'];
        Map<String, dynamic> location = geometry['location'];

        double latitude = location['lat'];
        double longitude = location['lng'];

        print("Address: $address | LatLng: ($latitude, $longitude)");
        return LatLng(latitude, longitude);
      }
      else
      {
        double latitude = 0.0 ;
        double longitude = 0.0;
        return LatLng(latitude, longitude);
      }
    } 
    else 
    {
        double latitude = 0.0 ;
        double longitude = 0.0;
        return LatLng(latitude, longitude);
    }
  }
}