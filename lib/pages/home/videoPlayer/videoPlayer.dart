import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
class videoPlayer extends StatefulWidget {
  @override
  _videoPlayerState createState() => _videoPlayerState();
}

class _videoPlayerState extends State<videoPlayer> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              color: Colors.black,
              height: height,
              width: width,
              child: Image.asset(
                  "assets/videoPlayer/videoPlayerBack.png",
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 20),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset("assets/featuredVideoPlayer/soundIcon.png",width: 40,fit:BoxFit.cover),
                    SizedBox(height: 20,),
                    Image.asset("assets/featuredVideoPlayer/fireIcon.png",width: 40,fit:BoxFit.cover),
                    SizedBox(height: 20,),
                    Image.asset("assets/featuredVideoPlayer/shareIcon.png",width: 40,fit:BoxFit.cover),
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
    );
  }
}
