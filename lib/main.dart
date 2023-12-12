import 'package:bootcamp_hw_capstone/data/local/database_helper.dart';
import 'package:bootcamp_hw_capstone/data/local/mysharedpref.dart';
import 'package:bootcamp_hw_capstone/ui/bloc/cart_dialog_bloc.dart';
import 'package:bootcamp_hw_capstone/ui/bloc/cart_page_bloc.dart';
import 'package:bootcamp_hw_capstone/ui/bloc/details_page_cubit.dart';

import 'package:bootcamp_hw_capstone/ui/bloc/home_page_cubit.dart';
import 'package:bootcamp_hw_capstone/ui/bloc/login_page_cubit.dart';
import 'package:bootcamp_hw_capstone/ui/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseHelper.instance();

  await MySharedPref.init();

  MySharedPref.setToken("");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => CartPageCubit()),
        BlocProvider(create: (context) => DetailsPageCubit()),
        BlocProvider(create: (context) => CartDialogBloc()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: "Ubuntu"),
        home: const SplashScreen(),
      ),
    );
  }
}
