import 'dart:async';
import 'dart:convert';

import 'package:celebside/pages/celebrity/home/createOffer/customizeEventBookings.dart';
import 'package:celebside/pages/home/celebrityProfile/bookEvent/maps.dart';
import 'package:celebside/pages/home/celebrityProfile/components.dart';
import 'package:celebside/pages/home/celebrityProfile/howRefundsWork/howRefundsWork2.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/paymentSuccessful.dart';
import 'package:celebside/pages/home/celebrityProfile/requestVideo/requestVideo.dart';
import 'package:celebside/pages/home/celebrityProfile/sendMessage/celebrityChat.dart';
import 'package:celebside/pages/home/featuredVideoPlayer/fanClub.dart';
import 'package:celebside/pages/home/home.dart' as Home;
import 'package:celebside/pages/home/videoPlayer/videoPlayer.dart';
import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/services/addRequest.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:duration_picker_dialog_box/duration_picker_dialog_box.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_dropdown/multiple_dropdown.dart';
import 'package:multiselect_dropdown/multiple_select.dart';
import 'package:http/http.dart' as http;


LatLng currentLoc=LatLng(37.42796133580664, -122.085749655962);
var markerList=[ Marker(draggable: true,position: currentLoc,markerId: MarkerId("${currentLoc.toString()}") ) ];
Completer<GoogleMapController> controller = Completer();

CameraPosition kGooglePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);


DateTime date= DateTime.now();
var dobDisplay = 'Date of the event.';
List bookingType=[];
List bookingPurpose=[];
var startFormat = "AM";
var endFormat = "AM";
var country="Ghana";
var countryCode="+233";
bool privateEvent=false;
bool publicEvent=false;
bool liveAppearance=false;
bool virtualEvent=false;


var fullName=TextEditingController(text:"");
var phoneNumber=TextEditingController(text:"");
var email=TextEditingController(text:"");
var organization=TextEditingController(text:"");
var eventDescription=TextEditingController(text:"");
var timeFrom=TextEditingController(text:"");
var timeTo=TextEditingController(text:"");
var appearanceHours=TextEditingController(text:"");
var appearanceMinutes=TextEditingController(text:"");
var venueName=TextEditingController(text:"");
var numberOfGuests=TextEditingController(text:"");
var reasonForAppearance=TextEditingController(text:"");
var anyOtherEngagements=TextEditingController(text:"");
var quotation=TextEditingController(text:"");



class bookEvent extends StatefulWidget {

  final String celebrity;
  bookEvent({this.celebrity});

  @override
  _bookEventState createState() => _bookEventState();
}

class _bookEventState extends State<bookEvent> {


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
          Image.asset(
          "assets/bluebackground.png",
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebrity).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              Map data=snapshot.data.data();

              return Center(
                child: Container(
                  width: width * 0.9,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          width: width * 0.9,
                          child: Text(
                            "Event Booking",
                            textAlign: TextAlign.left,
                            style: medium(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    "${data["imgSrc"]}",
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "From: ${data["fullName"]}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "AvenirBold",
                                          fontSize: 22),
                                    ),
                                    Text(
                                      "usually responds in ${data["eventBooking"]["responseTime"]} days",
                                      textAlign: TextAlign.left,
                                      style: small(color: Colors.orange),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      inputField(
                          label: "Full Name", context: context, onChange: (e) {},controller: fullName),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.all(Radius.circular(24.0))),
                        child: Row(
                          children: [
                            CountryCodePicker(
                              initialSelection: "${country}",
                              textStyle: small(color: Colors.white),
                              onChanged: (code){
                                country=code.name;
                                countryCode=code.dialCode;
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: TextField(
                                maxLength: 10,
                                controller: phoneNumber,
                                style: small(color: Colors.white),
                                decoration: InputDecoration(
                                  counterText: "",
                                  labelStyle: small(color: Colors.white),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  contentPadding:
                                  EdgeInsetsDirectional.only(start: 20),
                                ),
                                onChanged: (e) {},
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      inputField(
                          label: "Email", context: context, onChange: (e) {},
                        controller: email
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      inputField(
                          label: "Company or Organization",
                          context: context,
                          onChange: (e) {},
                          controller: organization
                          ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: width*0.85,
                          child: MultipleDropDown(
                              placeholder: "Booking Type",
                              values: bookingType,
                              elements:
                              [
                                "Walkthrough",
                                "Appearances",
                                "Hosting",
                                "Speaking",
                                "Performance",
                              ].map((String value) {
                                return MultipleSelectItem.build(value: value, display: value, content: value);
                              }).toList(),
                              // [
                              //   MultipleSelectItem.build(value: "TikToker", display: "TikToker", content:"TikToker"),
                              //   MultipleSelectItem.build(value: "Musician", display: "Musician", content:"Musician"),
                              //   MultipleSelectItem.build(value: "Actor", display: "Actor", content: "Actor"),
                              //   MultipleSelectItem.build(value: "Youtuber", display: "Youtuber", content: "Youtuber"),
                              //   MultipleSelectItem.build(value: "Facebook", display: "Facebook", content: "Facebook"),
                              // ]
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          width: width*0.85,
                          child: MultipleDropDown(
                            placeholder: "What is this booking for?",
                            values: bookingPurpose,
                            elements:
                            [
                              "Wedding",
                              "Private Party",
                              "Night Club",
                              "Corporate Event",
                              "Graduation",
                              "Convention",
                              "Tradeshow",
                              "Fair or Festival",
                              "Fundraising Event",
                              "Public Event",
                              "TV/Movie/Radio/Webcast"
                            ].map((String value) {
                              return MultipleSelectItem.build(value: value, display: value, content: value);
                            }).toList(),
                            // [
                            //   MultipleSelectItem.build(value: "TikToker", display: "TikToker", content:"TikToker"),
                            //   MultipleSelectItem.build(value: "Musician", display: "Musician", content:"Musician"),
                            //   MultipleSelectItem.build(value: "Actor", display: "Actor", content: "Actor"),
                            //   MultipleSelectItem.build(value: "Youtuber", display: "Youtuber", content: "Youtuber"),
                            //   MultipleSelectItem.build(value: "Facebook", display: "Facebook", content: "Facebook"),
                            // ]
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      inputFieldExpanded(
                          label: "Describe the Event",
                          context: context,
                          onChange: (e) {},
                          controller: eventDescription,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              showTitleActions: true,
                              minTime: DateTime(1960, 1, 1),
                              maxTime: DateTime(2021, 8, 20), onChanged: (date) {
                                print('change $date');
                              }, onConfirm: (dat) {
                                setState(() {
                                  date=dat;
                                  dobDisplay = dat.toIso8601String().split("T")[0].toString();
                                });
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.all(Radius.circular(24.0))),
                          child: Center(
                            child: TextField(
                              enabled: false,
                              style: small(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "${dobDisplay}",
                                labelStyle: small(color: Colors.white),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsetsDirectional.only(start: 20),
                              ),
                              onChanged: (e) => {},
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(
                          "Time",
                          style: smallBold(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.5,
                            child: inputField(
                                label: "From", context: context, onChange: (e) {},controller: timeFrom,numeric: true),
                          ),
                          Container(
                            width: width * 0.25,
                            padding: EdgeInsets.only(
                                left: 20, top: 3, bottom: 3, right: 20),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius:
                                BorderRadius.all(Radius.circular(24.0))),
                            child: DropdownButton<String>(
                              value: startFormat,
                              style: small(color: Colors.white),
                              dropdownColor: Colors.black,
                              onChanged: (String newValue) {
                                setState(() {
                                  startFormat = newValue;
                                });
                              },
                              hint: Text(
                                "AM",
                                style: small(color: Colors.white),
                              ),
                              items: <String>["AM", "PM"]
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    //style: small(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.5,
                            child: inputField(
                                label: "To", context: context, onChange: (e) {},controller: timeTo,numeric: true),
                          ),
                          Container(
                            width: width * 0.25,
                            padding: EdgeInsets.only(
                                left: 20, top: 3, bottom: 3, right: 20),
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius:
                                BorderRadius.all(Radius.circular(24.0))),
                            child: DropdownButton<String>(
                              value: endFormat,
                              style: small(color: Colors.white),
                              dropdownColor: Colors.black,
                              onChanged: (String newValue) {
                                setState(() {
                                  endFormat = newValue;
                                });
                              },
                              hint: Text(
                                "AM",
                                style: small(color: Colors.white),
                              ),
                              items: <String>["AM", "PM"]
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    //style: small(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: (){
                          showDialog(context: context, builder: (context){
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)
                                      )
                                  ),
                                  padding: EdgeInsets.all(20),
                                  height: height*0.5,
                                  width: width*0.8,
                                  child: Center(
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          width: MediaQuery.of(context).size.width * 0.9,
                                          decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.3),
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(18.0))),
                                          child: Center(
                                            child: TextField(
                                              controller: appearanceHours,
                                              style: small(color: Colors.white),
                                              decoration: InputDecoration(
                                                labelText: "Hours",
                                                labelStyle: small(color: Colors.white),
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                contentPadding:
                                                EdgeInsetsDirectional.only(start: 20),
                                              ),
                                              onChanged: (e)=>{},
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          width: MediaQuery.of(context).size.width * 0.9,
                                          decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.3),
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(18.0))),
                                          child: Center(
                                            child: TextField(
                                              controller: appearanceMinutes,
                                              style: small(color: Colors.white),
                                              decoration: InputDecoration(
                                                labelText: "Minutes",
                                                labelStyle: small(color: Colors.white),
                                                focusedBorder: InputBorder.none,
                                                enabledBorder: InputBorder.none,
                                                contentPadding:
                                                EdgeInsetsDirectional.only(start: 20),
                                              ),
                                              onChanged: (e)=>{},
                                              keyboardType: TextInputType.number,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 30,),
                                        authButton(text: "Done", color: Colors.white, bg: Colors.orange, onPress: (){


                                          if(appearanceMinutes.text!="" && appearanceHours.text!=""){
                                            Navigator.pop(context);
                                            setState(() {

                                            });
                                          }
                                          else{
                                            showErrorDialogue(context: context, message: "Kindly fill all fields.");
                                          }



                                        }, context: context)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.all(Radius.circular(18.0))),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                (appearanceHours.text!="" && appearanceMinutes.text!="")?"${appearanceHours.text} hours and ${appearanceMinutes.text} minutes":"Appearance Duration",style: small(color: Colors.white),
                              )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      inputField(
                          label: "Venue Name", context: context, onChange: (e) {},controller: venueName),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: (){
                        },
                        child:Container(
                          padding: EdgeInsets.all(3),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius:
                              BorderRadius.all(Radius.circular(18.0))),
                          child: Center(
                            child: TextField(
                              onTap: (){



                                print("soorat");


                                Navigator.push(context, CupertinoPageRoute(builder: (context){
                                  return maps();
                                }));


                              },
                              enabled: true,
                              readOnly: true,
                              style: small(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "GPS Cordinates",
                                hintText: markerList[0].position.toString(),
                                hintStyle: small(color: Colors.white,size: 14),
                                labelStyle: small(color: Colors.white),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding:
                                EdgeInsetsDirectional.only(start: 20),
                              ),
                              onChanged: (e)=>{},
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Private Event",
                                style: smallBold(color: Colors.white),
                              ),
                              Checkbox(
                                value: privateEvent,
                                onChanged: (e) {
                                  setState(() {
                                    privateEvent=e;
                                    publicEvent=false;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Public Event",
                                style: smallBold(color: Colors.white),
                              ),
                              Checkbox(
                                value: publicEvent,
                                onChanged: (e) {
                                  setState(() {
                                    publicEvent=e;
                                    privateEvent=false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Live Appearance",
                                style: smallBold(color: Colors.white),
                              ),
                              Checkbox(
                                value: liveAppearance,
                                onChanged: (e) {
                                  setState(() {
                                    liveAppearance=e;
                                    virtualEvent=false;
                                  });
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Virtual Event",
                                style: smallBold(color: Colors.white),
                              ),
                              Checkbox(
                                value: virtualEvent,
                                onChanged: (e) {
                                  setState(() {
                                    virtualEvent=e;
                                    liveAppearance=false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      inputField(
                          label: "Number of Guests",
                          context: context,
                          onChange: (e) {},
                          controller: numberOfGuests,
                          numeric: true
                      ),
                      SizedBox(height: 20),
                      inputFieldExpanded(
                          label: "Reason for appearance",
                          context: context,
                          onChange: (e) {},
                          controller: reasonForAppearance
                      ),
                      SizedBox(height: 20),
                      inputFieldExpanded(
                          label: "Any other engagements",
                          context: context,
                          onChange: (e) {},
                          controller: anyOtherEngagements
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 10, bottom: 10),
                        child: Text(
                          "Quotation",
                          style: smallBold(color: Colors.white),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.9,
                            child: inputField(
                                label: "GHS", context: context, onChange: (e) {},controller: quotation,numeric: true),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: width * 0.8,
                        child: GestureDetector(
                          onTap: ()async{

                            if(
                            fullName.text != "" &&
                            phoneNumber.text != ""  &&
                            email.text != ""
                            && organization.text != ""
                            && bookingType.length!=0
                            && bookingPurpose.length!=0
                            && eventDescription.text !=""
                                && dobDisplay!= ""
                                &&timeFrom.text!= ""
                                &&timeTo.text != ""
                                &&appearanceHours.text!=""
                                &&appearanceMinutes.text !=""
                                &&venueName.text!=""
                                &&numberOfGuests.text!=""
                                &&reasonForAppearance.text!=""
                                &&anyOtherEngagements.text !=""
                                && quotation.text!=""
                            ){

                              showLoading(context: context);

                              var checkRequestResponse = await checkRequest(context: context, celebrityId: widget.celebrity, userId: FirebaseAuth.instance.currentUser.uid.toString(), type: "eventBooking");

                              if(checkRequestResponse!="error"){

                                Map userData=await getUserData(id: FirebaseAuth.instance.currentUser.uid);
                                await addNotifications(target: "celebrities", message: "${userData["fullName"]} has requested an event booking.}", from: FirebaseAuth.instance.currentUser.uid, to: widget.celebrity, type: "eventBooking");
                                var res=await addBookingRequest(
                                    context: context,
                                    celebrityId: widget.celebrity,
                                    userId: FirebaseAuth.instance.currentUser.uid,
                                    type: "eventBooking",
                                    amount: double.parse(quotation.text),
                                    fullName: fullName.text,
                                    country: country,
                                    countryCode: countryCode,
                                    phoneNumber: phoneNumber.text,
                                    email: email.text,
                                    organization: organization.text,
                                    bookingTypes: bookingType,
                                    bookingReasons: bookingPurpose,
                                    eventDescription: eventDescription.text,
                                    date: date,
                                    loc_x: markerList[0].position.latitude,
                                    loc_y: markerList[0].position.longitude,
                                    timeStart: timeFrom.text,
                                    timeEnd: timeTo.text,
                                    startFormat: startFormat,
                                    endFormat: endFormat,
                                    appearanceHours: appearanceHours.text,
                                    appearanceMinutes: appearanceMinutes.text,
                                    venueName: venueName.text,
                                    privateEvent: privateEvent,
                                    publicEvent: publicEvent,
                                    liveAppearance: liveAppearance,
                                    virtualEvent: virtualEvent,
                                    numberOfGuests: numberOfGuests.text,
                                    reasonForAppearance: reasonForAppearance.text,
                                    anyOtherEngagements: anyOtherEngagements.text,
                                    quotation: quotation.text
                                );

                                if(res=="error"){
                                  showErrorDialogue(context: context, message: "errora");
                                }
                                else{
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }


                              }
                              else{
                                Navigator.pop(context);
                                showErrorDialogue(context: context, message: "You already have a pending request for this celebrity.");

                              }
                            }
                            else{
                              showMessage(context: context, message: "Kindly fill all details.");

                            }




                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: Colors.orange),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  FontAwesomeIcons.calendarCheck,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Submit Request",
                                    textAlign: TextAlign.center,
                                    style: smallBold(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                                return howRefundsWork2();
                              }));
                        },
                        child: Center(
                          child: Container(
                            width: width * 0.85,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.orange,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "How do refunds work",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Avenir",
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 160,
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
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: EdgeInsets.only(left: 20, top: 40),
            alignment: Alignment.topLeft,
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          height: height,
          width: width,
          child: Container(
            height: 70,
            padding: EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 10),
            color: Color.fromRGBO(24, 48, 93, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      print("one");
                      setState(() {
                        currentTab = 0;
                      });
                      Navigator.pushReplacement(context,
                          CupertinoPageRoute(builder: (context) {
                        return Home.Home();
                      }));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  currentTab == 0?
                                       Colors.orange
                                      : Colors.white,
                                  BlendMode.srcATop),
                              child: Image.asset(
                                "assets/bottom bar/simple/1.png",
                                fit: BoxFit.contain,
                                height: 25,
                              )),
                          Text(
                            "Home",
                            style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 12,
                              color: currentTab == 0?
                                   Colors.orange
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      print("one");
                      setState(() {
                        currentTab = 1;
                      });
                      Navigator.pushReplacement(context,
                          CupertinoPageRoute(builder: (context) {
                        return Home.Home();
                      }));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  currentTab == 1?
                                       Colors.orange
                                      : Colors.white,
                                  BlendMode.srcATop),
                              child: Image.asset(
                                "assets/bottom bar/simple/2.png",
                                fit: BoxFit.contain,
                                height: 25,
                              )),
                          Text(
                            "Requests",
                            style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 12,
                              color: currentTab == 1?
                                   Colors.orange
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      print("one");
                      setState(() {
                        currentTab = 2;
                      });
                      Navigator.pushReplacement(context,
                          CupertinoPageRoute(builder: (context) {
                        return Home.Home();
                      }));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  currentTab == 2?
                                       Colors.orange
                                      : Colors.white,
                                  BlendMode.srcATop),
                              child: Image.asset(
                                "assets/bottom bar/simple/3.png",
                                fit: BoxFit.contain,
                                height: 25,
                              )),
                          Text(
                            "Notifications",
                            style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 12,
                              color: currentTab == 2?
                                   Colors.orange
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      print("one");
                      setState(() {
                        currentTab = 3;
                      });
                      Navigator.pushReplacement(context,
                          CupertinoPageRoute(builder: (context) {
                        return Home.Home();
                      }));
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  currentTab == 3?
                                       Colors.orange
                                      : Colors.white,
                                  BlendMode.srcATop),
                              child: Image.asset(
                                "assets/bottom bar/simple/4.png",
                                fit: BoxFit.contain,
                                height: 25,
                              )),
                          Text(
                            "Profile",
                            style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 12,
                              color: currentTab == 3?
                                   Colors.orange
                                  : Colors.white,
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ])),
    );
  }
}
