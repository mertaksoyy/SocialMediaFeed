import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbHelper {
  static final String dbName = "socialmedia.sqlite";

  static Future<Database> dbAccess() async {
    String path = join(await getDatabasesPath(), dbName);

    if (await databaseExists(path)) {
      //Veritabanı var mı yok mu kontrolü
      print("You have already copied");
    } else {
      ByteData data = await rootBundle.load("database/$dbName");

      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      //Veritabanının kopyalanması.
      await File(path).writeAsBytes(bytes, flush: true);
      print("db copied");
    }
    //Veritabanını açıyoruz.
    return openDatabase(path);
  }
}
