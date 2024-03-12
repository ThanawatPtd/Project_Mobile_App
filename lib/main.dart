import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mobile_app/pages/home/home.dart';
import 'package:project_mobile_app/pages/login/login.dart';
import 'package:project_mobile_app/pages/signup/signup.dart';
import 'package:project_mobile_app/pages/welcome/bloc/welcomeBloc.dart';
import 'package:project_mobile_app/pages/welcome/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WelcomeBloc()),
      ],
      child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Welcome(),
                routes: {
                  'login': (context) =>  const Login(),
                  'signup': (context) => const Signup(),
                  'home':(context) => const Home(),
                },
              )),
    );
  }
}
