import 'package:bootcamp_hw_capstone/data/models/user_login_model.dart';
import 'package:bootcamp_hw_capstone/data/repositories/user_repository.dart';
import 'package:bootcamp_hw_capstone/ui/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageBloc {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginButtonFuction() async {
    var loginUser = UserLoginModel(
        email: emailController.text, password: passwordController.text);
    bool isLogged = await UserRepository().loginUser(loginUser);
    if (isLogged == true) {
      Get.off(() => HomePage());
    }
  }
}
