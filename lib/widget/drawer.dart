import 'package:flutter/material.dart';
import 'package:voltagelab/Bookmark/bookmarkcategory_page.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookMarkCategoryPage(),
                  ));
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Text("Bookmark"),
            ),
          )
        ],
      ),
    );
  }
}
