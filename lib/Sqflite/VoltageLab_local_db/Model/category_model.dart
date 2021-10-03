


import 'package:flutter/material.dart';

class VoltageLabSaveCategory {
  int? id;
  final int categoryid;
  final String categoryname;

    VoltageLabSaveCategory({
    Key? key,
    this.id,
    required this.categoryname,
    required this.categoryid,
  });

   factory VoltageLabSaveCategory.fromMap(Map<String, dynamic> json) {
    return VoltageLabSaveCategory(
      id: json["id"],
      categoryid: json['categoryid'],
      categoryname: json['categoryname']
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "categoryid" : categoryid,
        "categoryname" : categoryname
      };
}
