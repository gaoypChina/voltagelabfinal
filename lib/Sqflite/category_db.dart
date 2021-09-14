import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:voltagelab/Sqflite/Model/category_model.dart';

class SqlCategoryDB {
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initdb();
    return _database;
  }

  Future<Database> initdb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Category.db");

    return await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      await database.execute("""
       CREATE TABLE MYTable (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       categoryid INTEGER,
       categoryname TEXT
      )

      """);
    });
  }

  Future<bool> insertdata(SaveCategory saveCategory) async {
    final db = await initdb();
    db.insert("MYTable", saveCategory.toMap());
    return true;
  }

  Future<List<SaveCategory>> getdata() async {
    final db = await initdb();
    final List<Map<String, Object?>> datas = await db.query("MYTable");
    return datas.map((e) => SaveCategory.fromMap(e)).toList();
  }

  update(SaveCategory saveCategory) async {
    final db = await initdb();
    var result = await db.update("MYTable", saveCategory.toMap(),
        where: "id = ?", whereArgs: [saveCategory.id]);
    return result;
  }

  // orderupdate(SaveCategory saveCategory) async {
  //   final db = await initdb();
  //   var result = await db.update("MYTable", saveCategory.toMap(),
  //       where: "id = ?", whereArgs: [saveCategory.orderno]);
  //   return result;
  // }

  Future delete(int id) async {
    final db = await initdb();
    db.delete("MYTable", where: "id = ?", whereArgs: [id]);
  }
}
