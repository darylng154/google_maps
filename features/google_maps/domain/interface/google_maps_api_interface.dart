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

 *************************************************************************/

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toprun_application/features/delivery/domain/entities/delivery.dart';

import '/features/google_maps/data/models/directions.dart';
import '/features/google_maps/data/repositories/geocoding_repo.dart';
import '/features/google_maps/data/repositories/directions_repo.dart';

class GoogleMapsAPIInterface
{
  static double pickup_latitude = 0;
  static double pickup_longitude = 0;
  static double dest_latitude = 0;
  static double dest_longitude = 0;
  static double distance = 0;

  /* **********************************************************************
      Function Name:  static String concatAddress
      Input Parameters:
      String address - street of the address
      String city - city of the address
      String state - state of the address
      String zipcode - zipcode of the address
      Output Parameter:
      String nameless - concatenated full address
      Description :
      Concatenates parts of the addresses from the argument and returns
      a completed address.
   *************************************************************************/
  static String concatAddress(String address, String city, String state, String zipcode)
  {
    print("\nFull Address: $address, $city, $state $zipcode\n");
    return "$address, $city, $state $zipcode";
  }

  /* **********************************************************************
      Function Name:  static Future<void> setPickupCoordinates
      Input Parameters:
      String address - street of the address
      String city - city of the address
      String state - state of the address
      String zipcode - zipcode of the address
      Output Parameter:
      None
      Description :
      Calls Google's Geocoding API using the concatenated address given
      in the argument and sets the pickup latitude and longitude.
   *************************************************************************/
  static Future<void> setPickupCoordinates(String address, String city, String state, String zipcode) async
  {
    LatLng coordinates;
    String full_address = concatAddress(address, city, state, zipcode);
    coordinates = await GeocodingRepo.getCoordinates(full_address);
    pickup_latitude = coordinates.latitude;
    pickup_longitude = coordinates.longitude;
  }

  /* **********************************************************************
      Function Name:  static Future<void> setDestCoordinates
      Input Parameters:
      String address - street of the address
      String city - city of the address
      String state - state of the address
      String zipcode - zipcode of the address
      Output Parameter:
      None
      Description :
      Calls Google's Geocoding API using the concatenated address given
      in the argument and sets the destination latitude and longitude.
   *************************************************************************/
  static Future<void> setDestCoordinates(String address, String city, String state, String zipcode) async
  {
    LatLng coordinates;
    String full_address = concatAddress(address, city, state, zipcode);
    coordinates = await GeocodingRepo.getCoordinates(full_address);
    dest_latitude = coordinates.latitude;
    dest_longitude = coordinates.longitude;
  }

  /* **********************************************************************
      Function Name:  static Future<double?> getDistance
      Input Parameters:
      None
      Output Parameter:
      None
      Description :
      Calls Google's Directions API using the pickup and destination latitude
      and longitude. Sets and returns the distance between those two.
   *************************************************************************/
  static Future<double?> getDistance() async
  {
    LatLng pickup = LatLng(pickup_latitude, pickup_longitude);
    LatLng dest = LatLng(dest_latitude, dest_longitude);
    List<LatLng> coordinates = [pickup, dest];

    Directions? route = await DirectionsRepo.getDirections(coordinates);
    distance = route!.distanceToMiles();
    return route.distanceToMiles();
  }

  /* **********************************************************************
      Function Name:  static Future<double?> getDistanceBtwCoordinates
      Input Parameters:
      double current_latitude -
      double current_longitude -
      double end_latitude -
      double end_longitude -
      Output Parameter:
      None
      Description :
      Calls Google's Directions API using the pickup and destination latitude
      and longitude provided in the argument. Returns the distance between
      those two.
   *************************************************************************/
  static Future<double?> getDistanceBtwCoordinates(double current_latitude, double current_longitude,
                                                    double end_latitude, double end_longitude) async
  {
    LatLng current = LatLng(current_latitude, current_longitude);
    LatLng end = LatLng(end_latitude, end_longitude);
    List<LatLng> coordinates = [current, end];

    Directions? route = await DirectionsRepo.getDirections(coordinates);
    print("getDistanceBtwCoordinates | distance: ${route?.distanceToMiles()}");

    return route?.distanceToMiles();
  }

  /* **********************************************************************
      Function Name:  static Future<double?> getDistanceBtwCoordinates
      Input Parameters:
      DeliveryDetails delivery - package/delivery object providing its details
      Output Parameter:
      Map<String, LatLng> addresses - map with the package's pickup and
          destination's address and LatLng associated
      Description :
      Calls Google's Directions API using the pickup and destination latitude
      and longitude provided in the argument. Returns the distance between
      those two.
   *************************************************************************/
  static Map<String, LatLng> getAddresses(DeliveryDetails delivery)
  {
      Map<String, LatLng> addresses = {};
      print("GoogleMapsAPIInterface | getAddresses:");
      String pickup = concatAddress(delivery.shipmentInfo.pickupLocation.address, delivery.shipmentInfo.pickupLocation.city,
          delivery.shipmentInfo.pickupLocation.state, delivery.shipmentInfo.pickupLocation.zipcode);
      String dest = concatAddress(delivery.shipmentInfo.destLocation.address, delivery.shipmentInfo.destLocation.city,
          delivery.shipmentInfo.destLocation.state, delivery.shipmentInfo.destLocation.zipcode);

      addresses[pickup] = LatLng(delivery.shipmentInfo.pickupLocation.latitude, delivery.shipmentInfo.pickupLocation.longitude);
      addresses[dest] = LatLng(delivery.shipmentInfo.destLocation.latitude, delivery.shipmentInfo.destLocation.longitude);
      print("Map<String, LatLng> addresses: \n$addresses");

      return addresses;
  }

  /* **********************************************************************
      Function Name:  static bool isPickupStatus
      Input Parameters:
      DeliveryDetails delivery - package/delivery object providing its details
      Output Parameter:
      bool nameless - if delivery's status is part of pickup
      Description :
      Returns true if delivery's status is part of pickup. Else returns
      false.
   *************************************************************************/
  static bool isPickupStatus(DeliveryDetails delivery)
  {
    // if(delivery.status == "Picked up" || delivery.status == "Verified Pickup")
    if(delivery.status == "Picked up" || delivery.status == "Verified Pickup" || delivery.status == "Available" || delivery.status == "Make Offer" || delivery.status == "Delivered")
    {
      if(delivery.shipmentInfo.pickupLocation.latitude != 0 && delivery.shipmentInfo.destLocation.latitude != 0) {
        return true;
      }
      else
      {
        return false;
      }
    }
    else
    {
      return false;
    }
  }

  /* **********************************************************************
      Function Name:  static bool isDestStatus
      Input Parameters:
      DeliveryDetails delivery - package/delivery object providing its details
      Output Parameter:
      bool nameless - if delivery's status is part of destination
      Description :
      Returns true if delivery's status is part of destination. Else returns
      false.
   *************************************************************************/
  static bool isDestStatus(DeliveryDetails delivery)
  {
    if(delivery.status == "In Route" || delivery.status == "In Contract")
    {
      return true;
    }
    else
    {
      return false;
    }
  }

  /* **********************************************************************
      Function Name:  static Map<String, LatLng> getAddressesFromDeliveryList
      Input Parameters:
      List<DeliveryDetails>? deliveryList - list of package/delivery objects
      Output Parameter:
      Map<String, LatLng> nameless - map of all the addresses and coordinates
                                     part of transporter's route
      Description :
      Returns a map of all the packages' addresses and coordinates that
      the Transporter wants to pickup or deliver based on the list of
      deliveries.
   *************************************************************************/
  static Map<String, LatLng> getAddressesFromDeliveryList(List<DeliveryDetails>? deliveryList)
  {
    Map<String, LatLng> addresses = {};
    print("GoogleMapsAPIInterface | getAddressesFromDeliveryList:");

    if(deliveryList != null)
    {
      for(var delivery in deliveryList)
      {
        if(isPickupStatus(delivery))
        {
          String pickup = concatAddress(delivery.shipmentInfo.pickupLocation.address, delivery.shipmentInfo.pickupLocation.city,
              delivery.shipmentInfo.pickupLocation.state, delivery.shipmentInfo.pickupLocation.zipcode);

          addresses[pickup] = LatLng(delivery.shipmentInfo.pickupLocation.latitude, delivery.shipmentInfo.pickupLocation.longitude);
        }
        else if(isDestStatus(delivery))
        {
          String dest = concatAddress(delivery.shipmentInfo.destLocation.address, delivery.shipmentInfo.destLocation.city,
              delivery.shipmentInfo.destLocation.state, delivery.shipmentInfo.destLocation.zipcode);

          addresses[dest] = LatLng(delivery.shipmentInfo.destLocation.latitude, delivery.shipmentInfo.destLocation.longitude);
        }
      }
    }

    print("Map<String, LatLng> addresses: \n$addresses");
    return addresses;
  }
}