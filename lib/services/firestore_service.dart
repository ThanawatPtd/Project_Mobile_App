import 'package:cloud_firestore/cloud_firestore.dart';

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
