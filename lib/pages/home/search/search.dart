import 'package:celebside/pages/home/home.dart';
import 'package:celebside/pages/home/search/components.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutter/cupertino.dart';

var scrollController = ScrollController();
var searchBar = TextEditingController();
var limit = 10;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/bluebackground.png",
            fit: BoxFit.cover,
            width: width,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Center(
                  child: Container(
                    width: width * 0.9,
                    child: Text(
                      "Search",
                      style: medium(color: Colors.white),
                    ),
                  ),
                ), //Search
                SizedBox(height: 20,),
                searchField(
                    label: "Search",
                    context: context,
                    onChange: (val) {
                      setState(() {

                      });
                    },
                    controller: searchBar),
                SizedBox(
                  height: 20,
                ),
                searchBar.text==""?Center(
                  child: Container(
                    width: width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Searches",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontFamily: "Avenir",
                          ),
                        ),
                        TextButton(
                          onPressed: ()async{
                            var storage=LocalStorage("recentStorage");
                            if(await storage.ready){
                              await storage.deleteItem("recentSearches");
                              await storage.clear();
                            }
                            setState(() {
                            });
                          },
                          child: Text(
                            "Clear All",
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.orange,
                              fontFamily: "Avenir",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ):Container(), //Recent Searches
                searchBar.text==""?
                recentSeaches():
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("celebrities")
                          .limit(limit)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return NotificationListener<ScrollEndNotification>(
                            onNotification: (scrollEnd) {
                              var metrics = scrollEnd.metrics;
                              if (metrics.atEdge) {

                                if (metrics.pixels == 0)
                                {
                                  print('At top');
                                  setState(() {
                                    limit = 10;
                                  });
                                  print(limit);

                                }

                                else
                                  {
                                  print('At bottom');
                                  setState(() {
                                    limit += 5;
                                  });
                                  print(limit);
                                }


                              }
                              return true;
                            },
                            child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                controller: scrollController,
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot doc = snapshot.data.docs[index];
                                  var data = doc;
                                  var fullName = (data["fullName"]);
                                  var imgSrc = (data["imgSrc"]);

                                  if(doc["fullName"].toString().toLowerCase().contains(searchBar.text.toString().toLowerCase())){
                                    return searchRow(
                                        context: context,
                                        name: fullName,
                                        imgSrc: imgSrc,
                                        id: data.id
                                    );
                                  }
                                  else{
                                    return Container();
                                  }


                                }),
                          );
                        }

                        return Text(
                          "loading..",
                          style: small(color: Colors.white),
                        );
                      }),
                ),


                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: height,
            width: width,
            child: Container(
              height: 70,
              padding: EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 10),
              color: Color.fromRGBO(24, 48, 93, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        print("one");
                        setState(() {
                          currentTab = 0;
                        });
                        Navigator.pushReplacement(context,
                            CupertinoPageRoute(builder: (context) {
                          return Home();
                        }));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    currentTab == 0
                                        ? Colors.orange
                                        : Colors.white,
                                    BlendMode.srcATop),
                                child: Image.asset(
                                  "assets/bottom bar/simple/1.png",
                                  fit: BoxFit.contain,
                                  height: 25,
                                )),
                            Text(
                              "Home",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 12,
                                color: currentTab == 0
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        print("one");
                        setState(() {
                          currentTab = 1;
                        });
                        Navigator.pushReplacement(context,
                            CupertinoPageRoute(builder: (context) {
                          return Home();
                        }));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    currentTab == 1
                                        ? Colors.orange
                                        : Colors.white,
                                    BlendMode.srcATop),
                                child: Image.asset(
                                  "assets/bottom bar/simple/2.png",
                                  fit: BoxFit.contain,
                                  height: 25,
                                )),
                            Text(
                              "Requests",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 12,
                                color: currentTab == 1
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        print("one");
                        setState(() {
                          currentTab = 2;
                        });
                        Navigator.pushReplacement(context,
                            CupertinoPageRoute(builder: (context) {
                          return Home();
                        }));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    currentTab == 2
                                        ? Colors.orange
                                        : Colors.white,
                                    BlendMode.srcATop),
                                child: Image.asset(
                                  "assets/bottom bar/simple/3.png",
                                  fit: BoxFit.contain,
                                  height: 25,
                                )),
                            Text(
                              "Notifications",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 12,
                                color: currentTab == 2
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        print("one");
                        setState(() {
                          currentTab = 3;
                        });
                        Navigator.pushReplacement(context,
                            CupertinoPageRoute(builder: (context) {
                          return Home();
                        }));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    currentTab == 3
                                        ? Colors.orange
                                        : Colors.white,
                                    BlendMode.srcATop),
                                child: Image.asset(
                                  "assets/bottom bar/simple/4.png",
                                  fit: BoxFit.contain,
                                  height: 25,
                                )),
                            Text(
                              "Profile",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 12,
                                color: currentTab == 3
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ), //NAVBAR
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 40),
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
              )),
        ],
      ),
    );
  }
}
