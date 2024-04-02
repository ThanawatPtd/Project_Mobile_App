import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PlanService{
  late String userId = FirebaseAuth.instance.currentUser!.uid;
  late CollectionReference plan;

  void setPlan(){
      plan = FirebaseFirestore.instance.collection("Users").doc(userId).collection("Plans");
    }

  Stream<QuerySnapshot> getPlans(){
    return plan.snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getDataPlan(
      String docId) async {
    final docRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Record')
        .doc(docId);
    // Get the document data
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await docRef.get();
    if (documentSnapshot.exists) {
      // Get the data as a Map

      return documentSnapshot;
      // Use the data for your UI or logic
    }
    return null;
  }

  Future<void> addPlan(String name, num target,String description, String date){
    return plan.add({
      "Name": name,
      "Target": target,
      "Description": description,
      "EndDate": date
    });
  }

  Future<void> updatePlan(String docId,String name, num target,String description, String date){
    return plan.doc(docId).update({
      "Name": name,
      "Target": target,
      "Description": description,
      "EndDate": date
    });
  }
}