// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<ProBanglaVoltageCategorieslist> procategorieslistFromJson(String str) => List<ProBanglaVoltageCategorieslist>.from(json.decode(str).map((x) => ProBanglaVoltageCategorieslist.fromJson(x)));

String procategorieslistToJson(List<ProBanglaVoltageCategorieslist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProBanglaVoltageCategorieslist {
    ProBanglaVoltageCategorieslist({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory ProBanglaVoltageCategorieslist.fromJson(Map<String, dynamic> json) => ProBanglaVoltageCategorieslist(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
