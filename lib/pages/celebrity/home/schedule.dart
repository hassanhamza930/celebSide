import 'package:celebside/pages/celebrity/home/celebrityHome.dart';
import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class bookingCard extends StatefulWidget {
  final Map data;
  final String docId;

  bookingCard({this.data,this.docId});

  @override
  _bookingCardState createState() => _bookingCardState();
}

class _bookingCardState extends State<bookingCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var data=widget.data;

    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                color: Colors.black
            )
        ),
        width: width*0.9,
        // color: Colors.black,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text("${data["fullName"]}",style: small(color: Colors.black,size: 14),)),
                // Flexible(child: FaIcon(FontAwesomeIcons.pencilAlt,size: 14,))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("${data["timeStart"]} pm - ${data["timeEnd"]} pm",style: small(color: Colors.black38,size: 14),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Date  ${data["date"].toDate().toString().split(" ")[0]}",style: small(color: Colors.black38,size: 14),),
              ],
            ),
            SizedBox(height: 5,),
            Divider(height: 1,thickness:1,color: Colors.black12,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: ()async{



                    Map reqData=widget.data;
                    String reqId=widget.docId;
                    String user=widget.data["user"];

                    await FirebaseFirestore.instance.collection("requests")
                        .doc(reqId)
                        .set(
                        {
                          "status":"refunded"
                        },
                        SetOptions(merge:true)
                    );


                    Map userData=await getUserData(id: user);
                    Map celebData=await getCelebrityData(id: FirebaseAuth.instance.currentUser.uid);

                    userData["wallet"]+=reqData["amount"];



                    await FirebaseFirestore.instance
                    .collection("users")
                    .doc(user)
                    .set(
                      {
                        "wallet":userData["wallet"]
                      },
                      SetOptions(merge: true)
                    );



                    await addNotifications(target: "user", message: "Your Event Booking was cancelled by ${celebData["fullName"]}. ${double.parse("${reqData["amount"]}").floorToDouble()} GHS have been refunded.", from: FirebaseAuth.instance.currentUser.uid , to: user, type: "eventBooking");
                    await addTransaction(message: "Refund", to: user, from: user, amount: reqData["amount"]);




                  },
                  child: Container(
                      padding: EdgeInsets.only(top:10,bottom: 10,left:40,right:40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: Colors.black12
                          )
                      ),
                      child: Text("Cancel",style: small(color: Colors.deepPurple),)
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.only(top:10,bottom: 10,left:40,right:40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                              color: Colors.black12
                          )
                      ),
                      child: Text("Go to",style: small(color: Colors.red),)
                  ),
                ),
              ],
            ),
          ],

        ),
      ),
    );
  }
}





class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}



List<Meeting>_getDataSource(){
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 45, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 1,minutes: 45));
  meetings.add(Meeting('Event Booking', startTime, endTime, Color.fromRGBO(24, 48, 93, 1), false));
  meetings.add(Meeting('Event Booking', startTime, endTime.add(Duration(hours: 2)), Color.fromRGBO(24, 48, 93, 1), false));
  meetings.add(Meeting('Event Booking', startTime, endTime, Color.fromRGBO(24, 48, 93, 1), false));
  return meetings;
}


class schedule extends StatefulWidget {
  @override
  _scheduleState createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;




    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                color: Colors.black,
                height: height,
                width: width,
                child: Image.asset(
                  "assets/bluebackground.png",
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("type",isEqualTo: "eventBooking").where("status",isEqualTo: "complete").snapshots(),
              builder: (context, snapshot) {

                if(snapshot.hasData){
                  var data=snapshot.data;
                  List docs=data.docs;

                  List<Meeting> meetings=[];

                  docs.forEach((element) {

                    DateTime date=element["date"].toDate();
                    String hour;
                    if(element["startFormat"]=="AM"){
                      hour="0${element["timeStart"]}";
                    }
                    else{
                      hour="${12+int.parse("${element["timeStart"]}")}";
                    }



                    // "2012-02-27 13:27:00"

                    date=DateTime.parse("${date.year}-${date.month<10?"0"+date.month.toString():date.month}-${date.day<10?"0"+date.day.toString():date.day} $hour:00:00");

                    String hour2;
                    if(element["endFormat"]=="AM"){
                      hour2="0${element["timeEnd"]}";
                    }
                    else{
                      hour2="${12+int.parse("${element["timeEnd"]}")}";
                    }


                    DateTime dateEnd= DateTime.parse("${date.year}-${date.month<10?"0"+date.month.toString():date.month}-${date.day<10?"0"+date.day.toString():date.day} $hour2:00:00");
                    

                    meetings.add(
                      Meeting("${element["fullName"]}", date , dateEnd, Colors.orange, false)
                    );
                  });


                  return Center(
                    child: Container(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Schedule',
                            style: mediumBold(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40,),
                          Center(
                            child: Container(
                                color: Colors.white,
                                width: width*0.95,
                                height: height*0.5,
                                child: SfCalendar(
                                    onTap: (e){
                                      Meeting a=e.appointments[0];
                                    },
                                    view:CalendarView.week,
                                    dataSource: MeetingDataSource(meetings)
                                )
                            ),
                          ),
                          SizedBox(height: 20,),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Colors.white
                              ),
                              margin:EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              child: ListView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("All Pending Requests",style: small(color: Colors.black),),
                                      // Icon(Icons.add,color: Colors.purple,)
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  ListView.builder(
                                    shrinkWrap: true,
                                      itemCount: docs.length,
                                      itemBuilder: (context,index){
                                        return bookingCard(docId: docs[index].id,data: docs[index].data(),);
                                      }
                                      ),
                                  SizedBox(
                                    height: 30,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
                else{
                  return Container();
                }

              }
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                  child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 20),
                      width: width,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ))),
            ),
          ],
        ),
      ),
    );
  }
}
