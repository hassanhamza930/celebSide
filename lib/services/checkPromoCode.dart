import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
checkPromoCode({@required String code, @required String type, @required String celebrity}) async {
  var validated = false;
  var promo;

  Map celebData = await getCelebrityData(id: celebrity);
  List promos = celebData["$type"]["promos"];

  print(promos);
  print(code);

  promos.forEach((element) {
    if (element["promoCode"] == code) {
      print("oneIf");
      DateTime date = element["expiry"].toDate();

      if (DateTime.now().compareTo(date) <= 0 && int.parse(element["totalPromoCodes"]) > 0) {
        validated = true;
        promo = element;
        element["totalPromoCodes"] = "${int.parse(element["totalPromoCodes"]) - 1}";
      } else {
        print("2Ifed");
      }
    } else {}
  });

  if (validated == true) {
    await FirebaseFirestore.instance.collection("celebrities").doc(celebrity).set({
      "dm": {"promos": promos}
    }, SetOptions(merge: true));
    return {"message": "ok", "promo": promo};
  } else if (validated == false) {
    return {"message": "expired"};
  }
}
