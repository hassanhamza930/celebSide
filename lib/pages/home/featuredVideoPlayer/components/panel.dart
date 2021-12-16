import 'package:celebside/pages/home/featured/components/featuredVibeContainer.dart';
import 'package:celebside/pages/home/featuredVideoPlayer/fanClub.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';

class panel extends StatefulWidget {
  @override
  _panelState createState() => _panelState();
}

class _panelState extends State<panel> {

  @override
  Widget build(BuildContext context) {

  var width= MediaQuery.of(context).size.width;

    return Container(
        decoration: BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Center(
          child: ListView(
            children: [
              SizedBox(height: 20,),
              Center(
                child: Container(
                  width: width*0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Popular",
                        style: TextStyle(
                            color: Colors.white,
                          fontSize: 17,
                          fontFamily: "Avenir"
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        "New",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: "Avenir"
                        ),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context){
                                  return fanClub();
                                }
                              )
                          );
                        },
                        child: Text(
                          "Fan Club",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: "Avenir"
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  width: width*0.9,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 190,
                          width: MediaQuery.of(context).size.width,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection("requests").where("type",isEqualTo: "videoRequest").where("status",isEqualTo:"complete").where("private",isEqualTo: false).snapshots(),
                              builder: (context, snapshot) {

                                if(snapshot.hasData){
                                  List<DocumentSnapshot> data=snapshot.data.docs;
                                  return ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context,index){

                                      Map currentDocData=data[index].data();


                                      return StreamBuilder(
                                          stream: FirebaseFirestore.instance.collection("celebrities").doc(currentDocData["celebrity"]).snapshots(),
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData){

                                              Map celebData=snapshot.data.data();
                                              return Row(
                                                children: [
                                                  FeaturedVibeContainer(celebData:celebData,reqData: currentDocData,vidId:currentDocData["vidSrc"],imgSrc:celebData["imgSrc"],name:celebData["fullName"] ),
                                                  SizedBox(width: 10,)
                                                ],
                                              );

                                            }

                                            else{
                                              return Container();
                                            }

                                          }
                                      );
                                    },
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                  );
                                }
                                else{
                                  return Container();
                                }

                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
