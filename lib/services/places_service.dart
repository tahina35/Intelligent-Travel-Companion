import 'dart:convert';
import 'dart:convert' as convert;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:http/http.dart' as http;
import '../models/Places/location.dart';
import '../models/Places/place.dart';
import '../utils/resources.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

import 'firebase/firebase_remote_config_service.dart';

class PlacesService {

  const PlacesService();

  // Nearby Search function
  Future<List<Place>> searchNearby({
    required double latitude,
    required double longitude,
    required double radius,
    required geocoding.Location currentLocation,
    required List<String> includedPrimaryTypes
  }) async {

    final url = Uri.https(Resources.google_places_api_baseurl, 'v1/places:searchNearby');

    print(latitude);
    print(longitude);

    final requestBody = {
      "includedPrimaryTypes": includedPrimaryTypes,
      "excludedTypes": Resources.exclude_types,
      "locationRestriction": {
        "circle": {
          "center": {
            "latitude": latitude,
            "longitude": longitude
          },
          "radius": radius
        }
      }
    };

    final response = await http.post(
        url,
        body: json.encode(requestBody),
        headers: {
          'Content-Type': 'application/json',
          "X-Goog-Api-Key": Resources.api_key,
          "X-Goog-FieldMask": Resources.field_mask,
        }
    );

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body) as Map<String, dynamic>;

      final List<Future<Place>> placeFutures = (data['places'] as List).map((v) async {
        Place place = Place.fromJson(v);
        place.distanceMatrix = await getPlaceDistance(currentLocation, place.location!);
        return place;
      }).toList();

      return await Future.wait(placeFutures);
    } else {
      print(response.body);
      throw Exception('HTTP error: ${response.statusCode}');
    }

  }

  Future<geocoding.Location> getLocationFromName(String locationName) async {
    return await geocoding.locationFromAddress(locationName).then((value) => value[0]);
  }

  Future<String> getPlaceDistance(geocoding.Location currentLocation, Location placeLocation) async {

    final url = Uri.https(
        Resources.google_distance_matrix_baseurl,
        'maps/api/distancematrix/json',
        {
          'origins': '${currentLocation.latitude},${currentLocation.longitude}',
          'destinations': '${placeLocation.latitude},${placeLocation.longitude}',
          'units': 'metric',
          'mode': 'walking',
          'key': Resources.api_key
        }
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      return data['rows'][0]['elements'][0]['distance']['text'];
    } else {
      //print(response.body);
      throw Exception('HTTP error: ${response.statusCode}');
    }
  }


  // Get place details
  // Future<Map<String, dynamic>> getPlaceDetails(String placeId) async {
  //   try {
  //     final url = Uri.parse(
  //         '$_baseUrl/details/json?'
  //             'place_id=$placeId'
  //             '&fields=name,formatted_address,rating,opening_hours,photos,price_level,types'
  //             '&key=$_apiKey'
  //     );
  //
  //     final response = await http.get(url);
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       if (data['status'] == 'OK') {
  //         return data['result'];
  //       } else {
  //         throw Exception('Details API error: ${data['status']}');
  //       }
  //     } else {
  //       throw Exception('HTTP error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Place details error: $e');
  //     throw e;
  //   }
  // }

}