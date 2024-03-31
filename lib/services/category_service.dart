import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoryService{
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late CollectionReference categorise;

  void setCategory(){
    categorise = FirebaseFirestore.instance.collection("Users").doc(uid).collection("Categories");
  }

  Stream<QuerySnapshot> getCategories(){
    return categorise.snapshots();
  }

  void addCategory(String categoryName){
    categorise.add({
      "CategoryName": categoryName
    });
  }
}