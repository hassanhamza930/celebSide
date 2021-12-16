import 'package:celebside/pages/auth/notificationPermission.dart';
import 'package:celebside/services/addToWallet.dart';
import 'package:celebside/services/checkSignupBonusCode.dart';
import 'package:celebside/services/userSignup.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

var username = TextEditingController(text:"");
var email = TextEditingController(text:"");
var fullName =  TextEditingController(text:"");
String phone = "";
DateTime dob = null;
var dobDisplay = "Enter Your Date of Birth";
var password =  TextEditingController(text:"");
var countryCode="+233";
var country="Ghana";
bool hasReferral=false;
var referral=TextEditingController(text: "");


bool hide = true;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: Stack(
            children: [
              Image.asset(
                "assets/bluebackground.png",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Create an Account",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "AvenirBold",
                            color: Colors.white,
                            fontSize: 34),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      inputField(
                          label: "Username",
                          context: context,
                          controller: username,
                          onChange: (e) {
                          }), //username
                      SizedBox(
                        height: 10,
                      ),
                      inputField(
                          label: "Email",
                          context: context,
                          controller: email,
                          onChange: (e) {
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      inputField(
                          label: "Full Name",
                          context: context,
                          controller: fullName,
                        onChange: (e){}
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(3),
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0))),
                        child: Row(
                          children: [
                            CountryCodePicker(
                              initialSelection: "Ghana",
                              textStyle: small(color: Colors.white),
                              onChanged: (code) {
                                setState(() {
                                  country=code.name;
                                  print(country);
                                  countryCode = code.dialCode;
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
                                    phone = "0$e";
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
                              minTime: DateTime(1960, 1, 1),
                              maxTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                              onChanged: (date) {
                            setState(() {
                              dob = date;
                              dobDisplay = date.toString();
                            });
                          }, onConfirm: (date) {
                            setState(() {
                              dob = date;
                              dobDisplay = date.toString();
                            });
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
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
                                labelText:
                                    dobDisplay == "Enter Your Date of Birth"
                                        ? dobDisplay
                                        : dobDisplay.split(" ")[0],
                                labelStyle: small(color: Colors.white),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding:
                                    EdgeInsetsDirectional.only(start: 20),
                              ),
                              onChanged: (e) {},
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(24.0))),
                        child: Center(
                          child: TextField(
                            controller: password,
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
                              contentPadding:
                                  EdgeInsetsDirectional.only(start: 20),
                            ),
                            onChanged: (e) {
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: hasReferral,
                              onChanged: (val) {
                                setState(() {
                                  hasReferral = val;
                                });
                              }),
                          Text(
                            "I have referral Code (Enter Below)",
                            style: small(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      hasReferral
                          ? inputField(
                          label: "Referral Code",
                          context: context,
                          onChange: (e) {
                          },
                          controller: referral
                      ) : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      authButton(
                          text: "Sign Up",
                          color: Colors.white,
                          bg: Colors.orange,
                          onPress: () async {


                            await showLoading(context: context);

                            var codeResponse=await checkSignupBonusCode(hasReferral: hasReferral, referral: referral.text);

                            Navigator.of(context).pop();

                            if(codeResponse=="error"){
                              showErrorDialogue(context: context, message: "Kindly Enter Valid Promo Code");
                            }
                            else{
                              await showLoading(context: context);

                              Map response= await UserSignupService().signupWithData(username:username.text, email:email.text, fullName:fullName.text, phoneCode:countryCode, phone:phone, dob:dob, password:password.text,country:country);
                                if ( response != null && response["message"] == "created") {
                                print("created the account");

                                Navigator.of(context).pop();

                                // Navigator.pushReplacement(context,
                                // CupertinoPageRoute(builder: (context) {
                                // return NotificationPermission();
                                // }));

                                Navigator.of(context)
                                    .pushAndRemoveUntil(
                                    CupertinoPageRoute(builder: (context){
                                      return NotificationPermission();
                                    }), (Route<dynamic> route) => false);


                                if(hasReferral==true){
                                await addToWallet(amount: 15, id: referral.text.trim(), type: "users");
                                }
                                }

                                else {
                                  Navigator.of(context).pop();
                                  showErrorDialogue(context: context, message: "${response == null ? "Kindly Fill All Fields Properly" : response["message"]}");
                                }
                            }
                          },
                        context: context
                        ),
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "By clicking Sign up you agree to the following\nTerms and Conditions without reservation",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 50,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
