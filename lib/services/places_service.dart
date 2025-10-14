import 'dart:convert';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../models/Places/place.dart';
import '../utils/resources.dart';

class PlacesService {

  // Nearby Search function
  Future<List<Place>> searchNearby({
    required double latitude,
    required double longitude,
    required int radius,
    required List<String> types,
    required int maxResultCount,
  }) async {

    final url = Uri.https(Resources.google_places_api_baseurl, 'v1/places:searchNearby');

    final requestBody = {
      "includedTypes": types,
      "maxResultCount": maxResultCount,
      "locationRestriction": {
        "circle": {
          "center": {
            "latitude": latitude,
            "longitude": longitude},
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

      List<Place> places = [];
      data['places'].forEach((v) {
        places.add(Place.fromJson(v));
      });

      return places;
    } else {
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