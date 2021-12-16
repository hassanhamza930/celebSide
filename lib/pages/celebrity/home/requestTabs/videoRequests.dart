import 'dart:io';

import 'package:camera/camera.dart';
import 'package:celebside/pages/celebrity/home/celebrityVideoRecord.dart';
import 'package:celebside/pages/home/celebrityProfile/howRefundsWork/refundMessage.dart';
import 'package:celebside/pages/home/celebrityProfile/sendMessage/celebrityChat.dart';
import 'package:celebside/pages/home/requests/completed.dart';
import 'package:celebside/util/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:celebside/util/styles.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:video_player/video_player.dart';
import "package:flutter/cupertino.dart";

class videoRequestRow extends StatefulWidget {
  final bool completed;
  final data;
  final id;
  videoRequestRow(
      {@required this.id, @required this.completed, @required this.data});

  @override
  _videoRequestRowState createState() => _videoRequestRowState();
}

class _videoRequestRowState extends State<videoRequestRow> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = widget.data;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(data["user"])
            .snapshots(),
        builder: (context, snapshot2) {
          if (snapshot2.hasData) {
            var celebData = snapshot2.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage("${celebData["imgSrc"]}"),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${celebData["fullName"]}",
                          style: smallBold(color: Colors.black),
                        ),
                        Text(
                          "Video Request",
                          style: TextStyle(
                            fontFamily: "Avenir",
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "${data["videoDate"].toDate().toString().split(" ")[0]}",
                          style: TextStyle(
                            fontFamily: "Avenir",
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.completed == false) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            var width = MediaQuery.of(context).size.width;
                            var height = MediaQuery.of(context).size.height;
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("requests")
                                      .doc(widget.id)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      var data = snapshot.data;

                                      var someone = data["videoPerson"] == "myself"
                                              ? false
                                              : true;

                                      var amount = TextEditingController(
                                          text: "${data["amount"]}");
                                      var date = TextEditingController(
                                          text:
                                              "${data["videoDate"].toDate().toString().split(" ")[0]}");
                                      var videoMessage = TextEditingController(
                                          text: data["videoMessage"]);
                                      var videoFor = TextEditingController(
                                          text: data["videoFor"]);
                                      bool private = data["private"];

                                      return Center(
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          color: Color.fromRGBO(24, 48, 93, 1),
                                          width: width * 0.9,
                                          height: height * 0.8,
                                          child: ListView(
                                            children: [
                                              SizedBox(
                                                height: 50,
                                              ),
                                              Center(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: width * 0.9,
                                                  child: Text(
                                                    "Request Video",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Avenir",
                                                        fontSize: 22),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  width: width * 0.9,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: CircleAvatar(
                                                          radius: 40,
                                                          child: CircleAvatar(
                                                            radius: 40,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    "${celebData['imgSrc']}"),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Flexible(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "From:\n${celebData["fullName"]}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      "AvenirBold",
                                                                  fontSize: 22),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              inputField(
                                                label: "Amount (GHS)",
                                                context: context,
                                                onChange: (e) {},
                                                controller: amount,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              inputField(
                                                  label: "Video For",
                                                  context: context,
                                                  onChange: (e) {},
                                                  controller: videoFor),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              inputField(
                                                  label: "Due Date",
                                                  context: context,
                                                  onChange: (e) {},
                                                  controller: date),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              inputFieldExpanded(
                                                  label: "Video Message",
                                                  context: context,
                                                  onChange: (e) {},
                                                  controller: videoMessage),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      "Private (Do not share video on LetsVibe)",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Avenir",
                                                          fontSize: 14),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Checkbox(
                                                      value: private,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          private = !private;
                                                        });
                                                      }),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                  onTap: () async {
                                                    // Navigator.pop(context);

                                                    Navigator.push(context,
                                                        CupertinoPageRoute(
                                                            builder: (context) {
                                                      return celebrityVideoRecord(
                                                        reqId: widget.id,
                                                      );
                                                    }));
                                                  },
                                                  child: Center(
                                                    child: Container(
                                                      padding: EdgeInsets.only(
                                                          top: 10, bottom: 10),
                                                      decoration: BoxDecoration(
                                                          color: Colors.orange,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          20))),
                                                      width: width * 0.9,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .videocam_sharp,
                                                            color: Colors.blue,
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "Upload",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                      "AvenirBold",
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.warning,
                                                      color: Colors.orange),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context,
                                                          CupertinoPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return HowRefundsWork();
                                                      }));
                                                    },
                                                    child: Center(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "How do refunds work?",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  "Avenir",
                                                              fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 150,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                            );
                          });
                    } else {
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
                                  )
                                ],
                              ),
                            );

                          });
                    }
                  },
                  child: Container(
                    width: 100,
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                        color: widget.completed == true
                            ? Colors.orange
                            : Color.fromRGBO(24, 48, 93, 1),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.videocam,
                            color: Colors.white,
                          ),
                          Flexible(
                              child: Text(
                            widget.completed == true ? "Ready-Play" : "Pending",
                            style: small(color: Colors.white, size: 12),
                          )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

class videoRequests extends StatefulWidget {
  videoRequests({this.completed});
  final completed;

  @override
  _videoRequestsState createState() => _videoRequestsState();
}

class _videoRequestsState extends State<videoRequests> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("requests")
                .where("celebrity", isEqualTo: FirebaseAuth.instance.currentUser.uid.toString())
                .where("type", isEqualTo: "videoRequest")
                .where("filtered",isEqualTo: true)
                .where("status",
                    isEqualTo:
                        widget.completed == true ? "complete" : "pending")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var docs = snapshot.data.docs;
                return Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: ListView.builder(
                        itemCount: docs.length,
                        shrinkWrap: true,
                        itemBuilder: (snapshot, index) {
                          return videoRequestRow(
                              id: docs[index].id,
                              completed: widget.completed,
                              data: docs[index]);
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 150,
        ),
      ],
    );
  }
}
