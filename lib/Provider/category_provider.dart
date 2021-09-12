import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  bool isloading = false;
  List<Categories> category = [];

  Future getcategory() async {
    isloading = true;
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/categories?per_page=100";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        category = categoriesFromJson(jsondata);
        isloading = false;
        notifyListeners();
      }
    } catch (e) {
      isloading = false;

      print(e);
      notifyListeners();
    }
  }
}
