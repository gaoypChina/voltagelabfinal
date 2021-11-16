import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voltagelab/Sign_in_Screen/login.dart';
import 'package:voltagelab/pages/home_init_page.dart';
import 'package:voltagelab/pages/homepage.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return const HomeInitPage();
            // return const HomeInitPage();
          } else if (snapshot.hasError) {
            return const Text("something Wrong");
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
