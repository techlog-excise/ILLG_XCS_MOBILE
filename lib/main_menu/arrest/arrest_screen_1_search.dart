import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/main_menu/arrest/arrest_screen_1_search_result.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

const double _kPickerSheetHeight = 216.0;

class ArrestMainScreenFragmentSearch extends StatefulWidget {
  // ItemsPersonInformation ItemsData;
  ItemsOAGMasStaff ItemsData;
  ItemsMasterTitleResponse itemsTitle;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ArrestMainScreenFragmentSearch({
    Key key,
    @required this.ItemsData,
    @required this.itemsTitle,
    @required this.itemsMasProductSize,
    @required this.itemsMasProductUnit,
  }) : super(key: key);
  @override
  _ArrestMainScreenFragmentSearchSearchState createState() => new _ArrestMainScreenFragmentSearchSearchState();
}

class _ArrestMainScreenFragmentSearchSearchState extends State<ArrestMainScreenFragmentSearch> {
  final FocusNode myFocusNodeArrestCode = FocusNode();
  final FocusNode myFocusNodeArrestDateStart = FocusNode();
  final FocusNode myFocusNodeArrestDateEnd = FocusNode();
  final FocusNode myFocusNodeStaffName = FocusNode();
  final FocusNode myFocusNodeLawsuitBreaker = FocusNode();
  final FocusNode myFocusNodeLawsuitNo = FocusNode();

  TextEditingController editArrestCode = new TextEditingController();
  TextEditingController editArrestDateStart = new TextEditingController();
  TextEditingController editArrestDateEnd = new TextEditingController();
  TextEditingController editStaffName = new TextEditingController();
  TextEditingController editLawsuitBreaker = new TextEditingController();
  TextEditingController editLawsuitNo = new TextEditingController();

  String _currentDateArrestStart, _currentDateArrestEnd;
  DateTime _dtDateArrestStart, _dtDateArrestEnd;
  var dateFormatDate;
  DateTime _dtMaxDate;

  List<ItemsListArrestSearch> _searchResult = [];

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    _currentDateArrestStart = date;
    _currentDateArrestEnd = date;
    _dtDateArrestStart = DateTime.now();
    _dtDateArrestEnd = DateTime.now();

    _dtMaxDate = DateTime.now();
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new ArrestFutureMaster().apiRequestArrestListgetByConAdv(map).then((onValue) {
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
            builder: (context) => ArrestMainScreenFragmentSearchResult(
                  ItemsData: widget.ItemsData,
                  ItemSearch: _searchResult,
                  itemsTitle: widget.itemsTitle,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                )),
      );
    }
  }

  @override
  void dispose() {
    editArrestCode.dispose();
    editArrestDateStart.dispose();
    editArrestDateEnd.dispose();
    editStaffName.dispose();
    editLawsuitBreaker.dispose();
    editLawsuitNo.dispose();
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
              "เลขที่งาน",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeArrestCode,
              controller: editArrestCode,
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
                        "วันที่จับกุม",
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
                                  initialDateTime: _dtDateArrestStart,
                                  onDateTimeChanged: (DateTime s) {
                                    setState(() {
                                      String date = "";
                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                      _dtDateArrestStart = s;
                                      _currentDateArrestStart = date;
                                      editArrestDateStart.text = _currentDateArrestStart;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        focusNode: myFocusNodeArrestDateStart,
                        controller: editArrestDateStart,
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
                                  minimumDate: _dtDateArrestStart,
                                  maximumDate: _dtMaxDate,
                                  maximumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) + 1,
                                  minimumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) - 1,
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: _dtDateArrestEnd,
                                  onDateTimeChanged: (DateTime s) {
                                    setState(() {
                                      String date = "";
                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                      _dtDateArrestEnd = s;
                                      _currentDateArrestEnd = date;
                                      editArrestDateEnd.text = _currentDateArrestEnd;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        focusNode: myFocusNodeArrestDateEnd,
                        controller: editArrestDateEnd,
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
              "ชื่อผู้กล่าวหา",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeStaffName,
              controller: editStaffName,
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
              "ชื่อผู้ต้องหา",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeLawsuitBreaker,
              controller: editLawsuitBreaker,
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
              "มาตรา",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeLawsuitNo,
              controller: editLawsuitNo,
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
                                  "ARREST_CODE": editArrestCode.text,
                                  "OCCURRENCE_DATE_FROM": editArrestDateStart.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateArrestStart).toString(),
                                  "OCCURRENCE_DATE_TO": editArrestDateEnd.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateArrestEnd).toString(),
                                  "STAFF_NAME": editStaffName.text,
                                  "LAWBREAKER_NAME": editLawsuitBreaker.text,
                                  "SUBSECTION_NAME": editLawsuitNo.text,
                                };
                                print('map arrest search: $map');
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
              "ค้นหางานจับกุม",
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
