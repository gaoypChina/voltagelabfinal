import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class BookMarkPage extends StatefulWidget {
  const BookMarkPage({Key? key}) : super(key: key);

  @override
  _BookMarkPageState createState() => _BookMarkPageState();
}

class _BookMarkPageState extends State<BookMarkPage> {
  Box? box;

  @override
  void initState() {
    box = Hive.box('bookmark');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List savepostlist = box!.toMap().values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: savepostlist.length,
          itemBuilder: (context, index) {
            return Container(
              child: Text(savepostlist[index]['title'].toString()),
            );
          },
        ),
      ),
    );
  }
}
