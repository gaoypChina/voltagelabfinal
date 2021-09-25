// // ignore_for_file: non_constant_identifier_names

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationService extends ChangeNotifier {
  final String onesignalappid = "5cb539ea-9acf-402c-b303-564ed768b650";
//   // final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//   //     FlutterLocalNotificationsPlugin();

//   // bool notificationswetchvalue = false;
//   // TimeOfDay timeOfDay = TimeOfDay.now();

//   // Future initialize() async {
//   //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   //       FlutterLocalNotificationsPlugin();

//   //   AndroidInitializationSettings androidInitializationSettings =
//   //       const AndroidInitializationSettings('ic_launcher');

//   //   IOSInitializationSettings iOSinitializationSettings =
//   //       const IOSInitializationSettings();

//   //   final InitializationSettings initializationSettings =
//   //       InitializationSettings(
//   //           android: androidInitializationSettings,
//   //           iOS: iOSinitializationSettings);

//   //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   // }

//   // Future instantnotification() async {
//   //   var android =
//   //       const AndroidNotificationDetails("id", "channel", "Description");
//   //   var ios = const IOSNotificationDetails();
//   //   var platfrom = NotificationDetails(android: android, iOS: ios);
//   //   await _flutterLocalNotificationsPlugin.show(
//   //       0, 'instant notification', 'tab to do something', platfrom,
//   //       payload: "Welcome to demo App");
//   // }

//   // Future imagenotification() async {
//   //   var bigpicture = const BigPictureStyleInformation(
//   //     DrawableResourceAndroidBitmap('ic_launcher'),
//   //     largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
//   //     contentTitle: 'Demo Image Notification',
//   //     summaryText: 'This is demo text',
//   //     htmlFormatContentTitle: true,
//   //   );

//   //   var android = AndroidNotificationDetails("id", "channel", "Description",
//   //       styleInformation: bigpicture);
//   //   var platfrom = NotificationDetails(android: android);
//   //   await _flutterLocalNotificationsPlugin.show(
//   //       0, 'instant notification', 'tab to do something', platfrom,
//   //       payload: "Welcome to demo App");
//   // }

//   // Future shaduenotification() async {
//   //   var interval = RepeatInterval.daily;
//   //   var bigpicture = const BigPictureStyleInformation(
//   //     DrawableResourceAndroidBitmap('ic_launcher'),
//   //     largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
//   //     contentTitle: 'Demo Image Notification',
//   //     summaryText: 'This is demo text',
//   //     htmlFormatContentTitle: true,
//   //   );

//   //   var android = AndroidNotificationDetails("id", "channel", "Description",
//   //       styleInformation: bigpicture);
//   //   var platfrom = NotificationDetails(android: android);
//   //   await _flutterLocalNotificationsPlugin.periodicallyShow(
//   //       0, 'instant notification', 'tab to do something', interval, platfrom,
//   //       payload: "Welcome to demo App", androidAllowWhileIdle: true, );
//   // }

//   // Future selectedtimenotification() async {
//   //   var bigpicture = const BigPictureStyleInformation(
//   //     DrawableResourceAndroidBitmap('ic_launcher'),
//   //     largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
//   //     contentTitle: 'Demo Image Notification',
//   //     summaryText: 'This is demo text',
//   //     htmlFormatContentTitle: true,
//   //   );

//   //   var android = AndroidNotificationDetails("id", "channel", "Description",
//   //       styleInformation: bigpicture,
//   //       importance: Importance.max,
//   //       priority: Priority.max);
//   //   var platfrom = NotificationDetails(android: android);

//   //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

//   //   await _flutterLocalNotificationsPlugin.zonedSchedule(0, 'zone notificaion',
//   //       'tab to something', tz.TZDateTime(tz.local, now.year,now.month,now.day,now.hour,now.minute).add(const Duration(seconds: 5)), platfrom,
//   //       uiLocalNotificationDateInterpretation:
//   //         UILocalNotificationDateInterpretation.absoluteTime,

//   //       androidAllowWhileIdle: true,
//   //       matchDateTimeComponents: DateTimeComponents.time);
//   //   print(tz.TZDateTime(tz.local, now.year,now.month,now.day,now.hour,now.minute));
//   //   notifyListeners();
//   // }

//   // Future cancelnotification() async {
//   //   await _flutterLocalNotificationsPlugin.cancelAll();
//   // }

//   // tz.TZDateTime nextInstanceOfTenAM() {
//   //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//   //   tz.TZDateTime scheduledDate =
//   //       tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
//   //   if (scheduledDate.isBefore(now)) {
//   //     scheduledDate = scheduledDate.add(const Duration(days: 1));
//   //   }

//   //   return scheduledDate;
//   // }

//   // timezoneinit() {
//   //   tz.initializeTimeZones();
//   // }

//   // Future timepicker(BuildContext context) async {
//   //   final picker =
//   //       await showTimePicker(context: context, initialTime: TimeOfDay.now());

//   //   if (picker != null) {
//   //     // selectedtimenotification(picker.hour, picker.minute);
//   //     timeOfDay = picker;
//   //     notifyListeners();
//   //     print(timeOfDay);
//   //     return picker;
//   //   } else {
//   //     print('time not select');
//   //   }
//   //   notifyListeners();
//   // }

//   // notificionsswetchvalue(bool value) {
//   //   var box = Hive.box("notification");
//   //   box.put('value', value);
//   //   notifyswetchvalue_change();
//   //   notifyListeners();
//   // }

//   // notifyswetchvalue_change() {
//   //   var box = Hive.box("notification");
//   //   notificationswetchvalue = box.get('value') ?? false;
//   // }

  Future initplatfrom() async {
    OneSignal.shared.setAppId(onesignalappid);
  }
}
