import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
class howRefundsWork2 extends StatefulWidget {
  @override
  _howRefundsWork2State createState() => _howRefundsWork2State();
}

class _howRefundsWork2State extends State<howRefundsWork2> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body:Stack(
            children: [
              Center(
                child: Image.asset("assets/bluebackground.png",width:width,height:height,fit: BoxFit.cover,),
              ),
              Container(
                margin: EdgeInsets.only(top:15),
                child: ListView(
                  children: [
                    SizedBox(height: 30,),
                    Center(
                        child:Container(
                            width: width*0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Text(
                                    "How do Refunds Work?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "AvenirBold",
                                        fontSize: 34
                                    ),
                                  ),
                                ),

                              ],
                            )
                        )
                    ),
                    SizedBox(height: 20,),
                    Center(child: Image.asset("assets/icon.png",height: 150,fit: BoxFit.contain,)),
                    SizedBox(height: 20,),
                    Center(
                      child: Container(
                        width: width*0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/howRefundWorks/1.png"),
                            SizedBox(width: 20,),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    "Your request will be completed once Celebrity approves",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontFamily: "AvenirBold",
                                        fontSize: 17
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Center(
                      child: Container(
                        width: width*0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/howRefundWorks/2.png"),
                            SizedBox(width: 20,),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                      "Your approval and order updates will be sent to the email provided under profile information once Celebrity approves",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontFamily: "AvenirBold",
                                        fontSize: 17
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Center(
                      child: Container(
                        width: width*0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/howRefundWorks/3.png"),
                            SizedBox(width: 20,),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    "When your request is completed and paid, we will contact you for further details",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontFamily: "AvenirBold",
                                        fontSize: 17
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                    Center(
                      child: Container(
                        width: width*0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/howRefundWorks/4.png"),
                            SizedBox(width: 20,),
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                  "If for some reason your booking isn’t completed, you will receive a refund. ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontFamily: "AvenirBold",
                                        fontSize: 17
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),


                  ],
                ),
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
            ],
          )
      ),
    );
  }
}
