// ignore_for_file: non_constant_identifier_names, avoid_print, unused_local_variable

import 'dart:convert';

import 'package:voltagelab/model/Orginal_Date_time_model/date_time.dart';
import 'package:http/http.dart' as http;
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_single_data.dart';

class SubscriptionUserStreamdata {
  String api_token= "jhsdvcjhasdvjchsdcvjhvhgsdhgfsjhdcvbjshdcvbjsvdcjshdcvjshdfvujhsadvfcjshdcvjhsgfvjhgdcvjshdcvjhcvjshcvjsahcvjshcvjsghcvjsgcvjshgcvjhsgcvhsjcvjhsgcvsjvcjsbcvsjhcvdsjhdfvjsbv";

   Stream<Subscriptionsingledata?> streamsubscriptiondata(
      Duration refreshTime, String email) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await payment_user_info_get(email);
    }
  }

   Future<Subscriptionsingledata?> payment_user_info_get(
      String email) async {
    
    String url = "http://api.voltagelab.com/vl-app/one_month_subs/subs_data_get_by_status.php?api_token=$api_token&email=$email&status=approved";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      var data = jsonDecode(jsondata);
      subscriptiondate_end(data, email);
      return subscriptionsingledataFromJson(jsondata);
    } else {
      print('User Not found');
    }
  }

   Future subscriptiondate_end(data, String email) async {
    String api_token= "jhsdvcjhasdvjchsdcvjhvhgsdhgfsjhdcvbjshdcvbjsvdcjshdcvjshdfvujhsadvfcjshdcvjhsgfvjhgdcvjshdcvjhcvjshcvjsahcvjshcvjsghcvjsgcvjshgcvjhsgcvhsjcvjhsgcvsjvcjsbcvsjhcvdsjhdfvjsbv";
    var orginalDatetime = await get_today_datetime();

    String url =
        "http://api.voltagelab.com/vl-app/one_month_subs/update_subs_data.php?api_token=$api_token&email=$email&status=approved";

    if (DateTime.parse(data['end_date'])
            .difference(orginalDatetime!.datetime!)
            .inDays ==
        0) {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "status": "expair",
            "remaining": DateTime.parse(data['end_date'])
                .difference(orginalDatetime.datetime!)
                .inDays,
          }));
      if (response.statusCode == 200) {
        print('subscription end');
      } else {}
    } else {
      var response = await http.post(Uri.parse(url),
          body: jsonEncode({
            "remaining": DateTime.parse(data['end_date'])
                .difference(orginalDatetime.datetime!)
                .inDays,
          }));
      print('subscription not end');
    }
  }

   Future<OrginalDatetime?> get_today_datetime() async {
    String url = "http://worldtimeapi.org/api/timezone/Asia/Dhaka";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      return orginalDatetimeFromJson(jsondata);
    }
  }
}
