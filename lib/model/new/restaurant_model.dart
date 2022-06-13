import 'package:cloud_firestore/cloud_firestore.dart';
import 'firestore_keys_lunchy.dart';

class RestaurantModel {
  final String rest_name; //name of restaurant
  final String rest_menu; //name of menu & below is each countings for menu
    final int rest_menu_east;
    final int rest_menu_west;
    final int rest_menu_north;
    final int rest_menu_total;
    final int rest_priority;
  final DateTime rest_orderday; //orderday of the foods
  final DocumentReference reference; //This   is location of the document of reference in firestore


  RestaurantModel.fromSnapshot(DocumentSnapshot snapshot) //Firestore 에서 snapshot 한개를 데리고 온다
      : this.fromMap( //가지고 온 snapshot 을 fromMap 에다가 쏘아준다
      snapshot.data(), //JSON MAP 형태의 데이터를 들고옴
      reference: snapshot.reference //Snapshot 의 레퍼런스를 들고옴
  );

  RestaurantModel.fromMap(Map<String, dynamic> map, {this.reference}) // 현재 fromMap 은 snapshot.data() 와 reference 를 들고 있고, constructing element 에다가 쏘아준다.
  : rest_name = map[KEY_RESTAURANT],
  rest_menu = map[KEY_REST_MENU],
  rest_menu_east = map[KEY_REST_EAST_COUNT],
  rest_menu_west = map[KEY_REST_WEST_COUNT],
  rest_menu_north = map[KEY_REST_NORTH_COUNT],
  rest_menu_total = map[KEY_REST_TOTAL],
  rest_priority = map[KEY_REST_PRIORITY],
  rest_orderday = (map[KEY_REST_ORDERDAY]as Timestamp).toDate();

}
