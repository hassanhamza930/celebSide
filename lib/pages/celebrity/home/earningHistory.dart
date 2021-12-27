import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/celebrity/home/payouts/payouts.dart';
import 'package:celebside/pages/home/profile/transactions.dart';
import 'package:celebside/services/calculateFinances.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:celebside/pages/home/home.dart" as Home;

var currentTab=0;

class earningHistory extends StatefulWidget {
  @override
  _earningHistoryState createState() => _earningHistoryState();
}

class _earningHistoryState extends State<earningHistory> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
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
                                                "Personal Balance",
                                                style: TextStyle(
                                                    color: Color.fromRGBO(44,255,244,1),
                                                    fontSize: 20,
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
                                    AutoSizeText("¢${data["wallet"].floor()}",maxLines:1,style: mediumBold(color: Colors.white,size: 35),),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, CupertinoPageRoute(builder: (context){
                                          return payouts();
                                        }));
                                      },
                                      child: Image.asset(
                                        "assets/profile/withdraw.png",
                                        height: 50,
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
                                    "Earnings",
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
                                    "Withdrawls",
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
                          currentTab==0?
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

                                var total=0.0;
                                var wallet=double.parse("${data["wallet"]}");
                                docsData.forEach((element) {
                                    total+= double.parse("${element["amount"]}");
                                });
                                var recieved=total-wallet;


                                var totalDiscount=0.0;
                                var dmPrice=double.parse(data["dm"]["price"]).floor();

                                List dmPromos=data["dm"]["promos"];
                                dmPromos.forEach((element) {
                                  var discount=double.parse(element["promoDiscount"]);
                                  var totalPromos=double.parse(element["totalPromoCodes"]);
                                  totalDiscount+= ((dmPrice*(1/discount))*totalPromos).floor();
                                });

                                List videoRequests=data["videoRequest"]["promos"];
                                videoRequests.forEach((element) {
                                  var discount=double.parse(element["promoDiscount"]);
                                  var totalPromos=double.parse(element["totalPromoCodes"]);
                                  totalDiscount+= ((dmPrice*(1/discount))*totalPromos).floor();
                                });

                                List eventBookings=data["eventBooking"]["promos"];
                                eventBookings.forEach((element) {
                                  var discount=double.parse(element["promoDiscount"]);
                                  var totalPromos=double.parse(element["totalPromoCodes"]);
                                  totalDiscount+= ((dmPrice*(1/discount))*totalPromos).floor();
                                });



                                return Center(
                                  child: Container(
                                    width: width*0.8,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: [

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Number of Requests",style: small(color: Colors.white),),
                                            StreamBuilder(
                                              stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).snapshots(),
                                              builder: (context, snapshot) {
                                                if(snapshot.hasData){
                                                  QuerySnapshot data=snapshot.data;
                                                  return Text("${data.docs.length}",style: small(color: Colors.orange),);
                                                }
                                                else{
                                                  return Text("0",style: small(color: Colors.orange));
                                                }
                                              }
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Total Billed",style: small(color: Colors.white),),
                                            FutureBuilder(
                                              future: calculateTotalBilled(celebId: FirebaseAuth.instance.currentUser.uid),
                                              builder: (context, snapshot) {
                                                if(snapshot.hasData){
                                                  return Text("¢${snapshot.data}",style: small(color: Colors.orange),);
                                                }
                                                else{
                                                  return Text("¢0",style: small(color: Colors.orange),);
                                                }
                                              }
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Fees Charged",style: small(color: Colors.white),),
                                            FutureBuilder(
                                                future: calculateFeesCharged(celebId: FirebaseAuth.instance.currentUser.uid),
                                                builder: (context, snapshot) {
                                                  if(snapshot.hasData){
                                                    return Text("¢${snapshot.data}",style: small(color: Colors.orange),);
                                                  }
                                                  else{
                                                    return Text("¢0",style: small(color: Colors.orange),);
                                                  }
                                                }
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Net After Fees",style: small(color: Colors.white),),
                                            FutureBuilder(
                                                future: calculateNetAfterFees(celebId: FirebaseAuth.instance.currentUser.uid),
                                                builder: (context, snapshot) {
                                                  if(snapshot.hasData){
                                                    return Text("¢${snapshot.data}",style: small(color: Colors.orange),);
                                                  }
                                                  else{
                                                    return Text("¢0",style: small(color: Colors.orange),);
                                                  }
                                                }
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Discount",style: small(color: Colors.white),),
                                            FutureBuilder(
                                                future: calculateDiscount(celebId: FirebaseAuth.instance.currentUser.uid),
                                                builder: (context, snapshot) {
                                                  if(snapshot.hasData){
                                                    return Text("¢${snapshot.data}",style: small(color: Colors.orange),);
                                                  }
                                                  else{
                                                    return Text("¢0",style: small(color: Colors.orange),);
                                                  }
                                                }
                                            ),                                          ],
                                        ),


                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Pending Earnings",style: small(color: Colors.white),),
                                            Text("¢${data["wallet"]}",style: small(color: Colors.orange),),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Recieved Earnings",style: small(color: Colors.white),),
                                            FutureBuilder(
                                                future: calculateRecievedEarnings(celebId: FirebaseAuth.instance.currentUser.uid),
                                                builder: (context, snapshot) {
                                                  if(snapshot.hasData){
                                                    return Text("¢${snapshot.data}",style: small(color: Colors.orange),);
                                                  }
                                                  else{
                                                    return Text("¢0",style: small(color: Colors.orange),);
                                                  }
                                                }
                                            ),
                                          ],
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
                          ):
                          StreamBuilder(
                              stream: FirebaseFirestore.instance.collection("transactions").where("from",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("to",isEqualTo: "self").snapshots(),
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

                                        return transactionRow(message: currentDoc["message"],createdAt: currentDoc["createdAt"],amount: currentDoc["amount"],flow: currentDoc["flow"],from: currentDoc["from"],to: currentDoc["to"],);
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
                          // Container(
                          //   child: Center(
                          //     child: Text("You Haven't made any withdrawls",style: small(color: Colors.white),),
                          //   ),
                          // )

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
          return Container();
        }

      }
    );
  }
}
