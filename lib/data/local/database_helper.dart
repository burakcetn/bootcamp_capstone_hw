import 'dart:io';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String database = "favorite.sqlite";

  static Future<Database> instance() async {
    String veritabaniYolu = join(await getDatabasesPath(), database);

    if (await databaseExists(veritabaniYolu)) {
      Logger().d("Veritabanı daha önce kopyalanmış");
    } else {
      ByteData data = await rootBundle.load("database/$database");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(veritabaniYolu).writeAsBytes(bytes, flush: true);
      Logger().d("Veritabanı oluşturuldu");
    }

    return openDatabase(veritabaniYolu);
  }
}
