// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/Pro_bangla_voltagelab_Category/pro_category_database_model.dart';
import 'package:voltagelab/model/Pro_bangla_voltagelab_Category/pro_category_model.dart';
import 'package:voltagelab/model/Pro_english_voltagelab/pro_category_model.dart';
import 'package:voltagelab/model/Pro_english_voltagelab/pro_english_voltagelab_database_model.dart';
import 'package:voltagelab/model/Voltage_Lab/category_model.dart';
import 'package:voltagelab/model/Polytechnic/polytecnic_category.dart';
import 'package:voltagelab/model/subcategory.dart';

class CategoryProvider extends ChangeNotifier {
  int? categoryindex;
  List<Categories> category = [];
  List<SubCategory>? subcategory = [];

  List<ProbanglaVoltagelabCategorydatabaseList>
      probanglavoltagelabcategorydatabaselist = [];
  List<ProBanglaVoltageCategorieslist> probanglavoltagelabcategorylist = [];

  List<ProEnglishVoltagelabCategorydatabaseList>
      proenglishvoltagelabdatabasecategory = [];
  List<ProenglishVoltageCategorieslist> proenglishvoltagelabcategorylist = [];

  List<En_voltagelabCategory> en_voltagelabcategorylist = [];

  bool loading = false;

  //bangla voltagelap main category.....................................
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

  // english https://www.voltagelab.com/ main category.............................................

  Future en_voltagelabcategory() async {
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/categories?_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      en_voltagelabcategorylist = en_voltagelabCategoryFromJson(jsondata);
      notifyListeners();
      return en_voltagelabcategorylist;
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
  Future getpro_bvangla_voltagelabcategorylist() async {
    loading = true;
    String url =
        "http://192.168.0.108/tanvir/tanvir_mysqlfile_voltagelab/pro_category_list/pro_category_vl_bangla.php?api_token=jhsdvcjhasdvjchsdcvjhvhgsdhgfsjhdcvbjshdcvbjsvdcjshdcvjshdfvujhsadvfcjshdcvjhsgfvjhgdcvjshdcvjhcvjshcvjsahcvjshcvjsghcvjsgcvjshgcvjhsgcvhsjcvjhsgcvsjvcjsbcvsjhcvdsjhdfvjsbv";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      probanglavoltagelabcategorydatabaselist =
          proCategorydatabaseListFromJson(jsondata);
      List data = probanglavoltagelabcategorydatabaselist
          .map((e) => e.categoryid)
          .toList();
      print(data);
      getpro_bangla_voltagelab_categorybyid(data);

      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  // pro bangla voltagelab category by databse id
  Future getpro_bangla_voltagelab_categorybyid(List data) async {
    var data2 = data.join(",");
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/categories?include=$data2&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      probanglavoltagelabcategorylist = procategorieslistFromJson(jsondata);
      loading = false;
      notifyListeners();
    } else {
      loading = false;
      print("data pai nai");
      notifyListeners();
    }
  }

  //// pro english voltagelab categorylist

  Future getpro_english_voltagelabcategorylist() async {
    loading = true;
    String url =
        "http://192.168.0.108/tanvir/tanvir_mysqlfile_voltagelab/pro_category_list/pro_category_vl_bangla.php?api_token=jhsdvcjhasdvjchsdcvjhvhgsdhgfsjhdcvbjshdcvbjsvdcjshdcvjshdfvujhsadvfcjshdcvjhsgfvjhgdcvjshdcvjhcvjshcvjsahcvjshcvjsghcvjsgcvjshgcvjhsgcvhsjcvjhsgcvsjvcjsbcvsjhcvdsjhdfvjsbv";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      proenglishvoltagelabdatabasecategory =
          proenglishvoltagelabCategorydatabaseListFromJson(jsondata);

      List data = proenglishvoltagelabdatabasecategory
          .map((e) => e.categoryid)
          .toList();
      print(data);
      getpro_english_voltagelab_categorybyid(data);

      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  Future getpro_english_voltagelab_categorybyid(List data) async {
    var data2 = data.join(",");
    String url =
        "https://www.voltagelab.com/wp-json/wp/v2/categories?include=$data2&_fields[]=id&_fields[]=name";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      proenglishvoltagelabcategorylist =
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
