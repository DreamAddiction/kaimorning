import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_kai_morning_210303/model/new/driver/driver_model.dart';
import 'package:demo_kai_morning_210303/model/new/helper/transformers.dart';
import 'package:demo_kai_morning_210303/model/new/restaurant_model.dart';
import 'package:intl/intl.dart';
import '../firestore_keys_lunchy.dart';

/* 미구현:
1. doc("20220201") 부분 variable today = Date.today 비슷한거 만들어서 .toString() 으로 해준뒤 넣어주기
혹은
2. doc 는 하나로 해두고, 그 안에 미르관 성실관 나래관 등등 다 추가
 */



final reference_doneorder = FirebaseFirestore.instance
    .collection(COLLECTION_HOME_LUNCHY)
    .doc(DOCUMENT_ADMIN_LUNCHY)
    .collection(COLLECTION_RIDERS_RESTAURANTS)
    .doc(DOCUMENT_DORMITORIES)
    .collection(COLLECTION_TODAYORDER);

class DriverNetworkRepository with Transformers {
  Future<void> sendData(String dorm) {
    // ! 인수로 widget.store.dorm(?) 으로 기숙사 정보를 가지고 온다음 마지막 .doc(기숙사).set 같은 느낌으로 바꾸기
    return reference_doneorder.doc(dorm).set({dorm: true, 'today': "20220201"});
  }

  void getData() {
    reference_doneorder
        .doc("20220201")
        .get()
        .then((docSnapshot) => print(docSnapshot.data()));
  }

  Stream<List<DriverModel>> getDriverReady(DateTime _selDay) {
    String selDay = _selDay.toString();
    return FirebaseFirestore.instance
        .collection(COLLECTION_HOME_LUNCHY)
        .doc(DOCUMENT_ADMIN_LUNCHY)
        .collection(COLLECTION_RIDERS_RESTAURANTS)
        .doc(DOCUMENT_DORMITORIES)
        .collection("orders")
        .snapshots()
        .transform(toReadyDriver);
  }

}

DriverNetworkRepository driverNetworkRepository =
    DriverNetworkRepository();
