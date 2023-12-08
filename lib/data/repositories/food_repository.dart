import 'dart:convert';

import 'package:bootcamp_hw_capstone/data/models/food_model.dart';
import 'package:dio/dio.dart';

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
}
