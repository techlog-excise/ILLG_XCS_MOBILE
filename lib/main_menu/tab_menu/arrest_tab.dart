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
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:location/location.dart' as Locations;
import 'package:flutter/services.dart';

class ArrestFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasterTitleResponse itemsTitle;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ArrestFragment({
    Key key,
    @required this.ItemsPerson,
    @required this.itemsTitle,
    @required this.itemsMasProductSize,
    @required this.itemsMasProductUnit,
  }) : super(key: key);
  @override
  _ArrestFragmentState createState() => new _ArrestFragmentState();
}

class _ArrestFragmentState extends State<ArrestFragment> {
  List<ItemsListTransection> _itemTransection = [];
  String transection_no;
  bool IsArrestCode;

  List<ItemsListArrest6Section> _searchResult = [];

  Future<bool> onLoadActionGetTransection(Map map) async {
    /*await new TransectionFuture()
        .apiRequestTransactionRunninggetByCon(map)
        .then((onValue) {
      _itemTransection = onValue;
      if (_itemTransection.length != 0) {
        IsArrestCode = true;
        transection_no = (_itemTransection.last.RUNNING_NO + 1).toString();
        if (transection_no.length != 5) {
          String sum = "";
          for (int i = 0; i < 5 - transection_no.length; i++) {
            sum += "0";
          }
          transection_no = _itemTransection.last.RUNNING_PREFIX
              + _itemTransection.last.RUNNING_OFFICE_CODE +
              _itemTransection.last.RUNNING_YEAR +
              sum + transection_no;
        }
      } else {
        IsArrestCode = false;
        DateFormat format_auto = DateFormat("yyyy");
        String date_auto = (int.parse(
            format_auto.format(DateTime.now()).toString()) + 543)
            .toString()
            .substring(2);
        transection_no =
            "TN" + widget.ItemsPerson.WorkOffCode + date_auto + "00001";
      }
    });*/

    Map map_guiltbase = {"TEXT_SEARCH": ""};
    await new ArrestFuture().apiRequestArrestMasGuiltbasegetByKeyword(map_guiltbase).then((onValue) {
      _searchResult = onValue;
    });
    setState(() {});
    return true;
  }

  _navigate(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        });
    Map map = {
      "RUNNING_TABLE": "OPS_ARREST",
      //"RUNNING_OFFICE_CODE":"050800",
      "RUNNING_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE,
    };
    await onLoadActionGetTransection(map);
    Navigator.pop(context);

    if (_searchResult == null) {
      new NetworkDialog(context, "การเชื่อมมีปัญหา");
    } else {
      final result = await Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => ArrestMainScreenFragment(
                IsPreview: false,
                IsCreate: true,
                IsUpdate: false,
                ItemsPerson: widget.ItemsPerson,
                itemsTitle: widget.itemsTitle,
                itemsMasProductSize: widget.itemsMasProductSize,
                itemsMasProductUnit: widget.itemsMasProductUnit,
                /*ARREST_CODE: transection_no,
                    IsArrestCode: IsArrestCode,
                    itemsListTransection: _itemTransection.length == 0
                        ? null
                        : _itemTransection.last,*/
                ItemsGuiltbase: _searchResult,
              )));
    }
  }

  @override
  void initState() {
    super.initState();

    initPlatformState();
  }

  Locations.Location _location = new Locations.Location();
  bool _permission = false;
  String error;
  String placeAddress = "";

  initPlatformState() async {
    Locations.LocationData location;
    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();
      error = null;

      print("_permission : " + _permission.toString());
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }
      location = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        /*Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: new Text('ILG60_B_01_00_01_00',
                    style: TextStyle(color: Colors.grey[400],
                        fontFamily: FontStyles().FontFamily,fontSize: 12.0)),
              ),
            ),*/
        BackgroundContent(),
        new SingleChildScrollView(
            child: Center(
          child: new Container(
            padding: EdgeInsets.only(top: size.height / 4.5),
            child: new Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*new SizedBox(
                          height: (size.width * 50) / 100,
                          width: (size.width * 50) / 100,
                          child: new IconButton(
                            padding: new EdgeInsets.all(0.0),
                            color: Color(0xff087de1),
                            icon: */ /*new Icon(
                                Icons.add_circle, color: Color(0xff087de1),
                                size: (size.width * 50) / 100),*/ /*
                            Image(image: AssetImage(
                                "assets/icons/icon_drawer_tab1.png"),
                              height: 55.0,
                              width: 55.0,
                              fit: BoxFit.fitWidth,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _navigate(context);
                            },
                          )
                      ),*/

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
                        image: AssetImage("assets/icons/landing/arrest_landing.png"),
                        //height: (((size.width * 40) / 100)*55)/100,
                        //width: (((size.width * 40) / 100)*55)/100,
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
                    "สร้างบันทึกจับกุม สส.2/39",
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
