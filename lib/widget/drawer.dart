import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/pages/new_profile_page3.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/Provider/signin_provider.dart';
import 'package:voltagelab/Screen/Voltage_Lab/Bookmark/bookmarkcategory_page.dart';
import 'package:voltagelab/Subscription/subscription_page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  void initState() {
  
 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signin = Provider.of<SignInProvider>(context);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.grey[300],
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const VoltagelabBookMarkCategoryPage(),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: const Text("Bookmark"),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.grey[300],
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  signin.logout(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: const Text("Log Out"),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.grey[300],
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewProfilePage3(),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: const Text("Profile"),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            color: Colors.grey[300],
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SubscriptionPage(),
                      ));
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: const Text("Subscription"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
