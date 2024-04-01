

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mobile_app/firebase_options.dart';
import 'package:project_mobile_app/pages/create_record/create_record.dart';
import 'package:project_mobile_app/pages/home/home.dart';
import 'package:project_mobile_app/pages/login/login.dart';
import 'package:project_mobile_app/pages/setting/setting.dart';
import 'package:project_mobile_app/pages/signup/signup.dart';
import 'package:project_mobile_app/pages/summary/summary.dart';
import 'package:project_mobile_app/pages/welcome/bloc/welcomeBloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  await FirebaseAppCheck.instance.activate();
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
                theme: ThemeData(
                  textTheme: TextTheme(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                debugShowCheckedModeBanner: false,
                home: Login(),
                routes: {
                  'login': (context) => const Login(),
                  'signup': (context) => const Signup(),
                  'home':(context) => const Home(),
                  'summary':(context) => Summary(),
                  'setting':(context) => const Setting(),
                  'create_record':(context) => CreateRecord(),
                },
              )),
    );
  }
}
