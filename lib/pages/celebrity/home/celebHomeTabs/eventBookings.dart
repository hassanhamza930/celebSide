import 'package:celebside/pages/celebrity/home/requestTabs/seeLocation.dart';
import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


class celebHomePageEventBookingRequestsRow extends StatefulWidget {
  final Map data;
  final String id;
  celebHomePageEventBookingRequestsRow({@required this.data,@required this.id});

  @override
  _celebHomePageEventBookingRequestsRowState createState() => _celebHomePageEventBookingRequestsRowState();
}

class _celebHomePageEventBookingRequestsRowState extends State<celebHomePageEventBookingRequestsRow> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(bottom: 20),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(widget.data["user"]).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              Map userData=snapshot.data.data();

              return Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
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
                              radius: 30,
                              backgroundImage: NetworkImage("${userData["imgSrc"]}"),
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
                                  "${widget.data["createdAt"].toDate().toString().split(" ")[0]}",
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
                                  Icons.book,
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
                              "${widget.data["fullName"]}",
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
                              "${widget.data["organization"]}",
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
                            Flexible(
                              child: Text(
                                "${widget.data["bookingTypes"].toString().substring(1,widget.data["bookingTypes"].toString().indexOf("]"))}",
                                style: small(color: Colors.orange,size: 14),
                                textAlign: TextAlign.right,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Booking Reason",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Flexible(
                              child: Text(
                                "${widget.data["bookingReasons"].toString().substring(1,widget.data["bookingReasons"].toString().indexOf("]"))}",
                                style: small(color: Colors.orange,size: 14),
                                textAlign: TextAlign.right,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Appearance Duration",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Flexible(
                              child: Text(
                                "${widget.data["appearanceHours"]} hours, ${widget.data["appearanceMinutes"]} minutes",
                                style: small(color: Colors.orange,size: 14),
                                textAlign: TextAlign.right,
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
                              "${widget.data["private"]==true?"Private":"Public"}",
                              style: small(color: Colors.orange,size: 14),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Budget",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Text(
                              "¢${ double.parse('${widget.data["quotation"]}').floor() }",
                              style: small(color: Colors.orange,size: 14),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Text(
                              "${widget.data["date"].toDate().toString().split(" ")[0]}",
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
                              "${widget.data["timeStart"]} ${widget.data["startFormat"]}",
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
                              "${widget.data["timeEnd"]} ${widget.data["endFormat"]}",
                              style: small(color: Colors.orange,size: 14),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Venue",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Text(
                              "${widget.data["venueName"]}",
                              style: small(color: Colors.orange,size: 14),
                            )
                          ],
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       "Location GPS",
                        //       style: TextStyle(
                        //           fontFamily: "Avenir",
                        //           fontSize: 14,
                        //           color: Colors.black),
                        //     ),
                        //     Text(
                        //       "GPS 12321-82",
                        //       style: small(color: Colors.orange,size: 14),
                        //     )
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Number Guest",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Text(
                              "${widget.data["numberOfGuests"]}",
                              style: small(color: Colors.orange,size: 14),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Reason for appearance",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Text(
                              "${widget.data["reasonForAppearance"]}",
                              style: small(color: Colors.orange,size: 14),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                "Any other engagements",
                                style: TextStyle(
                                    fontFamily: "Avenir",
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "${widget.data["anyOtherEngagements"]}",
                                style: small(color: Colors.orange,size: 14),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        authButton(text: "See Location", color: Colors.white, bg: Colors.orange, onPress: (){
                          Navigator.push(context, CupertinoPageRoute(builder: (context){
                            return seeLocation(loc_x: widget.data["loc_x"],loc_y:widget.data["loc_y"]);
                          }));
                        }, context: context),
                        SizedBox(height: 20,),
                        Divider(height: 2,thickness: 2,color: Colors.black12,),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: ()async{
                                await FirebaseFirestore.instance.collection("requests").doc(widget.id).set({"filtered":true},SetOptions(merge: true));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(Radius.circular(20))),
                                width: MediaQuery.of(context).size.width * 0.4,
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
                              onPressed: () async{
                                await FirebaseFirestore.instance.collection("requests").doc(widget.id).delete();
                                await addNotifications(target: "user", message: "Your Event Booking Request was rejected.", from: FirebaseAuth.instance.currentUser.uid, to: widget.data["user"], type: "eventBooking");
                              },
                              mini: true,
                              backgroundColor: Colors.black.withOpacity(0.2),
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
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
      ),
    );
  }
}






class eventBookings extends StatefulWidget {
  @override
  _eventBookingsState createState() => _eventBookingsState();
}

class _eventBookingsState extends State<eventBookings> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("type",isEqualTo: "eventBooking").where("status",isEqualTo: "pending").where("filtered",isEqualTo: false).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            QuerySnapshot doc=snapshot.data;
            List<DocumentSnapshot> docs=doc.docs;

            return Container(
              margin: EdgeInsets.only(bottom: 50),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot indivisualDoc=docs[index];
                    Map data=indivisualDoc.data();

                    return celebHomePageEventBookingRequestsRow(data: data, id: indivisualDoc.id);
                  }),
            );
          }
          else{
            return Container();
          }
        }
    );

  }
}
