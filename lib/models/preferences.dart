import 'package:itc/models/activity_type.dart';

import 'meal_time_preference.dart';


class Preferences {

  final bool active;
  late List<String> foodPreferences;
  late ActivityType activityType;
  late MealTimePreferences mealTime;

  Preferences({
    required this.active,
    required this.foodPreferences,
    required this.activityType,
    required this.mealTime
  });

  Preferences.origin(this.active) {
    foodPreferences = [];
    activityType = ActivityType.origin();
    mealTime = MealTimePreferences.origin();
  }


}