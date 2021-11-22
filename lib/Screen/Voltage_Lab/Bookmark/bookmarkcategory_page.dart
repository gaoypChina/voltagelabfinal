import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/category_model.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/category_db.dart';
import 'package:voltagelab/helper/global.dart';

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
    final post = Provider.of<Postprovider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              post.getpostcount();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black,)),
        title:  Text("বুকমার্ক-বাংলা টপিক", style: Global.bnPostListAppbarText,),
      ),
      body: ListView.builder(
        itemCount: category.length,
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
                        builder: (context) => VoltagelabBookmarkPostpage(
                          categorymainid: category[index].id!,
                          categoryid: category[index].categoryid,
                          categoryName: category[index].categoryname,
                        ),
                      )).then((value) {
                    setState(() {
                      getdata();
                    });
                  });
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text(
                        category[index].categoryname,
                        style: Global.bnListTitleText,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white,
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
