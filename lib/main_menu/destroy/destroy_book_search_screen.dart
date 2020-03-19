import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io' show Platform;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/destroy/select_book_select_evidence_screen.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/manage_evidence_future/manage_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_inventory_list.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:intl/intl.dart';

const double _kPickerSheetHeight = 216.0;

class DestroyBookSearchScreenFragment extends StatefulWidget {
  bool IsUpdate;
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  List<EvidenceInventoryList> itemsEvidenceItem;
  bool IsTransferScreen;
  DestroyBookSearchScreenFragment({
    Key key,
    @required this.IsUpdate,
    @required this.ItemsPerson,
    @required this.itemsEvidenceItem,
    @required this.IsTransferScreen,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<DestroyBookSearchScreenFragment> {
  final FocusNode myFocusNodeLawsuit = FocusNode();
  final FocusNode myFocusNodeLawsuitYear = FocusNode();
  final FocusNode myFocusNodeLawsuitDateStart = FocusNode();
  final FocusNode myFocusNodeLawsuitDateEnd = FocusNode();

  //textfield
  TextEditingController editLawsuit = new TextEditingController();
  TextEditingController editLawsuitYear = new TextEditingController();
  TextEditingController editLawsuitDateStart = new TextEditingController();
  TextEditingController editLawsuitDateEnd = new TextEditingController();
  bool IsLawsuitType1 = true;
  bool IsLawsuitType2 = false;

  String _currentDateLawsuitStart, _currentDateLawsuitEnd;
  DateTime _dtDateLawsuitStart, _dtDateLawsuitEnd;
  var dateFormatDate;

  DateTime _dtMaxDate;

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    var formatter = new DateFormat('yyyy');
    String year = formatter.format(DateTime.now());
    editLawsuitYear.text = (int.parse(year) + 543).toString();

    dateFormatDate = new DateFormat.yMMMMd('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

    // String date = "";
    _currentDateLawsuitStart = date;
    _currentDateLawsuitEnd = date;

    _dtDateLawsuitStart = DateTime.now();
    _dtDateLawsuitEnd = DateTime.now();

    _dtMaxDate = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
    editLawsuit.dispose();
    editLawsuitYear.dispose();
    editLawsuitDateStart.dispose();
    editLawsuitDateEnd.dispose();
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
                _buildInput(), //
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
                                if (editLawsuit.text.isEmpty || editLawsuitYear.text.isEmpty) {
                                  new VerifyDialog(context, 'กรุณากรอกเลขที่รับคำกล่าวโทษ');
                                } else {
                                  _navigate(context);
                                }
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
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "ลักษณะคดี",
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
                          IsLawsuitType1 = true;
                          IsLawsuitType2 = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: IsLawsuitType1 ? Color(0xff3b69f3) : Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: IsLawsuitType1
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
                        'คดีนอกสถานที่',
                        style: textStyleSelect,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  width: size.width / 2.4,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                            IsLawsuitType2 = true;
                            IsLawsuitType1 = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: IsLawsuitType2 ? Color(0xff3b69f3) : Colors.white,
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: IsLawsuitType2
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
                          'คดีในสถานที่',
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
                      focusNode: myFocusNodeLawsuit,
                      controller: editLawsuit,
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
// ********************** เลขที่นำส่งของกลาง **********************
        Container(
          padding: paddingLabel,
          child: Text(
            "เลขที่นำส่งของกลาง",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            // focusNode: myFocusNodeLawsuitYear,
            // controller: editLawsuitYear,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
// ********************** ส่วนวันที่รับคดี / ถึงวันที่ **********************
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
                      "วันรับคดี",
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
                                    log("editLawsuitDateEnd, $editLawsuitDateEnd.text");
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
      ],
    );
  }

  List<EvidenceInventoryList> itemsEvidenceItem = [];
  Future<bool> onLoadAction(Map map) async {
    await new ManageEvidenceFuture().apiRequestEvidenceInventoryListgetByLawsuitNo(map).then((onValue) {
      print(onValue);
      itemsEvidenceItem = onValue;
    });
    itemsEvidenceItem.forEach((item) {
      /*for(int i=0;i<widget.itemsEvidenceItem.length;i++){
        if(item.EVIDENCE_IN_ITEM_CODE.trim().endsWith(widget.itemsEvidenceItem[i].EVIDENCE_IN_ITEM_CODE)){
          item.IsCkecked=true;
          break;
        }
      }*/
      if (item == null) {
        itemsEvidenceItem = [];
      } else {
        item.LAWSUIT_NO = map['LAWSUIT_NO'];
        item.LAWSUIT_NO_YEAR = map['LAWSUIT_NO_YEAR'].toString();
        item.IS_OUTSIDE = map['IS_OUTSIDE'];
        // item.LAWSUIT_DATE_START = map['LAWSUIT_DATE_START'];
        // item.LAWSUIT_DATE_END = map['LAWSUIT_DATE_END'];
      }
    });

    setState(() {});
    return true;
  }

  _navigate(BuildContext context) async {
    Map map = {
      "IS_OUTSIDE": IsLawsuitType1 ? 1 : 0, // 0 ในสถานที่ || 1 นอกสถานที่
      "LAWSUIT_NO": editLawsuit.text, // เลขที่นำส่งของกลาง
      "LAWSUIT_NO_YEAR": editLawsuitYear.text.isNotEmpty ? (int.parse(editLawsuitYear.text) > 543 ? int.parse(editLawsuitYear.text) - 543 : "") : "",
      // "TRANSFER_NO": "",
      // "LAWSUIT_DATE_START": editLawsuitDateStart.text,
      // "LAWSUIT_DATE_END": editLawsuitDateEnd.text, // editLawsuitDateEnd.text === 17 ธันวาคม 2562
      "OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE //"090601"
    };
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

    if (itemsEvidenceItem.length > 0) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectDestroyBookScreenFragment(
                  itemsEvidenceItem: itemsEvidenceItem,
                  IsUpdate: widget.IsUpdate,
                )),
      );
      if (result.toString() != "Back") {
        Navigator.pop(context, result);
      }
    } else {
      new EmptyDialog(context, "ไม่พบข้อมูล.");
    }
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
                widget.IsTransferScreen ? "ค้นหาของกลาง" : "ค้นหาเลขที่รับคำกล่าวโทษ",
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
                        child: new Text('ILG60_B_09_00_05_00',
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
