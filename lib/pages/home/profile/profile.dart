import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/auth/signupOptions.dart';
import 'package:celebside/pages/auth/splash.dart';
import 'package:celebside/pages/auth/welcome.dart';
import 'package:celebside/pages/home/profile/editProfile.dart';
import 'package:celebside/pages/home/profile/invites.dart';
import 'package:celebside/pages/home/profile/policy.dart';
import 'package:celebside/pages/home/profile/terms.dart';
import 'package:celebside/pages/home/profile/transactions.dart';
import 'package:celebside/services/Logout.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:url_launcher/url_launcher.dart';

class profile extends StatefulWidget {
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser.uid.toString()).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasData){

          var doc=snapshot.data;
          var data=doc.data();

          return Scaffold(
            body: Stack(
              children: [
                Image.asset("assets/bluebackground.png",fit: BoxFit.cover,width: width,height: height,),
                Center(
                  child: Container(
                    width: width*0.9,
                    child: ListView(
                      children: [
                        SizedBox(height: 10,),
                        Center(
                          child: Container(
                            child: Text(
                                "Profile",
                                style: medium(color: Colors.white)
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        Center(
                          child: CircleAvatar(
                            radius: 150,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.black54,
                              radius: 150,
                              backgroundImage: NetworkImage("${data["imgSrc"]}"),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: AutoSizeText(
                                "${data["fullName"]}",
                                maxLines: 1,
                                style: medium(color: Colors.white,size: 26),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context){
                                      return editProfile();
                                    }
                                ));
                          },
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Edit Profile",
                                  style: small(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 5,color: Colors.white,),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context){
                                  return transactions();
                                })
                            );
                          },
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Transaction History",
                                  style: small(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 5,color: Colors.white,),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: ()async{
                            const uri = 'mailto:test@letsvibe.com';
                            if (await canLaunch(uri))
                            {
                              await launch(uri);
                            }
                            else {
                              print('Could not launch $uri');
                            }
                          },
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Help and Support",
                                  style: small(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 5,color: Colors.white,),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,CupertinoPageRoute(builder: (context){
                              return invites();
                            }));
                          },
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Invite and Rewards",
                                  style: small(color: Colors.white)

                              ),
                            ),
                          ),
                        ),
                        Divider(height: 5,color: Colors.white,),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context){
                                  return terms();
                                })
                            );
                          },
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Terms and Conditions",
                                  style: small(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 5,color: Colors.white,),
                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context){
                                  return policy();
                                })
                            );
                          },
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Privacy Policy",
                                  style: small(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                        Divider(height: 5,color: Colors.white,),
                        SizedBox(height: 20,),
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
                                          Text("Come Back Soon",style: medium(color: Color.fromRGBO(24, 48, 93, 1)),textAlign: TextAlign.center,),
                                          Text("Are you sure you want to log out?",style: small(color: Colors.black),textAlign: TextAlign.center,),
                                          SizedBox(height: 20,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap:()async{
                                                  showLoading(context: context);
                                                  await LogOut();
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(CupertinoPageRoute(builder: (context){return welcome();}), (Route<dynamic> route) => false);

                                                  // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                                                  //   return welcome();
                                                  // }));

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
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  "Log Out",
                                  style: small(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 100,)
                      ],
                    ),
                  ) ,
                ),
              ],
            ),
          );
        }
        else{
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );
  }
}
