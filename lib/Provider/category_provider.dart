import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/category_model.dart';
import 'package:voltagelab/model/subcategory.dart';

class CategoryProvider extends ChangeNotifier {
  int? categoryindex;
  List<Categories> category = [];
  List<SubCategory>? subcategory = [];

  bool loading = false;

  Future getcategory() async {
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/categories?include=15,16,5323,1741,2908,92,1800&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      category = categoriesFromJson(jsondata);
      notifyListeners();
      return category;
    }
  }

  Future getsubcategory(int categoryid) async {
    loading = true;
    String url =
        // ignore: unnecessary_brace_in_string_interps
"https://blog.voltagelab.com/wp-json/wp/v2/categories?parent=${categoryid}&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      subcategory = subCategoryFromJson(jsondata);
      loading = false;
      notifyListeners();
      return subcategory;
    }
  }

  setcategoryindex(int index) {
    categoryindex = index;
    notifyListeners();
  }
}
