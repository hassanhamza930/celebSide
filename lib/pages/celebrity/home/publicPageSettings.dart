
import 'dart:io';

import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_dropdown/multiple_dropdown.dart';
import 'package:multiselect_dropdown/multiple_select.dart';


var aboutMe=TextEditingController(text: "");
List interests = [];
var loading=true;

class publicPageSettings extends StatefulWidget {
  @override
  _publicPageSettingsState createState() => _publicPageSettingsState();
}

class _publicPageSettingsState extends State<publicPageSettings> {

  fetchOneTime()async{
    var doc=await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).get();
    var data=doc.data();

    setState(() {
      aboutMe.text=data["about"];
      interests=data["interests"];
      loading=false;
    });
  }


  @override
  void initState() {

    fetchOneTime();
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



    //https://www.cprime.com/wp-content/static/images/blog/default-avatar-250x250.png

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Container(
                color: Colors.black,
                height: height,
                width: width,
                child: Image.asset(
                  "assets/bluebackground.png",
                  width: width,
                  height: height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  DocumentSnapshot doc=snapshot.data;
                  Map data=doc.data();

                  return Center(
                    child: Container(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          Text(
                            'Public Page Settings',
                            style: mediumBold(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [


                              GestureDetector(
                                onTap: ()async{
                                  print("Image");
                                  // var storage=await FirebaseStorage.instance;
                                  // var ref = FirebaseStorage.instance
                                  //     .ref()
                                  //     .child('images')
                                  //     .child('${FirebaseAuth.instance.currentUser.uid.toString()}');


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
                                    showErrorDialogue(context: context, message: "No File Selected");
                                  }




                                },
                                child: Column(
                                  children: [
                                    Text("Add Background Image",style: small(color: Colors.white,size: 14),),
                                    SizedBox(height: 10,),
                                    data["imgSrc"]=="https://www.cprime.com/wp-content/static/images/blog/default-avatar-250x250.png"?
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white38,
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      height: 200,
                                      width: width*0.4,
                                      child: Center(child: FaIcon(FontAwesomeIcons.fileUpload,size: 50,)),
                                    ):
                                    Image.network(
                                      data["imgSrc"],
                                      width: width*0.4,
                                      height: 200,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),

                              GestureDetector(
                                onTap: ()async{
                                  print("Video");
                                  // var storage=await FirebaseStorage.instance;
                                  // var ref = FirebaseStorage.instance
                                  //     .ref()
                                  //     .child('images')
                                  //     .child('${FirebaseAuth.instance.currentUser.uid.toString()}');


                                  try{
                                    XFile image;
                                    showLoading(context: context);

                                    await ImagePicker().pickVideo(source: ImageSource.gallery,).then((value) {
                                      setState(() {
                                        image = value;
                                      });
                                    });
                                    FirebaseStorage.instance.ref("videos/${FirebaseAuth.instance.currentUser.uid}").putFile(File(image.path))
                                        .then((TaskSnapshot taskSnapshot) {
                                      if (taskSnapshot.state == TaskState.success) {
                                        print("Image uploaded Successful");
                                        taskSnapshot.ref.getDownloadURL().then(
                                                (imageURL)async {

                                              await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"vidSrc":imageURL},SetOptions(merge: true));

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
                                    showErrorDialogue(context: context, message: "No File Selected");
                                  }




                                },
                                child: Column(
                                  children: [
                                    Text("Add Background Video",style: small(color: Colors.white,size: 14),),
                                    SizedBox(height: 10,),
                                    data["vidSrc"]==""?
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white38,
                                          borderRadius: BorderRadius.all(Radius.circular(20))
                                      ),
                                      height: 200,
                                      width: width*0.4,
                                      child: Center(child: FaIcon(FontAwesomeIcons.fileUpload,size: 50,)),
                                    ):
                                    Stack(
                                      children: [
                                        Container(
                                          decoration:BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20)
                                            )
                                          ),
                                          width: width*0.4,
                                          height: 200,
                                          child: InAppWebView(
                                            initialUrlRequest: URLRequest(url: Uri.parse(data["vidSrc"])),
                                            initialOptions: InAppWebViewGroupOptions(
                                             android: AndroidInAppWebViewOptions(
                                               allowFileAccess: true,
                                               cacheMode: AndroidCacheMode.LOAD_CACHE_ELSE_NETWORK,
                                               allowContentAccess: true
                                             )
                                            ),
                                          )
                                        ),
                                        // Container(
                                        //   width: width*0.4,
                                        //   height: 200,
                                        //   child: Center(
                                        //     child: TextButton(
                                        //         child: Icon(Icons.play_circle_outline,color: Colors.white,size: 45,),
                                        //       onPressed: ()async{
                                        //           print("played");
                                        //           await _controller.play();
                                        //       },
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ],
                                ),
                              ),


                            ],
                          ),
                          SizedBox(height: 20,),
                          Center(
                              child: Container(
                                height: 200,
                                padding: EdgeInsets.all(3),
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(24.0))),
                                child: Center(
                                  child: TextField(
                                    controller: aboutMe,
                                    minLines: 4,
                                    maxLines: 99999,
                                    style: small(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: "About Me",
                                      labelStyle: small(color: Colors.white),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      contentPadding:
                                      EdgeInsetsDirectional.all(20),
                                    ),
                                    onChanged: (e)=>{},
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              )
                          ),
                          SizedBox(height: 20,),
                          Center(
                            child: Container(
                              width: width*0.9,
                              child: MultipleDropDown(
                                  placeholder: "Select Interests",
                                  values:interests,
                                  elements: [
                                    MultipleSelectItem.build(value: "TikToker", display: "TikToker", content:"TikToker"),
                                    MultipleSelectItem.build(value: "Musician", display: "Musician", content:"Musician"),
                                    MultipleSelectItem.build(value: "Actor", display: "Actor", content: "Actor"),
                                    MultipleSelectItem.build(value: "Youtuber", display: "Youtuber", content: "Youtuber"),
                                    MultipleSelectItem.build(value: "Facebook", display: "Facebook", content: "Facebook"),
                                  ]
                              ),
                            ),
                          ),
                          // Center(
                          //   child: Container(
                          //     width: width*0.9,
                          //     padding: EdgeInsets.only(
                          //         left: 10, top: 7, bottom: 7, right: 20),
                          //     decoration: BoxDecoration(
                          //         color: Colors.white.withOpacity(0.1),
                          //         borderRadius:
                          //         BorderRadius.all(Radius.circular(15.0))),
                          //     child:  SearchableDropdown.multiple(
                          //       items: [
                          //         DropdownMenuItem(child: Text("TikToker")),
                          //         DropdownMenuItem(child: Text("Musician")),
                          //         DropdownMenuItem(child: Text("YouTuber")),
                          //         DropdownMenuItem(child: Text("Actor")),
                          //         DropdownMenuItem(child: Text("Facebook")),
                          //       ],
                          //       selectedItems: [],
                          //       hint: Text("Choose Your Interests",style: small(color: Colors.white),),
                          //       searchHint: Text("Select any",style: small(color: Colors.white),),
                          //       style: small(color: Colors.white),
                          //       onChanged: (value) {
                          //         setState(() {
                          //
                          //         });
                          //       },
                          //     ),),
                          // ),
                          SizedBox(height: 40,),
                          Center(
                            child: authButton(text: "Update", color: Colors.white, bg: Colors.orange, onPress: ()async{
                              print("updated");

                              try{
                                if(interests.length!=0 && aboutMe.text!=""){
                                  showLoading(context: context);
                                  await FirebaseFirestore.instance.collection("celebrities")
                                      .doc(FirebaseAuth.instance.currentUser.uid.toString())
                                      .set({
                                    "about":aboutMe.text,
                                    "interests":interests
                                  },SetOptions(merge:true));
                                  Navigator.pop(context);

                                }
                                else{
                                  showErrorDialogue(context: context, message: "Kindly Enter All Details.");
                                }
                              }
                              catch(e){
                                showErrorDialogue(context: context, message: e.toString());
                              }

                            }, context: context,thin: true),
                          ),
                          SizedBox(height: 100,),
                        ],
                      ),
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
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                  child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 20),
                      width: width,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ))),
            ),
            loading==true?
            Scaffold(
              backgroundColor: Colors.white54,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ):
            Container()
          ],
        ),
      ),
    );
  }
}
