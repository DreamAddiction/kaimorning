import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_kai_morning_210303/model/new/helper/transformers.dart';
import 'package:demo_kai_morning_210303/model/new/restaurant_model.dart';

import 'firestore_keys_lunchy.dart';

/* 미구현:
1. doc("20220201") 부분 variable today = Date.today 비슷한거 만들어서 .toString() 으로 해준뒤 넣어주기
혹은
2. doc 는 하나로 해두고, 그 안에 미르관 성실관 나래관 등등 다 추가
 */


class RestaurantNetworkRepository with Transformers {

  Stream<RestaurantModel> getRestaurantModelStream(String userKey) {
    //snapshots 는 새롭게 해당 snapshot 이 update 될때마다 새로운 data 를 보내줌 (Realtime database)
    return FirebaseFirestore.instance
        .collection(COLLECTION_HOME_LUNCHY)
        .doc(DOCUMENT_ADMIN_LUNCHY)
        .collection(COLLECTION_RIDERS_RESTAURANTS)
        .doc(DOCUMENT_RESTAURANTS)
        .collection("order_restaurant")
        .doc("jCpiIlmcfzCwdFvchcSp")
        .snapshots()
        .transform(toRestaurant);
  }
  Stream<List<RestaurantModel>> getRestaurantReady() {
    return FirebaseFirestore.instance
        .collection(COLLECTION_HOME_LUNCHY)
        .doc(DOCUMENT_ADMIN_LUNCHY)
        .collection(COLLECTION_RIDERS_RESTAURANTS)
        .doc(DOCUMENT_RESTAURANTS)
        .collection("order_restaurant")
        .snapshots()
        .transform(toReadyOrder);
  }

}

RestaurantNetworkRepository restaurantNetworkRepository =
    RestaurantNetworkRepository();
