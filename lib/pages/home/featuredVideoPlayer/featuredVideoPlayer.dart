
import 'package:celebside/pages/home/featuredVideoPlayer/components/panel.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class featuredVideoPlayer extends StatefulWidget {

  final celeb;
  final reqId;
  final Map celebData;
  final Map reqData;
  final String vidId;

  featuredVideoPlayer({this.celeb,this.reqId,this.celebData,this.reqData,this.vidId});


  @override
  _featuredVideoPlayerState createState() => _featuredVideoPlayerState();
}

class _featuredVideoPlayerState extends State<featuredVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SlidingUpPanel(
          maxHeight: height*0.4,
          minHeight: widget.celeb==true?height*0.0:height*0.15,
          color: widget.celeb==true?Colors.transparent:Colors.black,
          panelBuilder: (context){
            print("widget is celeb is");
            if(widget.celeb==true){
              return Container();
            }
            else{
              return panel();
            }
          },
          body: Stack(
            children: [
              Center(
                child:
                Container(
                    decoration:BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20)
                        )
                    ),
                    width: width,
                    height: height,
                    child: InAppWebView(
                      initialUrlRequest: URLRequest(url: Uri.parse(widget.vidId)),
                      initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(
                              allowFileAccess: true,
                              needInitialFocus: true,
                              cacheMode: AndroidCacheMode.LOAD_CACHE_ELSE_NETWORK,
                              allowContentAccess: true
                          )
                      ),
                    )
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top:20),
                  child: ListView(
                    children: [
                      Center(
                        child: Container(
                          width: width*0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      padding:EdgeInsets.only(right:15),
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage("${widget.celebData["imgSrc"]}"),
                                      )
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.celebData["fullName"]}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Averin",
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${widget.celebData["handle"]}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Averin",
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Text(
                                        "${widget.celebData["mostFollowers"]} Star",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Averin",
                                          color: Colors.white70,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              FloatingActionButton(
                                backgroundColor: Colors.black,
                                mini: true,
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child:Icon(Icons.close_outlined,color: Colors.white,),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                height: height,
                width: width,
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    TextButton(
                      onPressed: ()async{

                        print("pressed");
                        showLoading(context: context);
                        List newLikers=widget.reqData["likers"]==null?[]:widget.reqData["likers"];
                        var likes=widget.reqData["likes"]==null?0:widget.reqData["likes"];
                        likes=likes+1;

                        if(newLikers.contains(FirebaseAuth.instance.currentUser.uid.toString())){
                        }
                        else{
                          newLikers.add(FirebaseAuth.instance.currentUser.uid.toString());
                          FirebaseFirestore.instance.collection("requests").doc(widget.reqId)
                              .set({
                            "likers":newLikers,
                            "likes":likes
                          },SetOptions(merge: true));


                        }

                        Navigator.pop(context);

                      },
                        child: Image.asset(
                            "assets/featuredVideoPlayer/fireIcon.png",
                            color: Colors.white,width: 30,fit:BoxFit.cover
                        )
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(
                          "${widget.reqData["likes"]==null?0:widget.reqData["likes"]}",
                        style: small(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          )
        )
    );
  }
}
