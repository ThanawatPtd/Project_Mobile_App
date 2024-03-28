import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mobile_app/pages/home/home.dart';
import 'package:project_mobile_app/pages/login/login.dart';
import 'package:project_mobile_app/pages/signup/signup.dart';
import 'package:project_mobile_app/pages/summary/summary.dart';
import 'package:project_mobile_app/pages/welcome/bloc/welcomeBloc.dart';
import 'package:project_mobile_app/pages/welcome/welcome.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeFirebase();
  runApp(const MyApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
                home: Summary(),
                routes: {
                  'login': (context) =>  const Login(),
                  'signup': (context) => const Signup(),
                  'home':(context) => const Home(),
                  'summary':(context) => const Summary(),
                },
              )),
    );
  }
}
