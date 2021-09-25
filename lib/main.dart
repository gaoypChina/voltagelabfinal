import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/pages/homepage.dart';
import 'Provider/category_provider.dart';
import 'Provider/notification_provider.dart';
import 'Provider/signin_provider.dart';
import 'Provider/post_provider.dart';
import 'Provider/webview_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Provider/youtube_api_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.openBox("userdata");
  await Hive.openBox("voltagelabbadge");
  await Hive.openBox("Polytechnicbadge");
  await Hive.openBox("notification");
  Hive.init(dir.path);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => Postprovider()),
      ChangeNotifierProvider(create: (context) => Webcontroll()),
      ChangeNotifierProvider(create: (context) => SignInProvider()),
      ChangeNotifierProvider(create: (context) => YoutubeApiprovider()),
      ChangeNotifierProvider(create: (context) => NotificationService())
    ],
    child: MyApp(),
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  var box = Hive.box("userdata");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}

// box.get('email') != '' && box.get('types') == '2' ? const HomePage() : const HomePage2(),);

// box.get('email') != '' && box.get('types') == '2'
//           ? const NewHomePage()
//           : const HomePage2(),
// box.get('email') != '' && box.get('types') == '2' ? const HomePage() : const HomePage2(),
// box.get('email') != '' && box.get('types') == '2' ? const HomePage() : const HomePage2(),
