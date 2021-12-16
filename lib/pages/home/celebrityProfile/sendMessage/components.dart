import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
message({@required BuildContext context,@required String text,@required bool self,@required Timestamp createdAt}){
  var width=MediaQuery.of(context).size.width;
  return Center(
    child: Container(
      width: width*0.9,
      alignment: self==false?Alignment.centerLeft:Alignment.centerRight,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color:Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: self==false?Radius.circular(0):Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: self==false?Radius.circular(20):Radius.circular(0)
              ),
            ),
            width: 200,
            child: Text(
              "${text}",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Avenir",
                  fontSize: 14
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left:20,right:20,top: 10,bottom: 5),
            width: 200,
            child: Text(
              "${createdAt.toDate().toString().split(" ")[0]}",
              textAlign: self==false?TextAlign.left:TextAlign.right,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Avenir",
                  fontSize: 14
              ),
            ),
          ),
        ],
      ),
    ),
  );
}