import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


addTransaction({
  @required double amount,
  @required String message,
  @required String to,
  @required String from,
  @required String personId
})async{

  await FirebaseFirestore.instance.collection("transactions")
      .doc()
      .set(
      {
        "createdAt":DateTime.now(),
        "message": message,
        "to": to,
        "from": from,
        "amount": amount,
        "personId":personId
      },
      SetOptions(merge: true)
  );


}