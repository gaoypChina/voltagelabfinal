import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  Color color;
  String imgName;
  String name;
  IconData icon;
  List<SubCategory> subCategories;

  Category({
    required this.name,
    required this.imgName,
    required this.color,
    required this.icon,
    required this.subCategories,
  });
}

class SubCategory {
  String name;
  String imgName;
  Color color;
  IconData icon;
  List<SubChildCategory> subChildCategory;

  SubCategory({
    required this.name,
    required this.imgName,
    required this.color,
    required this.icon,
    required this.subChildCategory,
  });
}

class SubChildCategory {
  String name;
  String imgName;
  Color color;
  IconData icon;

  SubChildCategory({
    required this.name,
    required this.imgName,
    required this.color,
    required this.icon,
  });
}

final List<Category> allcategory = [
  Category(
      name: "first",
      imgName: "first",
      color: Colors.blue,
      icon: Icons.ac_unit,
      subCategories: [
        SubCategory(
            name: "first",
            imgName: "first",
            color: Colors.blue,
            icon: Icons.ac_unit,
            subChildCategory: [
              SubChildCategory(
                  name: "first",
                  imgName: "first",
                  color: Colors.blue,
                  icon: Icons.ac_unit)
            ])
      ]),
  Category(
      name: "first",
      imgName: "first",
      color: Colors.blue,
      icon: Icons.ac_unit,
      subCategories: [
        SubCategory(
            name: "first",
            imgName: "first",
            color: Colors.blue,
            icon: Icons.ac_unit,
            subChildCategory: [
              SubChildCategory(
                  name: "first",
                  imgName: "first",
                  color: Colors.blue,
                  icon: Icons.ac_unit)
            ])
      ])
];
