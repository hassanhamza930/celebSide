import 'package:celebside/pages/home/celebrityProfile/sendMessage/celebrityChat.dart';
import 'package:celebside/pages/home/featuredVideoPlayer/fanClub.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import "package:multi_sort/multi_sort.dart";
import 'package:flutter/cupertino.dart';

class notificationRow extends StatefulWidget {

  final String personId;
  final Timestamp createdAt;
  final String message;
  notificationRow({this.personId,this.createdAt,this.message});

  @override
  _notificationRowState createState() => _notificationRowState();
}

class _notificationRowState extends State<notificationRow> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.personId).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasData){
          DocumentSnapshot doc=snapshot.data;
          Map data=doc.data();

          var realDif="";
          Duration difference=DateTime.now().difference(widget.createdAt.toDate());

          if(difference.inDays>0){
            realDif="${difference.inDays} days ago";
          }
          else if(difference.inHours>0){
            realDif="${difference.inHours} hours ago";
          }
          else if(difference.inMinutes>0){
            realDif="${difference.inMinutes} minutes ago";
          }


          return Center(
            child: Container(
              margin: EdgeInsets.only(top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right:10),
                    child: Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            "${data["imgSrc"]}",
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.message}",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontFamily: "Avenir"
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "$realDif",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.orange,
                              fontFamily: "Avenir"
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else{
          return Container();
        }

      }
    );
  }
}






class notifications extends StatefulWidget {
  @override
  _notificationsState createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/bluebackground.png",fit: BoxFit.cover,width: width,height: height,),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: width*0.9,
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 10,),
                  SizedBox(height: 10,),
                  Center(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Notifications",
                        style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontFamily: "Avenir"
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).collection("notifications").orderBy("createdAt").snapshots(),
                    builder: (context, snapshot) {

                      if(snapshot.hasData){


                        List<DocumentSnapshot> doc=snapshot.data.docs;
                        List notifications=[];
                        doc.forEach((element) {
                          notifications.add(
                              element.data()
                          );
                        });

                        notifications=notifications!=null?notifications.reversed.toList(growable: true):[];

                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: notifications.length,
                            itemBuilder: (context,index)
                            {
                              return GestureDetector(
                                onTap: (){
                                  if(notifications[index]["type"]=="dm"){
                                    Navigator.push(context, CupertinoPageRoute(builder: (context){
                                      return celebrityChat(isCelebrity: false,celebId:notifications[index]["from"] ,);
                                    }));
                                  }

                                  if( notifications[index]["type"]=="fanClub"){
                                    Navigator.push(context, CupertinoPageRoute(builder: (context){
                                      return fanClub(celebId:notifications[index]["from"],);
                                    }));
                                  }

                                },
                                  child: notificationRow(createdAt: notifications[index]["createdAt"],message: notifications[index]["message"],personId: notifications[index]["from"],)
                              );
                            }
                        );
                      }
                      else{
                        return Container();
                      }

                    }
                  ),
                  SizedBox(height:200 ,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
