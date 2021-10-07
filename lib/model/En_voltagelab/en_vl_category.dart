// To parse this JSON data, do
//
//     final polytechnicCategory = polytechnicCategoryFromJson(jsonString);

import 'dart:convert';

List<En_voltagelabCategory> en_voltagelabCategoryFromJson(String str) => List<En_voltagelabCategory>.from(json.decode(str).map((x) => En_voltagelabCategory.fromJson(x)));

String en_voltagelabCategoryToJson(List<En_voltagelabCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class En_voltagelabCategory {
    En_voltagelabCategory({
        required this.id,
        required this.name,
    });

    int id;
    String name;

    factory En_voltagelabCategory.fromJson(Map<String, dynamic> json) => En_voltagelabCategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
