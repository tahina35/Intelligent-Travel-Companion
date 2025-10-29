import 'package:itc/services/places_service.dart';
import '../models/Places/place.dart';
import 'package:geocoding/geocoding.dart';

import '../models/context.dart';

class RecommenderService {

  final placesService = PlacesService();

  RecommenderService();

  Future<List<Place>> getRecommendations(Context context) async {
     try {

       Location current_location = await placesService.getLocationFromName(context.location + ", Montreal");

       print(current_location.latitude);
       print(current_location.longitude);

       List<Place> nearbyPlaces = await placesService.searchNearby(
         currentLocation: current_location,
         latitude: current_location.latitude,
         longitude: current_location.longitude,
         radius: 1000.0,
       );

       return nearbyPlaces;

     } catch(e) {
       print(e);
       throw Exception('An error occurred: Failed to fetch recommendations.');
     }

  }
}