import 'dart:convert';

import 'package:bootcamp_hw_capstone/data/models/food_cart_model.dart';
import 'package:bootcamp_hw_capstone/data/models/food_model.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class FoodRepository {
  var dioClient = Dio();

  Future getFoodList() async {
    String url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    Response response = await dioClient.get(url);
    List<Yemekler> foodList = [];

    if (response.statusCode == 200) {
      // FoodModel foodResponse = FoodModel.fromJson(response.data);

      FoodModel foodResponse = FoodModel.fromJson(jsonDecode(response.data));
      foodList = foodResponse.yemekler;
      return foodList;
    }
  }

  Future setItemToCart(Yemekler yemek) async {
    String url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    String yemekAdi = yemek.yemekAdi;
    int yemekFiyat = int.parse(yemek.yemekFiyat);

    String yemekResimAdi = yemek.yemekResimAdi;
    String userName = "burak_cetin";

    var data = <String, dynamic>{
      "yemek_adi": yemekAdi,
      "yemek_resim_adi": yemekResimAdi,
      "yemek_fiyat": yemekFiyat,
      "yemek_siparis_adet": 1,
      "kullanici_adi": userName
    };

    Response response = await dioClient.post(url, data: FormData.fromMap(data));
    if (response.statusCode == 200) {
      return true;
    } else {
      false;
    }
  }

  Future getCartItems(String kullaniciAdi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    List<SepetYemekler> cartItems = [];
    try {
      var data = {"kullanici_adi": kullaniciAdi};
      Response response = await Dio().post(url, data: FormData.fromMap(data));

      if (response.statusCode == 200) {
        CartItemModel cartItemModel =
            CartItemModel.fromJson(jsonDecode(response.data));
        cartItems = cartItemModel.sepetYemekler;

        return cartItems;
      }
    } catch (hata) {
      Logger().e(hata);
    }
  }

  Future updateItemInCart(List<int> yemekIds, int itemCount) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";

    for (int x = 0; x <= itemCount - 1; x++) {
      var data = {
        "kullanici_adi": "burak_cetin",
        "sepet_yemek_id": yemekIds[x]
      };
      var response = await dioClient.post(url, data: FormData.fromMap(data));
      if (response.statusCode == 200) {}
    }
  }
}
