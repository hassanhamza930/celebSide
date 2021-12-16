import 'package:celebside/pages/home/celebrityProfile/payment/orderDetails.dart';
import 'package:celebside/pages/home/home.dart';
import 'package:celebside/pages/home/profile/wallet.dart';
import 'package:celebside/pages/home/profile/withdraw.dart';
import 'package:celebside/services/getPayment.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:celebside/pages/home/home.dart" as Home;
import 'package:flutter/cupertino.dart';

var currentTab=0;

var amount= TextEditingController(text: "");
var mobileNumber=TextEditingController(text:"");
var provider="MTN";


class wallet extends StatefulWidget {
  @override
  _walletState createState() => _walletState();
}

class _walletState extends State<wallet> {
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
              height: height,
            ),

            StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
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
                                      Text("¢${data["wallet"]}",style: mediumBold(color: Colors.white,size: 50),),
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
                                var res= await payout(target: "user", amount:  int.parse(amount.text), number: mobileNumber.text , id: FirebaseAuth.instance.currentUser.uid, provider: provider);
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
}
