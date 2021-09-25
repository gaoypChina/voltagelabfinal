// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/Sqflite/Polytechnicbd/Model/post_model.dart';
import 'package:voltagelab/Sqflite/Polytechnicbd/db/post_db.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/Model/post_model.dart';
import 'package:voltagelab/Sqflite/VoltageLab_local_db/db/post_db.dart';
import 'package:voltagelab/model/Latest_Post_Model/latest_post.dart';
import 'package:voltagelab/model/Latest_Post_Model/latest_post_details_model.dart';
import 'package:voltagelab/model/post_details_model.dart';
import 'package:voltagelab/model/post_model.dart';
import 'package:voltagelab/model/search_post_model.dart';
import 'package:voltagelab/model/searchpost_details_model.dart';

class Postprovider extends ChangeNotifier {
  bool isloading = false;
  bool loadmoredata = false;
  bool searchpostloading = false;

  int voltagelabsavepostbadge = 0;
  int voltagelabpostcount = 0;

  int? polytechnicsavepostbadge;
  int polytechnicpostcount = 0;

  LatestPostdetails? latestPostdetails;

  List<LatestPostData> voltagelablatestpost = [];

  SqlVoltagelabPostDB sqlPostDB = SqlVoltagelabPostDB();
  SqlPolytechnicPostDB sqlPolytechnicPostDB = SqlPolytechnicPostDB();

  List<Postdata> postdata = [];
  List<SearchPost> searchpost = [];

  PostDetails? postDetails;
  SearchPostDetails? searchPostDetails;

  List<VoltageLabSavepost> savevoltagelabpost = [];
  List<PolytechnicSavepost> polytechnicsavepost = [];

  //voltagelab post..............................................
  Future getpost(int subcategoryid, int perpage, String sitename) async {
    if (sitename == 'voltagelab') {
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
    } else if (sitename == 'polytechnicbd') {
      getpolytechnicpost(subcategoryid, perpage);
    }
  }

  loadingmoredata(bool _loading) {
    loadmoredata = _loading;
    notifyListeners();
  }

  getvoltagelabsavepost() async {
    savevoltagelabpost.clear();
    savevoltagelabpost = await sqlPostDB.getdata();
    notifyListeners();
  }

  getpolytechnicsavepost() async {
    polytechnicsavepost.clear();
    polytechnicsavepost = await sqlPolytechnicPostDB.getdata();
    notifyListeners();
  }

  savepostremove(int id) {
    sqlPostDB.delete(id);
    notifyListeners();
  }

  //voltage lab post details................................................
  Future<PostDetails?> getpostdetails(int postid, String sitename) async {
    if (sitename == 'voltagelab') {
      String url =
          "https://blog.voltagelab.com/wp-json/wp/v2/posts/${postid}?_fields[]=content&_fields[]=link";
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        postDetails = postDetailsFromJson(jsondata);
        notifyListeners();
        return postDetails;
      }
    } else if (sitename == 'polytechnicbd') {
      print("bdcsabdh${sitename}");
      await getpolytechnicpostdetails(postid);
    }
  }

  //voltagelab fast post details...............................................................
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

  //voltagelab search post................................................
  Future<List<SearchPost>?> getsearchpost(
      String keyword, String sitename) async {
    if (sitename == 'voltagelab') {
      String url =
          "https://blog.voltagelab.com/wp-json/wp/v2/search?search=${keyword}&_fields[]=id&_fields[]=title";

      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        searchpost = searchPostFromJson(jsondata);
        notifyListeners();
        return searchpost;
      }
    } else if (sitename == 'polytechnicbd') {
      await polytechnicsearchpost(keyword);
    }
  }

  //voltagelab search post details................................................

  Future<SearchPostDetails?> getsearchpostdetails(
      int postid, String sitename) async {
    if (sitename == 'voltagelab') {
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
    } else if (sitename == 'polytechnicbd') {
      await polytechnicsearchpostdetails(postid);
    }
  }

  //voltagelab Latest post................................................
  Future getvoltagelablatestpost() async {
    isloading = true;
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/posts?per_page=5&_fields[]=id&_fields[]=title&_fields[]=yoast_head_json.og_image";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      voltagelablatestpost = latestPostDataFromJson(response.body);
      isloading = false;
      notifyListeners();
    }
  }

  //voltagelab Latest post details................................................
  Future getlatestpostdetails(int postid) async {
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/posts/${postid}?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      latestPostdetails = latestPostDetailsFromJson(jsondata);
      notifyListeners();
    }
  }

  //polytechnic get post..........................................
  Future getpolytechnicpost(int subcategoryid, int perpage) async {
    isloading = true;
    String url =
        "https://polytechnicbd.com/wp-json/wp/v2/posts?categories=${subcategoryid}&_fields[]=id&per_page=${perpage}&_fields[]=title&_fields[]=yoast_head_json.og_image&_fields[]=";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      isloading = false;
      var jsondata = response.body;
      postdata = postdataFromJson(jsondata);

      notifyListeners();
      return postdata;
    }
  }

  //polytechnic get post details..........................................
  Future getpolytechnicpostdetails(int postid) async {
    String url =
        "https://polytechnicbd.com/wp-json/wp/v2/posts/${postid}?_fields[]=content&_fields[]=link";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      postDetails = postDetailsFromJson(jsondata);
      notifyListeners();
      return postDetails;
    }
  }

  //polytechnic search post................................................
  Future<List<SearchPost>?> polytechnicsearchpost(String keyword) async {
    String url =
        "https://polytechnicbd.com/wp-json/wp/v2/search?search=${keyword}&_fields[]=id&_fields[]=title";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      searchpost = searchPostFromJson(jsondata);
      notifyListeners();
      return searchpost;
    }
  }

  Future<SearchPostDetails?> polytechnicsearchpostdetails(int postid) async {
    searchpostloading = true;
    String url =
        "https://polytechnicbd.com/wp-json/wp/v2/posts/${postid}?_fields[]=id&per_page=1&_fields[]=title&_fields[]=content&_fields[]=yoast_head_json.og_image&_fields[]=link&_fields[]=";

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      searchPostDetails = searchPostDetailsFromJson(response.body);
      searchpostloading = false;
      notifyListeners();
      return searchPostDetails;
    }
  }

  voltagelabsavepostcount() {
    var box = Hive.box('voltagelabbadge');
    voltagelabpostcount++;
    box.put('count', voltagelabpostcount);
    notifyListeners();
  }

  getpostcount() {
    var box = Hive.box('voltagelabbadge');
    voltagelabsavepostbadge = box.get('count') ?? 0;
    notifyListeners();
  }

  polytechnicsavepostcount() {
    var box = Hive.box('Polytechnicbadge');
    polytechnicpostcount++;
    box.put('count', polytechnicpostcount);
    notifyListeners();
  }

  getpolytechnicpostcount() {
    var box = Hive.box('Polytechnicbadge');
    polytechnicsavepostbadge = box.get('count') ?? 0;
    notifyListeners();
  }

  Future updatepostnotification() async {
    String url =
        "http://192.168.0.107/tanvir/userinfoverify.php?api_token=jvb/zljdsfbvkjzbkjsbfvkadjhgvajdfgbvkhdjafbvkahjdsbvjkhdsabvkjhdafbvjkhdsafbv&email=shakilhassan887@gmail.com&types=2";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      notifyListeners();
    }
  }
}
