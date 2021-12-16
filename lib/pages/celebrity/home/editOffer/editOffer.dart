import 'package:celebside/pages/celebrity/home/createOffer/components.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeDms.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeEventBookings.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeFanClub.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeShoutouts.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class editOffer extends StatefulWidget {
  @override
  _editOfferState createState() => _editOfferState();
}

class _editOfferState extends State<editOffer> {
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
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Text(
                            "Schedule/Edit Offers",
                            style: medium(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: width * 0.8,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,CupertinoPageRoute(builder: (context){
                                  return customizeShoutouts();
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.orange),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.videocam,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Shoutouts",
                                        textAlign: TextAlign.center,
                                        style: small(color: Colors.white)),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("¢${data["videoRequest"]["price"]}",
                                        textAlign: TextAlign.center,
                                        style: smallBold(color: Colors.white)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Icon(Icons.edit,color: Colors.blue,)

                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Text(
                              "Response Time: ${data["videoRequest"]["responseTime"]} Days ",
                              style: small(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(value:data["videoRequest"]["charity"], onChanged: (e) {}),
                              Flexible(
                                  child: Text(
                                    "Charity",
                                    style: small(color: Colors.white, size: 14),
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(value: data["videoRequest"]["hidden"], onChanged: (e) {}),
                              Flexible(
                                  child: Text(
                                    "Hidden ",
                                    style: small(color: Colors.white, size: 14),
                                  ))
                            ],
                          ),
                          
                          SizedBox(
                            height: 10,
                          ),
                          // Text("All Promo Codes",style: mediumBold(color: Colors.orange,size: 20),textAlign: TextAlign.center,),
                          // SizedBox(height: 10,),
                          // Container(
                          //   width: width,
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Flexible(child: Text("Title",style: smallBold(color: Colors.white),)),
                          //       Flexible(child: Text("Discount",style:smallBold(color: Colors.white),)),
                          //       Flexible(child: Text("Code",style: smallBold(color: Colors.white),)),
                          //       Flexible(child: Text("Amount",style: smallBold(color: Colors.white),)),
                          //       TextButton(onPressed: ()async{},child: Icon(Icons.remove,color: Colors.transparent,),)
                          //     ],
                          //   ),
                          // ),
                          // data["videoRequest"]["promos"].length==0?Container(margin: EdgeInsets.only(top:10,bottom: 10),child: Text("All promo codes will be shown here",textAlign: TextAlign.center,style: small(color: Colors.white,size: 14),)):
                          // ListView.builder(
                          //     physics: NeverScrollableScrollPhysics(),
                          //     shrinkWrap: true,
                          //     itemCount: data["videoRequest"]["promos"].length,
                          //     itemBuilder: (context,index){
                          //       var currentPromo=data["videoRequest"]["promos"][index];
                          //       return promoCodeRow(promoTitle: currentPromo["promoTitle"],promoCode:currentPromo["promoCode"],promoDiscount: currentPromo["promoDiscount"],totalPromoCodes: currentPromo["totalPromoCodes"],index: index,type: "eventBooking",);
                          //     }
                          // ),
                          SizedBox(height: 10,),
                          Divider(
                            thickness: 1,
                            height: 1,
                            color: Colors.white38,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: width * 0.8,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,CupertinoPageRoute(builder: (context){
                                  return customizeDms();
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.white),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.message,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Send DM",
                                        textAlign: TextAlign.center,
                                        style: small(color: Colors.orange)),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("¢${data["dm"]["price"]}",
                                        textAlign: TextAlign.center,
                                        style: smallBold(color: Colors.orange)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Icon(Icons.edit,color: Colors.blue,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Text(
                              "Response Time: ${data["dm"]["responseTime"]} Days ",
                              style: small(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(value: data["dm"]["charity"], onChanged: (e) {}),
                              Flexible(
                                  child: Text(
                                    "Charity ",
                                    style: small(color: Colors.white, size: 14),
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(value: data["dm"]["hidden"], onChanged: (e) {}),
                              Flexible(
                                  child: Text(
                                    "Hidden ",
                                    style: small(color: Colors.white, size: 14),
                                  ))
                            ],
                          ),
                          
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            thickness: 1,
                            height: 1,
                            color: Colors.white38,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: width * 0.8,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,CupertinoPageRoute(builder: (context){
                                  return customizeEventBooking();
                                }));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.orange),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.calendarCheck,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Event Booking",
                                        textAlign: TextAlign.center,
                                        style: small(color: Colors.white)),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("¢${data["eventBooking"]["budgetFrom"]} to ¢${data["eventBooking"]["budgetTo"]}",
                                        textAlign: TextAlign.center,
                                        style: smallBold(color: Colors.white)),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Icon(Icons.edit,color: Colors.blue,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Text(
                              "Response Time: ${data["eventBooking"]["responseTime"]} Days ",
                              style: small(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(value: data["eventBooking"]["charity"], onChanged: (e) {}),
                              Flexible(
                                  child: Text(
                                    "Charity ",
                                    style: small(color: Colors.white, size: 14),
                                  ))
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(value: data["eventBooking"]["hidden"], onChanged: (e) {}),
                              Flexible(
                                  child: Text(
                                    "Hidden ",
                                    style: small(color: Colors.white, size: 14),
                                  ))
                            ],
                          ),
                          
                          SizedBox(
                            height: 20,
                          ),
                          // Divider(
                          //   thickness: 1,
                          //   height: 1,
                          //   color: Colors.white38,
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                         //  Container(
                         //    width: width * 0.8,
                         //    child: GestureDetector(
                         //      onTap: () {
                         //        Navigator.push(context,CupertinoPageRoute(builder: (context){
                         //          return customizeFanClub();
                         //        }));
                         //      },
                         //      child: Container(
                         //        padding: EdgeInsets.all(10),
                         //        decoration: BoxDecoration(
                         //            borderRadius: BorderRadius.all(
                         //              Radius.circular(20),
                         //            ),
                         //            color: Colors.white),
                         //        child: Row(
                         //          mainAxisAlignment: MainAxisAlignment.center,
                         //          children: [
                         //            Icon(
                         //              Icons.message,
                         //              color: Colors.blue,
                         //            ),
                         //            SizedBox(
                         //              width: 10,
                         //            ),
                         //            Text("Fan Club Offers",
                         //                textAlign: TextAlign.center,
                         //                style: small(color: Colors.orange)),
                         //            SizedBox(
                         //              width: 25,
                         //            ),
                         //            Icon(Icons.edit,color: Colors.blue,)
                         //          ],
                         //        ),
                         //      ),
                         //    ),
                         //  ),
                         // SizedBox(height: 20,),
                         //  Container(
                         //      padding: EdgeInsets.only(left: 10, right: 10),
                         //      child: Text(
                         //        "Manage Promos and Discounts",
                         //        style: small(color: Colors.orange, size: 14),
                         //      )),
                          SizedBox(height: 100,)
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
