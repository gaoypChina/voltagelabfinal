// To parse this JSON data, do
//
//     final polytechnicCategory = polytechnicCategoryFromJson(jsonString);

import 'dart:convert';

List<PolytechnicCategory> polytechnicCategoryFromJson(String str) => List<PolytechnicCategory>.from(json.decode(str).map((x) => PolytechnicCategory.fromJson(x)));

String polytechnicCategoryToJson(List<PolytechnicCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PolytechnicCategory {
    PolytechnicCategory({
        required this.id,
        required this.name,
    });

    int id;
    String name;

    factory PolytechnicCategory.fromJson(Map<String, dynamic> json) => PolytechnicCategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
