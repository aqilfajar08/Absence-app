import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:training/core/components/custom_button_training.dart';
import 'package:training/core/extensions/build_context_ext.dart';
import 'package:training/presentation/auth/bloc/bloc_login_bloc.dart';
import 'package:training/presentation/home/pages/home_page.dart';
import 'package:training/presentation/home/pages/main_page.dart';

import '../../../core/core.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  bool isShowPassword = true;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.images.towerComp.path,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpaceHeight(100),
                const Text(
                  'Hello There',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SpaceHeight(80),
                CustomTextField(
                  controller: emailController,
                  label: 'Email Address',
                ),
                const SpaceHeight(20),
                CustomTextField(
                  controller: passwordController,
                  label: 'Password',
                  obscureText: isShowPassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isShowPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.black[200],
                    ),
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                  ),
                ),
                const SpaceHeight(40),
                CustomButtonTraining(
                  title: 'Sign In',
                  onPressed: () {},
                ),
                const SpaceHeight(20),
                CustomButtonTraining(
                  title: 'Attendence with Face ID',
                  prefixIcon: Assets.icons.attendance.svg(),
                  onPressed: () {},
                ),
                const SpaceHeight(20),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if(state is LoginSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }

                    if(state is LoginFailure) {
                      final errorMessage = jsonDecode(state.message) ['message'];

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(errorMessage)
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton.filled(
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                LoginButtonPressed(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        },
                        label: 'Login',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
