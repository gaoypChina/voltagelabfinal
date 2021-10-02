// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:voltagelab/model/Orginal_Date_time_model/date_time.dart';
import 'package:voltagelab/model/Subscription_data_Stream_model/subscription_user_data.dart';
import 'package:http/http.dart' as http;

class SubscriptionUserStreamdata {
  static Stream<Subscriptionuserdata?> streamsubscriptiondata(
      Duration refreshTime, String email) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await payment_user_info_get(email);
    }
  }

  static Future<Subscriptionuserdata?> payment_user_info_get(
      String email) async {
    String url =
        "https://amrkotha.org/user_data_get.php?api_token=bdsvkjsbdvjkhbszdkhjvbxznmbcvsjdfbvjshdbvjkhsxbvdjkhsdvjkshgjkgbvdsajfvbjdsahvbds&email=$email";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      var data = jsonDecode(jsondata);
      subscriptiondate_end(data);
      return subscriptionuserdataFromJson(response.body);
    } else {
      print('User Not found');
    }
  }

  static Future subscriptiondate_end(data) async {
    var orginalDatetime = await get_today_datetime();
    // String orginaldate =
    //     "${orginalDatetime!.datetime!.month}-${orginalDatetime.datetime!.day}-${orginalDatetime.datetime!.year}";
    print(orginalDatetime!.datetime);
    print(data['end_date']);
    print(DateTime.parse(data['end_date'])
        .difference(orginalDatetime.datetime!)
        .inDays
        .toString());

    String url =
        "https://amrkotha.org/update_user_data.php?api_token=bdsvkjsbdvjkhbszdkhjvbxznmbcvsjdfbvjshdbvjkhsxbvdjkhsdvjkshgjkgbvdsajfvbjdsahvbds&email=${data['email']}&types=${data['types']}";

    if (DateTime.parse(data['end_date'])
            .difference(orginalDatetime.datetime!)
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

  static Future<OrginalDatetime?> get_today_datetime() async {
    String url = "http://worldtimeapi.org/api/timezone/Asia/Dhaka";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsondata = response.body;
      return orginalDatetimeFromJson(jsondata);
    }
  }
}
