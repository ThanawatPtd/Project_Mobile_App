import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_mobile_app/pages/login/login_widgets.dart';
import 'package:project_mobile_app/services/flutterfire.dart';
import 'package:project_mobile_app/widgets/colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 25),
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 22.sp),
                          ),
                        ),
                        // reuseableText("Email"),
                        buildTextField(
                            "Email",
                            const FaIcon(FontAwesomeIcons.solidUser),
                            "Email",
                            emailController),
                        const SizedBox(
                          height: 20,
                        ),
                        // reuseableText("Password"),
                        buildTextField(
                            "Password",
                            const FaIcon(FontAwesomeIcons.lock),
                            "Password",
                            passwordController),
                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            bool signInPass = await signIn(
                                // emailController.text.trim(),
                                // passwordController.text.trim());
                                "Thanawatptd@hotmail.com",
                                "123456");
                            if (signInPass) {
                              Navigator.pushNamed(context, 'home'); //go to page
                            }
                          },
                          child: loginButton("Login", CustomColor.primaryColor),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              reuseableText("Don't have account? "),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.pushNamed(context, 'signup'),
                                child: signUpButton(),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              )),
        ));
  }
}
