// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/Sqflite/Subscription_save_data/Model/subscription_model.dart';
import 'package:voltagelab/Sqflite/Subscription_save_data/db/subscription_one_month.dart';
import 'package:voltagelab/model/Orginal_Date_time_model/date_time.dart';
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_all_data.dart';
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_single_data.dart';
import 'package:voltagelab/model/Subscription_details/subscription_details.dart';
import 'package:voltagelab/pages/homepage.dart';

class PaymentProvider extends ChangeNotifier {
  String api_token =
      "jhsdvcjhasdvjchsdcvjhvhgsdhgfsjhdcvbjshdcvbjsvdcjshdcvjshdfvujhsadvfcjshdcvjhsgfvjhgdcvjshdcvjhcvjshcvjsahcvjshcvjsghcvjsgcvjshgcvjhsgcvhsjcvjhsgcvsjvcjsbcvsjhcvdsjhdfvjsbv";
  OrginalDatetime? orginalDatetime;
  List<Subscriptionuserdata> subscriptionuserdata = [];
  Subscriptionsingledata? subscriptionsingledata;

  SqlSubscriptiononemonth_DB? sqlSubscriptiononemonth_DB =
      SqlSubscriptiononemonth_DB();
  List<Subscriptionsaveuserdata>? subscriptionsaveuserdatalist = [];

  SubscriptionDetails? subscriptionDetailspage;

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

  Future payment_user_inputdata({
    required String phone_num,
    transactionid,
    start_date,
    end_date,
    status,
    subscription_pack,
    remaining,
    payment_type,
    required BuildContext context,
  }) async {
    var box = Hive.box('userdata');
    isloading = true;
    String url =
        "http://api.voltagelab.com/vl-app/paid_subscription/input_subs_data.php?api_token=$api_token";
    // String url =
    //     "http://api.voltagelab.com/vl-app/one_month_subs/input_subs_data.php?api_token=$api_token";
    var response = await http.post(Uri.parse(url),
        body: jsonEncode({
          "fullname": box.get('name'),
          "email": box.get('email'),
          "phone_num": phone_num,
          "transactionid": transactionid,
          "start_date": start_date,
          "end_date": end_date,
          "status": status,
          "remaining": remaining,
          "subscription_pack": subscription_pack,
          "payment_type": payment_type,
          "login_type": box.get('type')
        }));
    if (response.statusCode == 200) {
      isloading = false;
      print('data upload success');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
      notifyListeners();
    } else {
      isloading = false;
      print('data already exists');
      print(status);
      notifyListeners();
    }
  }

  // Stream<Subscriptionuserdata?> streamsubscriptiondata(
  //     Duration refreshTime, String email) async* {
  //   while (true) {
  //     await Future.delayed(refreshTime);
  //     yield await payment_subscription_one_month_userinfo_get(email);
  //   }
  // }

  Future payment_subscription_one_month_userinfo_get(String email) async {
    isloading = true;
    String url =
        "http://api.voltagelab.com/vl-app/paid_subscription/all_data_get_by_email.php?api_token=$api_token&email=$email";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        subscriptionuserdata = subscriptionuserdataFromJson(jsondata);
        payment_subscription_one_mont_datasave(subscriptionuserdata);
        isloading = false;
        notifyListeners();
      } else {
        print('User Not found');
        isloading = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  payment_subscription_one_mont_datasave(
      List<Subscriptionuserdata> subscriptionuserdata1) async {
    subscriptionsaveuserdatalist!.clear();
    subscriptionsaveuserdatalist = await sqlSubscriptiononemonth_DB!.getdata();

    for (int i = 0; i < subscriptionuserdata1.length; i++) {
      Subscriptionsaveuserdata subscriptionsaveuserdata =
          Subscriptionsaveuserdata(
        subscriptionid: subscriptionuserdata1[i].id,
        startdate:
            "${subscriptionuserdata1[i].startDate.year.toString()}-${subscriptionuserdata1[i].startDate.month.toString()}-${subscriptionuserdata1[i].startDate.day.toString()}",
        enddate:
            "${subscriptionuserdata1[i].endDate.year.toString()}-${subscriptionuserdata1[i].endDate.month.toString()}-${subscriptionuserdata1[i].endDate.day.toString()}",
        subscriptionpack: subscriptionuserdata1[i].subscriptionPack,
        remaining: subscriptionuserdata1[i].remaining,
        status: subscriptionuserdata1[i].status,
      );

      if (subscriptionsaveuserdatalist!.any(
          (element) => element.subscriptionid == subscriptionuserdata1[i].id)) {
        sqlSubscriptiononemonth_DB!
            .delete(subscriptionuserdata1[i].id)
            .then((value) {
          sqlSubscriptiononemonth_DB!.insertdata(subscriptionsaveuserdata);
        });

        print('data allrady added');
        notifyListeners();
      } else {
        sqlSubscriptiononemonth_DB!.insertdata(subscriptionsaveuserdata);
        print('data addeds');
        notifyListeners();
      }
    }
  }

  subscription_one_monthdata_listadd() async {
    subscriptionsaveuserdatalist!.clear();
    subscriptionsaveuserdatalist = await sqlSubscriptiononemonth_DB!.getdata();
    notifyListeners();
  }

  Future<Subscriptionsingledata?> payment_user__single_info_get(
      String email) async {
    String url =
        "http://api.voltagelab.com/vl-app/paid_subscription/subs_data_get_by_status.php?api_token=$api_token&email=$email&status=1";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      subscriptionsingledata = subscriptionsingledataFromJson(jsondata);
      notifyListeners();
    } else {
      print('User Not found');
      notifyListeners();
    }
  }

  // Future subscriptiondate_end(data) async {
  //   var orginaldate =
  //       "${orginalDatetime!.datetime!.month}-${orginalDatetime!.datetime!.day}-${orginalDatetime!.datetime!.year}";
  //   if (data['end_date'] == orginaldate) {
  //     String url =
  //         "https://amrkotha.org/one_month_subscription/update_user_data.php?api_token=bdsvkjsbdvjkhbszdkhjvbxznmbcvsjdfbvjshdbvjkhsxbvdjkhsdvjkshgjkgbvdsajfvbjdsahvbds&email=${data['email']}&types=${data['types']}";
  //     var response = await http.post(Uri.parse(url),
  //         body: jsonEncode({"status": "expair"}));
  //     if (response.statusCode == 200) {
  //       print('subscription end');
  //     } else {
  //       print('subscription not end');
  //     }
  //   } else {
  //     print('subscription not end');
  //   }
  // }

  Future subscription_details_page() async {
    isloading = true;
    String url =
        "https://blog.voltagelab.com/wp-json/wp/v2/pages/2981?_fields[]=content";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      subscriptionDetailspage = subscriptionDetailsFromJson(response.body);
      isloading = false;
      notifyListeners();
    } else {
      print(response.body);
      isloading = false;
      notifyListeners();
    }
  }
}
