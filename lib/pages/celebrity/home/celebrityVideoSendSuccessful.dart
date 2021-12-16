import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
class celebrityVideoSuccessful extends StatefulWidget {
  @override
  _celebrityVideoSuccessfulState createState() => _celebrityVideoSuccessfulState();
}

class _celebrityVideoSuccessfulState extends State<celebrityVideoSuccessful> {
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
              ListView(
                children: [
                  SizedBox(height: 40,),
                  Center(
                    child: Container(
                      alignment: Alignment.center,
                      width: width*0.9,
                      child: Text(
                        "Video Request",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Avenir",
                            fontSize: 22
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10,),
                  Image.asset(
                    "assets/paymentSuccessful/person.png",
                    width: width*0.7,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: 40,),
                  Center(
                    child: Container(
                        alignment: Alignment.center,
                        width: width*0.9,
                        child: Text(
                          "Video Sent",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 34,
                              fontFamily: "AvenirBold",
                              color: Colors.white
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: 10,),
              
                  SizedBox(height: 20,),
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.only(top:10,bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          width: width*0.8,
                          child: Text(
                            "Okay",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "AvenirBold",
                                color: Colors.white
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 50,),

                ],
              ),
            ],
          )
      ),
    );
  }
}
