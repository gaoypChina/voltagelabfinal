// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/post_model.dart';

import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/category_db.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/post_db.dart';
import 'package:voltagelab/helper/global.dart';


import 'bookmarkpost_details.dart';


class VoltagelabBookmarkPostpage extends StatefulWidget {
  final int categoryid;
  final int categorymainid;
  final String categoryName;
  const VoltagelabBookmarkPostpage(
      {Key? key, required this.categoryid, required this.categorymainid, required this.categoryName})
      : super(key: key);

  @override
  _VoltagelabBookmarkPostpageState createState() => _VoltagelabBookmarkPostpageState();
}

class _VoltagelabBookmarkPostpageState extends State<VoltagelabBookmarkPostpage> {
  List<VoltageLabSavepost> savepost = [];
  SqlVoltagelabPostDB? sqlPostDB;
  SqlVoltageLabCategoryDB? sqlCategoryDB;

  getsavepost() async {
    savepost = await sqlPostDB!.getdata();
    setState(() {});
  }

  @override
  void initState() {
    sqlPostDB = SqlVoltagelabPostDB();
    sqlCategoryDB = SqlVoltageLabCategoryDB();
    getsavepost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<VoltageLabSavepost> postlist = [];
    savepost
        .where((element) => element.categoryid == widget.categoryid)
        .forEach((element) => postlist.add(element));
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title:  Text(widget.categoryName, style: Global.bnPostListAppbarText,),

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
                  ),
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VoltagelabBookmarkPostDetails(
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
                          style: Global.bnListTitleText,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (postlist.length == 1) {
                            sqlPostDB!.delete(postlist[index].id!);
                            getsavepost();
                            sqlCategoryDB!.delete(widget.categorymainid);
                            Navigator.pop(context);
                            print("category deletc");
                          } else {
                            sqlPostDB!.delete(postlist[index].id!);
                            getsavepost();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.delete,
                            size: 20,
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
