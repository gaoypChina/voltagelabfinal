

// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/post_model.dart';

class Postprovider extends ChangeNotifier {
  List<Postdata> postdata = [];

  bool isloading = false;
  bool loadmoredata = false;

  Box? box;

  Future getpost(int subcategoryid, int perpage) async {
    isloading = true;
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/posts?categories=${subcategoryid}&per_page=${perpage}&offset=0&_fields[]=id&_fields[]=title&_fields[]=content&_fields[]=yoast_head_json.og_image&_fields[]=date&_fields[]=link&_fields[]=";

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        postdata = postdataFromJson(jsondata);
        isloading = false;
        notifyListeners();
      }
    } catch (e) {
      isloading = false;
      print(e);
      notifyListeners();
    }
  }

  loadingmoredata(bool _loading) {
    loadmoredata = _loading;
    notifyListeners();
  }

  savepost(
      {required int id,
      required String date,
      required String link,
      required String title,
      required String content,
      required String yoastHeadJson}) async {
    box = Hive.box('bookmark');
    Map<String, dynamic> postjson = {
      "id": id,
      "date": date,
      "link": link,
      "title": title,
      "content": content,
      "yoastHeadJson": yoastHeadJson
    };
    if (box!.values.any((element) => element['id'] == id)) {
      print("data all rady added");
    } else {
      box!.add(postjson);
    }
    notifyListeners();
  }
}
