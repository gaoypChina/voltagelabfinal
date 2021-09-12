import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/pages/home_page.dart';

import 'Provider/post_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => Postprovider())
    ],
    child: MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  ));
}
