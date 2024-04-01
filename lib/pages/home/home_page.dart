import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mobile_app/services/home_service.dart';
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
  num amount = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [Container(
        child: FutureBuilder(future: homeService.getUserAmount(), 
        builder: (context1, snapshot1)  {
          // print(homeService.getUserAmount().);
          recordService.setRecord();
          if(snapshot1.hasData){
            return StreamBuilder(stream: recordService.getRecordStream(), builder: (context2, snapshot2) {
              if (snapshot2.hasData){
                  var recordList = snapshot2.data?.docs ?? [];
                  var todayRecordList = recordService.checkTime(recordList, "today");
                  var thisMonthRecordList = recordService.checkTime(recordList, "this_month");
                  var thisYearRecordList = recordService.checkTime(recordList, "this_year");
                  updateAmount(recordList);
                  return Column(
                    children: <Widget> [
                      SizedBox(height: 20.h,),
                      Center(child: WalletCard(money: amount),),
                      SizedBox(height: 20.h,),
                      Padding(padding: EdgeInsets.only(left: 20.h, right: 20.h), child: Align(alignment: Alignment.centerLeft,child: Text("Today",style: TextStyle(fontSize: 18.h),textAlign: TextAlign.left,),),),
                      Padding(padding: EdgeInsets.all(10.h), child: ListCategory(income: recordService.sumTypeAmount(todayRecordList ,"Income"),expense: recordService.sumTypeAmount(todayRecordList, "Expense"),),),
                      Padding(padding: EdgeInsets.only(left: 20.h, right: 20.h), child: Align(alignment: Alignment.centerLeft,child: Text("Month",style: TextStyle(fontSize: 18.h),textAlign: TextAlign.left,),),),
                      Padding(padding: EdgeInsets.all(10.h), child: ListCategory(income: recordService.sumTypeAmount(thisMonthRecordList, "Income"),expense: recordService.sumTypeAmount(thisMonthRecordList,"Expense"),),),
                      Padding(padding: EdgeInsets.only(left: 20.h, right: 20.h), child: Align(alignment: Alignment.centerLeft,child: Text("Year",style: TextStyle(fontSize: 18.h),textAlign: TextAlign.left,),),),
                      Padding(padding: EdgeInsets.all(10.h), child: ListCategory(income: recordService.sumTypeAmount(thisYearRecordList, "Income"),expense: recordService.sumTypeAmount(thisYearRecordList,"Expense"),),),
                    ],
                    );
              }
              else{
                return Align(
                  alignment: AlignmentDirectional.center,
                  child: CircularProgressIndicator());
              }
            });
          }
          else {
            return Align(
              alignment: AlignmentDirectional.center,
              child: CircularProgressIndicator());
          }
        },),
      ),],);
  }

  Future<void> updateAmount(List recordList) async {
    setState(()  {
      amount = recordService.calculatorAmountUser(recordList);
       homeService.updateAmount(amount);
    });
  }

}