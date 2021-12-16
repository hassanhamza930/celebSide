import 'package:celebside/pages/auth/splash.dart';
import 'package:celebside/pages/auth/welcome.dart';
import 'package:celebside/pages/celebrity/auth/celebrityWelcome.dart';
import 'package:celebside/pages/celebrity/home/celebFanClub.dart';
import 'package:celebside/pages/celebrity/home/earningHistory.dart';
import 'package:celebside/pages/celebrity/home/editOffer/editOffer.dart';
import 'package:celebside/pages/celebrity/home/editProfile.dart';
import 'package:celebside/pages/celebrity/home/payouts/payouts.dart';
import 'package:celebside/pages/celebrity/home/publicPageSettings.dart';
import 'package:celebside/pages/celebrity/home/publicProfile.dart';
import 'package:celebside/pages/home/celebrityInvites.dart';
import 'package:celebside/pages/home/profile/withdraw.dart';
import 'package:celebside/services/Logout.dart';
import 'package:celebside/util/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'createOffer/createOfferPage.dart';
import 'package:celebside/pages/home/celebrityProfile/celebrityProfilePage.dart';
import 'package:celebside/pages/home/featuredVideoPlayer/fanClub.dart';
import 'package:celebside/pages/home/profile/editProfile.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
class celebrityProfilePageEdit extends StatefulWidget {
  @override
  _celebrityProfilePageEditState createState() => _celebrityProfilePageEditState();
}

class _celebrityProfilePageEditState extends State<celebrityProfilePageEdit> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasData){
          DocumentSnapshot doc=snapshot.data;
          Map data=doc.data();
          return Scaffold(
            body: Stack(
              children: [
                Image.asset("assets/bluebackground.png",fit: BoxFit.cover,width: width,height: height,),
                Center(
                  child: Container(
                    child: ListView(
                      children: [
                        Center(
                          child: Container(
                            width: width*0.9,
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Center(
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            "Profile",
                                            style: medium(color: Colors.white)
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, CupertinoPageRoute(builder: (context){
                                                  return celebFanClub();
                                                }));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                                ),
                                                child: Text(
                                                  "My Fan Club",
                                                  style: small(color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Icon(Icons.more_vert,color: Colors.white,)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.black54,
                                        radius: 50,
                                        backgroundImage: NetworkImage("${data["imgSrc"]}"),
                                      ),
                                    ),
                                    SizedBox(width:10,),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${data["fullName"]}",style: medium(color: Colors.orange),),
                                          SizedBox(height: 10,),
                                          GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, CupertinoPageRoute(builder: (context){
                                                  return publicProfile();
                                                }));
                                              },
                                              child: Text("View Public Profile",style: small(color: Colors.white),)
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.orange,
                          ),
                          padding: EdgeInsets.only(left:15,right:10,top:10,bottom: 10),
                          child: Text("Talent Account Setting",style: mediumBold(color: Colors.white,size: 20),textAlign: TextAlign.left,),
                        ),
                        Center(
                          child: Container(
                            width: width*0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(builder: (context){
                                          return createOfferPage();
                                        })
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top:20,bottom: 5),
                                    child: Text("Create Offer",style: medium(color: Colors.white,size: 20),),
                                  ),
                                ),
                                Divider(height: 5,color: Colors.white,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(builder: (context){
                                          return editOffer();
                                        })
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top:20,bottom: 5),
                                    child: Text("Schedule / Edit Offer",style: medium(color: Colors.white,size: 20),),
                                  ),
                                ),
                                Divider(height: 5,color: Colors.white,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(builder: (context){
                                          return publicPageSettings();
                                        })
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top:20,bottom: 5),
                                    child: Text("Public Page Settings",style: medium(color: Colors.white,size: 20),),
                                  ),
                                ),
                                Divider(height: 5,color: Colors.white,),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(builder: (context){
                                          return payouts();
                                        })
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top:20,bottom: 5),
                                    child: Text("Payouts",style: medium(color: Colors.white,size: 20),),
                                  ),
                                ),
                                SizedBox(height: 20,),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.orange,
                          ),
                          padding: EdgeInsets.only(left:15,right:10,top:10,bottom: 10),
                          child: Text("General Account Setting",style: mediumBold(color: Colors.white,size: 20),textAlign: TextAlign.left,),
                        ),
                        Center(
                          child: Container(
                            width: width,
                            color: Colors.white,
                            child: Center(
                              child: Container(
                                width: width*0.9,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                                builder: (context){
                                                  return celebrityEditProfile();
                                                }
                                            ));
                                      },
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10,top: 20),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "Edit Profile",
                                              style: medium(color: Colors.black,size: 20)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(height: 5,color: Colors.black,),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.push(context,CupertinoPageRoute(builder: (context){
                                          return earningHistory();
                                        }));
                                      },
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10,top: 20),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "Earning History",
                                              style: medium(color: Colors.black,size: 20)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(height: 5,color: Colors.black,),
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
                                          margin: EdgeInsets.only(bottom: 10,top:20),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                              "Help and Support",
                                              style: medium(color: Colors.black,size: 20)
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Divider(height: 5,color: Colors.black,),
                                    // GestureDetector(
                                    //   onTap: (){
                                    //
                                    //     Navigator.push(context,CupertinoPageRoute(builder: (context){
                                    //       return celebrityInvites();
                                    //     }));
                                    //
                                    //   },
                                    //   child: Center(
                                    //     child: Container(
                                    //       margin: EdgeInsets.only(bottom: 10,top:20),
                                    //       alignment: Alignment.centerLeft,
                                    //       child: Text(
                                    //           "Invite and Rewards",
                                    //           style: medium(color: Colors.black,size: 20)
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    Divider(height: 5,color: Colors.black,),
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
                                                              await LogOutForCelebrity();
                                                              Navigator.pop(context);

                                                              Navigator.of(context)
                                                                  .pushAndRemoveUntil(CupertinoPageRoute(builder: (context){return celebrityWelcome();}), (Route<dynamic> route) => false);

                                                              // Navigator.pushReplacement(
                                                              //     context,
                                                              //     CupertinoPageRoute(builder: (context){
                                                              //       return Splash();
                                                              //     })
                                                              // );



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
                                              style: medium(color: Colors.black,size: 20)
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Image.asset("assets/logo.png",color: Colors.black38,height: 50,fit: BoxFit.cover,),
                                        Text("App Version 1.0.1",style: small(color: Colors.black,size: 14),),
                                      ],
                                    ),
                                    SizedBox(height: 100,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ) ,
                ),
              ],
            ),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}
