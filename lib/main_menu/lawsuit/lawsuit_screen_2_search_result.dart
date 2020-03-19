import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'future/lawsuit_future.dart';
import 'lawsuit_accept_case_screen.dart';
import 'lawsuit_not_accept_case_screen_1.dart';
import 'model/lawsuit_arrest_main.dart';
import 'model/lawsuit_list.dart';
import 'model/lawsuit_main.dart';

class LawsuitMainScreenFragmentSearchResult extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsArrestResponseGetOffice itemsOffice;
  List<ItemsLawsuitList> ItemSearch;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  LawsuitMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsPerson,
    @required this.ItemSearch,
    @required this.itemsOffice,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<LawsuitMainScreenFragmentSearchResult> {
  List<ItemsLawsuitList> _searchResult = [];
  ItemsLawsuitArrestMain lawsuitMain;
  ItemsLawsuitMain _itemsLawsuitMain;

  var dateFormatDate;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');

    _searchResult = widget.ItemSearch;
  }

  @override
  void dispose() {
    super.dispose();
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
        String suspect = "";
        String subSuspect = "";
        if (_searchResult[index].IndicmentDetail.length > 0) {
          suspect = _searchResult[index].IndicmentDetail[0].TITLE_SHORT_NAME_TH + _searchResult[index].IndicmentDetail[0].FIRST_NAME + " " + _searchResult[index].IndicmentDetail[0].LAST_NAME;

          if (_searchResult[index].IndicmentDetail.length == 2) {
            subSuspect += _searchResult[index].IndicmentDetail[1].TITLE_SHORT_NAME_TH + _searchResult[index].IndicmentDetail[1].FIRST_NAME + " " + _searchResult[index].IndicmentDetail[1].LAST_NAME;
          } else if (_searchResult[index].IndicmentDetail.length > 2) {
            subSuspect += _searchResult[index].IndicmentDetail[1].TITLE_SHORT_NAME_TH + _searchResult[index].IndicmentDetail[1].FIRST_NAME + " " + _searchResult[index].IndicmentDetail[1].LAST_NAME + " และคนอื่นๆ " + (_searchResult[index].IndicmentDetail.length - 2).toString() + " คน";
          }
        } else {
          suspect = "-";
        }

        String lawsuit_year = "";
        if (_searchResult[index].INDICTMENT_IS_LAWSUIT_COMPLETE == 1) {
          /*DateTime dt_lawsuit_year = DateTime.parse(_searchResult[index].LAWSUIT_NO_YEAR);*/
          DateTime dt_lawsuit_year = _searchResult[index].LAWSUIT_NO_YEAR != null ? DateTime.parse(_searchResult[index].LAWSUIT_NO_YEAR) : DateTime.now();
          List splitslawYear = dateFormatDate.format(dt_lawsuit_year).toString().split(" ");
          lawsuit_year = (int.parse(splitslawYear[3]) + 543).toString();
        }

        return Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
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
                    _searchResult[index].INDICTMENT_IS_LAWSUIT_COMPLETE == 1
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขที่รับคำกล่าวโทษ",
                                  style: textLabelStyle,
                                ),
                              ),
                              _searchResult[index].LAWSUIT_IS_OUTSIDE == 1
                                  ? Padding(
                                      padding: paddingInputBox,
                                      child: Text(
                                        "น. " + _searchResult[index].LAWSUIT_NO.toString() + '/' + lawsuit_year,
                                        style: textInputStyle,
                                      ),
                                    )
                                  : Padding(
                                      padding: paddingInputBox,
                                      child: Text(
                                        _searchResult[index].LAWSUIT_NO.toString() + '/' + lawsuit_year,
                                        style: textInputStyle,
                                      ),
                                    ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขที่งาน",
                                  style: textLabelStyle,
                                ),
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  _searchResult[index].ARREST_CODE,
                                  style: textInputStyle,
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "มาตรา",
                                  style: textLabelStyle,
                                ),
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  _searchResult[index].SUBSECTION_NAME,
                                  style: textInputStyle,
                                ),
                              ),
                            ],
                          ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ชื่อผู้ต้องหา",
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
                            suspect,
                            style: textInputStyle,
                          ),
                        ),
                        _searchResult[index].IndicmentDetail.length > 1
                            ? Container(
                                padding: paddingInputBox,
                                child: Text(
                                  subSuspect,
                                  style: textStyleDataSub,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                _searchResult[index].INDICTMENT_IS_LAWSUIT_COMPLETE == 1
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              new Container(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: new Card(
                                    color: labelColor,
                                    shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                                    elevation: 0.0,
                                    child: Container(
                                        width: 100.0,
                                        //height: 40,
                                        child: Center(
                                          child: MaterialButton(
                                            onPressed: () {
                                              _navigateLawsuitPreview(context, _searchResult[index].INDICTMENT_ID, true, false, _searchResult[index].LAWSUIT_ID, index);
                                              /*_navigateLawsuitPreview(
                                          context, 301, true, false, 280);*/
                                            },
                                            splashColor: labelColor,
                                            //highlightColor: Colors.blue,
                                            child: Center(
                                              child: Text(
                                                "เรียกดู",
                                                style: textPreviewStyle,
                                              ),
                                            ),
                                          ),
                                        ))),
                              ),
                            ],
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              new Container(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: new Card(
                                    color: Color(0xff087de1),
                                    shape: new RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                                    elevation: 0.0,
                                    child: Container(
                                        width: 100.0,
                                        //height: 40,
                                        child: Center(
                                          child: MaterialButton(
                                            onPressed: () {
                                              _navigateLawsuitAcceptCase(context, _searchResult[index].INDICTMENT_ID);
                                            },
                                            splashColor: Color(0xff087de1),
                                            //highlightColor: Colors.blue,
                                            child: Center(
                                              child: Text(
                                                "รับคดี",
                                                style: textStyleButtonAccept,
                                              ),
                                            ),
                                          ),
                                        ))),
                              ),
                              new Card(
                                  shape: new RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                                  elevation: 0.0,
                                  child: Container(
                                      width: 100.0,
                                      //height: 40,
                                      child: Center(
                                        child: MaterialButton(
                                          onPressed: () {
                                            _navigateLawsuitNotAcceptCase(context, _searchResult[index].INDICTMENT_ID, index);
                                          },
                                          splashColor: Color(0xff087de1),
                                          //highlightColor: Colors.blue,
                                          child: Center(
                                            child: Text(
                                              "ไม่รับคดี",
                                              style: textStyleButtonNotAccept,
                                            ),
                                          ),
                                        ),
                                      ))),
                            ],
                          )
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool IsCompareComplete = false;
  bool IsProveComplete = false;

  Future<bool> onLoadActionGetLawsuitIndicment(Map map, bool IsPreview, LAWSUIT_ID) async {
    await new LawsuitFuture().apiRequestLawsuiltArrestIndictmentgetByCon(map).then((onValue) {
      lawsuitMain = onValue;
    });
    if (IsPreview) {
      Map map_law = {
        "LAWSUIT_ID": LAWSUIT_ID
        /*"LAWSUIT_ID": 161*/
      };
      await new LawsuitFuture().apiRequestLawsuitgetByCon(map_law).then((onValue) {
        _itemsLawsuitMain = onValue;
      });

      //check is compare & prove complete
      if (lawsuitMain.IS_PROVE != 1) {
        Map map = {"LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID};
        await new LawsuitFuture().apiRequestLawsuiltComparegetByLawsuitID(map).then((onValue) {
          if (onValue != null) {
            print("onValue : " + onValue.COMPARE_ID.toString());
            IsCompareComplete = true;
          } else {
            IsCompareComplete = false;
          }
        });
      } else {
        Map map = {"LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID};
        await new LawsuitFuture().apiRequestLawsuiltProvegetByLawsuitID(map).then((onValue) {
          if (onValue != null) {
            IsProveComplete = true;
          } else {
            IsProveComplete = false;
          }
        });
      }
    }

    setState(() {});
    return true;
  }

  _navigateLawsuitPreview(BuildContext context, int INDICTMENT_ID, IsPreview, IsUpdate, LAWSUIT_ID, index) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {
      "INDICTMENT_ID": INDICTMENT_ID
      //"INDICTMENT_ID" : 5
    };
    await onLoadActionGetLawsuitIndicment(map, true, LAWSUIT_ID);
    Navigator.pop(context);
    if (lawsuitMain != null || _itemsLawsuitMain != null) {
      var result;
      if (_itemsLawsuitMain.IS_LAWSUIT == 0) {
        result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LawsuitNotAcceptCaseMainScreenFragment(
                    ItemsPerson: widget.ItemsPerson,
                    itemsLawsuitMain: lawsuitMain,
                    IsPreview: true,
                    itemsPreview: _itemsLawsuitMain,
                  )),
        );
      } else {
        result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LawsuitAcceptCaseMainScreenNonProofFragment(
                    itemsLawsuitMain: lawsuitMain,
                    ItemsPerson: widget.ItemsPerson,
                    itemsOffice: widget.itemsOffice,
                    IsEdit: IsUpdate,
                    IsPreview: IsPreview,
                    IsCreate: false,
                    itemsPreview: _itemsLawsuitMain,
                    itemsMasProductSize: widget.itemsMasProductSize,
                    itemsMasProductUnit: widget.itemsMasProductUnit,
                    IS_COMPARE_COMPLETE: IsCompareComplete,
                    IS_PROVE_COMPLETE: IsProveComplete,
                  )),
        );
      }
      if (result.toString() != "Back") {
        _searchResult.removeAt(index);
      } else {}
    }
  }

  _navigateLawsuitNotAcceptCase(BuildContext context, int INDICTMENT_ID, index) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {"INDICTMENT_ID": INDICTMENT_ID};
    await onLoadActionGetLawsuitIndicment(map, false, null);
    Navigator.pop(context);
    if (lawsuitMain != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LawsuitNotAcceptCaseMainScreenFragment(
                  ItemsPerson: widget.ItemsPerson,
                  itemsLawsuitMain: lawsuitMain,
                  IsPreview: false,
                )),
      );
      if (result.toString() != "Back") {
        Navigator.pop(context);
      }
    }
  }

  _navigateLawsuitAcceptCase(BuildContext context, int INDICTMENT_ID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {"INDICTMENT_ID": INDICTMENT_ID};
    await onLoadActionGetLawsuitIndicment(map, false, null);
    Navigator.pop(context);
    if (lawsuitMain != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LawsuitAcceptCaseMainScreenNonProofFragment(
                  itemsLawsuitMain: lawsuitMain,
                  itemsOffice: widget.itemsOffice,
                  ItemsPerson: widget.ItemsPerson,
                  IsEdit: false,
                  IsPreview: false,
                  IsCreate: true,
                  itemsPreview: null,
                )),
      );
      if (result.toString() != "Back") {
        /*Navigator.pop(context);*/
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 6.0, bottom: 6.0);

    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), // here the desired height
          child: AppBar(
            title: new Text(
              "ค้นหาคดีรับคำกล่าวโทษ",
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
              child: Column(
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
                                    padding: paddingInputBox,
                                    child: Text(
                                      'รวมทั้งหมด ' + _searchResult.length.toString() + ' คดี',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
