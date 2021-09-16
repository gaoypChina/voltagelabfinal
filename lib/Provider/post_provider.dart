// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab_v4/Sqflite/Model/post_model.dart';
import 'package:voltagelab_v4/Sqflite/post_db.dart';
import 'package:voltagelab_v4/model/post_details_model.dart';
import 'package:voltagelab_v4/model/post_model.dart';
import 'package:voltagelab_v4/model/search_post_model.dart';
import 'package:voltagelab_v4/model/searchpost_details_model.dart';

class Postprovider extends ChangeNotifier {
  bool isloading = false;
  bool loadmoredata = false;
  bool searchpostloading = false;

  SqlPostDB sqlPostDB = SqlPostDB();
  List<Postdata> postdata = [];
  List<SearchPost> searchpost = [];

  PostDetails? postDetails;
  SearchPostDetails? searchPostDetails;

  List<Savepost> savepost = [];

  Future getpost(int subcategoryid, int perpage) async {
    isloading = true;
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/posts?categories=${subcategoryid}&_fields[]=id&per_page=${perpage}&_fields[]=title&_fields[]=yoast_head_json.og_image&_fields[]=";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      isloading = false;
      var jsondata = response.body;
      postdata = postdataFromJson(jsondata);

      notifyListeners();
      return postdata;
    }
  }

  loadingmoredata(bool _loading) {
    loadmoredata = _loading;
    notifyListeners();
  }

  getsavepost() async {
    savepost.clear();
    savepost = await sqlPostDB.getdata();
    notifyListeners();
  }

  savepostremove(int id) {
    sqlPostDB.delete(id);
    notifyListeners();
  }

  Future<PostDetails?> getpostdetails(int postid) async {
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/posts/${postid}?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      postDetails = postDetailsFromJson(jsondata);
      notifyListeners();
      return postDetails;
    }
  }

  Future<PostDetails?> firstpostdetails() async {
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/posts/23063?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      postDetails = postDetailsFromJson(jsondata);
      notifyListeners();
      return postDetails;
    }
  }

  Future<List<SearchPost>?> getsearchpost(String keyword) async {
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/search?search=${keyword}&_fields[]=id&_fields[]=title";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      searchpost = searchPostFromJson(jsondata);
      notifyListeners();
      return searchpost;
    }
  }

  Future<SearchPostDetails?> getsearchpostdetails(int postid) async {
    searchpostloading = true;
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/posts/${postid}?_fields[]=id&per_page=1&_fields[]=title&_fields[]=content&_fields[]=yoast_head_json.og_image&_fields[]=link&_fields[]=";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      searchPostDetails = searchPostDetailsFromJson(response.body);
       searchpostloading = false;
      notifyListeners();
      return searchPostDetails;
    }
  }

  // savepost(
  //     {required int categoryid,
  //     required int id,
  //     required String date,
  //     required String link,
  //     required String title,
  //     required String content,
  //     required String yoastHeadJson}) async {
  //   postbox = Hive.box('bookmark');
  //   Map<String, dynamic> postjson = {
  //     "categoryid": categoryid,
  //     "id": id,
  //     "date": date,
  //     "link": link,
  //     "title": title,
  //     "content": content,
  //     "yoastHeadJson": yoastHeadJson
  //   };
  //   if (postbox!.values.any((element) => element['id'] == id)) {
  //     print("data all rady added");
  //   } else {
  //     postbox!.add(postjson);
  //     notifyListeners();
  //   }

  //   notifyListeners();
  // }

  // savecategory(int categoryid, String categoryname) {
  //   categorybox = Hive.box('category');
  //   Map category = {
  //     "id": categoryid,
  //     "categoryname": categoryname,
  //   };
  //   if (categorybox!.values.any((element) => element['id'] == categoryid)) {
  //     print("All Ready data added");
  //   } else {
  //     categorybox!.add(category);
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }
}
