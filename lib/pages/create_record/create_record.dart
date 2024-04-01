import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_mobile_app/services/category_service.dart';
import 'package:project_mobile_app/services/record_services.dart';
import 'package:project_mobile_app/widgets/appbar.dart';
import 'package:project_mobile_app/widgets/colors.dart';
import 'package:project_mobile_app/widgets/home_widgets.dart';

class CreateRecord extends StatefulWidget {
  const CreateRecord({super.key});

  @override
  State<CreateRecord> createState() => _CreateRecordState();
}

class _CreateRecordState extends State<CreateRecord> {
  TextEditingController moneyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController relatedController = TextEditingController();
  String? timeText;
  DateTime? date;

  var format = DateFormat("yyyy-MM-dd");
  String dropDownValue = "Income";
  String dropDownCategory = "Food";

  XFile? _imageFile;
  late Widget imageContainer;
  late final Reference imageReference;
  late String imageUrl;

  RecordService recordService = RecordService();
  CategoryService categoryService = CategoryService();
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  initState() {
    timeText = format.format(DateTime.now());
    recordService.setRecord();
    categoryService.setCategory();
    imageContainer = imageContainerFuction();
    imageReference = firebaseStorage.ref().child("${uid}/${DateTime.now().millisecondsSinceEpoch}.png");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Create Record",
          checkPop: true,
        ),
        backgroundColor: CustomColor.backgroundColor,
        body: Center(
            child: ListView(
          children: [
            Padding(
              // categoryDropdown
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: CustomContainer(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Category",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
                      child: StreamBuilder(
                        stream: categoryService.getCategories(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircularProgressIndicator();
                          } else {
                            var categoryList = snapshot.data?.docs ?? [];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                DropdownButton<String>(
                                  //category button
                                  menuMaxHeight: 100,
                                  // dropdown category
                                  underline: Container(
                                    height: 0,
                                  ),
                                  value: dropDownCategory,
                                  items: categoryList.map((index) {
                                    return DropdownMenuItem<String>(
                                        child: Text(index["CategoryName"]),
                                        value: index["CategoryName"]);
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropDownCategory = value!;
                                    });
                                  },
                                ),
                                DropdownButton<String>(
                                  // dropdown income expense
                                  underline: Container(
                                    height: 0,
                                  ),
                                  value: dropDownValue,
                                  items: const [
                                    DropdownMenuItem(
                                        value: "Income", child: Text("Income")),
                                    DropdownMenuItem(
                                        value: "Expense",
                                        child: Text("Expense"))
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropDownValue = value!;
                                    });
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )),
            ),
            Padding(
              // money textField
              padding: const EdgeInsets.all(8.0),
              child: CustomContainer(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Amount",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
                      child: customTextField(
                          moneyController, "Amount", TextInputType.number, 50),
                    ),
                  ],
                ),
              )),
            ),
            Padding(
              //date picker
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: CustomContainer(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Date",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                CustomColor.primaryColor),
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.white)),
                        onPressed: () async {
                          date = await showDatePicker(
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: Color.fromARGB(255, 77, 145,
                                          90), // header background color
                                      onPrimary:
                                          Colors.white, // header text color
                                      onSurface: Colors.black,
                                      // body text color
                                    ),
                                    textButtonTheme: TextButtonThemeData(
                                      style: TextButton.styleFrom(
                                        foregroundColor:
                                            Colors.black, // button text color
                                      ),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now());
                          setState(() {
                            timeText = format.format(date!);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(timeText!),
                            const Icon(Icons.calendar_view_month_outlined)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
            Padding(
              //description
              padding: const EdgeInsets.all(8.0),
              child: CustomContainer(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Description",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
                      child: customTextField(descriptionController, "",
                          TextInputType.multiline, 70),
                    ),
                  ],
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomContainer(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      "Photo",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: imageContainer)
                ],
              )),
            ),
            Padding(
              // Related TextField
              padding: const EdgeInsets.all(8.0),
              child: CustomContainer(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Related People",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0, left: 2.0),
                      child: customTextField(
                          relatedController, "", TextInputType.multiline, 70),
                    ),
                  ],
                ),
              )),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_imageFile != null) {
                    final file = File(_imageFile!.path);
                    await imageReference.putFile(file);
                    final url = await imageReference.getDownloadURL();
                    imageUrl = url;
                  }
                  recordService.addRecord(
                      dropDownCategory,
                      timeText!,
                      descriptionController.text,
                      dropDownValue,
                      relatedController.text,
                      amount: double.parse(moneyController.text),
                      imageUrl: imageUrl);
                  moneyController.clear();
                  descriptionController.clear();

                  Navigator.pop(context);
                },
                child: Text("Comfirm")),
          ],
        )));
  }

  Widget onPressedCamera() {
    pickImage(ImageSource.camera);
    if (_imageFile != null) {
      final file = File(_imageFile!.path);
      return Image.file(
        file,
        width: double.maxFinite.w,
        height: 200.h,
      );
    }
    return Container();
  }

  Future<Widget> onPressedGallery() async {
    await pickImage(ImageSource.gallery);
    if (_imageFile != null) {
      final file = File(_imageFile!.path);
      return Image.file(
        file,
        width: double.maxFinite.w,
        height: 200.h,
      );
    }
    return Container();
  }

  Future<void> pickImage(ImageSource source) async {
    if (await Permission.camera.request().isGranted) {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: source);
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Widget customTextField(TextEditingController controller, String text,
      TextInputType inputType, int height) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1, color: Colors.grey)),
      width: 325.w,
      height: height.h,
      child: TextField(
        controller: controller,
        maxLines: 2,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  Widget imageContainerFuction() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green[100], borderRadius: BorderRadius.circular(12)),
      width: double.maxFinite.w,
      height: 200.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          imageButton(() async {
            Widget widget = await onPressedCamera();
            print(widget.toString());
            if (widget.toString() != Container().toString()) {
              imageContainer = widget;
            }
          }, Icon(Icons.camera_alt), "Camera", Colors.green[200]!),
          imageButton(() async {
            Widget widget = await onPressedGallery();
            print(widget.toString());
            if (widget.toString() != Container().toString()) {
              imageContainer = widget;
            }
          }, Icon(Icons.photo), "Gallery", Colors.green[300]!)
        ],
      ),
    );
  }

  Widget imageButton(
      Function() function, Icon icon, String buttonName, Color color) {
    return GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            width: 100.w,
            height: 35.h,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [icon, Text(buttonName)],
            ),
          ),
        ),
        onTap: function);
  }
}
