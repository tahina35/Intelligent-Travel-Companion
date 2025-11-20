import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initialize() async {
    if(_isInitialized) {
      return;
    }

    const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await notificationsPlugin.initialize(initializationSettings);
    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_1',
        'Recommendations notifications',
        channelDescription: 'Recommendations notifications',
        playSound: false,
        importance: Importance.max,
        priority: Priority.high,
        // largeIcon: DrawableResourceAndroidBitmap('@mipmap/logo1'),
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification(String title, String body) async {
    if (!_isInitialized) {
      await initialize();
    }

    await notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails(),
    );
  }

}