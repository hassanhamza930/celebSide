import 'package:celebside/util/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




checkIfLogged(context) async{

 try{
  // await FirebaseAuth.instance.signOut();

   User currentUser=FirebaseAuth.instance.currentUser;
    print(currentUser);
 

   if(currentUser!=null){
     return "Logged";
   }
   else{
     return "Not Logged";
   }
 }
 catch(e){
   showErrorDialogue(context: context, message: e.toString());
 }


}