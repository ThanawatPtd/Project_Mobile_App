import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
              ),
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
                            "Sign up",
                            style: TextStyle(fontSize: 22.sp),
                          ),
                        ),
                        buildTextField("name",
                            const FaIcon(FontAwesomeIcons.solidUser), "Email"),
                        const SizedBox(
                          height: 20,
                        ),
                        buildTextField("username",
                            const FaIcon(FontAwesomeIcons.circleUser), "Email"),
                        SizedBox(
                          height: 20.h,
                        ),
                        buildTextField("password",
                            const FaIcon(FontAwesomeIcons.key), "Password"),
                        SizedBox(
                          height: 20.h,
                        ),
                        buildTextField("confirm password",
                            const FaIcon(FontAwesomeIcons.key), "Password"),
                        SizedBox(
                          height: 30.h,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: button("Sign up", Colors.green[300]!),
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
          border: Border.all(width: 1),
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

  Widget button(String text, Color color) {
    return Container(
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
    );
  }
}
