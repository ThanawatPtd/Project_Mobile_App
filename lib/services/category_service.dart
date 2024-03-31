import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoryService{
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late CollectionReference categories;

  void setCategory(){
      categories = FirebaseFirestore.instance.collection("Users").doc(uid).collection("Categories");
    }

  Stream<QuerySnapshot> getCategories(){
    return categories.snapshots();
  }

  void addCategory(String categoryName, String iconName){
    categories.add({
      "CategoryName": categoryName,
      "IconName": iconName
    });
  }
}