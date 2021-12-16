import 'package:celebside/util/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

addChatMessage({@required String from,@required String to, @required String message}) async{

  var chatId = await findOutChatId(id1: from, id2: to);
  var chatDoc = await FirebaseFirestore.instance.collection("chats").doc(chatId).get();
  var chatData = chatDoc.data();

  if (chatData == null) {
    await FirebaseFirestore.instance.collection("chats").doc(chatId).set({
      "messages": [
        {
          "text": message,
          "createdAt": DateTime.now(),
          "from": from,
          "to": to,
        }
      ]
    }, SetOptions(merge: true));
  } else {
    List messages = chatData["messages"];
    await messages.add({
      "text": message,
      "createdAt": DateTime.now(),
      "from": from,
      "to": to,
    });

    await FirebaseFirestore.instance
        .collection("chats")
        .doc(chatId)
        .set({"messages": messages}, SetOptions(merge: true));
  }


}