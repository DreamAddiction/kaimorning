import 'package:demo_kai_morning_210303/constant/firestore_keys.dart';
import 'package:demo_kai_morning_210303/constant/size.dart';
import 'package:demo_kai_morning_210303/model/new/restaurant_model.dart';
import 'package:demo_kai_morning_210303/model/new/restaurant_network_repository.dart';
import 'package:demo_kai_morning_210303/model/old/order_model.dart';
import 'package:demo_kai_morning_210303/model/old/rider_model.dart';
import 'package:demo_kai_morning_210303/model/old/rider_model_state.dart';
import 'package:demo_kai_morning_210303/model/old/user_model.dart';
import 'package:demo_kai_morning_210303/network/order_network_func.dart';
import 'package:demo_kai_morning_210303/network/user_network_func.dart';
import 'package:demo_kai_morning_210303/screen/sub/send_photo.dart';
import 'package:demo_kai_morning_210303/widgets/my_progress_indicator.dart';
import 'package:demo_kai_morning_210303/widgets/rounded_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RestaurantItem extends StatefulWidget {
  final RestaurantModel restaurantModel;


  RestaurantItem({this.restaurantModel});

  @override
  _RestaurantItemState createState() => _RestaurantItemState();
}

class _RestaurantItemState extends State<RestaurantItem> {

  bool _isOpened = false;
  var ridersList = ["West", "East", "North"];

  @override
  Widget build(BuildContext context) {

    RiderModel now_login_user = Provider.of<UserModelState>(context, listen: false).userModel;
    //(now_login_user.userName == widget.orderModel.store || now_login_user.userName == "김태영")? :
    return StreamProvider<UserModel>.value(
      value: userNetwork.getUserModelStream("1"),
      child: Consumer<UserModel>(builder: (context, user, _) {
        if (now_login_user.userName == widget.restaurantModel.rest_name || ridersList.contains(now_login_user.userName) || now_login_user.userName == "김태영") {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey)]),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  (now_login_user.userName == widget.restaurantModel.rest_name || ridersList.contains(now_login_user.userName) || now_login_user.userName == "김태영")
                      ? Column(
                    children: [
                      Wrap(
                        children: [
                          Center(child: SizedBox(height: 15.0)),
                          Center(
                              child: Text(
                                '${widget.restaurantModel.rest_name}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              )),
                          Center(child: SizedBox(height: 15.0)),
                          Row(
                            children: [
                              Container(
                                width: size.width*0.18,
                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 1,)),
                                child: Column(
                                  children: [
                                    Center(
                                        child:  Text('음식',
                                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,))),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width*0.18,
                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 1,)),
                                child: Column(
                                  children: [
                                    Center(
                                        child:  Text('북측',
                                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,))),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width*0.18,
                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 1,)),
                                child: Column(
                                  children: [
                                    Center(
                                        child:  Text('동측',
                                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,))),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width*0.18,
                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 1,)),
                                child: Column(
                                  children: [
                                    Center(
                                        child:  Text('서측',
                                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,))),
                                  ],
                                ),
                              ),
                              Container(
                                width: size.width*0.18,
                                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.black, width: 1,)),
                                child: Column(
                                  children: [
                                    Center(
                                        child:  Text('총계',
                                            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700,))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height:size.height*0.01,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: size.width*0.18,
                                    child: Column(
                                      children: [
                                        Center(
                                            child:  Text('${widget.restaurantModel.rest_menu}',
                                                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400,))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width*0.18,
                                    child: Column(
                                      children: [
                                        Center(
                                            child:  Text('${widget.restaurantModel.rest_menu_north}',
                                                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400,))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width*0.18,
                                    child: Column(
                                      children: [
                                        Center(
                                            child:  Text('${widget.restaurantModel.rest_menu_east}',
                                                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400,))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width*0.18,
                                    child: Column(
                                      children: [
                                        Center(
                                            child:  Text('${widget.restaurantModel.rest_menu_west}',
                                                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400,))),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width*0.18,
                                    child: Column(
                                      children: [
                                        Center(
                                            child:  Text('${widget.restaurantModel.rest_menu_total}',
                                                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400,))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //Phone SMS
                              Container(
                                height:size.height*0.05,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                      : Container(),
                ],
              )
            ),
          );

        }
        else{
          return Container();
        }
      }),
    );
  }
}
