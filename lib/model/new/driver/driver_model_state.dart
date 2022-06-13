import 'package:flutter/foundation.dart';
import 'driver_model.dart';

class DriverModelState extends ChangeNotifier{
  DriverModel _driverModel;

  DriverModel get driverModel => _driverModel;

  set driverModel(DriverModel driverModel){
    _driverModel = driverModel;
    notifyListeners();
  }
}