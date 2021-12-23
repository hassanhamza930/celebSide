import 'package:celebside/pages/celebrity/home/celebrityVideoRecord.dart';
import 'package:celebside/pages/celebrity/home/requestTabs/dms.dart';
import 'package:celebside/pages/celebrity/home/requestTabs/eventBookings.dart';
import 'package:celebside/pages/celebrity/home/requestTabs/videoRequests.dart';
import 'package:celebside/pages/celebrity/home/schedule.dart';
import 'package:celebside/pages/home/videoPlayer/videoPlayer.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

var currentTab = 0;
var subTab = 0;
var topBar = 0;



var reqController=PageController(keepPage: false);



class celebRequests extends StatefulWidget {
  @override
  _celebRequestsState createState() => _celebRequestsState();
}

class _celebRequestsState extends State<celebRequests> {

  @override
  void dispose() {
    currentTab = 0;
    subTab=0;
    topBar = 0;
    reqController=null;
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    reqController=PageController(keepPage: false,initialPage: 0);
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
            fit: BoxFit.cover,
            width: width,
          ),
          Center(
              child: Container(
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Requests",
                          style: TextStyle(
                            fontSize: 34,
                            fontFamily: "Avenir",
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                              return schedule();
                            }));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.history,
                                size: 30,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                                child: Text(
                                  "Schedule",
                                  style: small(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    color: Colors.white,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                print('one');
                                setState(() {
                                  currentTab = 0;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                      "Pending",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontFamily: "Avenir",
                                        ),
                                      ),
                                      StreamBuilder(
                                        stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo:FirebaseAuth.instance.currentUser.uid).where("status",isEqualTo: "pending").where("filtered",isEqualTo: true).snapshots(),
                                        builder: (context, snapshot) {
                                          if(snapshot.hasData){
                                            List<DocumentSnapshot> docs=snapshot.data.docs;
                                            print(docs);
                                            return Container(
                                              margin: EdgeInsets.only(left:5),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20))),
                                              padding: EdgeInsets.only(
                                                  top: 3,
                                                  bottom: 3,
                                                  left: 6,
                                                  right: 6),
                                              child: Text(
                                                "${docs.length}",
                                                style: small(color: Colors.white),
                                              ),
                                            );
                                          }
                                          else{
                                            return Container(
                                              margin: EdgeInsets.only(left:5),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20))),
                                              padding: EdgeInsets.only(
                                                  top: 3,
                                                  bottom: 3,
                                                  left: 6,
                                                  right: 6),
                                              child: Text(
                                                "0",
                                                style: small(color: Colors.white),
                                              ),
                                            );
                                          }
                                        }
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width * 0.4,
                                    height: 5,
                                    color: currentTab == 0
                                        ? Colors.black
                                        : Colors.transparent,
                                  )
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                print('two');
                                setState(() {
                                  currentTab = 1;
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Completed",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontFamily: "Avenir",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        padding: EdgeInsets.only(
                                            top: 3,
                                            bottom: 3,
                                            left: 6,
                                            right: 6),
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance.collection("requests")
                                            .where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid)
                                            .where("status",isEqualTo: "complete")
                                            .snapshots(),
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData){
                                              List<DocumentSnapshot> docs=snapshot.data.docs;
                                              return Text(
                                                "${docs.length}",
                                                style: small(color: Colors.white),
                                              );
                                            }
                                            else{
                                              return Text(
                                                "0",
                                                style: small(color: Colors.white),
                                              );
                                            }
                                          }
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width * 0.4,
                                    height: 5,
                                    color: currentTab == 1
                                        ? Colors.black
                                        : Colors.transparent,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                            color: Colors.white.withOpacity(0.5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: (){
                                        setState(() {
                                          reqController.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: subTab==0?Border.all(
                                                color: Color.fromRGBO(24, 48, 93, 1),
                                                width: 2
                                            ):Border.all(color: Colors.transparent)),
                                        child: Text(
                                          "DM",
                                          style: smallBold(
                                              color: Color.fromRGBO(24, 48, 93, 1),
                                              size: 14
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(width: 1,color: Colors.black,height: 30,),
                                    TextButton(
                                      onPressed: (){
                                        setState(() {
                                          reqController.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: subTab==1?Border.all(
                                                color: Color.fromRGBO(24, 48, 93, 1),
                                                width: 2
                                            ):Border.all(color: Colors.transparent)),
                                        child: Text(
                                          "Video Request",
                                          style: smallBold(
                                              color: Color.fromRGBO(24, 48, 93, 1),
                                              size: 14
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Container(width: 1,color: Colors.black,height: 30,),
                                    TextButton(
                                      onPressed: (){
                                        setState(() {
                                          reqController.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: subTab==2?Border.all(
                                                color: Color.fromRGBO(24, 48, 93, 1),
                                                width: 2
                                            ):Border.all(color: Colors.transparent)),
                                        child: Text(
                                          "Bookings",
                                          style: smallBold(
                                              color: Color.fromRGBO(24, 48, 93, 1),
                                              size: 14
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Container(
                                  height: 500,
                                  child: PageView(
                                    controller: reqController,
                                    onPageChanged: (page){
                                      setState(() {
                                        print(page);
                                        subTab=page;
                                      });
                                    },
                                    children: [
                                      dms(currentTab: currentTab,),
                                      videoRequests(completed: currentTab==1?true:false,),
                                      eventBookings(completed: currentTab==1?true:false,)
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(height: 10,),
                        SizedBox(height: 10,),
                      ],
                    )),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
