import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  final firebaseStorage = FirebaseStorage.instance.bucket;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}