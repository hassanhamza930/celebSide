import 'package:celebside/pages/auth/signUp.dart';
import 'package:celebside/util/components.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';



class signupOptions extends StatefulWidget {
  @override
  _signupOptionsState createState() => _signupOptionsState();
}

class _signupOptionsState extends State<signupOptions> {
  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/signupOptions/signupOptionsBack.png",
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Center(
              child: Container(
                width: width*0.8,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                        child: Image.asset(
                      "assets/icon.png",
                      height: 150,
                      fit: BoxFit.contain,)
                    ),
                    Text(
                      "Choose from\nover 1000+\nCelebrities",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "AvenirBold",
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          fontSize: 44
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "To surprise someone on a\nspecial ocassion",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Avenir",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16
                      ),
                    ),
                    SizedBox(height: 50,),
                    //Navigator.push(
                    //                         context,
                    //                         CupertinoPageRoute(builder: (context){
                    //                           return SignUp();
                    //                         })
                    //                       );
                    boxyButton(text: "Create a User Account", color: Colors.white, bg: Colors.orange, onPress: (){
                      Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context){
                            return SignUp();
                          })
                      );
                    }, context: context),
                    SizedBox(height: 20,),
                    // boxyButton(text: "Connect with Google", color: Colors.white, bg: Colors.redAccent, onPress: (){}, context: context) //create new account
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
        ),
      ),
    );
  }
}
