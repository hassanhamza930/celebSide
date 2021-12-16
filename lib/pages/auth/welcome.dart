import 'package:celebside/pages/auth/Login.dart';
import 'package:celebside/pages/auth/signUp.dart';
import 'package:celebside/pages/auth/signupOptions.dart';
import 'package:celebside/pages/celebrity/auth/celebLogin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../celebrity/auth/celebritySplash.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

class welcome extends StatefulWidget {
  @override
  _welcomeState createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/bluebackground.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                Image.asset(
                  'assets/welcome/homeBack.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.5,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  //margin: EdgeInsets.only(bottom:MediaQuery.of(context).size.height *0.2                ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Get a Special\nPersonalized\nVideo From",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 44,
                                  color: Colors.white,
                                  fontFamily: "AvenirBold"),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Your favourite celebrities",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: "Avenir"),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            authButton(
                                text: "Login",
                                color: Colors.orange,
                                onPress: () {
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) {
                                    return Login();
                                  }));
                                },
                                bg: Colors.white,
                                context: context),
                            SizedBox(
                              height: 10,
                            ),
                            authButton(
                                text: "Sign Up",
                                color: Colors.white,
                                bg: Colors.orange,
                                onPress: () {
                                  Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) {
                                    return signupOptions();
                                  }));
                                },
                                context: context),
                            SizedBox(
                              height: 20,
                            ),
                            // GestureDetector(
                            //   onTap: ()async{
                            //
                            //
                            //     final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
                            //
                            //     // Obtain the auth details from the request
                            //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                            //     print(googleUser.email);
                            //     print("this will login to google");
                            //   },
                            //   child: Container(
                            //       width: width,
                            //       child: Row(
                            //         crossAxisAlignment: CrossAxisAlignment.center,
                            //         mainAxisAlignment: MainAxisAlignment.center,
                            //         children: [
                            //           Text(
                            //             "Or Login With",
                            //             style: small(color: Colors.white,size: 14),
                            //           ),
                            //           SizedBox(width: 10,),
                            //           Container(
                            //             padding: EdgeInsets.only(bottom: 5),
                            //               child: Icon(FontAwesomeIcons.google,color: Colors.white,size: 15,)
                            //           )
                            //
                            //         ],
                            //       )),
                            // ),
                            SizedBox(height: 50),
                            authButton(text: "Enroll as a celebrity", color: Colors.white, bg: Colors.blue, onPress: (){
                              Navigator.push(context,CupertinoPageRoute(builder: (context){
                                return celebritySplash();
                              }));
                            }, context: context,thin: true),
                            SizedBox(height: 10),
                            authButton(text: "Login as Celebrity", color: Colors.orange, bg: Colors.white, onPress: (){
                              Navigator.push(context,CupertinoPageRoute(builder: (context){
                                return celebLogin();
                              }));
                            }, context: context,thin:true)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
