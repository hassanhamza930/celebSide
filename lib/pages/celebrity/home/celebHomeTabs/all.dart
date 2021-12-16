import 'package:celebside/pages/celebrity/home/celebHomeTabs/dms.dart';
import 'package:celebside/pages/celebrity/home/celebHomeTabs/eventBookings.dart';
import 'package:celebside/pages/celebrity/home/celebHomeTabs/videoRequests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class allCelebHomeTabRequests extends StatefulWidget {

  @override
  _allCelebHomeTabRequestsState createState() => _allCelebHomeTabRequestsState();
}

class _allCelebHomeTabRequestsState extends State<allCelebHomeTabRequests> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("status",isEqualTo: "pending").where("filtered",isEqualTo: false).snapshots(),
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
                    DocumentSnapshot currentDoc=docs[index];

                    Map data=currentDoc.data();


                    if(data["type"]=="dm"){
                      return celebrityHomePageDmRequestRow(data: data, id: currentDoc.id);
                    }
                    else if(data["type"]=="videoRequest"){
                      return celebrityHomePageRequestsVideoRequests(data: data, id: currentDoc.id);
                    }
                    else if(data["type"]=="eventBooking"){
                      return celebHomePageEventBookingRequestsRow(data: data, id: currentDoc.id);
                    }
                    else{
                      return Container(child: Text("TESTING"),);
                    }

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
