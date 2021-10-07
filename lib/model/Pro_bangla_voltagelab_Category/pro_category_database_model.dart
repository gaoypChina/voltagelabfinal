// To parse this JSON data, do
//
//     final proCategoryList = proCategoryListFromJson(jsonString);

import 'dart:convert';

List<Pro_bn_Vl_Category_database> proCategorydatabaseListFromJson(String str) => List<Pro_bn_Vl_Category_database>.from(json.decode(str).map((x) => Pro_bn_Vl_Category_database.fromJson(x)));

String proCategorydatabaseListToJson(List<Pro_bn_Vl_Category_database> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pro_bn_Vl_Category_database {
    Pro_bn_Vl_Category_database({
        this.id,
        this.categoryid,
    });

    String? id;
    String? categoryid;

    factory Pro_bn_Vl_Category_database.fromJson(Map<String, dynamic> json) => Pro_bn_Vl_Category_database(
        id: json["id"],
        categoryid: json["categoryid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryid": categoryid,
    };
}
