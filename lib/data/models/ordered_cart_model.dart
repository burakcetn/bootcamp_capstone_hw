class OrderedCartModel {
  List<int> sepetYemekId;
  String yemekAdi;
  String yemekResimAdi;
  String yemekFiyat;
  int yemekSiparisAdet;
  String kullaniciAdi;

  OrderedCartModel({
    required this.sepetYemekId,
    required this.yemekAdi,
    required this.yemekResimAdi,
    required this.yemekFiyat,
    required this.yemekSiparisAdet,
    required this.kullaniciAdi,
  });

  factory OrderedCartModel.fromJson(Map<String, dynamic> json) =>
      OrderedCartModel(
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
