import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation{
  static void gopush(context,Widget screen)
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen,));
  }
  static void gopushreplace(context,Widget screen)
  {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen,));
  }
  
}