import '../home/celebrityHome.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/cupertino.dart';

var status=false;

class celebrityNotifications extends StatefulWidget {
  @override
  _celebrityNotificationsState createState() => _celebrityNotificationsState();
}

class _celebrityNotificationsState extends State<celebrityNotifications> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Container(
            color: Colors.orange,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Image.asset(
                  "assets/bluebackground.png",
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Center(
                  child: Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                            child: Image.asset("assets/notificationpermission/bell.png")
                        ),
                        SizedBox(height: 50,),
                        Text(
                          "Turn On\nNotifications",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 34,
                              fontFamily: "AvenirBold",
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Enable push notifications to send you\npersonal news and updates.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: "Avenir",
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: Offset(0, 7), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Turn on notifications",
                                style: TextStyle(
                                    fontFamily: "Avenir", fontSize: 17),
                              ),
                              FlutterSwitch(value: status, onToggle: (val) {
                                setState(() {
                                  status=val;
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(builder: (context){
                                        return celebrityHome();
                                      })
                                  );

                                });
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        CupertinoPageRoute(builder: (context){
                          return celebrityHome();
                        })
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Skip",style: small(color: Colors.orange),),
                        ],
                      ),
                    ),
                  ),
                ),
                // GestureDetector(
                //   onTap: (){
                //     Navigator.pop(context);
                //   },
                //   child: Container(
                //     padding: EdgeInsets.only(left:20,top:20),
                //     alignment: Alignment.topLeft,
                //     child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
