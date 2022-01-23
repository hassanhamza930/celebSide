import 'package:celebside/pages/celebrity/home/celebHomeTabs/all.dart';
import 'package:celebside/services/calculateFinances.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'celebHomeTabs/dms.dart';
import 'celebHomeTabs/eventBookings.dart';
import 'celebHomeTabs/videoRequests.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
var currentTab = 0;
var subTab = 0;
var topBar = 0;

var pageHeight = 1000;
var controller = PageController(initialPage: 0);


var pages=[
  allCelebHomeTabRequests(),
  dms(),
  videoRequests(),
  eventBookings()
];

class celebrityBookings extends StatefulWidget {
  @override
  _celebrityBookingsState createState() => _celebrityBookingsState();
}

class _celebrityBookingsState extends State<celebrityBookings>
    with TickerProviderStateMixin {
  @override
  void dispose() {
    currentTab = 0;
    subTab = 0;
    topBar = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            child: NotificationListener<ScrollEndNotification>(
              onNotification: (scrollEnd) {
                var metrics = scrollEnd.metrics;
                if (metrics.atEdge) {
                  if (metrics.pixels == 0) {
                    print('At top');
                    setState(() {
                      pageHeight = 1000;
                    });
                    print(pageHeight);
                  } else {
                    print('At bottom');
                    setState(() {
                      pageHeight += 1000;
                    });
                    print(pageHeight);
                  }
                }
                return true;
              },
              child: ListView(
                children: [
                  topBar == 0
                      ? StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("filtered",isEqualTo:false).where('status',isEqualTo: "pending").snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            QuerySnapshot doc=snapshot.data;

                            var dm=0;
                            var videoRequest=0;
                            var eventBooking=0;


                            doc.docs.forEach((element) {
                              Map data=element.data();
                              if(data["type"]=="dm" ){
                                dm+=1;
                              }
                              if(data["type"]=="videoRequest"){
                                videoRequest+=1;
                              }
                              if(data["type"]=="eventBooking"){
                                eventBooking+=1;
                              }

                            });

                            return Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                color: Colors.transparent,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "New Bookings",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontFamily: "Avenir",
                                        ),
                                      ),
                                      Text(
                                        "${doc.docs.length}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontFamily: "Avenir",
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.8,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(24, 48, 93, 1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            )),
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  height: 50,
                                                  width: width * 0.35,
                                                  child: Center(
                                                    child: Text(
                                                      "Bookings",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                        fontFamily: "Avenir",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      topBar = 1;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Colors.white.withOpacity(0.2),
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(10),
                                                        )),
                                                    child: Center(
                                                      child: Text(
                                                        "Earnings",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontFamily: "Avenir",
                                                        ),
                                                      ),
                                                    ),
                                                    height: 50,
                                                    width: width * 0.35,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${videoRequest}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                                Text(
                                                  "Shoutouts",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "$dm",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                                Text(
                                                  "Messages",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "$eventBooking",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                                Text(
                                                  "Events",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          }
                          else{
                            var dm=0;
                            var videoRequest=0;
                            var eventBooking=0;
                            return Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                color: Colors.transparent,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total Bookings",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontFamily: "Avenir",
                                        ),
                                      ),
                                      Text(
                                        "0",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontFamily: "Avenir",
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.8,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(24, 48, 93, 1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            )),
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius: BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  height: 50,
                                                  width: width * 0.35,
                                                  child: Center(
                                                    child: Text(
                                                      "Bookings",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                        fontFamily: "Avenir",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      topBar = 1;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                        Colors.white.withOpacity(0.2),
                                                        borderRadius: BorderRadius.all(
                                                          Radius.circular(10),
                                                        )),
                                                    child: Center(
                                                      child: Text(
                                                        "Earnings",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontFamily: "Avenir",
                                                        ),
                                                      ),
                                                    ),
                                                    height: 50,
                                                    width: width * 0.35,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${videoRequest}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                                Text(
                                                  "Shoutouts",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "$dm",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                                Text(
                                                  "Messages",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "$eventBooking",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                                Text(
                                                  "Events",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          }
                        }
                      )
                      : StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("transactions").where("to",isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){

                            var totalEarnings=0.0;
                            var monthlyEarnings=0.0;
                            var lastMonthEarnings=0.0;

                            DateTime monthStart= DateTime.now().subtract(Duration(days: DateTime.now().day));
                            DateTime LastMonthStart= DateTime.now().subtract(Duration(days: (DateTime.now().day+30)    ));

                            
                            QuerySnapshot doc=snapshot.data;
                            doc.docs. forEach((element) {
                            Map data=element.data();
                              DateTime transactionDate=data["createdAt"].toDate();

                              if(transactionDate.isAfter(monthStart)){
                                monthlyEarnings+=element["amount"];
                              }
                              else if(transactionDate.isAfter(LastMonthStart) && transactionDate.isBefore(monthStart)){
                                lastMonthEarnings+=element["amount"];
                              }

                              totalEarnings+=element["amount"];

                            });
                            
                            return Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                color: Colors.transparent,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total Earnings",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontFamily: "Avenir",
                                        ),
                                      ),
                                      FutureBuilder(
                                        future: calculateTotalEarnings(celebId: FirebaseAuth.instance.currentUser.uid),
                                        builder: (context, snapshot) {
                                          if(snapshot.hasData){
                                            var data = snapshot.data;
                                            return Text(
                                              "¢${data}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.white,
                                                fontFamily: "Avenir",
                                              ),
                                            );
                                          }
                                          if(snapshot.hasError){
                                            print(snapshot.error);
                                            return Container();
                                          }
                                          else{
                                            return Text(
                                              "¢0",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 26,
                                                color: Colors.white,
                                                fontFamily: "Avenir",
                                              ),
                                            );
                                          }
                                        }
                                      ),
                                      Container(
                                        width: width * 0.8,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(24, 48, 93, 1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            )),
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      topBar = 0;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                      Colors.white.withOpacity(0.2),
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    height: 50,
                                                    width: width * 0.35,
                                                    child: Center(
                                                      child: Text(
                                                        "Bookings",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontFamily: "Avenir",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(10),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      "Earnings",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                        fontFamily: "Avenir",
                                                      ),
                                                    ),
                                                  ),
                                                  height: 50,
                                                  width: width * 0.35,
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                            child: Column(
                                              children: [
                                                FutureBuilder(
                                                  future: calculateMonthlyEarnings(celebId: FirebaseAuth.instance.currentUser.uid),
                                                  builder: (context, snapshot) {
                                                    if(snapshot.hasData){
                                                      return Text(
                                                        "¢${snapshot.data}",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontFamily: "AvenirBold",
                                                        ),
                                                      );
                                                    }
                                                    else{
                                                      return Text(
                                                        "¢0",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontFamily: "AvenirBold",
                                                        ),
                                                      );
                                                    }
                                                  }
                                                ),
                                                Text(
                                                  "Monthly Earnings",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                FutureBuilder(
                                                  future: calculateLastMonthEarnings(celebId: FirebaseAuth.instance.currentUser.uid),
                                                  builder: (context, snapshot) {
                                                    if(snapshot.hasData){
                                                      return Text(
                                                        "¢${snapshot.data}",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontFamily: "AvenirBold",
                                                        ),
                                                      );
                                                    }
                                                    else{
                                                      return Text(
                                                        "¢0",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontFamily: "AvenirBold",
                                                        ),
                                                      );
                                                    }
                                                  }
                                                ),
                                                Text(
                                                  "Last Month",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          }
                          else{
                            return Container(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                color: Colors.transparent,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total Earnings",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontFamily: "Avenir",
                                        ),
                                      ),
                                      Text(
                                        "¢0",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 26,
                                          color: Colors.white,
                                          fontFamily: "Avenir",
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.8,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(24, 48, 93, 1),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            )),
                                        child: Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      topBar = 0;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                      Colors.white.withOpacity(0.2),
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    height: 50,
                                                    width: width * 0.35,
                                                    child: Center(
                                                      child: Text(
                                                        "Bookings",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white,
                                                          fontFamily: "Avenir",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius: BorderRadius.all(
                                                        Radius.circular(10),
                                                      )),
                                                  child: Center(
                                                    child: Text(
                                                      "Earnings",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                        fontFamily: "Avenir",
                                                      ),
                                                    ),
                                                  ),
                                                  height: 50,
                                                  width: width * 0.35,
                                                ),
                                              ],
                                            )),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "¢0",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "AvenirBold",
                                                  ),
                                                ),
                                                Text(
                                                  "Monthly Earnings",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "¢0",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "AvenirBold",
                                                  ),
                                                ),
                                                Text(
                                                  "Last Month",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontFamily: "Avenir",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ));
                          }
                        }
                      ),
                  Container(
                      color: Colors.white.withOpacity(0.5),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    subTab=0;
                                    // controller.animateToPage(0,
                                    //     duration: Duration(milliseconds: 300),
                                    //     curve: Curves.easeInOut);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: subTab == 0
                                          ? Border.all(
                                              color:
                                                  Color.fromRGBO(24, 48, 93, 1),
                                              width: 2)
                                          : Border.all(
                                              color: Colors.transparent)),
                                  child: Text(
                                    "All",
                                    style: smallBold(
                                        color: Color.fromRGBO(24, 48, 93, 1),
                                        size: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    subTab=1;

                                    // controller.animateToPage(1,
                                    //     duration: Duration(milliseconds: 300),
                                    //     curve: Curves.easeInOut);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: subTab == 1
                                          ? Border.all(
                                              color:
                                                  Color.fromRGBO(24, 48, 93, 1),
                                              width: 2)
                                          : Border.all(
                                              color: Colors.transparent)),
                                  child: Text(
                                    "DM",
                                    style: smallBold(
                                        color: Color.fromRGBO(24, 48, 93, 1),
                                        size: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    subTab=2;

                                    // controller.animateToPage(2,
                                    //     duration: Duration(milliseconds: 300),
                                    //     curve: Curves.easeInOut);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: subTab == 2
                                          ? Border.all(
                                              color:
                                                  Color.fromRGBO(24, 48, 93, 1),
                                              width: 2)
                                          : Border.all(
                                              color: Colors.transparent)),
                                  child: Text(
                                    "Video Request",
                                    style: smallBold(
                                        color: Color.fromRGBO(24, 48, 93, 1),
                                        size: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.black,
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    subTab=3;

                                    // controller.animateToPage(3,
                                    //     duration: Duration(milliseconds: 300),
                                    //     curve: Curves.easeInOut);
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: subTab == 3
                                          ? Border.all(
                                              color:
                                                  Color.fromRGBO(24, 48, 93, 1),
                                              width: 2)
                                          : Border.all(
                                              color: Colors.transparent)),
                                  child: Text(
                                    "Bookings",
                                    style: smallBold(
                                        color: Color.fromRGBO(24, 48, 93, 1),
                                        size: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: pageHeight.toDouble(),
                            child: pages[subTab]
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
