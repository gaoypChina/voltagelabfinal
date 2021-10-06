// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/Model/post_model.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/db/category_db.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/db/post_db.dart';
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
