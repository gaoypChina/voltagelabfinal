// To parse this JSON data, do
//
//     final proCategoryList = proCategoryListFromJson(jsonString);

import 'dart:convert';

List<ProEnglishVoltagelabCategorydatabaseList> proenglishvoltagelabCategorydatabaseListFromJson(String str) => List<ProEnglishVoltagelabCategorydatabaseList>.from(json.decode(str).map((x) => ProEnglishVoltagelabCategorydatabaseList.fromJson(x)));

String proEnglishvoltagelabCategorydatabaseListToJson(List<ProEnglishVoltagelabCategorydatabaseList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProEnglishVoltagelabCategorydatabaseList {
    ProEnglishVoltagelabCategorydatabaseList({
        this.id,
        this.categoryid,
    });

    String? id;
    String? categoryid;

    factory ProEnglishVoltagelabCategorydatabaseList.fromJson(Map<String, dynamic> json) => ProEnglishVoltagelabCategorydatabaseList(
        id: json["id"],
        categoryid: json["categoryid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryid": categoryid,
    };
}
