import 'package:permission_handler/permission_handler.dart';

class Helper {

  static String formatTime(double hourValue) {
    int hour = hourValue.floor();
    int minute = ((hourValue - hour) * 60).round();

    String period = hour >= 12 ? 'PM' : 'AM';
    int displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return '$displayHour:${minute.toString().padLeft(2, '0')} $period';
  }

}