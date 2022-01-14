import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/celebrity/home/createOffer/components.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeShoutouts.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


var expiry=DateTime.now().add(Duration(days: 60));
var expiryDisplay="Expiry Date";

var priceController=TextEditingController();
var responseTimeController=TextEditingController();
var charity=false;
var hidden=false;
var covered=true;

var promoTitle="";
var promoDiscount="";
var promoCode="";
var totalPromoCodes="";

var loading=true;


class customizeDms extends StatefulWidget {
  @override
  _customizeDmsState createState() => _customizeDmsState();
}

class _customizeDmsState extends State<customizeDms> {

  fetchDataAndInitialize()async{
    var doc= await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).get();
    var data=doc.data();
    setState(() {
      priceController.value=TextEditingValue(text: data["dm"]["price"].toString());
      responseTimeController.value=TextEditingValue(text: data["dm"]["responseTime"].toString());
      charity=data["dm"]["charity"];
      hidden=data["dm"]["hidden"];
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
    covered=true;
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
                                "Customize DMs",
                                style: medium(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              inputField(
                                  label: "Price", context: context, onChange: (e) {},controller: priceController,numeric: true),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "( We advice a fee between ¢100.00 - ¢1000.00. The lower the price, the more the bookings )",
                                  style: small(color: Colors.white, size: 12),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              inputField(label: "Response Time ( in Days )", context: context, onChange: (e){},controller: responseTimeController,numeric: true),
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

                               if(priceController.text!="0" && responseTimeController.text!="0" ){
                                 try{
                                   showLoading(context: context);
                                   await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set(
                                       {
                                         "dm": {
                                            "price": priceController.text,
                                            "responseTime":responseTimeController.text,
                                            "charity":charity,
                                            "hidden":hidden
                                          }
                                       },SetOptions(merge:true));
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
                                  showErrorDialogue(context: context, message: "Kindly Fill All Detail Offerings");
                               }

                              }, context: context),
                              SizedBox(height: 70,),
                              covered==true?
                              GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      covered=false;
                                    });
                                  },
                                  child: Text("Manage Promo Codes",style: medium(color: Colors.orange,size: 18),textAlign: TextAlign.center,)
                              ):
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
                                  data["dm"]["promos"].length==0?Container(margin: EdgeInsets.only(top:10,bottom: 10),child: Text("All promo codes will be shown here",textAlign: TextAlign.center,style: small(color: Colors.white,size: 14),)):
                                  ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: data["dm"]["promos"].length,
                                      itemBuilder: (context,index){
                                        var currentPromo=data["dm"]["promos"][index];
                                        return promoCodeRow(promoTitle: currentPromo["promoTitle"],promoCode:currentPromo["promoCode"],promoDiscount: currentPromo["promoDiscount"],totalPromoCodes: currentPromo["totalPromoCodes"],index: index,type: "dm",expiry: currentPromo["expiry"].toDate().toString().split(" ")[0]);
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

                                  SizedBox(height: 50,),
                                  authButton(text: "Create", color: Colors.white, bg: Colors.orange, onPress: ()async{

                                    print("hello");
                                    print("promo code title is"+promoTitle);
                                    print("promo Discount is"+promoDiscount);
                                    print("promo code is"+promoCode);
                                    print("promo total is"+totalPromoCodes);

                                    if(promoTitle!="" && promoDiscount!="" && promoCode!="" && totalPromoCodes!="" && expiryDisplay!="Expiry Date" ){

                                      List promos= data["dm"]["promos"]==null?[]:data["dm"]["promos"];

                                      bool contains=false;

                                      promos.forEach((element) {
                                        var code=element["promoCode"];
                                        if(promoCode.trim()==code){
                                          contains=true;
                                        }
                                      });

                                      if(contains==false){
                                        showLoading(context: context);

                                        print("ifed");

                                        var currentPromos=data["dm"]["promos"];
                                        currentPromos.add(
                                            {
                                              "promoCode":promoCode,
                                              "promoTitle":promoTitle,
                                              "totalPromoCodes":totalPromoCodes,
                                              "promoDiscount":promoDiscount,
                                              "expiry":expiry,
                                            }
                                        );

                                        await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"dm":{"promos":currentPromos}},SetOptions(merge: true));

                                        Navigator.pop(context);
                                      }
                                      else{
                                        showErrorDialogue(context: context, message: "Promo Code Already Exists");
                                      }

                                    }
                                    else{
                                      print("elsed");
                                      showErrorDialogue(context: context, message: "Kindly Fill Out All Promo Details");
                                    }


                                  }, context: context),

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
