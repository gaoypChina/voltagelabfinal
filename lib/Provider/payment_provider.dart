// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/Orginal_Date_time_model/date_time.dart';
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_user_data.dart';
import 'package:voltagelab/pages/homepage.dart';

class PaymentProvider extends ChangeNotifier {
  String api_token =
      "jvb/zljdsfbvkjzbkjsbfvkadjhgvajdfgbvkhdjafbvkahjdsbvjkhdsabvkjhdafbvjkhdsafbv";
  OrginalDatetime? orginalDatetime;
  Subscriptionuserdata? subscriptionuserdata;

  bool isloading = false;

  Future get_today_datetime() async {
    String url = "http://worldtimeapi.org/api/timezone/Asia/Dhaka";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      orginalDatetime = orginalDatetimeFromJson(jsondata);
      notifyListeners();
    }
  }

  Future payment_user_inputdata(
      {required String bikash_phone_number,
      bkash_transaction_id,
      rocket_phone_number,
      rocket_transaction_id,
      nagad_phone_number,
      nagad_transaction_id,
      start_date,
      end_date,
      status,
      required BuildContext context}) async {
    var box = Hive.box('userdata');
    isloading = true;
    String url =
        "https://amrkotha.org/subscription_one_month_inputdata.php?api_token=bdsvkjsbdvjkhbszdkhjvbxznmbcvsjdfbvjshdbvjkhsxbvdjkhsdvjkshgjkgbvdsajfvbjdsahvbds";
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "fullname": box.get('name'),
          "email": box.get('email'),
          "bkash_phone_number": bikash_phone_number,
          "bkash_transaction_id": bkash_transaction_id,
          "rocket_phone_number": rocket_phone_number,
          "rocket_transaction_id": rocket_transaction_id,
          "nagad_phone_number": nagad_phone_number,
          "nagad_transaction_id": nagad_transaction_id,
          "start_date": start_date,
          "end_date": end_date,
          "status": status,
          "types": box.get('types')
        }));
    if (response.statusCode == 200) {
      isloading = false;
      print('data upload success');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
      notifyListeners();
    } else {
      isloading = false;
      print('data already exists');
      print(status);
      notifyListeners();
    }
  }

  Stream<Subscriptionuserdata?> streamsubscriptiondata(
      Duration refreshTime, String email) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await payment_user_info_get(email);
    }
  }

  Future<Subscriptionuserdata?> payment_user_info_get(String email) async {
    String url =
        "https://amrkotha.org/user_data_get.php?api_token=bdsvkjsbdvjkhbszdkhjvbxznmbcvsjdfbvjshdbvjkhsxbvdjkhsdvjkshgjkgbvdsajfvbjdsahvbds&email=$email";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      return subscriptionuserdataFromJson(jsondata);
    } else {
      print('User Not found');
    }
  }
}
