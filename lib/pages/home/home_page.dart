import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mobile_app/widgets/home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: ListView(children: [Container(
        child: Column(
          children: <Widget> [
            SizedBox(height: 20.h,),
            Center(child: WalletCard(money: 123.3240),),
            SizedBox(height: 20.h,),
            Padding(padding: EdgeInsets.only(left: 20.h, right: 20.h), child: Align(alignment: Alignment.centerLeft,child: Text("Today",style: TextStyle(fontSize: 18.h),textAlign: TextAlign.left,),),),
            Padding(padding: EdgeInsets.all(10.h), child: ListCategory(income: 100,expense: 200,),),
            Padding(padding: EdgeInsets.only(left: 20.h, right: 20.h), child: Align(alignment: Alignment.centerLeft,child: Text("Week",style: TextStyle(fontSize: 18.h),textAlign: TextAlign.left,),),),
            Padding(padding: EdgeInsets.all(10.h), child: ListCategory(income: 150,expense: 200,),),
            Padding(padding: EdgeInsets.only(left: 20.h, right: 20.h), child: Align(alignment: Alignment.centerLeft,child: Text("Month",style: TextStyle(fontSize: 18.h),textAlign: TextAlign.left,),),),
            Padding(padding: EdgeInsets.all(10.h), child: ListCategory(income: 100,expense: 200,),),
          ],
        ),
      ),],)
    );
  }
}