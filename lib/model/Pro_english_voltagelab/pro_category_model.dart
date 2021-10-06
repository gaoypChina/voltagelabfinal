// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<ProenglishVoltageCategorieslist> proenglishvoltagelabcategorieslistFromJson(String str) => List<ProenglishVoltageCategorieslist>.from(json.decode(str).map((x) => ProenglishVoltageCategorieslist.fromJson(x)));

String proenglishvoltagelabcategorieslistToJson(List<ProenglishVoltageCategorieslist> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProenglishVoltageCategorieslist {
    ProenglishVoltageCategorieslist({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory ProenglishVoltageCategorieslist.fromJson(Map<String, dynamic> json) => ProenglishVoltageCategorieslist(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
