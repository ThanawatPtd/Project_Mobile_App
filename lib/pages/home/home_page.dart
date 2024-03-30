import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mobile_app/services/home_service.dart';
import 'package:project_mobile_app/services/record_services.dart';
import 'package:project_mobile_app/widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeService homeService = HomeService();
  RecordService recordService = RecordService();
  
  
  @override
  Widget build(BuildContext context) {
    return ListView(children: [Container(
        child: FutureBuilder(future: homeService.getUserAmount(), 
        builder: (context1, snapshot1)  {
          // print(homeService.getUserAmount().);
          recordService.setRecord();
          if(snapshot1.hasData){
            return StreamBuilder(stream: recordService.getRecordStream(), builder: (context2, snapshot2) {
              if (snapshot2.hasData) {
                  var recordList = snapshot2.data?.docs ?? [];
                  var todayRecordList = recordService.checkTime(recordList, "today");
                  var thisMonthRecordList = recordService.checkTime(recordList, "this_month");
                  var thisYearRecordList = recordService.checkTime(recordList, "this_year");

                  return Column(
                    children: <Widget> [
                      SizedBox(height: 20.h,),
                      Center(child: WalletCard(money: snapshot1.data!),),
                      SizedBox(height: 20.h,),
                      Padding(padding: EdgeInsets.only(left: 20.h, right: 20.h), child: Align(alignment: Alignment.centerLeft,child: Text("Today",style: TextStyle(fontSize: 18.h),textAlign: TextAlign.left,),),),
                      Padding(padding: EdgeInsets.all(10.h), child: ListCategory(income: recordService.sumAmount(todayRecordList, "Income"),expense: recordService.sumAmount(todayRecordList, "Expense"),),),
                      Padding(padding: EdgeInsets.only(left: 20.h, right: 20.h), child: Align(alignment: Alignment.centerLeft,child: Text("Month",style: TextStyle(fontSize: 18.h),textAlign: TextAlign.left,),),),
                      Padding(padding: EdgeInsets.all(10.h), child: ListCategory(income: recordService.sumAmount(thisMonthRecordList, "Income"),expense: recordService.sumAmount(thisMonthRecordList, "Expense"),),),
                      Padding(padding: EdgeInsets.only(left: 20.h, right: 20.h), child: Align(alignment: Alignment.centerLeft,child: Text("Year",style: TextStyle(fontSize: 18.h),textAlign: TextAlign.left,),),),
                      Padding(padding: EdgeInsets.all(10.h), child: ListCategory(income: recordService.sumAmount(thisYearRecordList, "Income"),expense: recordService.sumAmount(thisYearRecordList, "Expense"),),),
                    ],
                    );
              }
              else{
                return const CircularProgressIndicator();
              }
            });
          }
          else {
            return const CircularProgressIndicator();
          }
        },),
      ),],);
  }
}