import 'package:flutter/material.dart';

import 'meal_time.dart';

class MealTimePreferences {

  late MealTime breakfast;
  late MealTime lunch;
  late MealTime dinner;

  MealTimePreferences({
    required this.breakfast,
    required this.lunch,
    required this.dinner
  });

  MealTimePreferences.origin() {
    breakfast = MealTime(icon: Icons.bakery_dining, name: 'Breakfast', start: 7, end: 10);
    lunch = MealTime(icon: Icons.lunch_dining, name: 'Lunch', start: 11, end: 14);
    dinner = MealTime(icon: Icons.dinner_dining, name: 'Dinner', start: 17, end: 20);
  }
}