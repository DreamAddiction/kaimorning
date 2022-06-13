import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_kai_morning_210303/constant/firestore_keys.dart';
import 'package:demo_kai_morning_210303/model/new/firestore_keys_lunchy.dart';

class DriverModel {
  final String nswe; //name of restaurant
  final String dorm; //name of menu & below is each countings for menu
  final Map dorm_menu;
  final Map dorm_phone;
  final DateTime dorm_orderday; //orderday of the foods
  final int dorm_priority;
  final String process;
  final DocumentReference reference; //This   is location of the document of reference in firestore
  final String dorm_restaurant;

  DriverModel.fromSnapshot(DocumentSnapshot snapshot) //Firestore 에서 snapshot 한개를 데리고 온다
      : this.fromMap( //가지고 온 snapshot 을 fromMap 에다가 쏘아준다
      snapshot.data(), //JSON MAP 형태의 데이터를 들고옴
      reference: snapshot.reference //Snapshot 의 레퍼런스를 들고옴
  );

  DriverModel.fromMap(Map<String, dynamic> map, {this.reference}) // 현재 fromMap 은 snapshot.data() 와 reference 를 들고 있고, constructing element 에다가 쏘아준다.
  : nswe = map[KEY_NSWE],
    dorm = map[KEY_DORMITORY],
    dorm_menu = map[KEY_DORM_MENU],
    dorm_restaurant = map[KEY_DORM_REST],
    dorm_orderday = (map[KEY_DORM_ORDERDAY]as Timestamp).toDate(),
    dorm_phone = map[KEY_DORM_PHONE_NUMBER],
    dorm_priority = map[KEY_DORM_PRIORITY],
    process = map[KEY_DORM_PROCESS];
}
