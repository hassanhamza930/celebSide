import 'package:celebside/pages/auth/createNewPass.dart';
import 'package:celebside/pages/home/home.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Image.asset(
                "assets/forgotPassword/forgotPasswordBack.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.center,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                    child: Container(
                      width:MediaQuery.of(context).size.width*0.9,
                      child: Text(
                        "Forgot password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "AvenirBold",
                          fontSize: 34,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Container(
                      width:MediaQuery.of(context).size.width*0.89,
                      child: Text(
                        "Please enter your email adress,\nYou will recieve a link to create a\nnew password via email",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Avenir",
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100,),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(3),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(24.0))
                      ),
                      child: Center(
                        child: TextField(
                          style: TextStyle(
                              color:Colors.white,
                              fontFamily:'Avenir'
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white,fontFamily:'Avenir'),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding:
                            EdgeInsetsDirectional.only(start: 20.0),
                          ),
                          onChanged: (_onChanged) {
                            print(_onChanged);
                          },
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                        return Home();
                      }));
                    },
                    child: Center(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              gradient: new LinearGradient(
                                colors: [
                                  Colors.orange,
                                  Colors.orange,
                                ],
                              ),
                              borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                          width: MediaQuery.of(context).size.width * 0.9,
                          //height: 50,
                          child: Center(
                            child: Text(
                              "Send",
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
                    ),
                  ),
                  SizedBox(height: 50,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                        return createNewPass();
                      }));
                    },
                    child: Center(
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          width: MediaQuery.of(context).size.width * 0.9,
                          //height: 50,
                          child: Center(
                            child: Text(
                              "Testing Create New Pass",
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
                    ),
                  ),
                ],
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
