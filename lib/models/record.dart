import 'dart:html';

import 'package:flutter/foundation.dart';

class Record{
  String category;
  double amount;
  DateTime date;
  List<String> relatedPeoples; //list ชื่อผู้เกี่ยวข้อง
  String type;
  String description;
  Record({required this.category, required this.amount, required this.date, required this.relatedPeoples, required this.type, required this.description});
}

class ListRecord {
  List<Record> listRecord = [];

  void addListRecord (String category, double amount, DateTime date, List){

  }
}


