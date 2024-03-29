import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletCard extends StatelessWidget {
  WalletCard({super.key, required this.money});

  double money = 0.00;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185.h,
      width: 300.h,
      decoration: BoxDecoration(color: Color.fromARGB(255, 77, 145, 90),borderRadius: BorderRadius.circular(15), boxShadow: [
        BoxShadow(color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),)]),
      child: Stack(
        children: [
          Padding(padding: EdgeInsets.only(left: 40.h, top: 20.h), child: Text("Account", style: TextStyle(fontSize: 12.h,color: Colors.grey[300]),),),
          Padding(padding: EdgeInsets.only(left: 28.h, top: 35.h), child: Text("MY ACCOUNT",style: TextStyle(color: Colors.white),),),
          Padding(padding: EdgeInsets.only(left: 250.h, top: 15.h), child: IconButton(icon: Icon(Icons.settings,color: Colors.white,),onPressed: () {},),),
          Padding(padding: EdgeInsets.only(top: 40.h),child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Container(
            height: 130.h,
            width: 130.w,
            decoration: BoxDecoration(color: Color.fromARGB(255, 45, 79, 52),shape: BoxShape.circle,border: Border.all(color: Colors.white,width: 2.h)),
            child: Stack(children: [Padding(padding: EdgeInsets.only(left: 40.h, top: 30.h),child: Text("Money",style: TextStyle(color: Colors.grey[300]),),),
            Align(alignment: Alignment.center, child: Text("${money.toStringAsFixed(2)}", style: TextStyle(color: Colors.white,fontSize: 15.h,fontWeight: FontWeight.bold),),)],),),],),)
        ],
      ),
    );
  }
}

class ListCategory extends StatelessWidget {
  ListCategory({super.key, required this.income, required this.expense});

  double income = 0.00;
  double expense = 0.00;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15), 
      // boxShadow: [
      //   BoxShadow(color: Colors.grey.withOpacity(0.5),
      //     spreadRadius: 5,
      //     blurRadius: 7,
      //     offset: Offset(0, 3),)]
      ),
      child: Padding(padding: EdgeInsets.all(30), child: Container(child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Icon(Icons.monetization_on_rounded,color: Color.fromARGB(255, 77, 145, 90),), Text("Income"),Row(children: [Text("THB ${income}",style: TextStyle(color: Color.fromARGB(255, 77, 145, 90)),),Icon(Icons.chevron_right,color: Color.fromARGB(255, 77, 145, 90),)],)],),
        SizedBox(height: 40.h, child: Divider(height: 1.h,),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Icon(Icons.monetization_on_rounded,color: Color.fromARGB(255, 255, 25, 25),), Text("Expense"),Row(children: [Text("THB ${expense}",style: TextStyle(color: Color.fromARGB(255, 255, 25 ,25)),),Icon(Icons.chevron_right,color: Color.fromARGB(255, 255, 25, 25),)],)],),
      ],),),)
    );
  }
}