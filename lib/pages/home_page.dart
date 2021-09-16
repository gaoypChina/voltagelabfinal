import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab_v4/Provider/category_provider.dart';
import 'package:voltagelab_v4/widget/drawer.dart';

import 'listcategory_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List gridnamelist = [
    "Blog",
    "Converter",
    "Blog",
    "Converter",
    "Blog",
    "Converter",
  ];

  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerPage(),
        appBar: AppBar(
          title: const Text("Voltage Lab"),
        ),
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverGrid.count(
              crossAxisCount: 2,
              children: List.generate(gridnamelist.length, (index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ListcategoryPage(),
                              ));
                        },
                        child: Container(
                          height: 80.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          // ignore: unnecessary_brace_in_string_interps
                          child: Image.asset("images/img${index}.png",
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        gridnamelist[index],
                      )
                    ],
                  ),
                );
              }),
            )
          ],
        ));
  }
}
