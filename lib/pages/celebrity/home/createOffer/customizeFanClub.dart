import 'package:celebside/pages/celebrity/home/createOffer/components.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';



var expiry=DateTime.now().add(Duration(days: 60));
var expiryDisplay="Expiry Date";

var promoTitle=TextEditingController(text: "");
var promoDiscount=TextEditingController(text: "");
var promoCode=TextEditingController(text: "");
var totalPromoCodes=TextEditingController(text: "");
var type="DM";

class customizeFanClub extends StatefulWidget {
  @override
  _customizeFanClubState createState() => _customizeFanClubState();
}

class _customizeFanClubState extends State<customizeFanClub> {
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
                  DocumentSnapshot doc=snapshot.data;
                  Map data=doc.data();

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
                              "Customize Fan Club",
                              style: medium(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(child: Text("Title",style: smallBold(color: Colors.white,size: 12),)),
                                  Flexible(child: Text("Discount",style:smallBold(color: Colors.white,size: 12),)),
                                  Flexible(child: Text("Code",style: smallBold(color: Colors.white,size: 12),)),
                                  Flexible(child: Text("Amount",style: smallBold(color: Colors.white,size: 12),)),
                                  Flexible(child: Text("Type",style: smallBold(color: Colors.white,size: 12),)),
                                  Flexible(child: Text("Expiry",style: smallBold(color: Colors.white,size: 12),)),
                                  FloatingActionButton(onPressed: (){},child:Container(),elevation: 0,backgroundColor: Colors.transparent,mini: true,)

                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            data["fanClub"]["promos"].length==0?Container(margin: EdgeInsets.only(top:10,bottom: 10),child: Text("All promo codes will be shown here",textAlign: TextAlign.center,style: small(color: Colors.white,size: 14),)):
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data["fanClub"]["promos"].length,
                                itemBuilder: (context,index){
                                  var currentPromo=data["fanClub"]["promos"][index];
                                  return fanClubPromoCodeRow(promoTitle: currentPromo["promoTitle"],promoCode:currentPromo["promoCode"],promoDiscount: currentPromo["promoDiscount"],totalPromoCodes: currentPromo["totalPromoCodes"],index: index,type: currentPromo["type"],expiry: currentPromo["expiry"].toDate().toString().split(" ")[0]);
                                }
                            ),
                            SizedBox(height: 30,),
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
                                      controller: promoTitle,
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
                                      controller: promoDiscount,
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
                                      controller: promoCode,
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
                                      controller: totalPromoCodes,
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
                                      "Type",
                                      style: small(color: Colors.white, size: 14),
                                    )),
                                Container(
                                  width: width*0.5,
                                  padding: EdgeInsets.only(left:20,right: 20),
                                  decoration:BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(24.0))
                                  ),
                                  child: DropdownButton<String>(
                                    value: type,
                                    style: small(color: Colors.white),
                                    dropdownColor: Colors.black,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        type = newValue;
                                      });
                                    },
                                    hint: Text(
                                      "Type",
                                      style: small(color: Colors.white),
                                    ),
                                    items: <String>["DM","Video Request","Event Booking"].map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: small(color: Colors.white),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
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
                            SizedBox(height: 50,),
                            authButton(text: "Create", color: Colors.white, bg: Colors.orange, onPress: ()async{

                            if(promoCode.text.length>=8){
                              showErrorDialogue(context: context, message: "Promo Code Cannot be Greater than 8 digits");
                              return 0;
                            }

                            if(promoTitle.text!="" && promoDiscount.text!="" && promoCode.text!="" && totalPromoCodes.text!="" && type!="" ){

                              var exists=false;
                              showLoading(context: context);
                              print("ifed");
                              List currentPromos=data["fanClub"]["promos"];
                              print(currentPromos);
                              currentPromos.forEach((element) {

                                if(element["promoCode"]==promoCode.text.toString().trim()){
                                  Navigator.pop(context);
                                  showErrorDialogue(context: context, message: "Promo Code Already Exists");
                                  exists=true;
                                }


                              });


                              if(exists==true){}
                              else{
                                await currentPromos.add(
                                    {
                                      "promoCode":promoCode.text,
                                      "promoTitle":promoTitle.text,
                                      "totalPromoCodes":totalPromoCodes.text,
                                      "promoDiscount":promoDiscount.text,
                                      "type":type,
                                      "expiry":expiry
                                    }
                                );

                                await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"fanClub":{"promos":currentPromos}},SetOptions(merge: true));

                                Navigator.pop(context);


                              }






                            }
                            else {
                              showErrorDialogue(context: context, message: "Kindly Fill Out All Promo Code Details Properly.");
                            }


                            }, context: context),
                            SizedBox(height: 100,),
                          ],
                        )),
                  );
                }
                else{
                  return Scaffold(body: Center(
                    child: CircularProgressIndicator(),
                  ));
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
          ],
        ),
      ),
    );
  }
}
