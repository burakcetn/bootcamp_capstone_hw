import 'package:bootcamp_hw_capstone/core/constants/constants.dart';
import 'package:bootcamp_hw_capstone/core/utils/custom_snackbar.dart';
import 'package:bootcamp_hw_capstone/data/local/mysharedpref.dart';
import 'package:bootcamp_hw_capstone/data/models/error_model.dart';
import 'package:bootcamp_hw_capstone/data/models/login_response_model.dart';
import 'package:bootcamp_hw_capstone/data/models/user_login_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserRepository {
  final dio = Dio();

  Future<bool> loginUser(UserLoginModel userLoginModel) async {
    Response response;
    try {
      response = await dio.post("${AppConstants.loginUrl}api/login",
          data: userLoginModel.toJson(),
          options: Options(headers: {
            "x-lang": "tr",
            "Accept": "application/json",
            "Content-type": "application/json"
          }));
      if (response.statusCode == 200) {
        LoginResponseModel token = LoginResponseModel.fromJson(response.data);
        MySharedPref.setToken(token.token);
        Logger().d(token.token);
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      Logger().e(e.response.toString());
      ErrorModel error = ErrorModel.fromJson(e.response?.data);
      CustomSnackBar.showCustomErrorSnackBar(
          title: "Hata", message: error.error);
      return false;
    }
  }
}
