import 'dart:convert';

FoodModel foodModelFromJson(String str) => FoodModel.fromJson(json.decode(str));

String foodModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel {
  List<Yemekler> yemekler;
  int success;

  FoodModel({
    required this.yemekler,
    required this.success,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        yemekler: List<Yemekler>.from(
            json["yemekler"].map((x) => Yemekler.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "yemekler": List<dynamic>.from(yemekler.map((x) => x.toJson())),
        "success": success,
      };
}

class Yemekler {
  String yemekId;
  String yemekAdi;
  String yemekResimAdi;
  String yemekFiyat;

  Yemekler({
    required this.yemekId,
    required this.yemekAdi,
    required this.yemekResimAdi,
    required this.yemekFiyat,
  });

  factory Yemekler.fromJson(Map<String, dynamic> json) => Yemekler(
        yemekId: json["yemek_id"],
        yemekAdi: json["yemek_adi"],
        yemekResimAdi: json["yemek_resim_adi"],
        yemekFiyat: json["yemek_fiyat"],
      );

  Map<String, dynamic> toJson() => {
        "yemek_id": yemekId,
        "yemek_adi": yemekAdi,
        "yemek_resim_adi": yemekResimAdi,
        "yemek_fiyat": yemekFiyat,
      };
}
