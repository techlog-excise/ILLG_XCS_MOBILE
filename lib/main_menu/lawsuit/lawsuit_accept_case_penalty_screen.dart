import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

import 'model/lawsuit_arrest_main.dart';

Color labelColor = Color(0xff087de1);
TextStyle textAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);

TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
TextStyle appBarStylePay = TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
TextStyle textStyleData = Styles.textStyleData;

class Pernalty extends StatefulWidget {
  ItemsLawsuitArrestMain itemsLawsuitMain;

  Pernalty({
    Key key,
    @required this.itemsLawsuitMain,
  }) : super(key: key);

  @override
  _PernaltyState createState() => _PernaltyState();
}

class _PernaltyState extends State<Pernalty> {
  ItemsLawsuitArrestMain _itemsLawsuitArrestMain;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _itemsLawsuitArrestMain = widget.itemsLawsuitMain;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            'บทกำหนดโทษ',
            style: textAppbar,
          ),
          centerTitle: true),
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
          ListView(children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('บทลงโทษมาตรา', style: textLabelStyle),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _itemsLawsuitArrestMain.SECTION_NAME.toString(),
                                style: textStyleData,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('อัตราโทษ', style: textLabelStyle),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _itemsLawsuitArrestMain.PENALTY_DESC.toString(),
                                style: textStyleData,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('อัตราที่กำหนดให้ปรับ', style: textLabelStyle),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                (_itemsLawsuitArrestMain.FINE == null || _itemsLawsuitArrestMain.FINE == "" || _itemsLawsuitArrestMain.FINE == 0) ? "ไม่มีอัตราที่กำหนดให้ปรับ" : _itemsLawsuitArrestMain.FINE,
                                style: textStyleData,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
        ],
      ),
    );
  }
}
