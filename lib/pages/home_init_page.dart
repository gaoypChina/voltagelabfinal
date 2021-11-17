import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voltagelab/Extra_Page/oldsubscription_page.dart';
import 'package:voltagelab/Subscription/newsubscription.dart';
import 'package:voltagelab/helper/global.dart';
import 'package:voltagelab/model/Subscription_details/subscription_details.dart';
import 'package:voltagelab/pages/contact_form.dart';
import 'package:voltagelab/pages/homepage.dart';
import 'package:voltagelab/pages/new_profile_page3.dart';

class HomeInitPage extends StatefulWidget {
  const HomeInitPage({Key? key}) : super(key: key);

  @override
  _HomeInitPageState createState() => _HomeInitPageState();
}

class _HomeInitPageState extends State<HomeInitPage> {
  int _currentIndex = 0;
  final List screens = [
    const HomePage(),
    const NewSubscriptionPage(),
    const NewProfilePage3(),
    const ContactForm()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("data"),
      // ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 16,
        unselectedFontSize: 12,
        selectedLabelStyle: Global.bottomSelectedNavText,
        unselectedLabelStyle: Global.bottomUnselectedNavText,
        iconSize: 30,
        selectedItemColor: Global.defaultColor,
        unselectedItemColor: Colors.black,
        // fixedColor: Colors.white,

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Global.defaultColor,
            ),
            label: 'হোম',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_alert,
              color: Global.defaultColor,
            ),
            label: 'সাবস্ক্রিপশন',

            // backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Global.defaultColor,
            ),
            label: 'প্রোফাইল',
            // backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.contact_support,
              color: Global.defaultColor,
            ),
            label: 'যোগাযোগ',
            // backgroundColor: Colors.blue
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Home',
          //   // backgroundColor: Colors.blue
          // )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
