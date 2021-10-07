// To parse this JSON data, do
//
//     final enVlDbFreeCategory = enVlDbFreeCategoryFromJson(jsonString);

import 'dart:convert';

List<EnVlDbFreeCategory> enVlDbFreeCategoryFromJson(String str) => List<EnVlDbFreeCategory>.from(json.decode(str).map((x) => EnVlDbFreeCategory.fromJson(x)));

String enVlDbFreeCategoryToJson(List<EnVlDbFreeCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EnVlDbFreeCategory {
    EnVlDbFreeCategory({
        this.id,
        this.categoryid,
        this.categoryName,
    });

    String? id;
    String? categoryid;
    String? categoryName;

    factory EnVlDbFreeCategory.fromJson(Map<String, dynamic> json) => EnVlDbFreeCategory(
        id: json["id"],
        categoryid: json["categoryid"],
        categoryName: json["category_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoryid": categoryid,
        "category_name": categoryName,
    };
}
