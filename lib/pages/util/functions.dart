// @dart=2.9

import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  return Color(int.parse(hexColor, radix: 16));
}



findOutChatId({@required String id1, @required String id2 }){

  var chatId="";

  if(id1.compareTo(id2)==-1){
    chatId=id1.toString()+id2.toString();
  }

  else if(id1.compareTo(id2)==1){
    chatId=id2.toString()+id1.toString();
  }

  else if (id1.compareTo(id2)==0) {
    chatId=id1+id2;
  }
  return chatId;

}


findOutRequestId({@required String id1, @required String id2,@required String type }){

  var chatId="";

  if(id1.compareTo(id2)==-1){
    chatId=id1.toString()+id2.toString();
  }

  else if(id1.compareTo(id2)==1){
    chatId=id2.toString()+id1.toString();
  }

  else if (id1.compareTo(id2)==0) {
    chatId=id1+id2;
  }

  return "$chatId$type";

}




