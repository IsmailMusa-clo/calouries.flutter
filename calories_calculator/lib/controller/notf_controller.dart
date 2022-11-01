import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/launcher_icon"), iOS: IOSInitializationSettings());

    _notificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? route) async {
      if (route != null) {}
    });
  }

  static void display() async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "easyapproach",
            "easyapproach channel",
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: IOSNotificationDetails(
            threadIdentifier: 'thread_id',
          ));

      await _notificationsPlugin.show(
        id,
        "For better health:",
        "Please drink a third of a liter of water to complete your daily need",
        notificationDetails,
        //payload: message.data["url"],
      );
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    LocalNotificationService.display();
    return Future.value(true);
  });
}
