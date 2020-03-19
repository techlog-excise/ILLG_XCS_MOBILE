import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isDisabled;

  CustomText(this.text, {this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return
        //GestureDetector(
        //  child:
        Container(
      width: MediaQuery.of(context).size.width,
      color: isDisabled ? Colors.grey[200] : Colors.transparent,
      child: Text(
        text,
        style: TextStyle(fontFamily: FontStyles().FontFamily, color: isDisabled ? Theme.of(context).disabledColor : Colors.black, decoration: isDisabled ? TextDecoration.lineThrough : null),
      ),
      //),
      //onTap: isDisabled ? () {} : null,
    );
  }
}
