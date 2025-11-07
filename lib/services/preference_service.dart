import 'package:itc/models/meal_time.dart';
import 'package:itc/models/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {

  static Future<void> saveData(Preferences data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isSet', true);
    await prefs.setInt('activity', data.activityType.id == 0 ? 3 : data.activityType.id);
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

  static Future<Map<String, dynamic>> readData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      'isSet': prefs.getBool('isSet'),
      'activity': prefs.getInt('activity'),
      'food_preferences': prefs.getStringList('food_preferences'),
      'breakfast_start': prefs.getDouble('breakfast_start'),
      'breakfast_end': prefs.getDouble('breakfast_end'),
      'lunch_start': prefs.getDouble('lunch_start'),
      'lunch_end': prefs.getDouble('lunch_end'),
      'dinner_start': prefs.getDouble('dinner_start'),
      'dinner_end': prefs.getDouble('dinner_end'),
    };
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