// @dart=2.9

import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
small({@required Color color,double size=17}) {
  return TextStyle(
    color: color,
    fontFamily: "Avenir",
    fontSize: size,
  );
}

smallBold({@required Color color,double size=17}) {
  return TextStyle(
    color: color,
    fontFamily: "AvenirBold",
    fontSize: size,
  );
}

medium({@required Color color,double size=30}){
  return TextStyle(
      color: color,
      fontFamily: "Avenir",
      fontSize:size
  );
}

mediumBold({@required Color color,double size=30}){
  return TextStyle(
      color: color,
      fontFamily: "AvenirBold",
      fontSize:size
  );
}


large({@required Color color}){
  return TextStyle(
    color: color,
    fontFamily: "Avenir",
    fontSize:50
  );
}
