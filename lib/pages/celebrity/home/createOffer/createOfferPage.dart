import 'package:celebside/pages/celebrity/home/createOffer/customizeDms.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeEventBookings.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeFanClub.dart';
import 'package:celebside/pages/celebrity/home/createOffer/customizeShoutouts.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class createOfferPage extends StatefulWidget {
  @override
  _createOfferPageState createState() => _createOfferPageState();
}

class _createOfferPageState extends State<createOfferPage> {
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
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                width: width * 0.9,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Create Offer",
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
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
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
                              Text("Record and Send Shoutouts",
                                  textAlign: TextAlign.center,
                                  style: small(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Edit and customise your page for fans’ personalised video request.",
                        style: small(color: Colors.white, size: 14),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: width * 0.8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
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
                              Text("Direct Messages",
                                  textAlign: TextAlign.center,
                                  style: small(color: Colors.orange)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Edit and customise your page for direct messages with your fans.",
                        style: small(color: Colors.white, size: 14),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: width * 0.8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Edit and customise your offers for Event Bookings",
                        style: small(color: Colors.white, size: 14),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: width * 0.8,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (context) {
                            return customizeFanClub();
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
                              Text("Fan Club Offers",
                                  textAlign: TextAlign.center,
                                  style: small(color: Colors.orange)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        "Edit and customise your offers for your Fan club members",
                        style: small(color: Colors.white, size: 14),
                      ),
                    ),
                  ],
                ),
              ),
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
