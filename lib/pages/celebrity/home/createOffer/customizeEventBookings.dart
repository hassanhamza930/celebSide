import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/celebrity/home/createOffer/components.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeDms.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeShoutouts.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:multiselect_dropdown/multiple_dropdown.dart';
import 'package:multiselect_dropdown/multiple_select.dart';


var expiry=DateTime.now().add(Duration(days: 60));
var expiryDisplay="Expiry Date";

var currentItem;
var responseTime=TextEditingController();
List bookingTypes = [];
List bookingReasons = [];
var budgetFrom=TextEditingController(text:"0");
var budgetTo=TextEditingController(text:"0");
var hidden=true;
var charity=true;

var promoTitle="";
var promoDiscount="";
var promoCode="";
var totalPromoCodes="";

var loading=true;
var shown=false;


class customizeEventBooking extends StatefulWidget {
  @override
  _customizeEventBookingState createState() => _customizeEventBookingState();
}

class _customizeEventBookingState extends State<customizeEventBooking> {

  @override
  void dispose() {
    loading=true;
    super.dispose();
  }



  setOneTime()async{


    var doc= await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).get();
    var data=doc.data();

    setState(() {
      bookingTypes=data["eventBooking"]["bookingTypes"];
      bookingReasons=data["eventBooking"]["bookingReasons"];
      hidden=data["eventBooking"]["hidden"];
      charity=data["eventBooking"]["charity"];
      budgetFrom.text=data["eventBooking"]["budgetFrom"].toString();
      budgetTo.text=data["eventBooking"]["budgetTo"].toString();
      responseTime.text=data["eventBooking"]["responseTime"].toString();
      loading=false;
    });


  }

  @override
  void initState() {
    setOneTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/bluebackground.png",
              fit: BoxFit.cover,
              width: width,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  var data=snapshot.data.data();
                  return Center(
                    child: Container(
                        alignment: Alignment.topCenter,
                        width: width * 0.9,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Text(
                              "Customize Event Bookings",
                              style: medium(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            inputField(
                                label: "Response Time ( in Days )",
                                context: context,
                                onChange: (e) {
                                },
                                controller: responseTime
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "(We advice you to respond to booking orders within 14 days otherwise request will be cancelled and refund will be made to fan.)",
                                style: small(color: Colors.white, size: 12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MultipleDropDown(
                                placeholder: "Select Event Types",
                                values:bookingTypes,
                                elements: [
                                  MultipleSelectItem.build(value: "Walkthrough", display: "Walkthrough", content: "Walkthrough"),
                                  MultipleSelectItem.build(value: "Appearances", display: "Appearances", content:"Appearances"),
                                  MultipleSelectItem.build(value: "Hosting", display: "Hosting", content: "Hosting"),
                                  MultipleSelectItem.build(value: "Speaking", display: "Speaking", content: "Speaking"),
                                  MultipleSelectItem.build(value: "Performance", display: "Performance", content: "Performance")
                                ]
                            ),

                            SizedBox(height: 10,),

                            SizedBox(
                              height: 20,
                            ),
                            MultipleDropDown(
                                placeholder: "Select Booking Reasons",
                                values:bookingReasons,
                                elements: [
                                  MultipleSelectItem.build(value: "Wedding", display: "Wedding", content: "Wedding"),
                                  MultipleSelectItem.build(value: "Private Party", display: "Private Party", content:"Private Party"),
                                  MultipleSelectItem.build(value: "Night Club", display: "Night Club", content: "Night Club"),
                                  MultipleSelectItem.build(value: "Corporate Event", display: "Corporate Event", content: "Corporate Event"),
                                  MultipleSelectItem.build(value: "Graduation", display: "Graduation", content: "Graduation"),
                                  MultipleSelectItem.build(value: "Convention", display: "Convention", content: "Convention"),
                                  MultipleSelectItem.build(value: "Tradeshow", display: "Tradeshow", content: "Tradeshow"),
                                  MultipleSelectItem.build(value: "Fair or Festival", display:"Fair or Festival", content: "Fair or Festival"),
                                  MultipleSelectItem.build(value: "Fundraising Event", display: "Fundraising Event", content: "Fundraising Event"),
                                  MultipleSelectItem.build(value: "Public Event", display: "Public Event", content: "Public Event"),
                                  MultipleSelectItem.build(value: "TV/Movie/Radio/Webcast", display: "TV/Movie/Radio/Webcast", content: "TV/Movie/Radio/Webcast"),
                                ]
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Container(
                                width: width*0.85,
                                child: Text(
                                    "Budget Range",
                                    style: medium(color: Colors.white, size: 20),
                                    textAlign: TextAlign.left
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  //padding: EdgeInsets.all(3),
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.05),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                                  child: Center(
                                    child: TextField(
                                      controller:budgetFrom ,
                                      style: small(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintStyle: small(color: Colors.white38),
                                        hintText: "From",
                                        labelText: "GHS",
                                        labelStyle: small(color: Colors.white),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        contentPadding:
                                        EdgeInsetsDirectional.only(start: 20),
                                      ),
                                      onChanged: (e) {

                                      },
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                ),
                                Container(
                                  //padding: EdgeInsets.all(3),
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.05),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                                  child: Center(
                                    child: TextField(
                                      controller: budgetTo ,
                                      style: small(color: Colors.white),
                                      decoration: InputDecoration(
                                        hintStyle: small(color: Colors.white38),
                                        hintText: "To",
                                        labelText: "GHS",
                                        labelStyle: small(color: Colors.white),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        contentPadding:
                                        EdgeInsetsDirectional.only(start: 20),
                                      ),
                                      onChanged: (e) {

                                      },
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Checkbox(value: hidden, onChanged: (e) {
                                  setState(() {
                                    hidden=e;
                                  });
                                }),
                                Flexible(
                                    child: Text(
                                      "Hidden ( Tick to hide your offer from fans )",
                                      style: small(color: Colors.white, size: 14),
                                    ))
                              ],
                            ),
                            Row(
                              children: [
                                Checkbox(value: charity, onChanged: (e) {
                                  setState(() {
                                    charity=e;
                                  });
                                }),
                                Flexible(
                                    child: Text(
                                      "Charity ( Tick for free video request for fans )",
                                      style: small(color: Colors.white, size: 14),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            authButton(text: "Update", color: Colors.white, bg: Colors.orange, onPress: ()async{

                              if(responseTime.text!="0" && bookingTypes.length!=0 && bookingReasons.length!=0 && budgetFrom.text!="0" && budgetTo.text!="0"){
                                try{
                                  showLoading(context: context);
                                  await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set(
                                      {
                                        "eventBooking":{
                                          "bookingTypes":bookingTypes,
                                          "bookingReasons":bookingReasons,
                                          "budgetFrom":budgetFrom.text,
                                          "budgetTo":budgetTo.text,
                                          "hidden":hidden,
                                          "charity":charity,
                                          "responseTime":responseTime.text
                                        }
                                      },
                                      SetOptions(merge: true)
                                  );

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                }
                                catch(e){
                                  Navigator.pop(context);
                                  showErrorDialogue(context: context, message: e.toString());
                                }
                              }
                              else{
                                showErrorDialogue(context: context, message: "Kindly Fill All Offering Details");
                              }

                            }, context: context),
                            SizedBox(
                              height: 50,
                            ),
                            shown==true?
                            Column(
                              children: [
                                Text("All Promo Codes",style: medium(color: Colors.orange,size: 25),textAlign: TextAlign.center,),
                                SizedBox(height: 10,),
                                Container(
                                  width: width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(child: AutoSizeText("Title",maxLines: 1,style: smallBold(color: Colors.white,size: 14),)),
                                      Flexible(child: AutoSizeText("Discount",maxLines: 1,style:smallBold(color: Colors.white,size: 14),)),
                                      Flexible(child: AutoSizeText("Code",maxLines: 1,style: smallBold(color: Colors.white,size: 14),)),
                                      Flexible(child: AutoSizeText("Amount",maxLines: 1,style: smallBold(color: Colors.white,size: 14),)),
                                      Flexible(child: AutoSizeText("Expiry",maxLines: 1,style: smallBold(color: Colors.white,size: 14),)),
                                      TextButton(onPressed: ()async{},child: Icon(Icons.remove,color: Colors.transparent,),)
                                    ],
                                  ),
                                ),
                                data["eventBooking"]["promos"].length==0?Container(margin: EdgeInsets.only(top:10,bottom: 10),child: Text("All promo codes will be shown here",textAlign: TextAlign.center,style: small(color: Colors.white,size: 14),)):
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data["eventBooking"]["promos"].length,
                                    itemBuilder: (context,index){
                                      var currentPromo=data["eventBooking"]["promos"][index];
                                      return promoCodeRow(promoTitle: currentPromo["promoTitle"],promoCode:currentPromo["promoCode"],promoDiscount: currentPromo["promoDiscount"],totalPromoCodes: currentPromo["totalPromoCodes"],index: index,type: "eventBooking",expiry: currentPromo["expiry"].toDate().toString().split(" ")[0],);
                                    }
                                ),
                                SizedBox(height: 50,),
                                Text("Add Promo Code",style: medium(color: Colors.orange,size: 25),textAlign: TextAlign.center,),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                          "Title",
                                          style: small(color: Colors.white, size: 14),
                                        )),
                                    Container(
                                      //padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(18.0))),
                                      child: Center(
                                        child: TextField(
                                          style: small(color: Colors.white),
                                          decoration: InputDecoration(
                                            hintStyle: small(color: Colors.white38),
                                            hintText: "Example",
                                            labelStyle: small(color: Colors.white),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            contentPadding:
                                            EdgeInsetsDirectional.only(start: 20),
                                          ),
                                          onChanged: (e){
                                            setState(() {
                                              promoTitle=e;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                          "Discount %",
                                          style: small(color: Colors.white, size: 14),
                                        )),
                                    Container(
                                      //padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(18.0))),
                                      child: Center(
                                        child: TextField(
                                          style: small(color: Colors.white),
                                          decoration: InputDecoration(
                                            //labelText: "Discount %",
                                            hintText: "15%",
                                            hintStyle: small(color: Colors.white38),
                                            labelStyle: small(color: Colors.white),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            contentPadding:
                                            EdgeInsetsDirectional.only(start: 20),
                                          ),
                                          onChanged: (e){
                                            setState(() {
                                              promoDiscount=e;
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                          "Code",
                                          style: small(color: Colors.white, size: 14),
                                        )),
                                    Container(
                                      //padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(18.0))),
                                      child: Center(
                                        child: TextField(
                                          style: small(color: Colors.white),
                                          decoration: InputDecoration(
                                            //labelText: "Discount %",
                                            hintText: "Example",
                                            hintStyle: small(color: Colors.white38),
                                            labelStyle: small(color: Colors.white),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            contentPadding:
                                            EdgeInsetsDirectional.only(start: 20),
                                          ),
                                          onChanged: (e){
                                            setState(() {
                                              promoCode=e;
                                            });
                                          },
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                          "Number of Promo Codes",
                                          style: small(color: Colors.white, size: 14),
                                        )),
                                    Container(
                                      //padding: EdgeInsets.all(3),
                                      width: MediaQuery.of(context).size.width * 0.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.05),
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(18.0))),
                                      child: Center(
                                        child: TextField(
                                          style: small(color: Colors.white),
                                          decoration: InputDecoration(
                                            //labelText: "Discount %",
                                            hintText: "50",
                                            hintStyle: small(color: Colors.white38),
                                            labelStyle: small(color: Colors.white),
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            contentPadding:
                                            EdgeInsetsDirectional.only(start: 20),
                                          ),
                                          onChanged: (e){
                                            setState(() {
                                              totalPromoCodes=e;
                                            });
                                          },
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                        child: Text(
                                          "Expiry Date",
                                          style: small(color: Colors.white, size: 14),
                                        )),
                                    GestureDetector(
                                      onTap: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            minTime: DateTime.now(),
                                            maxTime: DateTime.now().add(Duration(days: 720)) , onChanged: (date) {
                                              print('change $date');
                                            },
                                            onConfirm: (date) {
                                              setState(() {
                                                expiry = date;
                                                expiryDisplay=date.toString().split(" ")[0];
                                              });
                                            }, currentTime: DateTime.now(), locale: LocaleType.en);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(3),
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.05),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(24.0))),
                                        child: Center(
                                          child: TextField(
                                            enabled: false,
                                            style: small(color: Colors.white),
                                            decoration: InputDecoration(
                                              labelText: "${expiryDisplay}",
                                              labelStyle: small(color: Colors.white),
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding:
                                              EdgeInsetsDirectional.only(start: 20),
                                            ),
                                            onChanged: (e) => {},
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                authButton(
                                    text: "Create",
                                    color: Colors.white,
                                    bg: Colors.orange,
                                    onPress: () async{
                                      if(promoTitle!="" && promoDiscount!="" && promoCode!="" && totalPromoCodes!="" && expiryDisplay!="Expiry Date" ){
                                        showLoading(context: context);
                                        print("ifed");

                                        var currentPromos=data["eventBooking"]["promos"];
                                        currentPromos.add(
                                            {
                                              "promoCode":promoCode,
                                              "promoTitle":promoTitle,
                                              "totalPromoCodes":totalPromoCodes,
                                              "promoDiscount":promoDiscount,
                                              "expiry":expiry
                                            }
                                        );

                                        await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"eventBooking":{"promos":currentPromos}},SetOptions(merge: true));

                                        Navigator.pop(context);

                                      }
                                      else{
                                        print("elsed");
                                        showErrorDialogue(context: context, message: "Kindly fill out all Promo Code details");
                                      }
                                    },
                                    context: context),
                              ],
                            ):
                            Container(
                              child:GestureDetector(
                                onTap: (){
                                  setState(() {
                                    shown=true;
                                  });
                                },
                                  child: Text("Manage promo codes",style: medium(color: Colors.orange,size: 18),textAlign: TextAlign.center,)
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        )),
                  );
                }
                else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

              }
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            loading==true?Scaffold(
              backgroundColor: Colors.white54,
              body: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(color: Colors.blue,),
                ),
              ),
            ):Container()
          ],
        ),
      ),
    );
  }
}
