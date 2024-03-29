import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mobile_app/widgets/appbar.dart';
import 'package:project_mobile_app/widgets/colors.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(snapshot.data!,style: TextStyle(color: CustomColor.primaryColor),),
                ),
                settingButton("Password", Icon(Icons.arrow_right)),
                settingButton("Category", Icon(Icons.arrow_right)),
                settingButton("App information", Icon(Icons.arrow_right)),
                SizedBox(height: 380,),
                logoutButton("Logout", CustomColor.primaryColor),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
        future: getUsername(),
      ),
    ));
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
      String email = data['Email'];
      return '$name\n';
      // Use the data for your UI or logic
    } else {
      // The document does not exist
      return 'Document does not exist';
    }
  }
}

Widget settingButton(String text, Icon icon) {
  return Padding(
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