import 'package:celebside/models/user/userDetails.dart';
import 'package:celebside/pages/celebrity/home/editProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


updateUserProfileDetails({String username, String email, String fullName, String phone, String phoneCode, DateTime dob, String country, bool notificationPermission,})async
{


   try{


     await FirebaseAuth.instance.currentUser.updateDisplayName(fullName);
     await FirebaseAuth.instance.currentUser.updateEmail(email);


     await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid.toString()).set({
       "fullName":fullName,
       "dob":dob,
       "notificationPermission":notificationPermission
     },SetOptions(merge: true));
     return {"message":"updated"};
   }
   catch(e){
     return {"message":e};
   }




}