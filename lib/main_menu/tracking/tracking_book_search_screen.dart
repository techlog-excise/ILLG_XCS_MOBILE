import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/tracking/tracking_search_screen_2_result.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'model/data_api/tracking_list.dart';
import 'model/future/tracking_future.dart';

const double _kPickerSheetHeight = 216.0;

class TrackingBookSearchScreenFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  TrackingBookSearchScreenFragment({
    Key key,
    @required this.ItemsPerson,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<TrackingBookSearchScreenFragment> {
  final FocusNode myFocusNodeArrestDate = FocusNode();
  final FocusNode myFocusNodeArrestNumber = FocusNode();
  final FocusNode myFocusNodeLawsuitNumber = FocusNode();
  final FocusNode myFocusNodeLawsuitYear = FocusNode();
  final FocusNode myFocusNodeLawBreaker = FocusNode();

  TextEditingController editArrestDate = new TextEditingController();
  TextEditingController editArrestNumber = new TextEditingController();
  TextEditingController editLawsuitNumber = new TextEditingController();
  TextEditingController editLawsuitYear = new TextEditingController();
  TextEditingController editLawBreaker = new TextEditingController();

  String _currentArrestDate;
  DateTime _dtArrestDate;
  var dateFormatDate;

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    _dtArrestDate = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
    editArrestDate.dispose();
    editArrestNumber.dispose();
    editLawsuitNumber.dispose();
    editLawBreaker.dispose();
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
                                _navigate(context);
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
            "วันที่จับกุม",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeArrestDate,
            controller: editArrestDate,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(border: InputBorder.none, suffixIcon: Icon(FontAwesomeIcons.calendarAlt)),
            enableInteractiveSelection: false,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
              /*showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DynamicDialog(Current: _dtArrestDate);
                  }).then((s) {
                String date = "";
                List splits = dateFormatDate.format(s).toString().split(" ");
                date = splits[0] +
                    " " +
                    splits[1] +
                    " " +
                    (int.parse(splits[3]) + 543).toString();
                setState(() {
                  _dtArrestDate = s;
                  _currentArrestDate = date;
                  editArrestDate.text = _currentArrestDate;
                });
              });*/

              showCupertinoModalPopup<void>(
                context: context,
                builder: (BuildContext context) {
                  return _buildBottomPicker(
                    CupertinoDatePicker(
                      maximumDate: DateTime.now(),
                      maximumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) + 1,
                      minimumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) - 1,
                      mode: CupertinoDatePickerMode.date,
                      initialDateTime: _dtArrestDate,
                      onDateTimeChanged: (DateTime s) {
                        setState(() {
                          String date = "";
                          List splits = dateFormatDate.format(s).toString().split(" ");
                          date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                          _dtArrestDate = s;
                          _currentArrestDate = date;
                          editArrestDate.text = _currentArrestDate;
                        });
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        _buildLine,
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
            focusNode: myFocusNodeArrestNumber,
            controller: editArrestNumber,
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
                  Padding(
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
            focusNode: myFocusNodeLawBreaker,
            controller: editLawBreaker,
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
    );
  }

  List<ItemsTrackingList> _searchResult = [];
  //on show dialog
  Future<bool> onLoadAction(Map map) async {
    await new TrackingFuture().apiCaseStatusListgetByConAdv(map).then((onValue) {
      List<ItemsTrackingList> items = [];
      onValue.CASE_STATUS_LIST.forEach((item) {
        if (item.CASE_STATUS != null) {
          items.add(item);
        }
      });
      _searchResult = items;
    });
    setState(() {});
    return true;
  }

  _navigate(BuildContext context) async {
    Map map = {
      "ARREST_CODE": editArrestNumber.text,
      "OCCURRENCE_DATE_FROM": editArrestDate.text.isEmpty ? "" : _dtArrestDate.toString(),
      "OCCURRENCE_DATE_TO": editArrestDate.text.isEmpty ? "" : _dtArrestDate.toString(),
      "ARREST_LAWBREAKER_NAME": editLawBreaker.text,
      "LAWSUIT_NO": editLawsuitNumber.text,
      "LAWSUIT_NO_YEAR": editLawsuitYear.text.isNotEmpty ? (int.parse(editLawsuitYear.text) > 543 ? int.parse(editLawsuitYear.text) - 543 : "") : "",
      "ACCOUNT_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE
    };

    print(map);

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

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackingMainScreenFragmentSearchResult(ItemSearch: _searchResult),
        ));
    if (result.toString() != "Back") {
      Navigator.pop(context, result);
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
                "ค้นหาคดี",
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
                        child: new Text('ILG60_B_13_00_02_00',
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
