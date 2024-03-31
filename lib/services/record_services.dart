import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:project_mobile_app/models/category.dart';

class RecordService {
  late String userId = FirebaseAuth.instance.currentUser!.uid;
  late CollectionReference record;

  Stream<QuerySnapshot> getRecordStream() {
    final recordStream = record.snapshots();

    return recordStream;
  }

  void setRecord() {
    record = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Record');
  }

  List checkTime(List recordList, String type) {
    List newRecordList = [];
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    for (var record in recordList) {
      DocumentSnapshot doucument = record;
      Map<String, dynamic> data = doucument.data() as Map<String, dynamic>;

      DateTime recordTime = dateFormat.parse(data['Date']);

      if (recordTime.day == DateTime.now().day &&
          recordTime.month == DateTime.now().month &&
          recordTime.year == DateTime.now().year &&
          type == "today") {
        newRecordList.add(record);
      }
      if (recordTime.month == DateTime.now().month &&
          recordTime.year == DateTime.now().year &&
          type == "this_month") {
        newRecordList.add(record);
      }
      if (recordTime.year == DateTime.now().year && type == "this_year") {
        newRecordList.add(record);
      }
    }
    return newRecordList;
  }

  num sumTypeAmount(List recordList, String type) {
    num total = 0.00;
    for (var record in recordList) {
      DocumentSnapshot doucument = record;
      Map<String, dynamic> data = doucument.data() as Map<String, dynamic>;
      num amount = data['Amount'];
      String recordType = data["Type"];
      if (recordType == type || type == "Total") {
        total += amount;
      }
    }
    return total;
  }

  num sumCategoryAmount(List recordList, String category) {
    num total = 0.00;
    for (var record in recordList) {
      DocumentSnapshot doucument = record;
      Map<String, dynamic> data = doucument.data() as Map<String, dynamic>;
      num amount = data['Amount'];
      String recordCategory = data["Category"];
      if (recordCategory == category) {
        total += amount;
      }
    }
    return total;
  }



  List filttertype(List recordList, String field, String type){
    List newRecordList = [];
    bool check = true;
     for (var record in recordList) {
      DocumentSnapshot doucument = record;
      Map<String, dynamic> data = doucument.data() as Map<String, dynamic>;
      String recordField = data[field];
      String recordType = data['Type'];
      check = true;
      if (recordType == type || type == "Total"){
        for (var types in newRecordList){
          if(types == recordField) {
            check = false;
          }
        }
        if (check){
          newRecordList.add(recordField);
        }
      }
    }
    
    return newRecordList;
  }

  List filtterRecordType(List recordList, String type){
    List newRecordList = [];
     for (var record in recordList) {
      DocumentSnapshot doucument = record;
      Map<String, dynamic> data = doucument.data() as Map<String, dynamic>;
      String recordType = data["Type"];
      if (recordType == type || type == "Total"){
          newRecordList.add(record);
      }
    }
    
    return newRecordList;
  }

  List filtterRecordCategory(List recordList, String category){
    List newRecordList = [];
     for (var record in recordList) {
      DocumentSnapshot doucument = record;
      Map<String, dynamic> data = doucument.data() as Map<String, dynamic>;
      String recordCategory = data["Category"];
      if (recordCategory == category){
          newRecordList.add(record);
      }
    }
    
    return newRecordList;
  }

  double percentType(List recordList,String field,String type, String kind){
    List filtterRecordList = field == "Category" ? filtterRecordCategory(recordList, type) : filtterRecordType(recordList, type);
    num totalTypeAmount = sumTypeAmount(filtterRecordList, kind);
    print("total Type Amount => $totalTypeAmount");
    print("kind => $kind");
    num totalAmount = sumTypeAmount(recordList, kind);
    print("total Amount => $totalAmount");
    double percent = totalTypeAmount / totalAmount;
    print("percent => $percent");
    
    return percent * 100;
  }

  Future<void> addRecord1(
      String category, String datetime, String description, String type) {
    return record.add({
      'Category': category,
      'Date': datetime,
      'Description': description,
      'Type': type
    });
  }

  Future<void> addRecord(String category, num amount, String datetime,
      String description, String type) {
    return record.add({
      'Category': category,
      'Amount': amount,
      'Date': datetime,
      'Description': description,
      'Type': type
    });
  }
}
