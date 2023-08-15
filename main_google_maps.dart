/* **********************************************************************
    File: main_google_maps.dart
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
    Main for testing out Google Maps Buttons to show its functionalities
    currently supported.
    Running Web Command:
    flutter run -t lib/main_google_maps.dart -d chrome --web-browser-flag "--disable-web-security"
    There are 3 buttons:
    Top: Displays only markers on the map
    Middle: Displays markers and route on the map
    Middle: Displays markers, route, and user's location on the map
 *************************************************************************/

import 'package:flutter/material.dart';
import '/features/google_maps/data/repositories/geocoding_repo.dart';
import 'package:location/location.dart';
import '/features/google_maps/presentation/screens/buttons_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'features/google_maps/data/models/location_service.dart';

const _sf =  LatLng(37.7777158, -122.4224989);

const  _mountViewAddr = "1600 Amphitheatre Parkway, Mountain View, CA";
const _mustangAddr = '111 Mustang Drive, San Luis Obispo, CA';

const _primeRibAddr = "1906 Van Ness Ave, San Francisco, CA 94109";
const _wholeFoods = "1765 California St, San Francisco, CA 94109";
const _safeway = "1335 Webster St, San Francisco, CA 94115";
const _mensho = "672 Geary St, San Francisco, CA 94102";
const _slo = "1 Grand Ave, San Luis Obispo, CA 93407";

const _sfCity = "San Francisco";
const _state = "CA";
const _primeRibAddress = "1906 Van Ness Ave";
const _primeRibZipcode = "94109";
const _safewayAddress = "1335 Webster St";
const _safewayZipcode = "94115";


const String buttonsRoute = "/buttons";
const String googleMapsMarkers = "/googleMapsMarkers";
const String googleMapsRoute = "/googleMapsRoute";
const String googleMapsGPS = "/googleMapsGPS";

void main()
{
  /* **********************************************************************
      Function Name: runApp
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Function to run the app.
   *************************************************************************/
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  /* **********************************************************************
      Function Name: State<MyApp> createState
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Handles the building & states for the Google Maps Testing Screen
   *************************************************************************/
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  final Map<String, LatLng> _addresses = {};

  /* **********************************************************************
      Function Name: void initState
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Initializing function before Main is built. Initializes what String
      addresses and LatLng coordinates we want to display on the map.
      Enables location service and permissions using location package.
   *************************************************************************/
  @override
  initState()
  {
    super.initState();

    _addresses[_primeRibAddr] = const LatLng(0, 0);
    _addresses[_wholeFoods] = const LatLng(0, 0);
    _addresses[_mensho] = const LatLng(0, 0);
    _addresses[_safeway] = const LatLng(0, 0);

    // _addresses[_slo] = const LatLng(0, 0);

    initCoordinates(_addresses.keys.toSet());

    print("_addresses: $_addresses"
        "Addresses ${_addresses.keys.toSet()}\n"
        "LatLngs: ${_addresses.values.toSet()}");


    LocationService.enableLocation();
  }

  /* **********************************************************************
      Function Name:  Widget build
      Input Parameters:
      BuildContext context - handle to the location of a widget in the
      widget tree
      Output Parameter:
      MaterialApp widget - all widgets that make up the Google Maps Button
      Description :
      Handles the building, states, and routing for the Google Maps Testing
      Screen
   *************************************************************************/
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      initialRoute: buttonsRoute,
      routes:
      {
        buttonsRoute: (context) => ButtonsScreen(googleMapsRoute, _addresses),
      },
    );
  }

  /* **********************************************************************
      Function Name:  void initCoordinates
      Input Parameters:
      Set<String> addresses - String addresses we want to display on the map
      Output Parameter:
      None
      Description :
      Calls Google's Geocoding API to get LatLng coordinates of each address
      in the set of addresses and puts them into a local variable
      Map<String, LatLng> _addresses
   *************************************************************************/
  void initCoordinates(Set<String> addresses)
  {
    for(int i = 0; i < addresses.length; i++)
    {
      GeocodingRepo.getCoordinates(addresses.elementAt(i)).then((coordinates) =>
      {
        setState(()
        {
          _addresses[addresses.elementAt(i)] = coordinates;
        })
      });
    }
  }
}
