import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_2.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/lawsuit_screen_2_search_result.dart';
import 'package:prototype_app_pang/main_menu/notice/model/item_notice_search.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

import 'future/notice_future.dart';
import 'notice__screen.dart';
import 'notice_screen_search_result.dart';

const double _kPickerSheetHeight = 216.0;

class NoticeMainScreenFragmentSearch extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasterTitleResponse itemsTitle;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  NoticeMainScreenFragmentSearch({
    Key key,
    @required this.ItemsPerson,
    @required this.itemsTitle,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<NoticeMainScreenFragmentSearch> {
  final FocusNode myFocusNodeNoticeNo = FocusNode();
  final FocusNode myFocusNodeNoticePerson = FocusNode();
  final FocusNode myFocusNodeNoticeDateStart = FocusNode();
  final FocusNode myFocusNodeNoticeDateEnd = FocusNode();

  TextEditingController editNoticeNo = new TextEditingController();
  TextEditingController editNoticePerson = new TextEditingController();
  TextEditingController editNoticeDateStart = new TextEditingController();
  TextEditingController editNoticeDateEnd = new TextEditingController();

  String _currentDateNoticeStart, _currentDateNoticeEnd;
  DateTime _dtDateNoticeStart, _dtDateNoticeEnd;
  var dateFormatDate;
  DateTime _dtMaxDate;

  // List<ItemsList> _searchResult = [];
  List<ItemsNoticeSearch> _searchResult = [];

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    _currentDateNoticeStart = date;
    _currentDateNoticeEnd = date;
    _dtDateNoticeStart = DateTime.now();
    _dtDateNoticeEnd = DateTime.now();

    _dtMaxDate = DateTime.now();
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new NoticeFuture().apiRequestNoticeListgetByConAdv(map).then((onValue) {
      _searchResult = onValue;
    });
    setState(() {});
    return true;
  }

  onSearchTextSubmitted(Map map, mContext, IsAction) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadAction(map);
    Navigator.pop(context);
    if (_searchResult.length == 0) {
      if (!IsAction) {
        new EmptyDialog(mContext, "ไม่พบข้อมูล.");
      }
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NoticeMainScreenFragmentSearchResult(
                  ItemsPerson: widget.ItemsPerson,
                  itemsTitle: widget.itemsTitle,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  ItemSearch: _searchResult,
                )),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    editNoticeNo.dispose();
    editNoticePerson.dispose();
    editNoticeDateStart.dispose();
    editNoticeDateEnd.dispose();
  }

  Widget _buildContent(BuildContext context) {
    Color labelColor = Color(0xff087de1);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
            width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildInput(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Card(
                          shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                          elevation: 0.0,
                          child: Container(
                            width: 100.0,
                            child: MaterialButton(
                              onPressed: () {
                                Map map = {
                                  "NOTICE_CODE": editNoticeNo.text,
                                  "DATE_START_FROM": editNoticeDateStart.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateNoticeStart).toString(),
                                  "DATE_START_TO": editNoticeDateEnd.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateNoticeEnd).toString(),
                                  "SUSPECT_NAME": "",
                                  "STAFF_NAME": editNoticePerson.text,
                                  "OFFICE_NAME": "",
                                  "IS_ARREST": "",
                                  "ACCOUNT_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE
                                };
                                print(map);
                                onSearchTextSubmitted(map, context, false);
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
            ),
          ),
        ));
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: _kPickerSheetHeight,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: TextStyle(color: CupertinoColors.black, fontSize: 22.0, fontFamily: FontStyles().FontFamily),
        child: GestureDetector(
          // Blocks taps from propagating to the modal sheet and popping.
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget _buildInput() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return Container(
      padding: EdgeInsets.only(top: 22.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
            child: TextField(
              focusNode: myFocusNodeNoticeNo,
              controller: editNoticeNo,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              style: textInputStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          _buildLine,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: size.width / 2.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "วันที่รับแจ้งความ",
                        style: textLabelStyle,
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        enableInteractiveSelection: false,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          /*showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NoticeSearchDynamicDialog(
                                    Current: _dtDateNoticeStart,
                                    MaxDate: _dtMaxDate,
                                    MinDate: null);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(
                                s).toString().split(" ");
                            date = splits[0] + " " + splits[1] +
                                " " +
                                (int.parse(splits[3]) + 543)
                                    .toString();
                            setState(() {
                              _dtDateNoticeStart = s;
                              _currentDateNoticeStart = date;
                              editNoticeDateStart.text =
                                  _currentDateNoticeStart;
                            });
                          });*/

                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildBottomPicker(
                                CupertinoDatePicker(
                                  maximumDate: _dtMaxDate,
                                  maximumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) + 1,
                                  minimumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) - 1,
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: _dtDateNoticeStart,
                                  onDateTimeChanged: (DateTime s) {
                                    setState(() {
                                      String date = "";
                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                      _dtDateNoticeStart = s;
                                      _currentDateNoticeStart = date;
                                      editNoticeDateStart.text = _currentDateNoticeStart;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        focusNode: myFocusNodeNoticeDateStart,
                        controller: editNoticeDateStart,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: textInputStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    _buildLine,
                  ],
                ),
              ),
              Container(
                width: size.width / 2.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ถึงวันที่",
                        style: textLabelStyle,
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        enableInteractiveSelection: false,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          /*showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NoticeSearchDynamicDialog(
                                  Current: _dtDateNoticeEnd,
                                  MaxDate: _dtMaxDate,
                                  MinDate: _dtDateNoticeStart,);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(
                                s).toString().split(" ");
                            date = splits[0] + " " + splits[1] +
                                " " +
                                (int.parse(splits[3]) + 543)
                                    .toString();
                            setState(() {
                              _dtDateNoticeEnd = s;
                              _currentDateNoticeEnd = date;
                              editNoticeDateEnd.text = _currentDateNoticeEnd;
                            });
                          });*/

                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildBottomPicker(
                                CupertinoDatePicker(
                                  minimumDate: _dtDateNoticeStart,
                                  maximumDate: _dtMaxDate,
                                  maximumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) + 1,
                                  minimumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) - 1,
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: _dtDateNoticeEnd,
                                  onDateTimeChanged: (DateTime s) {
                                    setState(() {
                                      String date = "";
                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                      _dtDateNoticeEnd = s;
                                      _currentDateNoticeEnd = date;
                                      editNoticeDateEnd.text = _currentDateNoticeEnd;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        focusNode: myFocusNodeNoticeDateEnd,
                        controller: editNoticeDateEnd,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: textInputStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    _buildLine,
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "ชื่อผู้รับแจ้งความ",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeNoticePerson,
              controller: editNoticePerson,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              style: textInputStyle,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          _buildLine,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
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
            ),
          ],
        ),
      ),
    );
  }
}
