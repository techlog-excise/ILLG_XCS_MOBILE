import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/future_main/login_future.dart';
import 'package:prototype_app_pang/future_production/fine_future_production.dart';
import 'package:prototype_app_pang/future_production/login_future_production.dart';
import 'package:prototype_app_pang/main_menu/find_law/future/find_law_future.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_find_law_response.dart';
import 'package:prototype_app_pang/main_menu/fine/fine_result.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class FineScreen extends StatefulWidget {
  @override
  _FineScreen createState() => new _FineScreen();
}

class _FineScreen extends State<FineScreen> {
  final FocusNode myFocusNodeLawsuit = FocusNode();
  final FocusNode myFocusNodeMistake = FocusNode();
  final FocusNode myFocusNodePenalty = FocusNode();

  TextEditingController editSubsectionName = new TextEditingController();
  TextEditingController editGuiltbaseName = new TextEditingController();
  TextEditingController editPenalty = new TextEditingController();

  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  Color labelColor = Color(0xff087de1);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  List<ItemsFindLawResponse> _searchResult = [];

  String strPenalty = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _navigateSearch(BuildContext mContext) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });

    Map map = {
      'FINE': "",
      'FINE_TYPE': "",
      'GUILTBASE_NAME': editGuiltbaseName.text,
      'PENALTY_SECTION_ID': editPenalty.text,
      'SECTION_SECTION_ID': "",
      'SUBSECTION_NAME': editSubsectionName.text,
    };
    print('map find law search: $map');

    // await onLoadActionMasLawGroupSubSectionRulegetByConAdv(map);
    await onLoadOAG(map);
    Navigator.pop(context);

    if (_searchResult.length == 0) {
      // if (!IsAction) {
      new EmptyDialog(mContext, "ไม่พบข้อมูล.");
      // }
    } else {
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) => FineScreenResult(
                  ItemSearch: _searchResult,
                )),
      );
      if (result.toString() != "back") {
        // _itemsData = result;
        // Navigator.pop(mContext, result);
      }
    }
  }

  // =========================== OAG =================================
  Future<bool> onLoadOAG(map) async {
    String bodyText = "client_id=56e40953-db9d-477b-954e-73f3ec357190&client_secret=71ebae10-1726-4477-8719-2f5dac68281f&grant_source=int_ldap&grant_type=password&password=train01&scope=resource.READ&username=train01";
    String resToken = "";

    //await new LoginFuture().apiRequestOAG(bodyText).then((onValue) async {
    await new LoginFutureProduction().apiRequestProduction().then((onValue) async {
      resToken = onValue;
      print("Response: ${resToken.toString()}");
    });

    //await new LoginFuture().apiRequestMasLawGroupSubSectionRulegetByConAdv(resToken, map).then((onValue) async {
    await new FineFutureProduction().apiRequestProductionMasLawGroupSubSectionRulegetByConAdv(resToken, map).then((onValue) async {
      if (onValue.length > 0) {
        print('RequestMasLawGroupSubSectionRulegetByConAdv Successssss !!');
        _searchResult = onValue;
      } else {
        _searchResult = [];
      }
    });
  }
  // =================================================================

  // Future<bool> onLoadActionMasLawGroupSubSectionRulegetByConAdv(Map map) async {
  //   await new FindLawFuture().apiRequestMasLawGroupSubSectionRulegetByConAdv(map).then((onValue) {
  //     if (onValue.length > 0) {
  //       print('RequestMasLawGroupSubSectionRulegetByConAdv Successssss !!');
  //       _searchResult = onValue;
  //     } else {
  //       _searchResult = [];
  //     }
  //   });
  //   setState(() {});
  //   return true;
  // }

  @override
  void dispose() {
    myFocusNodeLawsuit.dispose();
    myFocusNodeMistake.dispose();
    myFocusNodePenalty.dispose();
    editGuiltbaseName.dispose();
    editSubsectionName.dispose();
    editPenalty.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;

    // print("Device width:${ScreenUtil.screenWidthDp}dp");

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        BackgroundContent(),
        new Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  //color: Colors.grey[200],
                  border: Border(
                top: BorderSide(color: Colors.grey[300], width: 1.0),
              )),
            ),
            Expanded(
              child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    child: _buildContent(context),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    return Container(
      height: size.height,
      decoration: BoxDecoration(
          //color: Colors.white,
          shape: BoxShape.rectangle,
          border: Border(
            top: BorderSide(color: Colors.grey[300], width: 1.0),
            bottom: BorderSide(color: Colors.grey[300], width: 1.0),
          )),
      width: size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
          width: Width,
          child: _buildInput(),
        ),
      ),
    );
  }

  Widget _buildInput() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;
    // print('sProductGroup ${test.toString()}');

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "มาตรา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            // enabled: widget.onEdit ? true : sProductGroup == null ? false : true,
            focusNode: myFocusNodeLawsuit,
            controller: editSubsectionName,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ฐานความผิด",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            // enabled: widget.onEdit ? true : sProductGroup == null ? false : true,
            focusNode: myFocusNodeMistake,
            controller: editGuiltbaseName,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "มาตราบทลงโทษ",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            // enabled: widget.onEdit ? true : sProductGroup == null ? false : true,
            focusNode: myFocusNodePenalty,
            controller: editPenalty,
            // keyboardType: TextInputType.text,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (string) {
              String str = "";
              str = string.replaceAll(new RegExp(r'[!@#$%^&*().+?":{}|<>-]'), "");
              strPenalty = str;
            },
            onSubmitted: (string) {
              setState(() {
                editPenalty.text = strPenalty;
                editPenalty.selection = TextSelection.fromPosition(TextPosition(offset: editPenalty.text.length));
              });
            },
          ),
        ),
        _buildLine,
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new Card(
                  shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.0), borderRadius: BorderRadius.circular(12.0)),
                  elevation: 0.0,
                  child: Container(
                    width: 100.0,
                    // width: ScreenUtil().setWidth(260.0),
                    child: MaterialButton(
                      onPressed: () {
                        setState(() {
                          editPenalty.text = strPenalty;
                          editPenalty.selection = TextSelection.fromPosition(TextPosition(offset: editPenalty.text.length));
                        });
                        _navigateSearch(context);
                      },
                      splashColor: Colors.grey,
                      child: Center(
                        child: Text(
                          "ค้นหา",
                          style: textLabelStyle,
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
