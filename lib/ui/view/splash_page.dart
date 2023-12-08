import 'package:bootcamp_hw_capstone/ui/view/home_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Image.asset("assets/images/splash.jpg"),
                Text(
                  "2HomeService",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: Colors.red),
                ),
              ],
            ),
            CircularProgressIndicator(
              color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }
}
