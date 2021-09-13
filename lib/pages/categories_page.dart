import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/model/category_model.dart';
import 'package:voltagelab/pages/post_page.dart';

class CategoryPage extends StatefulWidget {
  final Categories categories;
  const CategoryPage({Key? key, required this.categories}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int? subcategorylength;

  subcategoryfilter() {
    final category = Provider.of<CategoryProvider>(context, listen: false);
    if (category.subcategory.length == 0) {
      setState(() {
        subcategorylength = 0;
      });
    } else {
      setState(() {
        subcategorylength = category.subcategory.length;
      });
    }
  }

  @override
  void initState() {
    subcategoryfilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    subcategoryfilter();
    print(category.subcategory.length);
    return category.isloading == true
        ? Scaffold(
            appBar: AppBar(
              title: Text(widget.categories.name!),
            ),
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : DefaultTabController(
            length: category.subcategory.length == 0
                ? 0
                : category.subcategory.length,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(widget.categories.name!),
                bottom: TabBar(
                  tabs: List.generate(
                      category.subcategory.length == 0
                          ? 0
                          : category.subcategory.length,
                      (index) => Tab(
                            child: Text(category.subcategory.length == 0
                                ? widget.categories.name!
                                : category.subcategory[index].name!),
                          )),
                  isScrollable: true,
                  enableFeedback: true,
                  indicatorColor: Colors.green,
                ),
              ),
              body: TabBarView(
                children: List.generate(
                  category.subcategory.length == 0
                      ? 0
                      : category.subcategory.length,
                  (index) => PostPage(
                    subcategory: category.subcategory[index],
                    categoryid: category.subcategory.length == 0
                        ? widget.categories.id!
                        : category.subcategory[index].id!,
                  ),
                ),
              ),
            ),
          );
  }
}
