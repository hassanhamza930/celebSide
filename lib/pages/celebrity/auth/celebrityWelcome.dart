import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'bannerWelcome.dart';
import 'celebLogin.dart';
import '../home/celebrityHome.dart';
import 'celebritySignup.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
class celebrityWelcome extends StatefulWidget {
  @override
  _celebrityWelcomeState createState() => _celebrityWelcomeState();
}

class _celebrityWelcomeState extends State<celebrityWelcome> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/celebrityWelcome/celebrityWelcomeBack.png",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            height: height ,
            width: width,
            child: Center(
                child: Container(
                  width: width * 0.9,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                          child: Image.asset(
                            "assets/icon.png",
                            height: 100,
                            fit: BoxFit.contain,
                          )),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Why Join LetsVibe?",
                        style: mediumBold(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      bannerWelcome(),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: authButton(
                            text: "Enroll as Celebrity",
                            color: Colors.white,
                            bg: Colors.blue,
                            onPress: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                    return celebSignup();
                                  }));
                            },
                            context: context,
                            thin: true),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Enrolled?  ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (context) {
                                    return celebLogin();
                                  }));
                            },
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17, color: Colors.orange),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );


  }
}
