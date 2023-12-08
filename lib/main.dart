import 'package:bootcamp_hw_capstone/ui/bloc/home_page_cubit.dart';
import 'package:bootcamp_hw_capstone/ui/view/home_page.dart';
import 'package:bootcamp_hw_capstone/ui/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: "Ubuntu"),
        home: const SplashScreen(),
      ),
    );
  }
}
