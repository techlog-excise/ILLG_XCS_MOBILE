import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_list.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/manage_evidence_future/manage_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_list.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_screen_2_search_result.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker_lawsuit_search.dart';

import 'auction_search_screen_2_result.dart';

class AuctionMainScreenFragmentSearch2 extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  //ItemsArrestResponseGetOffice itemsOffice;
  AuctionMainScreenFragmentSearch2({
    Key key,
    @required this.ItemsPerson,
    //@required this.itemsOffice,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<AuctionMainScreenFragmentSearch2> {
  final FocusNode myFocusNodeAuctionNumber = FocusNode();
  final FocusNode myFocusNodeOfferNumber = FocusNode();
  final FocusNode myFocusNodeEvidencePerson = FocusNode();

  final FocusNode myFocusNodeAuctionDateStart = FocusNode();
  final FocusNode myFocusNodeAuctionDateEnd = FocusNode();
  final FocusNode myFocusNodeOfferDateStart = FocusNode();
  final FocusNode myFocusNodeOfferDateEnd = FocusNode();
  final FocusNode myFocusNodeLawsuitDateStart = FocusNode();
  final FocusNode myFocusNodeLawsuitDateEnd = FocusNode();

  TextEditingController editAuctionNumber = new TextEditingController();
  TextEditingController editOfferNumber = new TextEditingController();
  TextEditingController editEvidencePerson = new TextEditingController();

  TextEditingController editAuctionDateStart = new TextEditingController();
  TextEditingController editAuctionDateEnd = new TextEditingController();
  TextEditingController editOfferDateStart = new TextEditingController();
  TextEditingController editOfferDateEnd = new TextEditingController();
  TextEditingController editLawsuitDateStart = new TextEditingController();
  TextEditingController editLawsuitDateEnd = new TextEditingController();

  String _currentDateAuctionStart, _currentDateAuctionEnd, _currentDateOfferStart, _currentDateOfferEnd;
  DateTime _dtDateAuctionStart, _dtDateAuctionEnd, _dtDateOfferStart, _dtDateOfferEnd;
  var dateFormatDate;

  DateTime _dtMaxDate;

  List<ItemsEvidenceOutList> _searchResult = [];

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    _currentDateAuctionStart = date;
    _currentDateAuctionEnd = date;
    _currentDateOfferStart = date;
    _currentDateOfferEnd = date;

    _dtDateAuctionStart = DateTime.now();
    _dtDateAuctionEnd = DateTime.now();
    _dtDateOfferStart = DateTime.now();
    _dtDateOfferEnd = DateTime.now();

    _dtMaxDate = DateTime.now();
  }

  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new ManageEvidenceFuture().apiRequestEvidenceOutListgetByConAdv(map).then((onValue) {
      /*List<ItemsEvidenceOutList> items=[];
      onValue.forEach((f) {
        if (f.EVIDENCE_OUT_TYPE == 2) {
          items.add(f);
        }
      });
      _searchResult = items;*/
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
            builder: (context) => AuctionMainScreenFragmentSearchResult(
                  ItemsPerson: widget.ItemsPerson,
                  ItemSearch: _searchResult,
                  //itemsOffice: widget.itemsOffice,
                )),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    editAuctionNumber.dispose();
    editOfferNumber.dispose();
    editEvidencePerson.dispose();
    editAuctionDateStart.dispose();
    editAuctionDateEnd.dispose();
    editLawsuitDateStart.dispose();
    editLawsuitDateEnd.dispose();
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
                                  "EVIDENCE_OUT_CODE": editAuctionNumber.text,
                                  "EVIDENCE_OUT_DATE_FROM": editAuctionDateStart.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateAuctionStart).toString(),
                                  "EVIDENCE_OUT_DATE_TO": editAuctionDateEnd.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateAuctionEnd).toString(),
                                  "EVIDENCE_OUT_NO": editOfferNumber.text,
                                  "EVIDENCE_OUT_NO_DATE_FROM": editOfferDateStart.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateOfferStart).toString(),
                                  "EVIDENCE_OUT_NO_DATE_TO": editOfferDateEnd.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateOfferEnd).toString(),
                                  "EVIDENCE_OUT_TYPE": "1",
                                  "REPRESENT_OFFICE_CODE": "",
                                  "STAFF_NAME": editEvidencePerson.text,
                                  "STAFF_OFFICE_NAME": ""
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
              "เลขที่ขาย",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeAuctionNumber,
              controller: editAuctionNumber,
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
                        "วันที่ขาย",
                        style: textLabelStyle,
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        enableInteractiveSelection: false,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LawsuitSearchDynamicDialog(Current: _dtDateAuctionStart, MaxDate: _dtMaxDate, MinDate: null);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(s).toString().split(" ");
                            date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                            setState(() {
                              _dtDateAuctionStart = s;
                              _currentDateAuctionStart = date;
                              editAuctionDateStart.text = _currentDateAuctionStart;
                            });
                          });
                        },
                        focusNode: myFocusNodeAuctionDateStart,
                        controller: editAuctionDateStart,
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LawsuitSearchDynamicDialog(
                                  Current: _dtDateAuctionEnd,
                                  MaxDate: _dtMaxDate,
                                  MinDate: _dtDateAuctionStart,
                                );
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(s).toString().split(" ");
                            date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                            setState(() {
                              _dtDateAuctionEnd = s;
                              _currentDateAuctionEnd = date;
                              editAuctionDateEnd.text = _currentDateAuctionEnd;
                            });
                          });
                        },
                        focusNode: myFocusNodeAuctionDateEnd,
                        controller: editAuctionDateEnd,
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
              "เลขที่หนังสืออนุมัติ",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeOfferNumber,
              controller: editOfferNumber,
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
                        "วันที่อนุมัติ",
                        style: textLabelStyle,
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        enableInteractiveSelection: false,
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LawsuitSearchDynamicDialog(Current: _dtDateOfferStart, MaxDate: _dtMaxDate, MinDate: null);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(s).toString().split(" ");
                            date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                            setState(() {
                              _dtDateOfferStart = s;
                              _currentDateOfferStart = date;
                              editOfferDateStart.text = _currentDateOfferStart;
                            });
                          });
                        },
                        focusNode: myFocusNodeOfferDateStart,
                        controller: editOfferDateStart,
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LawsuitSearchDynamicDialog(
                                  Current: _dtDateOfferEnd,
                                  MaxDate: _dtMaxDate,
                                  MinDate: _dtDateOfferStart,
                                );
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(s).toString().split(" ");
                            date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                            setState(() {
                              _dtDateOfferEnd = s;
                              _currentDateOfferEnd = date;
                              editOfferDateEnd.text = _currentDateOfferEnd;
                            });
                          });
                        },
                        focusNode: myFocusNodeOfferDateEnd,
                        controller: editOfferDateEnd,
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
              "ผู้เสนออนุมัติ",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeEvidencePerson,
              controller: editEvidencePerson,
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
              "ค้นหางานขายทอดตลาด",
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
