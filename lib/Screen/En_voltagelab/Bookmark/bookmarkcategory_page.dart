// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/Model/category_model.dart';
import 'package:voltagelab/Sqflite/En_VoltageLab/db/category_db.dart';

import 'bookmarkpost_page.dart';

class En_voltagelabBookMarkCategoryPage extends StatefulWidget {
  const En_voltagelabBookMarkCategoryPage({Key? key}) : super(key: key);

  @override
  _En_voltagelabBookMarkCategoryPageState createState() =>
      _En_voltagelabBookMarkCategoryPageState();
}

class _En_voltagelabBookMarkCategoryPageState
    extends State<En_voltagelabBookMarkCategoryPage> {
  Sql_en_voltagelabCategoryDB? sql_en_voltagelabCategoryDB;
  List<En_voltagelabSaveCategory> en_voltagelabsavecategoyr = [];

  getdata() async {
    en_voltagelabsavecategoyr = await sql_en_voltagelabCategoryDB!.getdata();
    setState(() {});
  }

  @override
  void initState() {
    sql_en_voltagelabCategoryDB = Sql_en_voltagelabCategoryDB();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              post.get_en_voltagelabpostcount();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Polytechnic Bookmark"),
      ),
      body: ListView.builder(
        itemCount: en_voltagelabsavecategoyr.length,
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
                          categorymainid: en_voltagelabsavecategoyr[index].id!,
                          categoryid: en_voltagelabsavecategoyr[index].categoryid,
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
                        en_voltagelabsavecategoyr[index].categoryname,
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
