import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:voltagelab/Extra_Page/bottom_navbar.dart';
import 'package:voltagelab/Provider/connectivity_provider.dart';
import 'package:voltagelab/Screen/Voltage_Lab/MCQ/mcq_categorylist.dart';
import 'package:voltagelab/Subscription/newsubscription.dart';
import 'package:voltagelab/helper/global.dart';
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
import 'package:voltagelab/pages/home_init_page.dart';
import 'package:voltagelab/widget/drawer.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      {
      // Widget? imagechild,
      Icon? icon,
      GestureTapCallback? onTap,
      String? name,
      Color? color,
      String? gridTopText}) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade100,
          blurRadius: 5.0,
          // has the effect of softening the shadow
          spreadRadius: 2.0,
          offset: Offset(
            1.0, // horizontal, move right 10
            5.0, // vertical, move down 10
          ),
        )
      ], borderRadius: BorderRadius.circular(24), color: color),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned(
                child: Container(
              margin: EdgeInsets.only(bottom: 20),
              width: double.infinity,
              height: double.infinity,
              child: icon,
            )),
            Positioned(
                top: 0,
                right: 10,
                child: Text(gridTopText.toString(), style: Global.gridtopfont)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Text(name!, style: Global.gridTitleName)),
            )
          ],
        ),
      ),
    );
  }

  Widget progridviewtools(
      {Icon? icon,
      GestureTapCallback? onTap,
      String? name,
      String? gridTopText,
      Color? color,
      Subscriptionsingledata? subscriptionsingledata}) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5.0,
            spreadRadius: 2.0,
            offset: Offset(1.0, 5.0))
      ], borderRadius: BorderRadius.circular(24), color: color),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Positioned(
                child: Container(
              margin: EdgeInsets.only(bottom: 20),
              width: double.infinity,
              height: double.infinity,
              child: icon,
            )),
            Positioned(
                top: 0,
                right: 10,
                child: Text(gridTopText.toString(), style: Global.gridtopfont)),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Text(name!, style: Global.gridTitleName)),
            ),
          ],
        ),
      ),
    );
  }

  Widget progridviewtool(
      {
      // Widget? imagechild,
      Icon? icon,
      GestureTapCallback? onTap,
      String? name,
      String? gridTopText,
      Color? color,
      Subscriptionsingledata? subscriptionsingledata}) {
    return Container(
      // margin: const EdgeInsets.only(left: 10, right: 5),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade100,
          blurRadius: 5.0,
          // has the effect of softening the shadow
          spreadRadius: 2.0,
          offset: Offset(
            1.0, // horizontal, move right 10
            5.0, // vertical, move down 10
          ),
        )
      ], borderRadius: BorderRadius.circular(24), color: color),
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
                    margin: EdgeInsets.only(right: 10),
                    alignment: Alignment.topRight,
                    width: double.infinity,
                    child: Text(
                      gridTopText.toString(),
                      style: Global.gridtopfont,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    // height: 50,
                    // width: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: icon,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    name!,
                    style: Global.gridTitleName,
                  ),
                ],
              ),
              subscriptionsingledata == null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    )
                  : subscriptionsingledata.status != '1'
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Colors.grey.withOpacity(0.5),
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

  // void alartmessages() {
  //   Alert(
  //     context: context,
  //     type: AlertType.error,
  //     title: "SUBSCRIPTION ALERT",
  //     desc: "First you buy any premium package. Then you can use Pro Future.",
  //     buttons: [
  //       DialogButton(
  //         child: const Text(
  //           "Subscription Page",
  //           style: TextStyle(color: Colors.white, fontSize: 16),
  //         ),
  //         onPressed: () => Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => const NewSubscriptionPage())),
  //       )
  //     ],
  //   ).show();
  // }

  void alartmessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "সাবস্ক্রিপশন এলার্ট!!",
            style: GoogleFonts.hindSiliguri(
                color: Colors.red.shade300,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          content: Text(
              "এই ফিচারটি শুধুমাত্র সাবস্ক্রিপশন ইউজার দের জন্য। সাবস্ক্রিপশন করতে চাইলে নিচের Subscribe বাটনটিতে ক্লিক করুন।",
              style: Global.bnAlertText),
          actions: <Widget>[
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'Cancel'),
            //   child: const Text('Cancel'),
            // ),
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('OK'),
            // ),

            Row(
              children: [
                DialogButton(
                  width: 80,
                  color: Colors.white,
                  child: Text("Subscribe",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: Global.defaultColor,
                        fontWeight: FontWeight.bold,
                      )),
                  onPressed: () async {
                    Navigator.pop(context);
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NewSubscriptionPage()));
                  },
                ),
                DialogButton(
                    width: 50,
                    color: Colors.white,
                    child: Text("Close",
                        style: GoogleFonts.lato(
                          color: Colors.red.shade300,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () => Navigator.pop(context)),
                // SizedBox(
                //   height: 50,
                // ),
                // DialogButton(
                //     width: 60,
                //     color: Colors.white,
                //     child: Text("Reload",
                //         style: GoogleFonts.lato(
                //           color: Colors.red.shade300,
                //           fontSize: 14,
                //           fontWeight: FontWeight.bold,
                //         )),
                //     onPressed: () {
                //       onrefreshlist();
                //     })
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> onrefreshlist() async {
    final post = Provider.of<Postprovider>(context, listen: false);
    await Future.delayed(
      Duration(seconds: 5),
      () {
        // Provider.of<>(context, listen: false).getallmybook();
        post.connectivityCheck();
      },
    );
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
    // post.connectivityCheck();

    return Scaffold(
      // bottomNavigationBar: HomeInitPage(),
      // drawer: const DrawerPage(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            backgroundColor: Colors.white,
            title: Text(
              "Hi, ${box.get('name')}",
              style: Global.entitleName,
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedBackPage(),
                        ));
                  },
                  icon: Icon(
                    Icons.feedback,
                    color: Global.defaultColor,
                  ))
            ],
          ),
          // SliverToBoxAdapter(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       Container(
          //         height: 120,
          //         width: double.infinity,
          //         decoration: const BoxDecoration(
          //           color: Colors.blue,
          //           borderRadius: BorderRadius.only(
          //             bottomLeft: Radius.circular(30),
          //             bottomRight: Radius.circular(30),
          //           ),
          //         ),
          //         child: Container(
          //           margin: const EdgeInsets.only(left: 20),
          //           child: Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "Hi ${box.get('name')}",
          //                 style: GoogleFonts.roboto(
          //                     color: Colors.white, fontSize: 22),
          //               ),
          //               const SizedBox(height: 5),
          //               Text(
          //                 "Welcome Back👏",
          //                 style: GoogleFonts.roboto(
          //                     color: Colors.white,
          //                     fontSize: 22,
          //                     fontWeight: FontWeight.w500),
          //               )
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // comment
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
                    height: MediaQuery.of(context).size.height * 0.08,
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
                              child: Text(
                                latestpost.title!.rendered,
                                style: Global.titleCarosal,
                              ),
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
                // margin: const EdgeInsets.symmetric(horizontal: 12),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    childAspectRatio: 3 / 2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    freegridviewtool(
                      color: Colors.white,
                      // imagechild: Image.asset('images/icon.jpg'),
                      icon: Icon(
                        Icons.chrome_reader_mode_outlined,
                        color: Global.defaultColor,
                        size: 30,
                      ),
                      name: "পড়াশুনা",
                      gridTopText: "বাংলা",
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
                      color: Colors.white,
                      // imagechild: Image.asset('images/icon.jpg'),
                      icon: Icon(
                        Icons.chrome_reader_mode_outlined,
                        color: Global.defaultColor,
                        size: 30,
                      ),
                      name: "পড়াশুনা",
                      gridTopText: "ইংরেজি",
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
                      color: Colors.white,
                      icon: Icon(
                        Icons.question_answer_outlined,
                        color: Colors.blue,
                        size: 30,
                      ),
                      name: "MCQ",
                      gridTopText: "",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => const YoutubePlaylistPage(),
                              builder: (context) => const McqCategoryList(),

                            ));
                      },
                    ),
                    freegridviewtool(
                      color: Colors.white,
                      icon: Icon(
                        Icons.payment,
                        size: 30,
                        color: Global.defaultColor,
                      ),
                      name: "সাবস্ক্রিপশন তথ্য",
                      gridTopText: "",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SubscriptionDetailsPage(),
                            ));
                      },
                    ),
                    // freegridviewtool(
                    //   color: Colors.white,
                    //   imagechild: Image.asset('images/icon.jpg'),
                    //   name: "MCQ",
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const McqCategoryList(),
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
                    padding: const EdgeInsets.all(0),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'সাবস্ক্রিপশন ফিচার',
                          style: Global.subscriptionFeatureText,
                        ),
                        //TODO: color need add
                        const Divider(),
                        StreamBuilder(
                            stream: SubscriptionUserStreamdata()
                                .streamsubscriptiondata(
                                    const Duration(seconds: 5),
                                    box.get('email')),
                            builder: (context,
                                AsyncSnapshot<Subscriptionsingledata?>
                                    snapshot) {
                              print("checksubscriber:  $snapshot.data!.status");
                              return GridView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  // crossAxisCount: 2,
                                  // mainAxisSpacing: 10,
                                  // childAspectRatio: 2 / 2,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: 3 / 2,
                                ),
                                children: [
                                  progridviewtool(
                                    color: Colors.white,
                                    // imagechild: Image.asset(
                                    //   'images/icon.jpg',
                                    //   fit: BoxFit.cover,
                                    // ),
                                    icon: Icon(
                                      Icons.chrome_reader_mode_outlined,
                                      color: Global.defaultColor,
                                      size: 30,
                                    ),
                                    gridTopText: "বাংলা",
                                    name: 'বুকমার্ক',
                                    onTap: snapshot.data == null
                                        ? () {
                                            alartmessage();
                                            // post.isInternet == false
                                            //     ? alartmessage()
                                            //     : null;
                                          }
                                        : snapshot.data!.status != "1"
                                            ? () {
                                                // alartmessage();
                                                // post.isInternet == false
                                                //     ? alartmessage()
                                                //     : null;
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
                                    subscriptionsingledata:
                                        snapshot.data == null
                                            ? null
                                            : snapshot.data!,
                                  ),
                                  progridviewtool(
                                    color: Colors.white,
                                    // imagechild: Image.asset(
                                    //   'images/icon.jpg',
                                    //   fit: BoxFit.cover,
                                    // ),
                                    icon: Icon(
                                      Icons.chrome_reader_mode_outlined,
                                      color: Global.defaultColor,
                                      size: 30,
                                    ),
                                    gridTopText: "ইংরেজি",
                                    name: 'বুকমার্ক',
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
                                    subscriptionsingledata:
                                        snapshot.data == null
                                            ? null
                                            : snapshot.data!,
                                  ),
                                  progridviewtool(
                                    color: Colors.white,
                                    // imagechild: Image.asset(
                                    //   'images/icon.jpg',
                                    //   fit: BoxFit.cover,
                                    // ),
                                    icon: const Icon(
                                      Icons.category_outlined,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                    gridTopText: "",
                                    name: 'বিভাগ',
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
                                    subscriptionsingledata:
                                        snapshot.data == null
                                            ? null
                                            : snapshot.data!,
                                  ),
                                  progridviewtool(
                                    color: Colors.white,
                                    // imagechild: Image.asset(
                                    //   'images/icon.jpg',
                                    //   fit: BoxFit.cover,
                                    // ),
                                    icon: const Icon(
                                      Icons.video_library_outlined,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                    gridTopText: "",
                                    name: 'ভিডিও',

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
                                                        // const McqCategoryList(),
                                                    const YoutubePlaylistPage()
                                                  ),
                                                );
                                              },
                                    subscriptionsingledata:
                                        snapshot.data == null
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

          SliverToBoxAdapter(
            // child: Column(
            //   children: [
            //     Container(
            //       width: double.infinity,
            //       padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            //       child: Text(
            //         "আপনি যদি সাবস্ক্রাইব ইউজার হোন এবং কিন্তু ইন্টারনেট কানেকশন দুর্বল বা না থাকে তবে প্রো ফিচার ডিজাবল দেখতে পাবেন, সেক্ষেত্রে ফিচারটি একটিভ করতে নেট কানেকশন অন রেখে পেইজটিকে রিফ্রেশ করুন।",
            //         style: GoogleFonts.hindSiliguri(
            //             color: Colors.red.shade200,
            //             fontSize: 12,
            //             fontWeight: FontWeight.normal),
            //       ),
            //     ),
            //     Container(
            //       child: TextButton(
            //         style: TextButton.styleFrom(
            //           padding: const EdgeInsets.all(16.0),
            //           primary: Colors.black,
            //           textStyle: const TextStyle(fontSize: 12),
            //         ),
            //         onPressed: () {},
            //         child: Text('Refresh', style: GoogleFonts.lato()),
            //       ),
            //     )
            //   ],
            // ),

            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10, left: 20, right: 20),
              child: RichText(
                text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              "আপনি যদি সাবস্ক্রাইব ইউজার হোন কিন্তু ইন্টারনেট কানেকশন দুর্বল বা না থাকে তবে প্রো ফিচার ডিজাবল দেখতে পাবেন, সেক্ষেত্রে ফিচারটি একটিভ করতে নেট কানেকশন অন রেখে রিফ্রেশ ক্লিক করুন  ",
                          style: GoogleFonts.hindSiliguri(
                            color: Colors.black54,
                            fontSize: 12,
                          )),
                      TextSpan(
                          text: "Refresh",
                          style: GoogleFonts.lato(
                            backgroundColor: Colors.grey,
                            color: Global.defaultColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => setState(() {
                                  onrefreshlist();
                                  Fluttertoast.showToast(
                                      msg: "Wait a bit to refresh the page",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black54,
                                      fontSize: 16.0);
                                }))
                    ]),
              ),
            ),
          )
          // Container(
          //   // width: double.infinity,
          //   // padding: EdgeInsets.all(20),
          //   child: Text(
          //     "আপনি যদি সাবস্ক্রাইব ইউজার হোন তবে ফিচার একটিভ করতে নেট কানেকশন অন রেখে পেইজটিকে রিফ্রেশ করুন।",
          //     style: GoogleFonts.hindSiliguri(
          //         color: Colors.black,
          //         fontSize: 12,
          //         fontWeight: FontWeight.normal),
          //   ),
          // )
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
