// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/En_voltagelab/en_vl_category.dart';
import 'package:voltagelab/model/En_voltagelab/en_vl_db_free_category.dart';
import 'package:voltagelab/model/Pro_bangla_voltagelab_Category/pro_category_database_model.dart';
import 'package:voltagelab/model/Pro_bangla_voltagelab_Category/pro_category_model.dart';
import 'package:voltagelab/model/Pro_english_voltagelab/pro_category_model.dart';
import 'package:voltagelab/model/Pro_english_voltagelab/pro_english_voltagelab_database_model.dart';
import 'package:voltagelab/model/Voltage_Lab/category_model.dart';
import 'package:voltagelab/model/Voltage_Lab/vl_database_free_category.dart';
import 'package:voltagelab/model/subcategory.dart';

class CategoryProvider extends ChangeNotifier {
  int? categoryindex;
  List<Categories> category = [];
  List<SubCategory>? subcategory = [];

  List<Pro_bn_Vl_Category_database> pro_bn_vl_categorydatabase = [];
  List<Pro_bn_Vl_Categories> pro_bn_vl_category = [];

  List<Pro_en_vl_Categorydatabase> pro_en_vl_databasecategory = [];
  List<ProenglishVoltageCategorieslist> pro_en_vl_categorylist = [];

  List<VlDbFreeCategory> vl_db_free_category = [];
  List<EnVlDbFreeCategory> en_vl_db_free_category = [];

  List<En_voltagelabCategory> en_voltagelabcategorylist = [];

  bool loading = false;

  String api_token =
      "jhsdvcjhasdvjchsdcvjhvhgsdhgfsjhdcvbjshdcvbjsvdcjshdcvjshdfvujhsadvfcjshdcvjhsgfvjhgdcvjshdcvjhcvjshcvjsahcvjshcvjsghcvjsgcvjshgcvjhsgcvhsjcvjhsgcvsjvcjsbcvsjhcvdsjhdfvjsbv";

  //bangla voltagelab database category..................................

  Future get_free_bn_vl_categorylist() async {
    loading = true;
    String url =
        "http://192.168.0.108/tanvir/tanvir_mysqlfile_voltagelab/free_category_list/free_category_vl_bangla.php?api_token=$api_token";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      vl_db_free_category = vlDbFreeCategoryFromJson(jsondata);
      List data = vl_db_free_category.map((e) => e.categoryid).toList();
      print(data);
      get_bn_vl_free_category(data);
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  //bangla voltagelap main category.....................................
  Future get_bn_vl_free_category(var data) async {
    var data2 = data.join(",");
    //15,16,5323,1741,2908,92,1800
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/categories?include=$data2&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      category = categoriesFromJson(jsondata);
      notifyListeners();
      return category;
    }
  }

  //bangla voltagelap sub category.....................................
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
      await en_voltagelabsubcategory(categoryid);
    }
  }

  setcategoryindex(int index) {
    categoryindex = index;
    notifyListeners();
  }

  ////bangla voltagelab database category..................................
  Future get_free_en_vl_categorylist() async {
    loading = true;
    String url =
        "http://192.168.0.108/tanvir/tanvir_mysqlfile_voltagelab/free_category_list/free_category_vl_bangla.php?api_token=$api_token";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      en_vl_db_free_category = enVlDbFreeCategoryFromJson(jsondata);
      List data = en_vl_db_free_category.map((e) => e.categoryid).toList();
      print(data);
      en_free_vl_category(data);
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  // english https://www.voltagelab.com/ main category.............................................
  Future en_free_vl_category(var data) async {
    var data2 = data.join(",");
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/categories?include=$data2&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      en_voltagelabcategorylist = en_voltagelabCategoryFromJson(jsondata);
      notifyListeners();
      return en_voltagelabcategorylist;
    } else {
      print('free en voltagelab category not found');
    }
  }

  Future en_voltagelabsubcategory(int categoryid) async {
    subcategory!.clear();
    loading = true;
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/categories?parent=${categoryid}&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      subcategory = subCategoryFromJson(jsondata);
      loading = false;

      notifyListeners();
      return subcategory;
    }
  }

  // pro bangla voltagelab categorylist
  Future get_pro_bn_vl_categorylist() async {
    loading = true;
    String url =
        "http://192.168.0.108/tanvir/tanvir_mysqlfile_voltagelab/pro_category_list/pro_category_vl_bangla.php?api_token=$api_token";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      pro_bn_vl_categorydatabase = proCategorydatabaseListFromJson(jsondata);
      List data = pro_bn_vl_categorydatabase.map((e) => e.categoryid).toList();
      print(data);
      get_pro_bn_vl_categorybyid(data);

      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  // pro bangla voltagelab category by databse id
  Future get_pro_bn_vl_categorybyid(List data) async {
    var data2 = data.join(",");
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/categories?include=$data2&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      pro_bn_vl_category = procategorieslistFromJson(jsondata);
      loading = false;
      notifyListeners();
    } else {
      loading = false;
      print("data pai nai");
      notifyListeners();
    }
  }

  //// pro english voltagelab categorylist

  Future get_pro_en_vl_categorylist() async {
    loading = true;
    String url =
        "http://192.168.0.108/tanvir/tanvir_mysqlfile_voltagelab/pro_category_list/pro_category_vl_bangla.php?api_token=$api_token";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      pro_en_vl_databasecategory =
          proenglishvoltagelabCategorydatabaseListFromJson(jsondata);

      List data = pro_en_vl_databasecategory.map((e) => e.categoryid).toList();
      print(data);
      get_pro_en_vl_categorybyid(data);

      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  Future get_pro_en_vl_categorybyid(List data) async {
    var data2 = data.join(",");
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/categories?include=$data2&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      pro_en_vl_categorylist =
          proenglishvoltagelabcategorieslistFromJson(jsondata);
      loading = false;
      notifyListeners();
    } else {
      loading = false;
      print("data pai nai");
      notifyListeners();
    }
  }
}
