/* **********************************************************************
    File: map_screen.dart
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
    Main class for the Google Maps Screen's Fields, Constructor, and
    Functions
    About whichController: used to tell which Google Maps controller to use
    0: Displays only markers on the map
    1: Displays markers and route on the map
    2: Displays markers, route, and user's location on the map
 *************************************************************************/

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widget/map_screen_state.dart';
import '../../data/models/directions.dart';

class MapScreen extends ConsumerStatefulWidget
{
  LatLng initialCoordinates;
  double initialZoom;
  List<String> addresses;
  Map<String, Marker> markers = {};

  List<LatLng> coordinates;
  Directions? route;
  Polyline? polyline;

  int? whichController = 0;

  LatLng? currentLocation;

  /* **********************************************************************
      Function Name:  MapScreen
      Input Parameters:
      LatLng initialCoordinates - map's starting camera position
      double initialZoom - map's starting zoom
      List<String> addresses - addresses we want to display
      List<LatLng> coordinates - coordinates of the addresses
      int? whichController - which GoogleMaps controller you want to display
                             markers, routes, and user location
      LatLng? currentLocation -
      MapScreen nameless - Object for the Google Maps Screen
      Description :
      Constructor of the Google Maps Screen used to initialize the object.
   *************************************************************************/
  MapScreen(this.initialCoordinates, this.initialZoom, this.addresses, this.coordinates,
      {super.key, this.whichController, this.currentLocation});

  /* **********************************************************************
      Function Name:  ConsumerState<MapScreen> createState
      Input Parameters:
      None
      Output Parameter:
      MapScreenState - class that handles the states of the Google Maps Screen
      Description :
      Handles the building & states for the Google Maps Screen
   *************************************************************************/
  @override
  ConsumerState<MapScreen> createState() => MapScreenState();

  LatLng getCoordinates() {return initialCoordinates;}
  void setCoordinates(LatLng initialCoordinates) => this.initialCoordinates = initialCoordinates;

  double getInitialZoom() {return initialZoom;}
  void setInitialZoom(double initialZoom) => this.initialZoom = initialZoom;

  Map<String, Marker>? getMarkers() {return markers;}
  void setMarkers(Map<String, Marker> markers) => this.markers = markers;
}
