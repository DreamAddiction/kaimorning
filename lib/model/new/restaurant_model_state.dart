import 'package:demo_kai_morning_210303/model/new/restaurant_model.dart';
import 'package:flutter/foundation.dart';

class RestaurantModelState extends ChangeNotifier{
  RestaurantModel _restaurantModel;

  RestaurantModel get restaurantModel => _restaurantModel;

  set restaurantModel(RestaurantModel restaurantModel){
    _restaurantModel = restaurantModel;
    notifyListeners();
  }
}