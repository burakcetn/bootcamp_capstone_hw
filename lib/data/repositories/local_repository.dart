import 'package:bootcamp_hw_capstone/data/local/database_helper.dart';
import 'package:bootcamp_hw_capstone/data/models/food_model.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

class LocalRepository {
  Future<void> setList(List<Yemekler> yemekler) async {
    var db = await DatabaseHelper.instance();

    for (var yemek in yemekler) {
      var favorite = <String, dynamic>{};
      favorite["id"] = yemek.yemekId;
      favorite["name"] = yemek.yemekAdi;
      favorite["pictureName"] = yemek.yemekResimAdi;
      favorite["price"] = yemek.yemekFiyat;

      int a = await db.insert("favorite", favorite,
          conflictAlgorithm: ConflictAlgorithm.replace);
      Logger().d("$a idli yemek local'e eklendi varsa güncellendi");
    }
  }

  Future<List<Yemekler>> searchFood(String query) async {
    var db = await DatabaseHelper.instance();
    List<Map<String, dynamic>> rows =
        await db.rawQuery("SELECT * FROM favorite WHERE name like '%$query%'");
    return List.generate(rows.length, (i) {
      return Yemekler(
        yemekId: rows[i]['id'].toString(),
        yemekAdi: rows[i]['name'] as String,
        yemekResimAdi: rows[i]['pictureName'] as String,
        yemekFiyat: rows[i]['price'] as String,
      );
    });
  }
}
