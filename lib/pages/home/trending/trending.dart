import 'package:celebside/pages/home/featured/components/celebrityContainer.dart';
import 'package:celebside/util/styles.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
class Trending extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/bluebackground.png",width: width,fit: BoxFit.cover,),
            Container(
              height: MediaQuery.of(context).size.height,
              width: width,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SizedBox(height: 50,),
                    Center(
                      child: Container(
                        width: width*0.9,
                        margin: EdgeInsets.only(top:20),
                        child: Text(
                          "Trending",
                          textAlign: TextAlign.center,
                          style: medium(color: Colors.white),
                        ),

                      ) ,
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: width*0.9,
                      child: Column(
                        children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             celebrityContainer("assets/featured/celebrityStoneBoy.png","StoneBoy"),
                             celebrityContainer("assets/featured/celebrityStoneBoy.png","StoneBoy"),
                           ],
                         ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              celebrityContainer("assets/featured/celebrityStoneBoy.png","StoneBoy"),
                              celebrityContainer("assets/featured/celebrityStoneBoy.png","StoneBoy"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              celebrityContainer("assets/featured/celebrityStoneBoy.png","StoneBoy"),
                              celebrityContainer("assets/featured/celebrityStoneBoy.png","StoneBoy"),
                            ],
                          ),

                        ],
                      )
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(left:20,top:20),
                alignment: Alignment.topLeft,
                child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
