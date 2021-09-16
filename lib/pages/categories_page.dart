// ignore_for_file: prefer_is_empty

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab_v4/Provider/category_provider.dart';
import 'package:voltagelab_v4/model/category_model.dart';
import 'package:voltagelab_v4/model/subcategory.dart';
import 'package:voltagelab_v4/pages/post_page.dart';

class CategoryPage extends StatefulWidget {
  final Categories categories;
  const CategoryPage({Key? key, required this.categories}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<SubCategory> subcategory = [];

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
    return  DefaultTabController(
            length:
                category.subcategory.isEmpty ? 1 : category.subcategory.length,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Text(widget.categories.name!),
                bottom: category.subcategory.isEmpty
                    ? null
                    : TabBar(
                        tabs: List.generate(
                            category.subcategory.isEmpty
                                ? 1
                                : category.subcategory.length,
                            (index) => Tab(
                                  child: Text(category.subcategory.isEmpty
                                      ? widget.categories.name!
                                      : category.subcategory[index].name!),
                                )),
                        isScrollable: true,
                        enableFeedback: true,
                      ),
              ),
              body: TabBarView(
                children: List.generate(
                  category.subcategory.length == 0
                      ? 1
                      : category.subcategory.length,
                  (index) => PostPage(
                    categoryname: category.subcategory.isEmpty
                        ? widget.categories.name!
                        : category.subcategory[index].name!,
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
