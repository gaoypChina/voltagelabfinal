import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/Provider/notification_provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/Screen/Polytechnic_bd/listcategory_page.dart';
import 'package:voltagelab/Screen/Voltage_Lab/latestpost_details.dart';
import 'package:voltagelab/Screen/Voltage_Lab/listcategory_page.dart';
import 'package:voltagelab/Screen/Youtube/youtube_playlist.dart';
import 'package:voltagelab/widget/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool switchbtn = false;

  parmissionhandeler() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    } else {}
  }

  @override
  void initState() {
    parmissionhandeler();
    Provider.of<NotificationService>(context, listen: false).initplatfrom();
    Provider.of<Postprovider>(context, listen: false).getvoltagelablatestpost();
    Provider.of<CategoryProvider>(context, listen: false).getcategory();
    Provider.of<CategoryProvider>(context, listen: false)
        .polytechnicbdcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("userdata");
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      drawer: const DrawerPage(),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            centerTitle: true,
            backgroundColor: Colors.indigoAccent,
            actions: [
              // Icon(notification.notificationswetchvalue == true
              //     ? Icons.notifications_active
              //     : Icons.notifications_off),
              // Switch(
              //   value: notification.notificationswetchvalue,
              //   onChanged: (value) {
              //     if (value == true) {
              //       notification.timepicker(context).then((values) {
              //         if (values != null) {
              //           notification.notificionsswetchvalue(value);
              //           notification.selectedtimenotification();
              //         }
              //       });
              //     } else {
              //       // notification.cancelnotification().then((values) {
              //       notification.notificionsswetchvalue(value);
              //       // });
              //     }
              //   },
              // )
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi ${box.get('name')}",
                          style: GoogleFonts.roboto(
                              color: Colors.white, fontSize: 22),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Welcome Back👏",
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Latest Post',
                    style: GoogleFonts.roboto(fontSize: 20),
                  ),
                  const Divider()
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: post.voltagelablatestpost.isEmpty
                ? const SizedBox(
                    height: 60,
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: CarouselSlider.builder(
                        itemCount: post.voltagelablatestpost.length,
                        itemBuilder: (context, index, realIndex) {
                          var latestpost = post.voltagelablatestpost[index];
                          return Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LatestPostDetails(
                                              latestpostid: latestpost.id,
                                              latestposttitle:
                                                  latestpost.title.rendered,
                                              latestpostpic: latestpost
                                                  .yoastHeadJson.ogImage[0].url,
                                            )));
                              },
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                child: Text(latestpost.title.rendered),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: true,
                          pageSnapping: true,
                          aspectRatio: 1.8,
                          enlargeCenterPage: true,
                        )),
                  ),
          ),
          SliverToBoxAdapter(
              child: Container(
            margin: const EdgeInsets.all(5),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 2,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.indigo),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        post.getpostcount();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListcategoryPage(),
                            ));
                      },
                      borderRadius: BorderRadius.circular(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'images/icon.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Voltage Lab',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(40)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        post.getpolytechnicpostcount();
                        Provider.of<CategoryProvider>(context, listen: false)
                            .polytechnicbdcategory();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PolytechnicListcategoryPage(),
                            ));
                      },
                      borderRadius: BorderRadius.circular(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'images/icon.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Polytechnic',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 5),
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(40)),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const YoutubePlaylistPage(),
                            ));
                      },
                      borderRadius: BorderRadius.circular(40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                'images/icon.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Youtube',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
