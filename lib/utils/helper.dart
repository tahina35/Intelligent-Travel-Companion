import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

}