
import 'package:celebside/services/notification/notificationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

celebrityLogin({String email,String password})async{

  if(FirebaseAuth.instance.currentUser==null){

    if(email=="" || password=="" ){
      return {"message":"Kindly Fill All Fields Properly."};
    }


    try{
      var existsInUsers=await FirebaseFirestore.instance.collection("celebrities").where("email",isEqualTo: email).get();

      if(existsInUsers.docs.length==1){
        var userDetails=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
       await SaveDeviceTokenForCelebrity(userDetails.user.uid);

        return {"message":"signed in"};
      }
      else{
        return {"message":"Account Doesnt Exist."};
      }

    }
    catch(e){
      return {"message":e.message};
    }

  }
  else{
    return {"message":"Already Logged in"};
  }

}