


import 'package:celebside/services/notification/notificationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

userLogin({String email,String password})async{

  if(FirebaseAuth.instance.currentUser==null){

    try{

      if(email!="" || password!=""){
        var existsInUsers=await FirebaseFirestore.instance.collection("users").where("email",isEqualTo: email).get();

        if(existsInUsers.docs.length==1){

          var userDetails=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
         await SaveDeviceToken(userDetails.user.uid.toString());
          return {"message":"signed in"};
        }
        else{
          return {"message":"Account Doesnt Exist."};
        }
      }
      else{
        return {"message":"Kindly Fill All Details Properly"};
      }

    }
    catch(e){
      FirebaseAuthException error=e;

      return {"message":"${error.message}"};
    }

  }

}