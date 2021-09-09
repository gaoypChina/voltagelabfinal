import 'package:flutter/material.dart';
import 'package:voltagelab/helper/global.dart';
import 'package:voltagelab/model/category_model.dart';
import 'package:voltagelab/pages/home_page.dart';
import 'package:voltagelab/widget/mainappbar.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(),
    debugShowCheckedModeBanner: false,
    home: HomePage(category: allcategory[0]),
  ));
}


class HomePage extends StatelessWidget{
  Category category;

  HomePage({Key? key, required this.category}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainAppbar(appBar: "test")
        ],
      )
    );
  }

  //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
//test
//push

}



