import 'package:celebside/util/styles.dart';
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

List inviteData=[
  {
    'imgSrc':"assets/search/avatarSearch.png",
    'name':"Stone Bwoy"
  },
  {
    'imgSrc':"assets/search/avatarSearch.png",
    'name':"Stone Bwoy2"
  },
  {
    'imgSrc':"assets/search/avatarSearch.png",
    'name':"Stone Bwoy3"
  },
];



celebViberRow({@required BuildContext context,bool status=false}){
  var width=MediaQuery.of(context).size.width;
  var height=MediaQuery.of(context).size.height;
  return GestureDetector(
    onTap: (){

    },
    child: Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(top:10,bottom: 10),
            width:width*0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                Container(
                  width: width*0.6,
                  child: Row(
                    children: [
                      Container(
                          padding:EdgeInsets.only(right:5),
                          child: Image.asset("assets/search/avatarSearch.png",width: 70,)
                      ),
                      SizedBox(width: 5,),
                      Flexible(
                        child: Text(
                          "StoneBwoy",
                          style: small(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    padding: EdgeInsets.all(5),
                    child: Center(
                        child: status?Icon(Icons.done):Icon(Icons.add)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(color: Colors.black,height: 5,),
      ],
    ),
  );
}





class vibers extends StatefulWidget {
  @override
  _vibersState createState() => _vibersState();
}

class _vibersState extends State<vibers> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset("assets/bluebackground.png",fit: BoxFit.cover,width: width,),
            Center(
              child: ListView(
                children: [
                  SizedBox(height: 70,),
                  Center(
                    child: Container(
                      width: width*0.9,
                      child: Text(
                        "Your Vibers",
                        style: medium(color: Colors.white),
                      ),
                    ),
                  ), //Search
                  SizedBox(height: 20,),
                  Center(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: inviteData.length,
                      itemBuilder: (context,index){
                        return celebViberRow(context: context,status: true);
                      },
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text('Done',style: small(color: Colors.orange),)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
