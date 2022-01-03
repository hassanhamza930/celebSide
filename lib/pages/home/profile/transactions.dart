import 'package:celebside/pages/home/celebrityProfile/payment/orderDetails.dart';
import 'package:celebside/pages/home/home.dart';
import 'package:celebside/pages/home/profile/invites.dart';
import 'package:celebside/pages/home/profile/wallet.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:celebside/pages/home/home.dart" as Home;
import 'package:flutter/cupertino.dart';

class transactionRow extends StatefulWidget {

  final String message;
  final String to;
  final String from;
  final double amount;
  final Timestamp createdAt;



  transactionRow({
    this.amount,
    this.message,
    this.from,
    this.to,
    this.createdAt
});

  @override
  _transactionRowState createState() => _transactionRowState();
}

class _transactionRowState extends State<transactionRow> {



  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;


    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            color: Colors.white70,
            width: width,
            height: 2,
          ),
          Container(
            margin: EdgeInsets.only(top:10,bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width*0.7,
                  child: Row(
                    children: [
                      Container(
                          height: 40,
                          width: 40,
                          //padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                          ) ,
                          child: Center(child: Icon(widget.to==FirebaseAuth.instance.currentUser.uid?Icons.arrow_downward:Icons.arrow_upward,color: Colors.black,size: 20,))),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.message}",style: smallBold(color: Colors.white),textAlign: TextAlign.left,),
                            Text("${widget.to==FirebaseAuth.instance.currentUser.uid?"Debited":"Credited"} on: ${widget.createdAt.toDate()}",style: small(color: Colors.white),textAlign: TextAlign.left,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width*0.2,
                    child: Text("¢${widget.amount}",style: smallBold(color: Colors.white),)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}







class transactions extends StatefulWidget {
  @override
  _transactionsState createState() => _transactionsState();
}

class _transactionsState extends State<transactions> {
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
            Center(
              child: Container(
                width: width*0.9,
                child: ListView(
                  children: [
                    SizedBox(height: 40,),
                    Text("Transaction History",style: medium(color: Colors.white),textAlign: TextAlign.center,),
                    SizedBox(height: 50,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,CupertinoPageRoute(builder: (context){
                          return invites();
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(24, 48, 93, 1),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FaIcon(FontAwesomeIcons.moneyCheck,color: Colors.lightBlue,size: 40,),
                            SizedBox(width: 10,),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Personal Refund Balance",style: smallBold(color: Colors.white),textAlign: TextAlign.left,),
                                  Text("Refund from uncompleted requests",style: small(color: Colors.white,size: 14),textAlign: TextAlign.left,)
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                   SizedBox(height: 30,),
                   StreamBuilder(
                     stream: FirebaseFirestore.instance.collection("transactions").where("from",isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots(),
                     builder: (context, snapshot) {

                       if(snapshot.hasData){
                         List docs=snapshot.data.docs;
                         List docsData=[];
                         docs.forEach((element) {
                           docsData.add(element);
                         });

                         docsData.sort((a, b) => (b["createdAt"]).compareTo(a["createdAt"]));
                         // docsData=docsData.reversed.toList(growable: true);
                         
                         return ListView.builder(
                             physics: NeverScrollableScrollPhysics(),
                             shrinkWrap: true,
                             itemCount: docsData.length,
                             itemBuilder: (context,index){

                               var currentDoc=docsData[index];

                               return transactionRow(message: currentDoc["message"],createdAt: currentDoc["createdAt"],amount: currentDoc["amount"],from: currentDoc["from"],to: currentDoc["to"],);
                             }
                         );
                       }
                       else{
                         return Center(
                           child: CircularProgressIndicator(),
                         );
                       }

                     }
                   )



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
