import 'package:celebside/pages/home/celebrityProfile/celebrityProfilePage.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/orderDetails.dart';
import 'package:celebside/pages/home/requests/booking.dart';
import 'package:celebside/pages/home/requests/completed.dart';
import 'package:celebside/pages/home/requests/pending.dart';
import 'package:celebside/pages/home/videoPlayer/videoPlayer.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:sliding_up_panel/sliding_up_panel.dart';

var details=true;
var currentCat=0;
var controller=PageController(initialPage: 0);




class requests extends StatefulWidget {
  @override
  _requestsState createState() => _requestsState();
}

class _requestsState extends State<requests> {
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/bluebackground.png",fit: BoxFit.cover,width: width,),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("requests").where("user",isEqualTo: FirebaseAuth.instance.currentUser.uid.toString()).where("status",isEqualTo: currentCat==0?"pending":"complete").snapshots(),
              builder: (context, snapshot) {

                if(snapshot.hasData){
                  var DMcount=0;
                  List<QueryDocumentSnapshot> finalPending=[];


                  QuerySnapshot docs=snapshot.data;
                  docs.docs.forEach((element) {
                    Map data=element.data();

                    if( data["type"]=="dm" || data["type"]=="videoRequest" ){
                      DMcount+=1;
                    }
                    else{}


                  });

                  var pages=[
                    pending(),
                    completed(),
                    booking()
                  ];

                  return Center(
                      child: Container(
                        width: width,
                        height: height,
                        child: ListView(
                          // mainAxisSize: MainAxisSize.min,
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Text(
                                "Your Requests",
                                style: medium(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 20,),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      currentCat=0;
                                      setState(() {
                                      });
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Pending",style: small(color: currentCat==0?Colors.orange:Colors.white,),),
                                              SizedBox(width: 5,),
                                              Container(
                                                padding: EdgeInsets.only(top:2,bottom:2,left:5,right:5),
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(15)
                                                    )
                                                ) ,
                                                child: StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection("requests")
                                                      .where("user",isEqualTo: FirebaseAuth.instance.currentUser.uid)
                                                      .where("type",isNotEqualTo: "eventBooking" )
                                                      .where("status",isEqualTo: "pending")
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if(snapshot.hasData){
                                                      List<DocumentSnapshot> docs=snapshot.data.docs;
                                                      return Text("${docs.length}",style: small(color: Colors.white),);
                                                    }
                                                    else{
                                                      return Text("0",style: small(color: Colors.white),);
                                                    }
                                                  }
                                                ),
                                              )
                                            ]
                                            ,
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            color: currentCat==0?Colors.orange:Colors.white,
                                            height: 5,
                                            width: width*0.25,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      currentCat=1;
                                      setState(() {
                                      });
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Completed",style: small(color: currentCat==1?Colors.orange:Colors.white,),),
                                              SizedBox(width: 10,),
                                              Container(
                                                padding: EdgeInsets.only(top:2,bottom:2,left:5,right:5),
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(15)
                                                    )
                                                ) ,
                                                child: StreamBuilder(
                                                  stream: FirebaseFirestore.instance.collection("requests")
                                                      .where("user",isEqualTo: FirebaseAuth.instance.currentUser.uid)
                                                      .where("type",isNotEqualTo: "eventBooking" )
                                                      .where("status",isEqualTo: "complete")
                                                      .snapshots(),
                                                  builder: (context, snapshot) {
                                                    if(snapshot.hasData){
                                                      List<DocumentSnapshot> docs=snapshot.data.docs;
                                                      return Text("${docs.length}",style: small(color: Colors.white),);
                                                    }
                                                    else{
                                                      return Text("0",style: small(color: Colors.white),);
                                                    }
                                                  }
                                                ),
                                              )
                                            ]
                                            ,
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            color: currentCat==1?Colors.orange:Colors.white,
                                            height: 5,
                                            width: width*0.25,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        currentCat=2;
                                      });
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text("Booking",style: small(color: currentCat==2?Colors.orange:Colors.white,),),
                                                ],
                                              ),
                                              SizedBox(width: 10,),
                                              Container(
                                                padding: EdgeInsets.only(top:2,bottom:2,left:5,right:5),
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(15)
                                                    )
                                                ) ,
                                                child: StreamBuilder(
                                                    stream: FirebaseFirestore.instance.collection("requests")
                                                        .where("user",isEqualTo: FirebaseAuth.instance.currentUser.uid)
                                                        .where("type",isEqualTo: "eventBooking" )
                                                        .snapshots(),
                                                    builder: (context, snapshot) {
                                                      if(snapshot.hasData){
                                                        List<DocumentSnapshot> docs=snapshot.data.docs;
                                                        return Text("${docs.length}",style: small(color: Colors.white),);
                                                      }
                                                      else{
                                                        return Text("0",style: small(color: Colors.white),);
                                                      }
                                                    }
                                                ),
                                              )
                                            ]
                                            ,
                                          ),
                                          SizedBox(height: 5,),
                                          Container(
                                            color: currentCat==2?Colors.orange:Colors.white,
                                            height: 5,
                                            width: width*0.25,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            pages[currentCat],
                            SizedBox(height: 150,)
                          ],
                        ),
                      )
                  );
                }
                else{
                  return Container();
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
