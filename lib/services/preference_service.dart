import 'package:flutter/material.dart';
import 'package:itc/models/activity_type.dart';
import 'package:itc/models/meal_time.dart';
import 'package:itc/models/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/meal_time_preference.dart';

class PreferenceService {

  static Future<void> saveData(Preferences data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isSet', true);
    await prefs.setInt('activity', data.activityType.id);
    await prefs.setStringList('food_preferences', data.foodPreferences);
    await prefs.setDouble('breakfast_start', data.mealTime.breakfast.start);
    await prefs.setDouble('breakfast_end', data.mealTime.breakfast.end);
    await prefs.setDouble('lunch_start', data.mealTime.lunch.start);
    await prefs.setDouble('lunch_end', data.mealTime.lunch.end);
    await prefs.setDouble('dinner_start', data.mealTime.dinner.start);
    await prefs.setDouble('dinner_end', data.mealTime.dinner.end);
    
  }

  static Future<bool> isPreferenceSet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isSet') ?? false;
  }

  static Future<Preferences> readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final preferences = Preferences(
        active: prefs.getBool('isSet')!,
        activityType: ActivityType.fromId(prefs.getInt('activity')!),
        foodPreferences: prefs.getStringList('food_preferences')!,
        mealTime: MealTimePreferences(
            breakfast : MealTime(
                icon: Icons.bakery_dining,
                name: 'Breakfast',
                start: prefs.getDouble('breakfast_start')!,
                end: prefs.getDouble('breakfast_end')!
            ),
            lunch : MealTime(
                icon: Icons.lunch_dining,
                name: 'Lunch',
                start: prefs.getDouble('lunch_start')!,
                end: prefs.getDouble('lunch_end')!
            ),
            dinner : MealTime(
                icon: Icons.dinner_dining,
                name: 'Dinner',
                start: prefs.getDouble('dinner_start')!,
                end: prefs.getDouble('dinner_end')!
            )
        )
    );

    return preferences;
  }

  Future<void> removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

}