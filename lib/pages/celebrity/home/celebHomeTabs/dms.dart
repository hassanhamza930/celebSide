import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/services/addToWallet.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


class celebrityHomePageDmRequestRow extends StatefulWidget {

  final Map data;
  final String id;
  celebrityHomePageDmRequestRow({@required this.data,@required this.id});
  
  @override
  _celebrityHomePageDmRequestRowState createState() => _celebrityHomePageDmRequestRowState();
}

class _celebrityHomePageDmRequestRowState extends State<celebrityHomePageDmRequestRow> {
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
              margin: EdgeInsets.only(bottom: 20),
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
                        Flexible(
                          flex: 1,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                "${userData["imgSrc"]}"
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          flex: 3,
                          child: Column(
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
                          ),
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
                        Flexible(
                          child: Text(
                            "Request For",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.message,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 10,),
                              Text(
                                "DM",
                                style: TextStyle(
                                    fontFamily: "Avenir",
                                    fontSize: 14,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "Respond Before",
                            style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "${data["createdAt"].toDate().add(Duration(days: 7)).toString().split(" ")[0]}",
                            style: TextStyle(
                                fontFamily: "AvenirBold",
                                fontSize: 14,
                                color: Colors.black
                            ),
                            textAlign: TextAlign.right,
                          ),
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
                                  "Accept & Chat",
                                  style: smallBold(color: Colors.white)
                              ),
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: DateTime.now().toString(),
                          elevation: 0,
                          onPressed: ()async {
                            await FirebaseFirestore.instance.collection("requests").doc(widget.id).set({"status":"refunded"},SetOptions(merge: true));
                            await addToWallet(amount:data["amount"] , id: data["user"], type: "users");
                            await addNotifications(target: "user", message: "Your DM request was rejected, ${data["amount"]} GHS was refunded", from: FirebaseAuth.instance.currentUser.uid, to: data["user"], type: "dm");
                            await addTransaction(personId:data["user"],message: "DM Refund", to: data["user"], from: "letsvibe", amount: data["amount"]);

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









class dms extends StatefulWidget {

  @override
  _dmsState createState() => _dmsState();
}

class _dmsState extends State<dms> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("type",isEqualTo: "dm").where("status",isEqualTo: "pending").where("filtered",isEqualTo: false).snapshots(),
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

                  return celebrityHomePageDmRequestRow(data: docs[index].data(),id:indivisualDoc.id);
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
