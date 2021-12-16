import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


Future<Map> getUserData({@required String id})async{

  DocumentSnapshot doc=await FirebaseFirestore.instance.collection("users").doc(id).get();
  Map data=doc.data();

  return data;

}


Future<Map> getCelebrityData({@required String id})async{

  DocumentSnapshot doc=await FirebaseFirestore.instance.collection("celebrities").doc(id).get();
  Map data=doc.data();

  return data;

}