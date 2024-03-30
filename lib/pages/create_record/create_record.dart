import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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

  RecordService recordService = RecordService();

  @override
  initState() {
    timeText = format.format(DateTime.now());
    recordService.setRecord();
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
            Align(
              alignment: Alignment.topRight,
              child: DropdownButton<String>(
                // dropdown income expense
                underline: Container(
                  height: 0,
                ),
                value: dropDownValue,
                items: const [
                  DropdownMenuItem(value: "Income", child: Text("Income")),
                  DropdownMenuItem(value: "Expense", child: Text("Expense"))
                ],
                onChanged: (String? value) {
                  setState(() {
                    dropDownValue = value!;
                  });
                },
              ),
            ),
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
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            foregroundColor:
                                const MaterialStatePropertyAll(Colors.grey)),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.boxesPacking),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Text("Category"),
                                          SizedBox(width: 155.w,),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: FaIcon(
                                                  FontAwesomeIcons.close))
                                        ],
                                      ),
                                      // GridView.count(crossAxisCount: crossAxisCount)
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Category"),
                            const Icon(Icons.arrow_downward)
                          ],
                        ),
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
                              firstDate: DateTime(2003),
                              lastDate: DateTime(2025));
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
            ElevatedButton(onPressed: () {
              recordService.addRecord("Food",double.parse(moneyController.text),timeText!, descriptionController.text, dropDownValue);
                  moneyController.clear();
                  descriptionController.clear();

                  Navigator.pop(context);
                },
                child: Text("Comfirm")),
          ],
        )));
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
