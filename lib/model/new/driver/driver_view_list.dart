import 'package:demo_kai_morning_210303/model/new/driver/driver_Item.dart';
import 'package:demo_kai_morning_210303/model/new/driver/driver_network_repository.dart';
import 'package:demo_kai_morning_210303/model/new/restaurantItem.dart';
import 'package:demo_kai_morning_210303/model/new/restaurant_model.dart';
import 'package:demo_kai_morning_210303/model/new/restaurant_network_repository.dart';
import 'package:demo_kai_morning_210303/model/old/order_model.dart';
import 'package:demo_kai_morning_210303/network/order_network_func.dart';
import 'package:demo_kai_morning_210303/useful/search_engine.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:demo_kai_morning_210303/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'driver_model.dart';

class DriverViewList extends StatefulWidget {
  final DateTime selDay;
  final String selTime;

  DriverViewList({this.selDay, this.selTime});

  @override
  _DriverViewListState createState() => _DriverViewListState();
}

class _DriverViewListState extends State<DriverViewList> {


  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<DriverModel>>.value(
      value: driverNetworkRepository.getDriverReady(widget.selDay),
      child: Consumer<List<DriverModel>>(
        builder: (context, driverOrders, _){
          driverOrders.sort((a,b) => a.dorm_priority != null && b.dorm_priority != null ? a.dorm_priority.compareTo(b.dorm_priority) : 0);
          if(driverOrders == null){
            return MyProgressIndicator();
          }
          else if (driverOrders.isEmpty){
            return Container();
          }
          else{
            return ListView.builder(
              itemCount: driverOrders.length,
              itemBuilder: (context, index){
                if(SearchEngine.isSameDay(driverOrders[index].dorm_orderday, widget.selDay) && driverOrders[index].dorm_menu.isNotEmpty && widget.selTime == '종일'){
                  return DriverItem(
                    driverModel: driverOrders[index],
                  );
                }
                else{
                  return Container();
                }
              },
            );
          }
        },
      ),
    );
  }
}
