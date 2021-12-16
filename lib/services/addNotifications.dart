import 'package:celebside/services/fetchUsersData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


addNotifications( { @required String target, @required String message , String , @required String from , @required String to,@required String type } )async{


  if(target=="user"){

    await FirebaseFirestore.instance.collection("users").doc(to).collection("notifications").add(
        {
          "createdAt":DateTime.now(),
          "from":from,
          "to":to,
          "message":message,
          "type":type
        }
        );


  }

  else if(target=="celebrity"){

    await FirebaseFirestore.instance.collection("celebrities").doc(to).collection("notifications").add(
        {
          "createdAt":DateTime.now(),
          "from":from,
          "to":to,
          "message":message,
          "type":type
        }
    );

  }


}