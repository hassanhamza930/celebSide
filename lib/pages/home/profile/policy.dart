import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";

class policy extends StatefulWidget {
  @override
  _policyState createState() => _policyState();
}

class _policyState extends State<policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            color: Colors.white,
            child: Text("This will be privacy policy"),
          ),
        )
    );
  }
}
