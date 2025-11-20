import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:itc/router/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:itc/services/firebase/firebase_remote_config_service.dart';
import 'package:itc/services/notification_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //init notifications
  NotificationService().initialize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final remoteConfigService = FirebaseRemoteConfigService(
    firebaseRemoteConfig: FirebaseRemoteConfig.instance,
  );
  remoteConfigService.init();

  runApp(MaterialApp.router(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFFFFFFF),
          colorScheme: ColorScheme.light(
            brightness: Brightness.light,
            primary: Color(0xFF0A66C2),
            // secondary: Colors.transparent,
            // error: Colors.red,
            // surface:  Color(0xFFF5F8FA),
            //onSurface: onSurface
          )
        ),
        routerConfig: AppRouter().router,
      ),
  );

}

