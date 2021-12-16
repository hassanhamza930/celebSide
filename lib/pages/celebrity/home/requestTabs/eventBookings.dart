import 'package:celebside/pages/celebrity/home/requestTabs/seeLocation.dart';
import 'package:celebside/pages/home/celebrityProfile/sendMessage/celebrityChat.dart';
import 'package:celebside/pages/home/requests/booking.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";




var hidden=true;









class eventBookingRow extends StatefulWidget {
  final bool completed;
  final Map data;
  final docId;
  eventBookingRow({this.completed,this.data,this.docId});

  @override
  _eventBookingRowState createState() => _eventBookingRowState();
}

class _eventBookingRowState extends State<eventBookingRow> {
  var finalBookingFee=TextEditingController(text: "");
  var message=TextEditingController(text: "");


  @override
  Widget build(BuildContext context) {

    var data=widget.data;

      return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(data["user"]).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            Map userData=snapshot.data.data();
            return Center(
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.black38,offset: Offset(0,2),blurRadius: 2)],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.45),
                      width: 1,
                    )
                ),
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width * 0.85,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            child: Center(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage("${userData["imgSrc"]}"),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${userData["fullName"]}",
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                "${data["createdAt"].toDate().toString().split(" ")[0]}",
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${data["eventDescription"]}",
                        style: TextStyle(
                          fontFamily: "Avenir",
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Request For",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          SizedBox(width: 10,),
                          Row(
                            children: [
                              Icon(
                                Icons.message,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 5,),
                              Text(
                                "Event Booking",
                                style: TextStyle(
                                    fontFamily: "Avenir",
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          )
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Full Name",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            "${userData["fullName"]}",
                            style: small(color: Colors.orange,size: 14),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Company/Registration",
                              style: small(color: Colors.black,size: 14),
                            ),
                          ),
                          Text(
                            "${data["organization"]}",
                            style: small(color: Colors.orange,size: 14),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Booking Type",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            "${ data["bookingTypes"].toString().split("[")[1].split("]")[0] }",
                            style: small(color: Colors.orange,size: 14),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Booking Reason",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Text(
                                "${ data["bookingReasons"].toString().split("[")[1].split("]")[0] }",
                              style: small(color: Colors.orange,size: 14),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Appearance Duration",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "${data["appearanceHours"]} Hours and ${data["appearanceMinutes"]} Mins",
                              style: small(color: Colors.orange,size: 14),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Private or Public Event",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            "Private",
                            style: small(color: Colors.orange,size: 14),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time Start",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            "${data["timeStart"]} ${data["startFormat"]} ",
                            style: small(color: Colors.orange,size: 14),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time End",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            "${data["timeEnd"]} ${data["endFormat"]} ",
                            style: small(color: Colors.orange,size: 14),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Guests",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            "${data["numberOfGuests"]}  ",
                            style: small(color: Colors.orange,size: 14),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Date",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "${data["date"].toDate().toString().split(" ")[0]}",
                              style: small(color: Colors.orange,size: 14),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Venue Name",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Text(
                            "${data["venueName"]}",
                            style: small(color: Colors.orange,size: 14),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "Budget",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "¢${data["quotation"]}",
                              style: small(color: Colors.orange,size: 14),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      Divider(
                        thickness: 2,
                      ),
                      SizedBox(height: 10,),
                      authButton(text: "See Location", color: Colors.white, bg: Colors.orange, onPress: (){
                        Navigator.push(context, CupertinoPageRoute(builder: (context){
                          return seeLocation(loc_x: data["loc_x"],loc_y:data["loc_y"]);
                        }));
                      }, context: context),
                      SizedBox(height: 10,),
                      widget.completed==false?
                      Container(
                        padding: EdgeInsets.all(3),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius:
                            BorderRadius.all(Radius.circular(18.0))),
                        child: Center(
                          child: TextField(
                            controller: finalBookingFee,
                            style: small(color: Colors.black),
                            decoration: InputDecoration(
                              labelText: "Final Booking Fee",
                              labelStyle: small(color: Colors.black,size: 14),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding:
                              EdgeInsetsDirectional.only(start: 20),
                            ),
                            onChanged: (e)=>{},
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ):Container(),
                      SizedBox(height: 10,),
                      widget.completed==false?Container(
                        height: 150,
                        padding: EdgeInsets.all(3),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius:
                            BorderRadius.all(Radius.circular(24.0))),
                        child: Center(
                          child: TextField(
                            controller: message,
                            minLines: 4,
                            maxLines: 99999,
                            style: small(color: Colors.black,size: 14),
                            decoration: InputDecoration(
                              labelText: "Anything you would like to tell the booker",
                              labelStyle: small(color: Colors.black,size: 12),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsetsDirectional.only(start: 20,end: 20),
                            ),
                            onChanged: (e)=>{},
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ):Container(),
                      SizedBox(height: 20,),
                      widget.completed==false?Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: ()async{

                                if(finalBookingFee.text!="" && message.text!=""){
                                  print('accepted');

                                  showLoading(context: context);


                                    FirebaseFirestore.instance.collection("requests").doc(widget.docId).set(
                                        {
                                          "status":"offered",
                                          "quotation":double.parse(finalBookingFee.text),
                                          "celebrityMessage":message.text,
                                        },
                                        SetOptions(merge: true)
                                    );


                                  Navigator.pop(context);

                                }
                                else{
                                  showErrorDialogue(context: context, message: "Kindly Fill All Details");
                                }



                              },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.all(Radius.circular(20))),
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Center(
                                child: Text(
                                  "Accept",
                                  style: smallBold(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          FloatingActionButton(
                            heroTag: DateTime.now().toString(),
                            elevation: 0,
                            onPressed: ()async {

                              showLoading(context: context);


                              FirebaseFirestore.instance.collection("requests").doc(widget.docId).set(
                                  {
                                    "status":"rejected",
                                  },
                                  SetOptions(merge: true)
                              );


                              Navigator.pop(context);

                            },
                            mini: true,
                            backgroundColor: Colors.black.withOpacity(0.2),
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          )
                        ],
                      ):Container(),
                    ],
                  ),
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







class eventBookings extends StatefulWidget {
  eventBookings({this.completed});
  final completed;

  @override
  _eventBookingsState createState() => _eventBookingsState();
}

class _eventBookingsState extends State<eventBookings> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("type",isEqualTo: "eventBooking").where("status",isEqualTo: widget.completed==true?"accepted":"pending").where("filtered",isEqualTo: true).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasData){
          var data=snapshot.data;
          List docs=data.docs;



          return ListView(
            shrinkWrap: true,
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: docs.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  var currentDoc= docs[index];
                  var data=currentDoc.data();
                  return Container(
                    margin: EdgeInsets.only(top: 20,bottom: 50),
                      child: eventBookingRow(completed:widget.completed,docId: currentDoc.id,data: currentDoc.data(),)
                  );
                },

              ),
              SizedBox(height: 300,)
            ],
          );
        }

        else{
          return Container();
        }


      }
    );
  }
}
