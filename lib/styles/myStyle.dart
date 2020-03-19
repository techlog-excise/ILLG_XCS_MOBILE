import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static const textStyleLabel = TextStyle(fontSize: 15, color: Color(0xff087de1), fontFamily: 'Sukhumvit', fontWeight: FontWeight.w600);
  static const textStyleData = TextStyle(fontSize: 15, color: Colors.black, fontFamily: 'Sukhumvit');
  static const textStyleStar = TextStyle(color: Colors.red, fontFamily: 'Sukhumvit', fontWeight: FontWeight.w600);
  static const textInputStyleTitle = TextStyle(fontSize: 15.0, color: Colors.black, fontFamily: 'Sukhumvit');
  static const textLabelStyle = TextStyle(fontSize: 15.0, color: Color(0xff31517c), fontFamily: 'Sukhumvit');
  static const textConditionImgStyle = TextStyle(fontSize: 12.0, color: Colors.red, fontFamily: 'Sukhumvit');
  static const textStyleLanding = TextStyle(fontSize: 20, fontFamily: 'Sukhumvit');
  static const textStyleButtonAccept = TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Sukhumvit');

  static const textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: 'Sukhumvit');
  static const textExpandStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: 'Sukhumvit');

  static const styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: 'Sukhumvit');
}
