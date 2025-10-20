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

  static final Map<String, IconData> stringToIconData = {
    "sunny": CupertinoIcons.sun_max,
    "rainy": CupertinoIcons.cloud_heavyrain,
    "partially cloudy": CupertinoIcons.cloud_sun,
    "extreme heat": CupertinoIcons.thermometer_sun,
    "overcast": CupertinoIcons.cloud_sun,
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

  static String getCurrentOpeningStatus(double current_time, RegularOpeningHours regularOpeningHours) {
    if(regularOpeningHours.openNow! && regularOpeningHours.periods?.length == 1) {
      return "Open 24 hours";
    }

    int closingHour, closingMinute;
    double closingTime = 0;
    DateTime utcTime = DateTime.parse(regularOpeningHours.nextCloseTime!);
    DateTime localTime = utcTime.toLocal();
    closingHour = localTime.hour;
    closingMinute = localTime.minute;
    closingTime = closingHour + (closingMinute / 60);

    return "Open until ${Helper.formatTime(closingTime)}";
  }

  static Map<String, int> _timeToHourMinute(double time) {
    return {
      "hour" : time.floor(),
      "minute" : ((time - time.floor()) * 60).round()
    };
  }


}