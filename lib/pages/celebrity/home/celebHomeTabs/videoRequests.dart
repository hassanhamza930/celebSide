import 'package:celebside/pages/celebrity/home/celebHomeTabs/dms.dart';
import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/services/addToWallet.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:celebside/util/styles.dart';


class celebrityHomePageRequestsVideoRequests extends StatefulWidget {

  final Map data;
  final String id;
  celebrityHomePageRequestsVideoRequests({@required this.data,@required this.id});

  @override
  _celebrityHomePageRequestsVideoRequestsState createState() => _celebrityHomePageRequestsVideoRequestsState();
}

class _celebrityHomePageRequestsVideoRequestsState extends State<celebrityHomePageRequestsVideoRequests> {
  Map celebData=null;

  update()async{
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCelebrityData(id: FirebaseAuth.instance.currentUser.uid).then((value) {
     celebData=value;
      update();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    Map data=widget.data;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("users").doc(data["user"]).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          Map userData=snapshot.data.data();

          return Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * 0.85,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              "${userData["imgSrc"]}"
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userData["fullName"]}",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              "${data["createdAt"].toDate().toString().split(" ")[0]}",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${data["message"]}",
                      style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Request For",
                          style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.videocam_sharp,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 5,),
                            Text(
                              "${data["videoFor"]}",
                              style: TextStyle(
                                  fontFamily: "Avenir",
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booked For",
                          style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Text(
                          "${data["videoPerson"]}",
                          style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 14,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Respond Before",
                          style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 14,
                              color: Colors.black),
                        ),
                        Text(
                          celebData==null?"":"${data["createdAt"].toDate().add(Duration(days:int.parse("${celebData["videoRequest"]["responseTime"]}") ))}".split(" ")[0],
                          style: TextStyle(
                              fontFamily: "AvenirBold",
                              fontSize: 14,
                              color: Colors.black),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: ()async{
                            await FirebaseFirestore.instance.collection("requests").doc(widget.id).set({"filtered":true},SetOptions(merge: true));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.all(Radius.circular(20))),
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Center(
                              child: Text(
                                  "Accept",
                                  style: smallBold(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: DateTime.now().toString(),
                          elevation: 0,
                          onPressed: ()async {
                            await FirebaseFirestore.instance.collection("requests").doc(widget.id).delete();
                            await addToWallet(amount:data["amount"] , id: data["user"], type: "users");
                            await addNotifications(target: "user", message: "Your Video Request was rejected, ${data["amount"]} GHS was refunded", from: FirebaseAuth.instance.currentUser.uid, to: data["user"], type: "videoRequest");
                            await addTransaction(flow: 'in', message: "Video Request Refund", to: data["user"], from: data["celebrity"], amount: data["amount"]);

                          },
                          mini: true,
                          backgroundColor: Colors.black.withOpacity(0.2),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        else{
          return Container();
        }
      }
    );
  }
}



class videoRequests extends StatefulWidget {
  videoRequests({this.currentTab});
  final currentTab;

  @override
  _videoRequestsState createState() => _videoRequestsState();
}

class _videoRequestsState extends State<videoRequests> {
  @override
  Widget build(BuildContext context) {


    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("type",isEqualTo: "videoRequest").where("status",isEqualTo: "pending").where("filtered",isEqualTo: false).snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            QuerySnapshot doc=snapshot.data;
            List docs=doc.docs;

            return Container(
              margin: EdgeInsets.only(bottom: 50),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (context,index){
                    DocumentSnapshot indivisualDoc=docs[index];

                    return celebrityHomePageRequestsVideoRequests(data: docs[index].data(),id:indivisualDoc.id);
                  }),
            );
          }
          else{
            return Container();
          }
        }
    );

  }
}
