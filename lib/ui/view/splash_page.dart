import 'package:bootcamp_hw_capstone/data/local/mysharedpref.dart';
import 'package:bootcamp_hw_capstone/ui/view/home_page.dart';
import 'package:bootcamp_hw_capstone/ui/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 5),
        () => MySharedPref.getToken() == ""
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()))
            : Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage())));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Hero(
                  tag: "logoHero",
                  child: SizedBox(
                      width: 300,
                      height: 100,
                      child: RiveAnimation.asset(
                        "assets/images/splash.riv",
                        fit: BoxFit.contain,
                      )),
                ),
                Text(
                  "2HomeService",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: Colors.red),
                ),
              ],
            ),
            const CircularProgressIndicator(
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
}
