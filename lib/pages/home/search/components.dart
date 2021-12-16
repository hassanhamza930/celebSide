import 'package:celebside/pages/home/celebrityProfile/celebrityProfilePage.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:localstorage/localstorage.dart';
import 'package:flutter/cupertino.dart';

recentRow({@required BuildContext context, @required String id}) {
  var width = MediaQuery.of(context).size.width;

  fetchUserData(idToFetch)async{
    var userDoc= await FirebaseFirestore.instance.collection("celebrities").doc(idToFetch).get();
    var userData=userDoc.data();
    return userData;
  }

  return FutureBuilder(
    future: fetchUserData(id),
    builder: (context, snapshot) {

      var data=snapshot.data;

      if(snapshot.hasData){
        return GestureDetector(
          onTap: () async {

            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return celebrityProfilePage(id: id,);
            }));
          },
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                          width: width * 0.2,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Center(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage("${data["imgSrc"]}"),
                              ),
                            ),
                          ),
                      ),
                      Container(
                        width: width * 0.5,
                        child: Text(
                          "${data["fullName"]}",
                          style: small(color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        width: width * 0.25,
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.all(Radius.circular(20))),
                          padding:
                          EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                          //height: 50,
                          child: Center(
                            child: Text(
                              "REQUEST",
                              textAlign: TextAlign.center,
                              style: smallBold(color: Colors.white, size: 12),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 5,
              ),
            ],
          ),
        );
      }
      else{
        return Container();
      }


    }
  );
}

searchRow(
    {@required BuildContext context,
    @required String name,
    @required String imgSrc,
    @required String id}) {
  var width = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: () async {
      final storage = new LocalStorage('recentStorage');
      await storage.ready;
      List current = storage.getItem("recentSearches");
      if (current == null) {
        current = [id];
      } else {
        if(current.contains(id)){

        }
        else{
          current.add(id);
        }
      }

      await storage.setItem("recentSearches", current);
      print(await storage.getItem("recentSearches"));

      Navigator.push(context, CupertinoPageRoute(builder: (context) {
        return celebrityProfilePage(id: id,);
      }));
    },
    child: Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Container(
                    width: width * 0.2,
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage("${imgSrc}"),
                        ),
                      ),
                    ),
                ),
                Container(
                  width: width * 0.5,
                  child: Text(
                    name,
                    style: small(color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: width * 0.25,
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 7, top: 7),
                    //height: 50,
                    child: Center(
                      child: Text(
                        "REQUEST",
                        textAlign: TextAlign.center,
                        style: smallBold(color: Colors.white, size: 12),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          color: Colors.black,
          height: 5,
        ),
      ],
    ),
  );
}

class recentSeaches extends StatefulWidget {
  @override
  _recentSeachesState createState() => _recentSeachesState();
}

class _recentSeachesState extends State<recentSeaches> {



  fetchData() async {
    var storage=LocalStorage('recentStorage');
    if(await storage.ready){
      var data=await LocalStorage("recentStorage").getItem("recentSearches");
      return data;
    }

  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var data = snapshot.data;
                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return recentRow(context: context, id: data[index]);
                  },
                );
              }
              else{
                return Container(child: Text("Recent searches will be shown here",style: small(color: Colors.white54,size: 14),),);
              }

            }));
  }
}
