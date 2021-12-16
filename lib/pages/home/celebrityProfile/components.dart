import 'package:celebside/pages/home/celebrityProfile/requestVideo/requestVideo.dart';
import 'package:celebside/pages/home/celebrityProfile/sendMessage/celebrityChat.dart';
import 'package:celebside/pages/home/videoPlayer/videoPlayer.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/cupertino.dart';


celebButton({@required String label,@required BuildContext context,@required Color color,@required Color bg,@required var icon,@required Function() onpress}){
  var width= MediaQuery.of(context).size.width;
  return Center(
    child: Container(
      width: width*0.9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: (){
                onpress();
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top:10,bottom: 10,left:5,right:5),
                  decoration: BoxDecoration(
                      color: bg,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  width: width*0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      SizedBox(width: 20,),
                      Flexible(
                        child: Text(
                          label,
                          style: smallBold(color: color),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),
          SizedBox(height: 10,),
        ],
      ),
    ),
  );
}

demoVideo({@required BuildContext context,@required String preview}){
  return GestureDetector(
    onTap:(){
      Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context){
                return videoPlayer();
              }
          )
      );
    },
    child: Container(

        padding: EdgeInsets.all(10),
       // height: 500,
        //width: MediaQuery.of(context).size.width*0.5,
        child: Image.asset(
          preview,
          fit: BoxFit.cover,
        )
    ),
  );
}



rating({@required BuildContext context,@required double rating,@required int responseTime,@required int reviews}){
  var width=MediaQuery.of(context).size.width;
  return Center(
    child: Container(
      width: width * 0.92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(24, 48, 93, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                )),
            width: width * 0.45,
            height: 70,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "$responseTime Days",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Avenir",
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: Text(
                    "Response Time:",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "Avenir",
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
            width: 2,
          ),
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(24, 48, 93, 1),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            width: width * 0.45,
            height: 70,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RatingBar.builder(
                        itemSize: 20,
                        allowHalfRating: true,
                        ignoreGestures:   true,
                        initialRating: rating,
                        itemBuilder: (context, _) {
                          return Icon(
                            Icons.star,
                            color: Colors.amber,
                          );
                        },
                        onRatingUpdate: (val) {

                        }
                    ),
                    Text(
                      "${rating}",
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "AvenirBold",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${reviews} Reviews",
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: "Avenir",
                        color: Colors.orange,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}



description({@required String description,@required BuildContext context}){
  var width=MediaQuery.of(context).size.width;
  return Center(
    child: Container(
      width: width*0.9,
      child:Text(
          description,
          textAlign: TextAlign.left,
          style: small(color: Colors.white,size: 15)
      ),
    ),
  );
}