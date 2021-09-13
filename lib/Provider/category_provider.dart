import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/category_model.dart';
import 'package:voltagelab/model/subcategory.dart';

class CategoryProvider extends ChangeNotifier {
  bool isloading = false;
  int? categoryindex;
  List<Categories> category = [];
  List<SubCategory> subcategory = [];

  Future getcategory() async {
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/categories?include=15,16,5323,1741,2908,92,1800&_fields[]=id&_fields[]=name";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        category = categoriesFromJson(jsondata);
        notifyListeners();
      }
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  Future getsubcategory(int categoryid) async {
    isloading = true;
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/categories?parent=${categoryid}&_fields[]=id&_fields[]=name";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        subcategory = subCategoryFromJson(jsondata);
        isloading = false;
        notifyListeners();
      }
    } catch (e) {
      isloading = false;
      notifyListeners();
      print(e);
    }
  }

  setcategoryindex(int index) {
    categoryindex = index;
    notifyListeners();
  }
}
