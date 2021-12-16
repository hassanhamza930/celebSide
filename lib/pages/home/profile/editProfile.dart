import 'dart:io';

import 'package:celebside/models/user/userDetails.dart';
import 'package:celebside/pages/auth/welcome.dart';
import 'package:celebside/pages/celebrity/auth/celebrityWelcome.dart';
import 'package:celebside/services/updateUserProfileDetails.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import "../home.dart" as Home;

var hide = true;
var noti=true;

var notificationPermission = true;
var username= TextEditingController(text: "");
var email = TextEditingController(text: "");
var fullName = TextEditingController(text: "");
var phone = TextEditingController(text: "");
DateTime dob = null;
var dobDisplay = TextEditingController(text: "");
var countryCode="+233";
var country="Ghana";
var password=TextEditingController(text:"");

var loading=true;


class editProfile extends StatefulWidget {
  @override
  _editProfileState createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {

  @override
  void initState() {

      Future.delayed(
        Duration(milliseconds: 0),
          ()async{
            print("doing one time");

            var userDocument= await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid.toString()).get();
            var userData= userDetails.fromJson(userDocument.data());

            print(userData.password);

            setState(() {
              username.value= TextEditingValue(text:userData.username);
              email.value= TextEditingValue(text:userData.email);
              fullName.value= TextEditingValue(text:userData.fullName);
              phone.value= TextEditingValue(text:userData.phone.substring(1));
              dob=userData.dob;
              dobDisplay.value=TextEditingValue(text:userData.dob.toString().split(" ")[0]);
              country=userData.country;
              noti=userData.notificationPermission;
              password.text=userData.password;
              loading=false;
            });
          }
      );


    super.initState();
  }


  @override
  void dispose() {
    loading=true;
    super.dispose();
  }


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
              height: height,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    DocumentSnapshot doc=snapshot.data;
                    Map data=doc.data();

                    return Center(
                      child: Container(
                        width: width * 0.9,
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: Container(
                                child: Text(
                                  "Profile",
                                  style: medium(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: CircleAvatar(
                                radius: 150,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 150,
                                  backgroundImage: NetworkImage("${data["imgSrc"]}"),
                                ),
                              ),
                            ),//p
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: ()async{
                                try{
                                  XFile image;
                                  showLoading(context: context);

                                  await ImagePicker().pickImage(source: ImageSource.gallery,).then((value) {
                                    setState(() {
                                      image = value;
                                    });
                                  });
                                  FirebaseStorage.instance.ref("pictures/${FirebaseAuth.instance.currentUser.uid}").putFile(File(image.path))
                                      .then((TaskSnapshot taskSnapshot) {
                                    if (taskSnapshot.state == TaskState.success) {
                                      print("Image uploaded Successful");
                                      taskSnapshot.ref.getDownloadURL().then(
                                              (imageURL)async {

                                            await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"imgSrc":imageURL},SetOptions(merge: true));

                                          });
                                      Navigator.pop(context);

                                    }
                                    else if (taskSnapshot.state == TaskState.running) {
                                    }
                                    else if (taskSnapshot.state == TaskState.error) {
                                      showErrorDialogue(context: context, message: TaskState.error.toString());
                                    }
                                  });
                                }
                                catch(e){
                                  Navigator.pop(context);
                                  showErrorDialogue(context: context, message: "You have not selected any image.");
                                }

                              },
                              child: Text(
                                "Change Profile Picture",
                                style: smallBold(color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ), // rofile
                            SizedBox(
                              height: 40,
                            ),
                            inputField(
                                label: "Name",
                                context: context,
                                controller: fullName,
                                onChange: (e) {
                                  print(e);
                                }), //username
                            SizedBox(
                              height: 10,
                            ),
                            inputField(
                                label: "Email",
                                context: context,
                                controller: email,
                                onChange: (e) {
                                  print(e);
                                }), //username
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
                                    initialSelection: "${country}",
                                    textStyle: small(color: Colors.white),
                                    onChanged: (code){
                                      country=code.name;
                                      countryCode=code.dialCode;
                                    },
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.55,
                                    child: TextField(
                                      maxLength: 10,
                                      controller: phone,
                                      style: small(color: Colors.white),
                                      decoration: InputDecoration(
                                        counterText: "",
                                        labelStyle: small(color: Colors.white),
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        contentPadding:
                                        EdgeInsetsDirectional.only(start: 20),
                                      ),
                                      onChanged: (e) {},
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
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
                                    contentPadding: EdgeInsetsDirectional.only(start: 20),
                                  ),
                                  onChanged: (e) => {},
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            inputField(label: "Username", context: context, onChange: (e){},controller: username),
                            SizedBox(
                              height: 20,
                            ),
                            authButton(text: "Update", color: Colors.white, bg: Colors.orange, onPress: ()async{


                              if(fullName.text!="" && phone.text!="" && password.text!="" && username.text!="" && email.text!=""){
                                showLoading(context: context);

                                try{

                                  await FirebaseAuth.instance.currentUser.updateEmail(email.text);
                                  await FirebaseAuth.instance.currentUser.updateDisplayName(fullName.text);
                                  await FirebaseAuth.instance.currentUser.updatePassword(password.text);

                                  var doc = await FirebaseFirestore.instance.collection("users")
                                      .doc(FirebaseAuth.instance.currentUser.uid)
                                      .set(
                                      {
                                        "fullName": fullName.text,
                                        "country":country,
                                        "countryCode":countryCode,
                                        "password":password.text,
                                        "phone": "0${phone.text}",
                                        "username":username.text,
                                        "notificationsPermission":noti,
                                        "email":email.text
                                      }
                                      ,SetOptions(merge:true)
                                  );

                                  Navigator.pop(context);

                                }
                                catch(e){
                                  Navigator.pop(context);
                                  await showErrorDialogue(context: context,message: e.message.toString());
                                }


                              }

                              else{
                                await showErrorDialogue(context: context, message: "Kindly Fill All Details Properly.");
                              }




                            }, context: context),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Turn On/Off Notifications",
                                  style: small(color: Colors.white),
                                ),
                                FlutterSwitch(
                                    value: noti,
                                    onToggle: (val) {
                                      setState(() {
                                        noti = val;
                                      });
                                    }),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: (){
                                showDialog(context: context,builder: (context){
                                  var height=MediaQuery.of(context).size.height;
                                  var width=MediaQuery.of(context).size.width;
                                  return Scaffold(
                                    backgroundColor: Colors.transparent,
                                    body: Center(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)
                                            )
                                        ),
                                        width: width*0.8,
                                        height: height*0.6,
                                        child: Center(
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: [
                                              Image.asset("assets/profile/logout.png",fit: BoxFit.contain,height: 150,),
                                              SizedBox(height: 20,),
                                              Text("Delete Account",style: medium(color: Color.fromRGBO(24, 48, 93, 1)),textAlign: TextAlign.center,),
                                              Text("Are you sure you want to delete your account?",style: small(color: Colors.black),textAlign: TextAlign.center,),
                                              SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap:(){
                                                      Navigator.pushReplacement(
                                                          context,
                                                          CupertinoPageRoute(builder: (context){
                                                            return welcome();
                                                          })
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)
                                                          )
                                                      ),
                                                      width: width*0.35,
                                                      height: 40,
                                                      child: Center(
                                                        child: Text("Yes",style: small(color: Colors.white),),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap:(){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)
                                                          )
                                                      ),
                                                      width: width*0.35,
                                                      height: 40,
                                                      child: Center(
                                                        child: Text("Cancel",style: small(color: Colors.white),),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });

                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.warning,color: Colors.orange,),
                                  Text("Delete Account",style: small(color: Colors.white),),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }
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
            Container(
              alignment: Alignment.bottomCenter,
              height: height,
              width: width,
              child: Container(
                height: 70,
                padding: EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 10),
                color: Color.fromRGBO(24, 48, 93, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          print("one");
                          setState(() {
                            Home.currentTab = 0;
                          });
                          Navigator.pushReplacement(context,
                              CupertinoPageRoute(builder: (context) {
                            return Home.Home();
                          }));
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Home.currentTab == 0
                                          ? Colors.orange
                                          : Colors.white,
                                      BlendMode.srcATop),
                                  child: Image.asset(
                                    "assets/bottom bar/simple/1.png",
                                    fit: BoxFit.contain,
                                    height: 25,
                                  )),
                              Text(
                                "Home",
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 12,
                                  color: Home.currentTab == 0
                                      ? Colors.orange
                                      : Colors.white,
                                ),
                              )
                            ],
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          print("one");
                          setState(() {
                            Home.currentTab = 1;
                          });
                          Navigator.pushReplacement(context,
                              CupertinoPageRoute(builder: (context) {
                            return Home.Home();
                          }));
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Home.currentTab == 1
                                          ? Colors.orange
                                          : Colors.white,
                                      BlendMode.srcATop),
                                  child: Image.asset(
                                    "assets/bottom bar/simple/2.png",
                                    fit: BoxFit.contain,
                                    height: 25,
                                  )),
                              Text(
                                "Requests",
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 12,
                                  color: Home.currentTab == 1
                                      ? Colors.orange
                                      : Colors.white,
                                ),
                              )
                            ],
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          print("one");
                          setState(() {
                            Home.currentTab = 2;
                          });
                          Navigator.pushReplacement(context,
                              CupertinoPageRoute(builder: (context) {
                            return Home.Home();
                          }));
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Home.currentTab == 2
                                          ? Colors.orange
                                          : Colors.white,
                                      BlendMode.srcATop),
                                  child: Image.asset(
                                    "assets/bottom bar/simple/3.png",
                                    fit: BoxFit.contain,
                                    height: 25,
                                  )),
                              Text(
                                "Notifications",
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 12,
                                  color: Home.currentTab == 2
                                      ? Colors.orange
                                      : Colors.white,
                                ),
                              )
                            ],
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          print("one");
                          setState(() {
                            Home.currentTab = 3;
                          });
                          Navigator.pushReplacement(context,
                              CupertinoPageRoute(builder: (context) {
                            return Home.Home();
                          }));
                        },
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      Home.currentTab == 3
                                          ? Colors.orange
                                          : Colors.white,
                                      BlendMode.srcATop),
                                  child: Image.asset(
                                    "assets/bottom bar/simple/4.png",
                                    fit: BoxFit.contain,
                                    height: 25,
                                  )),
                              Text(
                                "Profile",
                                style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 12,
                                  color: Home.currentTab == 3
                                      ? Colors.orange
                                      : Colors.white,
                                ),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            loading==true?Scaffold(
              backgroundColor: Colors.white54,
              body: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(color: Colors.blue,),
                ),
              ),
            ):Container(),

          ],
        ),
      ),
    );
  }
}
