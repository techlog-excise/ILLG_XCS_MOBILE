import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_screen_2_search_result.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker_lawsuit_search.dart';

import 'future/prove_future.dart';
import 'model/prove_list.dart';

const double _kPickerSheetHeight = 216.0;

class ProveMainScreenFragmentSearch2 extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  //ItemsArrestResponseGetOffice itemsOffice;
  ProveMainScreenFragmentSearch2({
    Key key,
    @required this.ItemsPerson,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
    //@required this.itemsOffice,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<ProveMainScreenFragmentSearch2> {
  final FocusNode myFocusNodeDocNumber = FocusNode();
  final FocusNode myFocusNodeLawsuitNumber = FocusNode();
  final FocusNode myFocusNodeLawsuitYear = FocusNode();
  final FocusNode myFocusNodeProveNumber = FocusNode();
  final FocusNode myFocusNodeProveYear = FocusNode();
  final FocusNode myFocusNodeProvePerson = FocusNode();
  final FocusNode myFocusNodeLawsuitDateStart = FocusNode();
  final FocusNode myFocusNodeLawsuitDateEnd = FocusNode();

  TextEditingController editDocNumber = new TextEditingController();
  TextEditingController editLawsuitNumber = new TextEditingController();
  TextEditingController editLawsuitYear = new TextEditingController();
  TextEditingController editProveNumber = new TextEditingController();
  TextEditingController editProveYear = new TextEditingController();
  TextEditingController editProvePerson = new TextEditingController();
  TextEditingController editLawsuitDateStart = new TextEditingController();
  TextEditingController editLawsuitDateEnd = new TextEditingController();

  String _currentDateLawsuitStart, _currentDateLawsuitEnd;
  DateTime _dtDateLawsuitStart, _dtDateLawsuitEnd;
  var dateFormatDate;

  DateTime _dtMaxDate;

  bool IsInside = false;
  bool IsOutside = true;
  bool IsProveComplete = true;
  bool IsProveNonComplete = false;

  List<ItemsProveList> _searchResult = [];

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

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new ProveFuture().apiRequestProveListgetByConAdv(map).then((onValue) {
      List<ItemsProveList> itemsComplete = [];
      List<ItemsProveList> itemsNonComplete = [];
      onValue.forEach((f) {
        if (f.PROVE_ID == null || f.PROVE_ID == 0) {
          itemsNonComplete.add(f);
        } else {
          itemsComplete.add(f);
        }
      });
      if (IsProveComplete) {
        _searchResult = itemsComplete;
      } else {
        _searchResult = itemsNonComplete;
      }
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
        new EmptyDialog(mContext, "ไม่พบข้อมูล.");
      }
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProveMainScreenFragmentSearchResult(
                  ItemsPerson: widget.ItemsPerson,
                  ItemSearch: _searchResult,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  //itemsOffice: widget.itemsOffice,
                )),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    editDocNumber.dispose();
    editProveNumber.dispose();
    editLawsuitNumber.dispose();
    editProvePerson.dispose();
    editLawsuitDateStart.dispose();
    editLawsuitDateEnd.dispose();
    editLawsuitYear.dispose();
    editProveYear.dispose();
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
                                  "PROVE_TYPE": "",
                                  "PROVE_NO": editProveNumber.text,
                                  "PROVE_NO_YEAR": editProveYear.text.isNotEmpty ? (int.parse(editProveYear.text) > 543 ? int.parse(editProveYear.text) - 543 : "") : "",
                                  "PROVE_IS_OUTSIDE": (!IsOutside && !IsInside ? "" : (IsOutside ? 1 : 0)),
                                  "RECEIVE_DOC_DATE_FROM": editLawsuitDateStart.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateLawsuitStart).toString(),
                                  "RECEIVE_DOC_DATE_TO": editLawsuitDateEnd.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateLawsuitEnd).toString(),
                                  "RECEIVE_OFFICE_NAME": "",
                                  "PROVE_STAFF_NAME": editProvePerson.text,
                                  "ARREST_CODE": editDocNumber.text,
                                  "ARREST_DATE_FROM": "",
                                  "ARREST_DATE_TO": "",
                                  "ARREST_STAFF_NAME": "",
                                  "ARREST_OFFICE_NAME": "",
                                  "SECTION_NAME": "",
                                  "GUILTBASE_NAME": "",
                                  "LAWSUIT_NO": editLawsuitNumber.text,
                                  "LAWSUIT_NO_YEAR": editLawsuitYear.text.isNotEmpty ? (int.parse(editLawsuitYear.text) > 543 ? int.parse(editLawsuitYear.text) - 543 : "") : "",
                                  "LAWSUIT_IS_OUTSIDE": "",
                                  "LAWSUIT_DATE_FROM": "",
                                  "LAWSUIT_DATE_TO": "",
                                  "LAWSUIT_OFFICE_NAME": "",
                                  "LAWSUIT_STAFF_NAME": "",
                                  "ACCOUNT_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE
                                  /*"PROVE_TYPE": "",
                                  "PROVE_NO": "",
                                  "PROVE_IS_OUTSIDE": "",
                                  "RECEIVE_DOC_DATE_FROM": "",
                                  "RECEIVE_DOC_DATE_TO": "",
                                  "RECEIVE_OFFICE_NAME": "",
                                  "PROVE_STAFF_NAME": "",
                                  "ARREST_CODE": "",
                                  "ARREST_DATE_FROM": "",
                                  "ARREST_DATE_TO": "",
                                  "ARREST_STAFF_NAME": "",
                                  "ARREST_OFFICE_NAME": "",
                                  "SECTION_NAME": "",
                                  "GUILTBASE_NAME": "",
                                  "LAWSUIT_NO": "",
                                  "LAWSUIT_IS_OUTSIDE": "",
                                  "LAWSUIT_DATE_FROM": "",
                                  "LAWSUIT_DATE_TO": "",
                                  "LAWSUIT_OFFICE_NAME": "",
                                  "LAWSUIT_STAFF_NAME": ""*/
                                };
                                print(map.toString());
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
              "ลักษณะการพิสูจน์",
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
                            IsOutside = !IsOutside;
                            IsInside = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: IsOutside ? Color(0xff3b69f3) : Colors.white,
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: IsOutside
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
                          'พิสูจน์นอกสถานที่',
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
                              IsInside = !IsInside;
                              IsOutside = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: IsInside ? Color(0xff3b69f3) : Colors.white,
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: IsInside
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
                            'พิสูจน์ในสถานที่',
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
              "สถานะการพิสูจน์",
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
                            IsProveComplete = true;
                            IsProveNonComplete = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: IsProveComplete ? Color(0xff3b69f3) : Colors.white,
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: IsProveComplete
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
                          'พิสูจน์แล้ว',
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
                              IsProveComplete = false;
                              IsProveNonComplete = true;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: IsProveNonComplete ? Color(0xff3b69f3) : Colors.white,
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: IsProveNonComplete
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
                            'ยังไม่พิสูจน์',
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
                        "วันที่พิสูจน์",
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
                              editLawsuitDateStart.text =
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
                                      editLawsuitDateStart.text = _currentDateLawsuitStart;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        focusNode: myFocusNodeLawsuitDateStart,
                        controller: editLawsuitDateStart,
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
                              editLawsuitDateEnd.text = _currentDateLawsuitEnd;
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
                                      editLawsuitDateEnd.text = _currentDateLawsuitEnd;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                        focusNode: myFocusNodeLawsuitDateEnd,
                        controller: editLawsuitDateEnd,
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
              "ชื่อผู้พิสูจน์",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeProvePerson,
              controller: editProvePerson,
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
              "ค้นหางานพิสูจน์ของกลาง",
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
