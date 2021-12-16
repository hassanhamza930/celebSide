import 'package:celebside/pages/home/featuredVideoPlayer/featuredVideoPlayer.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class FeaturedVibeContainer extends StatefulWidget {

  FeaturedVibeContainer({this.reqId,this.celebData,this.reqData,this.vidId,this.imgSrc,this.name});
  final reqId;
  final Map celebData;
  final Map reqData;
  final String vidId;
  final String imgSrc;
  final String name;

  @override
  _FeaturedVibeContainerState createState() => _FeaturedVibeContainerState();
}

class _FeaturedVibeContainerState extends State<FeaturedVibeContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            CupertinoPageRoute(builder:(context){
              return featuredVideoPlayer(reqId:widget.reqId,reqData: widget.reqData,celebData: widget.celebData,vidId: widget.vidId,);
            })
        );
      },
      child: Container(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child:Image.network(widget.imgSrc,height: 179,width: 135,fit: BoxFit.cover,),
            ),
            Container(
              padding: EdgeInsets.all(5),
              height:179,
              width: 135,
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                        this.widget.name,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Avenir",
                        color: Colors.white
                      ),

                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
