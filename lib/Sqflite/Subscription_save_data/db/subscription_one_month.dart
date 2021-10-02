// ignore_for_file: camel_case_types

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:voltagelab/Sqflite/Subscription_save_data/Model/subscription_model.dart';

class SqlSubscriptiononemonth_DB {
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initdb();
    return _database;
  }

  Future<Database> initdb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Subscriptiononemonth.db");

    return await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      await database.execute("""
       CREATE TABLE MYTable (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       subscriptionid TEXT,
       startdate TEXT,
       enddate TEXT,
       status TEXT,
       subscriptionpack TEXT,
       remaining TEXT
      )

      """);
    });
  }

  Future<bool> insertdata(
      Subscriptionsaveuserdata subscriptionsaveuserdata) async {
    final db = await initdb();
    db.insert("MYTable", subscriptionsaveuserdata.toMap());
    return true;
  }

  Future<List<Subscriptionsaveuserdata>> getdata() async {
    final db = await initdb();
    final List<Map<String, Object?>> datas = await db.query("MYTable");
    return datas.map((e) => Subscriptionsaveuserdata.fromMap(e)).toList();
  }

  // update(Subscriptionsaveuserdata subscriptionsaveuserdata) async {
  //   final db = await initdb();
  //   var result = await db.update("MYTable", subscriptionsaveuserdata.toMap(),
  //       where: "id = ?",
  //       whereArgs: [
  //         subscriptionsaveuserdata.id,
  //       ]);
  //   return result;
  // }

  // orderupdate(SaveCategory saveCategory) async {
  //   final db = await initdb();
  //   var result = await db.update("MYTable", saveCategory.toMap(),
  //       where: "id = ?", whereArgs: [saveCategory.orderno]);
  //   return result;
  // }

  Future delete(String subscriptionid) async {
    final db = await initdb();
    db.delete("MYTable",
        where: "subscriptionid = ?", whereArgs: [subscriptionid]);
  }
}
