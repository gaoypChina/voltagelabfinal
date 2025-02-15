// ignore_for_file: iterable_contains_unrelated_type, avoid_print, non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:share/share.dart';
import 'package:voltagelab/Provider/payment_provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/Provider/otherprovider.dart';
import 'package:voltagelab/Sign_in_Screen/login.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/Model/category_model.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/Model/post_model.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/db/category_db.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/db/post_db.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/category_model.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/post_model.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/category_db.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/post_db.dart';
import 'package:voltagelab/Extra_Page/oldsubscription_page.dart';
import 'package:voltagelab/Subscription/newsubscription.dart';
import 'package:voltagelab/helper/global.dart';
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_single_data.dart';
import 'package:voltagelab/model/post_model.dart';
import 'package:voltagelab/pages/Guest/guest_home_init_page.dart';
import 'package:voltagelab/web_View/web_view.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetailsPage extends StatefulWidget {
  final String categoryname;
  final int categoryid;
  final Postdata postdata;
  final String sitename;

  const PostDetailsPage(
      {Key? key,
      required this.postdata,
      required this.categoryname,
      required this.categoryid,
      required this.sitename})
      : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  bool bookmark = false;
  bool isloading = false;

  int voltagelabsavepostcount = 0;

  SqlVoltageLabCategoryDB? sqlVoltagelabcategorydb;
  SqlVoltagelabPostDB? sqlVoltagelabpostdb;

  Sql_en_voltagelabPostDB? sql_en_VoltagelabPostDB;
  Sql_en_voltagelabCategoryDB? sql_en_voltagelabCategoryDB;

  List<VoltageLabSaveCategory> savevoltagelabcategorylist = [];
  List<VoltageLabSavepost> savevoltagelabpostlist = [];

  List<En_voltagelabSaveCategory> en_voltagelabSaveCategory = [];
  List<En_voltagelabSavepost> en_voltagelabSavepost = [];

  getsavecategoryandpost() async {
    savevoltagelabcategorylist = await sqlVoltagelabcategorydb!.getdata();
    savevoltagelabpostlist = await sqlVoltagelabpostdb!.getdata();
    en_voltagelabSaveCategory = await sql_en_voltagelabCategoryDB!.getdata();
    en_voltagelabSavepost = await sql_en_VoltagelabPostDB!.getdata();
  }

  // bookmarkdata() {
  //   if (widget.sitename == 'polytechnicbd') {
  //     if (polytechnicSavepost.contains(widget.postdata.id)) {
  //       setState(() {
  //         bookmark = true;
  //       });
  //     }
  //   } else {
  //     if (savevoltagelabpostlist.contains(widget.postdata.id)) {
  //       setState(() {
  //         bookmark = true;
  //       });
  //     }
  //   }
  // }

  void postshare(BuildContext context, String link) async {
    final String text = link;
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(text,
        subject: "Voltage Lab",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  void voltagelabsavecategory() {
    VoltageLabSaveCategory saveCategory = VoltageLabSaveCategory(
        categoryname: widget.categoryname, categoryid: widget.categoryid);
    if (savevoltagelabcategorylist
        .any((element) => element.categoryid == widget.categoryid)) {
      print("voltageLab category allrady added");
    } else {
      sqlVoltagelabcategorydb!.insertdata(saveCategory);
    }
  }

  void voltagelabsavepost(Postprovider post) {
    VoltageLabSavepost savepost = VoltageLabSavepost(
        postid: widget.postdata.id!,
        categoryid: widget.categoryid,
        posttitle: widget.postdata.title!.rendered,
        postlink: post.postDetails!.link,
        postcontent: post.postDetails!.content.rendered,
        postimage: widget.postdata.yoastHeadJson!.ogImage[0].url!);

    if (savevoltagelabpostlist
        .any((element) => element.postid == widget.postdata.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This Post Already save")));
    } else {
      sqlVoltagelabpostdb!.insertdata(savepost);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Save Post")));
      post.voltagelabsavepostcount();
    }
  }

  void polytechnicsavecategorydb() {
    En_voltagelabSaveCategory polytechnicCategory = En_voltagelabSaveCategory(
        categoryname: widget.categoryname, categoryid: widget.categoryid);
    if (en_voltagelabSaveCategory
        .any((element) => element.categoryid == widget.categoryid)) {
      // print("polyechnic category allrady added");
    } else {
      sql_en_voltagelabCategoryDB!.insertdata(polytechnicCategory);
    }
  }

  void polytechnicsavepostdb(Postprovider post) {
    En_voltagelabSavepost savepost = En_voltagelabSavepost(
        postid: widget.postdata.id!,
        categoryid: widget.categoryid,
        posttitle: widget.postdata.title!.rendered,
        postlink: post.postDetails!.link,
        postcontent: post.postDetails!.content.rendered,
        postimage: widget.postdata.yoastHeadJson!.ogImage[0].url!);

    if (en_voltagelabSavepost
        .any((element) => element.postid == widget.postdata.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This Post Already save")));
    } else {
      sql_en_VoltagelabPostDB!.insertdata(savepost);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Save Post")));
      post.en_voltagelabsavepostcount();
    }
  }

  void probookmark() {
    var box = Hive.box("userdata");
    print("email_registered_check " + box.length.toString());
    if (box.length != 0) {
      Provider.of<PaymentProvider>(context, listen: false)
          .payment_user__single_info_get(box.get('email'));
    }
  }

  void alartmessage() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "SUBSCRIPTION ALERT",
      desc: "First you buy any premium package. Then you can use bookmarks.",
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

  void alertGuestMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "লগিন এলার্ট",
              style: GoogleFonts.hindSiliguri(
                  color: Colors.red.shade300,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            content: Text(
                "এই ফিচারটি শুধুমাত্র লগিন ইউজার দের জন্য। লগিন / রেজিস্ট্রেশন করতে চাইলে নিচের Login বাটনে ক্লিক করুন।",
                style: Global.bnAlertText),
            actions: <Widget>[
              Row(
                children: [
                  DialogButton(
                    width: 80,
                    color: Colors.white,
                    child: Text("Login",
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: Global.defaultColor,
                          fontWeight: FontWeight.bold,
                        )),
                    onPressed: () async {
                      Navigator.pop(context);
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginPage()));
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
                      onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GuestHomeInitPage()),
                          )),
                ],
              )
            ],
          );
        });
  }

  @override
  void initState() {
    Provider.of<Postprovider>(context, listen: false).getvoltagelabsavepost();
    sqlVoltagelabcategorydb = SqlVoltageLabCategoryDB();
    sqlVoltagelabpostdb = SqlVoltagelabPostDB();
    sql_en_voltagelabCategoryDB = Sql_en_voltagelabCategoryDB();
    sql_en_VoltagelabPostDB = Sql_en_voltagelabPostDB();
    getsavecategoryandpost();
    probookmark();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
    final payment = Provider.of<PaymentProvider>(context);
    final textsize = Provider.of<Otherprovider>(context);
    double expanded_heigth = 300;
    double round_container_heigth = 50;
    getsavecategoryandpost();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              widget.postdata.title!.rendered,
              style: Global.bnPostListAppbarText,
            ),
            leading: IconButton(
                onPressed: () {
                  post.getpostcount();
                  post.get_en_voltagelabpostcount();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              widget.sitename == 'polytechnicbd'
                  ? IconButton(
                      onPressed: () {
                        if (post.isloading == true) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please Wait For Content Loading",
                                style: GoogleFonts.lato()),
                          ));
                        } else {
                          if (payment.subscriptionsingledata != null &&
                              payment.subscriptionsingledata!.status == '1') {
                            polytechnicsavecategorydb();
                            polytechnicsavepostdb(post);
                            post.getpolytechnicsavepost();
                          } else if (payment.subscriptionsingledata == null ||
                              payment.subscriptionsingledata!.status != '1') {
                            var box = Hive.box("userdata");
                            if (box.length != 0) {
                              alartmessage();
                            } else {
                              alertGuestMessage();
                            }
                          }
                        }
                      },
                      icon: Icon(post.en_voltagelabsavepost.any(
                              (element) => element.postid == widget.postdata.id)
                          ? Icons.bookmark
                          : Icons.bookmark_border))
                  : IconButton(
                      onPressed: () {
                        if (post.isloading == true) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            "Please Wait For Content Loading",
                            style: GoogleFonts.lato(),
                          )));
                        } else {
                          if (payment.subscriptionsingledata != null &&
                              payment.subscriptionsingledata!.status == '1') {
                            voltagelabsavecategory();
                            voltagelabsavepost(post);
                            post.getvoltagelabsavepost();
                          } else if (payment.subscriptionsingledata == null ||
                              payment.subscriptionsingledata!.status != '1') {
                            var box = Hive.box("userdata");
                            if (box.length != 0) {
                              alartmessage();
                            } else {
                              alertGuestMessage();
                            }
                          }
                        }
                      },
                      icon: Icon(post.savevoltagelabpost.any(
                              (element) => element.postid == widget.postdata.id)
                          ? Icons.bookmark
                          : Icons.bookmark_border)),
              IconButton(
                  onPressed: () {
                    postshare(context, post.postDetails!.link);
                  },
                  icon: const Icon(Icons.share)),
            ],
          ),
          // SliverPersistentHeader(
          //     delegate: DetailsSliverdelegate(
          //         expendedheigth: expanded_heigth,
          //         photourl: widget.postdata.yoastHeadJson!.ogImage[0].url!,
          //         round_container: round_container_heigth)),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: widget.postdata.yoastHeadJson!.ogImage[0].url!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.postdata.title!.rendered,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          fontFamily: 'SolaimanLipi'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: const Divider(),
            ),
          ),
          SliverToBoxAdapter(
            child: post.isloading
                ? SizedBox(
                    height: 300,
                    child: Center(
                      child: Text(
                        "Loading.......",
                        style: GoogleFonts.lato(),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Html(
                      data: post.postDetails!.content.rendered,
                      onLinkTap: (url, _, __, ___) async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WebViewPage(url: url!),
                            ));
                      },
                      onImageTap: (url, context, attributes, element) {
                        CachedNetworkImage(imageUrl: url!);
                      },
                      style: {
                        // "p": Style(fontSize: FontSize(textsize.textsize), fontFamily: 'SolaimanLipi', letterSpacing: 1.0),

                        "p": Style(
                            fontSize: FontSize(18),
                            fontFamily: 'SolaimanLipi',
                            letterSpacing: 1.5,
                            lineHeight: LineHeight(1.8)),
                        "li": Style(
                            fontSize: FontSize(16), fontFamily: 'SolaimanLipi'),
                        "alt": Style(
                            fontSize: FontSize(textsize.textsize),
                            fontFamily: 'SolaimanLipi'),
                        "strong": Style(
                            fontSize: FontSize(18), fontFamily: 'SolaimanLipi'),
                        "h1": Style(
                            fontSize: FontSize(24), fontFamily: 'SolaimanLipi'),
                        "h2": Style(
                            fontSize: FontSize(22), fontFamily: 'SolaimanLipi'),
                        "h3": Style(
                            fontSize: FontSize(18), fontFamily: 'SolaimanLipi'),
                        "h4": Style(
                            fontSize: FontSize(16), fontFamily: 'SolaimanLipi'),
                        "h5": Style(
                            fontSize: FontSize(12), fontFamily: 'SolaimanLipi'),
                        "h6": Style(
                            fontSize: FontSize(10), fontFamily: 'SolaimanLipi')
                      },
                    ),
                  ),
          )
        ],
      ),
    );
  }
}

// class DetailsSliverdelegate extends SliverPersistentHeaderDelegate {
//   final double expendedheigth;
//   final String photourl;
//   final double round_container;
//   const DetailsSliverdelegate(
//       {required this.photourl,
//       required this.expendedheigth,
//       required this.round_container});
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Image.network(
//           //   photourl,
//           //   width: MediaQuery.of(context).size.width,
//           //   height: expendedheigth,
//           //   fit: BoxFit.cover,
//           // ),
//           CachedNetworkImage(
//             key: UniqueKey(),
//             imageUrl: photourl,
//             fit: BoxFit.cover,
//             width: MediaQuery.of(context).size.width,
//             height: expendedheigth,
//           ),
//           Positioned(
//             top: expendedheigth - round_container + 25 - shrinkOffset,
//             left: 0,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: round_container - 10,
//               decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   )),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   double get maxExtent => expendedheigth;

//   @override
//   double get minExtent => 0;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return true;
//   }
// }
