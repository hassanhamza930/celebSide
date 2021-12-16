import'package:celebside/models/user/userDetails.dart';
import 'package:celebside/services/notification/notificationService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSignupService {
  UserCredential userData;
  set setUserData(UserCredential cred) {
    this.userData = cred;
  }
  UserCredential getUserCred() {
    return this.userData;
  }


  Future<Map> signupWithData ({final String username, final String email, final String fullName, final String phone, final DateTime dob, final String password, final String phoneCode, final String country,final String accountType})async
  {

    if(phone.length!=11){
      return {
        "user":null,
        "message":"The phone number is not proper"
      };
    }

    if(DateTime.now().difference(dob).inDays<3650){
      return {
        "user":null,
        "message":"You must be over 18 to login"
      };
    }



    if(username != "" && email != "" && fullName != "" && phone != "" && dob != null && password != ""){
      if(FirebaseAuth.instance.currentUser==null){
        var userExists= await FirebaseFirestore.instance.collection("users").where("username",isEqualTo: username).get();
        var phoneExists= await FirebaseFirestore.instance.collection("users").where("phone",isEqualTo: phone).get();


        if( phoneExists.docs.length==0){
          if(userExists.docs.length==0 ){
            try {
              userData = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password
              );
              this.setUserData=userData;
              print("created");

              await FirebaseFirestore.instance.collection("users").doc(userData.user.uid.toString()).set(userDetails(username: username, email: email, fullName: fullName, phone:phone, dob:dob, password:password,phoneCode: phoneCode,country: country,accountType: "user",imgSrc:"https://www.cprime.com/wp-content/static/images/blog/default-avatar-250x250.png",wallet:0.0 ).toJson(),SetOptions(merge: true));
              await SaveDeviceToken(userData.user.uid.toString());


              return {
                "user":userData,
                "message":"created"
              };

            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
                return {
                  "user":null,
                  "message":"The Account Password is Weak"
                };
              }
              else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
                return {
                  "user":null,
                  "message":"The account already exists for this email."
                };
              }
            }
            catch (e) {
              return {
                "user":null,
                "message":"Kindly Fill all the Fields"
              };
            }
          }
          else{
            return {"message":"Username is already Registered."};
          }
        }
        else{
          return {"message":"Phone is already Registered."};
        }



      }
      else{
        return {"user":null,"message":"Already Signed In."};
      }

    }
    else{
      return {"user":null,"message":"Kindly Fill All Details Properly."};
    }
  }



}
