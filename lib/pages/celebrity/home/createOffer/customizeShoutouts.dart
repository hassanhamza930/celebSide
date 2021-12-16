import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/celebrity/home/createOffer/components.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';




var expiry=DateTime.now().add(Duration(days: 60));
var expiryDisplay="Expiry Date";
var isCovered=true;

var loading=true;

var priceController=TextEditingController();
var responseTimeController=TextEditingController();
var charity=false;
var hidden=false;


var promoTitle="";
var promoDiscount="";
var promoCode="";
var totalPromoCodes="";


class customizeShoutouts extends StatefulWidget {
  @override
  _customizeShoutoutsState createState() => _customizeShoutoutsState();
}

class _customizeShoutoutsState extends State<customizeShoutouts> {


  fetchDataAndInitialize()async{
    var doc= await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).get();
    var data=doc.data();
    setState(() {
      priceController.value=TextEditingValue(text: data["videoRequest"]["price"].toString());
      responseTimeController.value=TextEditingValue(text: data["videoRequest"]["responseTime"].toString());
      charity=data["videoRequest"]["charity"];
      hidden=data["videoRequest"]["hidden"];
      loading=false;
    });

  }

  @override
  void initState() {
    fetchDataAndInitialize();
    super.initState();
  }

  @override
  void dispose() {

    loading=true;
    // TODO: implement dispose
    super.dispose();
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
                  print(data["videoRequest"]["promos"]);
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
                              "Customize Shoutouts",
                              style: medium(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            inputField(label: "Price", context: context, onChange: (e) {},controller: priceController),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "( We advice a fee between ¢100.00 - ¢1000.00. The lower the price, the more the bookings )",
                                style: small(color: Colors.white, size: 12),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(height: 30,),
                            inputField(label: "Response Time (in Days)", context: context, onChange: (e) {}, controller: responseTimeController),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "(We advice you to deliver within 7 days otherwise request will be cancelled and refund will be made to fan.)",
                                style: small(color: Colors.white, size: 12),
                                textAlign: TextAlign.left,
                              ),
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
                            SizedBox(height: 20,),
                            authButton(text: "Update Details", color: Colors.white, bg: Colors.orange, onPress: ()async{
                              if(priceController.text!="0" && responseTimeController.text!="0"){

                                showLoading(context: context);
                                try{
                                  await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"videoRequest":{"price":priceController.text,"responseTime":responseTimeController.text,"charity":charity,"hidden":hidden}},SetOptions(merge:true));
                                  Navigator.pop(context);

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                }
                                catch(e){
                                  Navigator.pop(context);
                                  showErrorDialogue(context: context, message: e);
                                }
                              }
                              else{
                                showErrorDialogue(context: context, message: "Kindly Fill All Details For Offering");
                              }

                            }, context: context),
                            SizedBox(height: 70,),
                            isCovered==true?
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    isCovered=false;
                                  });
                                },
                                child: Text("Manage Promo Codes",style: medium(color: Colors.orange,size: 18),textAlign: TextAlign.center,)
                            ):Column(
                              children: [
                                Text("All Promo Codes",style: medium(color: Colors.orange,size: 25),textAlign: TextAlign.center,),
                                SizedBox(height: 10,),
                                Container(
                                  width: width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(child: AutoSizeText("Title",maxLines:1,style: smallBold(color: Colors.white,size: 14),)),
                                      Flexible(child: AutoSizeText("Discount",maxLines:1,style: smallBold(color: Colors.white,size: 14),)),
                                      Flexible(child: AutoSizeText("Code",maxLines:1,style: smallBold(color: Colors.white,size: 14),)),
                                      Flexible(child: AutoSizeText("Amount",maxLines:1,style: smallBold(color: Colors.white,size: 14),)),
                                      Flexible(child: AutoSizeText("Expiry",maxLines:1,style: smallBold(color: Colors.white,size: 14),)),
                                      TextButton(onPressed: ()async{},child: Icon(Icons.remove,color: Colors.transparent,),)
                                    ],
                                  ),
                                ),
                                data["videoRequest"]["promos"].length==0?Container(margin: EdgeInsets.only(top:10,bottom: 10),child: Text("All promo codes will be shown here",textAlign: TextAlign.center,style: small(color: Colors.white,size: 14),)):
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data["videoRequest"]["promos"].length,
                                    itemBuilder: (context,index){
                                      var currentPromo=data["videoRequest"]["promos"][index];
                                      return promoCodeRow(promoTitle: currentPromo["promoTitle"],promoCode:currentPromo["promoCode"],promoDiscount: currentPromo["promoDiscount"],totalPromoCodes: currentPromo["totalPromoCodes"],index: index,type: "videoRequest",expiry: currentPromo["expiry"].toDate().toString().split(" ")[0],);
                                    }
                                ),
                                SizedBox(height: 15,),
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
                                            promoCode=e;
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

                                  print("hello");
                                  print("promo code title is"+promoTitle);
                                  print("promo Discount is"+promoDiscount);
                                  print("promo code is"+promoCode);
                                  print("promo total is"+totalPromoCodes);

                                  if(promoTitle!="" && promoDiscount!="" && promoCode!="" && totalPromoCodes!="" && expiryDisplay!="Expiry Date"){

                                    showDialog(context: context, builder: (context){
                                      return Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: Center(
                                          child: Container(
                                            height: 200,
                                            width: 200,
                                            child: CircularProgressIndicator(color: Colors.blue,),
                                          ),
                                        ),
                                      );
                                    });

                                    print("ifed");

                                    var currentPromos=data["videoRequest"]["promos"];
                                    currentPromos.add(
                                        {
                                          "promoCode":promoCode,
                                          "promoTitle":promoTitle,
                                          "totalPromoCodes":totalPromoCodes,
                                          "promoDiscount":promoDiscount,
                                          "expiry":expiry
                                        }
                                    );

                                    await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"videoRequest":{"promos":currentPromos}},SetOptions(merge: true));

                                    Navigator.pop(context);



                                  }
                                  else{
                                    print("elsed");
                                    showDialog(context: context, builder: (context) {
                                      return Scaffold(
                                        backgroundColor: Colors.transparent,
                                        body: Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              color: Colors.white,
                                            ),
                                            width: width * 0.5,
                                            height: height * 0.3,
                                            padding: EdgeInsets.all(20),
                                            child: Center(
                                              child: ListView(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      Align(
                                                        alignment: Alignment.topRight,
                                                        child: Center(
                                                          child:
                                                          FloatingActionButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Icon(
                                                              Icons.close,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.05,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      child: Center(
                                                        child: Text(
                                                          "Kindly Fill All Promo Details Properly.",
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  }


                                },
                                    context: context),
                              ],
                            ),
                            SizedBox(height: 100,),
                          ],
                        )),
                  );
                }
                else{
                  return Center(child: CircularProgressIndicator(),);
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
