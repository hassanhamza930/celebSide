import 'dart:convert';

import 'package:celebside/pages/home/celebrityProfile/howRefundsWork/howRefundsWork2.dart';
import 'package:celebside/pages/home/home.dart';
import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/services/addRequest.dart';
import 'package:celebside/services/addToWallet.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/services/checkPromoCode.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multiselect_dropdown/multiple_dropdown.dart';
import 'package:multiselect_dropdown/multiple_select.dart';
import "package:http/http.dart" as http;
import 'package:flutter/cupertino.dart';

class bookingDetails extends StatefulWidget {

  final String docId;
  final String celebrity;
  bookingDetails({@required this.docId,@required this.celebrity});

  @override
  _bookingDetailsState createState() => _bookingDetailsState();
}

class _bookingDetailsState extends State<bookingDetails> {
  DateTime date= DateTime.now();
  var dobDisplay = 'Enter your date of birth';
  List bookingType=[];
  List bookingPurpose=[];
  var startFormat = "AM";
  var endFormat = "AM";
  var country="Ghana";
  var countryCode="+233";
  var gpsCords="";
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
  var messageForCelebrity=TextEditingController(text:"");





  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("requests").doc(widget.docId).snapshots(),
        builder:(context,snapshot){

          var width=MediaQuery.of(context).size.width;
          var height=MediaQuery.of(context).size.height;

          if(snapshot.hasData){

            Map data=snapshot.data.data();


            date= data["date"].toDate();
            dobDisplay = data["date"].toDate().toString().split(" ")[0];
            List bookingType=data["bookingTypes"];
            List bookingPurpose=data["bookingReasons"];
            var startFormat = data["startFormat"];
            var endFormat = data["endFormat"];
            var country= data["country"];
            var countryCode= data["countryCode"];
            var gpsCords=data["gpsCords"];
            bool privateEvent=data["privateEvent"];
            bool publicEvent=data["publicEvent"];
            bool liveAppearance=data["liveAppearance"];
            bool virtualEvent=data["virtualEvent"];


            var fullName=TextEditingController(text:data["fullName"]);
            var phoneNumber=TextEditingController(text:data["phoneNumber"]);
            var email=TextEditingController(text:data["email"]);
            var organization=TextEditingController(text:data["organization"]);
            var eventDescription=TextEditingController(text:data["eventDescription"]);
            var timeFrom=TextEditingController(text:data["timeStart"]);
            var timeTo=TextEditingController(text:data["timeEnd"]);
            var appearanceHours=TextEditingController(text:data["appearanceHours"]);
            var appearanceMinutes=TextEditingController(text:data["appearanceMinutes"]);
            var venueName=TextEditingController(text:data["venueName"]);
            var numberOfGuests=TextEditingController(text:data["numberOfGuests"]);
            var reasonForAppearance=TextEditingController(text:data["reasonForAppearance"]);
            var anyOtherEngagements=TextEditingController(text:data["anyOtherEngagements"]);
            var quotation=TextEditingController(text:"${data["quotation"]}");
            messageForCelebrity=TextEditingController(text:"${data["celebrityMessage"]}");


            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebrity).snapshots(),
              builder: (context, snapshot) {

                if(snapshot.hasData){

                  Map data2=snapshot.data.data();

                  return Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(24, 48, 93, 1),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              
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
                              
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Center(
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        "${data2["imgSrc"]}",
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
                                          "From: ${data2["fullName"]}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "AvenirBold",
                                              fontSize: 22),
                                        ),
                                        Text(
                                          "usually responds in ${data2["eventBooking"]["responseTime"]} days",
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
                            width: MediaQuery.of(context).size.width * 0.7,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
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
                                  width: MediaQuery.of(context).size.width * 0.3,
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
                              controller: eventDescription
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2002, 1, 1),
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
                                  color: Colors.white.withOpacity(0.2),
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
                                    color: Colors.white.withOpacity(0.2),
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
                                    color: Colors.white.withOpacity(0.2),
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
                                                  color: Colors.white.withOpacity(0.2),
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
                                                  color: Colors.white.withOpacity(0.2),
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
                                  color: Colors.white.withOpacity(0.2),
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
                          inputField(
                              label: "GPS Cordinates",
                              context: context,
                              onChange: (e) {}),
                          SizedBox(
                            height: 10,
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
                          Container(

                            child: inputField(
                                label: "GHS", context: context, onChange: (e) {},controller: quotation,numeric: true),
                          ),
                          SizedBox(height: 10,),
                          Container(

                            child: inputFieldExpanded(
                                label: "Message From Celebrity", context: context, onChange: (e) {},controller: messageForCelebrity),
                          ),

                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: width * 0.8,
                            child: GestureDetector(
                              onTap: ()async{

                                Navigator.pop(context);

                                var promo=TextEditingController(text: "");

                                showDialog(
                                    context: context,
                                    builder: (context) {

                                      return Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.7),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)
                                                )
                                            ),
                                            height: height * 0.5,
                                            width: width * 0.7,
                                            child: Center(
                                              child: ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      padding: EdgeInsets.all(3),
                                                      width: width * 0.6,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.3),
                                                          borderRadius: BorderRadius.all(Radius.circular(18.0))),
                                                      child: Center(
                                                        child: TextField(
                                                          controller: promo,
                                                          style: small(color: Colors.white),
                                                          decoration: InputDecoration(
                                                            labelText: "Promo Code",
                                                            labelStyle: small(color: Colors.white),
                                                            focusedBorder: InputBorder.none,
                                                            enabledBorder: InputBorder.none,
                                                            contentPadding: EdgeInsetsDirectional.only(start: 20),
                                                          ),
                                                          onChanged: (e) => {},
                                                          keyboardType: TextInputType.text,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 20,),
                                                  Center(
                                                    child: authButton(text: "Continue", color: Colors.white, bg: Colors.orange, onPress: ()async{

                                                      showLoading(context: context);

                                                      var promoResponse= await checkPromoCode(code: promo.text, type: "eventBooking", celebrity: widget.celebrity );

                                                      if(promoResponse["message"]=="ok"){

                                                        var discount= int.parse(promoResponse["promo"]["promoDiscount"]);
                                                        var discountPercentage=(1- (discount/100));
                                                        var amount=double.parse(quotation.text);
                                                        amount=amount*discountPercentage;
                                                        var discountedAmount=double.parse(data["eventBooking"]["price"])*(double.parse(promoResponse["promo"]["promoDiscount"])/100);


                                                        print('ifed');

                                                        var response=await http.get(Uri.parse("https://us-central1-funnel-887b0.cloudfunctions.net/getPaymentPage"),headers: {"name":data["fullName"],"amount": "${amount*100}"});
                                                        var responseData=jsonDecode(response.body);

                                                        var slug=responseData["data"]["slug"];

                                                        Navigator.pop(context);

                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              var width = MediaQuery.of(context).size.width;
                                                              var height = MediaQuery.of(context).size.height;

                                                              return Scaffold(
                                                                backgroundColor: Colors.transparent,
                                                                body: Center(
                                                                  child: Container(
                                                                    width: width * 0.8,
                                                                    height: height * 0.8,
                                                                    child: InAppWebView(
                                                                      onWebViewCreated: (_webViewController) {
                                                                        _webViewController.addJavaScriptHandler(
                                                                            handlerName: 'close',
                                                                            callback: (args) async {
                                                                              showLoading(context: context);

                                                                              try {
                                                                                Map userData = await getUserData(id: FirebaseAuth.instance.currentUser.uid);

                                                                                await addToWallet(amount: amount * 0.7, id: widget.celebrity, type: "celebrities");

                                                                                await addTransaction(discount: discountedAmount,flow: "out", message: "Event Booking", to: widget.celebrity, from: FirebaseAuth.instance.currentUser.uid, amount: ( amount));

                                                                                await addNotifications(type:"eventBooking",target: "celebrity", message: "${userData["fullName"]} has accepted your offer, You have recieved ${amount*0.7} GHS for an event booking", from: FirebaseAuth.instance.currentUser.uid , to: widget.celebrity);

                                                                                await FirebaseFirestore.instance.collection('requests').doc(widget.docId).set(
                                                                                    {
                                                                                      "status":"accepted"
                                                                                    },
                                                                                    SetOptions(merge: true)
                                                                                );

                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);

                                                                                //  Add Transactions Here
                                                                                // Add Wallet here.


                                                                              } catch (e) {
                                                                                Navigator.pop(context);
                                                                                showErrorDialogue(context: context, message: e.toString());
                                                                              }
                                                                            });
                                                                      },
                                                                      initialUrlRequest: URLRequest(url: Uri.parse("https://paystack.com/pay/$slug")),
                                                                      initialOptions: InAppWebViewGroupOptions(
                                                                          android: AndroidInAppWebViewOptions(
                                                                              allowFileAccess: true, cacheMode: AndroidCacheMode.LOAD_CACHE_ELSE_NETWORK, allowContentAccess: true)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });


                                                        print("showed");
                                                      }

                                                      else{
                                                        Navigator.pop(context);
                                                        showErrorDialogue(context: context, message: "Your promo code is invalid or expired");
                                                      }

                                                    }, context: context,thin: true),
                                                  ),
                                                  SizedBox(height: 50,),
                                                  GestureDetector(
                                                    onTap: ()async{
                                                      showLoading(context: context);


                                                      var response=await http.get(Uri.parse("https://us-central1-funnel-887b0.cloudfunctions.net/getPaymentPage"),headers: {"name":data["fullName"],"amount": "${double.parse(quotation.text)*100}"});
                                                      var responseData=jsonDecode(response.body);

                                                      var slug=responseData["data"]["slug"];

                                                      Navigator.pop(context);

                                                      showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            var width = MediaQuery.of(context).size.width;
                                                            var height = MediaQuery.of(context).size.height;

                                                            return Scaffold(
                                                              backgroundColor: Colors.transparent,
                                                              body: Center(
                                                                child: Container(
                                                                  width: width * 0.8,
                                                                  height: height * 0.8,
                                                                  child: InAppWebView(
                                                                    onWebViewCreated: (_webViewController) {
                                                                      _webViewController.addJavaScriptHandler(
                                                                          handlerName: 'close',
                                                                          callback: (args) async {
                                                                            showLoading(context: context);

                                                                            try {
                                                                              Map userData = await getUserData(id: FirebaseAuth.instance.currentUser.uid);

                                                                              await addToWallet(amount: double.parse( quotation.text) * 0.7, id: widget.celebrity, type: "celebrities");

                                                                              await addTransaction(flow: "out", message: "Event Booking", to: widget.celebrity, from: FirebaseAuth.instance.currentUser.uid, amount: ( double.parse(quotation.text)));

                                                                              await addNotifications(type:"eventBooking",target: "celebrity", message: "${userData["fullName"]} has accepted your offer, You have recieved ${double.parse(quotation.text)*0.7} GHS for an event booking", from: FirebaseAuth.instance.currentUser.uid , to: widget.celebrity);

                                                                              await FirebaseFirestore.instance.collection('requests').doc(widget.docId).set(
                                                                                  {
                                                                                    "status":"accepted"
                                                                                  },
                                                                                  SetOptions(merge: true)
                                                                              );

                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);

                                                                              //  Add Transactions Here
                                                                              // Add Wallet here.


                                                                            } catch (e) {
                                                                              Navigator.pop(context);
                                                                              showErrorDialogue(context: context, message: e.toString());
                                                                            }
                                                                          });
                                                                    },
                                                                    initialUrlRequest: URLRequest(url: Uri.parse("https://paystack.com/pay/$slug")),
                                                                    initialOptions: InAppWebViewGroupOptions(
                                                                        android: AndroidInAppWebViewOptions(
                                                                            allowFileAccess: true, cacheMode: AndroidCacheMode.LOAD_CACHE_ELSE_NETWORK, allowContentAccess: true)),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: Center(
                                                        child: Text("Have no promo code?",style: small(color: Colors.white,size: 14),)
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });

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
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Accept",
                                        textAlign: TextAlign.center,
                                        style: smallBold(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: width * 0.8,
                            child: GestureDetector(
                              onTap: ()async{


                                FirebaseFirestore.instance.collection("requests").doc(widget.docId).set(
                                    {
                                      "status":"rejected",
                                    },
                                    SetOptions(merge: true)
                                );


                                Navigator.pop(context);


                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.red),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Reject",
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
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      textAlign: TextAlign.center,
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
            );
          }
          else{
            return Container();
          }



        }
    );

  }
}



class completedDetails extends StatefulWidget {

  final String docId;
  final String celebrity;
  completedDetails({@required this.docId,@required this.celebrity});


  @override
  _completedDetailsState createState() => _completedDetailsState();
}

class _completedDetailsState extends State<completedDetails> {
  DateTime date= DateTime.now();
  var dobDisplay = 'Enter your date of birth';
  List bookingType=[];
  List bookingPurpose=[];
  var startFormat = "AM";
  var endFormat = "AM";
  var country="Ghana";
  var countryCode="+233";
  var gpsCords="";
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





  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("requests").doc(widget.docId).snapshots(),
        builder:(context,snapshot){

          var width=MediaQuery.of(context).size.width;
          var height=MediaQuery.of(context).size.height;

          if(snapshot.hasData){

            Map data=snapshot.data.data();


            date= data["date"].toDate();
            dobDisplay = data["date"].toDate().toString().split(" ")[0];
            List bookingType=data["bookingTypes"];
            List bookingPurpose=data["bookingReasons"];
            var startFormat = data["startFormat"];
            var endFormat = data["endFormat"];
            var country= data["country"];
            var countryCode= data["countryCode"];
            var gpsCords=data["gpsCords"];
            bool privateEvent=data["privateEvent"];
            bool publicEvent=data["publicEvent"];
            bool liveAppearance=data["liveAppearance"];
            bool virtualEvent=data["virtualEvent"];


            var fullName=TextEditingController(text:data["fullName"]);
            var phoneNumber=TextEditingController(text:data["phoneNumber"]);
            var email=TextEditingController(text:data["email"]);
            var organization=TextEditingController(text:data["organization"]);
            var eventDescription=TextEditingController(text:data["eventDescription"]);
            var timeFrom=TextEditingController(text:data["timeStart"]);
            var timeTo=TextEditingController(text:data["timeEnd"]);
            var appearanceHours=TextEditingController(text:data["appearanceHours"]);
            var appearanceMinutes=TextEditingController(text:data["appearanceMinutes"]);
            var venueName=TextEditingController(text:data["venueName"]);
            var numberOfGuests=TextEditingController(text:data["numberOfGuests"]);
            var reasonForAppearance=TextEditingController(text:data["reasonForAppearance"]);
            var anyOtherEngagements=TextEditingController(text:data["anyOtherEngagements"]);
            var quotation=TextEditingController(text:"${data["quotation"]}");



            return StreamBuilder(
                stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebrity).snapshots(),
                builder: (context, snapshot) {

                  if(snapshot.hasData){

                    Map data2=snapshot.data.data();

                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(24, 48, 93, 1),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                alignment: Alignment.center,

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

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                          "${data2["imgSrc"]}",
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
                                            "From: ${data2["fullName"]}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "AvenirBold",
                                                fontSize: 22),
                                          ),
                                          Text(
                                            "usually responds in ${data2["eventBooking"]["responseTime"]} days",
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
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
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
                                    width: MediaQuery.of(context).size.width * 0.3,
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
                                controller: eventDescription
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2002, 1, 1),
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
                                    color: Colors.white.withOpacity(0.2),
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
                                      color: Colors.white.withOpacity(0.2),
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
                                      color: Colors.white.withOpacity(0.2),
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
                                                    color: Colors.white.withOpacity(0.2),
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
                                                    color: Colors.white.withOpacity(0.2),
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
                                    color: Colors.white.withOpacity(0.2),
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
                            inputField(
                                label: "GPS Cordinates",
                                context: context,
                                onChange: (e) {}),
                            SizedBox(
                              height: 10,
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
                            Container(

                              child: inputField(
                                  label: "GHS", context: context, onChange: (e) {},controller: quotation,numeric: true),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: width * 0.8,
                              child: GestureDetector(
                                onTap: ()async{


                                  Navigator.pop(context);

                                  showDialog(
                                    context:context,
                                    builder: (context){
                                      return Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: Center(
                                          child: Container(
                                            padding: EdgeInsets.all(15) ,
                                            width: width*0.8,
                                            height: height*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color: Colors.white
                                            ),
                                            child: Center(
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: [
                                                    Center(child: Text("Your support id is",style: small(color: Colors.black,size: 18),)),
                                                    SizedBox(height: 20,),
                                                    Center(child: Text("${widget.docId}",style: small(color: Colors.black,size: 25),textAlign: TextAlign.center,)),
                                                    SizedBox(height: 20,),
                                                    Center(
                                                      child: authButton(text: "Copy", color: Colors.white, bg: Colors.orange, onPress: (){
                                                        ClipboardManager.copyToClipBoard("${widget.docId}");
                                                        Navigator.pop(context);
                                                      }, context: context,thin: true),
                                                    )
                                                  ],
                                                )
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  );

                                  //showMessage(context: context, message: "Your support id is\n\n${widget.docId} " );

                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      color: Colors.red),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Refund",
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        textAlign: TextAlign.center,
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
            );
          }
          else{
            return Container();
          }



        }
    );

  }

}

















class pendingDetails extends StatefulWidget {


  final String docId;
  final String celebrity;
  pendingDetails({@required this.docId,@required this.celebrity});

  @override
  _pendingDetailsState createState() => _pendingDetailsState();
}

class _pendingDetailsState extends State<pendingDetails> {
  DateTime date= DateTime.now();
  var dobDisplay = 'Enter your date of birth';
  List bookingType=[];
  List bookingPurpose=[];
  var startFormat = "AM";
  var endFormat = "AM";
  var country="Ghana";
  var countryCode="+233";
  var gpsCords="";
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





  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("requests").doc(widget.docId).snapshots(),
        builder:(context,snapshot){

          var width=MediaQuery.of(context).size.width;
          var height=MediaQuery.of(context).size.height;

          if(snapshot.hasData){

            Map data=snapshot.data.data();


            date= data["date"].toDate();
            dobDisplay = data["date"].toDate().toString().split(" ")[0];
            List bookingType=data["bookingTypes"];
            List bookingPurpose=data["bookingReasons"];
            var startFormat = data["startFormat"];
            var endFormat = data["endFormat"];
            var country= data["country"];
            var countryCode= data["countryCode"];
            var gpsCords=data["gpsCords"];
            bool privateEvent=data["privateEvent"];
            bool publicEvent=data["publicEvent"];
            bool liveAppearance=data["liveAppearance"];
            bool virtualEvent=data["virtualEvent"];


            var fullName=TextEditingController(text:data["fullName"]);
            var phoneNumber=TextEditingController(text:data["phoneNumber"]);
            var email=TextEditingController(text:data["email"]);
            var organization=TextEditingController(text:data["organization"]);
            var eventDescription=TextEditingController(text:data["eventDescription"]);
            var timeFrom=TextEditingController(text:data["timeStart"]);
            var timeTo=TextEditingController(text:data["timeEnd"]);
            var appearanceHours=TextEditingController(text:data["appearanceHours"]);
            var appearanceMinutes=TextEditingController(text:data["appearanceMinutes"]);
            var venueName=TextEditingController(text:data["venueName"]);
            var numberOfGuests=TextEditingController(text:data["numberOfGuests"]);
            var reasonForAppearance=TextEditingController(text:data["reasonForAppearance"]);
            var anyOtherEngagements=TextEditingController(text:data["anyOtherEngagements"]);
            var quotation=TextEditingController(text:"${data["quotation"]}");



            return StreamBuilder(
                stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebrity).snapshots(),
                builder: (context, snapshot) {

                  if(snapshot.hasData){

                    Map data2=snapshot.data.data();

                    return Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(24, 48, 93, 1),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Center(
                              child: Container(
                                alignment: Alignment.center,

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

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                          "${data2["imgSrc"]}",
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
                                            "From: ${data2["fullName"]}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "AvenirBold",
                                                fontSize: 22),
                                          ),
                                          Text(
                                            "usually responds in ${data2["eventBooking"]["responseTime"]} days",
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
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
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
                                    width: MediaQuery.of(context).size.width * 0.3,
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
                                controller: eventDescription
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime(2002, 1, 1),
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
                                    color: Colors.white.withOpacity(0.2),
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
                                      color: Colors.white.withOpacity(0.2),
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
                                      color: Colors.white.withOpacity(0.2),
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
                                                    color: Colors.white.withOpacity(0.2),
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
                                                    color: Colors.white.withOpacity(0.2),
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
                                    color: Colors.white.withOpacity(0.2),
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
                            inputField(
                                label: "GPS Cordinates",
                                context: context,
                                onChange: (e) {}),
                            SizedBox(
                              height: 10,
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
                            Container(

                              child: inputField(
                                  label: "GHS", context: context, onChange: (e) {},controller: quotation,numeric: true),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(height: 10,),
                            // Container(
                            //   width: width * 0.8,
                            //   child: GestureDetector(
                            //     onTap: ()async{
                            //
                            //
                            //       Navigator.pop(context);
                            //
                            //       showMessage(context: context, message: "Your support id is\n\n${widget.docId} " );
                            //
                            //     },
                            //     child: Container(
                            //       padding: EdgeInsets.all(10),
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.all(
                            //             Radius.circular(20),
                            //           ),
                            //           color: Colors.red),
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           SizedBox(
                            //             width: 10,
                            //           ),
                            //           Text("Refund",
                            //               textAlign: TextAlign.center,
                            //               style: smallBold(color: Colors.white)),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            // GestureDetector(
                            //   onTap: () {
                            //     Navigator.push(context,
                            //         CupertinoPageRoute(builder: (context) {
                            //           return howRefundsWork2();
                            //         }));
                            //   },
                            //   child: Center(
                            //     child: Container(
                            //       width: width * 0.85,
                            //       alignment: Alignment.centerLeft,
                            //       child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Icon(
                            //             Icons.warning,
                            //             color: Colors.orange,
                            //           ),
                            //           SizedBox(
                            //             width: 5,
                            //           ),
                            //           Text(
                            //             "How do refunds work",
                            //             textAlign: TextAlign.center,
                            //             style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontFamily: "Avenir",
                            //                 fontSize: 17),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),

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
          else{
            return Container();
          }



        }
    );

  }
}

