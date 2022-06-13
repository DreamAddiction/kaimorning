import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_kai_morning_210303/model/new/driver/driver_model.dart';
import 'package:demo_kai_morning_210303/model/new/restaurant_model.dart';

class Transformers{
  final toRestaurant = StreamTransformer<DocumentSnapshot, RestaurantModel>.fromHandlers(
    handleData: (snapshot, sink) async{
      sink.add(RestaurantModel.fromSnapshot(snapshot));
    }
  );

  final toReadyOrder = StreamTransformer<QuerySnapshot, List<RestaurantModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<RestaurantModel> orders = [];

    snapshot.docs.forEach((documentSnapshot) {
      orders.add(RestaurantModel.fromSnapshot(documentSnapshot));
    });

    sink.add(orders);
  });

  final toReadyDriver = StreamTransformer<QuerySnapshot, List<DriverModel>>.fromHandlers(handleData: (snapshot, sink) async {
    List<DriverModel> dorms = [];

    snapshot.docs.forEach((documentSnapshot) {
      dorms.add(DriverModel.fromSnapshot(documentSnapshot));
    });

    sink.add(dorms);
  });


}