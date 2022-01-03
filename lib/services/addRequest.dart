import 'package:celebside/services/addToWallet.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";


addRequest({String message,@required BuildContext context,@required String celebrityId, @required String userId, @required String type,@required double amount}) async {

  var docId = await findOutRequestId(id1: celebrityId, id2: userId,type:type);

  DocumentSnapshot existingDoc=await FirebaseFirestore.instance.collection("requests").doc(docId).get();
  Map existingData= existingDoc.data();

  if(existingData==null ){

    await FirebaseFirestore.instance.collection("requests").doc(docId).set({
        "createdAt": DateTime.now(),
        "celebrity": celebrityId,
        "user": userId,
        "status":"pending",
        "type":type,
        "amount":amount,
      "message":message,
      "filtered":false,
    }, SetOptions(merge: true));


  }
  
  else if( existingData!=null && existingData["status"]=="complete"){

    await FirebaseFirestore.instance.collection("requests").doc(docId).set({
      "createdAt": DateTime.now(),
      "celebrity": celebrityId,
      "user": userId,
      "status":"pending",
      "type":type,
      "amount":amount,
      "message":message,
      "filtered":false,
    }, SetOptions(merge: true));

  }
  
  else if(existingData!=null && existingData["status"]!="complete"){

      print("Errored");
      return "error";

  }
  


}



addVideoRequest(
{
  @required BuildContext context,
  @required String celebrityId,
  @required String userId,
  @required String type,
  @required double amount,
  String videoPerson,
  String yourName,
  String theirName,
  String videoFor,
  DateTime videoDate,
  String videoMessage,
  bool private
})async
{

  var docId = await findOutRequestId(id1: celebrityId, id2: userId,type:type);

  DocumentSnapshot existingDoc=await FirebaseFirestore.instance.collection("requests").doc(docId).get();
  Map existingData= existingDoc.data();

  if(existingData==null ){

    await FirebaseFirestore.instance.collection("requests").doc(docId).set({
      "createdAt": DateTime.now(),
      "celebrity": celebrityId,
      "user": userId,
      "status":"pending",
      "type":type,
      "amount":amount,
      "yourName":yourName,
      "thierName":theirName,
      "videoFor":videoFor,
      "videoPerson":videoPerson,
      "videoMessage":videoMessage,
      "private":private,
      "videoDate":videoDate,
      "message":videoMessage,
      "filtered":false,
    }, SetOptions(merge: true));

    //check status here if completed or not

  }

  else if( existingData!=null && existingData["status"]=="complete"){

    await FirebaseFirestore.instance.collection("requests").doc(docId).set({
      "createdAt": DateTime.now(),
      "celebrity": celebrityId,
      "user": userId,
      "status":"pending",
      "type":type,
      "amount":amount,
      "yourName":yourName,
      "thierName":theirName,
      "videoFor":videoFor,
      "videoPerson":videoPerson,
      "videoMessage":videoMessage,
      "private":private,
      "videoDate":videoDate,
      "message":videoMessage,
      "filtered":false,
    }, SetOptions(merge: true));

  }

  else if(existingData!=null && existingData["status"]!="complete"){

    print("Errored");
    return "error";

  }



}






addBookingRequest(
    {
      @required BuildContext context,
      @required String celebrityId,
      @required String userId,
      @required String type,
      @required double amount,
      @required String fullName,
      @required String country,
      @required String countryCode,
      @required String phoneNumber,
      @required String email,
      @required String organization,
      @required List bookingTypes,
      @required List bookingReasons,
      @required String eventDescription,
      @required DateTime date,
      @required String timeStart,
      @required String timeEnd,
      @required String startFormat,
      @required String endFormat,
      @required String appearanceHours,
      @required String appearanceMinutes,
      @required String venueName,
      @required double loc_x,
      @required double loc_y,
      @required bool privateEvent,
      @required bool publicEvent,
      @required bool liveAppearance,
      @required bool virtualEvent,
      @required String numberOfGuests,
      @required String reasonForAppearance,
      @required String anyOtherEngagements,
      @required String quotation,

    }) async {

  var docId = await findOutRequestId(id1: celebrityId, id2: userId,type:type);

  DocumentSnapshot existingDoc=await FirebaseFirestore.instance.collection("requests").doc(docId).get();
  Map existingData= existingDoc.data();

  if(existingData==null ){

    await FirebaseFirestore.instance.collection("requests").doc(docId).set({
      "createdAt": DateTime.now(),
      "celebrity": celebrityId,
      "user": userId,
      "status":"pending",
      "type":type,
      "amount":amount,
      "fullName": fullName,
      "country": country,
      "countryCode": countryCode,
      "phoneNumber": phoneNumber,
      "email": email,
      "organization": organization,
      "bookingTypes": bookingTypes,
      "bookingReasons": bookingReasons,
      "eventDescription": eventDescription,
      "date": date,
      "timeStart": timeStart,
      "timeEnd": timeEnd,
      "startFormat": startFormat,
      "endFormat": endFormat,
      "appearanceHours": appearanceHours,
      "appearanceMinutes": appearanceMinutes,
      "venueName": venueName,
      "loc_x":loc_x,
      "loc_y":loc_y,
      "privateEvent": privateEvent,
      "publicEvent": publicEvent,
      "liveAppearance": liveAppearance,
      "virtualEvent": virtualEvent,
      "numberOfGuests": numberOfGuests,
      "reasonForAppearance": reasonForAppearance,
      "anyOtherEngagements": anyOtherEngagements,
      "quotation": quotation,
      "filtered":false,
    }, SetOptions(merge: true));

    //check status here if completed or not

  }

  else if( existingData!=null && existingData["status"]=="complete"){

    await FirebaseFirestore.instance.collection("requests").doc(docId).set({
      "createdAt": DateTime.now(),
      "celebrity": celebrityId,
      "user": userId,
      "status":"pending",
      "type":type,
      "amount":amount,
      "fullName": fullName,
      "country": country,
      "countryCode": countryCode,
      "phoneNumber": phoneNumber,
      "email": email,
      "organization": organization,
      "bookingTypes": bookingTypes,
      "bookingReasons": bookingReasons,
      "eventDescription": eventDescription,
      "date": date,
      "timeStart": timeStart,
      "timeEnd": timeEnd,
      "startFormat": startFormat,
      "endFormat": endFormat,
      "appearanceHours": appearanceHours,
      "appearanceMinutes": appearanceMinutes,
      "venueName": venueName,
      "loc_x":loc_x,
      "loc_y":loc_y,
      "privateEvent": privateEvent,
      "publicEvent": publicEvent,
      "liveAppearance": liveAppearance,
      "virtualEvent": virtualEvent,
      "numberOfGuests": numberOfGuests,
      "reasonForAppearance": reasonForAppearance,
      "anyOtherEngagements": anyOtherEngagements,
      "quotation": quotation,
      "filtered":false,
    }, SetOptions(merge: true));

  }

  else if(existingData!=null && existingData["status"]!="complete"){

    print("Errored");
    return "error";

  }



}



checkRequest({@required BuildContext context,@required String celebrityId, @required String userId, @required String type}) async {

  var docId = await findOutRequestId(id1: celebrityId, id2: userId,type:type);

  DocumentSnapshot existingDoc=await FirebaseFirestore.instance.collection("requests").doc(docId).get();
  Map existingData= existingDoc.data();

  if(existingData==null ){

    return "ok";
    //check status here if completed or not
  }

  else if( existingData!=null && existingData["status"]=="pending"){

   return "error";

  }
  else if(existingData!=null && existingData["status"]=="complete"){
    return "ok";
  }
  else{
    return "error";
  }

}


setRequestAsComplete({@required String userId, @required String type, @required BuildContext context})async{

  var docId = await findOutRequestId(id1: FirebaseAuth.instance.currentUser.uid.toString(), id2: userId,type:type);
  Map userData= await getUserData(id: userId);
  var requestDoc= await FirebaseFirestore.instance.collection("requests").doc(docId).get();
  Map requestData= requestDoc.data()==null?{"status":"complete"}:requestDoc.data();
  var status=requestData["status"];

  var messagePricedoc=await getCelebrityData(id: FirebaseAuth.instance.currentUser.uid);
  var messagePrice="${requestDoc["amount"]*0.7}";


  if(status=="pending"){

    await addToWallet(amount: ((double.parse(messagePrice).floorToDouble())), id: FirebaseAuth.instance.currentUser.uid, type: "celebrities");

    await FirebaseFirestore.instance.collection("requests").doc(docId).set({
      "status":"complete",
    }, SetOptions(merge: true));

    await FirebaseFirestore.instance.collection("users").doc(userId).collection("notifications").add(
        {
          "createdAt": DateTime.now(),
          "from": FirebaseAuth.instance.currentUser.uid,
          "to": userId,
          "message": "${messagePricedoc["fullName"]} has replied to a DM request",
          "type":"dm"
        }
    );

    Navigator.pop(context);

    await addTransaction(
        message: "DM request completed",
        to: FirebaseAuth.instance.currentUser.uid,
        from: "letsvibe",
        amount: ((double.parse(messagePrice)).floor().toDouble()),
        personId: FirebaseAuth.instance.currentUser.uid
    );
    showMessage(context: context, message: "Congratulations!, you just received ${(requestDoc["amount"])*0.7} GHS.");

  }
  else{
    Navigator.pop(context);
  }



}