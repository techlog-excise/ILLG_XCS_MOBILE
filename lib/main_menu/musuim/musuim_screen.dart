import 'dart:async';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/musuim/model/approve.dart';
import 'package:prototype_app_pang/main_menu/musuim/model/musuim.dart';
import 'package:prototype_app_pang/main_menu/musuim/model/musuim_main.dart';
import 'package:prototype_app_pang/main_menu/musuim/musuim_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class MusuimMainScreenFragment extends StatefulWidget {
  ItemsMusuimMain ItemsmusuimMain;
  bool IsUpdate;
  bool IsPreview;
  bool IsCreate;
  MusuimMainScreenFragment({
    Key key,
    @required this.ItemsmusuimMain,
    @required this.IsUpdate,
    @required this.IsPreview,
    @required this.IsCreate,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

const double _kPickerSheetHeight = 216.0;

class _FragmentState extends State<MusuimMainScreenFragment> with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    // Choice(title: 'ข้อมูลจัดเก็บเข้าพิพิธภัณฑ์'),
    Choice(title: 'ข้อมูลจัดเก็บ'),
    Choice(title: 'ของกลาง'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  List<ItemsDestroyEvidence> itemEvidence = [];

  //item หลักทั้งหมด
  ItemsMusuimMain itemMain;

  //item forms
  List<ItemsDestroyForms> itemsFormsTab = [];

  //time
  DateTime offerTime = DateTime.now();
  DateTime considerTime = DateTime.now();
  DateTime destroyTime = DateTime.now();
  String _offertime, _considertime, _destroytime;

  //วันที่อละเวลาปัจจุบัน
  String _currentOfferDate, _currentConsiderDate, _currentDestroyDate, _currentOfferTime, _currentConsiderTime, _currentDestroyTime;
  var dateFormatDate, dateFormatTime, _dtOfferDate, _dtConsiderDate, _dtDestroyDate;

  //_dt
  DateTime _dtCheckEvidence = DateTime.now();

  //node focus ข้อมูลจัดเก็บเข้าพิพิธภัณฑ์
  final FocusNode myFocusNodeApproveNumber = FocusNode();
  final FocusNode myFocusNodeApproveYear = FocusNode();
  final FocusNode myFocusNodeOfferDate = FocusNode();
  final FocusNode myFocusNodeOfferTime = FocusNode();
  final FocusNode myFocusNodePersonProponent = FocusNode();
  final FocusNode myFocusNodeProponentDepartment = FocusNode();
  final FocusNode myFocusNodePersonConsider = FocusNode();
  final FocusNode myFocusNodeConsiderDepartment = FocusNode();
  final FocusNode myFocusNodeConsiderDate = FocusNode();
  final FocusNode myFocusNodeConsiderTime = FocusNode();
  final FocusNode myFocusNodeStock = FocusNode();

  //textfield ข้อมูลจัดเก็บเข้าพิพิธภัณฑ์
  TextEditingController editApproveNumber = new TextEditingController();
  TextEditingController editApproveYear = new TextEditingController();
  TextEditingController editOfferDate = new TextEditingController();
  TextEditingController editOfferTime = new TextEditingController();
  TextEditingController editPersonProponent = new TextEditingController();
  TextEditingController editProponentDepartment = new TextEditingController();
  TextEditingController editPersonConsider = new TextEditingController();
  TextEditingController editConsiderDepartment = new TextEditingController();
  TextEditingController editConsiderDate = new TextEditingController();
  TextEditingController editConsiderTime = new TextEditingController();
  TextEditingController editStock = new TextEditingController();

  //node focus ของกลาง
  final FocusNode myFocusNodeDesployNumber = FocusNode();
  final FocusNode myFocusNodeDesployDate = FocusNode();
  final FocusNode myFocusNodeDesployTime = FocusNode();
  final FocusNode myFocusNodeDesployPerson = FocusNode();

  //textfield ของกลาง
  TextEditingController editDesployNumber = new TextEditingController();
  TextEditingController editDesployDate = new TextEditingController();
  TextEditingController editDesployTime = new TextEditingController();
  TextEditingController editDesployPerson = new TextEditingController();

  //node focus ลบ
  final FocusNode myFocusNodeCommentDelete = FocusNode();

  //textfield ลบ
  TextEditingController editCommentDelete = new TextEditingController();

  //app bar
  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  TextStyle textDataTitleStyle = TextStyle(fontSize: 18.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataStyleSub = TextStyle(fontSize: 14.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textLabelDeleteStyle = TextStyle(fontSize: 16.0, color: Colors.red[200], fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSubCont = TextStyle(fontSize: 14.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2), fontFamily: FontStyles().FontFamily);
  TextStyle textStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = Styles.textStyleStar;
  TextStyle textLabelEditNonCheckStyle = TextStyle(fontSize: 16.0, color: Colors.red[100]);
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);

  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

  //paffing
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  EdgeInsets paddingInputBoxSub = EdgeInsets.only(top: 8.0, bottom: 8.0);

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

    _offertime = dateFormatTime.format(DateTime.now()).toString();
    _considertime = dateFormatTime.format(DateTime.now()).toString();
    _destroytime = dateFormatTime.format(DateTime.now()).toString();
    editOfferTime.text = _offertime;
    editOfferDate.text = date;
    editConsiderTime.text = _considertime;
    editConsiderDate.text = date;
    editDesployTime.text = _destroytime;
    editDesployDate.text = date;

    _dtOfferDate = DateTime.now();
    _currentOfferDate = date;
    _currentOfferTime = dateFormatTime.format(DateTime.now()).toString();

    _dtConsiderDate = DateTime.now();
    _currentConsiderDate = date;
    _currentConsiderTime = dateFormatTime.format(DateTime.now()).toString();

    _dtDestroyDate = DateTime.now();
    _currentDestroyDate = date;
    _currentDestroyTime = dateFormatTime.format(DateTime.now()).toString();

    itemMain = widget.ItemsmusuimMain;
    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsUpdate;
      _setDataSaved();
    }
    if (widget.IsUpdate) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
    }
  }

  void _setDataSaved() {
    _onFinish = true;
    if (choices.length == 2) {
      //เพิ่ม tab แบบฟอร์ม
      choices.add(Choice(title: 'แบบฟอร์ม'));
      //เพิ่ม item forms
      itemsFormsTab.add(new ItemsDestroyForms("บัญชีรายการจัดเก็บของกลางเข้าพิพิธภัณฑ์"));
    }
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
  }

  @override
  void dispose() {
    super.dispose();

    editApproveNumber.dispose();
    editApproveYear.dispose();
    editOfferTime.dispose();
    editPersonProponent.dispose();
    editProponentDepartment.dispose();
    editPersonConsider.dispose();
    editConsiderDepartment.dispose();
    editConsiderDate.dispose();
    editConsiderTime.dispose();
    editOfferDate.dispose();
    editStock.dispose();

    editDesployNumber.dispose();
    editDesployDate.dispose();
    editDesployTime.dispose();
    editDesployPerson.dispose();
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

  /*****************************method for main tab**************************/
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        //choices.removeAt(choices.length - 1);
      } else {
        _onDeleted = true;
        _showDeleteAlertDialog();
      }
    });
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoCancelDeleteDialog() {
    return new CupertinoAlertDialog(
        content: Card(
          color: Colors.transparent,
          elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text(
                  "เหตุผลการลบ.",
                  style: textLabelStyle,
                ),
              ),
              Container(
                padding: paddingInputBox,
                child: TextField(
                  maxLines: 5,
                  focusNode: myFocusNodeCommentDelete,
                  controller: editCommentDelete,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[500], width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400], width: 0.5),
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey.shade50),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                editCommentDelete.dispose();
              },
              child: new Text('ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _onSaved = false;
                  _onEdited = false;
                  _onSave = false;
                  clearTextfield();
                  choices.removeAt(choices.length - 1);
                  //Navigator.pop(context, itemMain);
                  Navigator.pop(context);
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  //แสดง dialog ลบรายการ
  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

  //ล้างข้อมูลใน text field
  void clearTextfield() {}

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน cancel dialog
  CupertinoAlertDialog _createCupertinoCancelAlertDialog(mContext) {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ยืนยันการยกเลิกข้อมูลทั้งหมด.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);

                if (!_onEdited) {
                  Navigator.pop(mContext, "Back");
                } else {
                  setState(() {
                    _onSaved = true;
                    _onEdited = false;
                  });
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  //แสดง dialog ยกเลิกรายการ
  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }

  //เมื่อกดปุ่มบันทึก
  void onSaved() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadAction();
    Navigator.pop(context);

    setState(() {
      //เมื่อกดบันทึก
      _onSaved = true;
      _onFinish = true;

      ItemsMusuimApprove approve = new ItemsMusuimApprove(editApproveNumber.text, editOfferDate.text, editOfferTime.text, editPersonProponent.text, editProponentDepartment.text, editPersonConsider.text, editConsiderDepartment.text, editConsiderDate.text, editConsiderTime.text, editStock.text);
      ItemsMusuim musuim = ItemsMusuim(editDesployNumber.text, editDesployDate.text, editDesployTime.text, editDesployPerson.text, itemEvidence);
      itemMain = new ItemsMusuimMain(approve, musuim, true);

      _setDataSaved();
      //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
      tabController.animateTo((choices.length - 1));
    });
  }

  //timing progress dialog
  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
    TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    TextStyle appBarStylePay = TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final List<Widget> rowContents = <Widget>[
    //   new SizedBox(
    //       width: width / 4,
    //       child: new Center(
    //         child: new FlatButton(
    //           onPressed: () {
    //             /* _onEdited ?
    //             setState(() {
    //               _onSave = false;
    //               _onEdited = false;
    //             }) :*/
    //             _onSaved ? Navigator.pop(context, itemMain) : _showCancelAlertDialog(context);
    //           },
    //           padding: EdgeInsets.all(10.0),
    //           child: new Row(
    //             children: <Widget>[
    //               new Icon(
    //                 Icons.arrow_back_ios,
    //                 color: Colors.white,
    //               ),
    //               !_onSaved
    //                   ? new Text(
    //                       "ยกเลิก",
    //                       style: appBarStyle,
    //                     )
    //                   : new Container(),
    //             ],
    //           ),
    //         ),
    //       )),
    //   Expanded(
    //       child: Center(
    //     child: Text("", style: appBarStyle),
    //   )),
    //   new SizedBox(
    //       width: width / 4,
    //       child: new Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: <Widget>[
    //           _onSaved
    //               ? (_onSave
    //                   ? new FlatButton(
    //                       onPressed: () {
    //                         setState(() {
    //                           _onSaved = true;
    //                           _onSave = false;
    //                           _onEdited = false;
    //                         });
    //                         //TabScreenArrest1().createAcceptAlert(context);
    //                       },
    //                       child: Text('บันทึก', style: appBarStyle))
    //                   : PopupMenuButton<Constants>(
    //                       onSelected: choiceAction,
    //                       icon: Icon(
    //                         Icons.more_vert,
    //                         color: Colors.white,
    //                       ),
    //                       itemBuilder: (BuildContext context) {
    //                         return constants.map((Constants contants) {
    //                           return PopupMenuItem<Constants>(
    //                             value: contants,
    //                             child: Row(
    //                               children: <Widget>[
    //                                 Padding(
    //                                   padding: EdgeInsets.only(right: 4.0),
    //                                   child: Icon(
    //                                     contants.icon,
    //                                     color: Colors.grey[400],
    //                                   ),
    //                                 ),
    //                                 Padding(
    //                                   padding: EdgeInsets.only(left: 4.0),
    //                                   child: Text(contants.text, style: TextStyle(fontFamily: FontStyles().FontFamily)),
    //                                 )
    //                               ],
    //                             ),
    //                           );
    //                         }).toList();
    //                       },
    //                     ))
    //               : new FlatButton(
    //                   onPressed: () {
    //                     onSaved();
    //                   },
    //                   child: Text('บันทึก', style: appBarStyle)),
    //         ],
    //       ))
    // ];
    final btnCancle = new FlatButton(
      onPressed: () {
        /* _onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :*/
        _onSaved ? Navigator.pop(context, itemMain) : _showCancelAlertDialog(context);
      },
      padding: EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          !_onSaved
              ? new Text(
                  "ยกเลิก",
                  style: appBarStyle,
                )
              : new Container(),
        ],
      ),
    );
    final List<Widget> btnSave = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _onSaved
              ? (_onSave
                  ? new FlatButton(
                      onPressed: () {
                        setState(() {
                          _onSaved = true;
                          _onSave = false;
                          _onEdited = false;
                        });
                        //TabScreenArrest1().createAcceptAlert(context);
                      },
                      child: Text('บันทึก', style: appBarStyle))
                  : PopupMenuButton<Constants>(
                      onSelected: choiceAction,
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      itemBuilder: (BuildContext context) {
                        return constants.map((Constants contants) {
                          return PopupMenuItem<Constants>(
                            value: contants,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Icon(
                                    contants.icon,
                                    color: Colors.grey[400],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(contants.text, style: TextStyle(fontFamily: FontStyles().FontFamily)),
                                )
                              ],
                            ),
                          );
                        }).toList();
                      },
                    ))
              : new FlatButton(
                  onPressed: () {
                    onSaved();
                  },
                  child: Text('บันทึก', style: appBarStyle)),
        ],
      )
    ];
    return WillPopScope(
        onWillPop: () {
          setState(() {
            if (_onSaved) {
              if (_onEdited) {
                _onEdited = false;
                _onSaved = false;
              } else {
                Navigator.pop(context);
                //Navigator.pop(context, itemMain);
              }
            } else {
              Navigator.pop(context);
              //Navigator.pop(context, itemMain);
            }
          });
        },
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    titleSpacing: 0.0,
                    floating: false,
                    pinned: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        btnCancle,
                        Expanded(
                          child: Center(
                              child: Text(
                            'จัดเก็บเข้าพิพิธภัณฑ์',
                            style: appBarStyle,
                          )),
                        )
                      ],
                    ),
                    actions: btnSave,
                    automaticallyImplyLeading: false, // ปิดปุ่มกลับที่เป็น default ใน header
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey[500],
                        labelStyle: tabStyle,
                        controller: tabController,
                        isScrollable: false,
                        tabs: choices.map((Choice choice) {
                          return Tab(
                            text: choice.title,
                          );
                        }).toList(),
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: Center(
                child: Stack(
                  children: <Widget>[
                    // BackgroundContent(),
                    TabBarView(
                      //physics: NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: _onFinish
                          ? <Widget>[
                              _buildContent_tab_1(),
                              _buildContent_tab_2(),
                              _buildContent_tab_3(),
                            ]
                          : <Widget>[
                              _buildContent_tab_1(),
                              _buildContent_tab_2(),
                            ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
        // child: Scaffold(
        //   body: CustomScrollView(
        //     //physics: NeverScrollableScrollPhysics(),
        //     slivers: <Widget>[
        //       SliverAppBar(
        //         floating: true,
        //         primary: true,
        //         pinned: false,
        //         title: Text(
        //           "จัดเก็บเข้าพิพิธภัณฑ์",
        //           style: appBarStyle,
        //         ),
        //         centerTitle: true,
        //         flexibleSpace: new BottomAppBar(
        //           elevation: 0.0,
        //           color: Color(0xff2e76bc),
        //           child: new Row(children: rowContents),
        //         ),
        //         automaticallyImplyLeading: false,
        //       ),
        //       SliverFillRemaining(
        //         child: Scaffold(
        //           appBar: PreferredSize(
        //             preferredSize: Size.fromHeight(140.0),
        //             child: TabBar(
        //               labelColor: Colors.black,
        //               unselectedLabelColor: Colors.grey[500],
        //               labelStyle: tabStyle,
        //               controller: tabController,
        //               isScrollable: false,
        //               tabs: choices.map((Choice choice) {
        //                 return Tab(
        //                   text: choice.title,
        //                 );
        //               }).toList(),
        //             ),
        //           ),
        //           body: TabBarView(
        //             //physics: NeverScrollableScrollPhysics(),
        //             controller: tabController,
        //             children: _onFinish
        //                 ? <Widget>[
        //                     _buildContent_tab_1(),
        //                     _buildContent_tab_2(),
        //                     _buildContent_tab_3(),
        //                   ]
        //                 : <Widget>[
        //                     _buildContent_tab_1(),
        //                     _buildContent_tab_2(),
        //                   ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }

  //************************start_tab_1*****************************
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

  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery.of(context).size;
      final double Width = (size.width * 85) / 100;

      Widget _buildLine = Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
        width: Width,
        height: 1.0,
        color: Colors.grey[300],
      );
      final focus = FocusNode();

      return Container(
        padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 0.0,
                  color: Colors.transparent,
                  child: Container(
                    width: Width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "เลขที่หนังสือ",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Padding(
                                  padding: paddingInputBox,
                                  child: new Text(
                                    "กค.",
                                    style: textLabelStyle,
                                  ),
                                ),
                                Container(
                                  width: ((size.width * 75) / 100) / 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeApproveNumber,
                                          controller: editApproveNumber,
                                          keyboardType: TextInputType.number,
                                          textCapitalization: TextCapitalization.words,
                                          style: textInputStyle,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                ),
                                new Padding(
                                  padding: paddingInputBox,
                                  child: new Text(
                                    "/",
                                    style: textInputStyle,
                                  ),
                                ),
                                Container(
                                  width: ((size.width * 75) / 100) / 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeApproveYear,
                                          controller: editApproveYear,
                                          keyboardType: TextInputType.number,
                                          textCapitalization: TextCapitalization.words,
                                          style: textInputStyle,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "ลงวันที่",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: paddingInputBox,
                              child: IgnorePointer(
                                ignoring: false,
                                child: TextField(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicDialog(Current: _dtOfferDate);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                                      setState(() {
                                        _dtOfferDate = s;
                                        _currentOfferDate = date;
                                        editOfferDate.text = _currentOfferDate;
                                      });
                                    });
                                  },
                                  focusNode: myFocusNodeOfferDate,
                                  controller: editOfferDate,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  style: textInputStyle,
                                  decoration: InputDecoration(border: InputBorder.none, suffixIcon: Icon(FontAwesomeIcons.calendarAlt)),
                                ),
                              )),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "เวลา",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeOfferTime,
                              controller: editOfferTime,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _buildBottomPicker(
                                      CupertinoDatePicker(
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: offerTime,
                                        onDateTimeChanged: (DateTime newDateTime) {
                                          setState(() {
                                            offerTime = newDateTime;
                                            _offertime = dateFormatTime.format(offerTime).toString();
                                            editOfferTime.text = _offertime;
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
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "ผู้เสนอพิจารณาเห็นชอบ",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodePersonProponent,
                              controller: editPersonProponent,
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
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "หน่วยงาน",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeProponentDepartment,
                              controller: editProponentDepartment,
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
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "พิจารณาวันที่",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: paddingInputBox,
                              child: IgnorePointer(
                                ignoring: false,
                                child: TextField(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicDialog(Current: _dtConsiderDate);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                                      setState(() {
                                        _dtConsiderDate = s;
                                        _currentConsiderDate = date;
                                        editConsiderDate.text = _currentConsiderDate;
                                      });
                                    });
                                  },
                                  focusNode: myFocusNodeConsiderDate,
                                  controller: editConsiderDate,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.words,
                                  style: textInputStyle,
                                  decoration: InputDecoration(border: InputBorder.none, suffixIcon: Icon(FontAwesomeIcons.calendarAlt)),
                                ),
                              )),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "เวลา",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: myFocusNodeConsiderTime,
                              controller: editConsiderTime,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _buildBottomPicker(
                                      CupertinoDatePicker(
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: considerTime,
                                        onDateTimeChanged: (DateTime newDateTime) {
                                          setState(() {
                                            considerTime = newDateTime;
                                            _considertime = dateFormatTime.format(considerTime).toString();
                                            editConsiderTime.text = _considertime;
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
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "ผู้พิจารณาเห็นชอบ",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              style: textInputStyle,
                              focusNode: myFocusNodePersonConsider,
                              controller: editPersonConsider,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "หน่วยงาน",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              style: textInputStyle,
                              focusNode: myFocusNodeConsiderDepartment,
                              controller: editConsiderDepartment,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "คลังจัดเก็บ",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              style: textInputStyle,
                              focusNode: myFocusNodeStock,
                              controller: editStock,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      return itemMain.Approves == null
          ? Container()
          : Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              padding: EdgeInsets.only(top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Card(
                    elevation: 0.0,
                    color: Colors.transparent,
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เลขที่หนังสือ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                itemMain.Approves.ApproveNumber,
                                style: textInputStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "ลงวันที่",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Approves.OfferDate + " " + itemMain.Approves.OfferTime,
                                style: textInputStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "ผู้เสนอพิจารณาเห็นชอบ",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Approves.PersonProponent,
                                style: textInputStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "หน่วยงาน",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Approves.ProponentDepartment,
                                style: textInputStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "พิจารณาวันที่",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                itemMain.Approves.ConsiderDate + " " + itemMain.Approves.ConsiderTime,
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "ผู้พิจารณาเห็นชอบ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                itemMain.Approves.PersonConsider,
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หน่วยงาน",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                itemMain.Approves.ConsiderDepartment,
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "คลังจัดเก็บ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                itemMain.Approves.Stock,
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              //height: 34.0,
              // decoration: BoxDecoration(
              //     color: Colors.grey[200],
              //     border: Border(
              //       //top: BorderSide(color: Colors.grey[300], width: 1.0),
              //       bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              //     )),
              /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text('ILG60_B_07_00_03_00',
                    style: textStylePageName,),
                )
              ],
            ),*/
              ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _onSaved ? _buildContent_saved(context) : _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_1*******************************

  //************************start_tab_2*****************************
  //รูปภาพ
  Future<File> _imageFile;
  List<File> _arrItemsImageFile = [];
  List<String> _arrItemsImageName = [];
  bool isImage = false;
  VoidCallback listener;

  //get file รูปภาพ
  Future getImage(ImageSource source, mContext) async {
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      _arrItemsImageName.add(splits[splits.length - 1]);
      _arrItemsImageFile.add(image);
    });
    Navigator.pop(mContext);
  }

  //แสดง popup ให้เลือกรูปจากกล้องหรทอแกลอรี่
  void _showDialogImagePicker() {
    showDialog(context: context, builder: (context) => _onTapImage(context)); // Call the Dialog.
  }

  _onTapImage(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                    size: 38.0,
                  ),
                ),
                onTap: () {
                  getImage(ImageSource.camera, context);
                },
              ),
              GestureDetector(
                child: Container(
                  width: width / 3,
                  height: height / 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Icon(
                    Icons.image,
                    color: Colors.blue,
                    size: 38.0,
                  ),
                ),
                onTap: () {
                  getImage(ImageSource.gallery, context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery.of(context).size;
    Color labelColor = Color(0xff087de1);
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    return Container(
      padding: EdgeInsets.only(top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Card(
              shape: new RoundedRectangleBorder(side: new BorderSide(color: boxColor, width: 1.5), borderRadius: BorderRadius.circular(42.0)),
              elevation: 0.0,
              child: Container(
                width: size.width / 2.2,
                child: MaterialButton(
                  onPressed: () {
                    _onSaved ? null : _showDialogImagePicker();
                  },
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.file_upload,
                              size: 22,
                              color: uploadColor,
                            ),
                          ),
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              "เลือกไฟล์/รูปภาพ",
                              style: textLabelStyle,
                            ),
                          ),
                        ],
                      )),
                ),
              )),
        ],
      ),
    );
  }

  navigateDeliveredBook(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MusuimBookSearchScreenFragment()),
    );
    if (result.toString() != "Back") {
      setState(() {
        ItemsDestroyEvidence item = result;
        itemEvidence.add(item);
        itemEvidence.forEach((item) {
          item.EvidenceDetailController.expController.expanded = true;
        });
      });
    }
  }

  Widget _buildButtonSelectEvidence() {
    var size = MediaQuery.of(context).size;
    Color labelColor = Color(0xff087de1);
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    return Container(
      padding: EdgeInsets.only(left: 18.0, top: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Card(
              shape: new RoundedRectangleBorder(side: new BorderSide(color: boxColor, width: 1.5), borderRadius: BorderRadius.circular(42.0)),
              elevation: 0.0,
              child: Container(
                width: size.width / 2.2,
                //padding: EdgeInsets.all(4.0),
                child: MaterialButton(
                  onPressed: () {
                    _onSaved ? null : navigateDeliveredBook(context);
                  },
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "เพิ่มของกลาง",
                              style: textLabelStyle,
                            ),
                          ),
                        ],
                      )),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildDataImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 22.0),
      child: ListView.builder(
          itemCount: _arrItemsImageFile.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(top: 0.1, bottom: 0.1),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )),
                child: ListTile(
                    leading: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: Colors.white30),
                      ),
                      //margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                      padding: const EdgeInsets.all(3.0),
                      child: Image.file(
                        _arrItemsImageFile[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      _arrItemsImageName[index],
                      style: textInputStyleTitle,
                    ),
                    trailing: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: !_onSaved
                            ? Icon(
                                Icons.delete_outline,
                                size: 32.0,
                              )
                            : Icon(null),
                        onPressed: () {
                          setState(() {
                            //print(index.toString());
                            _arrItemsImageFile.removeAt(index);
                            _arrItemsImageName.removeAt(index);
                            if (_arrItemsImageFile.length == 0) {
                              isImage = false;
                            }
                          });
                        },
                      ),
                    ),
                    onTap: () {
                      //
                    }),
              ),
            );
          }),
    );
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoDeleteEvidenceDialog(index) {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ยืนยันการลบข้อมูล.",
            style: TitleStyle,
          ),
        ),
        actions: <Widget>[
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  itemEvidence.removeAt(index);
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  //แสดง dialog ลบรายการ
  void _showDeleteEvidenceAlertDialog(index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDeleteEvidenceDialog(index);
      },
    );
  }

  Widget _buildContent_tab_2() {
    Widget _buildExpandableContent(int index) {
      var size = MediaQuery.of(context).size;
      Widget _buildExpanded(index) {
        itemEvidence[index].EvidenceDetailController.editDeliveredNumber.text = "22";
        itemEvidence[index].EvidenceDetailController.editTotalNumber.text = "22";
        itemEvidence[index].EvidenceDetailController.editDeliveredVolumn.text = "500";
        itemEvidence[index].EvidenceDetailController.editTotalVolumn.text = "500";
        itemEvidence[index].EvidenceDetailController.editTotalNumberUnit.text = "ขวด";
        itemEvidence[index].EvidenceDetailController.editTotalVolumnUnit.text = "ลิตร";
        return Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "เลขทะเบียนบัญชี",
                    style: textLabelStyle,
                  ),
                ),
                Container(
                  padding: paddingInputBox,
                  child: Text(
                    'Auto Gen',
                    style: textInputStyle,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ชื่อของกลาง",
                    style: textLabelStyle,
                  ),
                ),
                Container(
                  padding: paddingInputBox,
                  child: Text(
                    itemEvidence[index].ProductGroup + ' / ' + itemEvidence[index].MainBrand,
                    style: textInputStyle,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        width: ((size.width * 75) / 100) / 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "จำนวน",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: itemEvidence[index].EvidenceDetailController.myFocusNodeDeliveredNumber,
                                controller: itemEvidence[index].EvidenceDetailController.editDeliveredNumber,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        width: ((size.width * 75) / 100) / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "จำนวนจัดเก็บ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: itemEvidence[index].EvidenceDetailController.myFocusNodeDefectiveNumber,
                                controller: itemEvidence[index].EvidenceDetailController.editDefectiveNumber,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        width: ((size.width * 75) / 100) / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "จำนวนคงเหลือ",
                                style: textLabelStyle,
                              ),
                            ),
                            new IgnorePointer(
                              ignoring: true,
                              child: Padding(
                                padding: paddingInputBox,
                                child: TextField(
                                  focusNode: itemEvidence[index].EvidenceDetailController.myFocusNodeToalNumber,
                                  controller: itemEvidence[index].EvidenceDetailController.editTotalNumber,
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization.words,
                                  style: textInputStyle,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        width: ((size.width * 75) / 100) / 3.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หน่วย",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              //padding: paddingInputBox,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: itemEvidence[index].EvidenceDetailController.dropdownValueProductUnit,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      itemEvidence[index].EvidenceDetailController.dropdownValueProductUnit = newValue;
                                    });
                                  },
                                  items: itemEvidence[index].EvidenceDetailController.dropdownItemsProductUnit.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            widget.IsCreate
                ? Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                          padding: EdgeInsets.all(6.0),
                          child: InkWell(
                              onTap: () {
                                _showDeleteEvidenceAlertDialog(index);
                              },
                              child: Text(
                                "ลบ",
                                style: textLabelEditNonCheckStyle,
                              ))),
                    ),
                  )
                : Container()
          ],
        );
      }

      Widget _buildCollapsed(int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text(
                "เลขทะเบียนบัญชี",
                style: textLabelStyle,
              ),
            ),
            Container(
              padding: paddingInputBox,
              child: Text(
                'Auto Gen',
                style: textInputStyle,
              ),
            ),
            Container(
              padding: paddingLabel,
              child: Text(
                "ชื่อของกลาง",
                style: textLabelStyle,
              ),
            ),
            Container(
              padding: paddingInputBox,
              child: Text(
                itemEvidence[index].ProductGroup + ' / ' + itemEvidence[index].MainBrand,
                style: textInputStyle,
              ),
            ),
          ],
        );
      }

      return ExpandableNotifier(
        controller: itemEvidence[index].EvidenceDetailController.expController,
        child: Stack(
          children: <Widget>[
            Expandable(collapsed: _buildCollapsed(index), expanded: _buildExpanded(index)),
            Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    Builder(builder: (context) {
                      var exp = ExpandableController.of(context);
                      return IconButton(
                        icon: Icon(
                          exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          size: 24.0,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          exp.toggle();
                        },
                      );
                    }),
                  ],
                ))
          ],
        ),
      );
    }

    Widget _buildContent(BuildContext context) {
      var size = MediaQuery.of(context).size;
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 4.0),
          child: Column(
            children: <Widget>[
              Container(
                width: size.width,
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "เลขที่เก็บเข้าพิพิธภัณฑ์",
                        style: textLabelStyle,
                      ),
                    ),
                    Container(
                      padding: paddingInputBox,
                      child: Text(
                        "Auto Generate",
                        style: textInputStyle,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "วันที่จัดเก็บ",
                            style: textLabelStyle,
                          ),
                          Text(
                            "*",
                            style: textStyleStar,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: paddingInputBox,
                        child: IgnorePointer(
                          ignoring: false,
                          child: TextField(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DynamicDialog(Current: _dtDestroyDate);
                                  }).then((s) {
                                String date = "";
                                List splits = dateFormatDate.format(s).toString().split(" ");
                                date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                                setState(() {
                                  _dtDestroyDate = s;
                                  _currentDestroyDate = date;
                                  editDesployDate.text = _currentDestroyDate;
                                });
                              });
                            },
                            focusNode: myFocusNodeDesployDate,
                            controller: editDesployDate,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textInputStyle,
                            decoration: InputDecoration(border: InputBorder.none, suffixIcon: Icon(FontAwesomeIcons.calendarAlt)),
                          ),
                        )),
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "เวลา",
                            style: textLabelStyle,
                          ),
                          Text(
                            "*",
                            style: textStyleStar,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: paddingInputBox,
                      child: TextField(
                        focusNode: myFocusNodeDesployTime,
                        controller: editDesployTime,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        style: textInputStyle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onTap: () {
                          showCupertinoModalPopup<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return _buildBottomPicker(
                                CupertinoDatePicker(
                                  use24hFormat: true,
                                  mode: CupertinoDatePickerMode.time,
                                  initialDateTime: destroyTime,
                                  onDateTimeChanged: (DateTime newDateTime) {
                                    setState(() {
                                      destroyTime = newDateTime;
                                      _destroytime = dateFormatTime.format(destroyTime).toString();
                                      editDesployTime.text = _destroytime;
                                    });
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "ผู้จัดเก็บ",
                            style: textLabelStyle,
                          ),
                          Text(
                            "*",
                            style: textStyleStar,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeDesployPerson,
                              controller: editDesployPerson,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              itemEvidence.length > 0
                  ? Container(
                      width: size.width,
                      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: itemEvidence.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: size.width,
                              padding: EdgeInsets.all(22.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                  )),
                              child: Stack(
                                children: <Widget>[
                                  _buildExpandableContent(index),
                                ],
                              ));
                        },
                      ),
                    )
                  : Container(),
              /*itemMain.CheckEvidenceType == 1 && widget.IsCreate?
              Container(
                padding: EdgeInsets.only(left: 22.0, bottom: 22.0),
                child: _buildButtonImgPicker(),
              )
                  :*/
              Container(
                width: size.width,
                padding: EdgeInsets.only(top: 22.0, bottom: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[_buildButtonImgPicker(), _buildButtonSelectEvidence()],
                ),
              ),
              _buildDataImage(context),
            ],
          ),
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      TextStyle textStyleSentence = TextStyle(color: Color(0xff087de1));
      EdgeInsets paddindSentence = EdgeInsets.only(top: 8.0, bottom: 8.0, left: 14.0, right: 14.0);
      var size = MediaQuery.of(context).size;

      Widget _buildExpandableContent(int index) {
        var size = MediaQuery.of(context).size;
        EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
        Widget _buildExpanded(index) {
          return Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "เลขทะเบียนบัญชี",
                      style: textLabelStyle,
                    ),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Text(
                      'Auto Gen',
                      style: textInputStyle,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ชื่อของกลาง",
                      style: textLabelStyle,
                    ),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Text(
                      itemMain.Musuims.Evidences[index].ProductGroup + ' / ' + itemMain.Musuims.Evidences[index].MainBrand,
                      style: textInputStyle,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          width: ((size.width * 75) / 100) / 3.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "จำนวน",
                                  style: textLabelStyle,
                                ),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text(
                                  '3',
                                  style: textInputStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          width: ((size.width * 75) / 100) / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "จำนวนจัดเก็บ",
                                  style: textLabelStyle,
                                ),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text(
                                  '2',
                                  style: textInputStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          width: ((size.width * 75) / 100) / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "จำนวนคงเหลือ",
                                  style: textLabelStyle,
                                ),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text(
                                  '1',
                                  style: textInputStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          width: ((size.width * 75) / 100) / 3.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "หน่วย",
                                  style: textLabelStyle,
                                ),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text(
                                  'ขวด',
                                  style: textInputStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        }

        Widget _buildCollapsed(int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  "เลขทะเบียนบัญชี",
                  style: textLabelStyle,
                ),
              ),
              Container(
                padding: paddingInputBox,
                child: Text(
                  'Auto Gen',
                  style: textInputStyle,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ชื่อของกลาง",
                  style: textLabelStyle,
                ),
              ),
              Container(
                padding: paddingInputBox,
                child: Text(
                  itemMain.Musuims.Evidences[index].ProductGroup + ' / ' + itemMain.Musuims.Evidences[index].MainBrand,
                  style: textInputStyle,
                ),
              ),
            ],
          );
        }

        return ExpandableNotifier(
          controller: itemMain.Musuims.Evidences[index].EvidenceDetailController.expController,
          child: Stack(
            children: <Widget>[
              Expandable(collapsed: _buildCollapsed(index), expanded: _buildExpanded(index)),
              Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    children: <Widget>[
                      Builder(builder: (context) {
                        var exp = ExpandableController.of(context);
                        return IconButton(
                          icon: Icon(
                            exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            size: 24.0,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            exp.toggle();
                          },
                        );
                      }),
                    ],
                  ))
            ],
          ),
        );
      }

      return SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Column(
          children: <Widget>[
            Container(
              width: size.width,
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "เลขที่เก็บเข้าพิพิธภัณฑ์",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      itemMain.Musuims.MusuimNumber,
                      style: textInputStyle,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "วันที่จัดเก็บ",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      itemMain.Musuims.MusuimDate + " " + itemMain.Musuims.MusuimTime,
                      style: textInputStyle,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ผู้จัดเก็บ",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      itemMain.Musuims.MusuimPerson,
                      style: textInputStyle,
                    ),
                  ),
                ],
              ),
            ),
            itemMain.Musuims.Evidences.length > 0
                ? Container(
                    width: size.width,
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: itemMain.Musuims.Evidences.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: size.width,
                            padding: EdgeInsets.all(22.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                )),
                            child: Stack(
                              children: <Widget>[
                                _buildExpandableContent(index),
                              ],
                            ));
                      },
                    ),
                  )
                : Container(),
            Container(
              padding: EdgeInsets.only(left: 22.0, bottom: 22.0),
              child: _buildButtonImgPicker(),
            ),
            _buildDataImage(context),
          ],
        ),
      ));
    }

    //data result when search data
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  //height: 34.0,
                  // decoration: BoxDecoration(
                  //     color: Colors.grey[200],
                  //     border: Border(
                  //       //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  //       bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  //     )),
                  /* child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_07_00_04_00', style: textStylePageName,),
                    )
                  ],
                ),*/
                  ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _onSaved ? _buildContent_saved(context) : _buildContent(context),
                ),
              ),
            ],
          ),
        ));
  }

//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            itemCount: itemsFormsTab.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                  child: ListTile(
                      leading: Padding(
                        padding: paddingLabel,
                        child: Text(
                          (index + 1).toString() + '. ',
                          style: textInputStyleTitle,
                        ),
                      ),
                      title: Padding(
                        padding: paddingLabel,
                        child: Text(
                          itemsFormsTab[index].FormsName,
                          style: textInputStyleTitle,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[300],
                        size: 18.0,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TabScreenArrest8Dowload(
                                Title: itemsFormsTab[index].FormsName,
                              ),
                            ));
                      }),
                ),
              );
            }),
      );
    }

    //data result when search data
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                //height: 34.0,
                // decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     border: Border(
                //       //top: BorderSide(color: Colors.grey[300], width: 1.0),
                //       bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                //     )),
                /*child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(
                      'ILG60_B_07_00_07_00', style: textStylePageName,),
                  )
                ],
              ),*/
                ),
            Expanded(
              child: new ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: SingleChildScrollView(
                  child: _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//************************end_tab_3*******************************
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      decoration: BoxDecoration(
          //This is for background color
          color: Color.fromRGBO(250, 250, 250, 1.0),
          //This is for bottom border that is needed
          border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0))),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return _tabBar != oldDelegate._tabBar;
  }
}
