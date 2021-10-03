// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/Voltage_Lab/category_model.dart';
import 'package:voltagelab/model/Polytechnic/polytecnic_category.dart';
import 'package:voltagelab/model/subcategory.dart';

class CategoryProvider extends ChangeNotifier {
  int? categoryindex;
  List<Categories> category = [];
  List<SubCategory>? subcategory = [];

  List<PolytechnicCategory> polytechniccategory = [];

  bool loading = false;

  //voltagelap main category.....................................
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

  //voltagelap sub category.....................................
  Future getsubcategory(int categoryid, String sitename) async {
    if (sitename == 'voltagelab') {
      loading = true;
      String url =
          "https://blog.voltagelab.com/wp-json/wp/v2/categories?parent=${categoryid}&_fields[]=id&_fields[]=name";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        subcategory = subCategoryFromJson(jsondata);
        loading = false;
       
        notifyListeners();
        return subcategory;
      }
    } else if (sitename == 'polytechnicbd') {
      await polytechnicbdsubcategory(categoryid);
    }
  }

  setcategoryindex(int index) {
    categoryindex = index;
    notifyListeners();
  }

  //https://polytechnicbd.com/ main category.............................................

  Future polytechnicbdcategory() async {
    String url =
        "https://polytechnicbd.com/wp-json/wp/v2/categories?_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      polytechniccategory = polytechnicCategoryFromJson(jsondata);
      notifyListeners();
      return polytechniccategory;
    }
  }

  Future polytechnicbdsubcategory(int categoryid) async {
    subcategory!.clear();
    loading = true;
    String url =
        "https://polytechnicbd.com/wp-json/wp/v2/categories?parent=${categoryid}&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      subcategory = subCategoryFromJson(jsondata);
      loading = false;
    
      notifyListeners();
      return subcategory;
    }
  }
}
