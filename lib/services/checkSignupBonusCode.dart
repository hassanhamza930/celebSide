import 'package:celebside/util/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


checkSignupBonusCode({@required bool hasReferral,@required String referral})async{

  if(hasReferral==false){
    return "ok";
  }
  else if(hasReferral==true && referral!="") {
    var doc=await FirebaseFirestore.instance.collection("users").doc(referral).get();

    if (doc.exists) {
      return "ok";
    }
    else{
      return "error";
    }
  }
  else if(hasReferral==true && referral==""){
    return "error";
  }




}