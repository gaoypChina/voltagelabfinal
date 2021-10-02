// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/pages/post_page.dart';

class CategoryPage extends StatefulWidget {
  final int categoryid;
  final String categoryname;
  final String sitename;
  const CategoryPage({
    Key? key,
    required this.categoryid,
    required this.categoryname,
    required this.sitename,
  }) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  double crossAxisSpacing = 8, mainAxisSpacing = 8, aspectRatio = 2;
  int crossAxisCount = 3;

  @override
  void initState() {
    // Future.delayed(Duration.zero, () {
    //   Provider.of<CategoryProvider>(context, listen: false)
    //       .getsubcategory(widget.categoryid);
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    var width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) /
        crossAxisCount;
    var height = width / aspectRatio;
    return category.subcategory!.isEmpty
        ? PostPage(
            sitename: widget.sitename,
            categoryid: widget.categoryid,
            categoryname: widget.categoryname)
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                widget.categoryname,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            body: category.loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: category.subcategory!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(100)),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PostPage(
                                                  sitename: widget.sitename,
                                                  categoryid: category
                                                      .subcategory![index].id!,
                                                  categoryname: category
                                                      .subcategory![index]
                                                      .name!)));
                                    },
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                category.subcategory![index].name!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          );
  }
}

// DefaultTabController(
//             length:
//                 category.subcategory.isEmpty ? 1 : category.subcategory.length,
//             child: Scaffold(
//               appBar: AppBar(
//                 elevation: 0,
//                 title: Text(widget.categories.name!),
//                 bottom: category.subcategory.isEmpty
//                     ? null
//                     : TabBar(
//                         tabs: List.generate(
//                             category.subcategory.isEmpty
//                                 ? 1
//                                 : category.subcategory.length,
//                             (index) => Tab(
//                                   child: Text(category.subcategory.isEmpty
//                                       ? widget.categories.name!
//                                       : category.subcategory[index].name!),
//                                 )),
//                         isScrollable: true,
//                         enableFeedback: true,
//                       ),
//               ),
//               body: TabBarView(
//                 children: List.generate(
//                   category.subcategory.length == 0
//                       ? 1
//                       : category.subcategory.length,
//                   (index) => PostPage(
//                     categoryname: category.subcategory.isEmpty
//                         ? widget.categories.name!
//                         : category.subcategory[index].name!,
//                     categoryid: category.subcategory.length == 0
//                         ? widget.categories.id!
//                         : category.subcategory[index].id!,
//                   ),
//                 ),
//               ),
//             ),
//           );
