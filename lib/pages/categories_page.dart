// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/model/category_model.dart';
import 'package:voltagelab/model/subcategory.dart';
import 'package:voltagelab/pages/post_page.dart';


class CategoryPage extends StatefulWidget {
  final Categories categories;
  const CategoryPage({Key? key, required this.categories}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  double crossAxisSpacing = 8, mainAxisSpacing = 8, aspectRatio = 2;
  int crossAxisCount = 3;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<CategoryProvider>(context, listen: false)
          .getsubcategory(widget.categories.id!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    var width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) / crossAxisCount;
    var height = width / aspectRatio;
    return category.subcategory!.isEmpty ? PostPage(categoryid: widget.categories.id!, categoryname: widget.categories.name!)
     : Scaffold(
      appBar: AppBar(title: Text(widget.categories.name!),),
      body: category.loading ? const Center(child: CircularProgressIndicator()) :  SingleChildScrollView(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: aspectRatio,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: category.subcategory!.length,
          itemBuilder: (context, index) {
            return Container(
              height: height,
              width: width,
              color: Colors.grey[300],
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage(categoryid: category.subcategory![index].id!, categoryname: category.subcategory![index].name!)));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(category.subcategory![index].name!),
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
