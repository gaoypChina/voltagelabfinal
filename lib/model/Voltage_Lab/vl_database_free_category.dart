// To parse this JSON data, do
//
//     final vlDbFreeCategory = vlDbFreeCategoryFromJson(jsonString);

import 'dart:convert';

List<VlDbFreeCategory> vlDbFreeCategoryFromJson(String str) => List<VlDbFreeCategory>.from(json.decode(str).map((x) => VlDbFreeCategory.fromJson(x)));

String vlDbFreeCategoryToJson(List<VlDbFreeCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VlDbFreeCategory {
    VlDbFreeCategory({
        this.id,
        this.categoryid,
        this.categoryName,
    });

    String? id;
    String? categoryid;
    String? categoryName;

    factory VlDbFreeCategory.fromJson(Map<String, dynamic> json) => VlDbFreeCategory(
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
