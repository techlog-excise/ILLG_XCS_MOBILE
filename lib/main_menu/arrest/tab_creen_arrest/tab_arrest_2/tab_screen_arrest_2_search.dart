import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_2.dart';
import 'package:expandable/expandable.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/server/server.dart' as serv;
import 'package:http/http.dart' as http;
import 'package:prototype_app_pang/styles/myStyle.dart';

const double _kPickerSheetHeight = 216.0;

class TabScreenArrest2Search extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  TabScreenArrest2Search({
    Key key,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _TabScreenArrest2SearchState createState() => new _TabScreenArrest2SearchState();
}

class _TabScreenArrest2SearchState extends State<TabScreenArrest2Search> {
  Future<List<ItemsList>> apiRequest(Map jsonMap) async {
    //encode Map to JSON
    var body = json.encode(jsonMap);
    final response = await http.post(
      serv.Server().IPAddress + "/ArrestNoticegetByConAdv",
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      return responseJson.map((m) => new ItemsList.fromJson(m)).toList();
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  // กดค้นหามั้ย
  bool IsSearch = false;

  TabController tabController;
  TextEditingController controller = new TextEditingController();
  List _searchResult = [];
  int _countItem = 0;
  List _itemsData = [];

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
  var dateFormatDate, dateFormatTime;
  DateTime _dtMaxDate;

  TextStyle textInputStyle = Styles.textInputStyle;
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textExpandStyle = Styles.textExpandStyle;
  TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle styleTextSearch = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 6.0, bottom: 6.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await apiRequest(map).then((onValue) {
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
      print("_searchResult: $_searchResult");
      setState(() {
        IsSearch = true;
      });
    }
  }

  @override
  void dispose() {
    editNoticeNo.dispose();
    editNoticePerson.dispose();
    editNoticeDateStart.dispose();
    editNoticeDateEnd.dispose();
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

  // ส่วนผล
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

  buildCollapsedNonCheck(index, expandContext) {
    String title = _searchResult[index].TITLE_SHORT_NAME_TH != null ? _searchResult[index].TITLE_SHORT_NAME_TH : _searchResult[index].TITLE_NAME_TH;
    String firstname = _searchResult[index].FIRST_NAME != null ? _searchResult[index].FIRST_NAME : "";
    String lastname = _searchResult[index].LAST_NAME != null ? _searchResult[index].LAST_NAME : "";
    return InkWell(
      onTap: () {
        setState(() {
          _searchResult[index].IsCheck = !_searchResult[index].IsCheck;
        });
      },
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
                    "เลขที่ใบแจ้งความ",
                    style: textLabelStyle,
                  ),
                ),
              ),
              Center(
                  child: InkWell(
                onTap: () {
                  setState(() {
                    _searchResult[index].IsCheck = !_searchResult[index].IsCheck;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _searchResult[index].IsCheck ? Color(0xff3b69f3) : Colors.white,
                    border: _searchResult[index].IsCheck ? Border.all(color: Color(0xff3b69f3), width: 2) : Border.all(color: Colors.grey[400], width: 2),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: _searchResult[index].IsCheck
                          ? Icon(
                              Icons.check,
                              size: 18.0,
                              color: Colors.white,
                            )
                          : Container(
                              height: 18.0,
                              width: 18.0,
                              color: Colors.transparent,
                            )),
                ),
              )),
            ],
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
              title + firstname + " " + lastname,
              style: textInputStyle,
            ),
          ),
        ],
      ),
    );
  }

  buildCollapsedChecked(index, expandContext) {
    String title = _searchResult[index].TITLE_SHORT_NAME_TH != null ? _searchResult[index].TITLE_SHORT_NAME_TH : _searchResult[index].TITLE_NAME_TH;
    String firstname = _searchResult[index].FIRST_NAME != null ? _searchResult[index].FIRST_NAME : "";
    String lastname = _searchResult[index].LAST_NAME != null ? _searchResult[index].LAST_NAME : "";
    return Builder(builder: (context) {
      var exp = ExpandableController.of(context);
      return InkWell(
        onTap: () {
          exp.toggle();
          setState(() {
            _searchResult[index].IsCheck = !_searchResult[index].IsCheck;
            exp.expanded;
          });
        },
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
                      "เลขที่ใบแจ้งความ",
                      style: textLabelStyle,
                    ),
                  ),
                ),
                Center(
                  child: Builder(
                    builder: (context) {
                      var exp = ExpandableController.of(context);
                      return InkWell(
                        onTap: () {
                          exp.toggle();
                          setState(() {
                            _searchResult[index].IsCheck = !_searchResult[index].IsCheck;
                            exp.expanded;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: _searchResult[index].IsCheck ? Color(0xff3b69f3) : Colors.white,
                            border: _searchResult[index].IsCheck ? Border.all(color: Color(0xff3b69f3), width: 2) : Border.all(color: Colors.grey[400], width: 2),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: _searchResult[index].IsCheck
                                  ? Icon(
                                      Icons.check,
                                      size: 18.0,
                                      color: Colors.white,
                                    )
                                  : Container(
                                      height: 18.0,
                                      width: 18.0,
                                      color: Colors.transparent,
                                    )),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
                title + firstname + " " + lastname,
                style: textInputStyle,
              ),
            ),
          ],
        ),
      );
    });
  }

  buildExpandedChecked(index, expandContext) {
    String title = _searchResult[index].TITLE_SHORT_NAME_TH != null ? _searchResult[index].TITLE_SHORT_NAME_TH : _searchResult[index].TITLE_NAME_TH;
    String firstname = _searchResult[index].FIRST_NAME != null ? _searchResult[index].FIRST_NAME : "";
    String lastname = _searchResult[index].LAST_NAME != null ? _searchResult[index].LAST_NAME : "";

    String suspect_name = "";
    String title_susp = _searchResult[index].SUSPECT_TITLE_SHORT_NAME_TH != null ? _searchResult[index].SUSPECT_TITLE_SHORT_NAME_TH : "";
    String firstname_susp = _searchResult[index].SUSPECT_FIRST_NAME != null ? _searchResult[index].SUSPECT_FIRST_NAME : "";
    String lastname_susp = _searchResult[index].SUSPECT_LAST_NAME != null ? _searchResult[index].SUSPECT_LAST_NAME : "";
    suspect_name = title_susp + firstname_susp + " " + lastname_susp;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: paddingLabel,
                child: Text(
                  "เลขที่ใบแจ้งความ",
                  style: textLabelStyle,
                ),
              ),
            ),
            Center(
              child: Builder(
                builder: (context) {
                  var exp = ExpandableController.of(context);
                  return InkWell(
                    onTap: () {
                      exp.toggle();
                      setState(() {
                        _searchResult[index].IsCheck = !_searchResult[index].IsCheck;
                        exp.expanded;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: _searchResult[index].IsCheck ? Color(0xff3b69f3) : Colors.white,
                        border: _searchResult[index].IsCheck ? Border.all(color: Color(0xff3b69f3), width: 2) : Border.all(color: Colors.grey[400], width: 2),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: _searchResult[index].IsCheck
                              ? Icon(
                                  Icons.check,
                                  size: 18.0,
                                  color: Colors.white,
                                )
                              : Container(
                                  height: 18.0,
                                  width: 18.0,
                                  color: Colors.transparent,
                                )),
                    ),
                  );
                },
              ),
            ),
          ],
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
            title + firstname + " " + lastname,
            style: textInputStyle,
          ),
        ),
        // Container(
        //   padding: paddingLabel,
        //   child: Text(
        //     "ผู้ต้องสงสัย",
        //     style: textLabelStyle,
        //   ),
        // ),
        // Padding(
        //   padding: paddingInputBox,
        //   child: Text(
        //     suspect_name,
        //     style: textInputStyle,
        //   ),
        // ),
        Container(
          padding: paddingLabel,
          child: Text(
            "วันที่แจ้งความ",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: Text(
            _searchResult[index] != null ? (_convertDate(_searchResult[index].NOTICE_DATE) + " " + _convertTime(_searchResult[index].NOTICE_DATE)) : "",
            style: textInputStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      itemCount: _searchResult.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Container(
            padding: EdgeInsets.all(18.0),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            child: !_searchResult[index].IsCheck
                ? buildCollapsedNonCheck(index, context)
                : ExpandableNotifier(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expandable(
                          collapsed: buildExpandedChecked(index, context),
                          expanded: buildCollapsedChecked(index, context),
                        ),
                        _searchResult[index].IsCheck
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Builder(
                                    builder: (context) {
                                      var exp = ExpandableController.of(context);
                                      return FlatButton(
                                          onPressed: () {
                                            exp.toggle();
                                          },
                                          child: Text(
                                            exp.expanded ? "ดูเพิ่มเติม..." : "ย่อ...",
                                            style: textExpandStyle,
                                          ));
                                    },
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildBottom() {
    var size = MediaQuery.of(context).size;
    bool isCheck = false;
    _countItem = 0;
    _searchResult.forEach((item) {
      if (item.IsCheck)
        setState(() {
          isCheck = item.IsCheck;
          _countItem++;
        });
    });
    return isCheck
        ? Container(
            width: size.width,
            height: 65,
            color: Color(0xff2e76bc),
            child: MaterialButton(
              onPressed: () {
                _searchResult.forEach((item) {
                  if (item.IsCheck) _itemsData.add(item);
                });
                Navigator.pop(context, _itemsData);
              },
              child: Center(
                child: Text(
                  'เลือก (${_countItem})',
                  style: textStyleButton,
                ),
              ),
            ),
          )
        : null;
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
              "ใบแจ้งความนำจับ",
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
                    child:
                        // new ConstrainedBox(
                        //     constraints: const BoxConstraints.expand(),
                        //     child: SingleChildScrollView(
                        //       child:
                        _searchResult.length != 0 ? _buildSearchResults() : _buildSearch(),
                    // )),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottom(),
      ),
    );
  }

  // ส่วนค้นหา
  Widget _buildSearch() {
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
                                  "ACCOUNT_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE,
                                  "NOTICE_CODE": editNoticeNo.text,
                                  "DATE_START_FROM": editNoticeDateStart.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateNoticeStart).toString(),
                                  "DATE_START_TO": editNoticeDateEnd.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateNoticeEnd).toString(),
                                  "OFFICE_NAME": "",
                                  "STAFF_NAME": editNoticePerson.text,
                                  "SUSPECT_NAME": "",
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
                        "วันที่แจ้งความ",
                        style: textLabelStyle,
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        enableInteractiveSelection: false,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
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
}
