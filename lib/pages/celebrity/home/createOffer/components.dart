import 'package:auto_size_text/auto_size_text.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class promoCodeRow extends StatefulWidget {

  final String promoTitle;
  final String promoDiscount;
  final String promoCode;
  final String totalPromoCodes;
  final int index;
  final String type;
  final String expiry;

  promoCodeRow({this.promoTitle,this.promoDiscount,this.promoCode,this.totalPromoCodes,this.index,@required this.type,this.expiry});

  @override
  _promoCodeRowState createState() => _promoCodeRowState();
}

class _promoCodeRowState extends State<promoCodeRow> {
  @override
  Widget build(BuildContext context) {

    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: AutoSizeText("${widget.promoTitle}",maxLines: 1,style: small(color: Colors.white),)),
          Flexible(child: AutoSizeText("${widget.promoDiscount}",maxLines: 1,style: small(color: Colors.white),)),
          Flexible(child: AutoSizeText("${widget.promoCode}",maxLines: 1,style: small(color: Colors.white),)),
          Flexible(child: AutoSizeText("${widget.totalPromoCodes}",maxLines: 1,style: small(color: Colors.white),)),
          Flexible(child: AutoSizeText("${widget.expiry}",maxLines: 1,style: small(color: Colors.white),)),
          FloatingActionButton(onPressed: ()async{



          try{
            var userDoc=await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).get();
            var userData=userDoc.data();
            List currentPromos=userData[widget.type]["promos"];
            await currentPromos.removeAt(widget.index);
            await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"${widget.type}":{"promos":currentPromos}},SetOptions(merge: true));

          }
          catch(e){
            showErrorDialogue(context: context, message: e);
          }



          },child: Icon(Icons.remove),mini: true,backgroundColor: Color.fromRGBO(24,48,93,1),)

        ],
      ),
    );
  }
}










class fanClubPromoCodeRow extends StatefulWidget {

  final String promoTitle;
  final String promoDiscount;
  final String promoCode;
  final String totalPromoCodes;
  final int index;
  final String type;
  final String expiry;
  fanClubPromoCodeRow({this.promoTitle,this.promoDiscount,this.promoCode,this.totalPromoCodes,this.index,@required this.type,this.expiry});

  @override
  _fanClubPromoCodeRowState createState() => _fanClubPromoCodeRowState();
}

class _fanClubPromoCodeRowState extends State<fanClubPromoCodeRow> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text("${widget.promoTitle}",style: small(color: Colors.white,size: 14),)),
          Flexible(child: Text("${widget.promoDiscount}",style: small(color: Colors.white,size: 14),)),
          Flexible(child: Text("${widget.promoCode}",style: small(color: Colors.white,size: 14),)),
          Flexible(child: Text("${widget.totalPromoCodes}",style: small(color: Colors.white,size: 14),)),
          Flexible(child: Text("${widget.type}",style: small(color: Colors.white,size: 14),)),
          Flexible(child: Text("${widget.expiry}",style: small(color: Colors.white,size: 14),)),
          FloatingActionButton(onPressed: ()async{



            try{
              var userDoc=await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).get();
              var userData=userDoc.data();
              List currentPromos=userData["fanClub"]["promos"];
              await currentPromos.removeAt(widget.index);
              await FirebaseFirestore.instance.collection("celebrities").doc(FirebaseAuth.instance.currentUser.uid.toString()).set({"fanClub":{"promos":currentPromos}},SetOptions(merge: true));

            }
            catch(e){
              showErrorDialogue(context: context, message: e);
            }



          },child: Icon(Icons.remove),mini: true,backgroundColor: Color.fromRGBO(24,48,93,1),)

        ],
      ),
    );
  }
}
