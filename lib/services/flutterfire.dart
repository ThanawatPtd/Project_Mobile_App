import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_mobile_app/models/appicon.dart';
import 'package:project_mobile_app/services/category_service.dart';

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

Future<bool> register(String username, String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    String userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .set({"Email": email, "Username": username, "Amount": 0});
    CategoryService categoryService = CategoryService();
    categoryService.setCategory();
    for(int i = 0;i < 20;i++){
      categoryService.addCategory(iconNameList[i], iconNameList[i]);
    }
    FirebaseAuth.instance.signOut();
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> changePassword(String currentPassword, String newPassword) async {
  bool success = false;

  //Create an instance of the current user.
  var user = await FirebaseAuth.instance.currentUser!;
  //Must re-authenticate user before updating the password. Otherwise it may fail or user get signed out.

  final cred = await EmailAuthProvider.credential(
      email: user.email!, password: currentPassword);
  await user.reauthenticateWithCredential(cred).then((value) async {
    await user.updatePassword(newPassword).then((_) {
      success = true;
    }).catchError((error) {
      print(error);
    });
  }).catchError((err) {
    print(err);
  });

  return success;
}
