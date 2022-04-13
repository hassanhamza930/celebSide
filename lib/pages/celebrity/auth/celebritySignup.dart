
import 'package:celebside/pages/auth/notificationPermission.dart';
import 'package:celebside/services/celebritySignup.dart';
import 'package:flutter/services.dart';
import 'celebLogin.dart';
import '../home/celebrityHome.dart';
import 'celebrityNotifications.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';

var dobDisplay = "Date of Birth";
bool hide = true;
var currentItem;
var fullName="";
var email="";
var phone="";
var countryCode="+233";
var country="Ghana";
DateTime dob;
var password="";
var mostFollowers="";
var handle="";
bool hasReferral=false;
var referral = "";
var currentItemDisplay="Where do you have most followers?";
var referralCode=TextEditingController(text:"");


class celebSignup extends StatefulWidget {
  @override
  _celebSignupState createState() => _celebSignupState();
}

class _celebSignupState extends State<celebSignup> {
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Center(
                child: Container(
              width: width * 0.9,
              child: ListView(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Sign Up",
                    style: mediumBold(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Let’s get to know you so can start monetising requests from fans",
                    style: small(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  inputField(
                      label: "Full Name",
                      context: context,
                      onChange: (e) {
                        print(e);
                        setState(() {
                          fullName=e;
                        });
                      }), //username
                  SizedBox(
                    height: 10,
                  ),
                  inputField(
                      label: "Email",
                      context: context,
                      onChange: (e) {
                        print(e);
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
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.all(Radius.circular(24.0))),
                    child: Row(
                      children: [
                        CountryCodePicker(
                          initialSelection: "Ghana",
                          textStyle: small(color: Colors.white),
                          onChanged: (e){
                            setState(() {
                              countryCode=e.dialCode;
                              country=e.name;
                            });
                          },
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextField(
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            maxLength: 10,
                            style: small(color: Colors.white),
                            decoration: InputDecoration(
                              counterText: "",
                              labelStyle: small(color: Colors.white),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding:
                                  EdgeInsetsDirectional.only(start: 20),
                            ),
                            onChanged: (e) {
                              setState(() {
                                phone="${0}$e";
                                print(phone);
                              });
                            },
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(1920, 1, 1),
                          maxTime: DateTime(2021, 8, 20), onChanged: (date) {
                        print('change $date');
                      }, onConfirm: (date) {
                        setState(() {
                          dob = date;
                          dobDisplay=date.toString().split(" ")[0];
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                    },
                    child: Container(
                      padding: EdgeInsets.all(3),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius:
                              BorderRadius.all(Radius.circular(24.0))),
                      child: Center(
                        child: TextField(
                          enabled: false,
                          style: small(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: "${dobDisplay}",
                            labelStyle: small(color: Colors.white),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding:
                                EdgeInsetsDirectional.only(start: 20),
                          ),
                          onChanged: (e) => {},
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.all(Radius.circular(24.0))),
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
                    height: 10,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 20, top: 3, bottom: 3, right: 20),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.all(Radius.circular(24.0))),
                    child: DropdownButton<String>(
                      value: currentItem,
                      style: small(color: Colors.white),
                      dropdownColor: Colors.black,
                      onChanged: (String newValue) {
                        setState(() {
                          mostFollowers = newValue;
                          currentItemDisplay=newValue;
                        });
                      },
                      hint: Center(
                        child: Text(
                          "${currentItemDisplay}",
                          style: small(color: Colors.white, size: 15),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      items: <String>[
                        "Instagram",
                        "Facebook",
                        "Twitter",
                        "Youtube"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            //style: small(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  inputField(
                      label: "Your Handle",
                      context: context,
                      onChange: (e) {
                        print(e);
                        setState(() {
                          handle=e;
                        });
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  authButton(
                      text: "Sign Up",
                      color: Colors.white,
                      bg: Colors.orange,
                      onPress: () async{

                        try{
                          showLoading(context: context);

                          var status = await celebritySignup(fullName: fullName,
                              email: email,
                              phone: phone,
                              countryCode: countryCode,
                              country: country,
                              dob: dob,
                              password: password,
                              mostFollowers: mostFollowers,
                              handle: handle,
                              hasReferral: hasReferral,
                              referral: referral);
                          if (status["message"] == "created") {
                            Navigator.pop(context);

                            Navigator.of(context).pushAndRemoveUntil(
                                CupertinoPageRoute(builder: (context) {
                                  return celebrityNotifications();
                                }), (Route<dynamic> route) => false);
                          }
                          else {
                            Navigator.pop(context);

                            showErrorDialogue(context: context,
                                message: "${status["message"]}");
                          }
                        }

                          catch(e){
                            showErrorDialogue(context: context,
                                message: e.toString());
                          }



                      },
                      context: context),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: Text(
                          "Note: you are not automatically enrolled on LestVibe. If you meet the eligibility requirements, a talent representative will contact you within a few days to finish onboarding",
                          style: small(color: Colors.orange, size: 14),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "Already Entrolled?",
                          style: small(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context, CupertinoPageRoute(
                              builder:(context){
                                return celebLogin();
                              }
                          ));
                        },
                        child: Text(
                          "Login",
                          style: small(color: Colors.orange),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          "By clicking Sign up you agree to the following Terms and Conditions and Privacy Policy",
                          style: small(color: Colors.white, size: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            )),
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
