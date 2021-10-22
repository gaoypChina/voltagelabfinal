import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/Provider/post_provider.dart';
import 'package:voltagelab/Screen/Voltage_Lab/Bookmark/bookmarkcategory_page.dart';
import 'package:voltagelab/pages/categories_page.dart';
import 'package:voltagelab/pages/search_page.dart';

class Pro_en_Vl_CategoryPage extends StatefulWidget {
  const Pro_en_Vl_CategoryPage({Key? key}) : super(key: key);

  @override
  _Pro_en_Vl_CategoryPageState createState() => _Pro_en_Vl_CategoryPageState();
}

class _Pro_en_Vl_CategoryPageState extends State<Pro_en_Vl_CategoryPage> {
  int? categoryindex;
  bool subcategoryshow = false;

  String sitename = 'polytechnicbd';

  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).get_pro_en_vl_categorylist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('voltagelabbadge');
    final category = Provider.of<CategoryProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            pinned: true,
            centerTitle: true,
            backgroundColor: Colors.indigoAccent,
            title: Text("Category"),
            actions: [
              // IconButton(
              //     onPressed: () {
              //       box.clear();

              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) =>
              //                 const VoltagelabBookMarkCategoryPage(),
              //           ));
              //     },
              //     icon: Badge(
              //         badgeContent:
              //             Text(post.voltagelabsavepostbadge.toString()),
              //         child: const Icon(Icons.bookmark_outline)))
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage(sitename: sitename),
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 20),
                          child: TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.7),
                              prefixIcon: const Icon(Icons.search),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              disabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                borderSide: BorderSide(
                                    width: 0, color: Colors.transparent),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(
                                    width: 0,
                                  )),
                              errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.transparent)),
                              focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  borderSide: BorderSide(
                                      width: 0, color: Colors.transparent)),
                              hintText: "Search Anything",
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Pro Categories",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5),
              ),
            ),
          ),
          category.loading
              ? SliverToBoxAdapter(
                  child: Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Color color = Colors
                          .primaries[Random().nextInt(Colors.primaries.length)];
                      var procategory = category.pro_en_vl_categorylist[index];
                      return Container(
                        margin: EdgeInsets.only(
                            left: index % 2 == 0 ? 15 : 10,
                            bottom: 15,
                            right: index % 2 != 0 ? 15 : 10),
                        decoration: BoxDecoration(
                            // color: color.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(40)),
                        child: InkWell(
                          onTap: () {
                            Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .getsubcategory(procategory.id!, sitename);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryPage(
                                    sitename: sitename,
                                    categoryid: procategory.id!,
                                    categoryname: procategory.name!,
                                  ),
                                ));
                          },
                          borderRadius: BorderRadius.circular(40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                // height: 80,
                                // width: 80,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    'images/youtube.png',
                                    height: 80,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  procategory.name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: color.withOpacity(1),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: category.pro_en_vl_categorylist.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.98,
                  ),
                )
        ],
      ),
    );
  }
}





// Column(
//           children: [
//             Container(
//               height: 170,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.indigoAccent,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     child: Container(
//                       padding: EdgeInsets.all(18),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Icon(Icons.arrow_back_ios),
//                           Text(
//                             "Category",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.w400),
//                           ),
//                           Icon(Icons.notifications_none)
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white.withOpacity(0.7),
//                         prefixIcon: Icon(Icons.search),
//                         contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           borderSide:
//                               BorderSide(width: 0, color: Colors.transparent),
//                         ),
//                         disabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           borderSide:
//                               BorderSide(width: 0, color: Colors.transparent),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(50)),
//                           borderSide:
//                               BorderSide(width: 0, color: Colors.transparent),
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(50)),
//                             borderSide: BorderSide(
//                               width: 0,
//                             )),
//                         errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(50)),
//                             borderSide: BorderSide(
//                                 width: 0, color: Colors.transparent)),
//                         focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(50)),
//                             borderSide: BorderSide(
//                                 width: 0, color: Colors.transparent)),
//                         hintText: "Search Anything",
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
