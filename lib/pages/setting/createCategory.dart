import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_mobile_app/pages/home/home.dart';
import 'package:project_mobile_app/pages/setting/setting.dart';
import 'package:project_mobile_app/services/category_service.dart';
import 'package:project_mobile_app/widgets/appbar.dart';
import 'package:project_mobile_app/widgets/colors.dart';
import 'package:project_mobile_app/widgets/home_widgets.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  CategoryService categoryService = CategoryService();
  int checkedIndex = 0;
  late List categoryList;
  final categoryNameController = TextEditingController();
  late String selectIcon;
  @override
  initState() {
    super.initState();
    categoryService.setCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      appBar: CustomAppBar(title: "Create Category", checkPop: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomContainer(
                  child: SizedBox(
                height: 400.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Select Icon"),
                        ),
                      ],
                    ),
                    StreamBuilder(
                      stream: categoryService.getCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          categoryList = snapshot.data!.docs ?? [];
                          DocumentSnapshot doc = categoryList[0];
                          Map<String, dynamic> dataTosetIconName = doc.data() as Map<String, dynamic>;
                          selectIcon = dataTosetIconName["IconName"];
                          selectIcon = categoryList[0]["IconName"];
                          return Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemCount: categoryList.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot documentSnapshot =
                                        categoryList[index];
                                    Map<String, dynamic> data = documentSnapshot
                                        .data() as Map<String, dynamic>;
                                    String categoryName = data["CategoryName"];
                                    String categoryIcon = data["IconName"];
                                    return GestureDetector(
                                      child: buildCard(
                                          index, categoryName, categoryIcon),
                                      onTap: () {
                                        selectIcon = categoryIcon;
                                      },
                                    );
                                  }));
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              )),
            ),
            SizedBox(
              height: 15.h,
            ),
            CustomContainer(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Category Name"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: customTextField(categoryNameController,
                      "Category Name", TextInputType.name, 50),
                ),
              ],
            )),
            GestureDetector(
              child: createCategoryButton("Create", CustomColor.primaryColor),
              onTap: () {
                categoryService.addCategory(
                    categoryNameController.text, selectIcon);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home(
                              page: 3,
                            )));
              },
            )
          ],
        ),
      ),
    );
  }

  Widget createCategoryButton(String text, Color color) {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      width: 325.w,
      height: 50.h,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(15.w)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, -1))
          ]),
      child: Center(
          child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,
        ),
      )),
    );
  }

  Widget buildCard(int index, String name, String categoryIcon) {
    bool checked = index == checkedIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          checkedIndex = index;
        });
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: 325.w,
              height: 75.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: checked ? CustomColor.primaryColor : Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/${categoryIcon}.svg",
                    width: 30.w,
                    height: 28.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      name,
                      style: TextStyle(
                          color: checked ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Offstage(
              offstage: !checked,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 2),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
}
