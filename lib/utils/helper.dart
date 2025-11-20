import 'package:flutter/cupertino.dart';
import 'package:itc/models/Places/regular_opening_hours.dart';

class Helper {

  static String formatTime(double hourValue) {
    int hour = hourValue.floor();
    int minute = ((hourValue - hour) * 60).round();

    String period = hour >= 12 ? 'PM' : 'AM';
    int displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }

  static double parseTime(String timeString) {

    final parts = timeString.split(' ');
    if (parts.length != 2) throw FormatException('Invalid time format');

    final timePart = parts[0];
    final period = parts[1].toUpperCase();

    final timeComponents = timePart.split(':');
    if (timeComponents.length != 2) throw FormatException('Invalid time format');

    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    if (minute != 0 && minute != 30) {
      throw FormatException('Minutes must be 00 or 30');
    }

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return minute == 30 ? hour + 0.5 : hour.toDouble();
  }

  static final Map<String, IconData> stringToIconData = {
    "sunny": CupertinoIcons.sun_max,
    "clear": CupertinoIcons.cloud_moon,
    "rainy": CupertinoIcons.cloud_heavyrain,
    "partially cloudy": CupertinoIcons.cloud_sun,
    "snow": CupertinoIcons.snow
  };

  static String formatPlaceType(String type) {
    String formattedType = type.replaceAll('_', ' ');
    return formattedType.split(' ')
        .map((word) => word.isNotEmpty
        ? word[0].toUpperCase() + word.substring(1).toLowerCase()
        : '')
        .join(' ');
  }

  static String getCurrentOpeningStatus(double current_time, RegularOpeningHours? regularOpeningHours) {
    final periods = regularOpeningHours?.periods;

    if(periods == null || periods.length == 1) {
      return "Open 24 hours";
    }

    final now = DateTime.now();
    final int currentDay = now.weekday - 1;
    final int currentTimeInt = (current_time * 100).toInt();

    for (final period in periods) {
      final openInfo = period.open;
      final closeInfo = period.close;

      if (openInfo == null || closeInfo == null) continue;

      final int openDay = openInfo.day!;
      final int openTimeInt = (openInfo.hour! * 100) + openInfo.minute!;
      final int closeDay = closeInfo.day!;
      final int closeTimeInt = (closeInfo.hour! * 100) + closeInfo.minute!;

      bool isActive = false;

      // Case 1: Same-day opening period
      if (openDay == closeDay) {
        if (currentDay == openDay && currentTimeInt >= openTimeInt && currentTimeInt < closeTimeInt) {
          isActive = true;
        }
      }
      // Case 2: Overnight opening period
      else {
        if (currentDay == openDay && currentTimeInt >= openTimeInt) {
          isActive = true;
        }
        else if (currentDay == closeDay && currentTimeInt < closeTimeInt) {
          isActive = true;
        }
      }

      if (isActive) {
        // Found the active period, return its closing time
        double closingTime = closeInfo.hour! + (closeInfo.minute! / 60);
        return "Open until ${Helper.formatTime(closingTime)}";
      }
    }

    return "Open";
  }

  static Map<String, int> _timeToHourMinute(double time) {
    return {
      "hour" : time.floor(),
      "minute" : ((time - time.floor()) * 60).round()
    };
  }

  static List<String> getCuisineOptions() {
    return [
      '🍕 Pizza',
      '🍣 Japanese',
      '🌮 Mexican',
      '🍔 Burgers',
      '🍛 Indian',
      '🥐 French',
      '🧀 Poutine',
      '☕ Café & Brunch',
      '🥗 Healthy',
      '🥢 Chinese',
      '🌱 Vegetarian',
      '🍗 American',
      '🌿 Vegan',
      '☀️ Gluten-Free',
      '🥖 Bakery'
    ];
  }

}