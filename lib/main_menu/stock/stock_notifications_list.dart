import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/future/check_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_main.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/manage_evidence_future/manage_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_main.dart';
import 'package:prototype_app_pang/main_menu/stock/model/stock_list_history.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/main_menu/stock/model/stock_list_history_detail.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/stock/stock_history_detail.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class StockNotifyFragment extends StatefulWidget {
  String Title;
  List<ItemsStockHistoryList> Items;
  StockNotifyFragment({
    Key key,
    @required this.Title,
    @required this.Items,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<StockNotifyFragment> {
  final FocusNode myFocusNodeSearch = FocusNode();
  TextEditingController editSearch = new TextEditingController();

  int countItems;
  int stockTotal = 0;
  var dateFormatDate, dateFormatTime;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    //_reverse_time();
  }

  @override
  void dispose() {
    super.dispose();
    editSearch.dispose();
  }

  String checkType(int type) {
    String result;
    if (type == 0) {
      result = 'รับ';
    } else if (type == 1) {
      result = 'คืน';
    } else if (type == 2) {
      result = 'จัดเก็บ';
    } else if (type == 3) {
      result = 'ขาย';
    } else if (type == 4) {
      result = 'ทำลาย';
    } else if (type == 5) {
      result = 'ยืม';
    } else if (type == 6) {
      result = 'บริจาค';
    } else if (type == 7) {
      result = 'โอนย้าย';
    }
    return result;
  }

  ItemsEvidenceMain itemsEvidenceInList;
  ItemsEvidenceOutMain itemsEvidenceOutList;
  List<ItemsStockHistoryDetail> itemMainsHis = [];

  Future<bool> onLoadAction(ItemsStockHistoryList itemHis) async {
    Map map;
    if (itemHis.EVIDENCE_OUT_TYPE == 0) {
      map = {
        "EVIDENCE_IN_ID": itemHis.EVIDENCE_ID,
        "PROVE_ID": itemHis.PROVE_ID
      };
      await new CheckEvidenceFuture()
          .apiRequestEvidenceIngetByCon(map)
          .then((onValue) {
        itemsEvidenceInList = onValue;
      });
    } else {
      map = {"EVIDENCE_OUT_ID": itemHis.EVIDENCE_ID.toString()};
       await new ManageEvidenceFuture()
           .apiRequestEvidenceOutgetByCon(map)
           .then((onValue) {
         itemsEvidenceOutList = onValue;
       });
    }

    if (itemsEvidenceInList != null) {
      itemsEvidenceInList.EvidenceInItem.forEach((f) {
        itemMainsHis.add(new ItemsStockHistoryDetail(
            EVIDENCE_ITEM_CODE: f.EVIDENCE_IN_ITEM_CODE,
            EVIDENCE_ITEM_DATE: itemsEvidenceInList.EVIDENCE_IN_DATE,
            PRODUCE_NAME: f.PRODUCT_DESC));
      });
    }

    if (itemsEvidenceOutList != null) {
      itemsEvidenceOutList.EvidenceOutIn.EvidenceOutInItem.forEach((f) {
        itemMainsHis.add(new ItemsStockHistoryDetail(
            EVIDENCE_ITEM_CODE: f.EVIDENCE_IN_ITEM_CODE,
            EVIDENCE_ITEM_DATE: itemsEvidenceOutList.EVIDENCE_OUT_DATE,
            PRODUCE_NAME: f.PRODUCT_DESC));
      });
    }

    setState(() {});
    return true;
  }

  _navigat_his(mContext, ItemsStockHistoryList itemHis) async {
    itemMainsHis = [];
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadAction(itemHis);
    Navigator.pop(context);
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StockHistoryDetailFragment(
            Items: itemMainsHis,
            Title: itemHis.EVIDENCE_CODE,
          ),
        ));
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(
        fontSize: 16.0,
        color: Colors.black,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    return widget.Items.length != 0
        ? Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.Items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _navigat_his(context, widget.Items[index]);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                    child: Container(
                        padding: EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                            //color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border(
                              //top: BorderSide(color: Colors.grey[300], width: 1.0),
                              bottom: BorderSide(
                                  color: Colors.grey[300], width: 1.0),
                            )),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 22.0, right: 22.0, top: 12.0, bottom: 12.0),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Text(
                                          "เลขที่" +
                                              checkType(widget.Items[index]
                                                  .EVIDENCE_OUT_TYPE).toString(),
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
                                      widget.Items[index].EVIDENCE_CODE,
                                      style: textInputStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "วันที่ ",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: paddingInputBox,
                                    child: Text(
                                      _convertDate(widget
                                              .Items[index].EVIDENCE_DATE) +
                                          ' ' +
                                          _convertTime(widget
                                              .Items[index].EVIDENCE_DATE),
                                      //_convertDate(itemMain[index].Date),
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
          )
        : Stack(
            children: <Widget>[
              new Center(
                child: new Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(22.0),
                        child: Icon(Icons.notifications,size: 92,color: Colors.grey[400]),
                      ),
                      Text(
                        "ไม่พบข้อมูลการแจ้งเตือน",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey[500],
                            fontFamily: FontStyles().FontFamily),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(
        fontSize: 18.0,
        color: Colors.white,
        fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(
        fontSize: 16.0,
        color: Color(0xff087de1),
        fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
          backgroundColor: Colors.white,
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
            ),
          ),
          body: Stack(children: <Widget>[
            BackgroundContent(),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          //color: Colors.grey[200],
                          border: Border(
                            top:
                                BorderSide(color: Colors.grey[300], width: 1.0),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 1.0),
                                child: new Text(
                                    'จำนวน ' +
                                        widget.Items.length.toString() +
                                        ' รายการ',
                                    style: textLabelStyle),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                          )
                        ],
                      )),
                  Expanded(
                    child: _buildContent(context),
                  ),
                ],
              ),
            ),
          ])),
    );
  }

  String _convertDate(String sDate) {
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    result = splits[0] +
        " " +
        splits[1] +
        " " +
        (int.parse(splits[3]) + 543).toString();

    return result;
  }

  String _convertTime(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " + dateFormatTime.format(dt).toString();
    return result;
  }
}
