import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecordService {
  late String userId = FirebaseAuth.instance.currentUser!.uid;
  late final CollectionReference record;

  Stream<QuerySnapshot> getRecordStream() {
    record = FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .collection('Record');
    final recordStream = record.snapshots();

    return recordStream;
  }

  List checkToday(List recordList) {
    List newRecordList = [];
    // DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    // for (var record in recordList) {
    //   DocumentSnapshot doucument = record;
    //   Map<String, dynamic> data = doucument.data() as Map<String, dynamic>;

    //   DateTime recordTime = dateFormat.parse(data['Date']);

    //   if(recordTime.day == DateTime.now().day){
    //     newRecordList.add(record);
    //   }
    // }
    return newRecordList;
  }
}
