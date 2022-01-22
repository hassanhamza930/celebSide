import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'celebNotifications.dart';
import 'celebRequests.dart';
import 'celebrityBooking.dart';
import 'package:celebside/pages/celebrity/home/celebrityProfile.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
var currentTab=0;

class celebrityHome extends StatefulWidget {
  @override
  _celebrityHomeState createState() => _celebrityHomeState();
}

class _celebrityHomeState extends State<celebrityHome> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var pages=[
      celebrityBookings(),
      celebRequests(),
      celebNotifications(),
      celebrityProfilePageEdit()
    ];




    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("celebrities").doc("${FirebaseAuth  .instance.currentUser.uid}").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            Map data=snapshot.data.data();
            if(data["disabled"]==true){
              return Scaffold(
                body: Center(
                  child: Text(
                    "Your account has been disabled, Kindly Contact the administrator",
                    style: small(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            else{
              return Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    Image.asset(
                      "assets/bluebackground.png",
                      width: width,
                      fit: BoxFit.cover,
                      height: height,
                    ),
                    Center(
                      child:pages[currentTab],
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: height,
                      width: width,
                      child: Container(
                        height: 70,
                        padding: EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 10),
                        color: Color.fromRGBO(24, 48, 93, 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  print("one");
                                  setState(() {
                                    currentTab = 0;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              currentTab == 0
                                                  ? Colors.orange
                                                  : Colors.white,
                                              BlendMode.srcATop),
                                          child: Image.asset(
                                            "assets/bottom bar/simple/1.png",fit: BoxFit.contain,
                                            height: 25,
                                          )),
                                      Text(
                                        "Home",
                                        style: TextStyle(
                                          fontFamily: "Avenir",
                                          fontSize: 12,
                                          color: currentTab == 0
                                              ? Colors.orange
                                              : Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            GestureDetector(
                                onTap: () {
                                  print("one");
                                  setState(() {
                                    currentTab = 1;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              currentTab == 1
                                                  ? Colors.orange
                                                  : Colors.white,
                                              BlendMode.srcATop),
                                          child: Image.asset(
                                            "assets/bottom bar/simple/2.png",
                                            fit: BoxFit.contain,
                                            height: 25,
                                          )
                                      ),
                                      Text(
                                        "Requests",
                                        style: TextStyle(
                                          fontFamily: "Avenir",
                                          fontSize: 12,
                                          color: currentTab == 1
                                              ? Colors.orange
                                              : Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            GestureDetector(
                                onTap: () {
                                  print("one");
                                  setState(() {
                                    currentTab = 2;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              currentTab == 2
                                                  ? Colors.orange
                                                  : Colors.white,
                                              BlendMode.srcATop),
                                          child: Image.asset(
                                            "assets/bottom bar/simple/3.png",
                                            fit: BoxFit.contain,
                                            height: 25,)),
                                      Text(
                                        "Notifications",
                                        style: TextStyle(
                                          fontFamily: "Avenir",
                                          fontSize: 12,
                                          color: currentTab == 2
                                              ? Colors.orange
                                              : Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            GestureDetector(
                                onTap: () {
                                  print("one");
                                  setState(() {
                                    currentTab = 3;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              currentTab == 3
                                                  ? Colors.orange
                                                  : Colors.white,
                                              BlendMode.srcATop),
                                          child: Image.asset(
                                            "assets/bottom bar/simple/4.png",
                                            fit: BoxFit.contain,
                                            height: 25,)),
                                      Text(
                                        "Profile",
                                        style: TextStyle(
                                          fontFamily: "Avenir",
                                          fontSize: 12,
                                          color: currentTab == 3
                                              ? Colors.orange
                                              : Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }
          else{
            return Container();//check interenet connection here
          }
        }
    );
  }
}
