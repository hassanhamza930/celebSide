import 'dart:convert';
import 'dart:io';
import 'package:celebside/pages/home/celebrityProfile/howRefundsWork/refundMessage.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/paymentOptions.dart';
import 'package:celebside/pages/home/celebrityProfile/sendMessage/components.dart';
import 'package:celebside/pages/home/featuredVideoPlayer/fanClub.dart';
import 'package:celebside/pages/home/home.dart';
import 'package:celebside/services/addRequest.dart';
import 'package:celebside/services/checkPromoCode.dart';
import 'package:celebside/services/getPayment.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/functions.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;
var promo = TextEditingController();


var messageText = TextEditingController(text: "");
ScrollController messagesScrollController = ScrollController();

class celebrityChat extends StatefulWidget {
  final bool willShow;
  final String celebId;
  final bool isCelebrity;
  celebrityChat({this.celebId, this.isCelebrity: false,this.willShow=false});

  @override
  _celebrityChatState createState() => _celebrityChatState();
}

class _celebrityChatState extends State<celebrityChat> {
  showOneTimePromo() async {
    if (widget.isCelebrity == false && widget.willShow==true) {
      Future.delayed(Duration(seconds: 3), () {
        showDialog(
            context: context,
            builder: (context) {
              var width = MediaQuery.of(context).size.width;
              var height = MediaQuery.of(context).size.height;

              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.all(20),
                    height: height * 0.45,
                    width: width * 0.7,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Introducing",
                                style: small(color: Colors.orange),
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                mini: true,
                                backgroundColor: Colors.blueAccent,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Send DM",
                                style: medium(color: Color.fromRGBO(24, 48, 93, 1)),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                    "There’s no guarantee you will get a response but feel free to ask a question, get advice, express your fanatic feelings or whatever. You only have 300 characters to do so.",
                                    style: small(color: Color.fromRGBO(24, 48, 93, 1)),
                                    textAlign: TextAlign.left),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                  child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    )),
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    "Send DM",
                                    style: mediumBold(color: Color.fromRGBO(24, 48, 93, 1), size: 26),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ))),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
        super.initState();
      });
    }
  }

  @override
  void initState() {
    messageText.clear();
    Future.delayed(Duration(seconds: 1), () {
      messagesScrollController.animateTo( messagesScrollController.position.maxScrollExtent,curve: Curves.easeInOut, duration: Duration(seconds: 1) );
    });
    showOneTimePromo();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection(widget.isCelebrity == true ? "users" : "celebrities").doc(widget.celebId.toString()).snapshots(),
      builder: (context, snapshot) {

        if(snapshot.hasData){
          var doc = snapshot.data;
          var data = doc.data();

          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/bluebackground.png",
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    controller: messagesScrollController,
                    // shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      StreamBuilder(stream: FirebaseFirestore.instance.collection(widget.isCelebrity == true ? "users" : "celebrities").doc(widget.celebId.toString()).snapshots(),
                          builder: (context, snapshot) {
                            return Center(
                                child: Container(
                                    width: width * 0.9,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${data["fullName"]}",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Colors.white, fontFamily: "Avenir", fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                            "${data["imgSrc"]}",
                                          ),
                                        )
                                      ],
                                    )));
                          }
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      widget.isCelebrity == true
                          ? Container()
                          : Center(
                        child: Container(
                          width: width * 0.9,
                          child: Column(
                            children: [
                              Text(
                                "Send a DM for just ¢${data["dm"]["price"]}",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white, fontFamily: "Avenir", fontSize: 22),
                              ),
                              Text(
                                "There’s no guarantee you will get a response but feel free to can ask a question, get advice, express your fanatic feelings or whatever. You only have 300 characters to do so",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontFamily: "Avenir", fontSize: 15),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("chats")
                              .doc(findOutChatId(id1: FirebaseAuth.instance.currentUser.uid, id2: widget.celebId))
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              DocumentSnapshot doc = snapshot.data;
                              Map data = doc.data();

                              if (doc.exists == false) {
                                return Container();
                              } else {
                                List messages = data["messages"];
                                messages.sort((a, b) {
                                  Timestamp time1 = a["createdAt"];
                                  Timestamp time2 = b["createdAt"];
                                  return time1.toDate().compareTo(time2.toDate());
                                });

                                return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      var messageData = messages[index];

                                      return Container(
                                        margin: EdgeInsets.only(top: 10, bottom: 10),
                                        child: message(
                                            context: context,
                                            text: "${messageData['text']}",
                                            self: messageData["from"] == FirebaseAuth.instance.currentUser.uid.toString() ? true : false,
                                            createdAt: messageData["createdAt"]),
                                      );
                                    });
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );

                            }
                          }),
                      SizedBox(
                        height: 300,
                      )
                      //message
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        color: Color.fromRGBO(24, 48, 93, 1),
                        padding: EdgeInsets.only(bottom: 10, top: 10),
                        constraints: BoxConstraints(
                          maxHeight: height*0.15,
                          minHeight: height*0.1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration:
                                BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.all(Radius.circular(24.0))),
                                child: Center(
                                  child: TextField(
                                    minLines: null,
                                    maxLines: null,
                                    maxLength: widget.isCelebrity == true ? 1500 : 300,
                                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                    controller: messageText,
                                    style: TextStyle(color: Colors.white, fontFamily: 'Avenir'),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      enabled: true,
                                      labelText: 'Write a Comment',
                                      labelStyle: TextStyle(color: Colors.white, fontFamily: 'Avenir'),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsetsDirectional.only(start: 20.0, end: 20),
                                    ),
                                    onChanged: (_onChanged) {},
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (widget.isCelebrity == false) {

                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        var width = MediaQuery.of(context).size.width;
                                        var height = MediaQuery.of(context).size.height;

                                        return Scaffold(
                                          backgroundColor: Colors.transparent,
                                          body: Center(
                                            child: Container(
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20))),
                                              padding: EdgeInsets.all(20),
                                              height: height * 0.45,
                                              width: width * 0.7,
                                              child: Center(
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Introducing",
                                                          style: small(color: Colors.orange),
                                                        ),
                                                        FloatingActionButton(
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 20,
                                                          ),
                                                          mini: true,
                                                          backgroundColor: Colors.blueAccent,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Pay DM",
                                                          style: medium(color: Color.fromRGBO(24, 48, 93, 1)),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                              "There’s no guarantee you will get a response. You will receive a refund if you don’t get a response.",
                                                              style: small(color: Color.fromRGBO(24, 48, 93, 1)),
                                                              textAlign: TextAlign.left),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () async {
                                                          if (messageText.text.toString().trim() == "") {
                                                            Navigator.pop(context);
                                                            showErrorDialogue(context: context, message: "Kindly enter a message to send");
                                                          } else {
                                                            //This will only run when you are a USER

                                                            //showLoading(context: context);

                                                            var checkRequestResponse = await checkRequest(context: context, celebrityId: widget.celebId, userId: FirebaseAuth.instance.currentUser.uid.toString(), type: "dm");

                                                            if (checkRequestResponse != "error") {
                                                              try {
                                                                Navigator.pop(context);

                                                                showDialog(
                                                                    context: context,
                                                                    builder: (context) {

                                                                      return Scaffold(
                                                                        backgroundColor: Colors.transparent,
                                                                        body: Center(
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.black.withOpacity(0.7),
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(20)
                                                                                )
                                                                            ),
                                                                            height: height * 0.5,
                                                                            width: width * 0.7,
                                                                            child: Center(
                                                                              child: ListView(
                                                                                shrinkWrap: true,
                                                                                children: [
                                                                                  Center(
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.all(3),
                                                                                      width: width * 0.6,
                                                                                      decoration: BoxDecoration(
                                                                                          color: Colors.white.withOpacity(0.3),
                                                                                          borderRadius: BorderRadius.all(Radius.circular(18.0))),
                                                                                      child: Center(
                                                                                        child: TextField(
                                                                                          controller: promo,
                                                                                          style: small(color: Colors.white),
                                                                                          decoration: InputDecoration(
                                                                                            labelText: "Promo Code",
                                                                                            labelStyle: small(color: Colors.white),
                                                                                            focusedBorder: InputBorder.none,
                                                                                            enabledBorder: InputBorder.none,
                                                                                            contentPadding: EdgeInsetsDirectional.only(start: 20),
                                                                                          ),
                                                                                          onChanged: (e) => {},
                                                                                          keyboardType: TextInputType.text,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(height: 20,),
                                                                                  Center(
                                                                                    child: authButton(text: "Continue", color: Colors.white, bg: Colors.orange, onPress: ()async{

                                                                                      showLoading(context: context);

                                                                                      var promoResponse= await checkPromoCode(code: promo.text, type: "dm", celebrity: widget.celebId );

                                                                                      if(promoResponse["message"]=="ok"){

                                                                                        var discount= double.parse(promoResponse["promo"]["promoDiscount"]);
                                                                                        var discountPercentage=(1- (discount/100));
                                                                                        var amount=double.parse(data["dm"]["price"])*100;
                                                                                        amount=amount*discountPercentage;

                                                                                        var discountedAmount=double.parse(data["dm"]["price"])*(double.parse(promoResponse["promo"]["promoDiscount"])/100);



                                                                                        print('ifed');

                                                                                        var response=await http.get(Uri.parse("https://us-central1-funnel-887b0.cloudfunctions.net/getPaymentPage"),headers: {"name":data["fullName"],"amount": "$amount"});
                                                                                        var responseData=jsonDecode(response.body);

                                                                                        var slug=responseData["data"]["slug"];

                                                                                        Navigator.pop(context);
                                                                                        Navigator.pop(context);
                                                                                        getPayment(message:messageText.text ,discount:discountedAmount ,context: context, amount: amount.toInt() , celebrity: widget.celebId, user: FirebaseAuth.instance.currentUser.uid, slug: slug);

                                                                                        print("showed");
                                                                                      }
                                                                                      else{
                                                                                        Navigator.pop(context);
                                                                                        showErrorDialogue(context: context, message: "Your promo code is invalid or expired");
                                                                                      }

                                                                                    }, context: context,thin: true),
                                                                                  ),
                                                                                  SizedBox(height: 50,),
                                                                                  GestureDetector(
                                                                                    onTap: ()async{
                                                                                      showLoading(context: context);

                                                                                      var response=await http.get(Uri.parse("https://us-central1-funnel-887b0.cloudfunctions.net/getPaymentPage"),headers: {"name":data["fullName"],"amount": "${double.parse(data["dm"]["price"])*100}"});
                                                                                      var responseData=jsonDecode(response.body);

                                                                                      var slug=responseData["data"]["slug"];

                                                                                      Navigator.pop(context);
                                                                                      Navigator.pop(context);
                                                                                      getPayment(message:messageText.text ,context: context, amount: int.parse(data["dm"]["price"])*100, celebrity: widget.celebId, user: FirebaseAuth.instance.currentUser.uid, slug: slug);

                                                                                      print("showed");
                                                                                    },
                                                                                    child: Center(
                                                                                        child: Text("Have no promo code?",style: small(color: Colors.white,size: 14),)
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });



                                                              } catch (e) {
                                                                Navigator.pop(context);
                                                                Navigator.pop(context);
                                                                showErrorDialogue(context: context, message: e.toString());
                                                              }
                                                            } else {
                                                              Navigator.pop(context);
                                                              showErrorDialogue(
                                                                  context: context,
                                                                  message: "You already have a pending DM request for this celebrity.");
                                                            }
                                                          }
                                                        },
                                                        child: Center(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors.orange,
                                                                  borderRadius: BorderRadius.all(
                                                                    Radius.circular(20),
                                                                  )),
                                                              padding: EdgeInsets.all(20),
                                                              margin: EdgeInsets.all(10),
                                                              child: Center(
                                                                child: Text(
                                                                  "Send DM ¢${data["dm"]["price"]}",
                                                                  style: mediumBold(color: Color.fromRGBO(24, 48, 93, 1), size: 26),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              ),
                                                            ))),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                                else {
                                  showLoading(context: context);

                                  var chatId = findOutChatId(id1: widget.celebId, id2: FirebaseAuth.instance.currentUser.uid.toString());
                                  var doc = await FirebaseFirestore.instance.collection("chats").doc(chatId).get();
                                  var chatData = doc.data();
                                  List messages = chatData["messages"];

                                  await messages.add({
                                    "text": messageText.text,
                                    "createdAt": DateTime.now(),
                                    "from": FirebaseAuth.instance.currentUser.uid.toString(),
                                    "to": widget.celebId.toString(),
                                  });

                                  await FirebaseFirestore.instance
                                      .collection("chats")
                                      .doc(chatId)
                                      .set({"messages": messages}, SetOptions(merge: true));

                                  DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(widget.celebId).get();
                                  DocumentSnapshot currentUserDoc = await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid).get();
                                  Map currentUserData = currentUserDoc.data();
                                  Map data = userDoc.data();

                                  await setRequestAsComplete(type: "dm", userId: widget.celebId,context: context);
                                  messageText.clear();
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20, top: 40),
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else{
          return Container();
        }

      }
    );
  }
}
