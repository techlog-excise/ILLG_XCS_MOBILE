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

import 'return_search_screen_2_result.dart';

class ReturnMainScreenFragmentSearch2 extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  //ItemsArrestResponseGetOffice itemsOffice;
  ReturnMainScreenFragmentSearch2({
    Key key,
    @required this.ItemsPerson,
    //@required this.itemsOffice,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<ReturnMainScreenFragmentSearch2> {
  final FocusNode myFocusNodeLawuitNumber = FocusNode();
  final FocusNode myFocusNodeProveNumber = FocusNode();
  final FocusNode myFocusNodeBookRequest = FocusNode();
  final FocusNode myFocusNodeEvidencePerson = FocusNode();

  final FocusNode myFocusNodeReturnDateStart = FocusNode();
  final FocusNode myFocusNodeReturnDateEnd = FocusNode();
  final FocusNode myFocusNodeLawsuitDateStart = FocusNode();
  final FocusNode myFocusNodeLawsuitDateEnd = FocusNode();

  TextEditingController editLawuitNumber = new TextEditingController();
  TextEditingController editProveNumber = new TextEditingController();
  TextEditingController editBookRequest = new TextEditingController();
  TextEditingController editEvidencePerson = new TextEditingController();

  TextEditingController editReturnDateStart = new TextEditingController();
  TextEditingController editReturnDateEnd = new TextEditingController();
  TextEditingController editLawsuitDateStart = new TextEditingController();
  TextEditingController editLawsuitDateEnd = new TextEditingController();

  String _currentDateReturnStart, _currentDateReturnEnd;
  DateTime _dtDateReturnStart, _dtDateReturnEnd;
  var dateFormatDate;

  bool IsReturnType2 = false, IsReturnType1 = true;

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
    _currentDateReturnStart = date;
    _currentDateReturnEnd = date;

    _dtDateReturnStart = DateTime.now();
    _dtDateReturnEnd = DateTime.now();

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
            builder: (context) => ReturnMainScreenFragmentSearchResult(
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
    editLawuitNumber.dispose();
    editProveNumber.dispose();
    editBookRequest.dispose();
    editEvidencePerson.dispose();
    editReturnDateStart.dispose();
    editReturnDateEnd.dispose();
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
                                  "EVIDENCE_OUT_CODE": "",
                                  "EVIDENCE_OUT_DATE_FROM": editReturnDateStart.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateReturnStart).toString(),
                                  "EVIDENCE_OUT_DATE_TO": editReturnDateEnd.text.isEmpty ? "" : DateFormat('yyyy-MM-dd').format(_dtDateReturnEnd).toString(),
                                  "EVIDENCE_OUT_NO": editBookRequest.text,
                                  "EVIDENCE_OUT_NO_DATE_FROM": "",
                                  "EVIDENCE_OUT_NO_DATE_TO": "",
                                  "EVIDENCE_OUT_TYPE": IsReturnType1 ? 0 : 1,
                                  "REPRESENT_OFFICE_CODE": "",
                                  "STAFF_NAME": editEvidencePerson.text,
                                  "STAFF_OFFICE_NAME": ""
                                  /*"EVIDENCE_OUT_CODE": "",
                                  "EVIDENCE_OUT_DATE_FROM": "",
                                  "EVIDENCE_OUT_DATE_TO": "",
                                  "EVIDENCE_OUT_NO": "",
                                  "EVIDENCE_OUT_NO_DATE_FROM": "",
                                  "EVIDENCE_OUT_NO_DATE_TO": "",
                                  "EVIDENCE_OUT_TYPE": "3",
                                  "REPRESENT_OFFICE_CODE": "",
                                  "STAFF_NAME": "",
                                  "STAFF_OFFICE_NAME": ""*/
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
            //padding: paddingLabel,
            child: Text(
              "ประเภทงานคืนของกลาง",
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
                  width: size.width / 2.4,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            IsReturnType1 = true;
                            IsReturnType2 = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: IsReturnType1 ? Color(0xff3b69f3) : Colors.white,
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: IsReturnType1
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
                          'หน่วยงานภายใน',
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
                              IsReturnType2 = true;
                              IsReturnType1 = false;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: IsReturnType2 ? Color(0xff3b69f3) : Colors.white,
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: IsReturnType2
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
                            'หน่วยงานภายนอก',
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
              "เลขที่รับคำกล่าวโทษ",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeLawuitNumber,
              controller: editProveNumber,
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
              "เลขที่เปรียบเทียบคดี",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeProveNumber,
              controller: editProveNumber,
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
              "เลขที่หนังสือแจ้งคืน",
              style: textLabelStyle,
            ),
          ),
          Padding(
            padding: paddingInputBox,
            child: TextField(
              focusNode: myFocusNodeBookRequest,
              controller: editBookRequest,
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
                        "วันที่คืน",
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
                                return LawsuitSearchDynamicDialog(Current: _dtDateReturnStart, MaxDate: _dtMaxDate, MinDate: null);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(s).toString().split(" ");
                            date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                            setState(() {
                              _dtDateReturnStart = s;
                              _currentDateReturnStart = date;
                              editReturnDateStart.text = _currentDateReturnStart;
                            });
                          });
                        },
                        focusNode: myFocusNodeReturnDateStart,
                        controller: editReturnDateStart,
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
                                  Current: _dtDateReturnEnd,
                                  MaxDate: _dtMaxDate,
                                  MinDate: _dtDateReturnStart,
                                );
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(s).toString().split(" ");
                            date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                            setState(() {
                              _dtDateReturnEnd = s;
                              _currentDateReturnEnd = date;
                              editReturnDateEnd.text = _currentDateReturnEnd;
                            });
                          });
                        },
                        focusNode: myFocusNodeReturnDateEnd,
                        controller: editReturnDateEnd,
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
              "ผู้นำส่งคืน",
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
              "ค้นหางานคืนของกลาง",
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
