import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/arrest_screen_1.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/notice/notice__screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:location/location.dart' as Locations;
import 'package:flutter/services.dart';

class NoticeFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasterTitleResponse itemsTitle;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  NoticeFragment({
    Key key,
    @required this.ItemsPerson,
    @required this.itemsTitle,
    @required this.itemsMasProductSize,
    @required this.itemsMasProductUnit,
  }) : super(key: key);
  @override
  _NoticeFragmentState createState() => new _NoticeFragmentState();
}

class _NoticeFragmentState extends State<NoticeFragment> {
  _navigate(BuildContext context) async {
    final result = await Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => NoticeMainScreenFragment(
              ItemsPerson: widget.ItemsPerson,
              itemsTitle: widget.itemsTitle,
              IsCreate: true,
              IsPreview: false,
              IsUpdate: false,
            )));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        BackgroundContent(),
        new SingleChildScrollView(
            child: Center(
          child: new Container(
            padding: EdgeInsets.only(top: size.height / 4.5),
            child: new Column(
              children: <Widget>[
                new SizedBox(
                  height: (size.width * 40) / 100,
                  width: (size.width * 40) / 100,
                  child: new RawMaterialButton(
                    onPressed: () {
                      _navigate(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(28.0),
                      child: Image(
                        image: AssetImage("assets/icons/landing/notice_landing.png"),
                        fit: BoxFit.contain,
                        color: Colors.white,
                      ),
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Color(0xff087de1),
                    padding: const EdgeInsets.all(12.0),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.only(top: 32.0),
                  child: Text(
                    "สร้างใบแจ้งความนำจับ",
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily),
                  ),
                )
              ],
            ),
          ),
        ))
      ],
    ));
  }
}
