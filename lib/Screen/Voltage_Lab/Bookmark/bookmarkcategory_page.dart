import 'package:flutter/material.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/category_model.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/category_db.dart';

import 'bookmarkpost_page.dart';

class VoltagelabBookMarkCategoryPage extends StatefulWidget {
  const VoltagelabBookMarkCategoryPage({Key? key}) : super(key: key);

  @override
  _VoltagelabBookMarkCategoryPageState createState() =>
      _VoltagelabBookMarkCategoryPageState();
}

class _VoltagelabBookMarkCategoryPageState
    extends State<VoltagelabBookMarkCategoryPage> {
  SqlVoltageLabCategoryDB? sqldbprovider;
  List<VoltageLabSaveCategory> category = [];

  getdata() async {
    category = await sqldbprovider!.getdata();
    setState(() {});
  }

  @override
  void initState() {
    sqldbprovider = SqlVoltageLabCategoryDB();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voltage Lab Bookmark"),
      ),
      body: ListView.builder(
        itemCount: category.length,
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
                        builder: (context) => VoltagelabBookmarkPostpage(
                          categorymainid: category[index].id!,
                          categoryid: category[index].categoryid,
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
                        category[index].categoryname,
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
