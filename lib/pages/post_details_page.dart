// ignore_for_file: iterable_contains_unrelated_type, avoid_print

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:share/share.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/Model/category_model.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/Model/post_model.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/db/category_db.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/db/post_db.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/category_model.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/post_model.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/category_db.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/post_db.dart';
import 'package:voltagelab/model/post_model.dart';
import 'package:voltagelab/web_View/web_view.dart';

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

  SqlVoltageLabCategoryDB? sqlVoltagelabcategorydb;
  SqlVoltagelabPostDB? sqlVoltagelabpostdb;

  SqlPolytechnicPostDB? sqlPolytechnicPostDB;
  SqlPolytechnicCategoryDB? sqlPolytechnicCategoryDB;

  List<VoltageLabSaveCategory> savevoltagelabcategorylist = [];
  List<VoltageLabSavepost> savevoltagelabpostlist = [];

  List<PolytechnicSaveCategory> polytechnicSaveCategory = [];
  List<PolytechnicSavepost> polytechnicSavepost = [];

  getsavecategoryandpost() async {
    savevoltagelabcategorylist = await sqlVoltagelabcategorydb!.getdata();
    savevoltagelabpostlist = await sqlVoltagelabpostdb!.getdata();
    polytechnicSaveCategory = await sqlPolytechnicCategoryDB!.getdata();
    polytechnicSavepost = await sqlPolytechnicPostDB!.getdata();
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
        postid: widget.postdata.id,
        categoryid: widget.categoryid,
        posttitle: widget.postdata.title.rendered,
        postlink: post.postDetails!.link,
        postcontent: post.postDetails!.content.rendered,
        postimage: widget.postdata.yoastHeadJson.ogImage[0].url);

    if (savevoltagelabpostlist
        .any((element) => element.postid == widget.postdata.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This Post Already save")));
    } else {
      sqlVoltagelabpostdb!.insertdata(savepost);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Save Post")));
    }
  }

  void polytechnicsavecategorydb() {
    PolytechnicSaveCategory polytechnicCategory = PolytechnicSaveCategory(
        categoryname: widget.categoryname, categoryid: widget.categoryid);
    if (polytechnicSaveCategory
        .any((element) => element.categoryid == widget.categoryid)) {
      print("polyechnic category allrady added");
    } else {
      sqlPolytechnicCategoryDB!.insertdata(polytechnicCategory);
    }
  }

  void polytechnicsavepostdb(Postprovider post) {
    PolytechnicSavepost savepost = PolytechnicSavepost(
        postid: widget.postdata.id,
        categoryid: widget.categoryid,
        posttitle: widget.postdata.title.rendered,
        postlink: post.postDetails!.link,
        postcontent: post.postDetails!.content.rendered,
        postimage: widget.postdata.yoastHeadJson.ogImage[0].url);

    if (polytechnicSavepost
        .any((element) => element.postid == widget.postdata.id)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This Post Already save")));
    } else {
      sqlPolytechnicPostDB!.insertdata(savepost);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Save Post")));
    }
  }

  @override
  void initState() {
    Provider.of<Postprovider>(context, listen: false).getvoltagelabsavepost();
    sqlVoltagelabcategorydb = SqlVoltageLabCategoryDB();
    sqlVoltagelabpostdb = SqlVoltagelabPostDB();
    sqlPolytechnicCategoryDB = SqlPolytechnicCategoryDB();
    sqlPolytechnicPostDB = SqlPolytechnicPostDB();
    getsavecategoryandpost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
    getsavecategoryandpost();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            title: Text(
              widget.postdata.title.rendered,
              style: const TextStyle(color: Colors.black),
            ),
            pinned: true,
            actions: [
              IconButton(
                  onPressed: () {
                    if (widget.sitename == 'polytechnicbd') {
                      polytechnicsavecategorydb();
                      polytechnicsavepostdb(post);
                    } else {
                      voltagelabsavecategory();
                      voltagelabsavepost(post);
                    }
                    post.getvoltagelabsavepost();
                    post.getpolytechnicsavepost();

                    // VoltageLabSaveCategory saveCategory =
                    //     VoltageLabSaveCategory(
                    //         categoryname: widget.categoryname,
                    //         categoryid: widget.categoryid);
                    // if (savevoltagelabcategorylist.any(
                    //     (element) => element.categoryid == widget.categoryid)) {
                    //   print("category allrady added");
                    // } else {
                    //   sqlVoltagelabcategorydb!.insertdata(saveCategory);
                    // }
                    // VoltageLabSavepost savepost = VoltageLabSavepost(
                    //     postid: widget.postdata.id,
                    //     categoryid: widget.categoryid,
                    //     posttitle: widget.postdata.title.rendered,
                    //     postlink: post.postDetails!.link,
                    //     postcontent: post.postDetails!.content.rendered,
                    //     postimage:
                    //         widget.postdata.yoastHeadJson.ogImage[0].url);

                    // if (savevoltagelabpostlist.any(
                    //     (element) => element.postid == widget.postdata.id)) {
                    //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //       content: Text("This Post Already save")));
                    // } else {
                    //   sqlVoltagelabpostdb!.insertdata(savepost);
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text("Save Post")));
                    // }
                  },
                  icon: Icon(post.savevoltagelabpost.any((element) =>
                          element.postid == widget.postdata.id ||
                          post.polytechnicsavepost.any((element) =>
                              element.postid == widget.postdata.id))
                      ? Icons.bookmark
                      : Icons.bookmark_border)),
              IconButton(
                  onPressed: () {
                    postshare(context, post.postDetails!.link);
                  },
                  icon: const Icon(Icons.share)),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: widget.postdata.yoastHeadJson.ogImage[0].url,
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
                      widget.postdata.title.rendered,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
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
            child: SingleChildScrollView(
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
              ),
            ),
          )
        ],
      ),
    );
  }
}
