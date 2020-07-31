import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            // top: Consts.avatarRadius + Consts.padding,
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          // margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              SizedBox(height: 8.0),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  //textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff087de1),
                    fontFamily: FontStyles().FontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontFamily: FontStyles().FontFamily,
                ),
              ),
              SizedBox(height: 64.0),
            ],
          ),
        ),
        Positioned(
          right: 6.0,
          top: 6.0,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              // alignment: Alignment(1.05, -1.05),
              // alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 14.0,
                backgroundColor: Colors.red,
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(Consts.padding),
      // ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
