import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer' as developer;

class FirebaseRemoteConfigService  {

  FirebaseRemoteConfigService({
    required this.firebaseRemoteConfig
  });

  final FirebaseRemoteConfig firebaseRemoteConfig;

  Future<void> init() async {
    try {
      await firebaseRemoteConfig.ensureInitialized();
      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );

      final contexts = {
        "location": "Ville-Marie",
        "time": "9",
        "weather": {
          "active": "0",
          "values": [
            "Sunny",
            "Clear",
            "Rainy",
            "Partially Cloudy",
            "Snow"
          ]
        }
      };

      await firebaseRemoteConfig.setDefaults({
        "contexts": jsonEncode(contexts)
      });

      // firebaseRemoteConfig.onConfigUpdated.listen((event) async {
      //   await firebaseRemoteConfig.activate();
      // });

      await firebaseRemoteConfig.fetchAndActivate();

    } on FirebaseException catch (e, st) {
      developer.log(
        'Unable to initialize Firebase Remote Config',
        error: e,
        stackTrace: st,
      );
    }
  }

  double getTime() {
    Map<String, dynamic> contexts = jsonDecode(firebaseRemoteConfig.getString('contexts'));
    return double.parse(contexts['time']);
  }

  String getLocation() {
    Map<String, dynamic> contexts = jsonDecode(firebaseRemoteConfig.getString('contexts'));
    return contexts['location'];
  }

  String getWeather() {
    Map<String, dynamic> contexts = jsonDecode(firebaseRemoteConfig.getString('contexts'));
    Map<String, dynamic> weather = contexts['weather'];
    int current_weather = int.parse(weather['active']);
    return weather['values'][current_weather];
  }

}