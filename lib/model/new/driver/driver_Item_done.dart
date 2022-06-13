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
import 'package:flutter_sms/flutter_sms.dart';

import 'driver_model.dart';


void _sendSMS(String message, List<String> recipents) async {
  String _result = await FlutterSms
      .sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}

class DriverItemDone extends StatefulWidget {
  final DriverModel driverModel;


  DriverItemDone({this.driverModel});

  @override
  _DriverItemDoneState createState() => _DriverItemDoneState();
}

class _DriverItemDoneState extends State<DriverItemDone> {

  bool _isOpened = false;
  var ridersList = ["West", "East", "North"];

  @override
  Widget build(BuildContext context) {
    RiderModel now_login_user = Provider.of<UserModelState>(context, listen: false).userModel;
    //(now_login_user.userName == widget.orderModel.store || now_login_user.userName == "김태영")? :
    return StreamProvider<UserModel>.value(
      value: userNetwork.getUserModelStream("1"),
      child: Consumer<UserModel>(builder: (context, user, _) {
        if (now_login_user.userName == widget.driverModel.nswe|| now_login_user.userName == "김태영") {
          if (widget.driverModel.process == KEY_DONE)
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
                  Positioned(
                    top: 5.0,
                    bottom: 5.0,
                    child: Container(),
                  ),
                  Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            '${widget.driverModel.dorm} 완료됨!',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.driverModel.dorm_menu.length,
                            itemBuilder: (context, index){
                              String key = widget.driverModel.dorm_menu.keys.elementAt(index);
                              if(widget.driverModel.dorm_menu.isNotEmpty){
                                return Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(width: size.width*0.05),
                                        Expanded(
                                          child: Container(
                                            width: size.width*0.1,
                                            child: Text('${key} : ',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 15.0)),
                                          ),
                                        ),
                                        Container(
                                          width: size.width*0.2,
                                          child: Text('${widget.driverModel.dorm_menu[key]}',
                                              style: TextStyle(fontSize: 15.0)),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height:size.height*0.01,
                                    ),

                                    //Phone SMS
                                    Container(
                                      height:size.height*0.05,
                                    ),
                                  ],
                                );
                              }
                              else{
                                return Container();
                              }
                            },
                          ),
                          InkWell(
                            onTap: () async {
                              if (widget.driverModel.process ==
                                  KEY_DONE) {
                                bool flag = await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('상태 변경'),
                                        content: Text(
                                            '${widget.driverModel.dorm}\n\n\n다시 배송 진행중 상태로 변경하시겠습니까?'),
                                        actions: [
                                          FlatButton(
                                            child: Text('변경'),
                                            onPressed: () {
                                              Navigator.pop(
                                                  context, true);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('취소'),
                                            onPressed: () {
                                              Navigator.pop(
                                                  context, false);
                                            },
                                          )
                                        ],
                                      );
                                    });

                                if (flag != null && flag) {
                                  await orderNetwork.changeOrderProcess(
                                      dorm:
                                      widget.driverModel.dorm,
                                      date: widget.driverModel.dorm_orderday,
                                      process: KEY_DOING);
                                }
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 4),
                              width: size.width*0.5,
                              height: size.height*0.05,
                              decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                  "${widget.driverModel.dorm} 완료 취소",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14.0)
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: size.width * 0.2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ],
              )
            ),
          );
          else
            return Container();
        }
        else{
          return Container();
        }
      }),
    );
  }
}
