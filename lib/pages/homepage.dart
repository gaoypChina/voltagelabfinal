
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:voltagelab/Provider/connectivity_provider.dart';
import 'package:voltagelab/Screen/Voltage_Lab/MCQ/mcq_categorylist.dart';
import 'package:voltagelab/Subscription/newsubscription.dart';
import 'package:voltagelab/pages/FeedBack_Page/feedback.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/Screen/En_voltagelab/Bookmark/bookmarkcategory_page.dart';
import 'package:voltagelab/Screen/En_voltagelab/listcategory_page.dart';
import 'package:voltagelab/Screen/Voltage_Lab/Bookmark/bookmarkcategory_page.dart';
import 'package:voltagelab/Screen/Voltage_Lab/latestpost_details.dart';
import 'package:voltagelab/Screen/Voltage_Lab/listcategory_page.dart';
import 'package:voltagelab/Screen/Youtube/youtube_playlist.dart';
import 'package:voltagelab/Stream_data/Subscription_Stream_data/subscription_userdata.dart';
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_single_data.dart';
import 'package:voltagelab/pages/Pro_Category_Page/pro_bangla_voltagelabcategory_page.dart';
import 'package:voltagelab/pages/Subscription_details/subscription_details.dart';
import 'package:voltagelab/widget/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool switchbtn = false;
  bool lock = true;

  parmissionhandeler() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    } else {}
  }

  Widget freegridviewtool(
      {Widget? imagechild,
      GestureTapCallback? onTap,
      String? name,
      Color? color}) {
    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(left: 10, right: 5, top: 0),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(40), color: color),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
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
                    child: imagechild),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                name!,
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget progridviewtool(
      {Widget? imagechild,
      GestureTapCallback? onTap,
      String? name,
      Color? color,
      Subscriptionsingledata? subscriptionsingledata}) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.indigo),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
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
                      child: imagechild,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    name!,
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              subscriptionsingledata == null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    )
                  : subscriptionsingledata.status != '1'
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.black.withOpacity(0.5),
                          ),
                        )
                      : Container()
              // SizedBox(
              //     height: 50,
              //     child: subscriptionsingledata == null
              //         ? Image.asset(
              //             'images/lock.png',
              //             height: 50,
              //           )
              //         : subscriptionsingledata.status != "approved"
              //             ? Image.asset(
              //                 'images/lock.png',
              //                 height: 50,
              //               )
              //             : null),
            ],
          ),
        ),
      ),
    );
  }

  void alartmessage() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "SUBSCRIPTION ALERT",
      desc: "First you buy any premium package. Then you can use Pro Future.",
      buttons: [
        DialogButton(
          child: const Text(
            "Subscription Page",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NewSubscriptionPage())),
        )
      ],
    ).show();
  }

  @override
  void initState() {
    parmissionhandeler();
    Provider.of<Postprovider>(context, listen: false).getvoltagelablatestpost();
    Provider.of<CategoryProvider>(context, listen: false)
        .get_free_bn_vl_categorylist();
    Provider.of<CategoryProvider>(context, listen: false)
        .get_free_en_vl_categorylist();
    var box = Hive.box("userdata");
    Provider.of<PaymentProvider>(context, listen: false)
        .payment_subscription_one_month_userinfo_get(box.get('email'));
    Provider.of<CategoryProvider>(context, listen: false)
        .getmcqmaincategorydb();

    //     .payment_subscription_one_month_userinfo_get(box.get('email'));

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
        SliverAppBar(
          pinned: true,
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedBackPage(),
                      ));
                },
                icon: Icon(Icons.feedback))
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
                  color: Colors.blue,
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
        // SliverToBoxAdapter(
        //   child: Container(
        //     padding: const EdgeInsets.all(15),
        //     alignment: Alignment.center,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text(
        //           'Latest Post',
        //           style: GoogleFonts.roboto(fontSize: 20),
        //         ),
        //         const Divider()
        //       ],
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: post.voltagelablatestpost.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: CarouselSlider.builder(
                      itemCount: post.voltagelablatestpost.length,
                      itemBuilder: (context, index, realIndex) {
                        var latestpost = post.voltagelablatestpost[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LatestPostDetails(
                                          latestpostid: latestpost.id!,
                                          latestposttitle:
                                              latestpost.title!.rendered,
                                          latestpostpic: latestpost
                                              .yoastHeadJson!.ogImage[0].url!,
                                        )));
                          },
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(0),
                            child: Text(latestpost.title!.rendered),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        pageSnapping: false,
                        height: MediaQuery.of(context).size.height * 0.08,
                        aspectRatio: 0,
                      )),
                ),
        ),

        SliverToBoxAdapter(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  // childAspectRatio: 2 / 2,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  freegridviewtool(
                    color: Colors.indigo,
                    imagechild: Image.asset('images/icon.jpg'),
                    name: "Voltage Lab",
                    onTap: () {
                      post.getpostcount();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListcategoryPage(),
                          ));
                    },
                  ),
                  freegridviewtool(
                    color: Colors.orange,
                    imagechild: Image.asset('images/icon.jpg'),
                    name: "English Voltage Lab",
                    onTap: () {
                      post.get_en_voltagelabpostcount();
                      // Provider.of<CategoryProvider>(context, listen: false)
                      //     .en_free_vl_category();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const En_voltagelabListcategoryPage(),
                          ));
                    },
                  ),
                  freegridviewtool(
                    color: Colors.deepOrange,
                    imagechild: Image.asset('images/icon.jpg'),
                    name: "Youtube",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const YoutubePlaylistPage(),
                          ));
                    },
                  ),
                  freegridviewtool(
                    color: Colors.deepOrange,
                    imagechild: Image.asset('images/icon.jpg'),
                    name: "Subscription Details",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const SubscriptionDetailsPage(),
                          ));
                    },
                  ),
                  freegridviewtool(
                    color: Colors.deepOrange,
                    imagechild: Image.asset('images/icon.jpg'),
                    name: "MCQ",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const McqCategoryList(),
                          ));
                    },
                  ),
                  // freegridviewtool(
                  //   color: Colors.deepOrange,
                  //   imagechild: Image.asset('images/icon.jpg'),
                  //   name: "pro Category",
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) =>
                  //               const ProBanglaVoltageCategoryListPage(),
                  //         ));
                  //   },
                  // ),
                  // freegridviewtool(
                  //   color: Colors.deepOrange,
                  //   imagechild: Image.asset('images/icon.jpg'),
                  //   name: "pro Category",
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) =>
                  //               const Pro_en_Vl_CategoryPage(),
                  //         ));
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Pro Futures',
                        style: GoogleFonts.roboto(fontSize: 20),
                      ),
                      const Divider(),
                      StreamBuilder(
                          stream: SubscriptionUserStreamdata()
                              .streamsubscriptiondata(
                                  const Duration(seconds: 5), box.get('email')),
                          builder: (context,
                              AsyncSnapshot<Subscriptionsingledata?> snapshot) {
                            return GridView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10,
                                // childAspectRatio: 2 / 2,
                              ),
                              children: [
                                progridviewtool(
                                  color: Colors.indigo,
                                  imagechild: Image.asset(
                                    'images/icon.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  name: 'VoltageLab Bookmark',
                                  onTap: snapshot.data == null
                                      ? () {
                                          alartmessage();
                                        }
                                      : snapshot.data!.status != "1"
                                          ? () {
                                              alartmessage();
                                            }
                                          : () {
                                              post.getpostcount();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const VoltagelabBookMarkCategoryPage(),
                                                ),
                                              );
                                            },
                                  subscriptionsingledata: snapshot.data == null
                                      ? null
                                      : snapshot.data!,
                                ),
                                progridviewtool(
                                  color: Colors.blueGrey,
                                  imagechild: Image.asset(
                                    'images/icon.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  name: 'Polytechnic Bookmark',
                                  onTap: snapshot.data == null
                                      ? () {
                                          alartmessage();
                                        }
                                      : snapshot.data!.status != "1"
                                          ? () {
                                              alartmessage();
                                            }
                                          : () {
                                              post.getpostcount();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const En_voltagelabBookMarkCategoryPage(),
                                                ),
                                              );
                                            },
                                  subscriptionsingledata: snapshot.data == null
                                      ? null
                                      : snapshot.data!,
                                ),
                                progridviewtool(
                                  color: Colors.blueGrey,
                                  imagechild: Image.asset(
                                    'images/icon.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                  name: 'Pro Category',
                                  onTap: snapshot.data == null
                                      ? () {
                                          alartmessage();
                                        }
                                      : snapshot.data!.status != "1"
                                          ? () {
                                              alartmessage();
                                            }
                                          : () {
                                              post.getpostcount();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const ProBanglaVoltageCategoryListPage(),
                                                ),
                                              );
                                            },
                                  subscriptionsingledata: snapshot.data == null
                                      ? null
                                      : snapshot.data!,
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    );
  }

  // Widget homepagewidget() {
  //   final post = Provider.of<Postprovider>(context);
  //   var box = Hive.box("userdata");
  //   return 
  // }
}



// Consumer<ConnectivityProvider>(
//         builder: (context, value, child) {
//           if (value.isonline != null) {
//             return value.isonline!
//                 ? homepagewidget()
//                 : const InternetDisconnectpage();
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),