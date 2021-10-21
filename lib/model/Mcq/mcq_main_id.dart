// To parse this JSON data, do
//
//     final mcqMainiddb = mcqMainiddbFromJson(jsonString);

import 'dart:convert';

List<McqMainiddb> mcqMainiddbFromJson(String str) => List<McqMainiddb>.from(json.decode(str).map((x) => McqMainiddb.fromJson(x)));

String mcqMainiddbToJson(List<McqMainiddb> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class McqMainiddb {
    McqMainiddb({
        this.id,
        this.mcqId,
        this.mcqName,
    });

    String? id;
    String? mcqId;
    String? mcqName;

    factory McqMainiddb.fromJson(Map<String, dynamic> json) => McqMainiddb(
        id: json["id"],
        mcqId: json["mcq_id"],
        mcqName: json["mcq_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "mcq_id": mcqId,
        "mcq_name": mcqName,
    };
}
