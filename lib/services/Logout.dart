
import 'package:celebside/services/notification/notificationService.dart';
import 'package:firebase_auth/firebase_auth.dart';

LogOut()async{
  var uid =   await FirebaseAuth.instance.currentUser.uid;
  await DeleteDeviceToken(uid);
  await FirebaseAuth.instance.signOut();


}
LogOutForCelebrity()async{
  var uid =   await FirebaseAuth.instance.currentUser.uid;
  await DeleteDeviceTokenForCelebrity(uid);
  await FirebaseAuth.instance.signOut();


}