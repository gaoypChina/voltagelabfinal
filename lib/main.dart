import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/connectivity_provider.dart';
import 'package:voltagelab/Provider/otherprovider.dart';
import 'package:voltagelab/Provider/payment_invoice.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/pages/Internet_Connectibity/internetdisconnect.dart';
import 'package:voltagelab/pages/homepage.dart';
import 'package:voltagelab/pages/homepage2.dart';
import 'Provider/category_provider.dart';

import 'Provider/notification_provider.dart';
import 'Provider/signin_provider.dart';
import 'Provider/post_provider.dart';
import 'Provider/webview_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Provider/youtube_api_provider.dart';
import 'package:voltagelab/Notification/OneSignal/navigatorstate_onesignal.dart'
    as onesignal;

Future<void> main() async {
  configLoading();
  onesignal.appnavigator = GlobalKey<NavigatorState>();
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await Hive.initFlutter();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.openBox("userdata");
  await Hive.openBox("voltagelabbadge");
  await Hive.openBox("Polytechnicbadge");
  await Hive.openBox("notification");
  await Hive.openBox("verificationnumber");
  await Hive.openBox("subsinfo");

  var box = Hive.box("userdata");
  Hive.init(dir.path);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => Postprovider()),
      ChangeNotifierProvider(create: (context) => Webcontroll()),
      ChangeNotifierProvider(create: (context) => SignInProvider()),
      ChangeNotifierProvider(create: (context) => YoutubeApiprovider()),
      ChangeNotifierProvider(create: (context) => NotificationService()),
      ChangeNotifierProvider(create: (context) => PaymentProvider()),
      ChangeNotifierProvider(create: (context) => PaymentInvoiceprovider()),
      ChangeNotifierProvider(create: (context) => Otherprovider()),
      ChangeNotifierProvider(create: (context) => ConnectivityProvider(),)
    ],
    child: MyApp(),
  ));
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.black
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.red
    ..textColor = Colors.black
    ..maskColor = Colors.black.withOpacity(0.7)
    ..userInteractions = true
    ..dismissOnTap = false;
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  var box = Hive.box("userdata");

  @override
  Widget build(BuildContext context) {
    final darktheme = Provider.of<Otherprovider>(context);
    print("internet check");
    return MaterialApp(
      // theme: ThemeData(brightness: Brightness.light),
      theme: darktheme.themeData,
      debugShowCheckedModeBanner: false,
      navigatorKey: onesignal.appnavigator,
      home: box.get('email') != '' && box.get('type') == '2'
                  ? const HomePage()
                  : const HomePage2(),
      builder: EasyLoading.init(),
    );
  }
}


// child: box.get('email') != '' && box.get('type') == '2'
//                   ? const HomePage()
//                   : const HomePage2(),


// StreamBuilder<ConnectivityResult>(
//           stream: Connectivity().onConnectivityChanged,
//           builder: (context, snapshot) {
            
//             if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
//               return box.get('email') != '' && box.get('type') == '2'
//                   ? const HomePage()
//                   : const HomePage2();
//             } else if (snapshot.data == ConnectivityResult.none) {
//               return const InternetDisconnectpage();
//             } else {
//               return box.get('email') != '' && box.get('type') == '2'
//                   ? const HomePage()
//                   : const HomePage2();
//             }
//           }),




// box.get('email') != '' && box.get('types') == '2' ? const HomePage() : const HomePage2(),);

// box.get('email') != '' && box.get('types') == '2'
//           ? const NewHomePage()
//           : const HomePage2(),
// box.get('email') != '' && box.get('types') == '2' ? const HomePage() : const HomePage2(),
// box.get('email') != '' && box.get('types') == '2' ? const HomePage() : const HomePage2(),
