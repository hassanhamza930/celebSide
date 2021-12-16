import 'package:celebside/pages/home/notifications/notifications.dart';
import 'package:celebside/pages/home/profile/profile.dart';
import 'package:celebside/pages/home/requests/requests.dart';

import 'featured/featured.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
var pages=[
  Featured(),
  requests(),
  notifications(),
  profile(),
];

var currentTab = 0;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
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
