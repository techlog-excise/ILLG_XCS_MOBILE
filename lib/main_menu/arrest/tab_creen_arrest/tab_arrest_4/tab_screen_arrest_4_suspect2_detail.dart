import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';
import 'package:prototype_app_pang/zan/model/person_net_lawbreaker_detail.dart';

class TabScreenArrest4Suspect2Detail extends StatefulWidget {
  ItemsListPersonNetLawbreakerDetail lawbreakerDetail;
  TabScreenArrest4Suspect2Detail({
    Key key,
    @required this.lawbreakerDetail,
  }) : super(key: key);
  @override
  _TabScreenArrest8DowloadState createState() => new _TabScreenArrest8DowloadState();
}

class _TabScreenArrest8DowloadState extends State<TabScreenArrest4Suspect2Detail> {
  ItemsListPersonNetLawbreakerDetail lawbreakerDetail;

  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textLabelEditStyle = TextStyle(fontSize: 16.0, color: Colors.red, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  var dateFormatDate, dateFormatTime;
  final formatter = new NumberFormat("#,###");
  @override
  void initState() {
    super.initState();
    lawbreakerDetail = widget.lawbreakerDetail;

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildContent() {
    String _prefix_law;
    if (lawbreakerDetail.LAWSUIT_IS_OUTSIDE != null) {
      _prefix_law = lawbreakerDetail.LAWSUIT_IS_OUTSIDE.trim().endsWith("รับคำกล่าวโทษนอกสถานที่ทำการ") ? "น." : "";
    } else {
      _prefix_law = "";
    }

    String _prefix_comp;
    if (lawbreakerDetail.COMPARE_IS_OUTSIDE != null) {
      _prefix_comp = lawbreakerDetail.COMPARE_IS_OUTSIDE.trim().endsWith("เปรียบเทียบนอกสถานที่ทำการ") ? "น." : "";
    } else {
      _prefix_comp = "";
    }

    return Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                  //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: paddingLabel,
                      child: Text(
                        "เลขรับคำกล่าวโทษ ",
                        style: textStyleLabel,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  _prefix_law + lawbreakerDetail.LAWSUIT_NO.toString() + "/" + _convertYear(lawbreakerDetail.LAWSUIT_NO_YEAR),
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ฐานความผิดมาตรา",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  lawbreakerDetail.SUBSECTION_NAME.toString(),
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ฐานความผิด",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  lawbreakerDetail.GUILTBASE_NAME.toString(),
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "วันที่จับกุม",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  _convertDate(lawbreakerDetail.OCCURRENCE_DATE) + " " + _convertTime(lawbreakerDetail.OCCURRENCE_DATE),
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ประเภทของกลาง",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  lawbreakerDetail.PRODUCT_GROUP_NAME != null ? lawbreakerDetail.PRODUCT_GROUP_NAME.toString() : "",
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "สถานที่จับกุม",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  lawbreakerDetail.LOCALE_ADDRESS.toString(),
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "เลขที่เปรียบเทียบคดี",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  lawbreakerDetail.COMPARE_NO != null ? (_prefix_comp + lawbreakerDetail.COMPARE_NO.toString() + "/" + _convertYear(lawbreakerDetail.COMPARE_NO_YEAR)) : "",
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ค่าปรับ",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  lawbreakerDetail.PAYMENT_FINE != null ? (formatter.format(lawbreakerDetail.PAYMENT_FINE).toString() + " บาท") : "",
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "คดีสิ้นสุดชั้น",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  lawbreakerDetail.LAWSUIT_END != null ? lawbreakerDetail.LAWSUIT_END.toString() : "",
                  style: textStyleData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    TextStyle styleTextEmpty = TextStyle(fontSize: 18.0, fontFamily: FontStyles().FontFamily);

    String _prefix_law;
    if (lawbreakerDetail.LAWSUIT_IS_OUTSIDE != null) {
      _prefix_law = lawbreakerDetail.LAWSUIT_IS_OUTSIDE.trim().endsWith("รับคำกล่าวโทษนอกสถานที่ทำการ") ? "น. " : "";
    } else {
      _prefix_law = "";
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          title: new Padding(
            padding: EdgeInsets.only(right: 22.0),
            child: new Text(
              _prefix_law.toString() + lawbreakerDetail.LAWSUIT_NO.toString() + "/" + _convertYear(lawbreakerDetail.LAWSUIT_NO_YEAR),
              style: styleTextAppbar,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, "back");
              }),
        ),
      ),
      body: Stack(
        children: <Widget>[
          BackgroundContent(),
          Center(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  String _convertDate(String sDate) {
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    result = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

    return result;
  }

  String _convertTime(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " + dateFormatTime.format(dt).toString();
    return result;
  }

  String _convertYear(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    String year = (int.parse(splits[3]) + 543).toString();
    return year;
  }
}
