import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_mobile_app/services/flutterfire.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              // appBar: AppBar(
              //   elevation: 0.5,
              //   bottom: PreferredSize(
              //     preferredSize: Size.fromHeight(1),
              //     child: Container(
              //       color: Colors.grey.withOpacity(0.5),
              //       height: 1,
              //     ),
              //   ),
              //   backgroundColor: Colors.white,
              //   actions: [
              //     Padding(
              //       padding: const EdgeInsets.only(top: 20),
              //       child: Text(
              //         "Log in",
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontSize: 16.sp,
              //             fontWeight: FontWeight.normal),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 175,
              //     )
              //   ],
              // ),
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
                        buildTextField("Username",
                            const FaIcon(FontAwesomeIcons.solidUser), "Email"),
                        const SizedBox(
                          height: 20,
                        ),
                        // reuseableText("Password"),
                        buildTextField("Password",
                            const FaIcon(FontAwesomeIcons.lock), "Password"),
                        SizedBox(
                          height: 30.h,
                        ),
                        button("Login", Colors.green[300]!),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              reuseableText("Don't have account? "),
                              signUpButton(),
                            ],
                          ),
                        ),
                      ]),
                ),
              )),
        ));
  }

  Widget reuseableText(String text) {
    return Container(
      margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
      child: Container(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.grey.withOpacity(0.5),
            fontWeight: FontWeight.normal,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String text, FaIcon icon, String type) {
    return Container(
        width: 325.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            icon,
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 270.w,
              height: 50.h,
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                obscureText: type == "Email" ? false : true,
                decoration: InputDecoration(
                  hintText: text,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget signUpButton() {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'signup'),
        child: Container(
          margin: EdgeInsets.only(top: 5.h, bottom: 10.h),
          child: Container(
            child: Text(
              "Sign up",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
              ),
            ),
          ),
        ));
  }

  Widget button(String text, Color color) {
    return GestureDetector(
      onTap: () async{
        bool signInPass = await signIn("Thanawatptd@hotmail.com", "123456");
        if(signInPass){
         Navigator.pushNamed(context, 'home'); 
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        width: 325.w,
        height: 50.h,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(15.w)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, -1))
            ]),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 16.sp,
          ),
        )),
      ),
    );
  }
}
