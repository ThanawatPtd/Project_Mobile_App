import 'dart:html';

import 'package:flutter/foundation.dart';

class Record{
  String r_id;
  Category category_name;
  double r_cash;
  DateTime time_stamp;
  Location location;
  List<String> list_p_name; //list ชื่อผู้เกี่ยวข้อง
  Record({required this.r_id, required this.r_cash, required this.category_name, required this.time_stamp, required this.location, required this.list_p_name}); //r_id auto get เดี๋ยวนึก
}