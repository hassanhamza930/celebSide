// @dart=2.9

import 'package:celebside/util/styles.dart';
import 'package:flutter/material.dart';


authButton({@required String text,@required Color color,@required Color bg,@required Function onPress,@required BuildContext context,bool thin=false}){
  var width=MediaQuery.of(context).size.width;
  return Container(
    width: thin?width*0.6:width*0.8,
    child: GestureDetector(
      onTap: ()=>{onPress()} ,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ), color:bg
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: small(color: color)
        ),
      ),
    ),
  );
}


boxyButton({@required String text,@required Color color,@required Color bg,@required Function onPress,@required BuildContext context,bool thin=false}){
  var width=MediaQuery.of(context).size.width;
  return Container(
    width: thin?width*0.6:width*0.8,
    child: GestureDetector(
      onTap: ()=>{onPress()} ,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ), color:bg
        ),
        child: Text(
            text,
            textAlign: TextAlign.center,
            style: small(color: color)
        ),
      ),
    ),
  );
}


inputField({@required String label,@required BuildContext context,@required Function(@required String val) onChange,TextEditingController controller,bool numeric=false, bool disabled=false  }){
  return Container(
    padding: EdgeInsets.all(3),
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius:
        BorderRadius.all(Radius.circular(18.0))),
    child: Center(
      child: TextField(
        enabled: disabled==true?false:true,
        controller: controller ,
        style: small(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: small(color: Colors.white),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding:
          EdgeInsetsDirectional.only(start: 20),
        ),
        onChanged: (e)=>{onChange(e)},
        keyboardType: numeric==true?TextInputType.number:TextInputType.text,
      ),
    ),
  );
}


searchField({@required String label,@required BuildContext context,@required Function(@required String val) onChange,TextEditingController controller}){
  return Center(
    child: Container(
      padding: EdgeInsets.all(3),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius:
          BorderRadius.all(Radius.circular(24.0))),
      child: Center(
        child: TextField(
          controller: controller,
          style: TextStyle(color: Colors.white, fontFamily: 'Avenir'),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
              size: 25,
            ),
            enabled: true,
            labelText: 'Search Usernames',
            labelStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Avenir'),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            contentPadding:
            EdgeInsetsDirectional.only(start: 20.0),
          ),
          onChanged: (e) {
            onChange(e);
          },
          keyboardType: TextInputType.text,
        ),
      ),
    ),
  );
}



inputFieldExpanded({@required String label,@required BuildContext context,@required Function(@required String val) onChange, TextEditingController controller,bool enabled=true }){
  return Container(
    height: 150,
    padding: EdgeInsets.all(3),
    width: MediaQuery.of(context).size.width * 0.9,
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius:
        BorderRadius.all(Radius.circular(24.0))),
    child: Center(
      child: TextField(
        enabled: enabled,
        controller: controller,
        minLines: 4,
        maxLines: 99999,
        style: small(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: small(color: Colors.white),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding:
          EdgeInsetsDirectional.only(start: 20),
        ),
        onChanged: (e)=>{onChange(e)},
        keyboardType: TextInputType.text,
      ),
    ),
  );
}



showErrorDialogue({@required context,@required message}){


  var width=MediaQuery.of(context).size.width;
  var height=MediaQuery.of(context).size.height;


  showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(
                              topRight:Radius.circular(20),
                              topLeft:Radius.circular(20),
                            )
                        ),
                        height: height*0.2,
                        width: width*0.7,
                      ),
                    ),
                    Center(
                      child: Container(
                        height: height*0.2,
                        width: width*0.7,
                        child: Center(
                          child: Image.asset(
                            "assets/error.png",
                            height: height*0.15,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: height*0.2,
                        width: width*0.7,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                            },
                              child: Icon(Icons.close,color: Colors.white,size: 40,)
                          ),
                          ),
                        ),
                      ),
                  ],
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight:Radius.circular(20),
                          bottomLeft:Radius.circular(20),
                        )
                    ),
                    height: height*0.2,
                    width: width*0.7,
                    child: Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Text("${message}",style: small(color: Colors.black),textAlign: TextAlign.center,),
                        ],
                      )
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

showMessage({@required context,@required message}){
  var width=MediaQuery.of(context).size.width;
  var height=MediaQuery.of(context).size.height;


  showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(
                              topRight:Radius.circular(20),
                              topLeft:Radius.circular(20),
                            )
                        ),
                        height: height*0.2,
                        width: width*0.7,
                      ),
                    ),
                    Center(
                      child: Container(
                        height: height*0.2,
                        width: width*0.7,
                        child: Center(
                          child: Image.asset(
                            "assets/paymentSuccessful/person.png",
                            height: height*0.15,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: height*0.2,
                        width: width*0.7,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close,color: Colors.white,size: 40,)
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight:Radius.circular(20),
                          bottomLeft:Radius.circular(20),
                        )
                    ),
                    height: height*0.2,
                    width: width*0.7,
                    child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text("${message}",style: small(color: Colors.black),textAlign: TextAlign.center,),
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}


showLoading({@required context}){
  showDialog(context: context, builder: (context){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: CircularProgressIndicator(color: Colors.blue,),
        ),
      ),
    );
  });
}





