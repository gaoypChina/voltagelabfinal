// To parse this JSON data, do
//
//     final subscriptionuserdata = subscriptionuserdataFromJson(jsonString);

import 'dart:convert';

Subscriptionuserdata subscriptionuserdataFromJson(String str) => Subscriptionuserdata.fromJson(json.decode(str));

String subscriptionuserdataToJson(Subscriptionuserdata data) => json.encode(data.toJson());

class Subscriptionuserdata {
    Subscriptionuserdata({
        this.id,
        this.fullname,
        this.email,
        this.bkashPhoneNumber,
        this.bkashTransactionId,
        this.rocketPhoneNumber,
        this.rocketTransactionId,
        this.nagadPhoneNumber,
        this.nagadTransactionId,
        this.startDate,
        this.endDate,
        this.status,
        this.types,
        this.subscriptionPack,
        this.remaining,
    });

    String? id;
    String? fullname;
    String? email;
    String? bkashPhoneNumber;
    String? bkashTransactionId;
    String? rocketPhoneNumber;
    String? rocketTransactionId;
    String? nagadPhoneNumber;
    String? nagadTransactionId;
    DateTime? startDate;
    DateTime? endDate;
    String? status;
    String? types;
    String? subscriptionPack;
    String? remaining;

    factory Subscriptionuserdata.fromJson(Map<String, dynamic> json) => Subscriptionuserdata(
        id: json["id"],
        fullname: json["fullname"],
        email: json["email"],
        bkashPhoneNumber: json["bkash_phone_number"],
        bkashTransactionId: json["bkash_transaction_id"],
        rocketPhoneNumber: json["rocket_phone_number"],
        rocketTransactionId: json["rocket_transaction_id"],
        nagadPhoneNumber: json["nagad_phone_number"],
        nagadTransactionId: json["nagad_transaction_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: json["status"],
        types: json["types"],
        subscriptionPack: json["subscription_pack"],
        remaining: json["remaining"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "bkash_phone_number": bkashPhoneNumber,
        "bkash_transaction_id": bkashTransactionId,
        "rocket_phone_number": rocketPhoneNumber,
        "rocket_transaction_id": rocketTransactionId,
        "nagad_phone_number": nagadPhoneNumber,
        "nagad_transaction_id": nagadTransactionId,
        "start_date": startDate!.toIso8601String(),
        "end_date": endDate!.toIso8601String(),
        "status": status,
        "types": types,
        "subscription_pack": subscriptionPack,
        "remaining": remaining,
    };
}
