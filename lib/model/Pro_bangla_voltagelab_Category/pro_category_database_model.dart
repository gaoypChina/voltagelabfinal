// To parse this JSON data, do
//
//     final proCategoryList = proCategoryListFromJson(jsonString);

import 'dart:convert';

List<ProbanglaVoltagelabCategorydatabaseList> proCategorydatabaseListFromJson(String str) => List<ProbanglaVoltagelabCategorydatabaseList>.from(json.decode(str).map((x) => ProbanglaVoltagelabCategorydatabaseList.fromJson(x)));

String proCategorydatabaseListToJson(List<ProbanglaVoltagelabCategorydatabaseList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProbanglaVoltagelabCategorydatabaseList {
    ProbanglaVoltagelabCategorydatabaseList({
        this.id,
        this.categoryid,
    });

    String? id;
    String? categoryid;

    factory ProbanglaVoltagelabCategorydatabaseList.fromJson(Map<String, dynamic> json) => ProbanglaVoltagelabCategorydatabaseList(
        id: json["id"],
        categoryid: json["categoryid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryid": categoryid,
    };
}
