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
import 'package:prototype_app_pang/main_menu/check_evidence/delivery_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/evidence_search_staff.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_get_staff.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_item.dart';
import 'package:prototype_app_pang/main_menu/destroy/destroy_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/approve.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_evidence.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_form_list.dart';
import 'package:prototype_app_pang/main_menu/destroy/model/destroy_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection_item.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/manage_evidence_future/manage_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_inventory_list.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_item.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_main.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class DestroyMainScreenFragment extends StatefulWidget {
  ItemsEvidenceOutMain ItemsdestroyMain;
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  bool IsUpdate;
  bool IsPreview;
  bool IsCreate;
  DestroyMainScreenFragment({
    Key key,
    @required this.ItemsdestroyMain,
    @required this.ItemsPerson,
    @required this.IsUpdate,
    @required this.IsPreview,
    @required this.IsCreate,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

const double _kPickerSheetHeight = 216.0;

class _FragmentState extends State<DestroyMainScreenFragment> with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'การอนุมัติ'),
    Choice(title: 'ของกลาง'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  List/*<EvidenceInventoryList>*/ itemEvidence = [];
  //List<ItemsEvidenceInItem> itemEvidence=[];
  //item หลักทั้งหมด
  ItemsEvidenceOutMain itemMain;

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

  //node focus การอนุมัติ
  final FocusNode myFocusNodeApproveNumber = FocusNode();
  final FocusNode myFocusNodeApproveYear = FocusNode();
  final FocusNode myFocusNodeOfferDate = FocusNode();
  final FocusNode myFocusNodeOfferTime = FocusNode();
  final FocusNode myFocusNodePersonOffer = FocusNode();
  final FocusNode myFocusNodeOfferDepartment = FocusNode();
  final FocusNode myFocusNodePersonConsider = FocusNode();
  final FocusNode myFocusNodeConsiderDepartment = FocusNode();
  final FocusNode myFocusNodeConsiderDate = FocusNode();
  final FocusNode myFocusNodeConsiderTime = FocusNode();
  final FocusNode myFocusNodeStock = FocusNode();

  //textfield การอนุมัติ
  TextEditingController editApproveNumber = new TextEditingController();
  TextEditingController editApproveYear = new TextEditingController();
  TextEditingController editOfferDate = new TextEditingController();
  TextEditingController editOfferTime = new TextEditingController();
  TextEditingController editPersonOffer = new TextEditingController();
  TextEditingController editOfferDepartment = new TextEditingController();
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
  final FocusNode myFocusNodeDesployDepartment = FocusNode();

  //textfield ของกลาง
  TextEditingController editDesployNumber = new TextEditingController();
  TextEditingController editDesployDate = new TextEditingController();
  TextEditingController editDesployTime = new TextEditingController();
  TextEditingController editDesployPerson = new TextEditingController();
  TextEditingController editDesployDepartment = new TextEditingController();

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

  String _offerDate = "", _considerDate = "", _destroyDate = "";

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

    _offerDate = DateTime.now().toString();
    _considerDate = DateTime.now().toString();
    _destroyDate = DateTime.now().toString();

    _dtOfferDate = DateTime.now();
    _currentOfferDate = date;
    _currentOfferTime = dateFormatTime.format(DateTime.now()).toString();

    _dtConsiderDate = DateTime.now();
    _currentConsiderDate = date;
    _currentConsiderTime = dateFormatTime.format(DateTime.now()).toString();

    _dtDestroyDate = DateTime.now();
    _currentDestroyDate = date;
    _currentDestroyTime = dateFormatTime.format(DateTime.now()).toString();

    editApproveYear.text = _convertYear(DateTime.now().toString());

    //itemMain = widget.ItemsdestroyMain;

    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsUpdate;
      //_setDataSaved();

      _setInitDataEvidence();
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
      itemsFormsTab = [];
      itemsFormsTab.add(new ItemsDestroyForms("บัญชีรายการทำลายของกลาง"));
    }
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
  }

  @override
  void dispose() {
    super.dispose();

    editApproveNumber.dispose();
    editApproveYear.dispose();
    editOfferDate.dispose();
    editOfferTime.dispose();
    editPersonOffer.dispose();
    editOfferDepartment.dispose();
    editPersonConsider.dispose();
    editConsiderDepartment.dispose();
    editConsiderDate.dispose();
    editConsiderTime.dispose();
    editStock.dispose();
    tabController.dispose();
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

  void _setInitDataEvidence() {
    editApproveNumber.text = itemMain.APPROVE_NO.substring(1, itemMain.APPROVE_NO.indexOf("/"));

    _dtOfferDate = DateTime.parse(itemMain.APPROVE_DATE);
    _dtConsiderDate = DateTime.parse(itemMain.EVIDENCE_OUT_NO_DATE);
    _dtOfferDate = DateTime.parse(itemMain.EVIDENCE_OUT_DATE);

    _currentOfferDate = _convertDate(_dtOfferDate.toString());
    _currentOfferTime = dateFormatTime.format(_dtOfferDate).toString();
    _currentConsiderDate = _convertDate(_dtConsiderDate.toString());
    _currentConsiderTime = dateFormatTime.format(_dtConsiderDate).toString();
    _currentDestroyDate = _convertDate(_dtOfferDate.toString());
    _currentDestroyTime = dateFormatTime.format(_dtOfferDate).toString();

    editOfferDate.text = _currentOfferDate;
    editOfferTime.text = _currentOfferTime;
    editConsiderDate.text = _currentOfferDate;
    editConsiderTime.text = _currentConsiderTime;
    editDesployDate.text = _currentDestroyDate;
    editDesployTime.text = _currentDestroyTime;

    editPersonOffer.text = get_staff_name(itemMain.EvidenceOutStaff, 72);
    editPersonConsider.text = get_staff_name(itemMain.EvidenceOutStaff, 73);
    editDesployPerson.text = get_staff_name(itemMain.EvidenceOutStaff, 74);

    editOfferDepartment.text = get_office_name(itemMain.EvidenceOutStaff, 72);
    editConsiderDepartment.text = get_staff_name(itemMain.EvidenceOutStaff, 73);
    editDesployDepartment.text = get_staff_name(itemMain.EvidenceOutStaff, 74);

    itemEvidence.forEach((item) {
      _setCalItem(item);
    });
  }

  /*****************************method for main tab**************************/
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onEdited = true;
        _onFinish = false;

        final pos = tabController.length - 1;
        choices.removeAt(pos);
        tabController = TabController(initialIndex: 0, length: choices.length, vsync: this);
        _tabPageSelector = new TabPageSelector(controller: tabController);

        _setInitDataEvidence();
      } else {
        _onDeleted = true;
        _showDeleteAlertDialog();
      }
    });
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoCancelDeleteDialog() {
    return new CupertinoAlertDialog(
        content:
            /*new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text("เหตุผลการลบ", style: textLabelStyle,),
              ),
              */ /*Padding(
                  padding: paddingInputBox,
                  child: TextField(
                    focusNode: myFocusNodeCommentDelete,
                    controller: editCommentDelete,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: textInputStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
              ),*/ /*
            ],
          )
        ),*/
            Card(
          color: Colors.transparent,
          elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                onDeleted();
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
    TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: FontStyles().FontFamily);
    TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold, fontFamily: FontStyles().FontFamily);
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
                    _setDataSaved();
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
  void onSaved(BuildContext mContext) async {
    if (editApproveNumber.text.isEmpty || editApproveYear.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกเลขที่หนังสืออนุมัติ');
    } else if (editPersonOffer.text.isEmpty || editOfferDepartment.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกช่องผู้เสนออนุมัติหรือหน่วยงานอนุมัติ');
    } else if (editPersonConsider.text.isEmpty || editConsiderDepartment.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกช่องผู้พิจารณาอนุมัติหรือหน่วยงานผู้พิจารณาอนุมัติ');
    } else if (editDesployPerson.text.isEmpty || editDesployDepartment.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกช่องประธานทำลายของกลางหรือหน่วยงานทำลายของกลาง');
    } else if (editStock.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกคลังจัดเก็บ');
    } else {
      if (_onEdited) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onLoadActionUpdAllEvidenceOut();
        Navigator.pop(context);
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onLoadActionInsAllEvidenceOut();
        Navigator.pop(context);
      }
    }
  }

  Future<String> _transection_running() async {
    Map map_transec = {"RUNNING_TABLE": "OPS_EVIDENCE_OUT", "RUNNING_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE};
    await new TransectionFuture().apiRequestTransactionRunninggetByCon(map_transec).then((onValue) {
      _itemTransection = onValue;
      if (_itemTransection.length != 0) {
        IsEvidenceCode = true;
        transection_no = (_itemTransection.last.RUNNING_NO + 1).toString();
        if (transection_no.length != 5) {
          String sum = "";
          for (int i = 0; i < 5 - transection_no.length; i++) {
            sum += "0";
          }
          transection_no = _itemTransection.last.RUNNING_PREFIX + _itemTransection.last.RUNNING_OFFICE_CODE + _itemTransection.last.RUNNING_YEAR + sum + transection_no;
        }
      } else {
        IsEvidenceCode = false;
        DateFormat format_auto = DateFormat("yyyy");
        String date_auto = (int.parse(format_auto.format(DateTime.now()).toString()) + 543).toString().substring(2);
        transection_no = "DT" + widget.ItemsPerson.OPERATION_OFFICE_CODE + date_auto + "00001";
      }
    });
    print("transection_no : " + transection_no);
    return transection_no;
  }

  void _transection_update() async {
    if (IsEvidenceCode) {
      Map map_tran_up = {
        "RUNNING_ID": _itemTransection.last.RUNNING_ID,
      };
      await new TransectionFuture().apiRequestTransactionRunningupdByCon(map_tran_up).then((onValue) {
        print("Update Transection : " + onValue.Msg);
      });
    } else {
      Map map_tran_ins = {"RUNNING_OFFICE_ID": 30, "RUNNING_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE, "RUNNING_TABLE": "OPS_EVIDENCE_OUT", "RUNNING_PREFIX": "DT"};
      print(map_tran_ins.toString());
      await new TransectionFuture().apiRequestTransactionRunninginsAll(map_tran_ins).then((onValue) {
        print("Insert Transection : " + onValue.Msg);
      });
    }
  }

  List<ItemsListTransection> _itemTransection = [];
  List<ItemsListTransectionItem> _itemTransectionitem = [];
  String transection_no, transection_item_no;
  bool IsEvidenceCode, IsEvidenceItemCode;
  //timing progress dialog
  Future<bool> onLoadActionInsAllEvidenceOut() async {
    String tran_evidence_no;
    await _transection_running().then((s) {
      print("report : " + s);
      tran_evidence_no = s;
    });

    Map map_evidence = {
      "EVIDENCE_OUT_ID": "",
      "EVIDENCE_IN_ID": "1",
      "WAREHOUSE_ID": 1,
      "OFFICE_CODE": "",
      "EVIDENCE_OUT_CODE": tran_evidence_no,
      "EVIDENCE_OUT_DATE": _destroyDate,
      "EVIDENCE_OUT_TYPE": 2,
      "EVIDENCE_OUT_NO": "",
      "EVIDENCE_OUT_NO_DATE": _considerDate,
      "BOOK_NO": "",
      "RECEIPT_NO": "",
      "PAY_DATE": "",
      "APPROVE_DATE": _offerDate,
      "RETURN_DATE": "",
      "REMARK": "",
      "APPROVE_NO": "กค." + editApproveNumber.text + "/" + editApproveYear.text,
      "IS_ACTIVE": "1",
      "EvidenceOutItem": _createMapEvidenceItem(false),
      "EvidenceOutStaff": _createMapStaff()
    };

    int EVIDENCE_OUT_ID;
    await new ManageEvidenceFuture().apiRequestEvidenceOutinsAll(map_evidence).then((onValue) {
      EVIDENCE_OUT_ID = onValue.EVIDENCE_OUT_ID;
      print("Insert EvidenceOut :" + onValue.Msg.toString());
      print(onValue.EVIDENCE_OUT_ID.toString());
    });

    double sum_dest = 0;
    itemEvidence.forEach((item) {
      sum_dest += double.parse(item.ItemsController.editTotalNumber.text);
    });
    print("BALANCE_QTY : " + sum_dest.toString());
    Map map_balance = {"STOCK_ID": 1, "BALANCE_QTY": sum_dest};
    await new ManageEvidenceFuture().apiRequestEvidenceOutStockBalanceupdByCon(map_balance).then((onValue) {
      print("Update Balance Stock :" + onValue.Msg.toString());
    });

    _transection_update();

    //getByCon
    if (EVIDENCE_OUT_ID != null) {
      Map map_con = {
        "EVIDENCE_OUT_ID": EVIDENCE_OUT_ID,
      };
      await new ManageEvidenceFuture().apiRequestEvidenceOutgetByCon(map_con).then((onValue) {
        if (onValue != null) {
          itemMain = onValue;
          itemEvidence = itemMain.EvidenceOutIn.EvidenceOutInItem;
        } else {
          //error
        }
      });
    }

    itemsListEvidenceStaff = [];
    //เมื่อกดบันทึก
    _onSaved = true;
    _onFinish = true;
    //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
    _setDataSaved();

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionUpdAllEvidenceOut() async {
    Map map = {
      "EVIDENCE_OUT_ID": itemMain.EVIDENCE_OUT_ID,
      "EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID,
      "WAREHOUSE_ID": "1",
      "OFFICE_CODE": "",
      "EVIDENCE_OUT_CODE": itemMain.EVIDENCE_OUT_CODE,
      "EVIDENCE_OUT_DATE": _destroyDate,
      "EVIDENCE_OUT_TYPE": 2,
      "EVIDENCE_OUT_NO": "",
      "EVIDENCE_OUT_NO_DATE": _considerDate,
      "BOOK_NO": "",
      "RECEIPT_NO": "",
      "PAY_DATE": "",
      "APPROVE_DATE": _offerDate,
      "RETURN_DATE": "",
      "REMARK": "",
      "APPROVE_NO": "กค." + editApproveNumber.text + "/" + editApproveYear.text,
      "IS_ACTIVE": "1",
      "EvidenceOutItem": _createMapEvidenceItem(true),
      "EvidenceOutStaff": _createMapStaff()
    };
    await new ManageEvidenceFuture().apiRequestEvidenceOutupdByCon(map).then((onValue) {
      print("Update EvidenceOut :" + onValue.Msg.toString());
    });

    int sum_dest = 0;
    itemEvidence.forEach((item) {
      try {
        sum_dest += int.parse(item.ItemsController.editTotalVolumn.text);
      } catch (e) {
        item.EvidenceOutStockBalance.forEach((item) {
          sum_dest += item.BALANCE_QTY.toInt();
        });
      }
    });
    print("BALANCE_QTY : " + sum_dest.toString());
    Map map_balance = {"STOCK_ID": 1, "BALANCE_QTY": sum_dest};
    await new ManageEvidenceFuture().apiRequestEvidenceOutStockBalanceupdByCon(map_balance).then((onValue) {
      print("Update Balance Stock :" + onValue.Msg.toString());
    });

    //getByCon
    Map map_con = {
      "EVIDENCE_OUT_ID": itemMain.EVIDENCE_OUT_ID,
    };
    await new ManageEvidenceFuture().apiRequestEvidenceOutgetByCon(map_con).then((onValue) {
      if (onValue != null) {
        itemMain = onValue;
        itemEvidence = onValue.EvidenceOutIn.EvidenceOutInItem;
      } else {
        //error
      }
    });

    itemsListEvidenceStaff = [];
    //เมื่อกดบันทึก
    _onSaved = true;
    _onFinish = true;
    //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
    _setDataSaved();

    setState(() {});
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
    //                     onSaved(context);
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
                    onSaved(context);
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
                            'ทำลายของกลาง',
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
        //         floating: true,
        //         primary: true,
        //         pinned: false,
        //         title: Text(
        //           "ทำลายของกลาง",
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
        //           body: Stack(
        //             children: <Widget>[
        //               BackgroundContent(),
        //               TabBarView(
        //                 //physics: NeverScrollableScrollPhysics(),
        //                 controller: tabController,
        //                 children: _onFinish
        //                     ? <Widget>[
        //                         _buildContent_tab_1(),
        //                         _buildContent_tab_2(),
        //                         _buildContent_tab_3(),
        //                       ]
        //                     : <Widget>[
        //                         _buildContent_tab_1(),
        //                         _buildContent_tab_2(),
        //                       ],
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
                                  "เลขที่หนังสืออนุมัติ",
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
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
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
                          ),
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
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
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

                                            List splitsArrestDate = _dtOfferDate.toUtc().toLocal().toString().split(" ");
                                            List splitsArrestTime = offerTime.toString().split(" ");
                                            _offerDate = splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString();
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
                                  "ผู้เสนออนุมัติ",
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
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                _navigateSearchStaff(context, 72);
                              },
                              focusNode: myFocusNodePersonOffer,
                              controller: editPersonOffer,
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
                              focusNode: myFocusNodeOfferDepartment,
                              controller: editOfferDepartment,
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
                                  "ผู้พิจารณาอนุมัติ",
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
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                _navigateSearchStaff(context, 73);
                              },
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
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
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
                          ),
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
                              enabled: false,
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

                                            List splitsArrestDate = _dtConsiderDate.toUtc().toLocal().toString().split(" ");
                                            List splitsArrestTime = considerTime.toString().split(" ");
                                            _considerDate = splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString();
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
      return itemMain == null
          ? Container()
          : Container(
              decoration: BoxDecoration(
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
                                "เลขที่หนังสืออนุมัติ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                itemMain.APPROVE_NO.toString(),
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
                                _convertDate(itemMain.EVIDENCE_OUT_NO_DATE) + " " + _convertTime1(itemMain.EVIDENCE_OUT_NO_DATE),
                                style: textInputStyle,
                              ),
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
                              child: Text(
                                get_staff_name(itemMain.EvidenceOutStaff, 72) != null ? get_staff_name(itemMain.EvidenceOutStaff, 72) : "",
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
                                get_office_name(itemMain.EvidenceOutStaff, 72) != null ? get_office_name(itemMain.EvidenceOutStaff, 72) : "",
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "ผู้พิจารณาอนุมัติ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                get_staff_name(itemMain.EvidenceOutStaff, 73) != null ? get_staff_name(itemMain.EvidenceOutStaff, 73) : "",
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
                                get_office_name(itemMain.EvidenceOutStaff, 73) != null ? get_office_name(itemMain.EvidenceOutStaff, 73) : "",
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "พิจารณาวันที่",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                _convertDate(itemMain.APPROVE_DATE) + " " + _convertTime1(itemMain.APPROVE_DATE),
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
                                "",
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
              //     border: Border(
              //   //top: BorderSide(color: Colors.grey[300], width: 1.0),
              //   bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              // )),
              /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text('ILG60_B_09_00_03_00',
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

  navigateDeliveredBook(BuildContext context, index, bool IsUpdate) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DestroyBookSearchScreenFragment(
                IsUpdate: IsUpdate,
                IsTransferScreen: false,
              )),
    );
    if (result.toString() != "Back") {
      setState(() {
        if (_onEdited) {
          List<EvidenceInventoryList> item = result;
          item.forEach((item) {
            itemEvidence[index] = item;
          });
          itemEvidence.forEach((item) {
            _setCalItem(item);
          });
        } else {
          List<EvidenceInventoryList> item = result;
          if (IsUpdate) {
            item.forEach((item) {
              itemEvidence[index] = item;
            });
          } else {
            item.forEach((item) {
              itemEvidence.add(item);
            });
          }
          itemEvidence.forEach((item) {
            _setCalItem(item);
          });
        }
        /*ItemsEvidence item = result;
        itemEvidence.add(item);
        itemEvidence.forEach((item){
          item.EvidenceDetailController.expController.expanded=true;
        });*/
      });
    }
  }

  Widget _buildButtonSelectEvidence() {
    var size = MediaQuery.of(context).size;
    Color boxColor = Colors.grey[300];
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
                    _onSaved ? null : navigateDeliveredBook(context, null, false);
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
          padding: EdgeInsets.only(top: 0),
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

  void onDeleted() async {
    Map map_evidence = {"EVIDENCE_OUT_ID": itemMain.EVIDENCE_OUT_ID};
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionInsLawsuitDelete(map_evidence);
    Navigator.pop(context, "Delete");
  }

  Future<bool> onLoadActionInsLawsuitDelete(Map map_evidence) async {
    await new ManageEvidenceFuture().apiRequestEvidenceOutupdDelete(map_evidence).then((onValue) {
      print("Delete Evidence Out : " + onValue.Msg);
    });

    _onSaved = false;
    _onEdited = true;
    _onSave = false;
    choices.removeAt(choices.length - 1);
    Navigator.pop(context);

    setState(() {});
    return true;
  }

  Widget _buildContent_tab_2() {
    Widget _buildExpandableContent(int index) {
      var size = MediaQuery.of(context).size;
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
                    itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(),
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
                    itemEvidence[index].PRODUCT_DESC.toString(),
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
                        width: ((size.width * 75) / 100) / 3.8,
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
                                enabled: false,
                                focusNode: itemEvidence[index].ItemsController.myFocusNodeDeliveredNumber,
                                controller: itemEvidence[index].ItemsController.editDeliveredNumber,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        width: ((size.width * 75) / 100) / 2.7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "จำนวนทำลาย",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                focusNode: itemEvidence[index].ItemsController.myFocusNodeDefectiveNumber,
                                controller: itemEvidence[index].ItemsController.editDefectiveNumber,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  double total_qauntity = itemEvidence[index].BALANCE_QTY - double.parse(text);
                                  itemEvidence[index].ItemsController.editTotalNumber.text = total_qauntity.toInt().toString();
                                },
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
                            new Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: itemEvidence[index].ItemsController.myFocusNodeToalNumber,
                                controller: itemEvidence[index].ItemsController.editTotalNumber,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
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
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: new FocusNode(),
                                controller: itemEvidence[index].ItemsController.editProductUnit,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
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
                itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(),
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
                itemEvidence[index].PRODUCT_DESC.toString(),
                style: textInputStyle,
              ),
            ),
          ],
        );
      }

      return ExpandableNotifier(
        controller: itemEvidence[index].ItemsController.expController,
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
                        "เลขที่ทำลาย",
                        style: textLabelStyle,
                      ),
                    ),
                    Container(
                      padding: paddingInputBox,
                      child: Text(
                        "Auto Gen",
                        style: textInputStyle,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "วันที่ทำลาย",
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
                            enableInteractiveSelection: false,
                            onTap: () {
                              FocusScope.of(context).requestFocus(new FocusNode());
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

                                      List splitsArrestDate = _dtDestroyDate.toUtc().toLocal().toString().split(" ");
                                      List splitsArrestTime = destroyTime.toString().split(" ");
                                      _destroyDate = splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString();
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
                            "ประธานทำลายของกลาง",
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
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                _navigateSearchStaff(context, 74);
                              },
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
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeDesployDepartment,
                              controller: editDesployDepartment,
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
                        padding: EdgeInsets.only(top: 0),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: itemEvidence.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              width: size.width,
                              padding: EdgeInsets.all(22.0),
                              decoration: BoxDecoration(
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[_buildButtonImgPicker(), _buildButtonSelectEvidence()],
                    ),
                  )),
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

        double BALANCE_QTY = 0;
        double QTY = 0;
        itemMain.EvidenceOutItem.forEach((f) {
          QTY = f.QTY;
          f.EvidenceOutStockBalance.forEach((f) {
            BALANCE_QTY = f.BALANCE_QTY;
          });
        });

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
                      itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(),
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
                      itemEvidence[index].PRODUCT_DESC.toString(),
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
                          width: ((size.width * 75) / 100) / 3.8,
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
                                  BALANCE_QTY.toInt().toString(),
                                  style: textInputStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 12.0),
                          width: ((size.width * 75) / 100) / 2.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "จำนวนทำลาย",
                                  style: textLabelStyle,
                                ),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text(
                                  QTY.toInt().toString(),
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
                                  BALANCE_QTY.toInt().toString(),
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
                                  /*itemEvidence[index].BALANCE_QTY_UNIT.toString()*/ "",
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
                  itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(),
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
                  itemEvidence[index].PRODUCT_DESC.toString(),
                  style: textInputStyle,
                ),
              ),
            ],
          );
        }

        return ExpandableNotifier(
          /*controller: itemMain.Destroys.Evidences[index].I
              .expController,*/
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
                      "เลขที่ทำลาย",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      itemMain.EVIDENCE_OUT_CODE,
                      style: textInputStyle,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "วันที่ทำลาย",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _convertDate(itemMain.EVIDENCE_OUT_DATE) + " " + _convertTime1(itemMain.EVIDENCE_OUT_DATE),
                      style: textInputStyle,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ประธานทำลายของกลาง",
                      style: textLabelStyle,
                    ),
                  ),
                  Padding(
                    padding: paddingInputBox,
                    child: Text(
                      get_staff_name(itemMain.EvidenceOutStaff, 74) != null ? get_staff_name(itemMain.EvidenceOutStaff, 74) : "",
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
                      get_office_name(itemMain.EvidenceOutStaff, 74) != null ? get_office_name(itemMain.EvidenceOutStaff, 74) : "",
                      style: textInputStyle,
                    ),
                  ),
                ],
              ),
            ),
            itemMain.EvidenceOutItem.length > 0
                ? Container(
                    width: size.width,
                    padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: itemMain.EvidenceOutItem.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            width: size.width,
                            padding: EdgeInsets.all(22.0),
                            decoration: BoxDecoration(
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
    return Container(
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
                        'ILG60_B_09_00_04_00', style: textStylePageName,),
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
    );
  }
//************************end_tab_2*****************************

//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    Widget _buildContent() {
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
                    child: new Text(
                      'ILG60_B_09_00_07_00', style: textStylePageName,),
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
    );
  }
//************************end_tab_3*******************************

  String _convertDate(String sDate) {
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    result = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

    return result;
  }

  String _convertTime(String sDate) {
    /* DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " + dateFormatTime.format(dt).toString();*/
    String result = "เวลา " + sDate.substring(3) + " น.";
    return result;
  }

  String _convertTime1(String sDate) {
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

  void _setCalItem(var item) {
    try {
      double BALANCE_QTY = 0;
      String BALANCE_QTY_UNIT = "";
      item.EvidenceOutStockBalance.forEach((f) {
        if (item.EVIDENCE_IN_ITEM_ID == f.EVIDENCE_IN_ITEM_ID) {
          BALANCE_QTY = f.BALANCE_QTY;
          BALANCE_QTY_UNIT = f.BALANCE_QTY_UNIT;
        }
      });
      item.ItemsController.editDeliveredNumber.text = BALANCE_QTY.toInt().toString();
      item.ItemsController.editDefectiveNumber.text = 0.toInt().toString();
      item.ItemsController.editTotalNumber.text = (BALANCE_QTY - 0).toInt().toString();
      item.ItemsController.editProductUnit.text = BALANCE_QTY_UNIT.toString();
    } catch (e) {
      item.ItemsController.editDeliveredNumber.text = item.BALANCE_QTY.toInt().toString();
      item.ItemsController.editDefectiveNumber.text = 0.toInt().toString();
      item.ItemsController.editTotalNumber.text = (item.BALANCE_QTY - 0).toInt().toString();
      item.ItemsController.editProductUnit.text = item.BALANCE_QTY_UNIT.toString();
    }
  }

  String _setItemName(var item) {
    String name = "";
    //name = item.PRODUCT_DESC;
    if (item.PRODUCT_GROUP_NAME != null) {
      name += item.PRODUCT_GROUP_NAME + " ";
    }
    if (item.PRODUCT_CATEGORY_NAME != null) {
      name += item.PRODUCT_CATEGORY_NAME + " ";
    }
    if (item.PRODUCT_TYPE_NAME != null) {
      name += item.PRODUCT_TYPE_NAME + " ";
    }
    if (item.PRODUCT_BRAND_NAME_TH != null) {
      name += item.PRODUCT_BRAND_NAME_TH + " ";
    }
    return name;
  }

  List<ItemsListEvidenceGetStaff> itemsListEvidenceStaff = [];
  void add_staff_to(int CONTRIBUTOR_ID) {
    /*72=ผู้เสนออนุมัติทำลาย
      73=ผู้พิจารณาอนุมัติทำลาย
      74=ประธานฯทำลายของกลาง*/
    itemsListEvidenceStaff.add(new ItemsListEvidenceGetStaff(
        STAFF_ID: null,
        STAFF_TYPE: widget.ItemsPerson.STAFF_TYPE,
        STAFF_CODE: "",
        STAFF_REF_ID: null,
        ID_CARD: "",
        TITLE_NAME_TH: widget.ItemsPerson.TITLE_SHORT_NAME_TH,
        TITLE_SHORT_NAME_TH: widget.ItemsPerson.TITLE_SHORT_NAME_TH,
        FIRST_NAME: widget.ItemsPerson.FIRST_NAME,
        LAST_NAME: widget.ItemsPerson.LAST_NAME,
        OPREATION_POS_NAME: "",
        OPREATION_POS_LAVEL_NAME: widget.ItemsPerson.OPREATION_POS_LAVEL_NAME,
        OPERATION_OFFICE_NAME: "",
        OPERATION_OFFICE_SHORT_NAME: "",
        CONTRIBUTOR_ID: CONTRIBUTOR_ID,
        IsCheck: false));
  }

  String get_staff_name(var Items, int CONTRIBUTOR_ID) {
    String name;
    Items.forEach((item) {
      if (item.CONTRIBUTOR_ID == CONTRIBUTOR_ID) {
        name = item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " + item.LAST_NAME;
      }
    });
    return name;
  }

  String get_office_name(var Items, int CONTRIBUTOR_ID) {
    String office;
    Items.forEach((item) {
      if (item.CONTRIBUTOR_ID == CONTRIBUTOR_ID) {
        office = item.OPERATION_OFFICE_NAME;
      }
    });
    return office;
  }

  _navigateSearchStaff(BuildContext context, int CONTRIBUTOR_ID) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenSearchStaff(CONTRIBUTOR_ID: CONTRIBUTOR_ID)),
    );

    if (result.toString() != "back") {
      var Item = result;
      if (_onEdited) {
        if (itemMain.EvidenceOutStaff.length > 0) {
          for (int i = 0; i < itemMain.EvidenceOutStaff.length; i++) {
            if (Item.CONTRIBUTOR_ID == itemMain.EvidenceOutStaff[i].CONTRIBUTOR_ID) {
              itemMain.EvidenceOutStaff[i] = Item;
            }
          }
        }
        print(itemMain.EvidenceOutStaff.length);
      } else {
        if (itemsListEvidenceStaff.length > 0) {
          if (itemsListEvidenceStaff.where((food) => food.CONTRIBUTOR_ID == (Item.CONTRIBUTOR_ID)).toList().length > 0) {
            for (int i = 0; i < itemsListEvidenceStaff.length; i++) {
              if (Item.CONTRIBUTOR_ID == itemsListEvidenceStaff[i].CONTRIBUTOR_ID) {
                itemsListEvidenceStaff[i] = Item;
              }
            }
          } else {
            itemsListEvidenceStaff.add(Item);
          }
        } else {
          itemsListEvidenceStaff.add(Item);
        }
        print(itemsListEvidenceStaff.length);
      }

      editPersonOffer.text = get_staff_name(itemsListEvidenceStaff, 72);
      editPersonConsider.text = get_staff_name(itemsListEvidenceStaff, 73);
      editDesployPerson.text = get_staff_name(itemsListEvidenceStaff, 74);

      editOfferDepartment.text = get_office_name(itemsListEvidenceStaff, 72);
      editConsiderDepartment.text = get_office_name(itemsListEvidenceStaff, 73);
      editDesployDepartment.text = get_office_name(itemsListEvidenceStaff, 74);
    }
  }

  List<Map> _createMapStaff() {
    List<Map> items = [];
    if (_onEdited) {
      print("Update Staff");
      itemMain.EvidenceOutStaff.forEach((item) {
        items.add({
          "EVIDENCE_OUT_STAFF_ID": item.EVIDENCE_OUT_STAFF_ID,
          "EVIDENCE_OUT_ID": item.EVIDENCE_OUT_ID,
          "STAFF_REF_ID": "",
          "TITLE_ID": "",
          "STAFF_CODE": "",
          "ID_CARD": "",
          "STAFF_TYPE": item.STAFF_TYPE,
          "TITLE_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "TITLE_NAME_EN": "",
          "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "TITLE_SHORT_NAME_EN": "",
          "FIRST_NAME": item.FIRST_NAME,
          "LAST_NAME": item.LAST_NAME,
          "AGE": "",
          "OPERATION_POS_CODE": "",
          "OPREATION_POS_NAME": item.LAST_NAME,
          "OPREATION_POS_LEVEL": "",
          "OPERATION_POS_LEVEL_NAME": "",
          "OPERATION_DEPT_CODE": "",
          "OPERATION_DEPT_NAME": "",
          "OPERATION_DEPT_LEVEL": "",
          "OPERATION_UNDER_DEPT_CODE": "",
          "OPERATION_UNDER_DEPT_NAME": "",
          "OPERATION_UNDER_DEPT_LEVEL": 0,
          "OPERATION_WORK_DEPT_CODE": null,
          "OPERATION_WORK_DEPT_NAME": null,
          "OPERATION_WORK_DEPT_LEVEL": 0,
          "OPERATION_OFFICE_CODE": "",
          "OPERATION_OFFICE_NAME": item.OPERATION_OFFICE_NAME,
          "OPERATION_OFFICE_SHORT_NAME": item.OPERATION_OFFICE_SHORT_NAME,
          "MANAGEMENT_POS_CODE": null,
          "MANAGEMENT_POS_NAME": null,
          "MANAGEMENT_POS_LEVEL": null,
          "MANAGEMENT_POS_LEVEL_NAME": null,
          "MANAGEMENT_DEPT_CODE": null,
          "MANAGEMENT_DEPT_NAME": null,
          "MANAGEMENT_DEPT_LEVEL": 0,
          "MANAGEMENT_UNDER_DEPT_CODE": null,
          "MANAGEMENT_UNDER_DEPT_NAME": null,
          "MANAGEMENT_UNDER_DEPT_LEVEL": 0,
          "MANAGEMENT_WORK_DEPT_CODE": null,
          "MANAGEMENT_WORK_DEPT_NAME": null,
          "MANAGEMENT_WORK_DEPT_LEVEL": 0,
          "MANAGEMENT_OFFICE_CODE": null,
          "MANAGEMENT_OFFICE_NAME": null,
          "MANAGEMENT_OFFICE_SHORT_NAME": null,
          "REPRESENT_POS_CODE": "",
          "REPRESENT_POS_NAME": "",
          "REPRESENT_POS_LEVEL": null,
          "REPRESENT_POS_LEVEL_NAME": null,
          "REPRESENT_DEPT_CODE": null,
          "REPRESENT_DEPT_NAME": null,
          "REPRESENT_DEPT_LEVEL": 0,
          "REPRESENT_UNDER_DEPT_CODE": null,
          "REPRESENT_UNDER_DEPT_NAME": null,
          "REPRESENT_UNDER_DEPT_LEVEL": 0,
          "REPRESENT_WORK_DEPT_CODE": null,
          "REPRESENT_WORK_DEPT_NAME": null,
          "REPRESENT_WORK_DEPT_LEVEL": 0,
          "REPRESENT_OFFICE_CODE": null,
          "REPRESENT_OFFICE_NAME": null,
          "REPRESENT_OFFICE_SHORT_NAME": null,
          "STATUS": 1,
          "REMARK": null,
          "CONTRIBUTOR_ID": item.CONTRIBUTOR_ID,
          "IS_ACTIVE": 1
        });
      });
    } else {
      print("Add Staff");
      itemsListEvidenceStaff.forEach((item) {
        items.add({
          "EVIDENCE_OUT_STAFF_ID": "",
          "EVIDENCE_OUT_ID": "",
          "STAFF_REF_ID": "",
          "TITLE_ID": "",
          "STAFF_CODE": "",
          "ID_CARD": "",
          "STAFF_TYPE": item.STAFF_TYPE,
          "TITLE_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "TITLE_NAME_EN": "",
          "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "TITLE_SHORT_NAME_EN": "",
          "FIRST_NAME": item.FIRST_NAME,
          "LAST_NAME": item.LAST_NAME,
          "AGE": "",
          "OPERATION_POS_CODE": "",
          "OPREATION_POS_NAME": item.OPREATION_POS_NAME,
          "OPREATION_POS_LEVEL": "",
          "OPERATION_POS_LEVEL_NAME": item.OPREATION_POS_LAVEL_NAME,
          "OPERATION_DEPT_CODE": "",
          "OPERATION_DEPT_NAME": "",
          "OPERATION_DEPT_LEVEL": "",
          "OPERATION_UNDER_DEPT_CODE": "",
          "OPERATION_UNDER_DEPT_NAME": "",
          "OPERATION_UNDER_DEPT_LEVEL": 0,
          "OPERATION_WORK_DEPT_CODE": null,
          "OPERATION_WORK_DEPT_NAME": null,
          "OPERATION_WORK_DEPT_LEVEL": 0,
          "OPERATION_OFFICE_CODE": "",
          "OPERATION_OFFICE_NAME": item.OPERATION_OFFICE_NAME,
          "OPERATION_OFFICE_SHORT_NAME": item.OPERATION_OFFICE_SHORT_NAME,
          "MANAGEMENT_POS_CODE": null,
          "MANAGEMENT_POS_NAME": null,
          "MANAGEMENT_POS_LEVEL": null,
          "MANAGEMENT_POS_LEVEL_NAME": null,
          "MANAGEMENT_DEPT_CODE": null,
          "MANAGEMENT_DEPT_NAME": null,
          "MANAGEMENT_DEPT_LEVEL": 0,
          "MANAGEMENT_UNDER_DEPT_CODE": null,
          "MANAGEMENT_UNDER_DEPT_NAME": null,
          "MANAGEMENT_UNDER_DEPT_LEVEL": 0,
          "MANAGEMENT_WORK_DEPT_CODE": null,
          "MANAGEMENT_WORK_DEPT_NAME": null,
          "MANAGEMENT_WORK_DEPT_LEVEL": 0,
          "MANAGEMENT_OFFICE_CODE": null,
          "MANAGEMENT_OFFICE_NAME": null,
          "MANAGEMENT_OFFICE_SHORT_NAME": null,
          "REPRESENT_POS_CODE": "",
          "REPRESENT_POS_NAME": "",
          "REPRESENT_POS_LEVEL": null,
          "REPRESENT_POS_LEVEL_NAME": null,
          "REPRESENT_DEPT_CODE": null,
          "REPRESENT_DEPT_NAME": null,
          "REPRESENT_DEPT_LEVEL": 0,
          "REPRESENT_UNDER_DEPT_CODE": null,
          "REPRESENT_UNDER_DEPT_NAME": null,
          "REPRESENT_UNDER_DEPT_LEVEL": 0,
          "REPRESENT_WORK_DEPT_CODE": null,
          "REPRESENT_WORK_DEPT_NAME": null,
          "REPRESENT_WORK_DEPT_LEVEL": 0,
          "REPRESENT_OFFICE_CODE": null,
          "REPRESENT_OFFICE_NAME": null,
          "REPRESENT_OFFICE_SHORT_NAME": null,
          "STATUS": 1,
          "REMARK": null,
          "CONTRIBUTOR_ID": item.CONTRIBUTOR_ID,
          "IS_ACTIVE": 1
        });
      });
    }
    return items;
  }

  List<Map> _createMapEvidenceItem(bool IsUpdate) {
    List<Map> items = [];
    if (_onEdited) {
      print("Update Item");
      itemMain.EvidenceOutItem.forEach((item) {
        if (IsUpdate) {
          items.add({
            "EVIDENCE_OUT_ITEM_ID": item.EVIDENCE_OUT_ITEM_ID,
            "EVIDENCE_OUT_ID": item.EVIDENCE_OUT_ID,
            "STOCK_ID": "1",
            "QTY":
                /*double.parse(
                item.ItemsController.editDefectiveNumber.text)*/
                item.QTY,
            "QTY_UNIT": item.QTY_UNIT,
            "PRODUCT_SIZE": "",
            "PRODUCT_SIZE_UNIT": "",
            "NET_VOLUMN": "",
            "NET_VOLUMN_UNIT": "",
            "IS_RETURN": "0",
            "IS_ACTIVE": "1"
          });
        }
      });
    } else {
      for (int i = 0; i < itemEvidence.length; i++) {
        if (IsUpdate) {
          /*items.add({
            "EVIDENCE_OUT_ITEM_ID": "1",
            "EVIDENCE_OUT_ID": "1",
            "STOCK_ID": "1",
            "QTY": "10",
            "QTY_UNIT": "กระป๋อง",
            "PRODUCT_SIZE": "0.36",
            "PRODUCT_SIZE_UNIT": "ลิตร",
            "NET_VOLUMN": "36",
            "NET_VOLUMN_UNIT": "ลิตร",
            "IS_RETURN": "0",
            "IS_ACTIVE": "1"
          });*/
        } else {
          print("Add Item");
          items.add({
            "EVIDENCE_OUT_ITEM_ID": "",
            "EVIDENCE_OUT_ID": "",
            "STOCK_ID": "1",
            "QTY": double.parse(itemEvidence[i].ItemsController.editDefectiveNumber.text),
            "QTY_UNIT": itemEvidence[i].BALANCE_QTY_UNIT,
            "PRODUCT_SIZE": "",
            "PRODUCT_SIZE_UNIT": "",
            "NET_VOLUMN": "",
            "NET_VOLUMN_UNIT": "",
            "IS_RETURN": "0",
            "IS_ACTIVE": "1"
          });
        }
      }
    }

    return items;
  }
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
