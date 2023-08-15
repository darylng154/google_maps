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
    Model for the Directions Repository.
 *************************************************************************/

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Directions
{
  final LatLngBounds bounds;
  final List<PointLatLng> polylinePoints;
  final double totalDistance;   // in meters
  final int totalDuration;   // in seconds

  const Directions
  (
    this.bounds,
    this.polylinePoints,
    this.totalDistance,
    this.totalDuration,
  );

  /* **********************************************************************
      Function Name:  factory Directions.fromMap
      Input Parameters:
      Map<String, dynamic> responseBody - Map of API's JSON response's body
      Output Parameter:
      Directions object - Directions model with parsed data
      Description :
      Parses data from Google's Direction API into a Directions Object.
      Includes:
      - bounds - Northwest & Southwest bounds of the route
      - polylinePoints - routing points fo the route to display on the screen
      - totalDistance -  total distance of the route to display on the screen
      - totalDuration - total duration of the route to display on the screen
   *************************************************************************/
  factory Directions.fromMap(Map<String, dynamic> responseBody)
  {
    // get route info
    final data = Map<String, dynamic>.from(responseBody['routes'][0]);

    // bounds
    final northeast = data['bounds']['northeast'];
    final southwest = data['bounds']['southwest'];
    final bounds = LatLngBounds
    (
      northeast: LatLng(northeast['lat'], northeast['lng']),
      southwest: LatLng(southwest['lat'], southwest['lng']),
    );

    // polylinePoints
    final polylinePoints = data['overview_polyline']['points'];

    // distance & duration
    num distance = 0;
    num duration = 0;

    if((data['legs'] as List).isNotEmpty)
    {
      for(int i = 0; i < data['legs'].length; i++)
      {
        Map<String, dynamic> legs = data['legs'][i];
        distance += legs['distance']['value'];
        duration += legs['duration']['value'];

        // print("legs[$i]: $legs \n\n");
      }
    }

    print(
        "Bounds: northeast = (${northeast['lat']}, ${northeast['lng']}) | "
         "totalDistance: $distance | "
         "totalDuration: $duration"
    );

    return Directions(bounds, PolylinePoints().decodePolyline(polylinePoints), distance.toDouble(), duration.toInt());
  }

  /* **********************************************************************
      Function Name:  double distanceToMiles
      Input Parameters:
      None
      Output Parameter:
      double nameless - total distance in miles
      Description :
      Converts Directions object's totalDistance from meters to miles
   *************************************************************************/
  double distanceToMiles()
  {
    double factor = 0.00062137;
    return totalDistance * factor;
  }

  /* **********************************************************************
      Function Name:  String durationToString
      Input Parameters:
      None
      Output Parameter:
      String nameless - total duration in hours and minutes
      Description :
      Converts Directions object's totalDuration from seconds to a String
      that tells the hours and minutes
   *************************************************************************/
  String durationToString()
  {
    int duration = totalDuration ~/ 60;
    print("durationToString duration: $duration min | total: $totalDuration sec");

    if(duration >= 60)
    {
      int hour = duration ~/ 60;
      int min = (duration - (hour * 60));
      return "$hour hr $min min";
    }
    else
    {
      return "$duration min";
    }
  }
}