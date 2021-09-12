import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voltagelab/Provider/category_provider.dart';
import 'package:voltagelab/model/subcategory.dart';

class ListcategoryPage extends StatefulWidget {
  const ListcategoryPage({Key? key}) : super(key: key);

  @override
  _ListcategoryPageState createState() => _ListcategoryPageState();
}

class _ListcategoryPageState extends State<ListcategoryPage> {
  int? categoryindex;
  bool subcategoryshow = false;

  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false).getcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: category.category.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    category.getsubcategory(category.category[index].id!);
                    Future.delayed(Duration(milliseconds: 1100), () {
                      category.setcategoryindex(index);
                    });
                    print(category.subcategory.length);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      category.category[index].name!,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Divider(height: 0),
                if (category.categoryindex == index) SubCategoryPage(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({Key? key}) : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context);
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: category.subcategory.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    category.subcategory[index].name!,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Divider(height: 0),
            ],
          );
        },
      ),
    );
  }
}
