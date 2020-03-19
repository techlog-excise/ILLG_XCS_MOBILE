import 'dart:core' as prefix2;
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/data_api/tracking_list.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/future/tracking_future.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_detail_items.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_head_list.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_list_arrest_items.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_list_lawsuit_items.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/tracking_main.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class TrackingFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsData;
  ItemsOAGMasStaff ItemsData;
  TrackingFragment({
    Key key,
    @required this.ItemsData,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<TrackingFragment> {
  var dateFormatDate, dateFormatTime;
  List<ItemsTrackingList> itemsTracking = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
  }

  //style content
  TextStyle textStyleLanding = Styles.textStyleLanding;
  TextStyle textStyleSubLabel = TextStyle(fontSize: 16, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = TextStyle(fontSize: 18, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle textStyleDataSub = TextStyle(fontSize: 16, fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(fontSize: 14.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleButtonAccept = Styles.textStyleButtonAccept;
  TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);

  /* int num_1 = 0, num_2 = 0;
  List number_law1 = [], number_law2 = [];
  var count_json, count_int;

  _getTestData() {
    
  } */

  //List<ItemsTrackingMain> itemMain = [
  /*new ItemsTrackingMain(1, "รอรับคดี", [
      new ItemsTrackingArrestList(1, "TN9011126100021", "10 ก.พ. 2562", [
        new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
        new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
      ]),
      new ItemsTrackingArrestList(1, "TN9011126100021", "10 ก.พ. 2562", [
        new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
        new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
      ]),
    ]),
    new ItemsTrackingMain(2, "รอรับคดี", [
      new ItemsTrackingHeadList("1/2562", "นางสาวชยนันท์ เกิดมากผล", [
        new ItemsTrackingArrestList(1, "TN9011126100021", "10 ก.พ. 2562", [
          new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
          new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
        ]),
        new ItemsTrackingLawsuitList(
            2, "TN9011126100021", "10 ก.พ. 2562", " 255/2562", [
          new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
          new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
        ]),
      ]),
      new ItemsTrackingHeadList("2/2562", "นางสาวชยนันท์ เกิดมากผล", [
        new ItemsTrackingArrestList(1, "TN9011126100021", "10 ก.พ. 2562", [
          new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
          new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
        ]),
        new ItemsTrackingArrestList(1, "TN9011126100021", "10 ก.พ. 2562", [
          new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
          new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
        ]),
      ])
    ]),
    new ItemsTrackingMain(
      3,
      "รอพิสูจน์ของกลาง",
      [
        new ItemsTrackingHeadList("1/2562", "นางสาวชยนันท์ เกิดมากผล", [
          new ItemsTrackingArrestList(1, "TN9011126100021", "10 ก.พ. 2562", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              2, "TN9011126100021", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
        ])
      ],
    ),
    new ItemsTrackingMain(
      4,
      "รอเปรียบเทียบ",
      [
        new ItemsTrackingHeadList("1/2562", "นางสาวชยนันท์ เกิดมากผล", [
          new ItemsTrackingArrestList(1, "TN9011126100021", "10 ก.พ. 2562", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              2, "TN9011126100022", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              4, "TN9011126100023", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
        ])
      ],
    ),
    new ItemsTrackingMain(
      5,
      "รอชำระค่าปรับ",
      [
        new ItemsTrackingHeadList("1/2562", "นางสาวชยนันท์ เกิดมากผล", [
          new ItemsTrackingArrestList(1, "TN9011126100021", "10 ก.พ. 2562", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              2, "TN9011126100022", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              4, "TN9011126100023", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
        ])
      ],
    ),
    new ItemsTrackingMain(
      6,
      "รอนำส่งรายได้",
      [
        new ItemsTrackingHeadList("1/2562", "นางสาวชยนันท์ เกิดมากผล", [
          new ItemsTrackingArrestList(1, "121/1", "10 ก.พ. 2562", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              2, "121/1", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              5, "TN9011126100023", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              6, "120/1", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
        ])
      ],
    ),
    new ItemsTrackingMain(
      7,
      "รอแบ่งเงินสินบน",
      [
        new ItemsTrackingHeadList("1/2562", "นางสาวชยนันท์ เกิดมากผล", [
          new ItemsTrackingArrestList(1, "121/1", "10 ก.พ. 2562", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              2, "121/1", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              5, "TN9011126100023", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              6, "120/1", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
          new ItemsTrackingLawsuitList(
              7, "LC0006036200001", "10 ก.พ. 2562", "นางสาวนิตยา ขนาดผล", [
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา"),
            new ItemsTrackingSubDetail("นาย", "สามารถ", "ปรารถนา")
          ]),
        ])
      ],
    ),
    new ItemsTrackingMain(
      8,
      "รอแบ่งเงินรางวัล",
      [],
    ),*/
  // ];
  List<ItemsTrackingMain> itemMain = [];
  List<ItemsTrackingList> _itemMains = [];

  int type_data;
  String name_data;
  Widget _buildContent(BuildContext context) {
    List splits = widget.ItemsData.OPERATION_OFFICE_SHORT_NAME.split(" ");
    print(splits);

    Map map;
    if (splits.length > 1) {
      map = {"TEXT_SEARCH": /*splits[1].toString().trim().substring(4)*/ "", "ACCOUNT_OFFICE_CODE": widget.ItemsData.OPERATION_OFFICE_CODE};
    } else {
      map = {"TEXT_SEARCH": /*splits[1].toString().trim().substring(4)*/ "", "ACCOUNT_OFFICE_CODE": widget.ItemsData.OPERATION_OFFICE_CODE};
    }
    print(map);

    var size = MediaQuery.of(context).size;
    return FutureBuilder<ItemsTrackingCaseByKeyword>(
      future: new TrackingFuture().apiCaseStatusListgetByKeyword(map),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ItemsTrackingList> items = [];
          snapshot.data.CaseStatusList.forEach((f) {
            if (f.CASE_STATUS != null) {
              items.add(f);
            }
          });
          _itemMains = items;
          List<String> head = [];

          List<ItemsTrackingHeadList> itemHeadList_1 = [];
          List<ItemsTrackingHeadList> itemHeadList_1_2 = [];
          List<ItemsTrackingHeadList> itemHeadList_2 = [];
          List<ItemsTrackingHeadList> itemHeadList_3 = [];
          List<ItemsTrackingHeadList> itemHeadList_4 = [];
          List<ItemsTrackingHeadList> itemHeadList_5 = [];
          List<ItemsTrackingHeadList> itemHeadList_6 = [];
          List<ItemsTrackingHeadList> itemHeadList_7 = [];
          List<ItemsTrackingHeadList> itemHeadList_8 = [];
          List<ItemsTrackingHeadList> itemHeadList_9 = [];

          /*List<ItemsTrackingArrestList> itemTypeList_1 = [];
          List<ItemsTrackingArrestList> itemTypeList_1_2 = [];
          List<ItemsTrackingArrestList> itemTypeList_2 = [];
          List<ItemsTrackingArrestList> itemTypeList_3 = [];
          List<ItemsTrackingArrestList> itemTypeList_4 = [];
          List<ItemsTrackingArrestList> itemTypeList_5 = [];
          List<ItemsTrackingArrestList> itemTypeList_6 = [];
          List<ItemsTrackingArrestList> itemTypeList_7 = [];*/

          for (int index = 0; index < _itemMains.length; index++) {
            if (_itemMains[index].CASE_STATUS == "รอรับคดี") {
              itemHeadList_1.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].ARREST_CODE, _itemMains[index].ARREST_STAFF_NAME, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].LAWSUIT_STAFF_NAME)])
              ]));
            } else if (_itemMains[index].CASE_STATUS == "ไม่รับเป็นคดี") {
              itemHeadList_1_2.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].ARREST_CODE, _itemMains[index].ARREST_STAFF_NAME, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].LAWSUIT_STAFF_NAME)])
              ]));
            } else if (_itemMains[index].CASE_STATUS == "รอคำพิพากษา") {
              //itemTypeList_2.add();
              String law_name = "";
              _itemMains[index].LawbreakerList.forEach((law) {
                law_name += law.ARREST_LAWBREAKER_NAME + "\n";
              });

              itemHeadList_2.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].LAWSUIT_NO, law_name, [
                new ItemsTrackingArrestList(2, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].LAWSUIT_STAFF_NAME)])
              ]));
            } else if (_itemMains[index].CASE_STATUS == "รอพิสูจน์ของกลาง") {
              String law_name = "";
              /*_itemMains[index].LawbreakerList.forEach((law){
                law_name += law.ARREST_LAWBREAKER_NAME+"\n";
              });*/
              String suspect = "";
              String subSuspect = "";
              if (_itemMains[index].LawbreakerList.length > 0) {
                suspect = _itemMains[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
                if (_itemMains[index].LawbreakerList.length == 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
                } else if (_itemMains[index].LawbreakerList.length > 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_itemMains[index].LawbreakerList.length - 2).toString() + " คน";
                }
              } else {
                suspect = "-";
              }
              law_name = suspect + "\n" + subSuspect;

              itemHeadList_3.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].LAWSUIT_NO.toString(), law_name, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].ARREST_STAFF_NAME), new ItemsTrackingSubDetail(_itemMains[index].ARREST_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(
                    2, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].LAWSUIT_STAFF_NAME.toString(), [new ItemsTrackingSubDetail(_itemMains[index].PROVE_STAFF_NAME), new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
              ]));
            } else if (_itemMains[index].CASE_STATUS == "รอเปรียบเทียบคดีและชำระค่าปรับ" || _itemMains[index].CASE_STATUS == "รอเปรียบเทียบและชำระเงิน") {
              String law_name = "";
              /*_itemMains[index].LawbreakerList.forEach((law){
                law_name += law.ARREST_LAWBREAKER_NAME+"\n";
              });*/
              String suspect = "";
              String subSuspect = "";
              if (_itemMains[index].LawbreakerList.length > 0) {
                suspect = _itemMains[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
                if (_itemMains[index].LawbreakerList.length == 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
                } else if (_itemMains[index].LawbreakerList.length > 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_itemMains[index].LawbreakerList.length - 2).toString() + " คน";
                }
              } else {
                suspect = "-";
              }
              law_name = suspect + "\n" + subSuspect;

              itemHeadList_4.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].LAWSUIT_NO.toString(), law_name, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(2, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].PROVE_STAFF_NAME, [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(4, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].PROVE_STAFF_NAME, [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)])
              ]));
            } else if (_itemMains[index].CASE_STATUS == "รอนำส่งรายได้") {
              String law_name = "";
              /*_itemMains[index].LawbreakerList.forEach((law){
                law_name += law.ARREST_LAWBREAKER_NAME+"\n";
              });*/
              String suspect = "";
              String subSuspect = "";
              if (_itemMains[index].LawbreakerList.length > 0) {
                suspect = _itemMains[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
                if (_itemMains[index].LawbreakerList.length == 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
                } else if (_itemMains[index].LawbreakerList.length > 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_itemMains[index].LawbreakerList.length - 2).toString() + " คน";
                }
              } else {
                suspect = "-";
              }
              law_name = suspect + "\n" + subSuspect;

              itemHeadList_5.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].LAWSUIT_NO.toString(), law_name, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(2, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].PROVE_STAFF_NAME, [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(5, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].PROVE_STAFF_NAME, [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(6, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].PROVE_STAFF_NAME, [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
              ]));
            } else if (_itemMains[index].CASE_STATUS == "รอแบ่งเงินสินบน" || _itemMains[index].CASE_STATUS == "รอแบ่งเงินสินบนรางวัล") {
              String law_name = "";
              /*_itemMains[index].LawbreakerList.forEach((law){
                law_name += law.ARREST_LAWBREAKER_NAME+"\n";
              });*/
              String suspect = "";
              String subSuspect = "";
              if (_itemMains[index].LawbreakerList.length > 0) {
                suspect = _itemMains[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
                if (_itemMains[index].LawbreakerList.length == 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
                } else if (_itemMains[index].LawbreakerList.length > 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_itemMains[index].LawbreakerList.length - 2).toString() + " คน";
                }
              } else {
                suspect = "-";
              }
              law_name = suspect + "\n" + subSuspect;

              itemHeadList_6.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].RECEIPT_NO.toString() + "/" + _itemMains[index].RECEIPT_BOOK_NO.toString(), law_name, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(2, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].PROVE_STAFF_NAME, [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(5, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].PROVE_STAFF_NAME, [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(6, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].PROVE_STAFF_NAME, [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
                new ItemsTrackingLawsuitList(7, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), _itemMains[index].PROVE_STAFF_NAME, [new ItemsTrackingSubDetail(_itemMains[index].COMPARE_STAFF_NAME)]),
              ]));
            } else if (_itemMains[index].CASE_STATUS == "รอแบ่งเงินรางวัล") {
              //itemTypeList_7.add();
              String law_name = "";
              /*_itemMains[index].LawbreakerList.forEach((law){
                law_name += law.ARREST_LAWBREAKER_NAME+"\n";
              });*/
              String suspect = "";
              String subSuspect = "";
              if (_itemMains[index].LawbreakerList.length > 0) {
                suspect = _itemMains[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
                if (_itemMains[index].LawbreakerList.length == 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
                } else if (_itemMains[index].LawbreakerList.length > 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_itemMains[index].LawbreakerList.length - 2).toString() + " คน";
                }
              } else {
                suspect = "-";
              }
              law_name = suspect + "\n" + subSuspect;

              itemHeadList_7.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].LAWSUIT_NO.toString(), law_name, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].ARREST_STAFF_NAME)])
              ]));
            } else if (_itemMains[index].CASE_STATUS == "รองานรายได้รับเงินนำส่ง") {
              String law_name = "";
              /*_itemMains[index].LawbreakerList.forEach((law){
                law_name += law.ARREST_LAWBREAKER_NAME+"\n";
              });*/
              String suspect = "";
              String subSuspect = "";
              if (_itemMains[index].LawbreakerList.length > 0) {
                suspect = _itemMains[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
                if (_itemMains[index].LawbreakerList.length == 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
                } else if (_itemMains[index].LawbreakerList.length > 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_itemMains[index].LawbreakerList.length - 2).toString() + " คน";
                }
              } else {
                suspect = "-";
              }
              law_name = suspect + "\n" + subSuspect;

              itemHeadList_8.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].LAWSUIT_NO.toString(), law_name, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].ARREST_STAFF_NAME)])
              ]));
            } else if (_itemMains[index].CASE_STATUS == "แบ่งเงินสินบนรางวัล") {
              String law_name = "";
              /*_itemMains[index].LawbreakerList.forEach((law){
                law_name += law.ARREST_LAWBREAKER_NAME+"\n";
              });*/
              String suspect = "";
              String subSuspect = "";
              if (_itemMains[index].LawbreakerList.length > 0) {
                suspect = _itemMains[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
                if (_itemMains[index].LawbreakerList.length == 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
                } else if (_itemMains[index].LawbreakerList.length > 2) {
                  subSuspect += _itemMains[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_itemMains[index].LawbreakerList.length - 2).toString() + " คน";
                }
              } else {
                suspect = "-";
              }
              law_name = suspect + "\n" + subSuspect;

              itemHeadList_9.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].LAWSUIT_NO.toString(), law_name, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].ARREST_STAFF_NAME)])
              ]));
            }

            //test รอรับคดี by paiwad
            else {
              itemHeadList_1.add(new ItemsTrackingHeadList(_itemMains[index].ARREST_ID, _itemMains[index].ARREST_CODE, _itemMains[index].ARREST_STAFF_NAME, [
                new ItemsTrackingArrestList(1, _itemMains[index].ARREST_CODE, _itemMains[index].OCCURRENCE_DATE.toString(), [new ItemsTrackingSubDetail(_itemMains[index].LAWSUIT_STAFF_NAME)])
              ]));
              /*itemTypeList_1.add(new ItemsTrackingArrestList(
                  1,
                  _itemMains[index].ARREST_CODE.toString(),
                  _itemMains[index].OCCURRENCE_DATE.toString(), [
                new ItemsTrackingSubDetail(_itemMains[index].ARREST_STAFF_NAME)
              ]));*/

            }
          }
          itemMain = [
            new ItemsTrackingMain(1, "รอรับคดี", itemHeadList_1),
            //new ItemsTrackingMain(1, "ไม่รับเป็นคดี", itemHeadList_1_2),
            new ItemsTrackingMain(2, "รอคำพิพากษาศาล", itemHeadList_2),
            new ItemsTrackingMain(3, "รอพิสูจน์ของกลาง", itemHeadList_3),
            new ItemsTrackingMain(4, "รอเปรียบเทียบคดีและชำระค่าปรับ", itemHeadList_4),
            new ItemsTrackingMain(5, "รอนำส่งรายได้", itemHeadList_5),
            new ItemsTrackingMain(6, "รอแบ่งเงินสินบนรางวัล", itemHeadList_6),
            /*new ItemsTrackingMain(7, "รอแบ่งเงินรางวัล", itemHeadList_7),
            new ItemsTrackingMain(8, "รองานรายได้รับเงินนำส่ง", itemHeadList_8),
            new ItemsTrackingMain(9, "แบ่งเงินสินบนรางวัล", itemHeadList_9),*/
          ];

          return itemMain.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemMain.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrackingMainScreenFragment(
                                Type: itemMain[index].TrackingType,
                                Items: itemMain[index].HeadLists,
                                Title: itemMain[index].TrackingName,
                                ItemsPerson: widget.ItemsData,
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 2.0, bottom: 2.0),
                        //padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: Container(
                            padding: EdgeInsets.all(22.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                              ),
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    //width: size.width / 2.5,
                                    width: 80.0,
                                    height: 80.0,
                                    padding: EdgeInsets.only(top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(12),
                                        color: Colors.white,
                                        border: Border(
                                          top: BorderSide(color: Color(0xff087de1), width: 1.0),
                                          bottom: BorderSide(color: Color(0xff087de1), width: 1.0),
                                          left: BorderSide(color: Color(0xff087de1), width: 1.0),
                                          right: BorderSide(color: Color(0xff087de1), width: 1.0),
                                        )),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                            child: Text(
                                              itemMain[index].HeadLists.length.toString(),
                                              style: textStyleData,
                                            )),
                                        Padding(
                                            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                            child: Text(
                                              "คดี",
                                              style: textDataSubStyle,
                                            )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 22.0),
                                    child: Text(
                                      itemMain[index].TrackingName,
                                      style: textStyleLabel,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  },
                )
              : Stack(
                  children: <Widget>[
                    new Center(
                      child: new Container(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Status : NULL",
                              style: TextStyle(fontSize: 20.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner
        return Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );

    // pate copy
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(
      children: <Widget>[
        BackgroundContent(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 22.0, top: 8, bottom: 8),
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              ' วันที่ ' + _convertDate(DateTime.now().toString()) + " " + _convertTime(DateTime.now().toString()),
                              style: textStyleSubLabel,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
              Expanded(
                child: _buildContent(context),
              ),
            ],
          ),
        ),
      ],
    ));
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
}
