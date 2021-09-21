// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/post_model.dart';

import 'package:voltagelab/Sqflite/VoltageLab_local_db/category_db.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/post_db.dart';


import 'bookmarkpost_details.dart';


class BookmarkPostpage extends StatefulWidget {
  final int categoryid;
  final int categorymainid;
  const BookmarkPostpage(
      {Key? key, required this.categoryid, required this.categorymainid})
      : super(key: key);

  @override
  _BookmarkPostpageState createState() => _BookmarkPostpageState();
}

class _BookmarkPostpageState extends State<BookmarkPostpage> {
  List<Savepost> savepost = [];
  SqlPostDB? sqlPostDB;
  SqlCategoryDB? sqlCategoryDB;

  getsavepost() async {
    savepost = await sqlPostDB!.getdata();
    setState(() {});
  }

  @override
  void initState() {
    sqlPostDB = SqlPostDB();
    sqlCategoryDB = SqlCategoryDB();
    getsavepost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Savepost> postlist = [];
    savepost
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
                        builder: (context) => BookmarkPostDetails(
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
