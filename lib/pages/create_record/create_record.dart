import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:project_mobile_app/pages/home/home.dart';
import 'package:project_mobile_app/pages/list/list.dart';
import 'package:project_mobile_app/services/category_service.dart';
import 'package:project_mobile_app/services/home_service.dart';
import 'package:project_mobile_app/services/record_services.dart';
import 'package:project_mobile_app/widgets/appbar.dart';
import 'package:project_mobile_app/widgets/colors.dart';
import 'package:project_mobile_app/widgets/home_widgets.dart';
import 'package:project_mobile_app/widgets/list.dart';

class CreateRecord extends StatefulWidget {
  CreateRecord({super.key, this.docId});
  String? docId ;
  @override
  State<CreateRecord> createState() => _CreateRecordState();
}

class _CreateRecordState extends State<CreateRecord> {

  TextEditingController moneyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController relatedController = TextEditingController();
  String? docId;
  String? timeText;
  DateTime? date;
  var format = DateFormat("yyyy-MM-dd");
  String dropDownValue = "Income";
  String dropDownCategory = "Food";

  RecordService recordService = RecordService();
  CategoryService categoryService = CategoryService();
  HomeService homeService = HomeService();

  @override
  initState() {
    timeText = format.format(DateTime.now());
    recordService.setRecord();
    categoryService.setCategory();
    super.initState();
    docId = widget.docId;
    fetchData();
  }

  @override
  build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: docId != null ? "Edit Record" : "Create Record",
          checkPop: true,
        ),
        backgroundColor: CustomColor.backgroundColor,
        body: Center(
            child: ListView(
          children: [
            Padding(
              //Category
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
            //description
            Padding(
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
                onPressed: ()async {
                  if (docId == null){
                  try{
                  await recordService.addRecord(
                      dropDownCategory,
                      timeText!,
                      descriptionController.text,
                      dropDownValue,
                      relatedController.text,
                      amount:double.parse(moneyController.text));

                  moneyController.clear();
                  descriptionController.clear();

                  Navigator.pop(context);
                  }
                  on FormatException catch (e) {
                     showDialog(
                      barrierColor: Colors.black.withOpacity(0.6),
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          icon: Icon(Icons.error),
                          iconColor: Colors.white,
                          contentTextStyle: TextStyle(color: Colors.white,),
                          titleTextStyle: TextStyle(color: Colors.white,),
                          title: Text("Invalid Money Format"),
                          content: Text("Please enter a valid amount in the format: X.XX (e.g., 123.45)"),
                          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK",style: TextStyle(color: Colors.white,),))],
                        );}
                      ,);}
                catch(e){
                  showDialog(
                      barrierColor: Colors.black.withOpacity(0.6),
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          icon: Icon(Icons.error),
                          iconColor: Colors.white,
                          contentTextStyle: TextStyle(color: Colors.white,),
                          titleTextStyle: TextStyle(color: Colors.white,),
                          title: Text("Error"),
                          content: Text("An unexpected error occurred: $e"),
                          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK",style: TextStyle(color: Colors.white,),))],
                        );
                        }
                      ,);
                }}
                else {
                  try{
                  await recordService.updateRecord(
                      docId!,
                      dropDownCategory,
                      timeText!,
                      descriptionController.text,
                      dropDownValue,
                      relatedController.text,
                      amount:double.parse(moneyController.text));

                  moneyController.clear();
                  descriptionController.clear();
                  relatedController.clear();

                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home(page: 1,)));
                  }
                  on FormatException catch (e) {
                     showDialog(
                      barrierColor: Colors.black.withOpacity(0.6),
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          icon: Icon(Icons.error),
                          iconColor: Colors.white,
                          contentTextStyle: TextStyle(color: Colors.white,),
                          titleTextStyle: TextStyle(color: Colors.white,),
                          title: Text("Invalid Money Format"),
                          content: Text("Please enter a valid amount in the format: X.XX (e.g., 123.45)"),
                          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK",style: TextStyle(color: Colors.white,),))],
                        );}
                      ,);}
                catch(e){
                  showDialog(
                      barrierColor: Colors.black.withOpacity(0.6),
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          icon: Icon(Icons.error),
                          iconColor: Colors.white,
                          contentTextStyle: TextStyle(color: Colors.white,),
                          titleTextStyle: TextStyle(color: Colors.white,),
                          title: Text("Error"),
                          content: Text("An unexpected error occurred: $e"),
                          actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("OK",style: TextStyle(color: Colors.white,),))],
                        );
                        }
                      ,);
                }
                }
                },
                child: Text("Comfirm")),
          ],
        )));
  }
  Future<void> fetchData() async { // Make the function async
  Future<List?> docRecord = recordService.getRecord(docId!);

  List? list = await docRecord; // Wait for the future to complete

  if (list != null) { // Check if data exists
    moneyController.text = list[0].toString();
    dropDownCategory = list[1].toString();
    timeText = format.format(list[2]); // Assuming format is a DateFormat instance
    descriptionController.text = list[3].toString();
    relatedController.text = list[4].toString();
    dropDownValue = list[5].toString();
  } else {
    // Handle no data case (e.g., show error message)
  }
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
