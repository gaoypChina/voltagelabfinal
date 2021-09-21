// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/Screen/Polytechnic_bd/listcategory_page.dart';
import 'package:voltagelab/Screen/Voltage_Lab/listcategory_page.dart';
import 'package:voltagelab/Screen/Youtube/youtube_playlist.dart';
import 'package:voltagelab/widget/drawer.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getcategory();
    Provider.of<CategoryProvider>(context, listen: false)
        .polytechnicbdcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");
    return Scaffold(
      drawer: const DrawerPage(),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              "Hey ${box.get('name')}",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: const CircleAvatar(
                  maxRadius: 20,
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 0),
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Text(
                  //       "Hey ${box.get('name')}",
                  //       style: const TextStyle(
                  //           fontSize: 25, fontWeight: FontWeight.bold),
                  //     ),
                  //     const Spacer(),
                  //     const CircleAvatar(
                  //       maxRadius: 22,
                  //     )
                  //   ],
                  // ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 15,
                    ),
                    // child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     const Text(
                    //       "What are you",
                    //       style: TextStyle(fontSize: 23, color: Colors.grey),
                    //     ),
                    //     const SizedBox(height: 5),
                    //     const Text("up to today?",
                    //         style: TextStyle(fontSize: 23, color: Colors.grey)),
                    //   ],
                    // ),
                  ),
                  GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.3,
                            mainAxisSpacing: 10),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ListcategoryPage(),
                                  ));
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Container(
                                //   margin: EdgeInsets.only(top: 20, left: 20),
                                //   child: const Text(
                                //     "Voltage Lab",
                                //     style: TextStyle(
                                //         color: Colors.white,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/voltagelab.png',
                                      height: 90,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Provider.of<CategoryProvider>(context,
                                      listen: false)
                                  .polytechnicbdcategory();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PolytechnicListcategoryPage(),
                                  ));
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Container(
                                //   margin: EdgeInsets.only(top: 20, left: 20),
                                //   child: const Text(
                                //     "Voltage Lab",
                                //     style: TextStyle(
                                //         color: Colors.white,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/plytechnicbd.png',
                                      height: 100,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(20)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const YoutubePlaylistPage(),
                                  ));
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Container(
                                //   margin: EdgeInsets.only(top: 20, left: 20),
                                //   child: const Text(
                                //     "Voltage Lab",
                                //     style: TextStyle(
                                //         color: Colors.white,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'images/youtube.png',
                                      height: 125,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
