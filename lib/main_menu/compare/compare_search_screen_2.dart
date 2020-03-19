import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/compare/future/compare_future.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_search_result_screen_2.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_list.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker_lawsuit_search.dart';

const double _kPickerSheetHeight = 216.0;

class CompareMainScreenFragmentSearch2 extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  CompareMainScreenFragmentSearch2({
    Key key,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<CompareMainScreenFragmentSearch2> {
  final FocusNode myFocusNodeDocNumber = FocusNode();
  final FocusNode myFocusNodeLawsuitNumber = FocusNode();
  final FocusNode myFocusNodeLawsuitYear = FocusNode();
  final FocusNode myFocusNodeComparePerson = FocusNode();
  final FocusNode myFocusNodeCompareDateStart = FocusNode();
  final FocusNode myFocusNodeCompareDateEnd = FocusNode();
  final FocusNode myFocusNodeProveNumber = FocusNode();
  final FocusNode myFocusNodeProveYear = FocusNode();

  TextEditingController editDocNumber = new TextEditingController();
  TextEditingController editLawsuitNumber = new TextEditingController();
  TextEditingController editLawsuitYear = new TextEditingController();
  TextEditingController editComparePerson = new TextEditingController();
  TextEditingController editCompareDateStart = new TextEditingController();
  TextEditingController editCompareDateEnd = new TextEditingController();
  TextEditingController editProveNumber = new TextEditingController();
  TextEditingController editProveYear = new TextEditingController();

  String _currentDateLawsuitStart, _currentDateLawsuitEnd;
  DateTime _dtDateLawsuitStart, _dtDateLawsuitEnd;
  var dateFormatDate;

  DateTime _dtMaxDate;

  bool IsCompareType1 = true;
  bool IsCompareType2 = false;
  bool IsCompareComplete = true;
  bool IsCompareNonComplete = false;

  List<ItemsCompareList> _searchResult = [];

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    _currentDateLawsuitStart = date;
    _currentDateLawsuitEnd = date;
    _dtDateLawsuitStart = DateTime.now();
    _dtDateLawsuitEnd = DateTime.now();

    _dtMaxDate = DateTime.now();
  }

  CupertinoAlertDialog _cupertinoSearchEmpty(mContext) {
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ไม่พบข้อมูล.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
                editDocNumber.clear();
                editLawsuitNumber.clear();
                editCompareDateStart.clear();
                editCompareDateEnd.clear();
                editComparePerson.clear();
                editProveNumber.clear();
                IsCompareType1 = true;
                IsCompareType2 = false;
                IsCompareComplete = true;
                IsCompareNonComplete = false;
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showSearchEmptyAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _cupertinoSearchEmpty(context);
      },
    );
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new CompareFuture().apiRequestCompareListgetByConAdv(map).then((onValue) {
      List<ItemsCompareList> itemsComplete = [];
      List<ItemsCompareList> itemsNonComplete = [];
      onValue.forEach((f) {
        if (f.COMPARE_ID == null || f.COMPARE_ID == 0) {
          itemsNonComplete.add(f);
        } else {
          itemsComplete.add(f);
        }
      });
      if (IsCompareComplete) {
        _searchResult = itemsComplete;
      } else {
        _searchResult = itemsNonComplete;
      }
      //_searchResult = onValue;
      print(onValue.length);
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
        _showSearchEmptyAlertDialog(mContext);
      }
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompareMainScreenFragmentSearchResult(
                  ItemsPerson: widget.ItemsPerson,
                  ItemSearch: _searchResult,
                  mapSearch: map,
                )),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    editDocNumber.dispose();
    editLawsuitNumber.dispose();
    editLawsuitYear.dispose();
    editComparePerson.dispose();
    editCompareDateStart.dispose();
    editCompareDateEnd.dispose();
    editProveNumber.dispose();
    editLawsuitYear.dispose();
  }

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(bottom: MediaQuery.of(context).viewInsets.bottom, right: 0.0, left: 0.0, child: InputDoneView());
    });

    overlayState.insert(overlayEntry);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
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
                                  "COMPARE_NO": "",
                                  "COMPARE_NO_YEAR": "",
                                  "COMPARE_DATE_FROM": editCompareDateStart.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateLawsuitStart).toString(),
                                  "COMPARE_DATE_TO": editCompareDateEnd.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateLawsuitEnd).toString(),
                                  "COMPARE_NAME": editComparePerson.text,
                                  "COMPARE_OFFICE_NAME": "",
                                  "COMPARE_IS_OUTSIDE": (!IsCompareType1 && !IsCompareType2 ? "" : (IsCompareType1 ? 0 : 1)),
                                  "ARREST_CODE": editDocNumber.text,
                                  "OCCURRENCE_DATE_FROM": "",
                                  "OCCURRENCE_DATE_TO": "",
                                  "ARREST_NAME": "",
                                  "ARREST_OFFICE_NAME": "",
                                  "SUBSECTION_NAME": "",
                                  "GUILTBASE_NAME": "",
                                  "LAWSUIT_IS_OUTSIDE": "",
                                  "LAWSUIT_NO": editLawsuitNumber.text,
                                  "LAWSUIT_NO_YEAR": editLawsuitYear.text.isNotEmpty ? (int.parse(editLawsuitYear.text) > 543 ? int.parse(editLawsuitYear.text) - 543 : "") : "",
                                  "LAWSUIT_DATE_FROM": "",
                                  "LAWSUIT_DATE_TO": "",
                                  "LAWSUIT_OFFICE_NAME": "",
                                  "LAWSUIT_NAME": "",
                                  "PROVE_IS_OUTSIDE": "",
                                  "PROVE_NO": editProveNumber.text,
                                  "PROVE_NO_YEAR": editProveYear.text.isNotEmpty ? (int.parse(editProveYear.text) > 543 ? int.parse(editProveYear.text) - 543 : "") : "",
                                  "RECEIVE_DOC_DATE_FROM": "",
                                  "RECEIVE_DOC_DATE_TO": "",
                                  "RECEIVE_OFFICE_NAME": "",
                                  "PROVE_NAME": "",
                                  "ACCOUNT_OFFICE_CODE": ""
                                };
                                print(IsCompareType1 ? 1 : 0);
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
            //padding: paddingLabel,
            child: Text(
              "ลักษณะคดีเปรียบเทียบ",
              style: textLabelStyle,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: size.width / 2.2,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            IsCompareType1 = !IsCompareType1;
                            IsCompareType2 = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: IsCompareType1 ? Color(0xff3b69f3) : Colors.white,
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: IsCompareType1
                                  ? Icon(
                                      Icons.check,
                                      size: 30.0,
                                      color: Colors.white,
                                    )
                                  : Container(
                                      height: 30.0,
                                      width: 30.0,
                                      color: Colors.transparent,
                                    )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'นอกสถานที่',
                          style: textStyleSelect,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    width: size.width / 2.2,
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              IsCompareType2 = !IsCompareType2;
                              IsCompareType1 = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: IsCompareType2 ? Color(0xff3b69f3) : Colors.white,
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: IsCompareType2
                                    ? Icon(
                                        Icons.check,
                                        size: 30.0,
                                        color: Colors.white,
                                      )
                                    : Container(
                                        height: 30.0,
                                        width: 30.0,
                                        color: Colors.transparent,
                                      )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'ในสถานที่',
                            style: textStyleSelect,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
          Container(
            //padding: paddingLabel,
            child: Text(
              "สถานะการเปรียบเทียบ",
              style: textLabelStyle,
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: size.width / 2.2,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            IsCompareComplete = true;
                            IsCompareNonComplete = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: IsCompareComplete ? Color(0xff3b69f3) : Colors.white,
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: IsCompareComplete
                                  ? Icon(
                                      Icons.check,
                                      size: 30.0,
                                      color: Colors.white,
                                    )
                                  : Container(
                                      height: 30.0,
                                      width: 30.0,
                                      color: Colors.transparent,
                                    )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'เปรียบเทียบแล้ว',
                          style: textStyleSelect,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    width: size.width / 2.2,
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              IsCompareComplete = false;
                              IsCompareNonComplete = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: IsCompareNonComplete ? Color(0xff3b69f3) : Colors.white,
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: IsCompareNonComplete
                                    ? Icon(
                                        Icons.check,
                                        size: 30.0,
                                        color: Colors.white,
                                      )
                                    : Container(
                                        height: 30.0,
                                        width: 30.0,
                                        color: Colors.transparent,
                                      )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'ยังไม่เปรียบเทียบ',
                            style: textStyleSelect,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
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
              focusNode: myFocusNodeDocNumber,
              controller: editDocNumber,
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
              "เลขที่รับคำกล่าวโทษ",
              style: textLabelStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: size.width / 2.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingInputBox,
                      child: TextField(
                        focusNode: myFocusNodeLawsuitNumber,
                        controller: editLawsuitNumber,
                        keyboardType: TextInputType.number,
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
              ),
              Container(
                  padding: paddingInputBox,
                  child: Text(
                    "/",
                    style: textInputStyle,
                  )),
              Container(
                width: size.width / 2.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingInputBox,
                      child: TextField(
                        focusNode: myFocusNodeLawsuitYear,
                        controller: editLawsuitYear,
                        keyboardType: TextInputType.number,
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
              )
            ],
          ),
          Container(
            padding: paddingLabel,
            child: Text(
              "ทะเบียนตรวจพิสูจน์",
              style: textLabelStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: size.width / 2.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        focusNode: myFocusNodeProveNumber,
                        controller: editProveNumber,
                        keyboardType: TextInputType.number,
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
              ),
              Container(
                  padding: paddingInputBox,
                  child: Text(
                    "/",
                    style: textInputStyle,
                  )),
              Container(
                width: size.width / 2.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        focusNode: myFocusNodeProveYear,
                        controller: editProveYear,
                        keyboardType: TextInputType.number,
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
              )
            ],
          ),
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
                        "วันที่เปรียบเทียบคดี",
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
                                return LawsuitSearchDynamicDialog(
                                    Current: _dtDateLawsuitStart,
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
                              _dtDateLawsuitStart = s;
                              _currentDateLawsuitStart = date;
                              editCompareDateStart.text =
                                  _currentDateLawsuitStart;
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
                                  initialDateTime: _dtDateLawsuitStart,
                                  onDateTimeChanged: (DateTime s) {
                                    setState(() {
                                      String date = "";
                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                      _dtDateLawsuitStart = s;
                                      _currentDateLawsuitStart = date;
                                      editCompareDateStart.text = _currentDateLawsuitStart;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        focusNode: myFocusNodeCompareDateStart,
                        controller: editCompareDateStart,
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
                                return LawsuitSearchDynamicDialog(
                                  Current: _dtDateLawsuitEnd,
                                  MaxDate: _dtMaxDate,
                                  MinDate: _dtDateLawsuitStart,);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(
                                s).toString().split(" ");
                            date = splits[0] + " " + splits[1] +
                                " " +
                                (int.parse(splits[3]) + 543)
                                    .toString();
                            setState(() {
                              _dtDateLawsuitEnd = s;
                              _currentDateLawsuitEnd = date;
                              editCompareDateEnd.text = _currentDateLawsuitEnd;
                            });
                          });*/

                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildBottomPicker(
                                CupertinoDatePicker(
                                  maximumDate: _dtMaxDate,
                                  minimumDate: _dtDateLawsuitStart,
                                  maximumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) + 1,
                                  minimumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) - 1,
                                  mode: CupertinoDatePickerMode.date,
                                  initialDateTime: _dtDateLawsuitEnd,
                                  onDateTimeChanged: (DateTime s) {
                                    setState(() {
                                      String date = "";
                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                      _dtDateLawsuitEnd = s;
                                      _currentDateLawsuitEnd = date;
                                      editCompareDateEnd.text = _currentDateLawsuitEnd;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        focusNode: myFocusNodeCompareDateEnd,
                        controller: editCompareDateEnd,
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
              "ชื่อผู้เปรียบเทียบคดี",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeComparePerson,
              controller: editComparePerson,
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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Text(
                "ค้นหางานเปรียบเทียบเเละชำระค่าปรับ",
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
                      //height: 34.0,
                      decoration: BoxDecoration(
                          border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                      /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_02_00_02_00',
                          style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
                      ),
                    ],
                  ),
                  ],
                )*/
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
          )),
    );
  }
}
