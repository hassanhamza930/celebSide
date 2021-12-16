import 'package:celebside/pages/home/videoPlayer/videoPlayer.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';

class orderDetails extends StatefulWidget {
  @override
  _orderDetailsState createState() => _orderDetailsState();
}

class _orderDetailsState extends State<orderDetails> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body:  Scaffold(
            body: Stack(
              children: [
                Image.asset("assets/bluebackground.png",fit: BoxFit.cover,width: width,),
                Center(
                    child: Container(
                      width: width*0.9,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Text(
                              "Order Details",
                              style: medium(color: Colors.white,),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/requestVideo/requestVideoProfilePic.png",
                                    width: 100,
                                  ),
                                  SizedBox(width: 10,),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "StoneBwoy",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontFamily: "AvenirBold",
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 5,),
                                        Text(
                                          "Video Shoutout",
                                          style: smallBold(color: Colors.orange)
                                        ),
                                        SizedBox(height: 5,),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                CupertinoPageRoute(builder: (context){
                                                  return videoPlayer();
                                                })
                                            );
                                          },
                                          child: Container(
                                            width: width*0.32,
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                              ),
                                              padding:EdgeInsets.only(top:7,bottom: 7,left: 10,right: 10),
                                              // padding: EdgeInsets.all(5),
                                              child: Row(
                                                children: [
                                                  Icon(Icons.videocam_sharp,color: Colors.white,),
                                                  SizedBox(width: 5,),
                                                  Flexible(
                                                    child: Text(
                                                      "Ready - Play",
                                                      style: TextStyle(
                                                          fontFamily: "Avenir",
                                                          fontSize: 12,
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Your Name is",style: small(color: Colors.white),),
                                  Flexible(child: Text("Prince Daniels",style: small(color: Color.fromRGBO(52,217, 247,1)),)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Their Name is",style: small(color: Colors.white),),
                                  Flexible(child: Text("-",style: small(color: Color.fromRGBO(52,217, 247,1)),)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Center(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("This Video is for",style: small(color: Colors.white),),
                                  Flexible(child: Text("Other",style: small(color: Color.fromRGBO(52,217, 247,1)),)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text("Instructions",style: small(color: Colors.white),),
                          SizedBox(height: 10,),
                          Text("I am a big fan and i a want a video for my birthday"*10,style: small(color: Color.fromRGBO(52,217, 247,1)),),
                          SizedBox(height: 40,),
                          Container(
                            padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(24, 48, 93, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    20
                                  )
                                )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left:10,bottom: 10),
                                      child: Text("Payment Details",style: smallBold(color: Colors.orange),textAlign: TextAlign.left,)
                                  ),
                                  Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                        color: Colors.orange,
                                        width: 3,
                                      ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Transaction ID",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Avenir",
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "Vibe Video 0012",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Avenir",
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Payment",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Avenir",
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "MTN Momo",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Avenir",
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                            ),
                                ],
                              ),
                          ),
                          SizedBox(height: 50,)
                        ],
                      ),
                    )
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.only(left:20,top:40),
                    alignment: Alignment.topLeft,
                    child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
