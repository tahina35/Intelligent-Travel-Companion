import 'package:itc/services/places_service.dart';
import 'package:itc/services/preference_service.dart';
import '../models/Places/place.dart';
import 'package:geocoding/geocoding.dart';
import '../models/Places/types.dart';
import '../models/context.dart';
import '../utils/helper.dart';
import 'activity_service.dart';

class RecommenderService {

  final placesService = PlacesService();
  final preferenceService = PreferenceService();
  final activityService = ActivityService();

  RecommenderService();

  Future<List<Place>> fetchRecommendations(Context context) async {
     try {

       Location current_location = await placesService.getLocationFromName(context.location + ", Montreal");
       List<String> primaryTypes = await _computePrimaryTypes(context);

       List<Place> nearbyPlaces = await placesService.searchNearby(
         currentLocation: current_location,
         latitude: current_location.latitude,
         longitude: current_location.longitude,
         includedPrimaryTypes: primaryTypes,
         radius: 1000.0,
       );

       nearbyPlaces = _scorePlaces(nearbyPlaces, Helper.parseTime(context.time));
       nearbyPlaces.sort((a, b) => b.score.compareTo(a.score));

       return nearbyPlaces;

     } catch(e) {
       print(e);
       throw Exception('An error occurred: Failed to fetch recommendations.');
     }
  }

  Future<List<String>> _computePrimaryTypes(Context context) async {
    List<String> primaryTypeList = [];

    print('Weather: ' + context.weather);
    print('Time: ' + context.time);
    print('Location: ' + context.location);

    List<Types> types = Types.values;
    for(Types type in types) {
      bool isOptimal = _filterTypeByWeather(type, context.weather) && _filterTypeByTime(type, Helper.parseTime(context.time));
      if(isOptimal) {
        print(type.name);
        primaryTypeList.add(type.name);
      }
    }

    return primaryTypeList;
  }

  bool _filterTypeByWeather(Types type, String weather) {
    
    bool isOptimal = false;

    switch(weather.toLowerCase()) {
      case "sunny":
        isOptimal = true;
        break;
      case "clear":
        isOptimal = true;
        break;
      case "partially cloudy":
        isOptimal = true;
        break;
      case "rainy":
        if(type.value == "indoor") {
          isOptimal = true;
        }
        break;
      case "snow":
        if(type.value == "indoor") {
          isOptimal = true;
        }
        break;
    }

    return isOptimal;
  }

  bool _filterTypeByTime(Types type, double time) {
    bool isOptimal = false;
    for(PreferredHours preferredHours in type.preferredHours) {
      if(time >= preferredHours.startHour && time <= preferredHours.endHour) {
        isOptimal = true;
        break;
      } else if(preferredHours.startHour > preferredHours.endHour
                  && (time >= preferredHours.startHour || time <= preferredHours.endHour)) {
        isOptimal = true;
        break;
      }
    }

    return isOptimal;
  }

  List<Place> _scorePlaces(List<Place> places, double time) {
    List<Place> results = [];

    for(Place place in places) {
      if(!_isPlaceValid(place, time)) {
        continue;
      }
      _scorePlaceByPeekHour(place, time);
      _scorePlaceByDistance(place);

      results.add(place);
    }
    return results;
  }

  void _scorePlaceByPeekHour(Place place, double time) {
      for(PeakHours peakHours in place.primaryType.peakHours) {
        if(time >= peakHours.startHour && time <= peakHours.endHour) {
          place.score += 0.2;
          break;
        } else if(peakHours.startHour > peakHours.endHour
                  && (time >= peakHours.startHour || time <= peakHours.endHour)) {
          place.score += 0.2;
          break;
        }
      }
  }

  void _scorePlaceByDistance(Place place) {
    String distance = place.distanceMatrix;
    double distanceValue = double.parse(distance.split(' ')[0]);
    String distanceUnit = distance.split(' ')[1];
    int distanceInMeters = 0;
    if(distanceUnit == "km") {
      distanceInMeters = ((distanceValue * 1000).toInt() <= 500) ?  (distanceValue * 1000).toInt() : 500 ;
    } else if(distanceUnit == "m") {
      distanceInMeters = 0;
    }

    place.score +=  0.25 - (0.05 * (distanceInMeters / 100));

  }

  //to be replaced
  bool _isPlaceValid(Place place, double  time) {
    final photos = place.photos;
    final rating = place.rating;
    final userRatingCount = place.userRatingCount;
    if(photos == null || photos.isEmpty || rating == null || userRatingCount == null || userRatingCount == 0) {
      return false;
    }

    return place.isPlaceOpen(time);
  }
}