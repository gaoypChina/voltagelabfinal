// ignore_for_file: non_constant_identifier_names, avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/Sqflite/Subscription_save_data/Model/subscription_model.dart';
import 'package:voltagelab/Sqflite/Subscription_save_data/db/subscription_one_month.dart';
import 'package:voltagelab/model/Orginal_Date_time_model/date_time.dart';
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_user_data.dart';
import 'package:voltagelab/pages/homepage.dart';

class PaymentProvider extends ChangeNotifier {
  String api_token =
      "jvb/zljdsfbvkjzbkjsbfvkadjhgvajdfgbvkhdjafbvkahjdsbvjkhdsabvkjhdafbvjkhdsafbv";
  OrginalDatetime? orginalDatetime;
  Subscriptionuserdata? subscriptionuserdata;

  SqlSubscriptiononemonth_DB? sqlSubscriptiononemonth_DB =
      SqlSubscriptiononemonth_DB();
  List<Subscriptionsaveuserdata>? subscriptionsaveuserdatalist = [];

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
    required String bikash_phone_number,
    bkash_transaction_id,
    rocket_phone_number,
    rocket_transaction_id,
    nagad_phone_number,
    nagad_transaction_id,
    start_date,
    end_date,
    status,
    subscription_pack,
    remaining,
    required BuildContext context,
  }) async {
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
          "types": box.get('types'),
          "subscription_pack": subscription_pack,
          "remaining": remaining
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
      yield await payment_subscription_one_month_userinfo_get(email);
    }
  }

  Future<Subscriptionuserdata?> payment_subscription_one_month_userinfo_get(
      String email) async {
    isloading = true;
    String url =
        "https://amrkotha.org/user_data_get.php?api_token=bdsvkjsbdvjkhbszdkhjvbxznmbcvsjdfbvjshdbvjkhsxbvdjkhsdvjkshgjkgbvdsajfvbjdsahvbds&email=$email";
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsondata = response.body;
        subscriptionuserdata = subscriptionuserdataFromJson(jsondata);
        payment_subscription_one_mont_datasave(subscriptionuserdata!);
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
      Subscriptionuserdata subscriptionuserdata1) async {
    subscriptionsaveuserdatalist!.clear();
    subscriptionsaveuserdatalist = await sqlSubscriptiononemonth_DB!.getdata();

    Subscriptionsaveuserdata subscriptionsaveuserdata =
        Subscriptionsaveuserdata(
      subscriptionid: subscriptionuserdata1.id!,
      startdate: subscriptionuserdata1.startDate!.toString(),
      enddate: subscriptionuserdata1.endDate!.toString(),
      subscriptionpack: subscriptionuserdata1.subscriptionPack!,
      remaining: subscriptionuserdata1.remaining!,
      status: subscriptionuserdata1.status!,
    );
    if (subscriptionsaveuserdatalist!.any((element) =>
        element.subscriptionpack == subscriptionuserdata1.subscriptionPack)) {
      // //   Subscriptionsaveuserdata subscriptionsaveuserdata = Subscriptionsaveuserdata(
      // //   subscriptionid: subscriptionuserdata1.id!,
      // //   startdate: subscriptionuserdata1.startDate!.toString(),
      // //   enddate: subscriptionuserdata1.endDate!.toString(),
      // //   subscriptionpack: subscriptionuserdata1.subscriptionPack!,
      // //   remaining: subscriptionuserdata1.remaining!,
      // //   status: subscriptionuserdata1.status!,
      // // );
      // // sqlSubscriptiononemonth_DB!.update(subscriptionsaveuserdata);
      sqlSubscriptiononemonth_DB!
          .delete(subscriptionuserdata1.id!)
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

  subscription_one_monthdata_listadd() async {
    subscriptionsaveuserdatalist!.clear();
    subscriptionsaveuserdatalist = await sqlSubscriptiononemonth_DB!.getdata();
    notifyListeners();
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
}
