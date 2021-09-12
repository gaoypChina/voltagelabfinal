import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/pages/post_page.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    return category.isloading == true
        ? Scaffold(
            appBar: AppBar(
              title: Text("Home"),
            ),
            body: Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : DefaultTabController(
            length: category.category.length,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text("Home"),
                bottom: TabBar(
                  tabs: List.generate(
                      category.category.length,
                      (index) => Tab(
                            child: Text(category.category[index].name!),
                          )),
                  isScrollable: true,
                  enableFeedback: true,
                  indicatorColor: Colors.green,
                ),
              ),
              body: TabBarView(
                  children: List.generate(
                      category.category.length,
                      (index) => PostPage(
                            categories: category.category[index],
                          ))),
            ),
          );
  }
}
