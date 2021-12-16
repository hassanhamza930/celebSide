import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/home/requests/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class bookingRow extends StatefulWidget {

  final celebrity;
  final user;
  final Timestamp createdAt;
  final status;
  final String docId;


  bookingRow({@required this.celebrity,@required this.user,@required this.createdAt,@required this.status,this.docId});
  @override
  _bookingRowState createState() => _bookingRowState();
}

class _bookingRowState extends State<bookingRow> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    var message="";
    Color color= Colors.white;
    var status=widget.status;

    if(status=="pending"){
      message="Pending";
      color=Color.fromRGBO(24, 47, 91, 1);
    }
    else if(status=="rejected"){
      message="Rejected";
      color=Colors.red;
    }

    else if(status=="offered"){
      message="Offered";
      color=Colors.green;
    }

    else if(status=="accepted"){
      message="Complete";
      color=Color.fromRGBO(24, 47, 91, 1);
    }



    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebrity).snapshots(),
        builder: (context, snapshot) {

          if(snapshot.hasData){

            bool refund;
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
                          Center(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage("${data["imgSrc"]}"),
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
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${widget.createdAt.toDate().toString().split(" ")[0]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Avenir",
                                    color: Colors.white,
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
                        onTap: ()async{


                          if(status=="offered"){
                            showDialog(context: context, builder: (context){
                              return Scaffold(
                                backgroundColor: Colors.transparent,
                                  body: Center(
                                    child: Container(
                                      color: Color.fromRGBO(24, 48, 93, 1),
                                      width: width*0.9,
                                      height: height*0.8,
                                      child: bookingDetails(docId: widget.docId,celebrity:widget.celebrity),
                                    ),
                                  )
                              );
                            });
                          }

                          else if(status=="accepted"){
                            showDialog(context: context, builder: (context){
                              return Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Center(
                                    child: Container(
                                      width: width*0.9,
                                      height: height*0.8,
                                      child: completedDetails(docId: widget.docId,celebrity:widget.celebrity),
                                    ),
                                  )
                              );
                            });
                          }

                          else if(status=="pending"){
                            showDialog(context: context, builder: (context){
                              return Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Center(
                                    child: Container(
                                      width: width*0.9,
                                      height: height*0.8,
                                      child: pendingDetails(docId: widget.docId,celebrity:widget.celebrity),
                                    ),
                                  )
                              );
                            });
                          }



                        },
                        child: Container(
                            width: width*0.3,
                            decoration: BoxDecoration(
                                color: color,
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
                                    message,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontFamily: "Avenir",
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
            return Center(
              child: Container(
                  height: 50,
                  width:50,
                  child: CircularProgressIndicator()
              ),
            );
          }

        }
    );
  }
}



class booking extends StatefulWidget {

  @override
  _bookingState createState() => _bookingState();
}

class _bookingState extends State<booking> {
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;


    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("requests").where("type",isEqualTo: "eventBooking").where("user",isEqualTo: FirebaseAuth.instance.currentUser.uid.toString()).snapshots(),
      builder: (context, snapshot) {


        if(snapshot.hasData){

          var docs=snapshot.data.docs;

          return Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: docs.length,
              itemBuilder: (context,index){
                Map data=docs[index].data();
                bool reviewed=data["reviewed"]==null?false:data["reviewed"];
                print(data);


                return bookingRow(celebrity: data["celebrity"],user: data["user"],createdAt: data["createdAt"],status: data["status"],docId: docs[index].id,);
              },
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
