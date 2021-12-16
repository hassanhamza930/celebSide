import 'package:celebside/pages/home/home.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';

var details = false;

class paymentSuccessful extends StatefulWidget {
  @override
  _paymentSuccessfulState createState() => _paymentSuccessfulState();
}

class _paymentSuccessfulState extends State<paymentSuccessful> {
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
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          ListView(
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: width * 0.9,
                  child: Text(
                    "Payment Method",
                    textAlign: TextAlign.left,
                    style: medium(color: Colors.white)
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/paymentSuccessful/person.png",
                height: height * 0.4,
                fit: BoxFit.contain,
              ),
              Center(
                child: Container(
                    alignment: Alignment.center,
                    width: width * 0.9,
                    child: Text(
                      "Payment Successful",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 34,
                          fontFamily: "AvenirBold",
                          color: Colors.white),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              details
                  ? Center(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orange,
                            width: 3,
                          )
                        ),
                        width: width * 0.9,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "See Details",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                                FloatingActionButton(
                                  mini: true,
                                  backgroundColor: Colors.orange,
                                  onPressed: () {
                                    setState(() {
                                      details = !details;
                                    });
                                  },
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transaction ID",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Vibe Video 0012",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Payment",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                                Text(
                                  "MTN Momo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Avenir",
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          details = !details;
                        });
                      },
                      child: Center(
                        child: Container(
                          width: width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "See Details",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Avenir",
                                    fontSize: 17,
                                    color: Colors.white),
                              ),
                              FloatingActionButton(
                                mini: true,
                                backgroundColor: Colors.orange,
                                onPressed: () {
                                  setState(() {
                                    details = !details;
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_forward_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      currentTab = 1;
                    });

                    Navigator.pushReplacement(context,
                        CupertinoPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: width * 0.8,
                      child: Text(
                        "Okay",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "AvenirBold",
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
            ],
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
      )),
    );
  }
}
