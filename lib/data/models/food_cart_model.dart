import 'dart:convert';

CartItemModel cartItemModelFromJson(String str) =>
    CartItemModel.fromJson(json.decode(str));

String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());

class CartItemModel {
  List<SepetYemekler> sepetYemekler;
  int success;

  CartItemModel({
    required this.sepetYemekler,
    required this.success,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        sepetYemekler: List<SepetYemekler>.from(
            json["sepet_yemekler"].map((x) => SepetYemekler.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "sepet_yemekler":
            List<dynamic>.from(sepetYemekler.map((x) => x.toJson())),
        "success": success,
      };
}

class SepetYemekler {
  String sepetYemekId;
  String yemekAdi;
  String yemekResimAdi;
  String yemekFiyat;
  String yemekSiparisAdet;
  String kullaniciAdi;

  SepetYemekler({
    required this.sepetYemekId,
    required this.yemekAdi,
    required this.yemekResimAdi,
    required this.yemekFiyat,
    required this.yemekSiparisAdet,
    required this.kullaniciAdi,
  });

  factory SepetYemekler.fromJson(Map<String, dynamic> json) => SepetYemekler(
        sepetYemekId: json["sepet_yemek_id"],
        yemekAdi: json["yemek_adi"],
        yemekResimAdi: json["yemek_resim_adi"],
        yemekFiyat: json["yemek_fiyat"],
        yemekSiparisAdet: json["yemek_siparis_adet"],
        kullaniciAdi: json["kullanici_adi"],
      );

  Map<String, dynamic> toJson() => {
        "sepet_yemek_id": sepetYemekId,
        "yemek_adi": yemekAdi,
        "yemek_resim_adi": yemekResimAdi,
        "yemek_fiyat": yemekFiyat,
        "yemek_siparis_adet": yemekSiparisAdet,
        "kullanici_adi": kullaniciAdi,
      };
}
