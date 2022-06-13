import 'package:demo_kai_morning_210303/constant/size.dart';
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

class RestaurantViewList extends StatefulWidget {
  final DateTime selDay;
  final String selTime;

  RestaurantViewList({this.selDay, this.selTime});

  @override
  _RestaurantViewListState createState() => _RestaurantViewListState();
}

class _RestaurantViewListState extends State<RestaurantViewList> {
  var restaurant_now = "DDDN";

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RestaurantModel>>.value(
      value: restaurantNetworkRepository.getRestaurantReady(),
      child: Consumer<List<RestaurantModel>>(
        builder: (context, restaurantOrders, _) {
          if (restaurantOrders == null) {
            return MyProgressIndicator();
          } else if (restaurantOrders.isEmpty) {
            return Container();
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            restaurant_now = "풀빛마루";
                          });
                        },
                        child: Container(
                          height: size.height*0.05,
                          width: size.width * 0.2,
                          child: Center(child: Text("풀빛마루")),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                        )),

                    InkWell(
                        onTap: () {
                          setState(() {
                            restaurant_now = "휴 김밥";
                          });
                        },
                        child: Container(
                          height: size.height*0.05,
                          width: size.width * 0.2,
                          child: Center(child: Text("휴 김밥")),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                        )),

                    InkWell(
                        onTap: () {
                          setState(() {
                            restaurant_now = "DDDN";
                          });
                        },
                        child: Container(
                          height: size.height*0.05,
                          width: size.width * 0.2,
                          child: Center(child: Text("DDDN")),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                        )),

                    InkWell(
                        onTap: () {
                          setState(() {
                            restaurant_now = "더 큰 도시락";
                          });
                        },
                        child: Container(
                          height: size.height*0.05,
                          width: size.width * 0.2,
                          child: Center(child: Text("더큰도시락")),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                        )),

                    InkWell(
                        onTap: () {
                          setState(() {
                            restaurant_now = "오샐러드";
                          });
                        },
                        child: Container(
                          height: size.height*0.05,
                          width: size.width * 0.2,
                          child: Center(child: Text("오샐러드")),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)
                          ),
                        )),
                  ],
                ),
                Container(
                  height: size.height * 0.01,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: restaurantOrders.length,
                    itemBuilder: (context, index) {
                      restaurantOrders.sort((a, b) =>
                          a.rest_priority != null && b.rest_priority != null
                              ? a.rest_priority.compareTo(b.rest_priority)
                              : 0);
                      if (SearchEngine.isSameDay(
                              restaurantOrders[index].rest_orderday,
                              widget.selDay) &&
                          widget.selTime == '종일' &&
                          restaurant_now == restaurantOrders[index].rest_name) {
                        return RestaurantItem(
                          restaurantModel: restaurantOrders[index],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
