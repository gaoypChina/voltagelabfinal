// import 'dart:convert';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:http/http.dart' as http;

// class LocalNotification {
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

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

//   Future imagenotification() async {
//     var bigpicture =  BigPictureStyleInformation(
//       const DrawableResourceAndroidBitmap('ic_launcher'),
//       largeIcon: const DrawableResourceAndroidBitmap('ic_launcher'),
//       contentTitle: 'hgjvjhgvjhvkjh',
//       summaryText: 'New User Found',
//       htmlFormatContentTitle: true,
//     );

//     var android = AndroidNotificationDetails("id", "channel", "Description",
//         styleInformation: bigpicture);
//     var platfrom = NotificationDetails(android: android);
//     await _flutterLocalNotificationsPlugin.show(
//         0, 'instant notification', 'tab to do something', platfrom,
//         payload: "Welcome to demo App");
//   }

//   Future updatepostnotification() async {
//     String url =
//         "http://192.168.0.107/tanvir/userinfoverify.php?api_token=jvb/zljdsfbvkjzbkjsbfvkadjhgvajdfgbvkhdjafbvkahjdsbvjkhdsabvkjhdafbvjkhdsafbv&email=shakilhassan887@gmail.com&types=2";
//     var response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       var jsondata = jsonDecode(response.body);
//       if (jsondata['full_name'] == 'Tanvir') {
//         imagenotification();
//       }else{
//         imagenotification();
//       }
//     }
//   }
// }
