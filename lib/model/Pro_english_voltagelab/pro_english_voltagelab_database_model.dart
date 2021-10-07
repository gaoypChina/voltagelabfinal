// To parse this JSON data, do
//
//     final proCategoryList = proCategoryListFromJson(jsonString);

import 'dart:convert';

List<Pro_en_vl_Categorydatabase> proenglishvoltagelabCategorydatabaseListFromJson(String str) => List<Pro_en_vl_Categorydatabase>.from(json.decode(str).map((x) => Pro_en_vl_Categorydatabase.fromJson(x)));

String proEnglishvoltagelabCategorydatabaseListToJson(List<Pro_en_vl_Categorydatabase> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pro_en_vl_Categorydatabase {
    Pro_en_vl_Categorydatabase({
        this.id,
        this.categoryid,
    });

    String? id;
    String? categoryid;

    factory Pro_en_vl_Categorydatabase.fromJson(Map<String, dynamic> json) => Pro_en_vl_Categorydatabase(
        id: json["id"],
        categoryid: json["categoryid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryid": categoryid,
    };
}
