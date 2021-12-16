import 'package:celebside/pages/home/celebrityProfile/celebrityProfilePage.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

var isJoined=false;



class fanMessage extends StatefulWidget {

  final int index;
  final String message;
  final int shares;
  final int likes;
  final Timestamp createdAt;
  final String celebId;
  fanMessage({this.message,this.shares,this.likes,this.createdAt,this.index,this.celebId});

  @override
  _fanMessageState createState() => _fanMessageState();
}



class _fanMessageState extends State<fanMessage> {
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top:20),
        width: width * 0.9,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight:
                      Radius.circular(10))),
              padding: EdgeInsets.all(10),
              width: width * 0.6,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.message}",
                    style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.createdAt.toDate().toString().split(" ")[0]}   ${widget.createdAt.toDate().hour } ${widget.createdAt.toDate().minute } ",
                    style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 11,
                        color: Colors.blueGrey),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: [

                  TextButton(
                    onPressed: (){
                      print('shared');

                      showDialog(context:context,builder: (context){

                        var width=MediaQuery.of(context).size.width;
                        var height=MediaQuery.of(context).size.height;

                        return Center(
                          child: Scaffold(
                            backgroundColor: Colors.transparent,
                            body: Container(
                              height: height,
                              width: width,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  color: Colors.white,
                                  height: height*0.3,
                                  width: width,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            FloatingActionButton(
                                              mini: true,
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                              child: Icon(Icons.close),
                                                ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [

                                            Column(
                                              children: [
                                                Text("Whatsapp",style: small(color: Colors.black),),
                                                SizedBox(height: 5,),
                                                FloatingActionButton(
                                                  backgroundColor: Colors.green,
                                                  onPressed: ()async{

                                                    String messageToLaunch=widget.message;
                                                    messageToLaunch=messageToLaunch.replaceAll(" ", " ");
                                                    var uri ="https://wa.me/?text=${Uri.encodeComponent(messageToLaunch)}";

                                                    if (await canLaunch(uri))
                                                    {
                                                      await launch(uri);
                                                    }
                                                    else {
                                                      print('Could not launch $uri');
                                                    }

                                                  },
                                                  child: FaIcon(FontAwesomeIcons.whatsapp,color: Colors.white,),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );

                      });

                    },
                    child: Container(
                      width: 70,
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "${widget.shares}",
                                style: TextStyle(
                                    fontFamily: "Avenir",
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  TextButton(
                    onPressed: ()async{
                      print("fired");

                      Map data= await getCelebrityData(id: widget.celebId);
                      List fanClubMessages= data["fanClubMessages"];
                      fanClubMessages.sort((a, b) => (b["createdAt"]).compareTo(a["createdAt"]));

                      List likersList=fanClubMessages[widget.index]["likers"]==null?[]:fanClubMessages[widget.index]["likers"];
                      fanClubMessages[widget.index]["likers"]=likersList;

                      if(likersList.contains(FirebaseAuth.instance.currentUser.uid)){

                      }

                      else{
                        fanClubMessages[widget.index]["likers"].add(FirebaseAuth.instance.currentUser.uid);
                        fanClubMessages[widget.index]["likes"]+=1;
                        await FirebaseFirestore.instance.collection("celebrities").doc(widget.celebId).set(
                            {
                              "fanClubMessages":fanClubMessages
                            },
                            SetOptions(merge:true)
                        );
                      }








                    },
                    child: Container(
                      width: 70,
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_fire_department_sharp,
                            color: Colors.white,
                          ),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(
                                "${widget.likes}",
                                style: TextStyle(
                                    fontFamily: "Avenir",
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

















class fanClub extends StatefulWidget {
  final String celebId;
  fanClub({this.celebId});

  @override
  _fanClubState createState() => _fanClubState();
}

class _fanClubState extends State<fanClub> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebId).snapshots(),
        builder: (context, snapshot) {

          if(snapshot.hasData){

            DocumentSnapshot doc=snapshot.data;
            Map data=doc.data();
            List fanClubMessages=data["fanClubMessages"];
            fanClubMessages.sort((a, b) => (b["createdAt"]).compareTo(a["createdAt"]));

            if(data["fanClubMembers"].contains(FirebaseAuth.instance.currentUser.uid)){
              isJoined=true;
            }
            else{
              isJoined=false;
            }



            return Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    "assets/bluebackground.png",
                    fit: BoxFit.cover,
                    width: width,
                  ),
                  SafeArea(
                    child: Center(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 10,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      "${data["imgSrc"]}",
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
                                                "Join ${data["fullName"]}'s Fan Club to unlock more exclusive contents",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "AvenirBold",
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "You will get notified when they drop Deals, Promos and Videos",
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
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 10,left:10,right: 10),
                                    decoration: BoxDecoration(
                                        gradient: new LinearGradient(
                                          colors: [
                                            Colors.orange,
                                            Colors.orange,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.all(Radius.circular(5))),
                                    //width: 80,
                                    //height: 27,
                                    //height: 50,
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(padding: EdgeInsets.only(bottom: 2),child: Icon(Icons.person_sharp,color: Colors.white,)),
                                          SizedBox(width: 5,),
                                          Text(
                                            isJoined==true?"Joined Fan Club":"Join Fan Club",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "AvenirBold",
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: FlutterSwitch(
                                      value: isJoined,
                                      onToggle: (value)async {

                                        showLoading(context: context);

                                        setState(() {
                                          isJoined=value;
                                        });


                                        List fanClubMembers=data["fanClubMembers"];

                                        if(value==true){

                                          var exists=fanClubMembers.contains(FirebaseAuth.instance.currentUser.uid);
                                          if(exists==true){
                                            //fanClubMembers.add(FirebaseAuth.instance.currentUser.uid);
                                          }
                                          else{
                                            fanClubMembers.add(FirebaseAuth.instance.currentUser.uid);
                                          }

                                            await FirebaseFirestore.instance.collection("celebrities").doc(widget.celebId).set(
                                              {
                                                "fanClubMembers":fanClubMembers
                                              },
                                              SetOptions(
                                                merge: true
                                              )
                                            );
                                            Navigator.pop(context);

                                        }
                                        else{

                                            await fanClubMembers.remove(FirebaseAuth.instance.currentUser.uid.toString());

                                            await FirebaseFirestore.instance.collection("celebrities").doc(widget.celebId).set(
                                                {
                                                  "fanClubMembers":fanClubMembers
                                                },
                                                SetOptions(
                                                merge: true
                                              )
                                            );

                                            Navigator.pop(context);

                                        }



                                      },
                                      activeColor: Colors.orange,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(top:20,bottom: 70),
                              width: width,
                              color: Colors.white.withOpacity(0.2),
                              child: Container(
                                width: width * 0.9,
                                child:  ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: fanClubMessages.length,
                                  itemBuilder: (context,index){
                                    var currentMessage=fanClubMessages[index];

                                    return fanMessage(
                                      shares: currentMessage["shares"],
                                      createdAt: currentMessage["createdAt"],
                                      message: currentMessage["message"],
                                      likes: currentMessage["likes"],
                                      index:index,
                                      celebId:widget.celebId,

                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
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
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        }
      ),
    );
  }
}
