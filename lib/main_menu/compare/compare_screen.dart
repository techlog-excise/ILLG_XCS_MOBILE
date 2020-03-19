import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_division_rate.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_product.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_detail_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_reward_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_signature.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_form_list.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_indicment_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';
import 'package:prototype_app_pang/zan/future/person_net_future.dart';
import 'package:prototype_app_pang/zan/model/person_net_main.dart';
import 'compare_pernalty.dart';
import 'future/compare_future.dart';
import 'model/compare_detail.dart';
import 'model/compare_guiltbase_fine.dart';
import 'model/compare_list.dart';
import 'model/compare_mistreat.dart';
import 'model/compare_notice.dart';

class CompareMainScreenFragment extends StatefulWidget {
  ItemsCompareMain itemsCompareMain;
  ItemsCompareArrestMain itemsCompareArrestMain;
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsListDivisionRate itemsListDivisionRate;
  Map mapSearch;
  bool IsPreview;
  bool IsEdit;
  bool IsCreate;
  int typeItem;
  CompareMainScreenFragment({
    Key key,
    @required this.itemsListDivisionRate,
    @required this.itemsCompareMain,
    @required this.itemsCompareArrestMain,
    @required this.ItemsPerson,
    @required this.mapSearch,
    @required this.IsEdit,
    @required this.IsPreview,
    @required this.IsCreate,
    @required this.typeItem,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<CompareMainScreenFragment> with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ชำระค่าปรับ'),
    Choice(title: 'ข้อมูลคดี'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  //item หลักทั้งหมด
  ItemsCompareMain itemMain;

  ItemsCompareArrestMain _compareArrestMain;

  ItemsCompareGuiltbaseFine itemGuiltbaseFine;
  //item forms
  List<ItemsCompareForms> itemsFormsTab = [];

  //วันที่อละเวลาปัจจุบัน
  String _currentProveDate, _currentProveTime;
  var dateFormatDate, dateFormatTime;
  //_dt
  DateTime _dtCheckEvidence = DateTime.now();
  //node focus ตรวจรับของกลาง
  final FocusNode myFocusNodeCheckEvidenceNumber = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceYear = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePlace = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePersonName = FocusNode();
  //textfield ตรวจรับของกลาง
  TextEditingController editCheckEvidenceNumber = new TextEditingController();
  TextEditingController editCheckEvidenceYear = new TextEditingController();
  TextEditingController editCheckEvidencePlace = new TextEditingController();
  TextEditingController editCheckEvidencePersonName = new TextEditingController();

  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 16.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  TextStyle textStyleLabel1 = Styles.textStyleLabel;
  TextStyle textStyleLabel = TextStyle(fontSize: 16, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textDataTitleStyle = TextStyle(fontSize: 18, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle textStyleBill = TextStyle(color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButtonAccept = TextStyle(fontSize: 16, color: Colors.white, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  TextStyle textStyleTitleLabel = TextStyle(fontSize: 16, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleTitleData = TextStyle(fontSize: 18, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2), fontFamily: FontStyles().FontFamily);

  @override
  void initState() {
    super.initState();

    _compareArrestMain = widget.itemsCompareArrestMain;

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    //วันและเวลาตรวจสอบของกลาง
    _currentProveDate = date;
    _currentProveTime = dateFormatTime.format(DateTime.now()).toString();

    if (widget.IsPreview) {
      print(widget.itemsCompareMain.toString());
      itemMain = widget.itemsCompareMain;

      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsEdit;
      _setInitDataProve();
      _setDataSaved();
    }
    if (widget.IsEdit) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      //_onEdited = widget.IsEdit;
      _setInitDataProve();
    }

    _compareArrestMain = widget.itemsCompareArrestMain;
  }

  String _checkType(int type) {
    String result;
    if (type == 1) {
      result = "น. ";
    } else {
      result = '';
    }
    return result;
  }

  void _setInitDataProve() {
    //tab 2
    /* editCheckEvidenceNumber.text = itemMain.CheckEvidence.Number;
    editCheckEvidenceYear.text = itemMain.CheckEvidence.Year;
    editCheckEvidencePlace.text = itemMain.CheckEvidence.Place;
    editCheckEvidencePersonName.text = itemMain.CheckEvidence.Person;
    _currentProveDate=itemMain.CheckEvidence.Date;
    _currentProveTime=itemMain.CheckEvidence.Time;*/
  }

  void _setDataSaved() {
    choices[0].title = "ข้อมูลชำระค่าปรับ";
    _onFinish = true;

    if (choices.length == 2) {
      itemsFormsTab = [];
      //เพิ่ม tab แบบฟอร์ม
      choices.add(Choice(title: 'แบบฟอร์ม'));
      //เพิ่ม item forms
      itemsFormsTab.add(new ItemsCompareForms("แบบฟอร์มบันทึกการเปรียบเทียบคดี 2/52", "", "ILG60_00_06_003", null));
      itemsFormsTab.add(new ItemsCompareForms("แบบฟอร์มคำให้การของผู้ต้องหา 2/53", "", "ILG60_00_06_001", null)); //ILG60_00_06_001
      itemsFormsTab.add(new ItemsCompareForms("คำร้องขอให้เปรียบเทียบคดี คด.1", "", "ILG60_00_06_004", null));
      itemsFormsTab.add(new ItemsCompareForms("เเบบฟอร์มคำให้การของผู้กล่าวโทษ 2/54", "", "ILG60_00_04_002", null));

      itemMain.CompareMapping.forEach((mapp) {
        for (int i = 0; i < _compareArrestMain.CompareArrestIndictmentDetail.length; i++) {
          if (mapp.INDICTMENT_DETAIL_ID == _compareArrestMain.CompareArrestIndictmentDetail[i].INDICTMENT_DETAIL_ID) {
            if (mapp.CompareDetail.length > 0) {
              itemsFormsTab.add(new ItemsCompareForms(
                  "ใบเสร็จรับเงิน",
                  _compareArrestMain.CompareArrestIndictmentDetail[i].TITLE_SHORT_NAME_TH.toString() + _compareArrestMain.CompareArrestIndictmentDetail[i].FIRST_NAME.toString() + " " + _compareArrestMain.CompareArrestIndictmentDetail[i].LAST_NAME.toString(),
                  "ILG60_00_06_002",
                  // mapp.CompareDetail.first.RECEIPT_NO.toString(),
                  mapp.CompareDetail.first.COMPARE_DETAIL_ID));
            }
          }
        }
      });
    } else if (choices.length == 3) {
      itemsFormsTab = [];
      //เพิ่ม item forms
      itemsFormsTab.add(new ItemsCompareForms("แบบฟอร์มบันทึกการเปรียบเทียบคดี 2/52", "", "ILG60_00_06_003", null));
      itemsFormsTab.add(new ItemsCompareForms("แบบฟอร์มคำให้การของผู้ต้องหา 2/53", "", "ILG60_00_06_001", null)); //ILG60_00_06_001
      itemsFormsTab.add(new ItemsCompareForms("คำร้องขอให้เปรียบเทียบคดี คด.1", "", "ILG60_00_06_004", null));
      itemsFormsTab.add(new ItemsCompareForms("เเบบฟอร์มคำให้การของผู้กล่าวโทษ 2/54", "", "ILG60_00_04_002", null));

      itemMain.CompareMapping.forEach((mapp) {
        for (int i = 0; i < _compareArrestMain.CompareArrestIndictmentDetail.length; i++) {
          if (mapp.INDICTMENT_DETAIL_ID == _compareArrestMain.CompareArrestIndictmentDetail[i].INDICTMENT_DETAIL_ID) {
            if (mapp.CompareDetail.length > 0) {
              itemsFormsTab.add(new ItemsCompareForms(
                  "ใบเสร็จรับเงิน",
                  _compareArrestMain.CompareArrestIndictmentDetail[i].TITLE_SHORT_NAME_TH.toString() + _compareArrestMain.CompareArrestIndictmentDetail[i].FIRST_NAME.toString() + " " + _compareArrestMain.CompareArrestIndictmentDetail[i].LAST_NAME.toString(),
                  "ILG60_00_06_002",
                  // mapp.CompareDetail.first.RECEIPT_NO.toString(),
                  mapp.CompareDetail.first.COMPARE_DETAIL_ID));
            }
          }
        }
      });
    }

    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
    //tabController.animateTo(tabController);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    //dismiss textfield for tab 2
    editCheckEvidenceNumber.dispose();
    editCheckEvidenceYear.dispose();
    editCheckEvidencePlace.dispose();
    editCheckEvidencePersonName.dispose();
  }

  /*****************************method for main tab**************************/
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        choices.removeAt(choices.length - 1);
      } else {
        _onDeleted = true;
        _showDeleteAlertDialog();
      }
    });
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoCancelDeleteDialog() {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ยืนยันการลบข้อมูลทั้งหมด.",
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
                  _onSaved = false;
                  _onEdited = false;
                  _onSave = false;
                  clearTextfield();
                  choices.removeAt(choices.length - 1);

                  Navigator.pop(context, itemMain);
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
        barrierDismissible: false,
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

      //

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

  List<ItemsCompareList> _searchResult = [];
  Future<bool> onLoadActionGetList(Map map) async {
    await new CompareFuture().apiRequestCompareListgetByConAdv(map).then((onValue) {
      _searchResult = onValue;
      print(onValue.length);
    });
    setState(() {});
    return true;
  }

  _navigatBack(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionGetList(widget.mapSearch);
    Navigator.pop(context);
    Navigator.pop(context, _searchResult);
  }

  @override
  Widget build(BuildContext context) {
    final btnCancle = new FlatButton(
        onPressed: () {
          /*if(_onSaved) {
                      Navigator.pop(context, "Back");
                    }else{
                      _showCancelAlertDialog(context);
                    }*/
          if (widget.IsPreview) {
            //_navigatBack(context);
            print(itemMain.toString());
            if (itemMain == null) {
              Navigator.pop(context, "Delete");
            } else {
              Navigator.pop(context, "Back");
            }
          } else {
            Navigator.pop(context, "Back");
          }
        },
        padding: EdgeInsets.all(10.0),
        child: new Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ));

    return WillPopScope(
        onWillPop: () {
          setState(() {
            if (_onSaved) {
              if (_onEdited) {
                _onEdited = false;
                _onSaved = false;
              } else {
                Navigator.pop(context, itemMain);
              }
            } else {
              Navigator.pop(context, itemMain);
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
                    centerTitle: true,
                    title: Text(
                      'เปรียบเทียบและชำระค่าปรับ',
                      style: appBarStyle,
                    ),
                    leading: btnCancle,
                    automaticallyImplyLeading: false, // ปิดปุ่มกลับที่เป็น default ใน header
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey[500],
                        labelStyle: tabStyle,
                        controller: tabController,
                        isScrollable: choices.length > 2 ? true : false,
                        tabs: choices.map((Choice choice) {
                          return choices.length > 2
                              ? Padding(
                                  padding: EdgeInsets.only(left: 8, right: 8),
                                  child: Tab(
                                    text: choice.title,
                                  ),
                                )
                              : Tab(
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
                    BackgroundContent(),
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
        //     physics: NeverScrollableScrollPhysics(),
        //     slivers: <Widget>[
        //       SliverAppBar(
        //         centerTitle: true,
        //         title: new Text("เปรียบเทียบและชำระค่าปรับ",
        //           style: appBarStyle,
        //         ),
        //         elevation: 0.0,
        //         leading: IconButton(
        //             icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        //             onPressed: () {
        //               /*if(_onSaved) {
        //                 Navigator.pop(context, "Back");
        //               }else{
        //                 _showCancelAlertDialog(context);
        //               }*/
        //               if(widget.IsPreview){
        //                 //_navigatBack(context);
        //                 print(itemMain.toString());
        //                 if(itemMain==null){
        //                   Navigator.pop(context, "Delete");
        //                 }else{
        //                   Navigator.pop(context, "Back");
        //                 }
        //               }else{
        //                 Navigator.pop(context, "Back");
        //               }

        //             }),
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
        //               isScrollable: choices.length>2?true:false,
        //               tabs: choices.map((Choice choice) {
        //                 return choices.length > 2
        //                     ? Padding(
        //                   padding: EdgeInsets.only(left: 8, right: 8),
        //                   child: Tab(
        //                     text: choice.title,
        //                   ),
        //                 )
        //                     : Tab(
        //                   text: choice.title,
        //                 );
        //               }).toList(),
        //             ),
        //           ),
        //           body: Stack(
        //             children: <Widget>[
        //               BackgroundContent(),
        //               TabBarView(
        //                 //physics: NeverScrollableScrollPhysics(),
        //                 controller: tabController,
        //                 children: _onFinish ? <Widget>[
        //                   _buildContent_tab_1(),
        //                   _buildContent_tab_2(),
        //                   _buildContent_tab_3(),
        //                 ] :
        //                 <Widget>[
        //                   _buildContent_tab_1(),
        //                   _buildContent_tab_2(),
        //                 ],
        //               ),

        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }

  //************************start_tab_1*******************************
  List<ItemsListDocument> itemsDocument = [];
  ItemsCompareMistreat MISTREAT;
  List<ItemsCompareNotice> itemsCompareNotice = [];
  //on show dialog
  Future<bool> onLoadActionGetDocument() async {
    Map map = {"DOCUMENT_TYPE": 6, "REFERENCE_CODE": itemMain.COMPARE_ID};

    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((item) {
        if (int.parse(item.IS_ACTIVE) == 1) {
          items.add(item);
        }
      });
      itemsDocument = items;
    });

    Map map_mist = {"PERSON_ID": 11, "SUBSECTION_ID": 279};

    await new CompareFuture().apiRequestCompareCountMistreatgetByCon(map_mist).then((onValue) {
      MISTREAT = onValue;
    });

    map = {"ARREST_ID": _compareArrestMain.ARREST_ID};
    await new CompareFuture().apiRequestCompareNoticegetByArrestID(map).then((onValue) {
      itemsCompareNotice = onValue;
    });

    setState(() {});
    return true;
  }

  _navigate(BuildContext context, String law_name, ItemsCompareListIndicmentDetail indicmentDetail, bool IsCreate, bool IsPreview, double fine_value) async {
    if (IsCreate) {
      indicmentDetail.IsDetailFineComplete = false;
    }

    if (IsPreview) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          });
      await onLoadActionGetDocument();
      Navigator.pop(context);
    }

    if (itemGuiltbaseFine != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompareDetailScreenFragment(
                  Title: law_name,
                  itemsCompareGuiltbaseFine: itemGuiltbaseFine,
                  itemsListDivisionRate: widget.itemsListDivisionRate,
                  ItemsPerson: widget.ItemsPerson,
                  itemsCompareMain: itemMain,
                  itemsCompareArrestMain: widget.itemsCompareArrestMain,
                  itemsCompareListIndicmentDetail: indicmentDetail,
                  IsHaveProve: itemMain != null ? true : false,
                  ItemsDocument: itemsDocument,
                  itemsCompareNotice: itemsCompareNotice,
                  IsCreate: IsCreate,
                  IsPreview: IsPreview,
                  FINE_VALUE: fine_value,
                )),
      );
      if (result.toString() != "Back") {
        setState(() {
          itemMain = result;
          print('this');
          if (itemMain != null) {
            print('this B');
            _setDataSaved();
          }
        });
      }
    } else {
      new EmptyDialog(context, "ไม่มีข้อมูลฐานความผิด");
    }
  }

  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      //style content
      var size = MediaQuery.of(context).size;
      // ถ้าเปิดมันจะ scroll ไม่ได้
      // if (itemMain != null) {
      //   _setDataSaved();
      // }
      return SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Column(
          children: <Widget>[
            itemMain != null
                ? Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      padding: EdgeInsets.all(22.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Container(
                              width: size.width,
                              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "คดีเปรียบเทียบที่",
                                    style: textStyleTitleLabel,
                                  ),
                                ),
                                Padding(
                                  padding: paddingData,
                                  child: Text(
                                    _checkType(itemMain.IS_OUTSIDE) + itemMain.COMPARE_NO.toString() + "/" + _convertYear(itemMain.COMPARE_NO_YEAR),
                                    style: textStyleTitleData,
                                  ),
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ))
                : Container(),
            Container(
              width: size.width,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0),
                physics: NeverScrollableScrollPhysics(),
                itemCount: _compareArrestMain.CompareArrestIndictmentDetail.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final formatter = new NumberFormat("#,##0.00");
                  double fine_value = 0;
                  if (_compareArrestMain.FINE_TYPE == 0 || _compareArrestMain.FINE_TYPE == 1 || _compareArrestMain.FINE_TYPE == 2) {
                    fine_value = 0;
                    if (_compareArrestMain.FINE_TYPE == 1) {
                      int mistreat_no = 0;
                      _compareArrestMain.CompareArrestIndictmentDetail.forEach((item) {
                        mistreat_no += item.MISTREAT_NO;
                      });
                      _compareArrestMain.CompareGuiltbaseFine.forEach((item) {
                        if (_compareArrestMain.SUBSECTION_RULE_ID == item.SUBSECTION_RULE_ID) {
                          if ((mistreat_no >= item.MISTREAT_START_NO) && (item.MISTREAT_START_NO > item.MISTREAT_TO_NO)) {
                            fine_value = item.FINE_AMOUNT;
                            itemGuiltbaseFine = item;
                          } else {
                            if (mistreat_no >= item.MISTREAT_START_NO && mistreat_no <= item.MISTREAT_TO_NO) {
                              fine_value += item.FINE_AMOUNT;
                              itemGuiltbaseFine = item;
                            }
                          }
                        }
                      });
                      _compareArrestMain.CompareArrestIndictmentDetail[index].FINE_TOTAL = fine_value;
                    } else if (_compareArrestMain.FINE_TYPE == 2) {
                      double volumn = 0;
                      _compareArrestMain.CompareProveProduct.forEach((item) {
                        volumn += item.VOLUMN;
                      });
                      if (volumn != 0) {
                        _compareArrestMain.CompareGuiltbaseFine.forEach((item) {
                          if (_compareArrestMain.SUBSECTION_RULE_ID == item.SUBSECTION_RULE_ID) {
                            if (item.MISTREAT_START_VOLUMN > item.MISTREAT_TO_VOLUMN) {
                              if (volumn > item.MISTREAT_START_VOLUMN) {
                                fine_value += item.FINE_AMOUNT;
                                itemGuiltbaseFine = item;
                              }
                            } else {
                              if (volumn > item.MISTREAT_START_VOLUMN && volumn <= item.MISTREAT_TO_VOLUMN) {
                                fine_value += item.FINE_AMOUNT;
                                itemGuiltbaseFine = item;
                              }
                            }
                          }
                        });
                      } else {
                        _compareArrestMain.CompareGuiltbaseFine.forEach((item) {
                          if (_compareArrestMain.SUBSECTION_RULE_ID == item.SUBSECTION_RULE_ID) {
                            fine_value += 0;
                            itemGuiltbaseFine = item;
                          }
                        });
                      }
                      _compareArrestMain.CompareArrestIndictmentDetail[index].FINE_TOTAL = fine_value;
                    } else {
                      _compareArrestMain.CompareGuiltbaseFine.forEach((item) {
                        if (_compareArrestMain.SUBSECTION_RULE_ID == item.SUBSECTION_RULE_ID) {
                          fine_value += item.FINE_AMOUNT;
                          itemGuiltbaseFine = item;
                        }
                      });
                      _compareArrestMain.CompareArrestIndictmentDetail[index].FINE_TOTAL = fine_value;
                    }
                  } else {
                    _compareArrestMain.CompareGuiltbaseFine.forEach((item) {
                      if (_compareArrestMain.SUBSECTION_RULE_ID == item.SUBSECTION_RULE_ID) {
                        itemGuiltbaseFine = item;
                      }
                    });
                    fine_value = 0;
                    List<double> temp = [];
                    if (_compareArrestMain.CompareProveProduct.length == 0) {
                      temp.add(0);
                    } else {
                      _compareArrestMain.CompareProveProduct.forEach((pro) {
                        temp.add(itemGuiltbaseFine.FINE_RATE * pro.VAT);
                        //fine_value += itemGuiltbaseFine.FINE_RATE*_compareArrestMain.CompareProveProduct[index].VAT;
                      });
                    }
                    /*itemMain.CompareMapping.forEach((item){
                          item.CompareDetail.forEach((item){
                            temp.add(itemGuiltbaseFine.FINE_RATE*item.PAYMENT_FINE);
                          });
                        });*/
                    fine_value = temp.reduce((a, b) => a + b);
                    _compareArrestMain.CompareArrestIndictmentDetail[index].FINE_TOTAL = fine_value;
                  }

                  bool IsCompare = false;
                  if (itemMain != null) {
                    itemMain.CompareMapping.forEach((item) {
                      if (item.INDICTMENT_DETAIL_ID == _compareArrestMain.CompareArrestIndictmentDetail[index].INDICTMENT_DETAIL_ID) {
                        if (item.CompareDetail.length > 0) {
                          IsCompare = true;
                        } else {
                          IsCompare = false;
                        }
                      }
                    });
                  }
                  print("IsCompare : " + IsCompare.toString());

                  //ใบเสร็จ
                  ItemsCompareDetail itemsCompareDetail;
                  if (itemMain != null) {
                    itemMain.CompareMapping.forEach((mapp) {
                      if (mapp.INDICTMENT_DETAIL_ID == _compareArrestMain.CompareArrestIndictmentDetail[index].INDICTMENT_DETAIL_ID) {
                        mapp.CompareDetail.forEach((item) {
                          itemsCompareDetail = item;
                        });
                      }
                    });
                  }

                  return GestureDetector(
                    onTap: () {
                      IsCompare
                          ? _navigate(
                              context,
                              _compareArrestMain.CompareArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH + _compareArrestMain.CompareArrestIndictmentDetail[index].FIRST_NAME + " " + _compareArrestMain.CompareArrestIndictmentDetail[index].LAST_NAME,
                              _compareArrestMain.CompareArrestIndictmentDetail[index],
                              false,
                              true,
                              fine_value,
                            )
                          : null;
                    },
                    child: Container(
                        //padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                              //color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: Border(
                                //top: BorderSide(color: Colors.grey[300], width: 1.0),
                                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                              )),
                          child: Stack(
                            children: <Widget>[
                              Column(
                                /*mainAxisAlignment: MainAxisAlignment
                                          .start,*/
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Divider(color: Colors.white),
                                  _compareArrestMain.CompareArrestIndictmentDetail.length == 1
                                      ? Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            "ผู้ต้องหา",
                                            style: textStyleLabel,
                                          ),
                                        )
                                      : Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            "ผู้ต้องหาลำดับที่ " + (index + 1).toString(),
                                            style: textStyleLabel,
                                          ),
                                        ),
                                  Padding(
                                    padding: paddingData,
                                    child: Text(
                                      _compareArrestMain.CompareArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH + _compareArrestMain.CompareArrestIndictmentDetail[index].FIRST_NAME + " " + _compareArrestMain.CompareArrestIndictmentDetail[index].LAST_NAME,
                                      style: textStyleData,
                                    ),
                                  ),
                                  IsCompare
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: paddingLabel,
                                              child: Text(
                                                "ค่าปรับตามบัญชีรายละเอียดฐานความผิดและอัตราโทษ",
                                                style: textStyleLabel1,
                                              ),
                                            ),
                                            Padding(
                                              padding: paddingData,
                                              child: Text(
                                                /*formatter.format(
                                                    itemsCompareDetail
                                                        .PAYMENT_FINE)
                                                    .toString(),*/
                                                formatter.format(_compareArrestMain.CompareArrestIndictmentDetail[index].FINE_TOTAL).toString(),
                                                style: textStyleData,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: paddingLabel,
                                              child: Text(
                                                "ค่าปรับตามบัญชีรายละเอียดฐานความผิดและอัตราโทษ",
                                                style: textStyleLabel1,
                                              ),
                                            ),
                                            Padding(
                                              padding: paddingData,
                                              child: Text(
                                                formatter.format(_compareArrestMain.CompareArrestIndictmentDetail[index].FINE_TOTAL).toString(),
                                                style: textStyleData,
                                              ),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                              IsCompare
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top: 22.0, bottom: 22.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Icon(
                                                Icons.arrow_forward_ios,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                        itemsCompareDetail.IS_TEMP_RELEASE == 1
                                            ? Padding(
                                                padding: EdgeInsets.only(top: 22.0, bottom: 22.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: paddingData,
                                                      child: Text(
                                                        "ปล่อยตัวชั่วคราว",
                                                        style: textStyleData,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.only(top: 47.0, bottom: 10.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: paddingData,
                                                      child: Text(
                                                        "เลขใบเสร็จ : " + itemsCompareDetail.RECEIPT_NO.toString() + "/" + itemsCompareDetail.RECEIPT_BOOK_NO.toString(),
                                                        style: tabStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        /*itemMain.Informations.Suspects[index]
                                            .IsActive ?
                                        Icon(Icons.arrow_forward_ios, size: 18,)
                                            :*/
                                        Container(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: new Card(
                                              color: Color(0xff087de1),
                                              shape: new RoundedRectangleBorder(side: new BorderSide(color: Color(0xff087de1), width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                                              elevation: 0.0,
                                              child: Container(
                                                  //width: 110.0,
                                                  //height: 40,
                                                  child: Center(
                                                child: MaterialButton(
                                                  onPressed: () {
                                                    _navigate(context, _compareArrestMain.CompareArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH + _compareArrestMain.CompareArrestIndictmentDetail[index].FIRST_NAME + " " + _compareArrestMain.CompareArrestIndictmentDetail[index].LAST_NAME,
                                                        _compareArrestMain.CompareArrestIndictmentDetail[index], true, false, fine_value);
                                                  },
                                                  splashColor: Color(0xff087de1),
                                                  //highlightColor: Colors.blue,
                                                  child: Center(
                                                    child: Text(
                                                      "เปรียบเทียบ",
                                                      style: textStyleButtonAccept,
                                                    ),
                                                  ),
                                                ),
                                              ))),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  );
                },
              ),
            ),
            itemMain != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompareRewardScreenFragment(
                                  itemsCompareListIndicment: _compareArrestMain,
                                  itemsCompareMain: itemMain,
                                )),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 4.0),
                      width: size.width,
                      child: Container(
                          padding: EdgeInsets.all(22.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border(
                                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เงินสินบน-รางวัล",
                                  style: textStyleLabel,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                              )
                            ],
                          )),
                    ),
                  )
                : Container()
          ],
        ),
      ));
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            //height: 34.0,
            // decoration: BoxDecoration(
            //     border: Border(
            //       top: BorderSide(color: Colors.grey[300], width: 1.0),
            //       //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            //     )
            // ),
            ),
        Expanded(
          child: _buildContent(context),
        ),
      ],
    );
  }
//************************end_tab_1*******************************

  //************************start_tab_2*****************************
  buildCollapsed() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "เลขที่รับคำกล่าวโทษ",
            style: textStyleLabel,
          ),
        ),
        _compareArrestMain.LAWSUIT_IS_OUTSIDE == 1
            ? Padding(
                padding: paddingData,
                child: Text(
                  "น. " + _compareArrestMain.LAWSUIT_NO.toString() + "/" + (_compareArrestMain.LAWSUIT_NO_YEAR != null ? _convertYear(_compareArrestMain.LAWSUIT_NO_YEAR) : "-"),
                  style: textDataTitleStyle,
                ),
              )
            : Padding(
                padding: paddingData,
                child: Text(
                  _compareArrestMain.LAWSUIT_NO.toString() + "/" + (_compareArrestMain.LAWSUIT_NO_YEAR != null ? _convertYear(_compareArrestMain.LAWSUIT_NO_YEAR) : "-"),
                  style: textDataTitleStyle,
                ),
              ),
        Padding(
          padding: paddingData,
          child: Container(
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "เลขที่งาน",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.ARREST_CODE,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "วันที่จับกุม",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _convertDate(_compareArrestMain.OCCURRENCE_DATE) + " " + _convertTime(_compareArrestMain.OCCURRENCE_DATE),
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ผู้จับกุม",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.ACCUSER_TITLE_NAME_TH + _compareArrestMain.ACCUSER_FIRST_NAME + " " + _compareArrestMain.ACCUSER_LAST_NAME,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ผู้ต้องหา",
            style: textStyleLabel,
          ),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _compareArrestMain.CompareArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: new Padding(
                      padding: paddingData,
                      child: Text(
                        (j + 1).toString() + '. ' + _compareArrestMain.CompareArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH + _compareArrestMain.CompareArrestIndictmentDetail[j].FIRST_NAME + " " + _compareArrestMain.CompareArrestIndictmentDetail[j].LAST_NAME,
                        style: textStyleData,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text(
                          "ดูประวัติผู้ต้องหา",
                          style: textStyleLink,
                        ),
                        onPressed: () {
                          Map map = {"TEXT_SEARCH": "", "PERSON_ID": _compareArrestMain.CompareArrestIndictmentDetail[j].PERSON_ID};
                          _navigatePreviewIndicmentDetail(context, map);
                          /* Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => LawsuitNotAcceptSuspectScreenFragment(ItemsSuspect: widget.itemsCaseInformation.Suspects[j],)));*/
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "มาตรา",
            style: textStyleLabel,
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: new Padding(
                  padding: paddingData,
                  child: Text(
                    _compareArrestMain.SUBSECTION_NAME,
                    style: textStyleData,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                child: new ButtonTheme(
                  minWidth: 44.0,
                  padding: new EdgeInsets.all(0.0),
                  child: new FlatButton(
                    child: new Text(
                      "ดูบทกำหนดโทษ",
                      style: textStyleLink,
                    ),
                    onPressed: () {
                      _navigatePreviewpernalty(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ฐานความผิด",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.GUILTBASE_NAME,
            style: textStyleData,
          ),
        ),
      ],
    );
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

  String _convertYear(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    String year = (int.parse(splits[3]) + 543).toString();
    return year;
  }

  _navigatePreviewpernalty(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Compare_Pernalty(
                // itemsCompareMain: _itemsLawsuitArrestMain,
                itemsCompareMain: _compareArrestMain,
              )),
    );
  }

  buildExpanded() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "เลขที่รับคำกล่าวโทษ",
            style: textStyleLabel,
          ),
        ),
        _compareArrestMain.LAWSUIT_IS_OUTSIDE == 1
            ? Padding(
                padding: paddingData,
                child: Text(
                  "น. " + _compareArrestMain.LAWSUIT_NO.toString() + "/" + (_compareArrestMain.LAWSUIT_NO_YEAR != null ? _convertYear(_compareArrestMain.LAWSUIT_NO_YEAR) : "-"),
                  style: textDataTitleStyle,
                ),
              )
            : Padding(
                padding: paddingData,
                child: Text(
                  _compareArrestMain.LAWSUIT_NO.toString() + "/" + (_compareArrestMain.LAWSUIT_NO_YEAR != null ? _convertYear(_compareArrestMain.LAWSUIT_NO_YEAR) : "-"),
                  style: textDataTitleStyle,
                ),
              ),
        Padding(
          padding: paddingData,
          child: Container(
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "เลขที่งาน",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.ARREST_CODE,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "วันที่จับกุม",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.OCCURRENCE_DATE != null ? _convertDate(_compareArrestMain.OCCURRENCE_DATE) + " " + _convertTime(_compareArrestMain.OCCURRENCE_DATE) : "null",
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ผู้จับกุม",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.ACCUSER_TITLE_NAME_TH + _compareArrestMain.ACCUSER_FIRST_NAME + " " + _compareArrestMain.ACCUSER_LAST_NAME,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ผู้ต้องหา",
            style: textStyleLabel,
          ),
        ),
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _compareArrestMain.CompareArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: paddingData,
                    child: Text(
                      (j + 1).toString() + '. ' + _compareArrestMain.CompareArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH + _compareArrestMain.CompareArrestIndictmentDetail[j].FIRST_NAME + " " + _compareArrestMain.CompareArrestIndictmentDetail[j].LAST_NAME,
                      style: textStyleData,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: new ButtonTheme(
                      minWidth: 44.0,
                      padding: new EdgeInsets.all(0.0),
                      child: new FlatButton(
                        child: new Text(
                          "ดูประวัติผู้ต้องหา",
                          style: textStyleLink,
                        ),
                        onPressed: () {
                          Map map = {"TEXT_SEARCH": "", "PERSON_ID": _compareArrestMain.CompareArrestIndictmentDetail[j].PERSON_ID};
                          _navigatePreviewIndicmentDetail(context, map);
                          /*Navigator.of(context)
                              .push(
                              new MaterialPageRoute(
                                  builder: (context) => LawsuitNotAcceptSuspectScreenFragment(ItemsSuspect: widget.itemsCaseInformation.Suspects[j])));*/
                        },
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "มาตรา",
            style: textStyleLabel,
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Expanded(
                child: new Padding(
                  padding: paddingData,
                  child: Text(
                    _compareArrestMain.SUBSECTION_NAME,
                    style: textStyleData,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0),
                child: new ButtonTheme(
                  minWidth: 44.0,
                  padding: new EdgeInsets.all(0.0),
                  child: new FlatButton(
                    child: new Text(
                      "ดูบทกำหนดโทษ",
                      style: textStyleLink,
                    ),
                    onPressed: () {
                      _navigatePreviewpernalty(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ฐานความผิด",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.GUILTBASE_NAME,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "วันที่รับคดี",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _compareArrestMain.LAWSUIT_DATE != null ? _convertDate(_compareArrestMain.LAWSUIT_DATE) + " " + _convertTime(_compareArrestMain.LAWSUIT_DATE) : "null",
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "วันที่พิสูจน์ของกลาง",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            /*_convertDate(_compareArrestMain.RECEIVE_DOC_DATE)*/
            _compareArrestMain.RECEIVE_DOC_DATE != null ? _convertDate(_compareArrestMain.RECEIVE_DOC_DATE) + " " + _convertTime(_compareArrestMain.LAWSUIT_DATE) : "-",
            style: textStyleData,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text(
                "ของกลาง",
                style: textStyleLabel,
              ),
            ),
            _compareArrestMain.CompareArrestIndictmentProduct.length == 0
                ? Container(
                    padding: paddingData,
                    child: Text(
                      "ไม่มีของกลาง",
                      style: textStyleData,
                    ),
                  )
                : Container(
                    padding: paddingLabel,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // new
                        itemCount: _compareArrestMain.CompareArrestIndictmentProduct.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TabScreenArrest6Product(
                                              ItemsProduct: _compareArrestMain.CompareArrestIndictmentProduct[index],
                                              IsComplete: true,
                                            )),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: paddingData,
                                        child: Text(
                                          (index + 1).toString() + ". " + new SetProductName(_compareArrestMain.CompareArrestIndictmentProduct[index]).PRODUCT_NAME,
                                          style: textStyleData,
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.navigate_next),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1.0,
                                color: Colors.grey[300],
                              ),
                            ],
                          );
                        }),
                  ),
          ],
        ),
      ],
    );
  }

  //bool Success=false;
  //ItemsListArrestPerson ItemsPreviewIndicmentDetail=null;
  ItemsListPersonNetMain itemsListPersonNetMain = null;
  //on show dialog
  Future<bool> onLoadActionIndicmentDetail(BuildContext context, Map map) async {
    /* await new ArrestFuture().apiRequestMasPersongetByCon(map).then((onValue) {
      Success = onValue.SUCCESS;
      onValue.RESPONSE_DATA.forEach((item){
        ItemsPreviewIndicmentDetail=item;
      });
    });*/
    await new PersonNetFuture().apiRequestPersonDetailgetByPersonId(map).then((onValue) {
      itemsListPersonNetMain = onValue;
    });
    setState(() {});
    return true;
  }

  _navigatePreviewIndicmentDetail(BuildContext context, Map map) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionIndicmentDetail(context, map);
    Navigator.pop(context);

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest4Suspect2(
                itemsListPersonNetMain: itemsListPersonNetMain,
              )),
    );
  }

  Widget _buildContent_tab_2() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery.of(context).size;
      return Container(
        padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Stack(
          children: <Widget>[
            ExpandableNotifier(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expandable(
                    collapsed: buildCollapsed(),
                    expanded: buildExpanded(),
                  ),
                  Row(
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
                                exp.expanded ? "ย่อ..." : "ดูเพิ่มเติม...",
                                style: textStyleLink,
                              ));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    //data result when search data
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              //height: 34.0,
              // decoration: BoxDecoration(
              //     border: Border(
              //       top: BorderSide(color: Colors.grey[300], width: 1.0),
              //       //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              //     )
              // ),
              ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: SingleChildScrollView(
                child: _buildContent(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
//************************end_tab_2*****************************

//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    Widget _buildContent() {
      TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
      TextStyle textInputStyleSubTitle = TextStyle(fontSize: 16.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily);

      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            padding: EdgeInsets.only(top: 0),
            itemCount: itemsFormsTab.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                //padding: EdgeInsets.only(top: 2, bottom: 2),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
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
                      subtitle: itemsFormsTab[index].FormsName.endsWith("ใบเสร็จรับเงิน")
                          ? Padding(
                              padding: paddingLabel,
                              child: Text(
                                itemsFormsTab[index].SubForms,
                                style: textInputStyleSubTitle,
                              ),
                            )
                          : null,
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[300],
                        size: 18.0,
                      ),
                      onTap: () {
                        _navigate_preview_form(context, itemsFormsTab[index]);
                      }),
                ),
              );
            }),
      );
    }

    //data result when search data
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              //height: 34.0,
              // decoration: BoxDecoration(
              //     border: Border(
              //       top: BorderSide(color: Colors.grey[300], width: 1.0),
              //       //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              //     )
              // ),
              ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Future<bool> onLoadActionPreviewForms(ItemsCompareForms item) async {
    print("Form Code : " + item.FormsCode.trim());

    if (item.FormsCode.isNotEmpty) {
      Map map;
      if (item.FormsCode.trim() == "ILG60_00_06_001") {
        map = {"CompareID": itemMain.COMPARE_ID};
        await new TransectionFuture().apiRequestILG60_00_06_001(map).then((onValue) {
          print("res PDF : " + onValue);
        });
      } else if (item.FormsCode.trim() == "ILG60_00_06_003") {
        map = {"CompareID": itemMain.COMPARE_ID};
        await new TransectionFuture().apiRequestILG60_00_06_003(map).then((onValue) {
          print("res PDF : " + onValue);
        });
      } else if (item.FormsCode.trim() == "ILG60_00_06_004") {
        map = {"LawsuitID": itemMain.LAWSUIT_ID};
        await new TransectionFuture().apiRequestILG60_00_06_004(map).then((onValue) {
          print("res PDF : " + onValue);
        });
      } else if (item.FormsCode.trim() == "ILG60_00_06_002") {
        print('Compare detail key: ${item.Keys}');
        map = {
          "receipt_no": 1, // ใช้ COMPARE_DETAIL_ID ถูกแล้ว แต่ที่เรียกไม่เจอคือเส้นอันเก่ามัน return receipt_no มา เขายังไม่ได้แก้
          "SystemId": "systemid",
          "UserName": "my_username",
          "Password": "bbbbb",
          "IpAddress": "10.11.1.10",
          "Operation": "1",
          "RequestData": {"UserName": "wannapa_j", "OffCode": "100300"}
          // "RequestData": {"UserName": "wannapa_j", "OffCode": widget.ItemsPerson.OPERATION_OFFICE_CODE}
        };
        await new TransectionFuture().apiRequestImgSignature(map).then((onValue) {
          print("Image Signature Status Code: " + onValue); // base64
        });
      } else if (item.FormsCode.trim() == "ILG60_00_04_002") {
        map = {"ArrestCode": widget.itemsCompareArrestMain.ARREST_CODE};
        await new TransectionFuture().apiRequestILG60_00_04_002(map).then((onValue) {
          print("res PDF : " + onValue);
        });
      }
    }

    setState(() {});
    return true;
  }

  _navigate_preview_form(BuildContext context, ItemsCompareForms item) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionPreviewForms(item);
    Navigator.pop(context);

    String dir = (await getApplicationDocumentsDirectory()).path;

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CompareSignature(
                Title: item.FormsName,
                FILE_PATH: item.FormsCode.isNotEmpty ? (dir + '/' + item.FormsCode + '.pdf') : item.FormsCode,
                // FILE_PATH: '/data/user/0/com.example.prototype_app_pang/cache/pdf2019-12-25T150738.297197.pdf',
                NAME: item.FormsCode + '.pdf',
                IsHaveCV: false,
                CompareID: item.Keys,
              )),
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
