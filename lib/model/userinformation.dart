// To parse this JSON data, do
//
//     final userinformation = userinformationFromJson(jsonString);

import 'dart:convert';

Userinformation userinformationFromJson(String str) => Userinformation.fromJson(json.decode(str));

String userinformationToJson(Userinformation data) => json.encode(data.toJson());

class Userinformation {
    Userinformation({
        required this.id,
        required this.fullName,
        required this.email,
        this.passwords,
        this.photoUrl,
        this.accountId,
        required this.type

    });

    String id;
    String fullName;
    String email;
    String? passwords;
    String? photoUrl;
    String? accountId;
    String type;


    factory Userinformation.fromJson(Map<String, dynamic> json) => Userinformation(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        passwords: json["passwords"],
        photoUrl: json["photo_url"],
        accountId: json["account_id"],
        type: json["type"]

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "passwords": passwords,
        "photo_url": photoUrl,
        "account_id": accountId,
        "type" : type

    };
}
