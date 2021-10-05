// To parse this JSON data, do
//
//     final subscriptionsingledata = subscriptionsingledataFromJson(jsonString);

import 'dart:convert';

Subscriptionsingledata subscriptionsingledataFromJson(String str) => Subscriptionsingledata.fromJson(json.decode(str));

String subscriptionsingledataToJson(Subscriptionsingledata data) => json.encode(data.toJson());

class Subscriptionsingledata {
  Subscriptionsingledata({
    this.id,
    this.fullname,
    this.email,
    this.phoneNum,
    this.transactionid,
    this.startDate,
    this.endDate,
    this.status,
    this.remaining,
    this.subscriptionPack,
    this.paymentType,
    this.loginType,
  });

  String? id;
  String? fullname;
  String? email;
  String? phoneNum;
  String? transactionid;
  DateTime? startDate;
  DateTime? endDate;
  String? status;
  String? remaining;
  String? subscriptionPack;
  String? paymentType;
  String? loginType;

  factory Subscriptionsingledata.fromJson(Map<String, dynamic> json) => Subscriptionsingledata(
    id: json["id"],
    fullname: json["fullname"],
    email: json["email"],
    phoneNum: json["phone_num"],
    transactionid: json["transactionid"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    status: json["status"],
    remaining: json["remaining"],
    subscriptionPack: json["subscription_pack"],
    paymentType: json["payment_type"],
    loginType: json["login_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "email": email,
    "phone_num": phoneNum,
    "transactionid": transactionid,
    "start_date": startDate!.toIso8601String(),
    "end_date": endDate!.toIso8601String(),
    "status": status,
    "remaining": remaining,
    "subscription_pack": subscriptionPack,
    "payment_type": paymentType,
    "login_type": loginType,
  };
}
