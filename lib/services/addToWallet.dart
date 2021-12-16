import 'package:celebside/services/fetchUsersData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

addToWallet({@required double amount, @required String id, @required String type}) async {
  Map data = await FirebaseFirestore.instance.collection("$type").doc(id).get().then((value) => value.data());

  var wallet = data["wallet"] == null ? 0 : double.parse("${data["wallet"]}");

  wallet = wallet + amount;

  await FirebaseFirestore.instance.collection("$type").doc(id).set({"wallet": wallet}, SetOptions(merge: true));
}
