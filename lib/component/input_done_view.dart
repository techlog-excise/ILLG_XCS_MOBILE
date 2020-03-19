import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InputDoneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color.fromRGBO(240, 240, 242, 1.0),
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: CupertinoButton(
            padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
            onPressed: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Text("ตกลง", style: TextStyle(color: Color.fromRGBO(69, 145, 249, 1.0), fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
