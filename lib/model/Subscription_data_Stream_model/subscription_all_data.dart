// To parse this JSON data, do
//
//     final subscriptionuserdata = subscriptionuserdataFromJson(jsonString);

import 'dart:convert';

List<Subscriptionuserdata> subscriptionuserdataFromJson(String str) => List<Subscriptionuserdata>.from(json.decode(str).map((x) => Subscriptionuserdata.fromJson(x)));

String subscriptionuserdataToJson(List<Subscriptionuserdata> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subscriptionuserdata {
    Subscriptionuserdata({
        required this.id,
        required this.fullname,
        required this.email,
        required this.phoneNum,
        required this.transactionid,
        required this.startDate,
        required this.endDate,
        required this.status,
        required this.remaining,
        required this.subscriptionPack,
        required this.paymentType,
        required this.loginType,
    });

    String id;
    String fullname;
    String email;
    String phoneNum;
    String transactionid;
    DateTime startDate;
    DateTime endDate;
    String status;
    String remaining;
    String subscriptionPack;
    String paymentType;
    String loginType;

    factory Subscriptionuserdata.fromJson(Map<String, dynamic> json) => Subscriptionuserdata(
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
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "status": status,
        "remaining": remaining,
        "subscription_pack": subscriptionPack,
        "payment_type": paymentType,
        "login_type": loginType,
    };
}
