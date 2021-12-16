import 'package:celebside/pages/auth/ForgotPassword.dart';
import 'package:celebside/pages/home/home.dart';
import 'package:celebside/pages/auth/signUp.dart';
import 'package:celebside/services/notification/notificationService.dart';
import 'package:celebside/services/userLogin.dart';
import 'package:celebside/util/components.dart';
import 'package:celebside/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

var email=TextEditingController();
var password=TextEditingController();



class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    var width= MediaQuery.of(context).size.width;
    var height= MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Image.asset(
              "assets/login/loginBack.png",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Center(
              child: Container(
                width: width*0.9,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          "Welcome Back",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "AvenirBold",
                            fontSize: 34,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.89,
                        child: Text(
                          "Login to your account",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: "Avenir",
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    inputField(label: "Email", context: context, onChange: (e){},controller: email),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      padding: EdgeInsets.all(3),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(18.0))),
                      child: Center(
                        child: TextField(
                          controller: password,
                          obscureText: hide,
                          style: small(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: TextButton(
                                onPressed: () {
                                  setState(() {
                                    hide = !hide;
                                  });
                                },
                                child: Icon(
                                  Icons.remove_red_eye,
                                  color: Colors.black,
                                )),
                            labelText: "Password",
                            labelStyle: small(color: Colors.white),
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            contentPadding: EdgeInsetsDirectional.only(start: 20),
                          ),
                          onChanged: (e) {
                          },
                        ),
                      ),
                    ),

                    // inputField(label: "Password", context: context, onChange: (e){},controller: password),
                    SizedBox(
                      height: 50,
                    ),
                    authButton(text: "Login", color: Colors.white, bg: Colors.orange, onPress: ()async{

                      showLoading(context: context);


                      var status=await userLogin(email: email.text,password: password.text);

                      if(status["message"]=="signed in"){


                        Navigator.pop(context);
                        Navigator.of(context)
                            .pushAndRemoveUntil(CupertinoPageRoute(builder: (context){return Home();}), (Route<dynamic> route) => false);

                        // Navigator.push(context,
                        //     CupertinoPageRoute(builder: (context) {
                        //       return Home();
                        //     }));
                      }
                      else{
                        Navigator.pop(context);
                        showErrorDialogue(context: context, message: status["message"].toString());
                      }


                   }, context: context),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) {
                          return ForgotPassword();
                        }));
                      },
                      child: Center(
                        child: Container(
                          child: Text(
                            "Forgot your password?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Avenir",
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 40),
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                )),
          ],
        ));
  }
}
