import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future <void> initNotification() async{

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future <void> showNotification() async{
  const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'orden_1',
      'Orden de Trabajo: Reparación',
      importance: Importance.max,
      priority: Priority.high
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails
  );

  await flutterLocalNotificationsPlugin.show(
      1,
    'Orden de Trabajo agregada',
    'Se ha agregado un nuevo equipo a tu lista de ordenes de trabajo.',
    notificationDetails
  );
}