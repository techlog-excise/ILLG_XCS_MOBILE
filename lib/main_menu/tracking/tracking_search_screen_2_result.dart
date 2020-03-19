import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_deatil_type_1_screen.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_deatil_type_2_screen.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'model/data_api/tracking_list.dart';
import 'model/future/tracking_future.dart';
import 'model/timeline_list.dart';

class TrackingMainScreenFragmentSearchResult extends StatefulWidget {
  ItemsPersonInformation ItemsPerson;
  List<ItemsTrackingList> ItemSearch;
  TrackingMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsPerson,
    @required this.ItemSearch,
    //@required this.itemsOffice,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<TrackingMainScreenFragmentSearchResult> {
  List<ItemsTrackingList> _searchResult = [];

  var dateFormatDate, dateFormatTime;
  final formatter = new NumberFormat("#,###");

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');

    _searchResult = widget.ItemSearch;
  }

  @override
  void dispose() {
    super.dispose();
  }

  String _convertYear(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    String year = (int.parse(splits[3]) + 543).toString();
    return year;
  }

  Widget _buildSearchResults() {
    Color labelColorPreview = Colors.white;
    Color labelColorEdit = Color(0xff087de1);
    TextStyle textPreviewStyle = TextStyle(fontSize: 16.0, color: labelColorPreview, fontFamily: FontStyles().FontFamily);
    TextStyle textEditStyle = TextStyle(fontSize: 16.0, color: labelColorEdit, fontFamily: FontStyles().FontFamily);

    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textStyleDataSub = TextStyle(fontSize: 16, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
    TextStyle textStyleButtonAccept = TextStyle(fontSize: 16, color: Colors.white, fontFamily: FontStyles().FontFamily);
    TextStyle textStyleButtonNotAccept = TextStyle(fontSize: 16, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);

    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        String title_code = "", title_person = "", data_code = "", data_person = "", sub_data_person = "";
        int track_type = 0;

        if (_searchResult[index].CASE_STATUS != null) {
          if (_searchResult[index].CASE_STATUS.trim().endsWith("รอรับคดี")) {
            track_type = 1;
            title_code = "เลขใบงานจับกุม";
            title_person = "ผู้กล่าวหา";
            data_code = _searchResult[index].ARREST_CODE.toString();
            //data_person = _searchResult[index].ARREST_STAFF_NAME.toString();
            String suspect = "";
            String subSuspect = "";
            if (_searchResult[index].LawbreakerList.length > 0) {
              suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
              if (_searchResult[index].LawbreakerList.length == 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
              } else if (_searchResult[index].LawbreakerList.length > 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
              }
            } else {
              suspect = "-";
            }
            data_person = suspect;
            sub_data_person = subSuspect;
          } else if (_searchResult[index].CASE_STATUS.trim().endsWith("ไม่รับเป็นคดี")) {
            track_type = 1;
            title_code = "เลขใบงานจับกุม";
            title_person = "ผู้กล่าวหา";
            data_code = _searchResult[index].ARREST_CODE.toString();
            //data_person = _searchResult[index].ARREST_STAFF_NAME.toString();
            String suspect = "";
            String subSuspect = "";
            if (_searchResult[index].LawbreakerList.length > 0) {
              suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
              if (_searchResult[index].LawbreakerList.length == 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
              } else if (_searchResult[index].LawbreakerList.length > 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
              }
            } else {
              suspect = "-";
            }
            data_person = suspect;
            sub_data_person = subSuspect;
          } else if (_searchResult[index].CASE_STATUS.trim().endsWith("รอคำพิพากษาศาล")) {
            track_type = 2;
            title_code = "เลขรับคำกล่าวโทษ";
            title_person = "ผู้ต้องหา";
            data_code = _searchResult[index].LAWSUIT_NO.toString();
            String suspect = "";
            String subSuspect = "";
            if (_searchResult[index].LawbreakerList.length > 0) {
              suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
              if (_searchResult[index].LawbreakerList.length == 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
              } else if (_searchResult[index].LawbreakerList.length > 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
              }
            } else {
              suspect = "-";
            }
            data_person = suspect;
            sub_data_person = subSuspect;
          } else if (_searchResult[index].CASE_STATUS.trim().endsWith("รอพิสูจน์ของกลาง")) {
            track_type = 3;
            title_code = "เลขรับคำกล่าวโทษ";
            title_person = "ผู้กล่าวหา";
            data_code = _searchResult[index].LAWSUIT_NO.toString();
            //data_person = _searchResult[index].LAWSUIT_STAFF_NAME.toString();
            String suspect = "";
            String subSuspect = "";
            if (_searchResult[index].LawbreakerList.length > 0) {
              suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
              if (_searchResult[index].LawbreakerList.length == 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
              } else if (_searchResult[index].LawbreakerList.length > 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
              }
            } else {
              suspect = "-";
            }
            data_person = suspect;
            sub_data_person = subSuspect;
          } else if (_searchResult[index].CASE_STATUS.trim().endsWith("รอเปรียบเทียบและชำระเงิน")) {
            track_type = 3;
            //title_code = "เลขเปรียบเทียบคดี";
            title_code = "เลขรับคำกล่าวโทษ";
            title_person = "ผู้ต้องหา";
            //data_code = _searchResult[index].COMPARE_NO.toString();
            data_code = _searchResult[index].LAWSUIT_NO.toString();

            String suspect = "";
            String subSuspect = "";
            if (_searchResult[index].LawbreakerList.length > 0) {
              suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
              if (_searchResult[index].LawbreakerList.length == 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
              } else if (_searchResult[index].LawbreakerList.length > 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
              }
            } else {
              suspect = "-";
            }
            data_person = suspect;
            sub_data_person = subSuspect;
          } else if (_searchResult[index].CASE_STATUS.trim().endsWith("ปล่อยตัวชั่วคราว")) {
            track_type = 3;
            title_code = "เลขรับคำกล่าวโทษ";
            title_person = "ผู้ต้องหา";
            data_code = _searchResult[index].LAWSUIT_NO.toString();

            String suspect = "";
            String subSuspect = "";
            if (_searchResult[index].LawbreakerList.length > 0) {
              suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
              if (_searchResult[index].LawbreakerList.length == 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
              } else if (_searchResult[index].LawbreakerList.length > 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
              }
            } else {
              suspect = "-";
            }
            data_person = suspect;
            sub_data_person = subSuspect;
          } else if (_searchResult[index].CASE_STATUS.trim().endsWith("รอนำส่งเงินรายได้")) {
            track_type = 4;
            title_code = "เลขที่ใบเสร็จ";
            title_person = "ผู้ต้องหา";
            data_code = "";

            String suspect = "";
            String subSuspect = "";
            if (_searchResult[index].LawbreakerList.length > 0) {
              suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
              if (_searchResult[index].LawbreakerList.length == 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
              } else if (_searchResult[index].LawbreakerList.length > 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
              }
            } else {
              suspect = "-";
            }
            data_person = suspect;
            sub_data_person = subSuspect;
          } else if (_searchResult[index].CASE_STATUS.trim().endsWith("แบ่งเงินสินบนรางวัลแล้ว")) {
            track_type = 5;
            title_code = "เลขเปรียบเทียบคดี";
            title_person = "ผู้ต้องหา";
            data_code = _searchResult[index].COMPARE_NO.toString();

            String suspect = "";
            String subSuspect = "";
            if (_searchResult[index].LawbreakerList.length > 0) {
              suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
              if (_searchResult[index].LawbreakerList.length == 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
              } else if (_searchResult[index].LawbreakerList.length > 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
              }
            } else {
              suspect = "-";
            }
            data_person = suspect;
            sub_data_person = subSuspect;
          } else if (_searchResult[index].CASE_STATUS.trim().endsWith("แบ่งเงินสินบนรางวัล")) {
            track_type = 5;
            title_code = "เลขเปรียบเทียบคดี";
            title_person = "ผู้ต้องหา";
            data_code = _searchResult[index].COMPARE_NO.toString();

            String suspect = "";
            String subSuspect = "";
            if (_searchResult[index].LawbreakerList.length > 0) {
              suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
              if (_searchResult[index].LawbreakerList.length == 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
              } else if (_searchResult[index].LawbreakerList.length > 2) {
                subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
              }
            } else {
              suspect = "-";
            }
            data_person = suspect;
            sub_data_person = subSuspect;
          }
        } else {
          track_type = 1;
          title_code = "เลขใบงานจับกุม";
          title_person = "ผู้กล่าวหา";
          data_code = _searchResult[index].ARREST_CODE.toString();
          //data_person = _searchResult[index].ARREST_STAFF_NAME.toString();
          String suspect = "";
          String subSuspect = "";
          if (_searchResult[index].LawbreakerList.length > 0) {
            suspect = _searchResult[index].LawbreakerList[0].ARREST_LAWBREAKER_NAME;
            if (_searchResult[index].LawbreakerList.length == 2) {
              subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME;
            } else if (_searchResult[index].LawbreakerList.length > 2) {
              subSuspect += _searchResult[index].LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " + (_searchResult[index].LawbreakerList.length - 2).toString() + " คน";
            }
          } else {
            suspect = "-";
          }
          data_person = suspect;
          sub_data_person = subSuspect;
        }

        return GestureDetector(
          child: Padding(
            padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
            child: Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              title_code,
                              style: textLabelStyle,
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              data_code.toString(),
                              style: textInputStyle,
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              title_person,
                              style: textLabelStyle,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingInputBox,
                                child: Text(
                                  data_person,
                                  style: textInputStyle,
                                ),
                              ),
                              /*_searchResult[index].LawbreakerList.length > 1*/ sub_data_person != null
                                  ? Container(
                                      padding: paddingInputBox,
                                      child: Text(
                                        sub_data_person,
                                        style: textInputStyle,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Icon(
                            Icons.navigate_next,
                            size: 28,
                            color: Colors.grey[500],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          onTap: () {
            _navigate(context, int.parse(_searchResult[index].ARREST_ID), _searchResult[index].CASE_STATUS, track_type);
          },
        );
      },
    );
  }

  List<ItemsTimeLineList> itemsTimeLineList = [];
  ItemsTrackingList _itemsTrackingList;
  Future<bool> onLoadActionGetAll(Map map) async {
    await new TrackingFuture().apiCaseStatusgetByCon(map).then((onValue) {
      itemsTimeLineList = [];
      if (onValue != null && onValue.CASE_STATUS.length > 0) {
        _itemsTrackingList = onValue.CASE_STATUS.first;

        //arrest
        if (_itemsTrackingList.ARREST_ID != null) {
          String law_name = "";
          _itemsTrackingList.LawbreakerList.forEach((law) {
            law_name += law.ARREST_LAWBREAKER_NAME + "\n";
          });

          itemsTimeLineList.add(new ItemsTimeLineList("เลขที่งานจับกุม", _itemsTrackingList.ARREST_CODE, "วันที่เกิดเหตุ", _convertDate(_itemsTrackingList.OCCURRENCE_DATE) + " " + _convertTime(_itemsTrackingList.OCCURRENCE_DATE), "ผู้ต้องหา", law_name));
        }
        //lawsuit
        if (_itemsTrackingList.LAWSUIT_NO != null) {
          String law_name = "";
          _itemsTrackingList.LawbreakerList.forEach((law) {
            law_name += law.ARREST_LAWBREAKER_NAME + "\n";
          });
          itemsTimeLineList
              .add(new ItemsTimeLineList("เลขรับคำกล่าวโทษ", _itemsTrackingList.LAWSUIT_NO, "วันที่รับคำกล่าวโทษ", _itemsTrackingList.LAWSUIT_DATE != null ? (_convertDate(_itemsTrackingList.LAWSUIT_DATE) + " " + _convertTime(_itemsTrackingList.LAWSUIT_DATE)) : "", "ผู้ต้องหา", law_name));
        }
        if (_itemsTrackingList.PROVE_NO != null) {
          itemsTimeLineList.add(new ItemsTimeLineList("ทะเบียนตรวจพิสูจน์ ", _itemsTrackingList.PROVE_NO, "วันที่พิสูจน์ของกลาง", _convertDate(_itemsTrackingList.PROVE_DATE) + " " + _convertTime(_itemsTrackingList.PROVE_DATE), "ผู้พิสูจน์ของกลาง", _itemsTrackingList.PROVE_STAFF_NAME));
        }
        if (_itemsTrackingList.COMPARE_NO != null) {
          itemsTimeLineList.add(new ItemsTimeLineList("เลขเปรียบเทียบคดี ", _itemsTrackingList.COMPARE_NO, "วันที่พิสูจน์ของกลาง", _convertDate(_itemsTrackingList.COMPARE_DATE) + " " + _convertTime(_itemsTrackingList.COMPARE_DATE), "ผู้เปรียบเทียบดคี", _itemsTrackingList.COMPARE_STAFF_NAME));
        }
      }
    });

    setState(() {});
    return true;
  }

  _navigate(BuildContext context, int ARREST_ID, String TITLE_CASE, int TYPE_CASE) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {'ARREST_ID': ARREST_ID};
    await onLoadActionGetAll(map);
    Navigator.pop(context);

    if (_itemsTrackingList != null) {
      if (TYPE_CASE == 1) {
        final result = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackingDetailType1ScreenFragment(
                Type: TYPE_CASE,
                Title: TITLE_CASE,
                Data: _itemsTrackingList,
              ),
            ));
      } else {
        final result = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrackingDetailType2ScreenFragment(
                Type: TYPE_CASE,
                Items: itemsTimeLineList,
                Title: TITLE_CASE,
              ),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    Color labelColor = Color(0xff087de1);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

    return WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Text(
              "ค้นหาคดี",
              style: styleTextAppbar,
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, "Back");
                }),
          ),
        ),
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            Center(
              child: _searchResult.length != 0
                  ? Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            //height: 34.0,
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(color: Colors.grey[300], width: 1.0),
                              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                            )),
                            child: _searchResult.length > 0
                                ? Container(
                                    padding: EdgeInsets.only(right: 18.0, top: 8.0, bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            'รวมทั้งหมด ' + formatter.format(_searchResult.length).toString() + ' คดี',
                                            style: textLabelStyle,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container()),
                        Expanded(
                          child: _searchResult.length != 0 ? _buildSearchResults() : new Container(),
                        ),
                      ],
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
                                "ไม่มีรายการคดี",
                                style: TextStyle(fontSize: 20.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
            ),
          ],
        ),
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
}
