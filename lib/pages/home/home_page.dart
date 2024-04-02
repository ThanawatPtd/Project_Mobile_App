import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:project_mobile_app/services/home_service.dart';
import 'package:project_mobile_app/services/plan_service.dart';
import 'package:project_mobile_app/services/record_services.dart';
import 'package:project_mobile_app/widgets/home_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeService homeService = HomeService();
  RecordService recordService = RecordService();
  PlanService planService = PlanService();
  num amount = 0;
  var format = DateFormat("yyyy-MM-dd");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planService.setPlan();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: FutureBuilder(
              future: homeService.getUserAmount(),
              builder: (context1, snapshot1) {
                // print(homeService.getUserAmount().);
                recordService.setRecord();
                planService.setPlan();
                if (snapshot1.hasData) {
                  return StreamBuilder(
                      stream: recordService.getRecordStream(),
                      builder: (context2, snapshot2) {
                        if (snapshot2.hasData) {
                          var recordList = snapshot2.data?.docs ?? [];
                          var todayRecordList =
                              recordService.checkTime(recordList, "today");
                          var thisMonthRecordList =
                              recordService.checkTime(recordList, "this_month");
                          var thisYearRecordList =
                              recordService.checkTime(recordList, "this_year");
                          updateAmount(recordList);
                          return Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20.h,
                              ),
                              Center(
                                child: WalletCard(money: amount),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              StreamBuilder(
                                stream: planService.getPlans(),
                                builder: (context3, snapshot3) {
                                  if (snapshot3.hasData) {
                                    var planList = snapshot3.data?.docs ?? [];

                                    return Container(
                                        child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.h,
                                              right: 20.h,
                                              bottom: 10.h),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Plan",
                                              style: TextStyle(fontSize: 18.h),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                        CarouselSlider.builder(
                                          itemCount: planList.length,
                                          itemBuilder:
                                              (context, index, realIndex) {
                                            DocumentSnapshot doucument =
                                                planList[index];
                                            String docId = doucument.id;
                                            return ShowPlan(
                                              docId: docId,
                                              recordList: recordList,
                                            );
                                          },
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 10),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 1000),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            viewportFraction: 0.9,
                                            aspectRatio: 2.0,
                                            height: 210.h,
                                            initialPage: 0,
                                            enableInfiniteScroll: false,
                                            scrollDirection: Axis.vertical,
                                          ),
                                        )
                                      ],
                                    ));
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 20.h, right: 20.h),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Today",
                                    style: TextStyle(fontSize: 18.h),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.h),
                                child: ListCategory(
                                  income: recordService.sumTypeAmount(
                                      todayRecordList, "Income"),
                                  expense: recordService.sumTypeAmount(
                                      todayRecordList, "Expense"),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 20.h, right: 20.h),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Month",
                                    style: TextStyle(fontSize: 18.h),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.h),
                                child: ListCategory(
                                  income: recordService.sumTypeAmount(
                                      thisMonthRecordList, "Income"),
                                  expense: recordService.sumTypeAmount(
                                      thisMonthRecordList, "Expense"),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 20.h, right: 20.h),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Year",
                                    style: TextStyle(fontSize: 18.h),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.h),
                                child: ListCategory(
                                  income: recordService.sumTypeAmount(
                                      thisYearRecordList, "Income"),
                                  expense: recordService.sumTypeAmount(
                                      thisYearRecordList, "Expense"),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Align(
                              alignment: AlignmentDirectional.center,
                              child: CircularProgressIndicator());
                        }
                      });
                } else {
                  return Align(
                      alignment: AlignmentDirectional.center,
                      child: CircularProgressIndicator());
                }
              }),
        ),
      ],
    );
  }

  Future<void> updateAmount(List recordList) async {
    setState(() {
      amount = recordService.calculatorAmountUser(recordList);
      homeService.updateAmount(amount);
    });
  }
}
