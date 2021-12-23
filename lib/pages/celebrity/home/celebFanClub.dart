import 'package:celebside/pages/celebrity/home/celebVibers.dart';
import 'package:celebside/pages/celebrity/home/fanClubReviews.dart';
import 'package:celebside/pages/home/featuredVideoPlayer/fanClub.dart';
import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_switch/flutter_switch.dart';
import "package:multi_sort/multi_sort.dart";
import 'package:flutter/cupertino.dart';

var message=TextEditingController(text:"");
var value=false;

class celebFanClub extends StatefulWidget {
  @override
  _celebFanClubState createState() => _celebFanClubState();
}

class _celebFanClubState extends State<celebFanClub> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasData){
          DocumentSnapshot doc=snapshot.data;
          Map data=doc.data();

          List fanClubMessages=data["fanClubMessages"];
          fanClubMessages.sort((a, b) => (b["createdAt"]).compareTo(a["createdAt"])); /// sort List<Map<String,dynamic>>
          //fanClubMessages=fanClubMessages.reversed.toList(growable: true);



         return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [

                  Image.asset(
                    "assets/bluebackground.png",
                    fit: BoxFit.cover,
                    width: width,
                  ),
                  Center(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            width: width * 0.9,
                            child: Text(
                              "Fan Club",
                              style: TextStyle(
                                fontSize: 34,
                                color: Colors.white,
                                fontFamily: "Avenir",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            width: width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage("${data["imgSrc"]}"),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "My Fan Club",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontFamily: "AvenirBold",
                                                color: Colors.orange,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            Text(
                                              "Drop Deals, Promos and messages to your fans in your Fan Club exclusively.",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: "Avenir",
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        )))
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 30,),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              GestureDetector(
                                onTap: (){

                                },
                                child: Column(
                                  children: [
                                    Text("${data["fanClubMessages"].length}",style: small(color: Colors.white),),
                                    Text("Promos",style: small(color: Colors.orange),),
                                  ],
                                ),
                              ),

                              GestureDetector(
                                // onTap: (){
                                //   Navigator.push(context, CupertinoPageRoute(builder: (context){
                                //     return vibers();
                                //   }));
                                // },
                                child: Column(
                                  children: [
                                    Text("${data["fanClubMembers"].length}",style: small(color: Colors.white),),
                                    Text("Vibers",style: small(color: Colors.orange),),
                                  ],
                                ),
                              ),

                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context){
                                    return fanClubReviews();
                                  }));
                                },
                                child: Column(
                                  children: [
                                    Text("${data["reviews"]}",style: small(color: Colors.white),),
                                    Text("Reviews",style: small(color: Colors.orange),),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Container(
                            width: width,
                            color: Colors.white.withOpacity(0.2),
                            child: Container(
                              width: width * 0.9,
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: fanClubMessages.length,
                                itemBuilder: (context,index){
                                  var currentMessage=fanClubMessages[index];
                                  return fanMessage(
                                    message: currentMessage["message"],
                                    createdAt: currentMessage["createdAt"],
                                    likes:currentMessage["likes"],
                                    shares: currentMessage["shares"],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 300,)
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: height,
                      width: width,
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 20, top: 20),
                        color: Color.fromRGBO(24, 48, 93, 1),
                        height: height * 0.13,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(left: 3),
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24.0))),
                                child: Center(
                                  child: TextField(
                                    controller: message,
                                    style: TextStyle(
                                        color: Colors.white, fontFamily: 'Avenir'),
                                    decoration: InputDecoration(
                                      enabled: true,
                                      labelText: 'Write a Message',
                                      labelStyle: TextStyle(
                                          color: Colors.white, fontFamily: 'Avenir'),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsetsDirectional.only(
                                          start: 20.0, end: 20),
                                    ),
                                    onChanged: (_onChanged) {
                                      print(_onChanged);
                                    },
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: ()async {

                                if(message.text.trim()!=""){

                                  showLoading(context: context);

                                  List messages=data["fanClubMessages"];
                                  messages.add(
                                      {
                                        "message":message.text,
                                        "createdAt":DateTime.now(),
                                        "likes":0,
                                        "shares":0
                                      }
                                      );

                                  await FirebaseFirestore.instance.collection("celebrities")
                                      .doc(FirebaseAuth.instance.currentUser.uid)
                                      .set(
                                      {
                                        "fanClubMessages":messages
                                      },
                                      SetOptions(merge: true)
                                    );


                                  List members=data["fanClubMembers"];
                                  members.forEach((element)async{

                                    var celebrityName=data["fullName"];
                                    await addNotifications(type:"fanClub",target: "user", message: "$celebrityName has sent a message in fan club.", String: String, from: FirebaseAuth.instance.currentUser.uid, to: element);

                                  });

                                  message.text='';
                                  Navigator.pop(context);

                                }
                                else{
                                  showErrorDialogue(context: context, message: "Kindly enter a message.");
                                }

                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left:20,top:40),
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      }
    );
  }
}
