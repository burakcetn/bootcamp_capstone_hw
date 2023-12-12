import 'package:bootcamp_hw_capstone/ui/bloc/login_page_cubit.dart';
import 'package:bootcamp_hw_capstone/ui/view/login/login_page.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final LoginPageBloc bloc;
  const LoginForm({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "LogIn",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: inputDecorationConstant("email", Icons.email),
            controller: bloc.emailController,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white30,
          ),
          child: TextField(
            decoration: inputDecorationConstant("password", Icons.key),
            controller: bloc.passwordController,
          ),
        )
      ],
    );
  }
}
