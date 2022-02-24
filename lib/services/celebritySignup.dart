import 'package:celebside/pages/celebrity/auth/celebritySignup.dart';
import 'package:celebside/services/notification/notificationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
celebritySignup(
    {@required String fullName,
    @required String email,
    @required String phone,
    @required String countryCode,
    @required String country,
    @required DateTime dob,
    @required String password,
    @required String mostFollowers,
    @required String handle,
    @required String referral,
    bool hasReferral}) async {
  if (hasReferral == true && referral == "") {
    return {"message": "Kindly Enter The Promo Code"};
  }

  if (fullName != "" && email != "" && phone != "" && dobDisplay != "" && password != "" && mostFollowers != "" && handle != "") {
    try {
      var phoneExists = await FirebaseFirestore.instance.collection("celebrities").where("phone", isEqualTo: phone).get();

      if (phoneExists.docs.length == 0) {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseFirestore.instance.collection("celebrities").doc(userCredential.user.uid.toString()).set({
          "fullName": fullName,
          "email": email,
          "phone": phone,
          "responseTime": 7,
          "reviews": 0,
          "rating": 4.5,
          "notificationsPermission": false,
          "notifications": [],
          "about": "No About",
          "countryCode": countryCode,
          "country": country,
          "dob": dob,
          "password": password,
          "mostFollowers": mostFollowers,
          "handle": handle,
          "hasReferral": hasReferral,
          "referral": referral,
          "interests": [],
          "wallet": 0,
          "accountType": "celebrity",
          "imgSrc": "https://www.cprime.com/wp-content/static/images/blog/default-avatar-250x250.png",
          "vidSrc": "",
          "approved": true,
          "dm": {"charity": false, "hidden": true, "price": "0", "responseTime": "0", "promos": []},
          "videoRequest": {"charity": false, "hidden": true, "price": "0", "responseTime": "0", "promos": []},
          "eventBooking": {
            "charity": false,
            "hidden": true,
            "responseTime": "0",
            "bookingReasons": [],
            "bookingTypes": [],
            "promos": [],
            "budgetFrom": "0",
            "budgetTo": "0",
          },
          "fanClub": {"promos": []},
          "fanClubMembers": [],
          "fanClubMessages": [],
          "createdAt":DateTime.now()
        });
        //Add Rewards here.


        await SaveDeviceTokenForCelebrity(userCredential.user.uid);

        return {"message": "created"};
      } else {
        return {"message": "Phone Number is Already Registered"};
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {"message": 'The password provided is too weak.'};
      } else if (e.code == 'email-already-in-use') {
        return {"message": 'The account already exists for that email.'};
      }
    } catch (e) {
      return {"message": e};
    }
  }
  else {
    return {"message": "Kindly Fill All Details Properly."};
  }
}
