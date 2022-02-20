import 'dart:io';

import 'package:celebside/pages/auth/splash.dart';
import 'package:celebside/pages/auth/welcome.dart';
import 'package:celebside/pages/celebrity/auth/celebritySignup.dart';
import 'package:celebside/pages/celebrity/auth/celebrityWelcome.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import "package:flutter/cupertino.dart";


var hide = true;
var noti = true;
var platform="Instagram";

var name=TextEditingController(text: "");
var phone=TextEditingController(text: "");
var password=TextEditingController(text: "");
var handle=TextEditingController(text: "");
var country="Ghana";
var countryCode="+233";
var email=TextEditingController(text:"");
var loading=true;


class celebrityEditProfile extends StatefulWidget {
  @override
  _celebrityEditProfileState createState() => _celebrityEditProfileState();
}

class _celebrityEditProfileState extends State<celebrityEditProfile> {

  fetchDataAndInitialize()async{
    var doc= await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).get();
    var data=doc.data();
    setState(() {
      email.text=data["email"];
      name.value=TextEditingValue(text: data["fullName"].toString());
      country=data["country"];
      countryCode=data["countryCode"];
      phone.value=TextEditingValue(text:data["phone"].substring(1));
      password.text=data["password"];
      platform=data["mostFollowers"];
      handle.text=data["handle"];
      noti=data["notificationsPermission"];
      loading=false;
    });

  }


  @override
  void initState() {
    fetchDataAndInitialize();
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
              stream: FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
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
                              radius: 100,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                backgroundColor: Colors.black54,
                                radius: 100,
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

                                          await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"imgSrc":imageURL},SetOptions(merge: true));

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
                                showErrorDialogue(context: context, message: "You did not select any image");
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
                              controller: name,
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
                                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
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
                          Container(
                            padding: EdgeInsets.only(left:20,top:3,bottom: 3,right: 20),
                            decoration:BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius:
                                BorderRadius.all(Radius.circular(24.0))
                            ),
                            child: DropdownButton<String>(
                              value: platform,
                              style: small(color: Colors.white),
                              dropdownColor: Colors.black,
                              onChanged: (String newValue) {
                                setState(() {
                                  platform = newValue;
                                });
                              },
                              hint: Text(
                                "Where do you have the most followers?",
                                style: small(color: Colors.white,size: 14),
                              ),
                              items: <String>["Instagram", 'Facebook',"Twitter","Youtube"].map<DropdownMenuItem<String>>((String value) {
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
                          inputField(label: "Your Handle", context: context, onChange: (e){},controller: handle),
                          SizedBox(
                            height: 20,
                          ),
                          authButton(text: "Update", color: Colors.white, bg: Colors.orange, onPress: ()async{


                            if(name.text!="" && phone.text!="" && password.text!="" && platform!="" && handle.text!="" && email.text!=""){
                              showLoading(context: context);

                              try{

                                var credential=EmailAuthProvider.credential(email: email.text, password: password.text);
                                await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential);

                                await FirebaseAuth.instance.currentUser.updateEmail(email.text);
                                await FirebaseAuth.instance.currentUser.updateDisplayName(name.text);
                                await FirebaseAuth.instance.currentUser.updatePassword(password.text);

                                var doc = await FirebaseFirestore.instance.collection("celebrities")
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .set(
                                    {
                                      "fullName": name.text,
                                      "country":country,
                                      "countryCode":countryCode,
                                      "password":password.text,
                                      "phone":"0${phone.text}",
                                      "mostFollowers":platform,
                                      "handle":handle.text,
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
                                                  onTap:()async{
                                                    var credential=EmailAuthProvider.credential(email: email.text, password: password.text);
                                                    await FirebaseAuth.instance.currentUser.reauthenticateWithCredential(credential);

                                                    await FirebaseAuth.instance.currentUser.delete();
                                                   // await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid).delete();


                                                    Navigator.pushReplacement(
                                                        context,
                                                        CupertinoPageRoute(builder: (context){
                                                          return Splash();
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
            loading==true?Scaffold(
              backgroundColor: Colors.white54,
              body: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(color: Colors.blue,),
                ),
              ),
            ):Container()
          ],
        ),
      ),
    );
  }
}
