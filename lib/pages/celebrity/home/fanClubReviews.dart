import 'package:celebside/pages/home/celebrityProfile/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_rating_bar/flutter_rating_bar.dart';



List inviteData=[
  {
    'imgSrc':"assets/search/avatarSearch.png",
    'name':"Stone Bwoy"
  },
  {
    'imgSrc':"assets/search/avatarSearch.png",
    'name':"Stone Bwoy2"
  },
  {
    'imgSrc':"assets/search/avatarSearch.png",
    'name':"Stone Bwoy3"
  },
];



celebViberRow({@required BuildContext context,bool status=false,@required String user,@required double rating,@required String review}){
  var width=MediaQuery.of(context).size.width;
  var height=MediaQuery.of(context).size.height;
  return GestureDetector(
    onTap: (){

    },
    child: Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top:10,bottom: 10),
            width:width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("users").doc(user).snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      Map userData=snapshot.data.data();

                      return Container(
                        width: width*0.5,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage("${userData["imgSrc"]}"),
                              ),
                            ),
                            SizedBox(width: 5,),
                            Flexible(
                              child: Text(
                              "${userData["fullName"]}",
                              style: small(color: Colors.white),
                              textAlign: TextAlign.left,
                              ),
                              ),
                          ],
                        ),
                      );
                    }
                    else{
                      return Container();
                    }
                  }
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: width*0.3,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    padding: EdgeInsets.all(5),
                    child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            RatingBar.builder(
                                itemSize: 15,
                                allowHalfRating: true,
                                ignoreGestures:   true,
                                initialRating: double.parse("${rating}"),
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
                              "${double.parse("${rating}")}",
                              style: small(color: Colors.white,size: 14)
                            ),
                          ],
                        ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left:20,right: 20,bottom: 20),
          width: width,
            child: Text(
                "${review}",
              style: small(color: Colors.white,size: 14),
              textAlign: TextAlign.start,
            )
        ),
        Divider(color: Colors.black,height: 5,),
      ],
    ),
  );
}





class fanClubReviews extends StatefulWidget {
  @override
  _fanClubReviewsState createState() => _fanClubReviewsState();
}

class _fanClubReviewsState extends State<fanClubReviews> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/bluebackground.png",fit: BoxFit.cover,width: width,),
            Center(
              child: ListView(
                children: [
                  SizedBox(height: 70,),
                  Center(
                    child: Container(
                      width: width*0.9,
                      child: Text(
                        "Your Reviews",
                        style: medium(color: Colors.white),
                      ),
                    ),
                  ), //Search
                  SizedBox(height: 20,),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        Map celebData=snapshot.data.data();
                        

                        return StreamBuilder(
                          stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("reviewed",isEqualTo: true).snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              List<DocumentSnapshot> requests=snapshot.data.docs;
                              return Center(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: requests.length,
                                  itemBuilder: (context,index){
                                    Map currentReqData=requests[index].data();
                                    Map currentReview=currentReqData["review"];

                                    return celebViberRow(context: context,status: true,rating:double.parse("${currentReview["rating"]}"),review: currentReview["remarks"],user: currentReqData["user"] );

                                    },
                                ),
                              );
                            }
                            else{
                              return Container();
                            }
                          }
                        );
                      }
                      else{
                        return Container();
                      }

                    }
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: Icon(
                  //     Icons.arrow_back,
                  //     color: Colors.white,
                  //     size: 30,
                  //   ),
                  // ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('Done',style: small(color: Colors.orange),)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
