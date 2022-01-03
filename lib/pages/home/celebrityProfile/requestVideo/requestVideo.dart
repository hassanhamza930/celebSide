import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:celebside/pages/home/celebrityProfile/howRefundsWork/refundMessage.dart';
import 'package:celebside/pages/home/celebrityProfile/payment/paymentOptions.dart';
import 'package:celebside/pages/home/home.dart';
import 'package:celebside/services/addChatMessage.dart';
import 'package:celebside/services/addNotifications.dart';
import 'package:celebside/services/addRequest.dart';
import 'package:celebside/services/addTransaction.dart';
import 'package:celebside/services/checkPromoCode.dart';
import 'package:celebside/services/fetchUsersData.dart';
import 'package:celebside/services/getPayment.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import "package:http/http.dart" as http;


var dob="By when do you need this video";
var currentItem;
var promo=TextEditingController(text: "");

var currentTab=0;
var private=true;

var myName=TextEditingController(text: "");
var theirName=TextEditingController(text: "");
DateTime date;
var celebrityRequest=TextEditingController(text: "");


class requestVideo extends StatefulWidget {
  final String celebId;
  requestVideo({@required this.celebId});

  @override
  _requestVideoState createState() => _requestVideoState();
}

class _requestVideoState extends State<requestVideo> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          Image.asset(
            "assets/bluebackground.png",
            width: width,
            height: height,
            fit: BoxFit.cover,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("celebrities").doc(widget.celebId).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                var data=snapshot.data;
                return Center(
                  child: Container(
                    width: width*0.9,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Container(
                            alignment: Alignment.center,
                            width: width * 0.9,
                            child: Text(
                              "Request Video",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Avenir",
                                  fontSize: 22),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  child: CircleAvatar(
                                    radius:40,
                                    child: CircleAvatar(
                                      radius:40,
                                      backgroundImage: NetworkImage("${data['imgSrc']}"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "From:\n${data["fullName"]}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "AvenirBold",
                                            fontSize: 22),
                                      ),
                                      Text(
                                        "usually delivers video in ${data["videoRequest"]["responseTime"]} days",
                                        textAlign: TextAlign.left,
                                        style: small(color: Colors.orange),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentTab=0;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: currentTab==0?Colors.orange:Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(Radius.circular(5))),
                                    width: width * 0.42,
                                    child: Text(
                                      "Someone",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontFamily: "Avenir"),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      currentTab=1;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: currentTab==1?Colors.orange:Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.all(Radius.circular(5))),
                                    width: width * 0.42,
                                    child: Text(
                                      "Myself",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontFamily: "Avenir"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        inputField(label: "My Name is", context: context, onChange: (e){},controller: myName),
                        currentTab==0?SizedBox(
                          height: 10,
                        ):Container(),
                        currentTab==0?inputField(label: "Their Name is", context: context, onChange: (e){},controller: theirName):Container(),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left:20,top:3,bottom: 3,right: 20),
                          decoration:BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius:
                              BorderRadius.all(Radius.circular(24.0))
                          ),
                          child: DropdownButton<String>(
                            value: currentItem,
                            style: small(color: Colors.white),
                            dropdownColor: Colors.black,
                            onChanged: (String newValue) {
                              setState(() {
                                currentItem = newValue;
                              });
                            },
                            hint: Text(
                              "What is this video for?",
                              style: small(color: Colors.white),
                            ),
                            items: <String>['Birthday Wishes', 'Anniversary Celebration', 'Wedding Wishes', 'Proposals',"Get Well Soon","Congratulations","Apology","Ask a Question","Pep Talk","Motivation","Roast Friend"].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  //style: small(color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // inputField(label: currentTab==0?"Introduce Your Friend":"Introduce Yourself", context: context, onChange: (e){}),
                        GestureDetector(
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(DateTime.now().add(Duration(days: 365)).year, 12, 12),
                                onChanged: (date2) {
                                  print('change $date');
                                }, onConfirm: (date2) {
                                  setState(() {
                                    dob = date2
                                        .toIso8601String()
                                        .split("T")[0]
                                        .toString();

                                    date=date2;

                                  });
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.en);
                          },
                          child: Container(
                            padding: EdgeInsets.all(3),
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius:
                                BorderRadius.all(Radius.circular(24.0))),
                            child: Center(
                              child: TextField(
                                enabled: false,
                                style: small(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: "${dob}",
                                  labelStyle: small(color: Colors.white),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding:
                                  EdgeInsetsDirectional.only(start: 20),
                                ),
                                onChanged: (e) => {},
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        inputFieldExpanded(label: "What would you like them to say?", context: context, onChange: (e){},controller: celebrityRequest),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Text(
                                "Private (Do not share video on LetsVibe)",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Avenir",
                                    fontSize: 14),
                                textAlign: TextAlign.center,
                              )
                              ,
                            ),
                            Checkbox(value: private, onChanged: (val) {
                              setState(() {
                                private=!private;
                              });
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                            onTap: () async{

                              if(myName.text!="" && celebrityRequest.text!=""){
                                showLoading(context: context);

                                var checkRequestResponse = await checkRequest(context: context, celebrityId: widget.celebId, userId: FirebaseAuth.instance.currentUser.uid.toString(), type: "videoRequest");


                                if (checkRequestResponse!="error"){
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

                                                        var promoResponse= await checkPromoCode(code: promo.text, type: "videoRequest", celebrity: widget.celebId );

                                                        if(promoResponse["message"]=="ok"){

                                                          var discount= int.parse(promoResponse["promo"]["promoDiscount"]);
                                                          var discountPercentage=(1- (discount/100));
                                                          var amount=double.parse(data["videoRequest"]["price"]);
                                                          amount=amount*discountPercentage;
                                                          var discountedAmount=double.parse(data["videoRequest"]["price"])*(double.parse(promoResponse["promo"]["promoDiscount"])/100);


                                                          print('ifed');

                                                          var response=await http.get(Uri.parse("https://us-central1-funnel-887b0.cloudfunctions.net/getPaymentPage"),headers: {"name":data["fullName"],"amount": "${amount *100 }"});
                                                          var responseData=jsonDecode(response.body);

                                                          var slug=responseData["data"]["slug"];

                                                          Navigator.pop(context);
                                                          Navigator.pop(context);
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) {
                                                                var width = MediaQuery.of(context).size.width;
                                                                var height = MediaQuery.of(context).size.height;

                                                                return Scaffold(
                                                                  backgroundColor: Colors.transparent,
                                                                  body: Center(
                                                                    child: Container(
                                                                      width: width * 0.8,
                                                                      height: height * 0.8,
                                                                      child: InAppWebView(
                                                                        onWebViewCreated: (_webViewController) {
                                                                          _webViewController.addJavaScriptHandler(
                                                                              handlerName: 'close',
                                                                              callback: (args) async {
                                                                                showLoading(context: context);

                                                                                try {
                                                                                  Map userData = await getUserData(id: FirebaseAuth.instance.currentUser.uid);

                                                                                  await addTransaction( message: "Video Request", to: widget.celebId, from:FirebaseAuth.instance.currentUser.uid , amount: ( (double.parse("${data["videoRequest"]["price"]  }"))));

                                                                                  await addNotifications(type:"videoRequest",target: "celebrity", message: "${userData["fullName"]} has made a video request", String: String, from: FirebaseAuth.instance.currentUser.uid, to: widget.celebId );

                                                                                  await addVideoRequest(
                                                                                      context: context,
                                                                                      celebrityId: widget.celebId,
                                                                                      userId: FirebaseAuth.instance.currentUser.uid,
                                                                                      type: "videoRequest",
                                                                                      amount:(double.parse("${data["videoRequest"]["price"]}")  ),
                                                                                      theirName: theirName.text,
                                                                                      yourName: myName.text,
                                                                                      videoDate: date,
                                                                                      videoFor: currentItem,
                                                                                      videoMessage: celebrityRequest.text,
                                                                                      videoPerson: currentTab==0?"someone":"myself",
                                                                                      private: private
                                                                                  );


                                                                                  Navigator.pop(context);
                                                                                  Navigator.pop(context);

                                                                                  //  Add Transactions Here
                                                                                  // Add Wallet here.

                                                                                  currentTab = 1;
                                                                                  Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) {
                                                                                    return Home();
                                                                                  }));
                                                                                } catch (e) {
                                                                                  Navigator.pop(context);
                                                                                  Navigator.pop(context);
                                                                                  showErrorDialogue(context: context, message: e.toString());
                                                                                }
                                                                              });
                                                                        },
                                                                        initialUrlRequest: URLRequest(url: Uri.parse("https://paystack.com/pay/$slug")),
                                                                        initialOptions: InAppWebViewGroupOptions(
                                                                            android: AndroidInAppWebViewOptions(
                                                                                allowFileAccess: true, cacheMode: AndroidCacheMode.LOAD_CACHE_ELSE_NETWORK, allowContentAccess: true)),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });

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

                                                        var response=await http.get(Uri.parse("https://us-central1-funnel-887b0.cloudfunctions.net/getPaymentPage"),headers: {"name":data["fullName"],"amount": "${double.parse(data["videoRequest"]["price"])*100}"});
                                                        var responseData=jsonDecode(response.body);

                                                        var slug=responseData["data"]["slug"];

                                                        Navigator.pop(context);
                                                        Navigator.pop(context);


                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              var width = MediaQuery.of(context).size.width;
                                                              var height = MediaQuery.of(context).size.height;

                                                              return Scaffold(
                                                                backgroundColor: Colors.transparent,
                                                                body: Center(
                                                                  child: Container(
                                                                    width: width * 0.8,
                                                                    height: height * 0.8,
                                                                    child: InAppWebView(
                                                                      onWebViewCreated: (_webViewController) {
                                                                        _webViewController.addJavaScriptHandler(
                                                                            handlerName: 'close',
                                                                            callback: (args) async {
                                                                              showLoading(context: context);

                                                                              try {
                                                                                Map userData = await getUserData(id: FirebaseAuth.instance.currentUser.uid);

                                                                                // await addToWallet(amount: ((amount.toDouble()) / 100) * 0.7, id: celebrity, type: "celebrities");

                                                                                await addTransaction(message: "Video Request", to: widget.celebId, from:FirebaseAuth.instance.currentUser.uid , amount: ( (double.parse("${data["videoRequest"]["price"]  }")) ));


                                                                                await addNotifications(type:"videoRequest",target: "celebrity", message: "${userData["fullName"]} has made a video Request", String: String, from: FirebaseAuth.instance.currentUser.uid, to: widget.celebId );

                                                                                await addVideoRequest(
                                                                                    context: context,
                                                                                    celebrityId: widget.celebId,
                                                                                    userId: FirebaseAuth.instance.currentUser.uid,
                                                                                    type: "videoRequest",
                                                                                    amount:(double.parse("${data["videoRequest"]["price"]}")  ),
                                                                                    theirName: theirName.text,
                                                                                    yourName: myName.text,
                                                                                    videoDate: date,
                                                                                    videoFor: currentItem,
                                                                                    videoMessage: celebrityRequest.text,
                                                                                    videoPerson: currentTab==0?"someone":"myself",
                                                                                    private: private
                                                                                );

                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);

                                                                                //  Add Transactions Here
                                                                                // Add Wallet here.

                                                                                currentTab = 1;
                                                                                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) {
                                                                                  return Home();
                                                                                }));
                                                                              } catch (e) {
                                                                                Navigator.pop(context);
                                                                                Navigator.pop(context);
                                                                                showErrorDialogue(context: context, message: e.toString());
                                                                              }
                                                                            });
                                                                      },
                                                                      initialUrlRequest: URLRequest(url: Uri.parse("https://paystack.com/pay/$slug")),
                                                                      initialOptions: InAppWebViewGroupOptions(
                                                                          android: AndroidInAppWebViewOptions(
                                                                              allowFileAccess: true, cacheMode: AndroidCacheMode.LOAD_CACHE_ELSE_NETWORK, allowContentAccess: true)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });

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


                                }
                                else{
                                  Navigator.pop(context);
                                  showErrorDialogue(
                                      context: context,
                                      message: "You already have a pending DM request for this celebrity.");
                                }

                              }
                              else{
                                showErrorDialogue(context: context, message: "Kindly Fill all Details properly.");
                              }

                            },
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.only(top:10,bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                width: width*0.9,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.videocam_sharp,color: Colors.blue,),
                                    SizedBox(width: 20,),
                                    Flexible(
                                      child: Text(
                                        "Confirm and Pay  ¢${data["videoRequest"]["price"]}",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "AvenirBold",
                                            color: Colors.white
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Icon(Icons.warning,color:Colors.orange),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, CupertinoPageRoute(builder: (context) {
                                  return HowRefundsWork();
                                }));
                              },
                              child: Center(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "How do refunds work?",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Avenir",
                                        fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 150,
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
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              padding: EdgeInsets.only(left:20,top:40),
              alignment: Alignment.topLeft,
              child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: height,
            width: width,
            child: Container(
              height: 70,
              padding: EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 10),
              color: Color.fromRGBO(24, 48, 93, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        print("one");
                        setState(() {
                          currentTab = 0;
                        });
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                          return Home();
                        }));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    currentTab == 0
                                        ? Colors.orange
                                        : Colors.white,
                                    BlendMode.srcATop),
                                child: Image.asset(
                                  "assets/bottom bar/simple/1.png",fit: BoxFit.contain,
                                  height: 25,
                                )),
                            Text(
                              "Home",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 12,
                                color: currentTab == 0
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        print("one");
                        setState(() {
                          currentTab = 1;
                        });
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                          return Home();
                        }));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    currentTab == 1
                                        ? Colors.orange
                                        : Colors.white,
                                    BlendMode.srcATop),
                                child: Image.asset(
                                  "assets/bottom bar/simple/2.png",
                                  fit: BoxFit.contain,
                                  height: 25,
                                )
                            ),
                            Text(
                              "Requests",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 12,
                                color: currentTab == 1
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        print("one");
                        setState(() {
                          currentTab = 2;
                        });
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                          return Home();
                        }));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    currentTab == 2
                                        ? Colors.orange
                                        : Colors.white,
                                    BlendMode.srcATop),
                                child: Image.asset(
                                  "assets/bottom bar/simple/3.png",
                                  fit: BoxFit.contain,
                                  height: 25,)),
                            Text(
                              "Notifications",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 12,
                                color: currentTab == 2
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                  GestureDetector(
                      onTap: () {
                        print("one");
                        setState(() {
                          currentTab = 3;
                        });
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
                          return Home();
                        }));
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    currentTab == 3
                                        ? Colors.orange
                                        : Colors.white,
                                    BlendMode.srcATop),
                                child: Image.asset(
                                  "assets/bottom bar/simple/4.png",
                                  fit: BoxFit.contain,
                                  height: 25,)),
                            Text(
                              "Profile",
                              style: TextStyle(
                                fontFamily: "Avenir",
                                fontSize: 12,
                                color: currentTab == 3
                                    ? Colors.orange
                                    : Colors.white,
                              ),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
