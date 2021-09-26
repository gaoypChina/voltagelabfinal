// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/Orginal_Date_time_model/date_time.dart';

class PaymentProvider extends ChangeNotifier {
  String api_token =
      "jvb/zljdsfbvkjzbkjsbfvkadjhgvajdfgbvkhdjafbvkahjdsbvjkhdsabvkjhdafbvjkhdsafbv";
  OrginalDatetime? orginalDatetime;

  Future get_today_datetime() async {
    String url = "http://worldtimeapi.org/api/timezone/Asia/Dhaka";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      orginalDatetime = orginalDatetimeFromJson(jsondata);
      notifyListeners();
    }
  }

  Future payment_user_inputdata(String name, email, phonenumber, address,
      start_date, end_date, status) async {
    String url =
        "http://192.168.0.107/tanvir/subscription_one_month_inputdata.php?api_token=${api_token}";
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "fullname": name,
          "email": email,
          "phone_number": phonenumber,
          "address": address,
          "start_date": start_date,
          "end_date": end_date,
          "status": status
        }));
    if (response.statusCode == 200) {
      print('data upload success');
    } else {
      print('data already exists');
    }
  }
}
