import 'celebrityWelcome.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';

class celebritySplash extends StatefulWidget {
  @override
  _celebritySplashState createState() => _celebritySplashState();
}

class _celebritySplashState extends State<celebritySplash> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1),(){
      Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
              builder: (context){
                return celebrityWelcome();
              }
          )
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          Image.asset(
              "assets/bluebackground.png",
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
          ),
          Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png"),
                Text(
                    "For Celebs",
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: "Avenir",
                    color: Colors.white
                  ),
                )
              ],
            )
          )
        ],
      )
    );
  }
}
