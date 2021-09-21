import 'package:flutter/material.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/Model/category_model.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/db/category_db.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/category_model.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/category_db.dart';

import 'bookmarkpost_page.dart';

class PolytechnicBookMarkCategoryPage extends StatefulWidget {
  const PolytechnicBookMarkCategoryPage({Key? key}) : super(key: key);

  @override
  _PolytechnicBookMarkCategoryPageState createState() =>
      _PolytechnicBookMarkCategoryPageState();
}

class _PolytechnicBookMarkCategoryPageState
    extends State<PolytechnicBookMarkCategoryPage> {
  SqlPolytechnicCategoryDB? sqlPolytechnicCategoryDB;
  List<PolytechnicSaveCategory> polytechnicsavecategoyr = [];

  getdata() async {
    polytechnicsavecategoyr = await sqlPolytechnicCategoryDB!.getdata();
    setState(() {});
  }

  @override
  void initState() {
    sqlPolytechnicCategoryDB = SqlPolytechnicCategoryDB();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polytechnic Bookmark"),
      ),
      body: ListView.builder(
        itemCount: polytechnicsavecategoyr.length,
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
                        builder: (context) => PolytechnicBookmarkPostpage(
                          categorymainid: polytechnicsavecategoyr[index].id!,
                          categoryid: polytechnicsavecategoyr[index].categoryid,
                        ),
                      )).then((value) {
                    setState(() {
                      getdata();
                    });
                  });
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    children: [
                      Text(
                        polytechnicsavecategoyr[index].categoryname,
                        style: const TextStyle(fontSize: 17),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(100)),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
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
