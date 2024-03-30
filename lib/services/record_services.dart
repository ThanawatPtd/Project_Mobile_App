import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class RecordService {
  late String userId = FirebaseAuth.instance.currentUser!.uid;
  late final CollectionReference record;

  Stream<QuerySnapshot> getRecordStream() {
    final recordStream = record.snapshots();

    return recordStream;
  }
  void setRecord()async{
    record = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Record');
    print("record Innitialize");
  }

  List checkTime(List recordList, String type) {
    List newRecordList = [];
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    for (var record in recordList) {
      DocumentSnapshot doucument = record;
      Map<String, dynamic> data = doucument.data() as Map<String, dynamic>;

      DateTime recordTime = dateFormat.parse(data['Date']);

      if(recordTime.day == DateTime.now().day && recordTime.month == DateTime.now().month &&  recordTime.year == DateTime.now().year && type == "today"){
        newRecordList.add(record);
      }
      if(recordTime.month == DateTime.now().month && recordTime.year == DateTime.now().year && type == "this_month"){
        newRecordList.add(record);
      }
      if(recordTime.year == DateTime.now().year && type == "this_year"){
        newRecordList.add(record);
      }
    }
    return newRecordList;
  }
  num sumAmount(List recordList,String type){
    num total = 0.00;
    for(var record in recordList){
      DocumentSnapshot doucument = record;
      Map<String, dynamic> data = doucument.data() as Map<String, dynamic>;
      num amount = data['Amount'];
      String recordType = data['Type'];
      if(recordType == type){
        total += amount;
      }
    }
    return total;
  }


  Future<void> addRecord(String category, num amount, String datetime, String description,String type){
    return record.add({'Category' : category, 'Amount': amount, 'Date': datetime, 'Description': description, 'Type': type} );
  }
}
