import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/post_model.dart';

class Postprovider extends ChangeNotifier {
  List<Postdata> postdata = [];
  bool isloading = false;

  bool loadmoredata = false;

  Future getpost(int id, int perpage) async {
    isloading = true;
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/posts?categories=${id}&per_page=${perpage}&offset=1&_fields[]=id&_fields[]=title&_fields[]=content&_fields[]=yoast_head_json.og_image&_fields[]=date&_fields[]=";
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
}
