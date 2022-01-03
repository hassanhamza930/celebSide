import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";



calculateTotalEarnings({@required String celebId})async{

  var totalEarnings=0.0;
  var resp= await FirebaseFirestore.instance.collection("transactions").where("personId",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("from",isEqualTo:"letsvibe").get();
  List docs=resp.docs;
  docs.forEach((element) {
    totalEarnings+=double.parse("${element.data()["amount"]}");
  });

  return Future.delayed(Duration(milliseconds: 100),(){
    print('returned');
    return double.parse("${totalEarnings}").floor();
  });

}


calculateMonthlyEarnings({@required String celebId})async{

  var monthlyEarnings=0.0;
  var resp= await FirebaseFirestore.instance.collection("transactions").where("personId",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("from",isEqualTo:"letsvibe").get();
  List docs=resp.docs;
  DateTime monthStart= DateTime.now().subtract(Duration(days: DateTime.now().day));


  docs.forEach((element) {
    var transactionDate=element.data()["createdAt"].toDate();
    if(transactionDate.isAfter(monthStart)){
      monthlyEarnings+=element["amount"];
    }

  });


  return Future.delayed(Duration(milliseconds: 100),(){
    print('returned');
    return double.parse("${monthlyEarnings}").floor();
  });

}


calculateLastMonthEarnings({@required String celebId})async {
  var lastMonthEarnings = 0.0;
  var resp= await FirebaseFirestore.instance.collection("transactions").where("personId",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("from",isEqualTo:"letsvibe").get();
  List docs = resp.docs;
  DateTime monthStart = DateTime.now().subtract(Duration(days: DateTime
      .now()
      .day));
  DateTime LastMonthStart = DateTime.now().subtract(Duration(days: (DateTime
      .now()
      .day + 30)));


  docs.forEach((element) {
    var transactionDate = element.data()["createdAt"].toDate();
    if (transactionDate.isAfter(LastMonthStart) &&
        transactionDate.isBefore(monthStart)) {
      lastMonthEarnings += element["amount"];
    }
  });

  return Future.delayed(Duration(milliseconds: 100), () {
    print('returned');
    return double.parse("${lastMonthEarnings}").floor();
  });
}



calculateTotalBilled({@required String celebId})async{
  var totalBilled=0.0;
  var totalBilledDocs= await FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
  totalBilledDocs.docs.forEach((element) {
    totalBilled+=( double.parse("${element.data()["amount"]}"));
  });

  return Future.delayed(Duration(milliseconds: 10),(){
    return totalBilled.floor();
  });

}


calculateFeesCharged({@required String celebId})async{
  var totalBilled=0.0;
  var totalBilledDocs= await FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
  totalBilledDocs.docs.forEach((element) {
    totalBilled+=( double.parse("${element.data()["amount"]}") );
  });

  var feesCharged=totalBilled*0.3;

  return Future.delayed(Duration(milliseconds: 10),(){
    return feesCharged.floor();
  });

}


calculateNetAfterFees({@required String celebId})async{
  var totalBilled=0.0;
  var totalBilledDocs= await FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
  totalBilledDocs.docs.forEach((element) {
    totalBilled+=( double.parse("${element.data()["amount"]}")   );
  });

  var netAfterFees=totalBilled*0.7;

  return Future.delayed(Duration(milliseconds: 10),(){
    return netAfterFees.floor();
  });

}



calculateDiscount({@required String celebId})async{
  var discount=0.0;
  var allDocs= await FirebaseFirestore.instance.collection("requests").where("celebrity",isEqualTo: FirebaseAuth.instance.currentUser.uid).get();
  allDocs.docs.forEach((element) {
    discount+=double.parse("${element.data()["discount"]}");
  });


  return Future.delayed(Duration(milliseconds: 10),(){
    return discount.floor();
  });



}





calculateRecievedEarnings({@required String celebId})async{
  var recievedEarnings=0.0;
  var docs= await FirebaseFirestore.instance.collection("transactions").where("from",isEqualTo: FirebaseAuth.instance.currentUser.uid).where("to",isEqualTo: "bank").get();
  docs.docs.forEach((element) {
    recievedEarnings+=double.parse("${element.data()["amount"]}");
  });
  return Future.delayed(Duration(milliseconds: 10),(){
    return recievedEarnings.floor();
  });

}