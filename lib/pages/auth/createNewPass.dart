import 'package:celebside/pages/home/home.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';

class createNewPass extends StatefulWidget {
  @override
  _createNewPassState createState() => _createNewPassState();
}

class _createNewPassState extends State<createNewPass> {
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
        body: Stack(
          children: [
            Image.asset(
              "assets/bluebackground.png",
              width: width,
              fit: BoxFit.cover,
              height: height,
            ),
            Image.asset(
              "assets/createPass/newPassBack.png",
              width: width,
              fit: BoxFit.cover,
              height: height/2,
            ),
            Image.asset(
              "assets/createPass/grad.png",
              width: width,
              fit: BoxFit.cover,
              height: height,
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
                        "Create New Password",
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
                        "Your new password must be different from previous password",
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
                            labelText: 'Password',
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
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(left: 10,top: 5),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        "Must be atleast 8 characters",
                        style: small(color: Colors.orange,size: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
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
                            labelText: 'Confirm Password',
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
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(3),
                      margin: EdgeInsets.only(left: 10,top: 5),
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        "Must be atleast 8 characters",
                        style: small(color: Colors.orange,size: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,),

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
                              "Reset Password",
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
        )
    );
  }
}
