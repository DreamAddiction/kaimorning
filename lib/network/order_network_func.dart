import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_kai_morning_210303/model/new/firestore_keys_lunchy.dart';
import 'package:demo_kai_morning_210303/model/old/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constant/firestore_keys.dart';
import 'help/transformer.dart';


class OrderNetwork with Transformers {

  Future<void> createNewOrder({
    @required String orderKey,
    @required String store,
    @required String menu,
    @required String time,
    @required String dest,
    @required String ordererKey,
    @required DateTime orderDay,
    @required int priority,
  }) async {
    final DocumentReference orderRef = FirebaseFirestore.instance.collection(
        COLLECTION_HOME).doc(DOCUMENT_ADMIN).collection(COLLECTION_ORDERS).doc(
        orderKey);

    DocumentSnapshot snapshot = await orderRef.get();

    if (!snapshot.exists) {
      return await orderRef.set(OrderModel.getMapForCreateOrder(
          orderKey: orderKey,
          store: store,
          menu: menu,
          time: time,
          dest: dest,
          ordererKey: ordererKey,
          orderDay: orderDay,
          priority: priority
      ));
    }
  }


  Stream<OrderModel> getRoomModelStream(String orderKey) {
    return FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(
        DOCUMENT_ADMIN).collection(COLLECTION_ORDERS)
        .doc(orderKey)
        .snapshots()
        .transform(toOrder);
  }

  Stream<List<OrderModel>> getOrdersReady() {
    return FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(
        DOCUMENT_ADMIN).collection(COLLECTION_ORDERS)
        .snapshots()
        .transform(toReadyOrder).transform(toPriorityStore);
  }

  Stream<List<OrderModel>> getOrdersDoing() {
    return FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(
        DOCUMENT_ADMIN).collection(COLLECTION_ORDERS)
        .snapshots()
        .transform(toDoingOrder).transform(toPriorityDest);
  }

  Stream<List<OrderModel>> getOrdersDone() {
    return FirebaseFirestore.instance.collection(COLLECTION_HOME).doc(
        DOCUMENT_ADMIN).collection(COLLECTION_ORDERS)
        .snapshots()
        .transform(toDoneOrder);
  }

  Future<void> changeOrderProcess(
      {@required String dorm, @required DateTime date, @required String process}) async {
    var inputDate = date;
    var formatter_month = new DateFormat('M');
    var formatter_day = new DateFormat('d');
    var formatted_month = formatter_month.format(inputDate);
    String month = formatted_month;
    String day = formatter_day.format(inputDate);
    print(month + "-" + day + "-" + dorm);
    String documentName = month + "-" + day + "-" + dorm;

    final DocumentReference orderRef = FirebaseFirestore.instance
        .collection(COLLECTION_HOME_LUNCHY)
        .doc(DOCUMENT_ADMIN_LUNCHY)
        .collection("RidersAndRestaurants")
        .doc("dormitories")
        .collection("orders")
        .doc(documentName);

    final DocumentSnapshot orderSnapshot = await orderRef.get();

    if (orderSnapshot.exists) {
      switch (process) {
        case KEY_READY:
          await orderRef.update({KEY_PROCESS: KEY_READY});
          break;

        case KEY_DOING:
          await orderRef.update({KEY_PROCESS: KEY_DOING});
          break;

        case KEY_DONE:
          await orderRef.update({KEY_PROCESS: KEY_DONE});
          print("switched to done!");
          break;

        default:
          break;
      }
    }
  }
}

OrderNetwork orderNetwork = OrderNetwork();