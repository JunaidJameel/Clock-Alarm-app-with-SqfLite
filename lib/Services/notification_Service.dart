// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   Future<void> initNotification() async {
//     AndroidInitializationSettings initializationSettingsAndriod =
//         const AndroidInitializationSettings('timer');

//     var initializtionSettings = InitializationSettings(
//       android: initializationSettingsAndriod,
//     );

//     await notificationsPlugin.initialize(initializtionSettings,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notificationResponse) async {});
//   }

//   notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'channelId',
//         'channelName',
//         importance: Importance.max,
//         largeIcon: DrawableResourceAndroidBitmap('timer'),
//         styleInformation: BigPictureStyleInformation(
//           DrawableResourceAndroidBitmap('Clock'),
//           hideExpandedLargeIcon: true,
//         ),
//       ),
//     );
//   }

//   Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     return notificationsPlugin.show(
//       id,
//       title,
//       body,
//       notificationDetails(),
//     );
//   }
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('timer');

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void sendNotification(int id, String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.max,
      largeIcon: DrawableResourceAndroidBitmap('timer'),
      styleInformation: BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('Clock'),
        hideExpandedLargeIcon: true,
      ),
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
        id, title, body, notificationDetails);
  }
}
