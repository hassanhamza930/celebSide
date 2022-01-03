import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/orderDetails.dart';
import 'package:celebside/pages/home/featuredVideoPlayer/components/panel.dart';
import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:sliding_up_panel/sliding_up_panel.dart';




class pendingRow extends StatefulWidget {

  final amount;
  final celebrity;
  final user;
  final Timestamp createdAt;
  final status;
  final String type;
  final videoDate;
  final docId;
  final expiryDate;

  pendingRow({this.expiryDate ,@required this.amount,@required String this.docId,@required this.celebrity,@required this.user,@required this.createdAt,@required this.status,@required this.type,@required this.videoDate});
  @override
  _pendingRowState createState() => _pendingRowState();
}

class _pendingRowState extends State<pendingRow> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebrity).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasData){

          bool refund;
          DocumentSnapshot doc=snapshot.data;
          Map data=doc.data();

          // if(widget.createdAt)

          DateTime createdAt= widget.createdAt.toDate();
          DateTime expiry=widget.expiryDate.toDate();





          print(expiry);

          print("printing difference");
          print(DateTime.now().compareTo(expiry));

          if(DateTime.now().compareTo(expiry)==-1 || DateTime.now().compareTo(expiry)==0){
            refund=false;
          }
          else{
            refund=true;
          }



          return Center(
            child: Container(
              margin: EdgeInsets.only(top:10),
              width: width*0.95,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
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
                              Text(
                                "${widget.type.toString()=="dm"?"Direct Message":"Video Request"}",
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

                        if( refund==true){

                          showLoading(context: context);

                          var doc= await FirebaseFirestore.instance.collection("requests").doc(widget.docId).get();
                          var data=doc.data();
                          var docId=widget.docId;
                          var amount=data["amount"];
                          Map userData= await getUserData(id: FirebaseAuth.instance.currentUser.uid);



                          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).set(
                              {
                                "wallet": (userData["wallet"]+amount)
                              },
                              SetOptions(merge: true)
                          ).then((value)async{
                            Navigator.pop(context);
                            await addNotifications(target: "user", message: "Your ${widget.type=="dm"?"DM":"Video"} request has been refunded.", from: widget.celebrity, to: FirebaseAuth.instance.currentUser.uid, type: widget.type);
                            await addTransaction(message: "Refund", to: FirebaseAuth.instance.currentUser.uid, from: FirebaseAuth.instance.currentUser.uid, amount: widget.amount);
                            await showMessage(context: context, message: "${amount} GHS have been successfully refunded in to your wallet.");
                            FirebaseFirestore.instance.collection("requests").doc(docId).delete();
                          });





                        }
                        else{

                          showDialog(context: context, builder: (context2){
                            return Container(
                              height: height*0.7,
                              width: width,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: height*0.4,
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(24, 48, 93,1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              20
                                          )
                                      )
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: width * 0.9,
                                      child: ListView(
                                        children: [
                                          SizedBox(height: 20,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.videocam,color: Colors.white,size: 35,),
                                              SizedBox(width: 20,),
                                              Text("Pending",style: mediumBold(color: Colors.white),),

                                            ],
                                          ),
                                          SizedBox(height: 20,),
                                          Container(
                                            padding: EdgeInsets.all(20),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.orange,
                                                  width: 3,
                                                )
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Amount:",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Avenir",
                                                          fontSize: 17,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "${widget.amount} GHS",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Avenir",
                                                          fontSize: 17,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Refundable Date",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Avenir",
                                                          fontSize: 17,
                                                          color: Colors.white),
                                                    ),
                                                    AutoSizeText(
                                                      "${expiry.toString().split(" ")[0]}",
                                                      maxLines: 1,
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily: "Avenir",
                                                          fontSize: 17,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20,),
                                          authButton(text: "Okay", color: Colors.white, bg: Colors.orange, onPress: (){
                                            Navigator.pop(context);
                                          }, context: context),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });

                        }

                      },
                      child: Container(
                          width: width*0.3,
                          decoration: BoxDecoration(
                              color: refund==true?Colors.red:Color.fromRGBO(24, 47, 91, 1),
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          margin: EdgeInsets.only(left: 10),
                          padding:EdgeInsets.only(top:7,bottom: 7,left: 7,right: 7),
                          // padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(widget.type=="dm"?Icons.message:Icons.videocam_sharp,color: Colors.white,),
                              SizedBox(width: 5,),
                              refund==true?
                              Flexible(child: AutoSizeText("Refund",maxLines: 1,style: small(color: Colors.white,size: 14),),):
                              Flexible(
                                child: AutoSizeText(
                                  widget.status=="pending"||widget.status=="filtered"?"Pending":"",
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





class pending extends StatefulWidget {

  @override
  _pendingState createState() => _pendingState();
}

class _pendingState extends State<pending> {
  @override
  Widget build(BuildContext context) {


    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;


    return Align(
      alignment: Alignment.topCenter,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("requests").where("user",isEqualTo: FirebaseAuth.instance.currentUser.uid.toString()).where("type",isNotEqualTo:"eventBooking").where("status",isEqualTo: "pending").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<DocumentSnapshot> docs= snapshot.data.docs;
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: docs.length,
              itemBuilder: (context,index){
                Map data=docs[index].data();

                return pendingRow(
                    amount:data["amount"],
                    celebrity: data["celebrity"],
                    user: data["user"],
                    createdAt: data["createdAt"],
                    expiryDate: data["expiryDate"],
                    status: data["status"],
                    type: data["type"],
                    videoDate:data["videoDate"],
                    docId:docs[index].id
                );
              },
            );
          }
          else{
            return Container();
          }
        }
      ),
    );
  }
}
