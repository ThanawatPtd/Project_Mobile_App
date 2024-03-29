import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile_app/widgets/appbar.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final docRef = FirebaseFirestore.instance.collection('your_collection').doc('document_id');

  @override
  Widget build(BuildContext context) {

    return Container(
              child: Center(
            child: FutureBuilder(builder: (context, snapshot) {
              if(snapshot.hasData){
                return Text(snapshot.data!);
              }
              else{
                return CircularProgressIndicator();
              }
            }, future: getUsername(),),
              )
    );
  }

  Future<String> getUsername()async{
    // Reference to the document you want to retrieve
final docRef = FirebaseFirestore.instance.collection('Users').doc(uid);

// Get the document data
DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await docRef.get();

// Check if the document exists
if (documentSnapshot.exists) {
  // Get the data as a Map
  Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
  
  // Access specific fields
  String name = data['Username'];
  String email = data['Email'];
  return '$name\n$email';
  // Use the data for your UI or logic
} else {
  // The document does not exist
  return 'Document does not exist';
}

  }
}
