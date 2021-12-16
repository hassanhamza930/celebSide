import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/orderDetails.dart';
import 'package:celebside/pages/home/home.dart';
import 'package:celebside/pages/home/profile/wallet.dart';
import 'package:celebside/pages/home/profile/withdraw.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:celebside/pages/home/home.dart" as Home;

var currentTab = 0;

class invites extends StatefulWidget {
  @override
  _invitesState createState() => _invitesState();
}

class _invitesState extends State<invites> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var conta=context;

    return StreamBuilder(
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
                    height: height * 1.5,
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
                            "Invite",
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
                                borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text("Personal Wallet",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        44, 255, 244, 1),
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold)),
                                            Text(
                                              "Earn Rewards when people join through your links.",
                                              style: small(color: Colors.white),
                                              textAlign: TextAlign.left,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        "¢${data["wallet"]==null?0:data["wallet"]}",
                                        maxLines: 1,
                                        style: mediumBold(color: Colors.white, size: 40),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            CupertinoPageRoute(builder: (context) {
                                              return wallet();
                                            }));
                                      },
                                      child: Image.asset(
                                        "assets/profile/withdraw.png",
                                        height: 70,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                            child: Center(
                                child: Text(
                                  "Promo Code: ${FirebaseAuth.instance.currentUser.uid}",
                                  style: small(color: Colors.white),
                                  textAlign: TextAlign.center,
                                )
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              child: authButton(
                                  text: "Copy Link",
                                  color: Colors.white,
                                  bg: Colors.orange,
                                  onPress: () {
                                    ClipboardManager.copyToClipBoard("${FirebaseAuth.instance.currentUser.uid}");
                                    showMessage(context: context, message: "Copied to Clipboard");
                                  },
                                  context: context,
                                  thin: true),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.7),
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  "Share Via",
                                  style: small(color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(FontAwesomeIcons.whatsapp,
                                        color: Colors.white, size: 40),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    FaIcon(FontAwesomeIcons.facebookMessenger,
                                        color: Colors.white, size: 40),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    FaIcon(FontAwesomeIcons.inbox,
                                        color: Colors.white, size: 40)
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 150,
                          ),
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
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      }
    );
  }
}
