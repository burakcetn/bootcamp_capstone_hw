import 'package:bootcamp_hw_capstone/core/constants/constants.dart';
import 'package:bootcamp_hw_capstone/ui/bloc/login_page_cubit.dart';
import 'package:bootcamp_hw_capstone/ui/view/login/custom_background_painter.dart';
import 'package:bootcamp_hw_capstone/ui/view/login/login_form.dart';
import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginPageBloc bloc = LoginPageBloc();
  @override
  Widget build(BuildContext context) {
    print("tekrar çalıştı");
    return Scaffold(
      backgroundColor: Colors.redAccent,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              CustomPaint(
                painter: CustomBackgroundPainter(),
                size: Size(420, 400),
              ),
              Material(
                type: MaterialType.transparency,
                child: Hero(
                  tag: "logoHero",
                  child: SizedBox(
                    height: 400,
                    child: SizedBox(
                        width: 300,
                        height: 100,
                        child: RiveAnimation.asset(
                          "assets/images/splash.riv",
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 800,
                width: 420,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                    ),
                    LoginForm(bloc: bloc),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: SizedBox(
                          height: 60,
                          width: 120,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            onPressed: () => bloc.loginButtonFuction(),
                            child: const Text("Login"),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

InputDecoration inputDecorationConstant(
  String labelText,
  IconData iconData, {
  String? prefix,
  String? helperText,
}) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    helperText: helperText,
    labelText: labelText,
    prefixStyle: const TextStyle(color: Colors.white, fontSize: 14),
    suffixStyle: const TextStyle(color: Colors.white, fontSize: 14),
    hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
    labelStyle: const TextStyle(color: Colors.white, fontSize: 14),
    fillColor: Colors.transparent,
    filled: true,
    // prefixText: prefix,
    prefixIcon: Icon(
      iconData,
      size: 20,
      color: Colors.white,
    ),
    prefixIconConstraints: const BoxConstraints(minWidth: 60),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      // borderSide: BorderSide(color: Colors.grey),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      // borderSide: BorderSide(color: Colors.grey),
    ),
  );
}
