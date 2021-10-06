


import 'package:flutter/material.dart';

class En_voltagelabSaveCategory {
  int? id;
  final int categoryid;
  final String categoryname;

    En_voltagelabSaveCategory({
    Key? key,
    this.id,
    required this.categoryname,
    required this.categoryid,
  });

   factory En_voltagelabSaveCategory.fromMap(Map<String, dynamic> json) {
    return En_voltagelabSaveCategory(
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
