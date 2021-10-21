// To parse this JSON data, do
//
//     final mcqMaincategory = mcqMaincategoryFromJson(jsonString);

import 'dart:convert';

List<McqMaincategory> mcqMaincategoryFromJson(String str) => List<McqMaincategory>.from(json.decode(str).map((x) => McqMaincategory.fromJson(x)));

String mcqMaincategoryToJson(List<McqMaincategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class McqMaincategory {
    McqMaincategory({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory McqMaincategory.fromJson(Map<String, dynamic> json) => McqMaincategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
