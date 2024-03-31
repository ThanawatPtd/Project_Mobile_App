import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mobile_app/widgets/colors.dart';

class RecordCard extends StatelessWidget {
  RecordCard(
      {super.key,
      required this.name,
      required this.amount,
      required this.color,
      required this.date,
      required this.description,
      required this.relatedPeople});
  String name;
  Color color;
  num amount;
  DateTime date;
  String description;
  String relatedPeople;
  
  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: () {
        showDialog(
          barrierColor: Colors.black.withOpacity(0.6),
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: CustomColor.primaryColor,
              icon: IconTheme(data: IconThemeData(), child: Image.asset(name)),
              iconColor: Colors.white,
              contentTextStyle: TextStyle(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
              ),

              title: Text("Details"),
              content: Container(
                height: 300.h,
                child: Column(
                  children: [
                    SizedBox(height: 20,child: Divider(height: 1.h,),),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                      Row(children: [Icon(Icons.monetization_on,color: Colors.white,),SizedBox(width: 8.h,),Text("Amount",style: TextStyle(fontSize: 15.h),)],),Text("$amount",style: TextStyle(fontSize: 15.h,color: Colors.grey[350]))
                    ],),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [Padding(
                        padding: EdgeInsets.all(8.h),
                        child: Text("Category: $name"),
                      ),],),
                      
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))
              ],
            );
          },
        );
      },
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
              padding: EdgeInsets.all(30),
              child: Container(
                  child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.monetization_on_rounded,
                          color: color,
                        ),
                        SizedBox(
                          width: 50.w,
                        ),
                        Text(name)
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "THB ${amount.toStringAsFixed(2)}",
                          style: TextStyle(color: color),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: color,
                        ),
                      ],
                    )
                  ],
                ),
              ])))),
    );
  }
}
