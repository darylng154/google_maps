/* **********************************************************************
    File: map_screen_state.dart
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
    Handles the states for Google Maps Screen called MapScreen
    About whichController: used to tell which Google Maps controller to use
    0: Displays only markers on the map
    1: Displays markers and route on the map
    2: Displays markers, route, and user's location on the map
 *************************************************************************/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import 'package:toprun_application/features/google_maps/data/models/location_service.dart';

import '../../data/models/marker_function.dart';
import '../../data/repositories/directions_repo.dart';
import '../../data/repositories/geocoding_repo.dart';
import '../screens/map_screen.dart';

class MapScreenState extends ConsumerState<MapScreen> {
  GoogleMapController? controller;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  StreamSubscription<LocationData>? _locationSubscription;

  // final int _jsonResponse = 60000;
  final int _jsonResponse = 1000;

  /* **********************************************************************
      Function Name: void initState
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Initializing function before MapScreen is built. Throws an exception
      when an unsupported whichController is provided.
   *************************************************************************/
  @override
  initState() {
    super.initState();

    print("MapScreen | currentLocation: ${widget.currentLocation}");
    switch (widget.whichController) {
      case 0:
        initMarker();
        break;

      case 1:
        initRoute();
        break;

      case 2:
        updateCurrentLocation(_jsonResponse);
        initGPS();
        break;

      default:
        throw Exception(
            "Google Maps Screen ${widget.whichController} is not an option for whichController!");
        break;
    }
  }

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      Scaffold widget - all widgets that make up the Google Maps Button
      Description :
      Handles the building & states for the Google Maps Screen
   *************************************************************************/
  @override
  Widget build(BuildContext context) {
    print("MAKING GOOGLE MAP WIDGET!");
    print(
        "route:${widget.route != null} | ${widget.route?.polylinePoints != null}\n"
        "${widget.route?.polylinePoints.map((e) => LatLng(e.latitude, e.longitude)).toList()}");

    // widget.currentLocation = widget.initialCoordinates;
    print("Current Location: widget: ${widget.currentLocation}");
    // print("Marker[user]: ${widget.markers["user"]}");
    // print("Markers: ${widget.markers.values.toSet()}");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps'),
        backgroundColor: Colors.green[700],
      ),
      body: Stack(alignment: Alignment.center, children: [
        GoogleMap(
          key: widget.key,
          initialCameraPosition: CameraPosition(
            target: widget.initialCoordinates,
            zoom: widget.initialZoom,
          ),
          markers: widget.markers.values.toSet(),
          polylines: {widget.polyline = showPolylines()},
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),

        if (widget.route != null) distanceBox()
      ]),
    );
  }

  /* **********************************************************************
      Function Name:  Widget distanceBox
      Input Parameters:
      None
      Output Parameter:
      Positioned widget - all widgets that make up the Distance Box displayed
          at the top of the map
      Description :
      Handles the building for the Distance Box displayed at the top of the map
   *************************************************************************/
  Widget distanceBox() {
    double topPadding = 20;
    double textsize = 12;
    int mileDecimals = 1;

    return Positioned(
      top: topPadding,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(topPadding),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ]),
        child: Text(
          "Distance: ${widget.route!.distanceToMiles().toStringAsFixed(mileDecimals)} mi | Duration: ${widget.route!.durationToString()}",
          style: TextStyle(
            fontSize: textsize,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /* **********************************************************************
      Function Name:  dynamic showPolylines
      Input Parameters:
      None
      Output Parameter:
      Polyline nameless - line that displays the route on the screen
      Description :
      Returns a Polyline object if widget.route is not null/empty. If
      widget.route is empty, that means we will not be displaying any route
      lines.
   *************************************************************************/
  dynamic showPolylines() {
    int width = 5;

    print(
        "showPolylines: route:${widget.route != null} | ${widget.route?.polylinePoints != null}\n"
        "${widget.route?.polylinePoints.map((e) => LatLng(e.latitude, e.longitude)).toList()}");

    if (widget.route != null) {
      print("RETURNING POLYLINE ROUTE");
      return Polyline(
          polylineId: const PolylineId('route'),
          color: Colors.green,
          width: width,
          points: widget.route!.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList());
    }

    return Polyline(
        polylineId: const PolylineId('route'),
        color: Colors.green,
        width: width,
        points: []);
  }

  Future<void> initCoordinates() async {
    for (int i = 0; i < widget.addresses.length; i++) {
      widget.coordinates.add(
          await GeocodingRepo.getCoordinates(widget.addresses.elementAt(i)));
    }
  }

  /* **********************************************************************
      Function Name:  void updateCurrentLocation
      Input Parameters:
      int interval - duration in milliseconds until the next listen
      Output Parameter:
      None
      Description :
      Uses location package to listen and updates widget.currentLocation
      to see if the user's location has changed.
   *************************************************************************/
  void updateCurrentLocation(int interval) {
    Location location = Location();
    location.changeSettings(interval: interval);

    _locationSubscription = location.onLocationChanged.listen((newLocation) {
      setState(() {
        widget.currentLocation = LatLng(
            newLocation.latitude as double, newLocation.longitude as double);
        widget.markers['user'] =
            MarkerFunction.initCurrentLocationMarker(widget.currentLocation)!;
        controller?.animateCamera(
            CameraUpdate.newLatLng(widget.currentLocation as LatLng));
      });
    });
  }

  /* **********************************************************************
      Function Name:  void initMarker
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Initializes the GoogleMaps controller and markers. Takes the list of
      addresses and coordinates to initialize and add markers to the list
      of markers, widget.markers. setState is called to update the widget's
      fields.
   *************************************************************************/
  void initMarker() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = await _controller.future;

      setState(() {
        widget.markers =
            MarkerFunction.initMarkers(widget.addresses, widget.coordinates);
        controller?.animateCamera(CameraUpdate.newLatLng(widget.coordinates.first));
      });
    });
  }

  /* **********************************************************************
      Function Name:  void initRoute
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Initializes the GoogleMaps controller, markers, and route. Takes the
      list of coordinates and calls Google's Directions API for all the
      routing details. Takes the list of addresses and coordinates to
      initialize and add markers to the list of markers, widget.markers.
      setState is called to update the widget's fields.
   *************************************************************************/
  void initRoute() async {
    double zoom = 100;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = await _controller.future;

      widget.route = await DirectionsRepo.getDirections(widget.coordinates);

      setState(() {
        widget.markers =
            MarkerFunction.initMarkers(widget.addresses, widget.coordinates);
        controller?.animateCamera(
            CameraUpdate.newLatLngBounds(widget.route!.bounds, zoom));
      });
    });
  }

  /* **********************************************************************
      Function Name:  void initGPS
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Initializes the GoogleMaps controller, markers, routes, and user's
      current location. Uses location package to get user's current location.
      Takes the list of coordinates and calls Google's Directions API for
      all the routing details. Takes the list of addresses, coordinates,
      and user location to initialize and add markers to the list of markers,
      widget.markers. setState is called to update the widget's fields.
   *************************************************************************/
  void initGPS() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = await _controller.future;

      await LocationService.getCurrentLocation();
      widget.currentLocation = LocationService.currentLocation;

      print("initGPS | before coordinates: ${widget.coordinates}");
      widget.addresses.insert(0, "LatLng(${widget.currentLocation?.latitude},${widget.currentLocation?.longitude})");
      widget.coordinates.insert(0, widget.currentLocation as LatLng);

      print("initGPS | after coordinates: ${widget.coordinates}");
      widget.route = await DirectionsRepo.getDirections(widget.coordinates);

      setState(() {
        widget.markers =
            MarkerFunction.initMarkers(widget.addresses, widget.coordinates);
      });
    });
  }

  /* **********************************************************************
      Function Name:  void disposed
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Clean up function for the Google Maps Screen.
   *************************************************************************/
  @override
  void dispose() {
    super.dispose();
    if(controller != null)
    {
      controller?.dispose();
    }
    _locationSubscription?.cancel();
  }
}
