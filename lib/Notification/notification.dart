// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// class NotificationPage extends StatefulWidget {
//   const NotificationPage({Key? key}) : super(key: key);

//   @override
//   _NotificationPageState createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   Future initialize() async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();

//     AndroidInitializationSettings androidInitializationSettings =
//         const AndroidInitializationSettings('ic_launcher');

//     IOSInitializationSettings iOSinitializationSettings =
//         const IOSInitializationSettings();

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: androidInitializationSettings,
//             iOS: iOSinitializationSettings);

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   Future shaduenotification() async {
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
//     var bigpicture = const BigPictureStyleInformation(
//       DrawableResourceAndroidBitmap('ic_launcher'),
//       largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
//       contentTitle: 'Demo Image Notification',
//       summaryText: 'This is demo text',
//       htmlFormatContentTitle: true,
//     );


//     var android = AndroidNotificationDetails("id", "channel", "Description",
//         styleInformation: bigpicture);
//     var platfrom = NotificationDetails(android: android);

//     await flutterLocalNotificationsPlugin.zonedSchedule(0, 'tanvir',
//         'tanvir tanvir tanvcir', nextInstanceOfTenAM(), platfrom,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.wallClockTime,
//         androidAllowWhileIdle: true);
//   }

//     tz.TZDateTime nextInstanceOfTenAM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 11, 28);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(seconds:));
//     }

//     return scheduledDate;
//   }

//   @override
//   void initState() {
//     tz.initializeTimeZones();
//     initialize();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Notification'),
//       ),
//       body: Container(
//         child: ElevatedButton(
//             onPressed: () {
//               shaduenotification();
//             },
//             child: const Text('Start Notificcation')),
//       ),
//     );
//   }
// }
