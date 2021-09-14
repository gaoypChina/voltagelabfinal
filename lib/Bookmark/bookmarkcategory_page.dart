import 'package:flutter/material.dart';
import 'package:voltagelab/Bookmark/bookmarkpost_page.dart';
import 'package:voltagelab/Sqflite/Model/category_model.dart';
import 'package:voltagelab/Sqflite/category_db.dart';

class BookMarkCategoryPage extends StatefulWidget {
  const BookMarkCategoryPage({Key? key}) : super(key: key);

  @override
  _BookMarkCategoryPageState createState() => _BookMarkCategoryPageState();
}

class _BookMarkCategoryPageState extends State<BookMarkCategoryPage> {
  SqlCategoryDB? sqldbprovider;
  List<SaveCategory> category = [];

  getdata() async {
    category = await sqldbprovider!.getdata();
    setState(() {});
  }

  @override
  void initState() {
    sqldbprovider = SqlCategoryDB();
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: category.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
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
                          builder: (context) => BookmarkPostpage(
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
                    padding: EdgeInsets.all(30),
                    child: Row(
                      children: [
                        Text(
                          category[index].categoryname,
                          style: TextStyle(fontSize: 17),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
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
      ),
    );
  }
}
