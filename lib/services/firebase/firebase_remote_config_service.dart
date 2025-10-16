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

      await firebaseRemoteConfig.setDefaults(const {
        "time": 9.0,
        "location": "Concordia University",
        "weather": "sunny",
      });

      await firebaseRemoteConfig.fetchAndActivate();

    } on FirebaseException catch (e, st) {
      developer.log(
        'Unable to initialize Firebase Remote Config',
        error: e,
        stackTrace: st,
      );
    }
  }

  double getTime() => firebaseRemoteConfig.getDouble('time');

  String getLocation() => firebaseRemoteConfig.getString('location');

  String getWeather() => firebaseRemoteConfig.getString('weather');

}