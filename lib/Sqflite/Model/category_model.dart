import 'dart:convert';

import 'package:flutter/material.dart';

class SaveCategory {
  int? id;
  final int categoryid;
  final String categoryname;

    SaveCategory({
    Key? key,
    this.id,
    required this.categoryname,
    required this.categoryid,
  });

   factory SaveCategory.fromMap(Map<String, dynamic> json) {
    return SaveCategory(
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
