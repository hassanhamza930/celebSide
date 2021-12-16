import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
class terms extends StatefulWidget {
  @override
  _termsState createState() => _termsState();
}

class _termsState extends State<terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Text("This will be terms and conditions"),
          ),
        )
    );
  }
}
