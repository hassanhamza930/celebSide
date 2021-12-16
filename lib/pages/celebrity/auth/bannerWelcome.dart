import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:font_awesome_flutter/font_awesome_flutter.dart';


var currentBanner=0;

class bannerWelcome extends StatefulWidget {
  @override
  _bannerWelcomeState createState() => _bannerWelcomeState();
}

class _bannerWelcomeState extends State<bannerWelcome> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: [
          Container(
            height: height * 0.27,
            width: width * 0.8,
            child: PageView(
              onPageChanged: (val) {
                setState(() {
                  currentBanner = val;
                });
              },
              scrollDirection: Axis.horizontal,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    width: width * 0.8,
                    height: height * 0.27,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Monetization",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: "AvenirBold",
                                      color: Colors.orange),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.moneyBillAlt,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "Monitize your free time, proceed with orders in your free time",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "Avenir",
                                      color: Colors.black),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    width: width * 0.8,
                    height: height * 0.27,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Personal Connection",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: "AvenirBold",
                                      color: Colors.orange),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.connectdevelop,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "Create messages for fans for their personal occasions; birthdays, anniversaries, be it any celebration.",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "Avenir",
                                      color: Colors.black),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    width: width * 0.8,
                    height: height * 0.27,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  "Spreading Happiness",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontFamily: "AvenirBold",
                                      color: Colors.orange),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              FaIcon(
                                FontAwesomeIcons.smile,
                                color: Colors.blue,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "Create a unique experience like never before. Your fan will be left with a lasting impression of you.",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: "Avenir",
                                      color: Colors.black),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                color: currentBanner == 0 ? Colors.orange : Colors.white,
                size: 12,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.circle,
                color: currentBanner == 1 ? Colors.orange : Colors.white,
                size: 12,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.circle,
                color: currentBanner == 2 ? Colors.orange : Colors.white,
                size: 12,
              ),
            ],
          )
        ],
      ),
    );
  }
}


