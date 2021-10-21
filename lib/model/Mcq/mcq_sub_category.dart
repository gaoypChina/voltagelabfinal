// To parse this JSON data, do
//
//     final mcqsubcategory = mcqsubcategoryFromJson(jsonString);

import 'dart:convert';

List<Mcqsubcategory> mcqsubcategoryFromJson(String str) => List<Mcqsubcategory>.from(json.decode(str).map((x) => Mcqsubcategory.fromJson(x)));

String mcqsubcategoryToJson(List<Mcqsubcategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Mcqsubcategory {
    Mcqsubcategory({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory Mcqsubcategory.fromJson(Map<String, dynamic> json) => Mcqsubcategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
