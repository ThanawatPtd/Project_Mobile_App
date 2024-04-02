import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class FirestoreService {
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   static final CollectionReference _todoCollection = _firestore.collection('Users');

//   static Future<void> addTodo(TodoItem todo) async {
//     await _todoCollection.add(todo.toJson());
//   }

//   static Stream<QuerySnapshot> getTodos() {
//     return _todoCollection.snapshots();
//   }

//   static Future<void> updateTodo(TodoItem todo) async {
//     await _todoCollection.doc(todo.id).update(todo.toJson());
//   }

//   static Future<void> deleteTodo(String todoId) async {
//     await _todoCollection.doc(todoId).delete();
//   }
// }
class UserService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final uid = FirebaseAuth.instance.currentUser!.uid;
  static final DocumentReference documentReference = _firestore.collection('Users').doc(uid);

  Future<DocumentSnapshot> getUserData() async {
    final docSnapshot = await documentReference.get();
    return  docSnapshot;
  }
}