import 'package:celebside/pages/auth/ForgotPassword.dart';
import 'package:celebside/services/celebrityLogin.dart';
import 'package:celebside/util/styles.dart';
import 'celebrityForgotPassword.dart';
import '../home/celebrityHome.dart';
import 'celebrityNotifications.dart';
import 'package:celebside/util/components.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';

var email="";
var password="";
var hide=true;

class celebLogin extends StatefulWidget {
  @override
  _celebLoginState createState() => _celebLoginState();
}

class _celebLoginState extends State<celebLogin> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/login/loginBack.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Center(
              child: Container(
                width: width*0.9,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          "Welcome Back",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "AvenirBold",
                            fontSize: 34,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.89,
                        child: Text(
                          "Login to your account",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Avenir",
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    inputField(label: "Email", context: context, onChange: (e){
                      setState(() {
                        email=e;
                      });
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(18.0))),
                      child: Center(
                        child: TextField(
                          obscureText: hide,
                          style: small(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: TextButton(
                                onPressed: () {
                                  setState(() {
                                    hide = !hide;
                                  });
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.black,
                                )),
                            labelText: "Password",
                            labelStyle: small(color: Colors.white),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: EdgeInsetsDirectional.only(start: 20),
                          ),
                          onChanged: (e) {
                            setState(() {
                              password=e;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    authButton(text: "Login", color: Colors.white, bg: Colors.orange, onPress: ()async{


                      showLoading(context: context);


                      var status=await celebrityLogin(email: email,password: password);

                      if(status["message"]=="signed in"){
                        Navigator.pop(context);
                        Navigator.of(context)
                            .pushAndRemoveUntil(CupertinoPageRoute(builder: (context){return celebrityHome();}), (Route<dynamic> route) => false);

                      }
                      else{
                        Navigator.pop(context);
                        showErrorDialogue(context: context, message: "${status["message"]}");
                      }




                    },
                        context: context),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                              return celebrityForgotPassword();
                            }));
                      },
                      child: Center(
                        child: Container(
                          child: Text(
                            "Forgot your password?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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
}
