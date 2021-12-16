import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/orderDetails.dart';
import 'package:celebside/pages/home/celebrityProfile/sendMessage/celebrityChat.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


class dmRow extends StatefulWidget {

  final user;
  final createdAt;
  final status;
  dmRow({this.user,this.createdAt,this.status});

  @override
  _dmRowState createState() => _dmRowState();
}

class _dmRowState extends State<dmRow> {
  @override
  Widget build(BuildContext context) {



    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(widget.user).snapshots(),
        builder: (context, snapshot) {

          if(snapshot.hasData){

            DocumentSnapshot doc=snapshot.data;
            Map data=doc.data();

            return Center(
              child: Container(
                margin: EdgeInsets.only(top:10),
                width: width*0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width*0.6,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                "${data["imgSrc"]}",
                                ),
                            ),
                          ),
                          SizedBox(width: 7,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${data["fullName"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "AvenirBold",
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${widget.createdAt.toDate().toString().split(" ")[0]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Avenir",
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width*0.3,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              CupertinoPageRoute(builder: (context){
                                return celebrityChat(celebId: widget.user.toString(),isCelebrity:true);
                              })
                          );
                        },
                        child: Container(
                            width: width*0.3,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(24, 47, 91, 1),
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            margin: EdgeInsets.only(left: 10),
                            padding:EdgeInsets.only(top:7,bottom: 7,left: 7,right: 7),
                            // padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.message,color: Colors.white,),
                                SizedBox(width: 5,),
                                Flexible(
                                  child: AutoSizeText(
                                    widget.status=="pending"?"Pending":"",
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: "Avenir",
                                        fontSize: 12,
                                        color: Colors.white
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          else{
            return Container(
                height: 50,
                child: CircularProgressIndicator()
            );
          }

        }
    );
    
    
  }
}







class dms extends StatefulWidget {
  dms({this.currentTab});
  final currentTab;

  @override
  _dmsState createState() => _dmsState();
}

class _dmsState extends State<dms> {
  @override
  Widget build(BuildContext context) {


    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(height: 10,),
        Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
              ),
            padding: EdgeInsets.all(10),
            child: Center(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid.toString()).where("type",isEqualTo: "dm").where("filtered",isEqualTo:true).where("status",isEqualTo: widget.currentTab==0?"pending":"complete").snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    var docs=snapshot.data;
                    List data=docs.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context,index){
                        return dmRow(user: data[index].data()["user"],status: data[index].data()["status"],createdAt:data[index].data()["createdAt"],);
                      },
                    );


                  }
                  else{
                    return Container();
                  }
                }
              ),
            ),
          ),
        ),
        SizedBox(height: 20,),
        SizedBox(height: 150,),

      ],
    );
  }
}
