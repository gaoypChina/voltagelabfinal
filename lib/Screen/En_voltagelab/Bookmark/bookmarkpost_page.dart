// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/Model/post_model.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/db/category_db.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/db/post_db.dart';
import 'package:voltagelab/helper/global.dart';
import 'bookmarkpost_details.dart';

class VLEngBookmarkPostPage extends StatefulWidget {
  final int categoryid;
  final int categorymainid;
  String categoryName;
  VLEngBookmarkPostPage(
      {Key? key, required this.categoryid, required this.categorymainid, required this.categoryName})
      : super(key: key);

  @override
  _VLEngBookmarkPostPageState createState() =>
      _VLEngBookmarkPostPageState();
}

class _VLEngBookmarkPostPageState
    extends State<VLEngBookmarkPostPage> {


  List<En_voltagelabSavepost> en_voltagelabsavepost = [];

  Sql_en_voltagelabPostDB? sql_en_voltagelabPostDB;
  Sql_en_voltagelabCategoryDB? sql_en_voltagelabCategoryDB;

  getsavepost() async {
   
    en_voltagelabsavepost = await sql_en_voltagelabPostDB!.getdata();
    setState(() {});
  }

  @override
  void initState() {
    sql_en_voltagelabPostDB = Sql_en_voltagelabPostDB();
    sql_en_voltagelabCategoryDB = Sql_en_voltagelabCategoryDB();
    getsavepost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<En_voltagelabSavepost> postlist = [];
    en_voltagelabsavepost
        .where((element) => element.categoryid == widget.categoryid)
        .forEach((element) => postlist.add(element));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title:  Text(widget.categoryName.toString(),style: Global.enPostListAppbarText,),
      ),
      body: ListView.builder(
        itemCount: postlist.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                ),
                boxShadow: [
            BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3), // changes position of shadow
          ),]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => En_voltagelabBookmarkPostDetails(
                            categoryid: postlist[index].categoryid,
                            id: postlist[index].postid,
                            link: postlist[index].postlink,
                            title: postlist[index].posttitle,
                            content: postlist[index].postcontent,
                            yoastHeadJson: postlist[index].postimage),
                      ));
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          postlist[index].posttitle,
                          style: Global.enListTitleText,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (postlist.length == 1) {
                            sql_en_voltagelabPostDB!.delete(postlist[index].id!);
                            getsavepost();
                            sql_en_voltagelabCategoryDB!.delete(widget.categorymainid);
                            Navigator.pop(context);
                            print("category deletc");
                          } else {
                            sql_en_voltagelabPostDB!.delete(postlist[index].id!);
                            getsavepost();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.delete,
                            size: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
