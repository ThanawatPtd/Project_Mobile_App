import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  XFile? _imageFile;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  late final Reference storageRef;
  late final assets;
  late final imageUrl;

  @override
  initState() {
    super.initState();
    loginTest();
    storageRef = firebaseStorage.ref().child("Images/1.jpg");
  }

  Future<void> loginTest()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: "Thanawatptd@hotmail.com", password: "123456");
  }

  Future<void> uploadImageFromAssets() async {
    assets = await rootBundle.load("assets/images/unnamed.jpg");
    final byteData = assets.buffer.asUint8List();
    await storageRef.putData(byteData);
  }

  Future<void> uploadImageFromDevice(String filePath) async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
    final file = File(filePath);
    await storageRef.putFile(file);
  }

  Future<void> pickImage(ImageSource source) async {
    if (await Permission.camera.request().isGranted) {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: source);
      setState(() {
        _imageFile = pickedFile;
      });
      final filePath = _imageFile!.path;
      final file = File(filePath);
      await storageRef.putData(await file.readAsBytes());
      print("Upload to Storage success");
      imageUrl = await storageRef.getDownloadURL();
      print(storageRef.toString());
      print(imageUrl.toString());
    } else {
      // Handle permission denied case
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Camera & Gallery'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageFile != null
                  ? Image.file(File(_imageFile!.path))
                  : Container(),
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.camera),
                child: Text('Open Camera'),
              ),
              ElevatedButton(
                onPressed: () => pickImage(ImageSource.gallery),
                child: Text('Open Gallery'),
              ),
              ElevatedButton(
                  onPressed: () {
                    uploadImageFromAssets();
                  },
                  child: Text("Push Data to Internet")),
            ],
          ),
        ),
      ),
    );
  }
}
