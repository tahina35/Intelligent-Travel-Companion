import 'package:itc/models/preferences.dart';
import 'package:itc/models/activity.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // static Future<Preferences> readData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   int? activity = prefs.getInt('activity');
  //   List<String>? food_preferences = prefs.getStringList('food_preferences');
  //   double? breakfast_start = prefs.getDouble('breakfast_start');
  //   double? breakfast_end = prefs.getDouble('breakfast_end');
  //   double? lunch_start = prefs.getDouble('lunch_start');
  //   double? lunch_end = prefs.getDouble('lunch_end');
  //   double? dinner_start = prefs.getDouble('dinner_start');
  //   double? dinner_end = prefs.getDouble('dinner_end');
  //
  //   return Preferences(
  //       active: prefs.getBool('isSet') ?? false,
  //       foodPreferences: foodPreferences,
  //       activityType: activity,
  //       mealTime: mealTime
  //   );
  //
  // }

  Future<void> removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
  }

  Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

}