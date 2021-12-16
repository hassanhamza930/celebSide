import 'package:celebside/pages/home/celebrityProfile/payment/paymentSuccessful.dart';
import 'package:celebside/services/getPayment.dart';
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
import 'package:flutter/cupertino.dart';


var currentTab=0;
var currentMethod=0;
var currentItem;
var check=false;

var mobileNumber=TextEditingController(text: "");
var bank="";
var accountName=TextEditingController(text: "");
var accountNumber= TextEditingController(text: "");
var tos=false;


class withdraw extends StatefulWidget {
  @override
  _withdrawState createState() => _withdrawState();
}

class _withdrawState extends State<withdraw> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasData){
          Map data=snapshot.data.data();

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
                            "Wallet",
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
                                                "Personal Refund",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(44,255,244,1),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold
                                                )
                                            ),
                                            Text(
                                              "Refund from uncompleted requests",
                                              style: small(color: Colors.white),
                                              textAlign: TextAlign.left,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),

                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("¢${data["wallet"]==null?0:data["wallet"]}",style: mediumBold(color: Colors.white,size: 50),),
                                  ],
                                )
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),
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
                              Container(
                                padding: EdgeInsets.only(left:5,bottom:5),
                                child: Row(
                                  children: [
                                    Text("Minimum withdrawl limit is ¢100",style: small(color: Colors.white,size: 14),)
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  inputField(label: "Amount", context: context, onChange: (e){}),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    currentTab=0;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: currentTab==0?Colors.orange:Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                  width: width * 0.42,
                                  child: Text(
                                    "Mobile Money",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontFamily: "Avenir"),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    currentTab=1;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: currentTab==1?Colors.orange:Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                  width: width * 0.42,
                                  child: Text(
                                    "Bank Account",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontFamily: "Avenir"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          currentTab==0?Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          currentMethod=0;
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
                                      inputField(label: "Your Mobile Number here", context: context, onChange: (e){},controller: mobileNumber),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ):
                          Column(
                            children: [
                              Container(
                                width: width*0.9,
                                padding: EdgeInsets.only(left:20,top:3,bottom: 3,right: 20),
                                decoration:BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24.0))
                                ),
                                child: DropdownButton<String>(
                                  value: currentItem,
                                  style: small(color: Colors.white),
                                  dropdownColor: Colors.black,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      currentItem = newValue;
                                    });
                                  },
                                  hint: Text(
                                    "Select Bank",
                                    style: small(color: Colors.white),
                                  ),
                                  items: <String>['UBL', 'HBL'].map<DropdownMenuItem<String>>((String value) {
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
                              SizedBox(height: 20,),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left:5,bottom:5),
                                    child: Row(
                                      children: [
                                        Text("Account Name",style: smallBold(color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      inputField(label: "Enter your account Name", context: context, onChange: (e){}),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left:5,bottom:5),
                                    child: Row(
                                      children: [
                                        Text("Account Number",style: smallBold(color: Colors.white),)
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      inputField(label: "Enter your account Number", context: context, onChange: (e){}),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(value: check, onChanged: (val) {
                                    setState(() {
                                      check=!check;
                                    });
                                  }),
                                  Flexible(
                                    child: Text(
                                      "I Agree to the Terms and Conditions",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Avenir",
                                          fontSize: 17),
                                      textAlign: TextAlign.center,
                                    )
                                    ,
                                  ),
                                ],
                              ),
                              Container(
                                width: width*0.8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "( Tick if you have read and agree to all terms and conditions by LetsVibe as a talent )",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Avenir",
                                            fontSize: 14),
                                        textAlign: TextAlign.left,
                                      )
                                      ,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          authButton(text: "Withdraw", color: Colors.white, bg: Colors.orange, onPress: ()async{


                            // Navigator.pushReplacement(context,CupertinoPageRoute(builder: (context){
                            //   return paymentSuccessful();
                            // }));


                            if(currentTab==0){
                            }
                            else{
                              showErrorDialogue(context: context, message: "Only Supporting Mobile Money");
                            }


                          }, context: context),

                          SizedBox(height: 150,),

                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: height,
                    width: width,
                    child: Container(
                      height: 70,
                      padding:
                      EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 10),
                      color: Color.fromRGBO(24, 48, 93, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                print("one");
                                setState(() {
                                  Home.currentTab = 0;
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
                                            Home.currentTab == 0
                                                ? Colors.orange
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
                                        color: Home.currentTab == 0
                                            ? Colors.orange
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
                                  Home.currentTab = 1;
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
                                            Home.currentTab == 1
                                                ? Colors.orange
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
                                        color: Home.currentTab == 1
                                            ? Colors.orange
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
                                  Home.currentTab = 2;
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
                                            Home.currentTab == 2
                                                ? Colors.orange
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
                                        color: Home.currentTab == 2
                                            ? Colors.orange
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
                                  Home.currentTab = 3;
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
                                            Home.currentTab == 3
                                                ? Colors.orange
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
                                        color: Home.currentTab == 3
                                            ? Colors.orange
                                            : Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ), // NAVBAR
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
          return Container();
        }

      }
    );
  }
}
