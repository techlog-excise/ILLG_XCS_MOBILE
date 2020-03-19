import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_2.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/main_menu/notice/model/item_notice_search.dart';
import 'package:prototype_app_pang/main_menu/notice/model/item_notice_staff.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'future/notice_future.dart';
import 'model/item_notice_main.dart';
import 'notice__screen.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class NoticeMainScreenFragmentSearchResult extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasterTitleResponse itemsTitle;
  List<ItemsNoticeSearch> ItemSearch;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  NoticeMainScreenFragmentSearchResult({
    Key key,
    @required this.ItemsPerson,
    @required this.ItemSearch,
    @required this.itemsTitle,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<NoticeMainScreenFragmentSearchResult> {
  List<ItemsNoticeSearch> _searchResult = [];
  ItemsNoticeMain noticeMain;

  var dateFormatDate;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    _searchResult = widget.ItemSearch;

    _searchResult.sort((a, b) {
      var adate = a.NOTICE_DATE;
      var bdate = b.NOTICE_DATE;
      return -adate.compareTo(bdate);
    });
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
    TextStyle textInputStyle = Styles.textInputStyle;
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
        print("NOTICE_ID: ${_searchResult[index].NOTICE_ID}");

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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "เลขที่ใบแจ้งความ",
                            style: textLabelStyle,
                          ),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: Text(
                            _searchResult[index].NOTICE_CODE,
                            style: textInputStyle,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ผู้รับแจ้งความ",
                            style: textLabelStyle,
                          ),
                        ),
                        Padding(
                          padding: paddingInputBox,
                          child: Text(
                            _searchResult[index].NoticeStaff.first.TITLE_SHORT_NAME_TH + _searchResult[index].NoticeStaff.first.FIRST_NAME + " " + _searchResult[index].NoticeStaff.first.LAST_NAME,
                            // _itemstaff[index].TITLE_SHORT_NAME_TH + _itemstaff[index].FIRST_NAME + " " + _itemstaff[index].LAST_NAME, // มันมีแค่ index เดียว
                            // 'ทดสอบ',
                            style: textInputStyle,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
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
                                        _navigateNoticeScreen(context, _searchResult[index].NOTICE_ID, true, false);
                                      },
                                      splashColor: Color(0xff087de1),
                                      //highlightColor: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          "เรียกดู",
                                          style: textStyleButtonAccept,
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        _searchResult[index].IS_ARREST == 1
                            ? Container()
                            : new Card(
                                shape: new RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                                elevation: 0.0,
                                child: Container(
                                    width: 100.0,
                                    //height: 40,
                                    child: Center(
                                      child: MaterialButton(
                                        onPressed: () {
                                          _navigateNoticeScreen(context, _searchResult[index].NOTICE_ID, false, true);
                                        },
                                        splashColor: Color(0xff087de1),
                                        //highlightColor: Colors.blue,
                                        child: Center(
                                          child: Text(
                                            "แก้ไข",
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

  Future<bool> onLoadActionGetNotice(Map map) async {
    await new NoticeFuture().apiRequestNoticegetByCon(map).then((onValue) {
      noticeMain = onValue;
    });
    setState(() {});
    return true;
  }

  _navigateNoticeScreen(BuildContext context, int NoticeID, bool IsPreview, bool IsUpdate) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {"NOTICE_ID": NoticeID};
    await onLoadActionGetNotice(map);
    Navigator.pop(context);
    if (noticeMain != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoticeMainScreenFragment(
                  ItemsPerson: widget.ItemsPerson,
                  itemsTitle: widget.itemsTitle,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                  itemsNoticeMain: noticeMain,
                  IsPreview: IsPreview,
                  IsCreate: false,
                  IsUpdate: IsUpdate,
                )),
      );
      if (result.toString() != "Back") {
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
              "ค้นหาใบแจ้งความนำจับ",
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
