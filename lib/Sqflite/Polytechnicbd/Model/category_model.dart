import 'dart:convert';

import 'package:flutter/material.dart';

class PolytechnicSaveCategory {
  int? id;
  final int categoryid;
  final String categoryname;

    PolytechnicSaveCategory({
    Key? key,
    this.id,
    required this.categoryname,
    required this.categoryid,
  });

   factory PolytechnicSaveCategory.fromMap(Map<String, dynamic> json) {
    return PolytechnicSaveCategory(
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
