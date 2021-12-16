import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/celebrity/home/payment/paymentSucessful.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/paymentSuccessful.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:celebside/pages/home/celebrityProfile/payment/orderDetails.dart';
import 'package:celebside/pages/home/home.dart';
import 'package:celebside/pages/home/profile/wallet.dart';
import 'package:celebside/pages/home/profile/withdraw.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:celebside/pages/home/home.dart" as Home;
import "package:celebside/services/getPayment.dart";

var currentTab=0;
var currentMethod=0;
var currentItem;
var check=false;
var amount=TextEditingController(text: "");
var mobileNumber=TextEditingController(text:"");
var provider="MTN";


class payouts extends StatefulWidget {
  @override
  _payoutsState createState() => _payoutsState();
}

class _payoutsState extends State<payouts> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
      builder: (context, snapshot) {


        if(snapshot.hasData){
          Map data= snapshot.data.data();

          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Image.asset(
                    "assets/bluebackground.png",
                    fit: BoxFit.cover,
                    width: width,
                    height: height,
                  ),
                  Center(
                    child: Container(
                      width: width * 0.9,
                      child: ListView(
                        children: [


                          SizedBox(
                            height: 40,
                          ),

                          Text(
                            "Payouts",
                            style: medium(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(24, 48, 93, 1),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.moneyCheck,
                                      color: Colors.lightBlue,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Total Earnings",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(44,255,244,1),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                )
                                            ),
                                            Text(
                                                "All Earnings from completed requests",
                                                style: TextStyle(
                                                    color: Colors.white.withOpacity(0.87),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AutoSizeText("¢${data["wallet"]}",maxLines: 1,style: mediumBold(color: Colors.white,size: 50),),
                                  ],
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          // Center(child: Text("You will be charged 10 GHS for this transaction",style: small(color: Colors.white,size: 14),)),
                          SizedBox(height: 20,),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left:5,bottom:5),
                                child: Row(
                                  children: [
                                    Text("Amount",style: smallBold(color: Colors.white),)
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  inputField(label: "GHS", context: context, onChange: (e){},controller: amount),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          currentMethod=0;
                                          provider="MTN";
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(
                                                color: currentMethod==0?Colors.orange:Colors.white,
                                                width: 3
                                            )
                                        ),
                                        child: Image.asset(
                                          "assets/profile/1.png",
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          currentMethod=1;
                                          provider="vod";
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(
                                                color: currentMethod==1?Colors.orange:Colors.white,
                                                width: 3
                                            )
                                        ),
                                        child: Image.asset(
                                          "assets/profile/2.png",
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          currentMethod=2;
                                          provider="tgo";
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            border: Border.all(
                                                color: currentMethod==2?Colors.orange:Colors.white,
                                                width: 3
                                            )
                                        ),
                                        child: Image.asset(
                                          "assets/profile/3.png",
                                          height: 50,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left:5,bottom:5),
                                    child: Row(
                                      children: [
                                        Text("Mobile Number",style: smallBold(color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      inputField(label: "Your Mobile Number here", context: context, onChange: (e){},controller: mobileNumber ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          authButton(text: "Withdraw", color: Colors.white, bg: Colors.orange, onPress: ()async{

                            showLoading(context: context);

                            if(amount.text!="" && mobileNumber.text!="" && provider!=""){
                              var res= await payout(target: "celebrity", amount:  int.parse(amount.text), number: mobileNumber.text , id: FirebaseAuth.instance.currentUser.uid, provider: provider);
                              Navigator.pop(context);
                              showMessage(context: context, message: res["message"]);
                            }
                            else{
                              Navigator.pop(context);
                              showErrorDialogue(context: context, message: "Kindly enter all details properly.");
                            }



                          }, context: context),

                          SizedBox(height: 150,),

                        ],
                      ),
                    ),
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
                      )),
                ],
              ),
            ),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      }
    );
  }
}
