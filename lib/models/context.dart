import '../utils/helper.dart';

class Context {

  String location;
  String weather;
  String time;

  Context({
    required this.location,
    required this.weather,
    required this.time,
  }) {

    double parsedTime = Helper.parseTime(this.time);

    if((parsedTime >= 18.5 && parsedTime <= 23.5) || (parsedTime >= 0 && parsedTime <= 6)) {
      if(weather.toLowerCase() == "sunny") {
        this.weather = "Clear";
      }
    } else {
      if(weather.toLowerCase() == "clear") {
        this.weather = "Sunny";
      }
    }
  }





}