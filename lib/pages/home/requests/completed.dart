import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/pages/celebrity/home/celebrityVideoFinalize.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/orderDetails.dart';
import 'package:celebside/pages/home/celebrityProfile/sendMessage/celebrityChat.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path_provider/path_provider.dart';
import "package:firebase_storage/firebase_storage.dart";

var reviewText=TextEditingController(text: "");
var rating=0;

class completedRow extends StatefulWidget {

  final celebrity;
  final String type;
  final user;
  final createdAt;
  final status;
  final bool reviewed;
  final String docId;
  final vidLink;

  completedRow({@required this.vidLink,@required this.type,@required this.celebrity,@required this.user,@required this.createdAt,@required this.status,@required this.reviewed,@required this.docId});

  @override
  _completedRowState createState() => _completedRowState();
}

class _completedRowState extends State<completedRow> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebrity).snapshots(),
        builder: (context, snapshot) {

          if(snapshot.hasData){

            DocumentSnapshot doc=snapshot.data;
            Map data=doc.data();

            return Center(
              child: Container(
                margin: EdgeInsets.only(top:10),
                width: width*0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width*0.6,
                      child: Row(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage("${data["imgSrc"]}"),
                              ),
                            ),
                          ),
                          SizedBox(width: 7,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${data["fullName"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "AvenirBold",
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${widget.createdAt.toDate().toString().split(" ")[0]}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Avenir",
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "${widget.type.toString()=="dm"?"Direct Message":"Video Request"}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Avenir",
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),


                    Column(
                      children: [
                        widget.reviewed==true?
                        Container():
                        Container(
                          width: width*0.3,
                          child: GestureDetector(
                            onTap: (){
                              showDialog(context: context, builder: (context){
                                return Scaffold(
                                  backgroundColor: Colors.transparent,
                                  body: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)
                                          )
                                      ),
                                      width: width*0.7,
                                      height: height*0.5,
                                      child: Center(
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [

                                            Center(child: Text("How was your experience?")),
                                            SizedBox(height: 10,),
                                            Center(
                                              child: RatingBar.builder(itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ), onRatingUpdate: (e){

                                                setState(() {
                                                  rating=e.toInt();
                                                });

                                              }),
                                            ),
                                            SizedBox(height: 20,),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black54,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(15)
                                                  )
                                              ),
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.all(10),
                                              child: inputField(label: "Remarks", context: context, onChange: (e){},controller: reviewText),
                                            ),
                                            SizedBox(height: 10,),
                                            Center(
                                              child: authButton(text: "Submit", color: Colors.white, bg: Colors.orange,thin: true, onPress: ()async{

                                                if(rating!=0 && reviewText.text!=""){
                                                  showLoading(context: context);

                                                  await FirebaseFirestore.instance.collection("requests").doc(widget.docId)
                                                      .set(
                                                      {
                                                        "reviewed":true,
                                                        "review":{
                                                          "rating":rating,
                                                          "remarks":reviewText.text,
                                                          "createdAt":DateTime.now(),
                                                        }
                                                      },
                                                      SetOptions(merge: true)
                                                  );

                                                  reviewText.clear();

                                                  Navigator.pop(context);
                                                  Navigator.pop(context);

                                                }
                                                else{
                                                    showErrorDialogue(context: context, message: "Kindly enter all details.");
                                                }



                                              }, context: context),
                                            )

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Container(
                                width: width*0.3,
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                margin: EdgeInsets.only(left: 10),
                                padding:EdgeInsets.only(top:7,bottom: 7,left: 7,right: 7),
                                // padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.message,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Flexible(
                                      child: AutoSizeText(
                                        "Review",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontFamily: "Avenir",
                                            color: Colors.white
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: width*0.3,
                          child: GestureDetector(
                            onTap: (){


                              if(widget.type=="dm"){
                                Navigator.push(context, CupertinoPageRoute(builder: (context){
                                  return celebrityChat(celebId: widget.celebrity ,isCelebrity: false,willShow: false,);
                                }));
                              }
                              else if(widget.type=="videoRequest"){
                                showDialog(
                                    context: context,
                                    builder: (context) {

                                      var width=MediaQuery.of(context).size.width;
                                      var height=MediaQuery.of(context).size.height;

                                      return Center(
                                        child: Stack(
                                          children: [
                                            Container(
                                                decoration:BoxDecoration(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20)
                                                    )
                                                ),
                                                width: width*0.8,
                                                height: height*0.8,
                                                child: InAppWebView(
                                                  initialUrlRequest: URLRequest(url: Uri.parse(widget.vidLink)),
                                                  initialOptions: InAppWebViewGroupOptions(
                                                      android: AndroidInAppWebViewOptions(
                                                          allowFileAccess: true,
                                                          cacheMode: AndroidCacheMode.LOAD_CACHE_ELSE_NETWORK,
                                                          allowContentAccess: true
                                                      )
                                                  ),
                                                )
                                            ),
                                            Container(
                                              width:width*0.8,
                                              height:height*0.8,
                                              child: Center(
                                                child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: FloatingActionButton(
                                                      mini: true,
                                                      backgroundColor: Colors.white,
                                                      child: Icon(Icons.close,color: Colors.black,),
                                                      onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:width*0.8,
                                              height:height*0.8,
                                              child: Center(
                                                child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: Container(
                                                      margin: EdgeInsets.only(bottom: height*0.2),
                                                      padding: EdgeInsets.all(10),
                                                    child: Image.asset(
                                                        "assets/logo.png",
                                                      color: Colors.white.withOpacity(0.6),
                                                      height: 100,
                                                    )
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:width*0.8,
                                              height:height*0.8,
                                              child: Center(
                                                child: Align(
                                                  alignment: Alignment.bottomRight,
                                                  child: Container(
                                                      padding: EdgeInsets.all(20),
                                                      child: FloatingActionButton(
                                                        onPressed: ()async{

                                                          showLoading(context: context);

                                                            Directory appDocDir = await getApplicationDocumentsDirectory();
                                                            File downloadToFile = File('${appDocDir.path}/${DateTime.now().millisecond}.mp4');

                                                            try {
                                                              await FirebaseStorage.instance
                                                                  .ref('requests/${widget.docId}/${widget.celebrity}')
                                                                  .writeToFile(downloadToFile);
                                                            } on FirebaseException catch (e) {
                                                              showErrorDialogue(context: context, message: e);
                                                            }



                                                          // String appDocumentsPath = '/storage/emulated/0/Documents';
                                                          Directory appDir= await getApplicationDocumentsDirectory();
                                                          String appDocumentsPath = appDir.path;
                                                          String filePath = '$appDocumentsPath/${DateTime.now().millisecond}.mp4';
                                                          File f = await getImageFileFromAssets('logoSmall.png');




                                                            print("filePath is");
                                                            print(filePath);
                                                          Navigator.pop(context);

                                                            showMessage(context: context, message: "Successfully Saved");








                                                        },
                                                        child: Icon(Icons.download,color: Colors.white,size: 50,),
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      );

                                    });
                              }



                            },
                            child: Container(
                                width: width*0.3,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(24, 47, 91, 1),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                                margin: EdgeInsets.only(left: 10),
                                padding:EdgeInsets.only(top:7,bottom: 7,left: 7,right: 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    widget.type=="dm"?Icon(Icons.message,color: Colors.white,):Icon(Icons.videocam,color: Colors.white,),
                                    SizedBox(width: 5,),
                                    Flexible(
                                      child: AutoSizeText(
                                        widget.status=="pending"?"Pending":"Completed",
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontFamily: "Avenir",
                                            color: Colors.white
                                        ),
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                        )
                      ],
                    )




                  ],
                ),
              ),
            );
          }

          else{
            return Center(
              child: Container(
                  height: 50,
                  width:50,
                  child: CircularProgressIndicator()
              ),
            );
          }

        }
    );
  }
}








class completed extends StatefulWidget {


  @override
  _completedState createState() => _completedState();
}

class _completedState extends State<completed> {
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.topCenter,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("requests").where("user",isEqualTo: FirebaseAuth.instance.currentUser.uid.toString()).where("type",isNotEqualTo:"eventBooking").where("status",isEqualTo: "complete").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              List<DocumentSnapshot> docs= snapshot.data.docs;
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: docs.length,
                itemBuilder: (context,index){
                  Map data=docs[index].data();
                  bool reviewed=data["reviewed"]==null?false:data["reviewed"];


                  return completedRow(vidLink:data["vidSrc"],type: data["type"],celebrity: data["celebrity"],user: data["user"],createdAt: data["createdAt"],status: data["status"],reviewed: reviewed,docId: docs[index].id,);
                },
              );
            }
            else{
              return Container();
            }
          }
      ),
    );


  }
}
