import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_deatil_type_1_screen.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_deatil_type_2_screen.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'model/data_api/tracking_list.dart';
import 'model/future/tracking_future.dart';
import 'model/timeline_list.dart';

class TrackingMainScreenFragment extends StatefulWidget {
  int Type;
  List Items;
  String Title;
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  TrackingMainScreenFragment({
    Key key,
    @required this.Type,
    @required this.Items,
    @required this.Title,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<TrackingMainScreenFragment> {
  final FocusNode myFocusNodeSearch = FocusNode();
  TextEditingController editSearch = new TextEditingController();

  List<ItemsTimeLineList> itemsTimeLineList = [];

  var dateFormatDate, dateFormatTime;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
  }

  @override
  void dispose() {
    super.dispose();
    editSearch.dispose();
  }

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
          /*String suspect = "";
          String subSuspect = "";
          if (_itemsTrackingList.LawbreakerList.length > 0) {
            suspect = _itemsTrackingList.LawbreakerList[0].ARREST_LAWBREAKER_NAME;
            if (_itemsTrackingList.LawbreakerList.length == 2) {
              subSuspect += _itemsTrackingList.LawbreakerList[1].ARREST_LAWBREAKER_NAME;
            } else if (_itemsTrackingList.LawbreakerList.length > 2) {
              subSuspect += _itemsTrackingList.LawbreakerList[1].ARREST_LAWBREAKER_NAME + " และคนอื่นๆ " +
                  (_itemsTrackingList.LawbreakerList.length - 2).toString() +
                  " คน";
            }
          }else {
            suspect = "-";
          }
          law_name = suspect+"\n"+subSuspect;*/

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
          itemsTimeLineList.add(new ItemsTimeLineList("เลขเปรียบเทียบคดี ", _itemsTrackingList.COMPARE_NO, "วันที่เปรียบเทียบดคี", _convertDate(_itemsTrackingList.COMPARE_DATE) + " " + _convertTime(_itemsTrackingList.COMPARE_DATE), "ผู้เปรียบเทียบดคี", _itemsTrackingList.COMPARE_STAFF_NAME));
        }
      }
    });

    setState(() {});
    return true;
  }

  _navigateType1(BuildContext context, int ARREST_ID) async {
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
      final result = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrackingDetailType1ScreenFragment(
              Type: widget.Type,
              Title: widget.Title,
              Data: _itemsTrackingList,
            ),
          ));
    }
  }

  _navigateType2(BuildContext context, int ARREST_ID) async {
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
      final result = Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TrackingDetailType2ScreenFragment(
              Type: widget.Type,
              Items: itemsTimeLineList,
              Title: widget.Title,
            ),
          ));
    }
  }

  Widget _buildContent_type1(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    return Container(
      child: ListView.builder(
        itemCount: widget.Items.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          String label_title, label_sub;
          String person_name;
          if (widget.Type == 1) {
            label_title = "เลขใบงานจับกุม";
            label_sub = "ผู้กล่าวหา";
            person_name = widget.Items[index].TrackingName;
          } else if (widget.Type == 2 || widget.Type == 3 || widget.Type == 4 || widget.Type == 5) {
            label_title = "เลขรับคำกล่าวโทษ";
            label_sub = "ผู้ต้องหา";
            person_name = widget.Items[index].TrackingName;
          } else if (widget.Type == 6) {
            label_title = "เลขที่ใบเสร็จ";
            label_sub = "ผู้ต้องหา";
            person_name = widget.Items[index].TrackingName;
          } else {
            label_title = "";
            label_sub = "";
            person_name = "";
          }

          return GestureDetector(
            onTap: () {
              if (widget.Type == 1) {
                print("type: " + widget.Type.toString());
                _navigateType1(context, int.parse(widget.Items[index].ARREST_ID));
              } else {
                print("type: " + widget.Type.toString());
                _navigateType2(context, int.parse(widget.Items[index].ARREST_ID));
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackingDetailType2ScreenFragment(
                            Type: widget.Type,
                            Title: widget.Title,
                            Items: widget.Items[index].TrackingList,
                          ),
                    ));*/
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                  child: Container(
                    padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 12.0, bottom: 12.0),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    label_title,
                                    style: textLabelStyle,
                                  ),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Icon(Icons.navigate_next),
                                ),
                              ],
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                widget.Items[index].TrackingNumber.toString(),
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                label_sub,
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                person_name,
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent_type2(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    return Container(
      child: ListView.builder(
        itemCount: widget.Items.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          String label_title, label_sub;
          if (widget.Type == 1) {
            label_title = "เลขใบงานจับกุม";
            label_sub = "ผู้กล่าวหา";
          } else if (widget.Type == 2 || widget.Type == 3 || widget.Type == 4 || widget.Type == 5) {
            label_title = "เลขรับคำกล่าวโทษ";
            label_sub = "ผู้ต้องหา";
          } else if (widget.Type == 6) {
            label_title = "เลขที่ใบเสร็จ";
            label_sub = "ผู้ต้องหา";
          } else if (widget.Type == 7) {
            label_title = "เลขที่เปรียบเทียบคดี";
            label_sub = "ผู้ต้องหา";
          } else {
            label_title = "";
            label_sub = "";
          }

          return GestureDetector(
            onTap: () {
              if (widget.Type == 1) {
                /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackingDetailType1ScreenFragment(
                            Type: widget.Type,
                            Title: widget.Title,
                            Data: widget.Items[index],
                          ),
                    ));*/
                print("type: " + widget.Type.toString());
                _navigateType1(context, int.parse(widget.Items[index].ARREST_ID));
              } else {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrackingDetailType2ScreenFragment(
                            Type: widget.Type,
                            Items: widget.Items[index].TrackingList,
                            Title: widget.Title,
                          ),
                    ));*/
                print("type: " + widget.Type.toString());
                _navigateType2(context, int.parse(widget.Items[index].ARREST_ID));
              }
            },
            child: Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                  child: Container(
                    padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 12.0, bottom: 12.0),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    label_title,
                                    style: textLabelStyle,
                                  ),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Icon(Icons.navigate_next),
                                ),
                              ],
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                widget.Items[index].TrackingNumber,
                                //widget.Items[index].TrackingNumber.toString(),
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                label_sub,
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                widget.Items[index].TrackingName,
                                //widget.Items[index].TrackingName,
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Text(
                widget.Title,
                style: styleTextAppbar,
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackingBookSearchScreenFragment(
                              ItemsPerson: widget.ItemsPerson,
                            ),
                          ));
                    })
              ],
            ),
          ),
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
                        decoration: BoxDecoration(
                            border: Border(
                          //top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            /*Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                          child: new Text('ILG60_B_13_00_03_00',
                            style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                        ),
                      ],
                    ),*/
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                                  child: new Text('รวม ' + widget.Items.length.toString() + ' คดี', style: textLabelStyle),
                                ),
                              ],
                            ),
                          ],
                        )),
                    Expanded(
                      child: widget.Type == 1 ? _buildContent_type1(context) : _buildContent_type2(context),
                    ),
                  ],
                ),
              ),
            ],
          )),
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
