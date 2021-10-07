// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Pro_bn_Vl_Categories> procategorieslistFromJson(String str) => List<Pro_bn_Vl_Categories>.from(json.decode(str).map((x) => Pro_bn_Vl_Categories.fromJson(x)));

String procategorieslistToJson(List<Pro_bn_Vl_Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pro_bn_Vl_Categories {
    Pro_bn_Vl_Categories({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory Pro_bn_Vl_Categories.fromJson(Map<String, dynamic> json) => Pro_bn_Vl_Categories(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
