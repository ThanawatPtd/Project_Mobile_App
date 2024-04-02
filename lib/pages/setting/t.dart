import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_mobile_app/services/category_service.dart';
import 'package:project_mobile_app/services/firestore_service.dart';
import 'package:project_mobile_app/widgets/colors.dart';
import 'package:project_mobile_app/services/flutterfire.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final categoryNameController = TextEditingController();
  late List categoryList;
  late String userImgae;
  late final userdoc;
  final CategoryService categoryService = CategoryService();
  final UserService userService = UserService();

  @override
  initState() {
    categoryService.setCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Container(
            height: 125.w,
            decoration: BoxDecoration(color: Colors.grey[200]),
          ),
          Transform.translate(
            offset: Offset(0, 90),
            child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 3.h,
                          spreadRadius: 0.5.h,
                          offset: Offset(0, -5.h))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: SingleChildScrollView(
                  child: Center(
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          String username = data["Username"];
                          String userImgae = data["Image"];
                          return Column(
                            children: [
                              SizedBox(
                                height: 50.h,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  username,
                                  style: TextStyle(
                                      color: CustomColor.primaryColor),
                                ),
                              ),
                              settingButton("Password", Icon(Icons.arrow_right),
                                  () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          height: 300,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text("Change Password"),
                                              textFieldSetting("Old Password",
                                                  oldPasswordController),
                                              textFieldSetting("New Password",
                                                  newPasswordController),
                                              textFieldSetting(
                                                  "Confirm Password",
                                                  confirmPasswordController),
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    if (newPasswordController
                                                            .text ==
                                                        confirmPasswordController
                                                            .text) {
                                                      Future<bool>
                                                          changePasswordPass =
                                                          changePassword(
                                                              oldPasswordController
                                                                  .text,
                                                              newPasswordController
                                                                  .text);
                                                      bool
                                                          passwordChangeSuccess =
                                                          await changePasswordPass; // Wait for result
                                                      if (passwordChangeSuccess) {
                                                        Navigator.pop(
                                                            context); // Close dialog

                                                        // Show successful password change dialog
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: Text(
                                                                  "Change Password Successful",
                                                                ),
                                                                actions: [
                                                                  Center(
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                          backgroundColor: CustomColor
                                                                              .primaryColor,
                                                                          foregroundColor:
                                                                              Colors.white),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context); // Close AlertDialog
                                                                      },
                                                                      child: Text(
                                                                          "OK"),
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }
                                                  },
                                                  child:
                                                      Text("Confirm Password"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: CustomColor
                                                        .primaryColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              settingButton("Category", Icon(Icons.arrow_right),
                                  () {
                                showDialog(
                                    // category grid
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("Category"),
                                                    smallButton(
                                                        () => Navigator.pop(
                                                            context),
                                                        Colors.red,
                                                        Colors.white,
                                                        Icon(
                                                          Icons.close,
                                                          color: Colors.white,
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              StreamBuilder(
                                                stream: categoryService
                                                    .getCategories(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    categoryList =
                                                        snapshot.data!.docs ??
                                                            [];
                                                    return Expanded(
                                                        child: GridView.builder(
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 3,
                                                            ),
                                                            itemCount:
                                                                categoryList
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              DocumentSnapshot
                                                                  documentSnapshot =
                                                                  categoryList[
                                                                      index];
                                                              Map<String,
                                                                      dynamic>
                                                                  data =
                                                                  documentSnapshot
                                                                          .data()
                                                                      as Map<
                                                                          String,
                                                                          dynamic>;
                                                              String
                                                                  categoryName =
                                                                  data[
                                                                      "CategoryName"];
                                                              String
                                                                  categoryIcon =
                                                                  data[
                                                                      "IconName"];
                                                              return GestureDetector(
                                                                child: categoryCard(
                                                                    categoryName,
                                                                    categoryIcon),
                                                                onTap: () {},
                                                              );
                                                            }));
                                                  } else {
                                                    return CircularProgressIndicator();
                                                  }
                                                },
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: smallButton(() {
                                                      Navigator.pushNamed(
                                                          context,
                                                          "create_category");
                                                    },
                                                        CustomColor
                                                            .primaryColor,
                                                        Colors.white,
                                                        Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        )),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              settingButton(
                                  "App information", Icon(Icons.arrow_right),
                                  () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Theme(
                                          data: Theme.of(context).copyWith(
                                              textButtonTheme: TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          CustomColor
                                                              .primaryColor))),
                                          child: AboutDialog(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text("Developed By"),
                                                    Text("Thanawat Potidet "),
                                                    Text("Chutipong Triyasith")
                                                  ],
                                                )
                                              ],
                                              applicationName:
                                                  "Project Mobile App",
                                              applicationVersion:
                                                  "version: 0.0.1"));
                                    });
                              }),
                              SizedBox(
                                height: 250.h,
                              ),
                              GestureDetector(
                                child: logoutButton(
                                    "Logout", CustomColor.primaryColor),
                                onTap: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                      future: userService.getUserData(),
                    ),
                  ),
                )),
          ),
          // Transform.translate(
          //   child: profileImage(),
          //   offset: Offset(1.w, 20.h),
          // ),
          Transform.translate(
            offset: Offset(0, 20.h),
            child: Row(
              children: [
                profileImage(),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          )
        ]),
      ],
    );
  }

  Widget textFieldSetting(String text, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColor.primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColor.primaryColor)),
          hintText: text,
        ),
        obscureText: true,
      ),
    );
  }

  Future<String> getUsername() async {
    // Reference to the document you want to retrieve
    final docRef = FirebaseFirestore.instance.collection('Users').doc(uid);

// Get the document data
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await docRef.get();

// Check if the document exists
    if (documentSnapshot.exists) {
      // Get the data as a Map
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      // Access specific fields
      String name = data['Username'];
      return '$name\n';
      // Use the data for your UI or logic
    } else {
      // The document does not exist
      return 'Document does not exist';
    }
  }

  Future<String> getImage() async {
    final docRef = FirebaseFirestore.instance.collection('Users').doc(uid);
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await docRef.get();
    if (documentSnapshot.exists) {
      // Get the data as a Map
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;

      // Access specific fields
      String image = data["Image"];
      return '$image';
      // Use the data for your UI or logic
    } else {
      // The document does not exist
      return 'Document does not exist';
    }
  }

  Widget profileImage() {
    if (userImgae != "") {
      return ClipOval(
        child: Image.network(userImgae,
            width: 100.w, height: 100.h, fit: BoxFit.cover),
      );
    }
    else{
      return ClipOval(
        child: Image.asset("assets/images/logo.png",
            width: 100.w, height: 100.h, fit: BoxFit.cover),
      );
    }
  }
}

Widget settingButton(String text, Icon icon, Function() function) {
  return GestureDetector(
    onTap: function,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(children: [
        Container(
          width: 325.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(text),
              ),
              icon
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            height: 1,
          ),
        )
      ]),
    ),
  );
}

Widget logoutButton(String text, Color color) {
  return Container(
    margin: EdgeInsets.only(top: 20.h),
    width: 275.w,
    height: 40.h,
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

Widget smallButton(
    Function() function, Color containerColor, Color iconColor, Icon icon) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: containerColor),
    child: IconButton(
      icon: icon,
      onPressed: function,
    ),
  );
}

Widget categoryCard(String categoryName, String categoryIcon) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      decoration: BoxDecoration(
          // border: Border.all(width: 1, color: Colors.green),
          color: CustomColor.primaryColor,
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/${categoryIcon}.svg",
              width: 30.w,
              height: 28.h,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                categoryName,
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ],
        )),
      ),
    ),
  );
}
