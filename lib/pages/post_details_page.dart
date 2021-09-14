import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/Sqflite/Model/category_model.dart';
import 'package:voltagelab/Sqflite/Model/post_model.dart';
import 'package:voltagelab/Sqflite/category_db.dart';
import 'package:voltagelab/Sqflite/post_db.dart';
import 'package:voltagelab/model/post_model.dart';
import 'package:share/share.dart';

class PostDetailsPage extends StatefulWidget {
  final String categoryname;
  final int categoryid;
  final Postdata postdata;
  const PostDetailsPage(
      {Key? key,
      required this.postdata,
      required this.categoryname,
      required this.categoryid})
      : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {

  bool bookmark = false;

  SqlCategoryDB? sqldbprovider;
  SqlPostDB? sqlPostDB;

  List<SaveCategory> savecategorylist = [];
  List<Savepost> savepostlist = [];

  getsavecategoryandpost() async {
    savecategorylist = await sqldbprovider!.getdata();
    savepostlist = await sqlPostDB!.getdata();
    setState(() {});
  }

  bookmarkdata() {
    if (savepostlist.contains(widget.postdata.id)) {
      setState(() {
        bookmark = true;
      });
    }
  }

  void postshare(BuildContext context, String link) async {
    final scaffoldkey = GlobalKey<ScaffoldState>();
    final String text = link;
    final RenderBox box = context.findRenderObject() as RenderBox;
    await Share.share(text,
        subject: "Voltage Lab",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  @override
  void initState() {
    Provider.of<Postprovider>(context, listen: false).getsavepost();
    sqldbprovider = SqlCategoryDB();
    sqlPostDB = SqlPostDB();
    getsavecategoryandpost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              widget.postdata.title!.rendered!,
              style: TextStyle(color: Colors.black),
            ),
            pinned: true,
            actions: [
              IconButton(
                  onPressed: () {
                    
                    SaveCategory saveCategory = SaveCategory(
                        categoryname: widget.categoryname,
                        categoryid: widget.categoryid);

                    if (savecategorylist.any(
                        (element) => element.categoryid == widget.categoryid)) {
                      print("category allrady added");
                    } else {
                      sqldbprovider!.insertdata(saveCategory);
                    }

                    Savepost savepost = Savepost(
                        postid: widget.postdata.id!,
                        categoryid: widget.categoryid,
                        posttitle: widget.postdata.title!.rendered!,
                        postdate: widget.postdata.date.toString(),
                        postlink: widget.postdata.link!,
                        postcontent: widget.postdata.content!.rendered!,
                        postimage:
                            widget.postdata.yoastHeadJson!.ogImage![0].url!);

                    if (savepostlist.any(
                        (element) => element.postid == widget.postdata.id)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("This Post Already save")));
                    } else {
                      sqlPostDB!.insertdata(savepost);
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("Save Post")));
                    }
                    post.getsavepost();
                  },
                  icon: Icon(post.savepost.any(
                          (element) => element.postid == widget.postdata.id)
                      ? Icons.bookmark
                      : Icons.bookmark_border)),
              IconButton(
                  onPressed: () {
                    postshare(context, widget.postdata.link!);
                  },
                  icon: Icon(Icons.share)),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  key: UniqueKey(),
                  imageUrl: widget.postdata.yoastHeadJson!.ogImage![0].url!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      widget.postdata.title!.rendered!,
                      style: TextStyle(
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
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Divider(),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Container(
                child: Html(
                  data: widget.postdata.content!.rendered,
                  onLinkTap: (url, _, __, ___) async {
                    if (await canLaunch(url!)) {
                      await launch(
                        url,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  onImageTap: (url, context, attributes, element) {
                    CachedNetworkImage(imageUrl: url!);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
