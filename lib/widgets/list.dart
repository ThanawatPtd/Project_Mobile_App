import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_mobile_app/widgets/colors.dart';

class RecordCard extends StatelessWidget {
  RecordCard({super.key, required this.name,required this.amount, required this.color});
  String name;
  Color color;
  num amount;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15), 
      ),
      child: Padding(padding: EdgeInsets.all(30), child: Container(child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Row(
            children: [Icon(Icons.monetization_on_rounded,color: color,),SizedBox(width: 50.w,), Text(name)],), 
          Row(children: [Text("THB ${amount.toStringAsFixed(2)}",style: TextStyle(color: color),),Icon(Icons.chevron_right,color: color,)],)],),
    ]))));
  }
}