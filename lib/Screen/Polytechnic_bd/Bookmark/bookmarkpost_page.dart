// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/Model/post_model.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/db/category_db.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/db/post_db.dart';


import 'bookmarkpost_details.dart';

class PolytechnicBookmarkPostpage extends StatefulWidget {
  final int categoryid;
  final int categorymainid;
  const PolytechnicBookmarkPostpage(
      {Key? key, required this.categoryid, required this.categorymainid})
      : super(key: key);

  @override
  _PolytechnicBookmarkPostpageState createState() =>
      _PolytechnicBookmarkPostpageState();
}

class _PolytechnicBookmarkPostpageState
    extends State<PolytechnicBookmarkPostpage> {


  List<PolytechnicSavepost> polytechnicsavepost = [];

  SqlPolytechnicPostDB? sqlPolytechnicPostDB;
  SqlPolytechnicCategoryDB? sqlPolytechnicCategoryDB;

  getsavepost() async {
   
    polytechnicsavepost = await sqlPolytechnicPostDB!.getdata();
    setState(() {});
  }

  @override
  void initState() {
    sqlPolytechnicPostDB = SqlPolytechnicPostDB();
    sqlPolytechnicCategoryDB = SqlPolytechnicCategoryDB();
    getsavepost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<PolytechnicSavepost> postlist = [];
    polytechnicsavepost
        .where((element) => element.categoryid == widget.categoryid)
        .forEach((element) => postlist.add(element));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: ListView.builder(
        itemCount: postlist.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(6)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PolytechnicBookmarkPostDetails(
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
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          postlist[index].posttitle,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (postlist.length == 1) {
                            sqlPolytechnicPostDB!.delete(postlist[index].id!);
                            getsavepost();
                            sqlPolytechnicCategoryDB!.delete(widget.categorymainid);
                            Navigator.pop(context);
                            print("category deletc");
                          } else {
                            sqlPolytechnicPostDB!.delete(postlist[index].id!);
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
