import 'package:celebside/pages/home/celebrityProfile/celebrityProfilePage.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";import 'package:flutter/cupertino.dart';


class celebrityContainer extends StatefulWidget {
  celebrityContainer(this.image,this.name);

  final String image;
  final String name;

  @override
  _celebrityContainerState createState() => _celebrityContainerState();
}

class _celebrityContainerState extends State<celebrityContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context){
            return celebrityProfilePage();
          })
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top:20),
            decoration: BoxDecoration(
                color: Color.fromRGBO(24, 48, 93, 1),
                borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            height: 200,
            width: 143,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(this.widget.image),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top:10,left: 10,right: 10,bottom: 5),
                    child: Text(
                        this.widget.name,
                        // overflow: TextOverflow.fade,
                        style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 18,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left:10),
                    child: Text(
                      "More Info",
                      style: TextStyle(
                        fontFamily: "Avenir",
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 230,
              width: 143,
              alignment: Alignment.bottomCenter,
              child: Container(
                //padding: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    gradient: new LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.orange,
                      ],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                width: 80,
                height: 27,
                //height: 50,
                child: Center(
                  child: Text(
                    "REQUEST",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "AvenirBold",
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
