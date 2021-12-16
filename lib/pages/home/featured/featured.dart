import 'components/components.dart';
import 'package:celebside/pages/home/featured/components/celebrityContainer.dart';
import 'package:celebside/pages/home/featured/components/featuredVibeContainer.dart';
import 'package:celebside/pages/home/featuredVideoPlayer/featuredVideoPlayer.dart';
import 'package:celebside/pages/home/search/search.dart';
import 'package:celebside/pages/home/trending/trending.dart';
import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';




var featuredData=[
  {
    'imgSrc':"assets/featured/featuredVibe1.png",
    'name':"Thomas Curtis"
  },
  {
    'imgSrc':"assets/featured/featuredVibe1.png",
    'name':"StoneBwoy"
  },
  {
    'imgSrc':"assets/featured/featuredVibe1.png",
    'name':"Jackie Appiah"
  },
];


var categoryData=[
  {
    'imgSrc':"assets/featured/celebrityStoneBoy.png",
    'name':"Stone Bwoy"
  },
  {
    'imgSrc':"assets/featured/celebrityStoneBoy.png",
    'name':"Jackie Appiah"
  },
  {
    'imgSrc':"assets/featured/celebrityStoneBoy.png",
    'name':"Daniels"
  },
  {
    'imgSrc':"assets/featured/celebrityStoneBoy.png",
    'name':"Chad"
  },
];


class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/bluebackground.png",
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Container(
              margin: EdgeInsets.only(top: 10,bottom: 50),
              // padding: EdgeInsets.only(bottom:100),
              child: Center(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                CupertinoPageRoute(builder: (context){
                                  return Search();
                                })
                            );
                          },
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(3),
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0))),
                              child: Center(
                                child: TextField(
                                  enabled: false,
                                  style: TextStyle(color: Colors.white, fontFamily: 'Avenir'),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    enabled: true,
                                    labelText: 'Search',
                                    labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Avenir'),
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsetsDirectional.only(start: 20.0),
                                  ),
                                  onChanged: (_onChanged) {
                                    print(_onChanged);
                                  },
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(context,CupertinoPageRoute(builder: (context){
                                return Trending();
                              }));
                            },
                            child: Image.asset(
                                "assets/categories.png",
                              fit: BoxFit.contain,
                              height: 30,
                            )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    featuredVibes(),
                    banner(),
                    categoryRow(context: context,categoryData: categoryData,categoryName: "Trending"),
                    SizedBox(height: 10,),
                    categoryRow(context: context,categoryData: categoryData,categoryName: "Pick of the week"),
                    bigBanner(context: context),
                    SizedBox(height: 10,),
                    categoryRow(context: context,categoryData: categoryData,categoryName: "Musicians"),
                    SizedBox(height: 10,),
                    categoryRow(context: context,categoryData: categoryData,categoryName: "Actors"),
                    SizedBox(height: 50,),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
