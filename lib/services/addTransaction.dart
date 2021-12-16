import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


addTransaction({@required String flow,@required String message, @required String to, @required String from ,@required double amount,double discount=0})async{

  await FirebaseFirestore.instance.collection("transactions")
      .doc()
      .set(
          {
            "flow":flow,
            "createdAt":DateTime.now(),
            "message": message,
            "to": to,
            "from": from,
            "amount": amount,
            "discount":discount
          },
        SetOptions(merge: true)
          );


}