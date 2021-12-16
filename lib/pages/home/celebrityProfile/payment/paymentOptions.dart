import 'package:celebside/pages/home/celebrityProfile/payment/paymentSuccessful.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/paymentUnsuccessful.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var selectedMethod="card";


class paymentOptions extends StatefulWidget {

  final celebId;
  final String type;
  final amount;
  paymentOptions({this.celebId,this.type,this.amount});

  @override
  _paymentOptionsState createState() => _paymentOptionsState();
}

class _paymentOptionsState extends State<paymentOptions> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebId).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          DocumentSnapshot doc=snapshot.data;
          Map data=doc.data();

          return SafeArea(
            child: Scaffold(
                body: Stack(
                  children: [
                    Image.asset(
                      "assets/bluebackground.png",
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                    ),
                    Center(
                      child: Container(
                        width: width*0.9,
                        child: ListView(
                          children: [
                            SizedBox(height: 40,),
                            Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: width*0.9,
                                child: Text(
                                    "Request ${widget.type}",
                                    textAlign: TextAlign.left,
                                    style: medium(color: Colors.white)
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Center(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: width*0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.network("${data["imgSrc"]}",height: 50,fit: BoxFit.contain,),
                                    SizedBox(width: 10,),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "From:\n${data["fullName"]}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "AvenirBold",
                                                fontSize: 22
                                            ),
                                          ),
                                          Text(
                                            "usually delivers video in ${data["responseTime"]} days",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontFamily: "AvenirBold",
                                                fontSize: 17
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: width*0.9,
                                  child: Text(
                                    "Payment Options",
                                    style: TextStyle(
                                        fontSize: 34,
                                        fontFamily: "AvenirBold",
                                        color: Colors.white
                                    ),
                                  )
                              ),
                            ),
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: (){

                                setState(() {
                                  selectedMethod="card";
                                });

                              },
                              child: Center(
                                child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: selectedMethod=="card"?Colors.orange:Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)
                                        )
                                    ),
                                    alignment: Alignment.centerLeft,
                                    width: width*0.9,
                                    child: Text(
                                      "Card",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "Avenir",
                                          color: Colors.black
                                      ),
                                    )
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectedMethod="mobile";
                                });

                              },
                              child: Center(
                                child: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: selectedMethod=="mobile"?Colors.orange:Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)
                                        )
                                    ),
                                    alignment: Alignment.centerLeft,
                                    width: width*0.9,
                                    child: Text(
                                      "Mobile Money",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "Avenir",
                                          color: Colors.black
                                      ),
                                    )
                                ),
                              ),
                            ),

                            SizedBox(height: 20,),
                            inputField(label: "Promo Code", context: context, onChange: (e){}),
                            SizedBox(height: 20,),
                            authButton(text: "Pay", color: Colors.white, bg: Colors.orange, onPress: (){

                              if(selectedMethod=="card"){



                              }

                            }, context: context),
                            SizedBox(height: 50,),

                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left:20,top:40),
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                      ),
                    ),
                  ],
                )
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
