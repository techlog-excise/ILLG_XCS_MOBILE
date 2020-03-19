import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix1;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_division_rate.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_product.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/future/check_evidence_future.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_main.dart';
import 'package:prototype_app_pang/main_menu/compare/compare_screen.dart';
import 'package:prototype_app_pang/main_menu/compare/future/compare_future.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_main.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/future/lawsuit_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/model/lawsuit_form_list.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_lawsuit_staff.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_lawsuit_type.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_main.dart';
import 'package:prototype_app_pang/main_menu/prove/prove_manage_evidence_screen.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/SetProductNameProve.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/model/choice.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

import 'future/prove_future.dart';
import 'model/prove_arrest.dart';
import 'model/prove_arrest_product.dart';
import 'model/prove_product.dart';
import 'model/prove_science.dart';
import 'model/prove_staff.dart';

const double _kPickerSheetHeight = 216.0;

class ProveMainScreenFragment extends StatefulWidget {
  ItemsProveMain itemsProveMain;
  List<ItemsProveStaff> itemsProveSatff;
  ItemsProveScience itemsProveScience;
  List<ItemsProveProduct> itemsProveProduct;
  //ItemsProveEvidence itemsProveEvidence;
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsProveArrest itemsProveArrest;
  //List<ItemsProveArrestIndicmentProduct> itemsIndicmentProduct;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  List<ItemsProveArrestProduct> itemsProveArrestProduct;
  bool IsCreate;
  bool IsEdit;
  bool IsPreview;
  bool IS_COMPARE_COMPARE;
  ProveMainScreenFragment({
    Key key,
    @required this.itemsProveMain,
    @required this.itemsProveSatff,
    @required this.itemsProveScience,
    //@required this.itemsProveEvidence,
    @required this.itemsProveProduct,
    @required this.itemsProveArrest,
    //@required this.itemsIndicmentProduct,
    @required this.itemsProveArrestProduct,
    @required this.ItemsPerson,
    @required this.IsCreate,
    @required this.IsEdit,
    @required this.IsPreview,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
    @required this.IS_COMPARE_COMPARE,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<ProveMainScreenFragment> with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  //พิสูจน์นอกสถานที่ทำการ
  bool IsOutside = true;
  //พิสูจน์ของกลาง
  bool IsProve = false;
  //นำส่งของกลางเพื่อจัดเก็บ
  bool IsDeliveredStorage = true;

  bool IsProductStorageAll = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลคดี'),
    Choice(title: 'ตรวจรับของกลาง'),
    Choice(title: 'พิสูจน์ของกลาง'),
    Choice(title: 'สรุปผลรายงานการพิสูจน์'),
  ];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
    //const Constants(text: 'ยกเลิกนำส่งของกลาง',icon: Icons.directions_car),
  ];

  //item หลักทั้งหมด
  ItemsProveMain itemsProveMain;
  List<ItemsProveStaff> itemsProveStaff;
  ItemsProveScience itemsProveScience;
  List<ItemsProveProduct> itemsProveProduct;
  ItemsEvidenceMain itemsProveEvidence;

  // ItemsPersonInformation _itemsStaff;
  ItemsOAGMasStaff _itemsStaff;

  ItemsProveArrest itemsProveArrest;
  //item ของกลาง
  //List<ItemsProveArrestIndicmentProduct> itemsIndicmentProduct;
  List<ItemsProveArrestProduct> itemsProveArrestProduct;

  //ItemsProveMain itemMain;
  //item forms
  List<ItemsLawsuitForms> itemsFormsTab3 = [];

  //วันที่อละเวลาปัจจุบัน
  String _currentProveDate, _currentDeriveredDate, _currentProveEvidenceDate, _currentDeliverDate, _currentProveTime, _currentDeriveredTime, _currentProveEvidenceTime, _currentDeliverTime;
  var dateFormatDate, dateFormatTime;
  //_dt
  DateTime _dtCheckEvidence = DateTime.now();
  DateTime _dtProve = DateTime.now();
  DateTime _dtDerivered = DateTime.now();
  DateTime _dtDeliverDate = DateTime.now();

  //node focus Date
  final FocusNode myFocusNodeDeriveredDate = FocusNode();
  final FocusNode myFocusNodeDeriveredTime = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceDate = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceTime = FocusNode();
  final FocusNode myFocusNodeProveEvidenceDate = FocusNode();
  final FocusNode myFocusNodeProveEvidenceTime = FocusNode();
  final FocusNode myFocusNodeDeliverDate = FocusNode();
  final FocusNode myFocusNodeDeliverTime = FocusNode();
  //node focus ตรวจรับของกลาง
  final FocusNode myFocusNodeCheckEvidenceNumber = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceYear = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePlace = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePersonName = FocusNode();
  //node focus พิสูจน์ของกลาง
  final FocusNode myFocusNodeProveCommand = FocusNode();
  final FocusNode myFocusNodeProvePerson = FocusNode();
  final FocusNode myFocusNodeProveLabNumber = FocusNode();
  final FocusNode myFocusNodeProveLabYear = FocusNode();
  final FocusNode myFocusNodeProvePetitionNumber = FocusNode();
  final FocusNode myFocusNodeProveReportNumber = FocusNode();
  //node focus นำส่งเพื่อจัดเก็บ
  final FocusNode myFocusNodeDeriveredNumber = FocusNode();
  final FocusNode myFocusNodeDeriveredYear = FocusNode();
  final FocusNode myFocusNodeDeriveredPersonName = FocusNode();
  final FocusNode myFocusNodeDeriveredDepartment = FocusNode();
  final FocusNode myFocusNodeDeriveredStockName = FocusNode();
  final FocusNode myFocusNodeDeriveredTransport = FocusNode();
  //node focus สรุปผลรายงานการพิสูจน์
  final FocusNode myFocusNodeRemark = FocusNode();
  //textfield ตรวจรับของกลาง
  TextEditingController editCheckEvidenceNumber = new TextEditingController();
  TextEditingController editCheckEvidenceYear = new TextEditingController();
  TextEditingController editCheckEvidencePlace = new TextEditingController();
  TextEditingController editCheckEvidencePersonName = new TextEditingController();
  //textfield พิสูจน์ของกลาง
  TextEditingController editProveCommand = new TextEditingController();
  TextEditingController editProvePerson = new TextEditingController();
  TextEditingController editProveLabNumber = new TextEditingController();
  TextEditingController editProveLabYear = new TextEditingController();
  TextEditingController editProvePetitionNumber = new TextEditingController();
  TextEditingController editProveReportNumber = new TextEditingController();
  //textfield นำส่งเพื่อจัดเก็บ
  TextEditingController editDeriveredNumber = new TextEditingController();
  TextEditingController editDeriveredYear = new TextEditingController();
  TextEditingController editDeriveredPersonName = new TextEditingController();
  TextEditingController editDeriveredDepartment = new TextEditingController();
  TextEditingController editDeriveredStockName = new TextEditingController();
  TextEditingController editDeriveredTransport = new TextEditingController();
  //textfield Date
  TextEditingController editDeriveredDate = new TextEditingController();
  TextEditingController editDeriveredTime = new TextEditingController();
  TextEditingController editCheckEvidenceDate = new TextEditingController();
  TextEditingController editCheckEvidenceTime = new TextEditingController();
  TextEditingController editProveEvidenceDate = new TextEditingController();
  TextEditingController editProveEvidenceTime = new TextEditingController();
  TextEditingController editDeliverDate = new TextEditingController();
  TextEditingController editDeliverTime = new TextEditingController();
  //textfield สรุปผลรายงานการพิสูจน์
  TextEditingController editRemark = new TextEditingController();

  final FocusNode myFocusNodeProductStorageCount = FocusNode();
  final FocusNode myFocusNodeProductStorageVolumn = FocusNode();
  TextEditingController editProductStorageCount = new TextEditingController();
  TextEditingController editProductStorageVolumn = new TextEditingController();

  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStylePay = TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textStyleDataTitle = TextStyle(fontSize: 18, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = Styles.textStyleStar;
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2), fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

  DateTime checkEvidenceTime = DateTime.now();
  DateTime proveEvidenceTime = DateTime.now();
  DateTime deliverTime = DateTime.now();
  DateTime deriveredTime = DateTime.now();
  String _checkEvidenceDate, _proveEvidenceDate, _deliverDate, _deriveredDate;

  final formatter = new NumberFormat("#,##0.0000");
  final formatter_pr = new NumberFormat("#,##0.00");

  bool IsCompareComplete = false;

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
    //วันและเวลาตรวจสอบของกลาง
    _currentProveDate = date;
    _currentProveTime = dateFormatTime.format(DateTime.now()).toString();
    //วันและเวลาวันที่พิสูจน์
    _currentProveEvidenceDate = date;
    _currentProveEvidenceTime = dateFormatTime.format(DateTime.now()).toString();
    //วันและเวลาวันที่นำส่ง(Lab)
    _currentDeliverDate = date;
    _currentDeliverTime = dateFormatTime.format(DateTime.now()).toString();
    //วันและเวลานำส่งเพื่อจัดเก็บ
    _currentDeriveredDate = date;
    _currentDeriveredTime = dateFormatTime.format(DateTime.now()).toString();

    _checkEvidenceDate = DateTime.now().toString();
    _proveEvidenceDate = DateTime.now().toString();
    _deliverDate = DateTime.now().toString();
    _deriveredDate = DateTime.now().toString();

    editCheckEvidenceDate.text = _currentProveDate;
    editDeliverDate.text = _currentDeliverDate;
    editDeriveredDate.text = _currentDeriveredDate;
    editProveEvidenceDate.text = _currentProveEvidenceDate;

    editCheckEvidenceTime.text = _currentProveTime;
    editDeriveredTime.text = _currentDeriveredTime;
    editDeliverTime.text = _currentDeliverTime;
    editProveEvidenceTime.text = _currentProveEvidenceTime;

    editCheckEvidenceYear.text = _convertYear(DateTime.now().toString());
    editDeriveredYear.text = _convertYear(DateTime.now().toString());
    editProveLabYear.text = _convertYear(DateTime.now().toString());

    //itemMain=widget.itemsProveArrest;
    itemsProveArrest = widget.itemsProveArrest;
    //itemsIndicmentProduct = widget.itemsIndicmentProduct;
    itemsProveArrestProduct = widget.itemsProveArrestProduct;
    itemsProveArrestProduct.sort((a, b) => a.PRODUCT_GROUP_ID.compareTo(b.PRODUCT_GROUP_ID));

    itemsProveArrestProduct.forEach((item) {
      item.controller.editQuantity.text = item.QUANTITY.toString();
      item.controller.editVolume.text = item.VOLUMN.toString();
    });

    _itemsStaff = widget.ItemsPerson;

    //set staff
    String title = widget.ItemsPerson.TITLE_SHORT_NAME_TH != null ? widget.ItemsPerson.TITLE_SHORT_NAME_TH : "";
    String firstname = widget.ItemsPerson.FIRST_NAME != null ? widget.ItemsPerson.FIRST_NAME : "";
    String lastname = widget.ItemsPerson.LAST_NAME != null ? widget.ItemsPerson.LAST_NAME : "";
    editCheckEvidencePersonName.text = title + firstname + " " + lastname;
    editProvePerson.text = title + firstname + " " + lastname;
    editDeriveredPersonName.text = title + firstname + " " + lastname;

    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsEdit;

      itemsProveMain = widget.itemsProveMain;
      itemsProveStaff = widget.itemsProveSatff;
      itemsProveProduct = widget.itemsProveProduct;
      if (itemsProveMain.IS_SCIENCE == 1) {
        itemsProveScience = widget.itemsProveScience;
      }

      IsCompareComplete = widget.IS_COMPARE_COMPARE;

      _setInitDataProve();
      _setDataSaved();
    }
    if (widget.IsEdit) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      //_onEdited = widget.IsEdit;
      _setInitDataProve();
    }
  }

  void _setInitDataProve() {
    //tab 2
    editCheckEvidenceNumber.text = itemsProveMain.PROVE_NO;
    editCheckEvidenceYear.text = (int.parse(itemsProveMain.PROVE_NO_YEAR) + 543).toString() /*itemsProveMain.PROVE_NO_YEAR*/;
    editCheckEvidencePlace.text = itemsProveMain.RECEIVE_OFFICE_NAME;
    _currentProveDate = _convertDate(itemsProveMain.PROVE_DATE);
    _currentProveTime = _convertTime(itemsProveMain.PROVE_DATE);
    _dtCheckEvidence = DateTime.parse(itemsProveMain.PROVE_DATE);
    //IsOutside = itemMain.CheckEvidence.IsOutside;

    //tab 3
    editProveCommand.text = itemsProveMain.COMMAND;
    _currentProveEvidenceDate = _convertDate(itemsProveMain.RECEIVE_DOC_DATE);
    _currentProveEvidenceTime = _convertTime(itemsProveMain.RECEIVE_DOC_DATE);
    _dtProve = DateTime.parse(itemsProveMain.RECEIVE_DOC_DATE);
    IsProve = itemsProveMain.IS_SCIENCE == 1 ? true : false;
    if (itemsProveMain.IS_SCIENCE == 1) {
      if (itemsProveScience != null) {
        editProveLabNumber.text = itemsProveScience.DELIVERY_DOC_NO_1;
        editProveLabYear.text = itemsProveScience.DELIVERY_DOC_NO_2;
        editProvePetitionNumber.text = itemsProveScience.REQUEST_DOC_NO;
        editProveReportNumber.text = itemsProveScience.RESULT_DOC_NO;
      }
    }
    //tab4
    editRemark.text = itemsProveMain.PROVE_RESULT != null ? itemsProveMain.PROVE_RESULT.toString() : "";
    /*if(itemsProveMain.DELIVERY_DOC_NO_1!=null){
      editDeriveredNumber.text = itemsProveMain.DELIVERY_DOC_NO_1;
      editDeriveredYear.text = itemsProveMain.DELIVERY_DOC_NO_2;
      editDeriveredDepartment.text = itemsProveMain.DELIVERY_OFFICE_NAME;
      editDeriveredStockName.text = "";
      editDeriveredTransport.text = "";
      _currentDeriveredDate = _convertDate(itemsProveMain.DELIVERY_DOC_DATE);
      _currentDeriveredTime = _convertTime(itemsProveMain.DELIVERY_DOC_DATE);
      _dtDerivered = DateTime.parse(itemsProveMain.DELIVERY_DOC_DATE);
      IsDeliveredStorage = true;

      //itemsProveEvidence = widget.itemsProveEvidence;
    }else{
      IsDeliveredStorage=false;
    }*/

    //staff
    itemsProveStaff.forEach((item) {
      if (item.CONTRIBUTOR_ID == 22) {
        editCheckEvidencePersonName.text = item.TITLE_SHORT_NAME_TH.toString() + item.FIRST_NAME + " " + item.LAST_NAME;
      } else if (item.CONTRIBUTOR_ID == 25) {
        editProvePerson.text = item.TITLE_SHORT_NAME_TH.toString() + item.FIRST_NAME + " " + item.LAST_NAME;
      } else if (item.CONTRIBUTOR_ID == 26) {
        editDeriveredPersonName.text = item.TITLE_SHORT_NAME_TH.toString() + item.FIRST_NAME + " " + item.LAST_NAME;
      }
    });
  }

  void _setDataSaved() {
    //เพิ่ม item forms
    itemsFormsTab3 = [];
    itemsFormsTab3.add(new ItemsLawsuitForms("บันทึกตรวจรับของกลาง", "ILG60_00_05_001"));
    itemsFormsTab3.add(new ItemsLawsuitForms("บัญชีของกลาง ส.ส 2/4", "ILG60_00_05_002"));
    itemsFormsTab3.add(new ItemsLawsuitForms("บันทึกการตรวจพิสูจน์นอกสถานที่", "ILG60_00_05_003"));
    //itemsFormsTab3.add(new ItemsLawsuitForms("บันทึกการนำส่งของกลาง (ขก. 1)",""));
    //เพิ่ม tab แบบฟอร์ม
    choices.add(Choice(title: 'แบบฟอร์ม'));
    int index = 3;
    tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
    tabController.animateTo(choices.length - 1);
  }

  String _convertDate(String sDate) {
    String result;
    DateTime dt = DateTime.parse(sDate);
    List splits = dateFormatDate.format(dt).toString().split(" ");
    result = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

    return result;
  }

  String _convertTime1(String sDate) {
    /* DateTime dt = DateTime.parse(sDate);
    String result = "เวลา " + dateFormatTime.format(dt).toString();*/
    String result = "เวลา " + sDate.substring(0, 5) + " น.";
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

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    //dismiss textfield for tab 2
    editCheckEvidenceNumber.dispose();
    editCheckEvidenceYear.dispose();
    editCheckEvidencePlace.dispose();
    editCheckEvidencePersonName.dispose();
    //dismiss textfield for tab 3
    editProvePerson.dispose();
    editProveCommand.dispose();
    editProveLabNumber.dispose();
    editProveLabYear.dispose();
    editProvePetitionNumber.dispose();
    editProveReportNumber.dispose();
    //dismiss textfield for tab 4
    editDeriveredNumber.dispose();
    editDeriveredYear.dispose();
    editDeriveredPersonName.dispose();
    editDeriveredDepartment.dispose();
    editDeriveredStockName.dispose();
    editDeriveredTransport.dispose();

    editProductStorageVolumn.dispose();
    editProductStorageCount.dispose();

    editRemark.dispose();
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
        _onFinish = false;
        _onEdited = true;

        final pos = tabController.length - 1;
        choices.removeAt(pos);
        int index = tabController.index;
        tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
        _tabPageSelector = new TabPageSelector(controller: tabController);
      } else {
        _onDeleted = true;
        _showDeleteAlertDialog();
      }
    });
  }

  // delete dialog
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
                  onDeleted();
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void onDeleted() async {
    Map map_prove = {"PROVE_ID": itemsProveMain.PROVE_ID};
    print(map_prove);
    List<Map> map_staff = [];
    itemsProveStaff.forEach((item) {
      if (item.CONTRIBUTOR_ID == 22) {
        map_staff.add({"STAFF_ID": item.STAFF_ID});
      } else if (item.CONTRIBUTOR_ID == 25) {
        map_staff.add({"STAFF_ID": item.STAFF_ID});
      } else if (item.CONTRIBUTOR_ID == 26) {
        map_staff.add({"STAFF_ID": item.STAFF_ID});
      }
    });
    Map map_science;
    if (itemsProveScience != null) {
      map_science = {"SCIENCE_ID": itemsProveScience.SCIENCE_ID};
    }

    List<Map> map_pro = [];
    itemsProveProduct.forEach((item) {
      map_pro.add({"PRODUCT_ID": item.PRODUCT_ID});
    });

    /*Map map_evidence = {
      "EVIDENCE_IN_ID": 45
    };*/

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionInsLawsuitDelete(map_prove, map_staff, map_science, map_pro);
    Navigator.pop(context, "Delete");
  }

  Future<bool> onLoadActionInsLawsuitDelete(Map map_prove, List<Map> map_staff, Map map_science, List<Map> map_pro) async {
    await new ProveFuture().apiRequestProveupdDelete(map_prove).then((onValue) {
      print("Delete Prove : " + onValue.Msg);
    });
    for (int i = 0; i < map_staff.length; i++) {
      await new ProveFuture().apiRequestProveStaffupdDelete(map_staff[i]).then((onValue) {
        print("Delete Staff : " + onValue.Msg);
      });
    }
    if (map_science != null) {
      await new ProveFuture().apiRequestProveScienceupdDelete(map_science).then((onValue) {
        print("Delete Science : " + onValue.Msg);
      });
    }
    for (int i = 0; i < map_pro.length; i++) {
      await new ProveFuture().apiRequestProveProductupdDelete(map_pro[i]).then((onValue) {
        print("Delete Product: " + onValue.Msg);
      });
    }

    /*_onSaved = false;
    _onEdited = true;
    _onSave = false;
    clearTextfield();
    choices.removeAt(choices.length-1);*/
    Navigator.pop(context, "Back");

    setState(() {});
    return true;
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
                    _onFinish = true;

                    //เพิ่ม tab แบบฟอร์ม
                    itemsFormsTab3 = [];
                    itemsFormsTab3.add(new ItemsLawsuitForms("บันทึกตรวจรับของกลาง", "ILG60_00_05_001"));
                    itemsFormsTab3.add(new ItemsLawsuitForms("บัญชีของกลาง ส.ส 2/4", "ILG60_00_05_002"));
                    itemsFormsTab3.add(new ItemsLawsuitForms("บันทึกการตรวจพิสูจน์นอกสถานที่", "ILG60_00_05_003"));
                    //itemsFormsTab3.add(new ItemsLawsuitForms("บันทึกการนำส่งของกลาง (ขก. 1)",""));
                    choices.add(Choice(title: 'แบบฟอร์ม'));
                    int index = 3;
                    tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
                    _tabPageSelector = new TabPageSelector(controller: tabController);
                    tabController.animateTo(choices.length - 1);
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

  Future<bool> onLoadActionProveinsAll(Map map) async {
    int PROVE_ID;
    List<int> PRODUCT_ID = [];
    int STAFF_ID;
    int SCIENCE_ID;
    await new ProveFuture().apiRequestProveinsAll(map).then((onValue) {
      print("Insert Prove : " + onValue.Msg + " , " + onValue.PROVE_ID.toString());
      PROVE_ID = onValue.PROVE_ID;
    });

    List<Map> map_staff = [_createMapStaff(PROVE_ID, 22, null), _createMapStaff(PROVE_ID, 25, null), _createMapStaff(PROVE_ID, 26, null)];
    for (int i = 0; i < map_staff.length; i++) {
      await new ProveFuture().apiRequestProveStaffinsAll(map_staff[i]).then((onValue) {
        STAFF_ID = onValue.STAFF_ID;
        print("Insert Staff [" + i.toString() + "] : " + onValue.Msg);
      });
    }
    //นำส่งทางวิทยาศาลตร์
    if (IsProve) {
      Map map_science = {
        "SCIENCE_ID": "",
        "PROVE_ID": PROVE_ID,
        "SCIENCE_CODE": "",
        "DELIVERY_DOC_NO_1": editProveLabNumber.text,
        "DELIVERY_DOC_NO_2": editProveLabYear.text,
        "DELIVERY_DOC_DATE": _dtDeliverDate.toString(),
        "REQUEST_DOC_NO": editProvePetitionNumber.text,
        "REQUEST_DOC_DATE": DateTime.now().toString(),
        "RESULT_DOC_NO": editProveReportNumber.text,
        "RESULT_DOC_DATE": DateTime.now().toString(),
        "SCIENCE_RESULT_DESC": "",
        "IS_ACTIVE": "1"
      };
      await new ProveFuture().apiRequestProveScienceinsAll(map_science).then((onValue) {
        SCIENCE_ID = onValue.SCIENCE_ID;
        print("Insert Science : " + onValue.Msg);
      });
    }

    //จัดเก็บของกลาง
    /*if(IsDeliveredStorage){
      Map map_evidence = {
        "EVIDENCE_IN_ID": "",
        "PROVE_ID": PROVE_ID,
        "EVIDENCE_IN_CODE": editDeriveredNumber.text+"/"+_convertYear(_dtDeliverDate.toString()),
        "EVIDENCE_IN_DATE": _dtDeliverDate.toString(),
        "RETURN_DATE": "",
        "IS_RECEIVE": 0,
        "DELIVERY_NO": editDeriveredNumber.text,
        "DELIVERY_DATE": DateTime.now().toString(),
        "EVIDENCE_IN_TYPE": 0,
        "REMARK": editDeriveredTransport.text,
        "IS_ACTIVE": 1,
        "IS_EDIT": 1,
        "EvidenceInItem": _createMapEvidence(),
        "EvidenceInStaff": [
          {
            "EVIDENCE_IN_STAFF_ID": "",
            "EVIDENCE_IN_ID": "",
            "STAFF_REF_ID": "",
            "TITLE_ID": 1,
            "STAFF_CODE": "",
            "ID_CARD": "",
            "STAFF_TYPE": 1,
            "TITLE_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
            "TITLE_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": "",
            "FIRST_NAME": _itemsStaff.FIRST_NAME,
            "LAST_NAME": _itemsStaff.LAST_NAME,
            "AGE": "",
            "OPERATION_POS_CODE": "",
            "OPREATION_POS_NAME": _itemsStaff.OPREATION_POS_NAME,
            "OPREATION_POS_LEVEL": "",
            "OPERATION_POS_LEVEL_NAME": _itemsStaff.OPREATION_POS_LAVEL_NAME,
            "OPERATION_DEPT_CODE": "",
            "OPERATION_DEPT_NAME": "",
            "OPERATION_DEPT_LEVEL": "",
            "OPERATION_UNDER_DEPT_CODE": "",
            "OPERATION_UNDER_DEPT_NAME": "",
            "OPERATION_UNDER_DEPT_LEVEL": 0,
            "OPERATION_WORK_DEPT_CODE": null,
            "OPERATION_WORK_DEPT_NAME": null,
            "OPERATION_WORK_DEPT_LEVEL": 0,
            "OPERATION_OFFICE_CODE": widget.ItemsPerson.WorkOffCode,
            "OPERATION_OFFICE_NAME": "",
            "OPERATION_OFFICE_SHORT_NAME": "",
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
            "CONTRIBUTOR_ID": 13,
            "IS_ACTIVE": 1
          }
        ]
      };
      int EVIDENCE_IN_ID;
      await new CheckEvidenceFuture()
          .apiRequestEvidenceIninsAll(map_evidence)
          .then((onValue) {
        print("Insert Evidence : " + onValue.Msg);
        EVIDENCE_IN_ID = onValue.EVIDENCE_IN_ID;
        print("Evidence IN ID : " + onValue.EVIDENCE_IN_ID.toString());
      });

      //get By Con Evidence
      map_evidence={
        "EVIDENCE_IN_ID": EVIDENCE_IN_ID,
        "PROVE_ID": PROVE_ID,
      };
      await new CheckEvidenceFuture()
          .apiRequestEvidenceIngetByCon(map_evidence)
          .then((onValue) {
            itemsProveEvidence = onValue;
            print("Get Evidence : "+onValue.EVIDENCE_IN_ID.toString());
      });
    }*/
    if (itemsProveArrestProduct.length > 0) {
      Map map_evidence = {
        "EVIDENCE_IN_ID": "",
        "PROVE_ID": PROVE_ID,
        "EVIDENCE_IN_CODE": "",
        "EVIDENCE_IN_DATE": "",
        "RETURN_DATE": "",
        "IS_RECEIVE": 0,
        "DELIVERY_NO": "",
        "DELIVERY_DATE": "",
        "EVIDENCE_IN_TYPE": 0,
        "REMARK": "",
        "IS_ACTIVE": 1,
        "IS_EDIT": 1,
        "EvidenceInItem": /*_createMapEvidence()*/ [],
        "EvidenceInStaff": [
          {
            "EVIDENCE_IN_STAFF_ID": "",
            "EVIDENCE_IN_ID": "",
            "STAFF_REF_ID": "",
            "TITLE_ID": 1,
            "STAFF_CODE": "",
            "ID_CARD": "",
            "STAFF_TYPE": 1,
            "TITLE_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
            "TITLE_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": "",
            "FIRST_NAME": _itemsStaff.FIRST_NAME,
            "LAST_NAME": _itemsStaff.LAST_NAME,
            "AGE": "",
            "OPERATION_POS_CODE": "",
            "OPREATION_POS_NAME": _itemsStaff.OPREATION_POS_NAME,
            "OPREATION_POS_LEVEL": "",
            "OPERATION_POS_LEVEL_NAME": _itemsStaff.OPREATION_POS_LAVEL_NAME,
            "OPERATION_DEPT_CODE": "",
            "OPERATION_DEPT_NAME": "",
            "OPERATION_DEPT_LEVEL": "",
            "OPERATION_UNDER_DEPT_CODE": "",
            "OPERATION_UNDER_DEPT_NAME": "",
            "OPERATION_UNDER_DEPT_LEVEL": 0,
            "OPERATION_WORK_DEPT_CODE": null,
            "OPERATION_WORK_DEPT_NAME": null,
            "OPERATION_WORK_DEPT_LEVEL": 0,
            "OPERATION_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE,
            "OPERATION_OFFICE_NAME": widget.ItemsPerson.OPERATION_OFFICE_NAME,
            "OPERATION_OFFICE_SHORT_NAME": widget.ItemsPerson.OPERATION_OFFICE_SHORT_NAME,
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
            "CONTRIBUTOR_ID": 59,
            "IS_ACTIVE": 1
          }
        ]
      };
      for (int i = 0; i < _createMapProduct(PROVE_ID, SCIENCE_ID).length; i++) {
        await new ProveFuture().apiRequestProveProductinsAll(_createMapProduct(PROVE_ID, SCIENCE_ID)[i]).then((onValue) {
          print("Insert Product : " + onValue.Msg + ", " + onValue.PRODUCT_ID.toString());
          PRODUCT_ID.add(onValue.PRODUCT_ID);
        });
      }

      /*int EVIDENCE_IN_ID;
      await new CheckEvidenceFuture()
          .apiRequestEvidenceIninsAll(map_evidence)
          .then((onValue) {
        print("Insert Evidence : " + onValue.Msg);
        EVIDENCE_IN_ID = onValue.EVIDENCE_IN_ID;
        print("Evidence IN ID : " + onValue.EVIDENCE_IN_ID.toString());
      });

      //get By Con Evidence
      map_evidence={
        "EVIDENCE_IN_ID": EVIDENCE_IN_ID,
        "PROVE_ID": PROVE_ID,
      };
      await new CheckEvidenceFuture()
          .apiRequestEvidenceIngetByCon(map_evidence)
          .then((onValue) {
        itemsProveEvidence = onValue;
        print("Get Evidence : "+onValue.EVIDENCE_IN_ID.toString());
      });*/

    }

    List<Map> _arrJsonImg = [];
    List<File> _arrFiles = [];
    List<Map> _arrJsonImgUpdate = [];
    List<Map> _arrJsonImgDelete = [];
    int index = 0;
    for (int i = 0; i < PRODUCT_ID.length; i++) {
      itemsProveArrestProduct.forEach((item) {
        //Add
        item.itemsListDocument.forEach((_file) {
          String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
          index++;
          _arrJsonImg.add({
            "DATA_SOURCE": "",
            "DOCUMENT_ID": "",
            //"DOCUMENT_NAME": item.PRODUCT_MAPPING_ID.toString()+"_"+item.PRODUCT_GROUP_ID.toString()+"_"+item.PRODUCT_CATEGORY_ID.toString()+"_"+index.toString(),
            "DOCUMENT_OLD_NAME": _file.DOCUMENT_NAME,
            "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
            "DOCUMENT_TYPE": "5",
            "FILE_TYPE": "jpg",
            "FOLDER": "product",
            "IS_ACTIVE": "1",
            "REFERENCE_CODE": PRODUCT_ID[i],
            "CONTENT": base64Image
          });
          _arrFiles.add(_file.FILE_CONTENT);
        });
      });
    }

    for (int i = 0; i < _arrJsonImg.length; i++) {
      await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i], _arrFiles[i]).then((onValue) {
        print("[" + i.toString() + "] : " + onValue.DOCUMENT_ID.toString());
      });
    }

    //get by con
    Map map_prove_id = {"PROVE_ID": PROVE_ID};
    print(map_prove_id.toString());
    await new ProveFuture().apiRequestProvegetByCon(map_prove_id).then((onValue) {
      itemsProveMain = onValue;
      print(onValue.PROVE_ID);
    });
    await new ProveFuture().apiRequestProveStaffgetByCon(map_prove_id).then((onValue) {
      itemsProveStaff = onValue;
    });
    await new ProveFuture().apiRequestProveSciencegetByCon(map_prove_id).then((onValue) {
      if (onValue.length > 0) {
        itemsProveScience = onValue.first;
      }
    });
    await new ProveFuture().apiRequestProveProductgetByProveId(map_prove_id).then((onValue) {
      itemsProveProduct = onValue;
    });

    _onSaved = true;
    _onFinish = true;
    _onEdited = false;
    _setDataSaved();

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionProveupdAll(Map map_prove, Map map_science, List<Map> map_staff, List<Map> map_pro) async {
    await new ProveFuture().apiRequestProveupdByCon(map_prove).then((onValue) {
      print("Update Prove : " + onValue.Msg);
    });
    if (IsProve) {
      await new ProveFuture().apiRequestProveScienceupdByCon(map_prove).then((onValue) {
        print("Update Prove : " + onValue.Msg);
      });
    }

    if (map_science == null) {
      if (IsProve) {
        map_science = {
          "SCIENCE_ID": "",
          "PROVE_ID": itemsProveMain.PROVE_ID,
          "SCIENCE_CODE": "",
          "DELIVERY_DOC_NO_1": editProveLabNumber.text,
          "DELIVERY_DOC_NO_2": editProveLabYear.text,
          "DELIVERY_DOC_DATE": _dtDeliverDate.toString(),
          "REQUEST_DOC_NO": editProvePetitionNumber.text,
          "REQUEST_DOC_DATE": DateTime.now().toString(),
          "RESULT_DOC_NO": editProveReportNumber.text,
          "RESULT_DOC_DATE": DateTime.now().toString(),
          "SCIENCE_RESULT_DESC": "",
          "IS_ACTIVE": "1"
        };
        await new ProveFuture().apiRequestProveScienceinsAll(map_science).then((onValue) {
          print("Update Add Science : " + onValue.Msg);
        });
      }
    } else {
      if (IsProve) {
        await new ProveFuture().apiRequestProveScienceupdByCon(map_science).then((onValue) {
          print("Update Science : " + onValue.Msg);
        });
      } else {
        await new ProveFuture().apiRequestProveScienceupdDelete(map_science).then((onValue) {
          print("Update Delete Science : " + onValue.Msg);
        });
      }
    }

    /*for(int i=0;i<map_pro.length;i++){
      await new ProveFuture().apiRequestProveProductupdByCon(map_pro[i]).then((onValue) {
        print("Update Product ["+i.toString()+"] : " + onValue.Msg);
      });
    }*/

    for (int i = 0; i < map_staff.length; i++) {
      await new ProveFuture().apiRequestProveScienceupdByCon(map_staff[i]).then((onValue) {
        print("Update Staff [" + i.toString() + "] : " + onValue.Msg);
      });
    }

    //get by con
    Map map_prove_id = {"PROVE_ID": itemsProveMain.PROVE_ID};
    print(map_prove_id.toString());
    await new ProveFuture().apiRequestProvegetByCon(map_prove_id).then((onValue) {
      itemsProveMain = onValue;
      print(onValue.PROVE_ID);
    });
    await new ProveFuture().apiRequestProveStaffgetByCon(map_prove_id).then((onValue) {
      itemsProveStaff = onValue;
    });
    await new ProveFuture().apiRequestProveSciencegetByCon(map_prove_id).then((onValue) {
      if (onValue.length > 0) {
        itemsProveScience = onValue.first;
      }
    });
    await new ProveFuture().apiRequestProveProductgetByProveId(map_prove_id).then((onValue) {
      itemsProveProduct = onValue;
    });

    _onSaved = true;
    _onFinish = true;
    _onEdited = false;
    _setDataSaved();

    setState(() {});
    return true;
  }

  //เมื่อกดปุ่มบันทึก
  void onSaved(BuildContext mContext) async {
    bool IsNonProve = false;
    bool IsOverItemDelivered = false;
    if (itemsProveArrest.GROUP_SECTION_SECTION_ID != 203 || itemsProveArrest.GROUP_SECTION_SECTION_ID != 204) {
      IsNonProve = false;
      int count = 0;
      itemsProveArrestProduct.forEach((item) {
        if (item.IS_PROVE) {
          count++;
        }
      });
      if (count != itemsProveArrestProduct.length) {
        IsNonProve = true;
      }
    } else {
      if (_onEdited) {
        for (int i = 0; i < itemsProveProduct.length; i++) {
          if (itemsProveProduct[i].VAT > 0) {
            IsNonProve = false;
          } else {
            IsNonProve = true;
            break;
          }
        }
      } else {
        for (int i = 0; i < itemsProveArrestProduct.length; i++) {
          if (itemsProveArrestProduct[i].VAT > 0) {
            IsNonProve = false;
          } else {
            IsNonProve = true;
            break;
          }

          if (double.parse(itemsProveArrestProduct[i].controller.editQuantity.text.replaceAll(",", "")) > itemsProveArrestProduct[i].QUANTITY || double.parse(itemsProveArrestProduct[i].controller.editVolume.text.replaceAll(",", "")) > itemsProveArrestProduct[i].VOLUMN) {
            IsOverItemDelivered = true;
            break;
          } else {
            IsOverItemDelivered = false;
          }
        }
      }
    }

    if (editCheckEvidenceNumber.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกเลขทะเบียนตรวจพิสูจน์');
    } else if (editCheckEvidencePlace.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกที่ช่องเขียนที่');
    } else if (IsNonProve) {
      new VerifyDialog(mContext, 'กรุณาพิสูจน์ของกลางให้ครบ');
    } else if (editRemark.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกสรุปผลรายงานการพิสูจน์');
    } /*else if (IsDeliveredStorage&&editDeriveredNumber.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกเลขที่หนังสือนำส่งเพื่อจัดเก็บ');
    }else if (IsDeliveredStorage&&editDeriveredDepartment.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกหน่วยงานต้นทางนำส่งเพื่อจัดเก็บ');
    }else if (IsDeliveredStorage&&IsOverItemDelivered) {
      new VerifyDialog(mContext, 'จำนวนหรือปริมาณนำส่งต้อไม่เกินจำนวนที่มีอยู่');
    }*/
    else {
      if (!_onEdited) {
        final fmt = DateFormat('MM-dd');
        String lawsuit_no_year = widget.itemsProveArrest.LAWSUIT_NO_YEAR + "-" + fmt.format(DateTime.now());

        Map map_prove = {
          "PROVE_ID": "",
          "LAWSUIT_ID": itemsProveArrest.LAWSUIT_ID,
          "DELIVERY_OFFICE_ID": "1",
          "RECEIVE_OFFICE_ID": "1",
          "PROVE_TYPE": "0",
          /*"DELIVERY_DOC_NO_1": IsDeliveredStorage ? editDeriveredNumber.text : "",
          "DELIVERY_DOC_NO_2": IsDeliveredStorage ? editDeriveredYear.text : "",
          "DELIVERY_DOC_DATE": IsDeliveredStorage ? _dtDeliverDate.toString() : "",
          "DELIVERY_OFFICE_CODE": */ /*"003"*/ /* "",
          "DELIVERY_OFFICE_NAME": IsDeliveredStorage ?editDeriveredDepartment.text:"",*/
          "DELIVERY_DOC_NO_1": "",
          "DELIVERY_DOC_NO_2": "",
          "DELIVERY_DOC_DATE": "",
          "DELIVERY_OFFICE_CODE": "",
          "DELIVERY_OFFICE_NAME": "",
          "RECEIVE_OFFICE_CODE": itemsProveArrest.ARREST_CODE.substring(2, 8),
          "RECEIVE_OFFICE_NAME": editCheckEvidencePlace.text,
          "PROVE_NO": editCheckEvidenceNumber.text,
          "PROVE_NO_YEAR": _dtProve.toString() /*editCheckEvidenceYear.text*/,
          "RECEIVE_DOC_DATE": _dtCheckEvidence.toString(),
          "COMMAND": editProveCommand.text,
          "LAWSUIT_NO": itemsProveArrest.LAWSUIT_NO,
          "LAWSUIT_NO_YEAR": DateTime.now().toString(),
          "OCCURRENCE_DATE": "",
          "OUT_OFFICE_NAME": "",
          "IS_OUTSIDE": "1",
          "IS_SCIENCE": IsProve ? 1 : 0,
          "IS_RECEIVE": "1",
          "PROVE_DATE": _dtProve.toString(),
          "DELIVERY_PROVE_DOC_NO_1": "",
          "DELIVERY_PROVE_DOC_NO_2": "",
          "PROVE_RESULT": editRemark.text,
          "IS_ACTIVE": "1"
        };

        //print('in : '+itemsProveArrestProduct[0].controller.editQuantity.text);

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () {},
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            });
        await onLoadActionProveinsAll(map_prove);
        Navigator.pop(context);
      } else {
        final fmt = DateFormat('MM-dd');
        String lawsuit_no_year = widget.itemsProveArrest.LAWSUIT_NO_YEAR + "-" + fmt.format(DateTime.now());

        Map map_prove = {
          "PROVE_ID": itemsProveMain.PROVE_ID,
          "LAWSUIT_ID": itemsProveMain.LAWSUIT_ID,
          "DELIVERY_OFFICE_ID": "1",
          "RECEIVE_OFFICE_ID": "1",
          "PROVE_TYPE": "0",
          /*"DELIVERY_DOC_NO_1": IsDeliveredStorage ? editDeriveredNumber.text : "",
          "DELIVERY_DOC_NO_2": IsDeliveredStorage ? editDeriveredYear.text : "",
          "DELIVERY_DOC_DATE":
          IsDeliveredStorage ? _dtDeliverDate.toString() : "",
          "DELIVERY_OFFICE_CODE": */ /*"003"*/ /* "",
          "DELIVERY_OFFICE_NAME": editDeriveredDepartment.text,*/
          "DELIVERY_DOC_NO_1": "",
          "DELIVERY_DOC_NO_2": "",
          "DELIVERY_DOC_DATE": "",
          "DELIVERY_OFFICE_CODE": "",
          "DELIVERY_OFFICE_NAME": "",
          "RECEIVE_OFFICE_CODE": itemsProveArrest.ARREST_CODE.substring(2, 8),
          "RECEIVE_OFFICE_NAME": editCheckEvidencePlace.text,
          "PROVE_NO": editCheckEvidenceNumber.text,
          "PROVE_NO_YEAR": _dtProve.toString() /*editCheckEvidenceYear.text*/,
          "RECEIVE_DOC_DATE": _dtCheckEvidence.toString(),
          "COMMAND": editProveCommand.text,
          "LAWSUIT_NO": itemsProveArrest.LAWSUIT_NO,
          "LAWSUIT_NO_YEAR": /*lawsuit_no_year*/ DateTime.now().toString(),
          "OCCURRENCE_DATE": "",
          "OUT_OFFICE_NAME": "",
          "IS_OUTSIDE": "1",
          "IS_SCIENCE": IsProve ? 1 : 0,
          "IS_RECEIVE": "1",
          "PROVE_DATE": _dtProve.toString(),
          "DELIVERY_PROVE_DOC_NO_1": "",
          "DELIVERY_PROVE_DOC_NO_2": "",
          "PROVE_RESULT": editRemark.text,
          "IS_ACTIVE": "1"
        };

        Map map_science;
        if (itemsProveScience != null) {
          map_science = {
            "SCIENCE_ID": itemsProveScience.SCIENCE_ID,
            "PROVE_ID": itemsProveScience.PROVE_ID,
            "SCIENCE_CODE": "",
            "DELIVERY_DOC_NO_1": editProveLabNumber.text,
            "DELIVERY_DOC_NO_2": editProveLabYear.text,
            "DELIVERY_DOC_DATE": _dtDeliverDate.toString(),
            "REQUEST_DOC_NO": editProvePetitionNumber.text,
            "REQUEST_DOC_DATE": DateTime.now().toString(),
            "RESULT_DOC_NO": editProveReportNumber.text,
            "RESULT_DOC_DATE": DateTime.now().toString(),
            "SCIENCE_RESULT_DESC": "",
            "IS_ACTIVE": "1"
          };
        }

        List<Map> map_staff = [];
        itemsProveStaff.forEach((item) {
          if (item.CONTRIBUTOR_ID == 22) {
            map_staff.add(_createMapStaff(itemsProveMain.PROVE_ID, item.CONTRIBUTOR_ID, item.STAFF_ID));
          } else if (item.CONTRIBUTOR_ID == 25) {
            map_staff.add(_createMapStaff(itemsProveMain.PROVE_ID, item.CONTRIBUTOR_ID, item.STAFF_ID));
          } else if (item.CONTRIBUTOR_ID == 26) {
            map_staff.add(_createMapStaff(itemsProveMain.PROVE_ID, item.CONTRIBUTOR_ID, item.STAFF_ID));
          }
        });

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return WillPopScope(
                onWillPop: () {},
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
            });
        await onLoadActionProveupdAll(map_prove, map_science, map_staff, _createMapProduct(itemsProveMain.PROVE_ID, null));
        Navigator.pop(context);
      }
    }

    setState(() {});
  }

  List<Map> _createMapEvidence() {
    List<Map> map = [];
    itemsProveArrestProduct.forEach((item) {
      map.add({
        "EVIDENCE_IN_ITEM_ID": "",
        "EVIDENCE_IN_ITEM_CODE": "",
        "EVIDENCE_IN_ID": "",
        "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
        "PRODUCT_CODE": item.PRODUCT_CODE,
        "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
        "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
        "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
        "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
        "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
        "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
        "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
        "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
        "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
        "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
        "PRODUCT_GROUP_CODE": item.PRODUCT_GROUP_CODE,
        "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME,
        "PRODUCT_CATEGORY_CODE": item.PRODUCT_CATEGORY_CODE,
        "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME != null ? item.PRODUCT_CATEGORY_NAME : "",
        "PRODUCT_TYPE_CODE": item.PRODUCT_TYPE_CODE,
        "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME != null ? item.PRODUCT_TYPE_NAME : "",
        "PRODUCT_SUBTYPE_CODE": item.PRODUCT_SUBTYPE_CODE,
        "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME != null ? item.PRODUCT_SUBTYPE_NAME : "",
        "PRODUCT_SUBSETTYPE_CODE": item.PRODUCT_SUBSETTYPE_CODE,
        "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME != null ? item.PRODUCT_SUBSETTYPE_NAME : "",
        "PRODUCT_BRAND_CODE": item.PRODUCT_BRAND_CODE,
        "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH != null ? item.PRODUCT_BRAND_NAME_TH : "",
        "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN != null ? item.PRODUCT_BRAND_NAME_EN : "",
        "PRODUCT_SUBBRAND_CODE": item.PRODUCT_SUBBRAND_CODE,
        "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH != null ? item.PRODUCT_SUBBRAND_NAME_TH : "",
        "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN != null ? item.PRODUCT_SUBBRAND_NAME_EN : "",
        "PRODUCT_MODEL_CODE": item.PRODUCT_MODEL_CODE,
        "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH != null ? item.PRODUCT_MODEL_NAME_TH : "",
        "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN != null ? item.PRODUCT_MODEL_NAME_EN : "",
        "LICENSE_PLATE": item.LICENSE_PLATE != null ? item.LICENSE_PLATE : "",
        "ENGINE_NO": item.ENGINE_NO != null ? item.ENGINE_NO : "",
        "CHASSIS_NO": item.CHASSIS_NO != null ? item.CHASSIS_NO : "",
        "PRODUCT_DESC": item.PRODUCT_DESC != null ? item.PRODUCT_DESC : "",
        "SUGAR": item.SUGAR,
        "CO2": item.CO2,
        "DEGREE": item.DEGREE,
        "PRICE": item.PRICE,
        "DELIVERY_QTY": item.controller.editQuantity.text,
        "DELIVERY_QTY_UNIT": item.QUANTITY_UNIT,
        "DELIVERY_SIZE": "",
        "DELIVERY_SIZE_UNIT": "",
        "DELIVERY_NET_VOLUMN": item.controller.editVolume.text,
        "DELIVERY_NET_VOLUMN_UNIT": item.VOLUMN_UNIT,
        "DAMAGE_QTY": "",
        "DAMAGE_QTY_UNIT": "",
        "DAMAGE_SIZE": "",
        "DAMAGE_SIZE_UNIT": "",
        "DAMAGE_NET_VOLUMN": "",
        "DAMAGE_NET_VOLUMN_UNIT": "",
        "IS_DOMESTIC": 0,
        "IS_ACTIVE": 1,
        "EvidenceOutStockBalance": [
          /*{
            "STOCK_ID": "",
            "WAREHOUSE_ID": 1,
            "EVIDENCE_IN_ITEM_ID": "",
            "RECEIVE_QTY": item.controller.editQuantity.text,
            "RECEIVE_QTY_UNIT": item.QUANTITY_UNIT,
            "RECEIVE_SIZE": "",
            "RECEIVE_SIZE_UNIT": "",
            "RECEIVE_NET_VOLUMN": item.controller.editVolume.text,
            "RECEIVE_NET_VOLUMN_UNIT": item.VOLUMN_UNIT,
            "BALANCE_QTY": item.QUANTITY-double.parse(item.controller.editQuantity.text),
            "BALANCE_QTY_UNIT": item.QUANTITY_UNIT,
            "BALANCE_SIZE": "",
            "BALANCE_SIZE_UNIT": "",
            "BALANCE_NET_VOLUMN": "",
            "BALANCE_NET_VOLUMN_UNIT": "",
            "IS_FINISH": 2,
            "IS_RECEIVE": 1
          }*/
        ],
      });
    });
    return map;
  }

  List<Map> _createMapProduct(PROVE_ID, SCIENCE_ID) {
    List<Map> map = [];
    if (_onEdited) {
      itemsProveProduct.forEach((item) {
        print(item.VAT);
        map.add({
          "PRODUCT_ID": item.PRODUCT_ID,
          "PROVE_ID": PROVE_ID,
          "SCIENCE_ID": item.SCIENCE_ID,
          "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
          "PRODUCT_INDICTMENT_ID": item.PRODUCT_INDICTMENT_ID,
          "PRODUCT_MAPPING_REF_ID": item.PRODUCT_MAPPING_REF_ID,
          "PRODUCT_CODE": item.PRODUCT_CODE,
          "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
          "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
          "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
          "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
          "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
          "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
          "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
          "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
          "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
          "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
          "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
          "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
          "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
          "REMAIN_SIZES_UNIT_ID": item.REMAIN_SIZES_UNIT_ID,
          "REMAIN_QUATITY_UNIT_ID": item.REMAIN_QUATITY_UNIT_ID,
          "REMAIN_VOLUMN_UNIT_ID": item.REMAIN_VOLUMN_UNIT_ID,
          "PRODUCT_GROUP_CODE": item.PRODUCT_GROUP_CODE == null ? "" : item.PRODUCT_GROUP_CODE,
          "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME == null ? "" : item.PRODUCT_GROUP_NAME,
          "PRODUCT_CATEGORY_CODE": item.PRODUCT_CATEGORY_CODE == null ? "" : item.PRODUCT_CATEGORY_CODE,
          "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME == null ? "" : item.PRODUCT_CATEGORY_NAME,
          "PRODUCT_TYPE_CODE": item.PRODUCT_TYPE_CODE == null ? "" : item.PRODUCT_TYPE_CODE,
          "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME == null ? "" : item.PRODUCT_TYPE_NAME,
          "PRODUCT_SUBTYPE_CODE": item.PRODUCT_SUBTYPE_CODE == null ? "" : item.PRODUCT_SUBTYPE_CODE,
          "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME == null ? "" : item.PRODUCT_SUBTYPE_NAME,
          "PRODUCT_SUBSETTYPE_CODE": item.PRODUCT_SUBSETTYPE_CODE == null ? "" : item.PRODUCT_SUBSETTYPE_CODE,
          "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME == null ? "" : item.PRODUCT_SUBSETTYPE_NAME,
          "PRODUCT_BRAND_CODE": item.PRODUCT_BRAND_CODE == null ? "" : item.PRODUCT_BRAND_CODE,
          "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH == null ? "" : item.PRODUCT_BRAND_NAME_TH,
          "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN == null ? "" : item.PRODUCT_BRAND_NAME_EN,
          "PRODUCT_SUBBRAND_CODE": item.PRODUCT_SUBBRAND_CODE == null ? "" : item.PRODUCT_SUBBRAND_CODE,
          "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH == null ? "" : item.PRODUCT_SUBBRAND_NAME_TH,
          "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN == null ? "" : item.PRODUCT_SUBBRAND_NAME_EN,
          "PRODUCT_MODEL_CODE": item.PRODUCT_MODEL_CODE == null ? "" : item.PRODUCT_MODEL_CODE,
          "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH == null ? "" : item.PRODUCT_MODEL_NAME_TH,
          "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN == null ? "" : item.PRODUCT_MODEL_NAME_EN,
          "IS_TAX_VALUE": item.IS_TAX_VALUE,
          "TAX_VALUE": item.TAX_VALUE,
          "IS_TAX_VOLUMN": item.IS_TAX_VOLUMN,
          "TAX_VOLUMN": item.TAX_VOLUMN,
          "TAX_VOLUMN_UNIT": item.TAX_VOLUMN_UNIT,
          "LICENSE_PLATE": item.LICENSE_PLATE != null ? item.LICENSE_PLATE : "",
          "ENGINE_NO": item.ENGINE_NO != null ? item.ENGINE_NO : "",
          "CHASSIS_NO": item.CHASSIS_NO != null ? item.CHASSIS_NO : "",
          "PRODUCT_DESC": item.PRODUCT_DESC,
          "SUGAR": item.SUGAR,
          "CO2": item.CO2,
          "DEGREE": item.DEGREE,
          "PRICE": item.PRICE,
          "SIZES": item.SIZES,
          "SIZES_UNIT": item.SIZES_UNIT,
          "QUANTITY": item.QUANTITY,
          "QUANTITY_UNIT": item.QUANTITY_UNIT,
          "VOLUMN": item.VOLUMN,
          "VOLUMN_UNIT": item.VOLUMN_UNIT,
          "REMAIN_SIZES": item.REMAIN_SIZES,
          "REMAIN_SIZES_UNIT": item.REMAIN_SIZES_UNIT,
          "REMAIN_QUANTITY": item.REMAIN_QUANTITY,
          "REMAIN_QUANTITY_UNIT": item.REMAIN_QUANTITY_UNIT,
          "REMAIN_VOLUMN": item.REMAIN_VOLUMN,
          "REMAIN_VOLUMN_UNIT": item.REMAIN_VOLUMN_UNIT,
          "REMARK": item.REMARK == null ? "" : item.REMARK,
          "REMAIN_REMARK": item.REMAIN_REMARK,
          "PRODUCT_RESULT": item.PRODUCT_RESULT,
          "SCIENCE_RESULT_DESC": item.SCIENCE_RESULT_DESC,
          "VAT": item.VAT,
          "IS_DOMESTIC": item.IS_DOMESTIC,
          "IS_ILLEGAL": item.IS_ILLEGAL,
          "IS_SCIENCE": item.IS_SCIENCE,
          "IS_PROVE": 1,
          "IS_ACTIVE": 1
        });
      });
    } else {
      itemsProveArrestProduct.forEach((item) {
        map.add({
          "PRODUCT_ID": "",
          "PROVE_ID": PROVE_ID,
          "SCIENCE_ID": SCIENCE_ID,
          "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
          "PRODUCT_INDICTMENT_ID": "",
          "PRODUCT_MAPPING_REF_ID": "",
          "PRODUCT_CODE": item.PRODUCT_CODE,
          "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
          "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
          "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
          "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
          "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
          "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
          "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
          "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
          "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
          "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
          "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
          "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
          "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
          "REMAIN_SIZES_UNIT_ID": item.REMAIN_SIZES_UNIT_ID,
          "REMAIN_QUATITY_UNIT_ID": item.REMAIN_QUATITY_UNIT_ID,
          "REMAIN_VOLUMN_UNIT_ID": item.REMAIN_VOLUMN_UNIT_ID,
          "PRODUCT_GROUP_CODE": item.PRODUCT_GROUP_CODE == null ? "" : item.PRODUCT_GROUP_CODE,
          "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME == null ? "" : item.PRODUCT_GROUP_NAME,
          "PRODUCT_CATEGORY_CODE": item.PRODUCT_CATEGORY_CODE == null ? "" : item.PRODUCT_CATEGORY_CODE,
          "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME == null ? "" : item.PRODUCT_CATEGORY_NAME,
          "PRODUCT_TYPE_CODE": item.PRODUCT_TYPE_CODE == null ? "" : item.PRODUCT_TYPE_CODE,
          "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME == null ? "" : item.PRODUCT_TYPE_NAME,
          "PRODUCT_SUBTYPE_CODE": item.PRODUCT_SUBTYPE_CODE == null ? "" : item.PRODUCT_SUBTYPE_CODE,
          "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME == null ? "" : item.PRODUCT_SUBTYPE_NAME,
          "PRODUCT_SUBSETTYPE_CODE": item.PRODUCT_SUBSETTYPE_CODE == null ? "" : item.PRODUCT_SUBSETTYPE_CODE,
          "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME == null ? "" : item.PRODUCT_SUBSETTYPE_NAME,
          "PRODUCT_BRAND_CODE": item.PRODUCT_BRAND_CODE == null ? "" : item.PRODUCT_BRAND_CODE,
          "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH == null ? "" : item.PRODUCT_BRAND_NAME_TH,
          "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN == null ? "" : item.PRODUCT_BRAND_NAME_EN,
          "PRODUCT_SUBBRAND_CODE": item.PRODUCT_SUBBRAND_CODE == null ? "" : item.PRODUCT_SUBBRAND_CODE,
          "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH == null ? "" : item.PRODUCT_SUBBRAND_NAME_TH,
          "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN == null ? "" : item.PRODUCT_SUBBRAND_NAME_EN,
          "PRODUCT_MODEL_CODE": item.PRODUCT_MODEL_CODE == null ? "" : item.PRODUCT_MODEL_CODE,
          "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH == null ? "" : item.PRODUCT_MODEL_NAME_TH,
          "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN == null ? "" : item.PRODUCT_MODEL_NAME_EN,
          "IS_TAX_VALUE": item.IS_TAX_VALUE,
          "TAX_VALUE": item.TAX_VALUE,
          "IS_TAX_VOLUMN": item.IS_TAX_VOLUMN,
          "TAX_VOLUMN": item.TAX_VOLUMN,
          "TAX_VOLUMN_UNIT": item.TAX_VOLUMN_UNIT,
          "LICENSE_PLATE": item.LICENSE_PLATE != null ? item.LICENSE_PLATE : "",
          "ENGINE_NO": item.ENGINE_NO != null ? item.ENGINE_NO : "",
          "CHASSIS_NO": item.CHASSIS_NO != null ? item.CHASSIS_NO : "",
          "PRODUCT_DESC": item.PRODUCT_DESC,
          "SUGAR": item.SUGAR,
          "CO2": item.CO2,
          "DEGREE": item.DEGREE,
          "PRICE": item.PRICE,
          "SIZES": item.SIZES,
          "SIZES_UNIT": item.SIZES_UNIT,
          "QUANTITY": item.QUANTITY,
          "QUANTITY_UNIT": item.QUANTITY_UNIT,
          "VOLUMN": item.VOLUMN,
          "VOLUMN_UNIT": item.VOLUMN_UNIT,
          "REMAIN_SIZES": item.REMAIN_SIZES,
          "REMAIN_SIZES_UNIT": item.REMAIN_SIZES_UNIT,
          "REMAIN_QUANTITY": item.REMAIN_QUANTITY,
          "REMAIN_QUANTITY_UNIT": item.REMAIN_QUANTITY_UNIT,
          "REMAIN_VOLUMN": item.REMAIN_VOLUMN,
          "REMAIN_VOLUMN_UNIT": item.REMAIN_VOLUMN_UNIT,
          "REMARK": item.REMARK == null || item.REMARK.endsWith("null") ? "" : item.REMARK,
          "REMAIN_REMARK": item.REMAIN_REMARK,
          "PRODUCT_RESULT": item.PRODUCT_RESULT,
          "SCIENCE_RESULT_DESC": item.SCIENCE_RESULT_DESC,
          "VAT": item.VAT,
          "IS_DOMESTIC": item.IS_DOMESTIC,
          "IS_ILLEGAL": item.IS_ILLEGAL,
          "IS_SCIENCE": item.IS_SCIENCE,
          "IS_PROVE": item.IS_PROVE ? 1 : 0,
          "IS_ACTIVE": 1
        });
      });
    }
    return map;
  }

  Map _createMapStaff(int PROVE_ID, int CONTRIBUTOR_ID, int staff_id) {
    if (_onEdited) {
      return {
        "STAFF_ID": staff_id,
        "PROVE_ID": PROVE_ID,
        "COMPARE_DETAIL_ID": "",
        "STAFF_REF_ID": _itemsStaff.STAFF_ID,
        "TITLE_ID": _itemsStaff.TITLE_ID,
        "STAFF_CODE": "",
        "ID_CARD": "",
        "STAFF_TYPE": _itemsStaff.STAFF_TYPE,
        "TITLE_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
        "TITLE_NAME_EN": "",
        "TITLE_SHORT_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
        "TITLE_SHORT_NAME_EN": "",
        "FIRST_NAME": _itemsStaff.FIRST_NAME,
        "LAST_NAME": _itemsStaff.LAST_NAME,
        "AGE": "",
        "OPERATION_DEPT_CODE": _itemsStaff.OPERATION_DEPT_CODE != null ? _itemsStaff.OPERATION_DEPT_CODE : "",
        "OPERATION_DEPT_LEVEL": _itemsStaff.OPERATION_DEPT_LEVEL != null ? _itemsStaff.OPERATION_DEPT_LEVEL : "",
        "OPERATION_DEPT_NAME": _itemsStaff.OPERATION_DEPT_NAME != null ? _itemsStaff.OPERATION_DEPT_NAME : "",
        "OPERATION_OFFICE_CODE": _itemsStaff.OPERATION_OFFICE_CODE != null ? _itemsStaff.OPERATION_OFFICE_CODE : "",
        "OPERATION_OFFICE_NAME": _itemsStaff.OPERATION_OFFICE_NAME != null ? _itemsStaff.OPERATION_OFFICE_NAME : "",
        "OPERATION_OFFICE_SHORT_NAME": _itemsStaff.OPERATION_OFFICE_SHORT_NAME != null ? _itemsStaff.OPERATION_OFFICE_SHORT_NAME : "",
        "OPERATION_POS_CODE": _itemsStaff.OPERATION_POS_CODE != null ? _itemsStaff.OPERATION_POS_CODE : "",
        "OPERATION_POS_LEVEL_NAME": _itemsStaff.OPREATION_POS_LAVEL_NAME != null ? _itemsStaff.OPREATION_POS_LAVEL_NAME : "",
        "OPERATION_UNDER_DEPT_CODE": _itemsStaff.OPERATION_UNDER_DEPT_CODE != null ? _itemsStaff.OPERATION_UNDER_DEPT_CODE : "",
        "OPERATION_UNDER_DEPT_LEVEL": _itemsStaff.OPERATION_UNDER_DEPT_LEVEL != null ? _itemsStaff.OPERATION_UNDER_DEPT_LEVEL : "",
        "OPERATION_UNDER_DEPT_NAME": _itemsStaff.OPERATION_UNDER_DEPT_NAME != null ? _itemsStaff.OPERATION_UNDER_DEPT_NAME : "",
        "OPERATION_WORK_DEPT_CODE": _itemsStaff.OPERATION_WORK_DEPT_CODE != null ? _itemsStaff.OPERATION_WORK_DEPT_CODE : "",
        "OPERATION_WORK_DEPT_LEVEL": _itemsStaff.OPERATION_WORK_DEPT_LEVEL != null ? _itemsStaff.OPERATION_WORK_DEPT_LEVEL : "",
        "OPERATION_WORK_DEPT_NAME": _itemsStaff.OPERATION_WORK_DEPT_NAME != null ? _itemsStaff.OPERATION_WORK_DEPT_NAME : "",
        "OPREATION_POS_LEVEL": _itemsStaff.OPREATION_POS_LEVEL != null ? _itemsStaff.OPREATION_POS_LEVEL : "",
        "OPREATION_POS_NAME": _itemsStaff.OPREATION_POS_NAME != null ? _itemsStaff.OPREATION_POS_NAME : "",
        "MANAGEMENT_POS_CODE": "",
        "MANAGEMENT_POS_NAME": "",
        "MANAGEMENT_POS_LEVEL": "",
        "MANAGEMENT_POS_LEVEL_NAME": "",
        "MANAGEMENT_DEPT_CODE": "",
        "MANAGEMENT_DEPT_NAME": "",
        "MANAGEMENT_DEPT_LEVEL": "",
        "MANAGEMENT_UNDER_DEPT_CODE": "",
        "MANAGEMENT_UNDER_DEPT_NAME": "",
        "MANAGEMENT_UNDER_DEPT_LEVEL": "",
        "MANAGEMENT_WORK_DEPT_CODE": "",
        "MANAGEMENT_WORK_DEPT_NAME": "",
        "MANAGEMENT_WORK_DEPT_LEVEL": "",
        "MANAGEMENT_OFFICE_CODE": "",
        "MANAGEMENT_OFFICE_NAME": "",
        "MANAGEMENT_OFFICE_SHORT_NAME": "",
        "REPRESENTATION_POS_CODE": "",
        "REPRESENTATION_POS_NAME": "",
        "REPRESENTATION_POS_LEVEL": "",
        "REPRESENTATION_POS_LEVEL_NAME": "",
        "REPRESENTATION_DEPT_CODE": "",
        "REPRESENTATION_DEPT_NAME": "",
        "REPRESENTATION_DEPT_LEVEL": "",
        "REPRESENTATION_UNDER_DEPT_CODE": "",
        "REPRESENTATION_UNDER_DEPT_NAME": "",
        "REPRESENTATION_UNDER_DEPT_LEVEL": "",
        "REPRESENT_WORK_DEPT_CODE": "",
        "REPRESENT_WORK_DEPT_NAME": "",
        "REPRESENT_WORK_DEPT_LEVEL": "",
        "REPRESENT_OFFICE_CODE": "",
        "REPRESENT_OFFICE_NAME": "",
        "REPRESENT_OFFICE_SHORT_NAME": "",
        "STATUS": "",
        "REMARK": "",
        "CONTRIBUTOR_ID": CONTRIBUTOR_ID,
        "IS_ACTIVE": 1
      };
    } else {
      return {
        "STAFF_ID": "",
        "PROVE_ID": PROVE_ID,
        "COMPARE_DETAIL_ID": "",
        "STAFF_REF_ID": _itemsStaff.STAFF_ID,
        "TITLE_ID": _itemsStaff.TITLE_ID,
        "STAFF_CODE": "",
        "ID_CARD": "",
        "STAFF_TYPE": _itemsStaff.STAFF_TYPE,
        "TITLE_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
        "TITLE_NAME_EN": "",
        "TITLE_SHORT_NAME_TH": _itemsStaff.TITLE_SHORT_NAME_TH,
        "TITLE_SHORT_NAME_EN": "",
        "FIRST_NAME": _itemsStaff.FIRST_NAME,
        "LAST_NAME": _itemsStaff.LAST_NAME,
        "AGE": "",
        "OPERATION_DEPT_CODE": _itemsStaff.OPERATION_DEPT_CODE != null ? _itemsStaff.OPERATION_DEPT_CODE : "",
        "OPERATION_DEPT_LEVEL": _itemsStaff.OPERATION_DEPT_LEVEL != null ? _itemsStaff.OPERATION_DEPT_LEVEL : "",
        "OPERATION_DEPT_NAME": _itemsStaff.OPERATION_DEPT_NAME != null ? _itemsStaff.OPERATION_DEPT_NAME : "",
        "OPERATION_OFFICE_CODE": _itemsStaff.OPERATION_OFFICE_CODE != null ? _itemsStaff.OPERATION_OFFICE_CODE : "",
        "OPERATION_OFFICE_NAME": _itemsStaff.OPERATION_OFFICE_NAME != null ? _itemsStaff.OPERATION_OFFICE_NAME : "",
        "OPERATION_OFFICE_SHORT_NAME": _itemsStaff.OPERATION_OFFICE_SHORT_NAME != null ? _itemsStaff.OPERATION_OFFICE_SHORT_NAME : "",
        "OPERATION_POS_CODE": _itemsStaff.OPERATION_POS_CODE != null ? _itemsStaff.OPERATION_POS_CODE : "",
        "OPERATION_POS_LEVEL_NAME": _itemsStaff.OPREATION_POS_LAVEL_NAME != null ? _itemsStaff.OPREATION_POS_LAVEL_NAME : "",
        "OPERATION_UNDER_DEPT_CODE": _itemsStaff.OPERATION_UNDER_DEPT_CODE != null ? _itemsStaff.OPERATION_UNDER_DEPT_CODE : "",
        "OPERATION_UNDER_DEPT_LEVEL": _itemsStaff.OPERATION_UNDER_DEPT_LEVEL != null ? _itemsStaff.OPERATION_UNDER_DEPT_LEVEL : "",
        "OPERATION_UNDER_DEPT_NAME": _itemsStaff.OPERATION_UNDER_DEPT_NAME != null ? _itemsStaff.OPERATION_UNDER_DEPT_NAME : "",
        "OPERATION_WORK_DEPT_CODE": _itemsStaff.OPERATION_WORK_DEPT_CODE != null ? _itemsStaff.OPERATION_WORK_DEPT_CODE : "",
        "OPERATION_WORK_DEPT_LEVEL": _itemsStaff.OPERATION_WORK_DEPT_LEVEL != null ? _itemsStaff.OPERATION_WORK_DEPT_LEVEL : "",
        "OPERATION_WORK_DEPT_NAME": _itemsStaff.OPERATION_WORK_DEPT_NAME != null ? _itemsStaff.OPERATION_WORK_DEPT_NAME : "",
        "OPREATION_POS_LEVEL": _itemsStaff.OPREATION_POS_LEVEL != null ? _itemsStaff.OPREATION_POS_LEVEL : "",
        "OPREATION_POS_NAME": _itemsStaff.OPREATION_POS_NAME != null ? _itemsStaff.OPREATION_POS_NAME : "",
        "MANAGEMENT_POS_CODE": "",
        "MANAGEMENT_POS_NAME": "",
        "MANAGEMENT_POS_LEVEL": "",
        "MANAGEMENT_POS_LEVEL_NAME": "",
        "MANAGEMENT_DEPT_CODE": "",
        "MANAGEMENT_DEPT_NAME": "",
        "MANAGEMENT_DEPT_LEVEL": "",
        "MANAGEMENT_UNDER_DEPT_CODE": "",
        "MANAGEMENT_UNDER_DEPT_NAME": "",
        "MANAGEMENT_UNDER_DEPT_LEVEL": "",
        "MANAGEMENT_WORK_DEPT_CODE": "",
        "MANAGEMENT_WORK_DEPT_NAME": "",
        "MANAGEMENT_WORK_DEPT_LEVEL": "",
        "MANAGEMENT_OFFICE_CODE": "",
        "MANAGEMENT_OFFICE_NAME": "",
        "MANAGEMENT_OFFICE_SHORT_NAME": "",
        "REPRESENTATION_POS_CODE": "",
        "REPRESENTATION_POS_NAME": "",
        "REPRESENTATION_POS_LEVEL": "",
        "REPRESENTATION_POS_LEVEL_NAME": "",
        "REPRESENTATION_DEPT_CODE": "",
        "REPRESENTATION_DEPT_NAME": "",
        "REPRESENTATION_DEPT_LEVEL": "",
        "REPRESENTATION_UNDER_DEPT_CODE": "",
        "REPRESENTATION_UNDER_DEPT_NAME": "",
        "REPRESENTATION_UNDER_DEPT_LEVEL": "",
        "REPRESENT_WORK_DEPT_CODE": "",
        "REPRESENT_WORK_DEPT_NAME": "",
        "REPRESENT_WORK_DEPT_LEVEL": "",
        "REPRESENT_OFFICE_CODE": "",
        "REPRESENT_OFFICE_NAME": "",
        "REPRESENT_OFFICE_SHORT_NAME": "",
        "STATUS": "",
        "REMARK": "",
        "CONTRIBUTOR_ID": CONTRIBUTOR_ID,
        "IS_ACTIVE": 1
      };
    }
  }

  //Time Picker
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

  ItemsCompareArrestMain compareArrestMain;
  ItemsListDivisionRate itemsListDivisionRate;
  ItemsCompareMain itemsCompareMain;
  Future<bool> onLoadActionGetCompareIndicment(Map map) async {
    await new CompareFuture().apiRequestCompareArrestgetByIndictmentID(map).then((onValue) {
      if (onValue.length > 0) {
        compareArrestMain = onValue[0];
      }
    });

    for (int i = 0; i < compareArrestMain.CompareArrestIndictmentDetail.length; i++) {
      Map map_mist = {"PERSON_ID": compareArrestMain.CompareArrestIndictmentDetail[i].PERSON_ID, "SUBSECTION_ID": compareArrestMain.SUBSECTION_ID};
      await new CompareFuture().apiRequestCompareCountMistreatgetByCon(map_mist).then((onValue) {
        print(compareArrestMain.CompareArrestIndictmentDetail[i].PERSON_ID.toString() + " : " + onValue.MISTREAT.toString());
        compareArrestMain.CompareArrestIndictmentDetail[i].MISTREAT_NO = onValue.MISTREAT;
      });
    }

    map = {"TEXT_SEARCH": "", "DIVISIONRATE_ID": ""};
    await new ArrestFutureMaster().apiRequestMasDivisionRategetByCon(map).then((onValue) {
      itemsListDivisionRate = onValue.RESPONSE_DATA.first;
    });

    int compareID;
    int lawsuitID;
    bool IsCompareNull = false;

    map = {"LAWSUIT_ID": itemsProveMain.LAWSUIT_ID};
    await new LawsuitFuture().apiRequestLawsuiltComparegetByLawsuitID(map).then((onValue) {
      if (onValue != null) {
        IsCompareNull = false;
        compareID = onValue.COMPARE_ID;
        lawsuitID = onValue.LAWSUIT_ID;
        print(compareID.toString() + " , " + lawsuitID.toString());
      } else {
        IsCompareNull = true;
      }
    });

    print("IsCompareNull : " + IsCompareNull.toString());

    if ((compareID != null || compareID != 0) && !IsCompareNull) {
      //เรียกดู compare
      map = {"COMPARE_ID": compareID};
      await new CompareFuture().apiRequestComparegetByCon(map).then((onValue) {
        itemsCompareMain = onValue;
      });

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CompareMainScreenFragment(
                  itemsListDivisionRate: itemsListDivisionRate,
                  itemsCompareMain: itemsCompareMain,
                  itemsCompareArrestMain: compareArrestMain,
                  ItemsPerson: widget.ItemsPerson,
                  IsEdit: false,
                  IsPreview: true,
                  IsCreate: false,
                )),
      );
      print("Back : " + result.toString());
      if (result.toString().endsWith("Back")) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });
        //check Is Compare
        await onLoadActionCheckIsComplete(1);
        Navigator.pop(context);
      }
    } else {
      //สร้าง compare
      if (compareArrestMain != null) {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CompareMainScreenFragment(
                    itemsCompareMain: null,
                    itemsCompareArrestMain: compareArrestMain,
                    itemsListDivisionRate: itemsListDivisionRate,
                    ItemsPerson: widget.ItemsPerson,
                    IsEdit: false,
                    IsPreview: false,
                    IsCreate: true,
                  )),
        );
        print("Back : " + result.toString());
        if (result.toString().endsWith("Back")) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              });
          //check Is Compare
          await onLoadActionCheckIsComplete(1);
          Navigator.pop(context);
        }
      }
    }
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionCheckIsComplete(int type) async {
    if (type == 1) {
      Map map = {"LAWSUIT_ID": itemsProveMain.LAWSUIT_ID};
      await new LawsuitFuture().apiRequestLawsuiltComparegetByLawsuitID(map).then((onValue) {
        if (onValue != null) {
          print("onValue : " + onValue.COMPARE_ID.toString());
          IsCompareComplete = true;
        } else {
          IsCompareComplete = false;
        }
      });
      print(IsCompareComplete.toString());
    }
    setState(() {});
    return true;
  }

  _navigate_compare(BuildContext context, int INDICTMENT_ID) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    Map map = {"INDICTMENT_ID": INDICTMENT_ID};
    print(map.toString());
    await onLoadActionGetCompareIndicment(map);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // check ว่าส่งแบบฟ้องศาลมั้ย
    List<int> arrayItemLawsuitType = [];
    final itemLawsuitType = itemsProveArrest.ProveLawsuitType;
    for (var i = 0; i < itemLawsuitType.length; i++) {
      arrayItemLawsuitType.add(itemsProveArrest.ProveLawsuitType[i].LAWSUIT_TYPE);
    }

    bool haveLawsuit = false;
    arrayItemLawsuitType.forEach((value) {
      if (value == 0) {
        haveLawsuit = true;
      }
    });
    print("ส่งแบบฟ้องศาล: $haveLawsuit");

    // final List<Widget> rowContents = <Widget>[
    //   new SizedBox(
    //       width: width / 3,
    //       child: new Center(
    //         child: new FlatButton(
    //           onPressed: () {
    //             // _onSaved ? Navigator.pop(context, itemMain) :
    //             if (_onSaved) {
    //               Navigator.pop(context, "Back");
    //             } else {
    //               _showCancelAlertDialog(context);
    //             }
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
    //       width: width / 3,
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
    //                   : (/*itemMain.IsActive*/ _onFinish
    //                       ? haveLawsuit // กรณีส่งแบบฟ้องศาล จะไม่ขึ้นปุ่มชำระค่าปรับ
    //                           ? Container()
    //                           : new ButtonTheme(
    //                               minWidth: 44.0,
    //                               padding: new EdgeInsets.all(0.0),
    //                               child: FlatButton(
    //                                 onPressed: () {
    //                                   //เมื่อชำระค่าปรับ
    //                                   _navigate_compare(context, itemsProveArrest.INDICTMENT_ID);
    //                                 },
    //                                 child: Row(
    //                                   children: <Widget>[
    //                                     Text('ชำระค่าปรับ', style: appBarStylePay),
    //                                     Icon(
    //                                       Icons.arrow_forward_ios,
    //                                       color: Colors.white,
    //                                     )
    //                                   ],
    //                                 ),
    //                               ))
    //                       : Container()))
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
        // _onSaved ? Navigator.pop(context, itemMain) :
        if (_onSaved) {
          Navigator.pop(context, "Back");
        } else {
          _showCancelAlertDialog(context);
        }
      },
      padding: EdgeInsets.all(10.0),
      // child: new Row(
      //   children: <Widget>[
      //     new Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.white,
      //     ),
      //     !_onSaved
      //         ? new Text(
      //             "ยกเลิก",
      //             style: appBarStyle,
      //           )
      //         : new Container(),
      //   ],
      // ),
      child: new Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
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
                  : (/*itemMain.IsActive*/ _onFinish
                      ? haveLawsuit // กรณีส่งแบบฟ้องศาล จะไม่ขึ้นปุ่มชำระค่าปรับ
                          ? Container()
                          :
                          // new ButtonTheme(
                          //     minWidth: 44.0,
                          //     padding: new EdgeInsets.all(0.0),
                          //     child: FlatButton(
                          //       onPressed: () {
                          //         //เมื่อชำระค่าปรับ
                          //         _navigate_compare(context, itemsProveArrest.INDICTMENT_ID);
                          //       },
                          //       child: Row(
                          //         children: <Widget>[
                          //           Text('ชำระค่าปรับ', style: appBarStylePay),
                          //           Icon(
                          //             Icons.arrow_forward_ios,
                          //             color: Colors.white,
                          //           )
                          //         ],
                          //       ),
                          //     ))
                          new FlatButton(
                              onPressed: () {
                                _navigate_compare(context, itemsProveArrest.INDICTMENT_ID);
                              },
                              padding: EdgeInsets.all(10.0),
                              child: Text('ชำระค่าปรับ', style: appBarStyle))
                      : Container()))
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
              //Navigator.pop(context, itemMain);
            }
          } else {
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
                  centerTitle: true,
                  // title: Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: <Widget>[
                  //     btnCancle,
                  //     Expanded(
                  //       child: Center(
                  //           child: Text(
                  //         'พิสูจน์ของกลาง',
                  //         style: appBarStyle,
                  //       )),
                  //     )
                  //   ],
                  // ),
                  title: Text(
                    'พิสูจน์ของกลาง',
                    style: appBarStyle,
                  ),
                  leading: btnCancle,
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
                      isScrollable: choices.length != 2 ? true : false,
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
                            _buildContent_tab_4(),
                            _buildContent_tab_5(),
                          ]
                        : <Widget>[
                            _buildContent_tab_1(),
                            _buildContent_tab_2(),
                            _buildContent_tab_3(),
                            _buildContent_tab_4(),
                          ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //************************start_tab_1*****************************
  _navigateProveArrestProduct(BuildContext context, ItemsProveArrestProduct itemProduct) async {
    if (itemProduct != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest6Product(
                  ItemsProduct: itemProduct,
                  IsComplete: true,
                )),
      );
    }
  }

  buildCollapsed() {
    var size = MediaQuery.of(context).size;
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
        itemsProveArrest.LAWSUIT_IS_OUTSIDE == 1
            ? Padding(
                padding: paddingData,
                child: Text(
                  // "น. " + itemsProveArrest.LAWSUIT_NO + "/" + (int.parse(itemsProveArrest.LAWSUIT_NO_YEAR) + 543).toString(),
                  "น. " + itemsProveArrest.LAWSUIT_NO + "/" + _convertYear(itemsProveArrest.LAWSUIT_NO_YEAR).toString(),
                  style: textStyleDataTitle,
                ),
              )
            : Padding(
                padding: paddingData,
                child: Text(
                  // itemsProveArrest.LAWSUIT_NO + "/" + (int.parse(itemsProveArrest.LAWSUIT_NO_YEAR) + 543).toString(),
                  itemsProveArrest.LAWSUIT_NO + "/" + _convertYear(itemsProveArrest.LAWSUIT_NO_YEAR).toString(),
                  style: textStyleDataTitle,
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
            itemsProveArrest.ARREST_CODE,
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
            _convertDate(itemsProveArrest.ARREST_DATE) + " " + _convertTime(itemsProveArrest.ARREST_DATE),
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
            itemsProveArrest.ARREST_STAFF_NAME,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "มาตรา",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            // itemsProveArrest.SUBSECTION_NAME.toString(),
            itemsProveArrest.SECTION_NAME.toString(),
            style: textStyleData,
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
            itemsProveArrest.GUILTBASE_NAME.toString(),
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "วันที่รับคดีคำกล่าวโทษ",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            // _convertDate(itemsProveArrest.LAWSUIT_DATE) + " " + _convertTime1(itemsProveArrest.LAWSUIT_DATE_TIME),
            _convertDate(itemsProveArrest.LAWSUIT_DATE),
            style: textStyleData,
          ),
        ),
      ],
    );
  }

  buildExpanded() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 80) / 100;
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
        itemsProveArrest.LAWSUIT_IS_OUTSIDE == 1
            ? Padding(
                padding: paddingData,
                child: Text(
                  // "น. " + itemsProveArrest.LAWSUIT_NO + "/" + (int.parse(itemsProveArrest.LAWSUIT_NO_YEAR) + 543).toString(),
                  "น. " + itemsProveArrest.LAWSUIT_NO + "/" + _convertYear(itemsProveArrest.LAWSUIT_NO_YEAR).toString(),
                  style: textStyleDataTitle,
                ),
              )
            : Padding(
                padding: paddingData,
                child: Text(
                  // itemsProveArrest.LAWSUIT_NO + "/" + (int.parse(itemsProveArrest.LAWSUIT_NO_YEAR) + 543).toString(),
                  itemsProveArrest.LAWSUIT_NO + "/" + _convertYear(itemsProveArrest.LAWSUIT_NO_YEAR).toString(),
                  style: textStyleDataTitle,
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
            itemsProveArrest.ARREST_CODE,
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
            _convertDate(itemsProveArrest.ARREST_DATE) + " " + _convertTime(itemsProveArrest.ARREST_DATE),
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
            itemsProveArrest.ARREST_STAFF_NAME,
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "มาตรา",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            // itemsProveArrest.SUBSECTION_NAME.toString(),
            itemsProveArrest.SECTION_NAME.toString(),
            style: textStyleData,
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
            itemsProveArrest.GUILTBASE_NAME.toString(),
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "วันที่รับคดีคำกล่าวโทษ",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            // _convertDate(itemsProveArrest.LAWSUIT_DATE) + " " + _convertTime1(itemsProveArrest.LAWSUIT_DATE_TIME),
            _convertDate(itemsProveArrest.LAWSUIT_DATE),
            style: textStyleData,
          ),
        ),
        /*Container(
          padding: paddingLabel,
          child: Text(
            "ชื่อผู้รับคดี",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            */ /*itemMain.LawsuitPersonName*/ /*
            "",
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "เลขหนังสือนำส่งพิสูจน์",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            itemsProveArrest.DELIVERY_DOC_NO_1!=null
                ?(itemsProveArrest.DELIVERY_DOC_NO_1.toString() +
                "/" +
                itemsProveArrest.DELIVERY_DOC_NO_2.toString())
                :"",
            style: textStyleData,
          ),
        ),*/
        Container(
          padding: paddingLabel,
          child: Text(
            "ของกลาง",
            style: textStyleLabel,
          ),
        ),
        itemsProveArrestProduct.length == 0
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
                    itemCount: itemsProveArrestProduct.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _navigateProveArrestProduct(context, itemsProveArrestProduct[index]);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: paddingData,
                                    child: Text(
                                      (index + 1).toString() + ". " + itemsProveArrestProduct[index].PRODUCT_DESC.toString(),
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
    );
  }

  Widget _buildContent_tab_1() {
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
              //   top: BorderSide(color: Colors.grey[300], width: 1.0),
              //   //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              // )),
              /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_03_00_03_00', style: textStylePageName,),
                    )
                  ],
                ),*/
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
//************************end_tab_1*******************************

//************************start_tab_2*******************************
  Widget _buildContent_tab_2() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery.of(context).size;
      return SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 18.0,top: 8,bottom: 8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    IsOutside = !IsOutside;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: IsOutside ? Color(0xff3b69f3) : Colors
                                        .white,
                                    border: Border.all(
                                        width: 1.5,
                                        color: Colors.black38
                                    ),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: IsOutside
                                          ? Icon(
                                        Icons.check,
                                        size: 16.0,
                                        color: Colors.white,
                                      )
                                          : Container(
                                        height: 16.0,
                                        width: 16.0,
                                        color: Colors.transparent,
                                      )
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "พิสูจน์นอกสถานที่ทำการ", style: textStyleLabel,),
                            ),
                          ],
                        ),
                      ),*/
                  IsOutside
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "ทะเบียนตรวจพิสูจน์",
                                    style: textStyleLabel,
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
                                    padding: paddingData,
                                    child: new Text(
                                      "น.",
                                      style: textStyleLabel,
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
                                            focusNode: myFocusNodeCheckEvidenceNumber,
                                            controller: editCheckEvidenceNumber,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
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
                                    padding: paddingData,
                                    child: new Text(
                                      "/",
                                      style: textStyleData,
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
                                            focusNode: myFocusNodeCheckEvidenceYear,
                                            controller: editCheckEvidenceYear,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
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
                                    "วันที่ตรวจรับ",
                                    style: textStyleLabel,
                                  ),
                                  Text(
                                    "*",
                                    style: textStyleStar,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: paddingData,
                              child: TextField(
                                enableInteractiveSelection: false,
                                onTap: () {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  /*showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DynamicDialog(
                                            Current: _dtCheckEvidence);
                                      }).then((s) {
                                    String date = "";
                                    List splits = dateFormatDate
                                        .format(s)
                                        .toString()
                                        .split(" ");
                                    date = splits[0] +
                                        " " +
                                        splits[1] +
                                        " " +
                                        (int.parse(splits[3]) + 543).toString();
                                    setState(() {
                                      _dtCheckEvidence = s;
                                      _currentProveDate = date;
                                      editCheckEvidenceDate.text =
                                          _currentProveDate;
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
                                          initialDateTime: _dtCheckEvidence,
                                          onDateTimeChanged: (DateTime s) {
                                            setState(() {
                                              String date = "";
                                              List splits = dateFormatDate.format(s).toString().split(" ");
                                              date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                              _dtCheckEvidence = s;
                                              _currentProveDate = date;
                                              editCheckEvidenceDate.text = _currentProveDate;

                                              List splitsCheckEvidenceDate = _dtCheckEvidence.toUtc().toLocal().toString().split(" ");
                                              List splitsCheckEvidenceTime = checkEvidenceTime.toString().split(" ");
                                              _dtCheckEvidence = DateTime.parse(splitsCheckEvidenceDate[0].toString() + " " + splitsCheckEvidenceTime[1].toString());
                                              print(_dtCheckEvidence.toString());
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                focusNode: myFocusNodeCheckEvidenceDate,
                                controller: editCheckEvidenceDate,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.calendarAlt,
                                    color: Colors.grey,
                                  ),
                                ),
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
                                    "เวลา",
                                    style: textStyleLabel,
                                  ),
                                  Text(
                                    "*",
                                    style: textStyleStar,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: paddingData,
                              child: TextField(
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
                                          initialDateTime: checkEvidenceTime,
                                          onDateTimeChanged: (DateTime newDateTime) {
                                            setState(() {
                                              checkEvidenceTime = newDateTime;
                                              _currentProveTime = dateFormatTime.format(checkEvidenceTime).toString();
                                              editCheckEvidenceTime.text = _currentProveTime;

                                              List splitsCheckEvidenceDate = _dtCheckEvidence.toUtc().toLocal().toString().split(" ");
                                              List splitsCheckEvidenceTime = checkEvidenceTime.toString().split(" ");
                                              _checkEvidenceDate = splitsCheckEvidenceDate[0].toString() + " " + splitsCheckEvidenceTime[1].toString();
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                focusNode: myFocusNodeCheckEvidenceTime,
                                controller: editCheckEvidenceTime,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
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
                                    "เขียนที่",
                                    style: textStyleLabel,
                                  ),
                                  Text(
                                    "*",
                                    style: textStyleStar,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: paddingData,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeCheckEvidencePlace,
                                      controller: editCheckEvidencePlace,
                                      keyboardType: TextInputType.text,
                                      textCapitalization: TextCapitalization.words,
                                      style: textStyleData,
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
                                    "ผู้รับมอบของกลาง",
                                    style: textStyleLabel,
                                  ),
                                  Text(
                                    "*",
                                    style: textStyleStar,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: paddingData,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      enabled: false,
                                      focusNode: myFocusNodeCheckEvidencePersonName,
                                      controller: editCheckEvidencePersonName,
                                      textCapitalization: TextCapitalization.words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  /*Container(
                                    height: 1.0,
                                    color: Colors.grey[300],
                                  ),*/
                                ],
                              ),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ));
    }

    Widget _buildContent_saved(BuildContext context) {
      String staff_name = "";
      itemsProveStaff.forEach((item) {
        if (item.CONTRIBUTOR_ID == 22) {
          staff_name = item.TITLE_SHORT_NAME_TH.toString() + item.FIRST_NAME + " " + item.LAST_NAME;
        }
      });

      return Container(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ทะเบียนตรวจพิสูจน์",
                          style: textStyleLabel,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          itemsProveMain.IS_OUTSIDE == 1
                              ? Padding(
                                  padding: paddingData,
                                  child: Text(
                                    "น. " + itemsProveMain.PROVE_NO.toString() + '/' + (int.parse(itemsProveMain.PROVE_NO_YEAR) + 543).toString(),
                                    style: textStyleData,
                                  ),
                                )
                              : Padding(
                                  padding: paddingData,
                                  child: Text(
                                    itemsProveMain.PROVE_NO.toString() + '/' + (int.parse(itemsProveMain.PROVE_NO_YEAR) + 543).toString(),
                                    style: textStyleData,
                                  ),
                                ),
                        ],
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
                          "วันที่ตรวจรับ",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          _convertDate(itemsProveMain.RECEIVE_DOC_DATE) + ' ' + _convertTime(itemsProveMain.RECEIVE_DOC_DATE),
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "เขียนที่",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemsProveMain.RECEIVE_OFFICE_NAME,
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้รับมอบของกลาง",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          staff_name,
                          style: textStyleData,
                        ),
                      ),
                    ],
                  ),
                  !IsCompareComplete
                      ? Align(
                          alignment: Alignment.topRight,
                          child: PopupMenuButton<Constants>(
                            onSelected: choiceAction,
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black,
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
                          ),
                        )
                      : Container()
                ],
              )),
        ),
      );
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
            //   top: BorderSide(color: Colors.grey[300], width: 1.0),
            //   //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            // )),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(
                    'ILG60_B_03_00_04_00', style: textStylePageName,),
                )
              ],
            ),*/
            ),
        Expanded(
          child: _onSaved ? _buildContent_saved(context) : _buildContent(context),
        ),
      ],
    );
  }
//************************end_tab_2*******************************

  //************************start_tab_3*******************************

  List<ItemsListDocument> itemsDocument = [];
  Future<bool> onLoadActionDocument(ItemsProveProduct itemProduct) async {
    Map map = {"DOCUMENT_TYPE": 5, "REFERENCE_CODE": itemProduct.PRODUCT_ID};

    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((item) {
        if (int.parse(item.IS_ACTIVE) == 1) {
          items.add(item);
        }
      });
      itemsDocument = items;
    });

    setState(() {});
    return true;
  }

  // ******************** Func Nav ********************
  _navigate(BuildContext context, ItemsProveArrestProduct itemArrestProduct, int index) async {
    var result;
    if (itemsProveArrest.GROUP_SECTION_SECTION_ID == 203 || itemsProveArrest.GROUP_SECTION_SECTION_ID == 204) {
      if (itemArrestProduct.VAT > 0) {
        result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProveManageEvidenceScreenFragment(
                    itemsProduct: itemArrestProduct,
                    IsCreate: false,
                    IsPreview: true,
                    itemsMasProductSize: widget.itemsMasProductSize,
                    itemsMasProductUnit: widget.itemsMasProductUnit,
                    SECTION_ID: itemsProveArrest.GROUP_SECTION_SECTION_ID,
                  )),
        );
      } else {
        result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProveManageEvidenceScreenFragment(
                    itemsProduct: itemArrestProduct,
                    IsCreate: true,
                    IsPreview: false,
                    itemsMasProductSize: widget.itemsMasProductSize,
                    itemsMasProductUnit: widget.itemsMasProductUnit,
                    SECTION_ID: itemsProveArrest.GROUP_SECTION_SECTION_ID,
                  )),
        );
      }
    } else {
      if (itemArrestProduct.IS_PROVE) {
        result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProveManageEvidenceScreenFragment(
                    itemsProduct: itemArrestProduct,
                    IsCreate: false,
                    IsPreview: true,
                    itemsMasProductSize: widget.itemsMasProductSize,
                    itemsMasProductUnit: widget.itemsMasProductUnit,
                    SECTION_ID: itemsProveArrest.GROUP_SECTION_SECTION_ID,
                  )),
        );
      } else {
        result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProveManageEvidenceScreenFragment(
                    itemsProduct: itemArrestProduct,
                    IsCreate: true,
                    IsPreview: false,
                    itemsMasProductSize: widget.itemsMasProductSize,
                    itemsMasProductUnit: widget.itemsMasProductUnit,
                    SECTION_ID: itemsProveArrest.GROUP_SECTION_SECTION_ID,
                  )),
        );
      }
    }

    if (result.toString() != "Back") {
      itemsProveArrestProduct[index] = result;
      //print(itemsProveArrestProduct[index].VAT);
    }
    setState(() {});
  }

  _navigate_preview(BuildContext mContext, ItemsProveProduct itemProveProduct, int index) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionDocument(itemProveProduct);

    Navigator.pop(context);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProveManageEvidenceScreenFragment(
                itemsProduct: itemProveProduct,
                IsCreate: false,
                IsPreview: true,
                itemsMasProductSize: widget.itemsMasProductSize,
                itemsMasProductUnit: widget.itemsMasProductUnit,
                ItemsDocument: itemsDocument,
                SECTION_ID: itemsProveArrest.GROUP_SECTION_SECTION_ID,
              )),
    );
    if (result.toString() != "Back") {
      itemsProveProduct[index] = result;
      print(itemsProveProduct[index].VAT);
    }
    setState(() {});
  }

  Widget _buildTaxValueProduct(BuildContext mContext, size) {
    // BuildContext mContext เก็บ reference parent กับ child
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(18.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text(
                "มูลค่าภาษีพิสูจน์",
                style: textStyleLabel,
              ),
            ),
            Container(
              padding: paddingData,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // new
                itemCount: itemsProveArrestProduct.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int j) {
                  // ********************** ส่งตัวแปร context, j ไป
                  taxTotal = 0;
                  return GestureDetector(
                    onTap: () {
                      // ********************** ส่ง Data ไปหน้า "รายละเอียดพิสูจน์ของกลาง"
                      _navigate(mContext, itemsProveArrestProduct[j], j);
                    },
                    child: Container(
                      padding: paddingData,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    (j + 1).toString() + ". " + itemsProveArrestProduct[j].PRODUCT_DESC.toString() + (itemsProveArrestProduct[j].REMARK != null ? " (" + itemsProveArrestProduct[j].REMARK.toString() + ")" : ""),
                                    style: textStyleLabel,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                          Container(
                            padding: paddingData,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                itemsProveArrest.GROUP_SECTION_SECTION_ID == 203 || itemsProveArrest.GROUP_SECTION_SECTION_ID == 204
                                    ? Container(
                                        padding: paddingData,
                                        child: Text(
                                          formatter.format(itemsProveArrestProduct[j].VAT).toString() + " บาท",
                                          style: textStyleData,
                                        ),
                                      )
                                    : (itemsProveArrestProduct[j].IS_PROVE
                                        ? Container(
                                            padding: paddingData,
                                            child: Text(
                                              "พิสูจน์แล้ว",
                                              style: textStyleStar,
                                            ),
                                          )
                                        : Container())
                              ],
                            ),
                          ),
                          /*Padding(
                            padding: paddingData,
                            child: Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ),*/
                          itemsProveArrest.GROUP_SECTION_SECTION_ID == 203 || itemsProveArrest.GROUP_SECTION_SECTION_ID == 204 ? _calTaxTotal(itemsProveArrestProduct, j, itemsProveArrestProduct.length) : Container()
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxValueProductPreview(BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        padding: EdgeInsets.all(18.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text(
                "มูลค่าภาษีพิสูจน์",
                style: textStyleLabel,
              ),
            ),
            Container(
              padding: paddingData,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // new
                itemCount: itemsProveProduct.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int j) {
                  taxTotal = 0;
                  return Container(
                    padding: paddingData,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _navigate_preview(mContext, itemsProveProduct[j], j);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    (j + 1).toString() + ". " + itemsProveArrestProduct[j].PRODUCT_DESC.toString() + (itemsProveArrestProduct[j].REMARK != null ? " (" + itemsProveArrestProduct[j].REMARK.toString() + ")" : ""),
                                    style: textStyleLabel,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18.0,
                                color: Colors.grey[400],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            itemsProveArrest.GROUP_SECTION_SECTION_ID == 203 || itemsProveArrest.GROUP_SECTION_SECTION_ID == 204
                                ? Container(
                                    padding: paddingData,
                                    child: Text(
                                      formatter.format(itemsProveProduct[j].VAT).toString() + " บาท",
                                      style: textStyleData,
                                    ),
                                  )
                                : (itemsProveArrestProduct[j].IS_PROVE
                                    ? Container(
                                        padding: paddingData,
                                        child: Text(
                                          "พิสูจน์แล้ว",
                                          style: textStyleStar,
                                        ),
                                      )
                                    : Container())
                          ],
                        ),
                        /* Padding(
                          padding: paddingData,
                          child: Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),*/
                        itemsProveArrest.GROUP_SECTION_SECTION_ID == 203 || itemsProveArrest.GROUP_SECTION_SECTION_ID == 204 ? _calTaxTotal(itemsProveProduct, j, itemsProveProduct.length) : Container(),
                        Padding(
                          padding: paddingData,
                          child: Container(
                            height: 1.0,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //มูลค่าภาษีรวม
  double taxTotal = 0;
  Widget _calTaxTotal(List items, int index, int len) {
    taxTotal = 0;
    items.forEach((item) {
      taxTotal += item.VAT;
    });
    return index == len - 1
        ? Container(
            padding: EdgeInsets.only(top: 22.0, bottom: 22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "มูลค่าภาษีพิสูจน์รวม",
                    style: textStyleLabel,
                  ),
                ),
                Container(
                  padding: paddingData,
                  child: Text(
                    formatter_pr.format(taxTotal).toString() + " บาท",
                    style: textStyleData,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildContent_tab_3() {
    Widget _buildContent(BuildContext context) {
      taxTotal = 0;
      var size = MediaQuery.of(context).size;
      return SingleChildScrollView(
          child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding:
                              EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    IsProve = !IsProve;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4.0),
                                    color:
                                    IsProve ? Color(0xff3b69f3) : Colors.white,
                                    border: Border.all(
                                        width: 1.5, color: Colors.black38),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: IsProve
                                          ? Icon(
                                        Icons.check,
                                        size: 16.0,
                                        color: Colors.white,
                                      )
                                          : Container(
                                        height: 16.0,
                                        width: 16.0,
                                        color: Colors.transparent,
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "ส่งพิสูจน์ทางเคมีและวิทยาศาสตร์",
                                style: textStyleLabel,
                              ),
                            ),
                          ],
                        ),
                      ),*/
                  Container(
                    padding: paddingLabel,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "วันที่พิสูจน์",
                          style: textStyleLabel,
                        ),
                        Text(
                          "*",
                          style: textStyleStar,
                        ),
                      ],
                    ),
                  ),
                  /*Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new ListTile(
                              title: Text(
                                _currentProveEvidenceDate,
                                style: textStyleData,),
                              trailing: Icon(
                                  FontAwesomeIcons.calendarAlt, size: 28.0),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DynamicDialog(
                                          Current: _dtProve);
                                    }).then((s) {
                                  String date = "";
                                  List splits = dateFormatDate.format(
                                      s).toString().split(" ");
                                  date = splits[0] + " " + splits[1] +
                                      " " +
                                      (int.parse(splits[3]) + 543)
                                          .toString();
                                  setState(() {
                                    _dtProve = s;
                                    _currentProveEvidenceDate = date;
                                  });
                                });
                              },
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),*/
                  Padding(
                    padding: paddingData,
                    child: TextField(
                      enableInteractiveSelection: false,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        /*showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return DynamicDialog(Current: _dtProve);
                                }).then((s) {
                              String date = "";
                              List splits =
                              dateFormatDate.format(s).toString().split(" ");
                              date = splits[0] +
                                  " " +
                                  splits[1] +
                                  " " +
                                  (int.parse(splits[3]) + 543).toString();
                              setState(() {
                                _dtProve = s;
                                _currentProveEvidenceDate = date;
                                editProveEvidenceDate.text =
                                    _currentProveEvidenceDate;
                              });
                            });*/
                        //_selectDate(context);

                        showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return _buildBottomPicker(
                              CupertinoDatePicker(
                                maximumDate: DateTime.now(),
                                maximumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) + 1,
                                minimumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) - 1,
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: _dtCheckEvidence,
                                onDateTimeChanged: (DateTime s) {
                                  setState(() {
                                    String date = "";
                                    List splits = dateFormatDate.format(s).toString().split(" ");
                                    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                    _dtProve = s;
                                    _currentProveEvidenceDate = date;
                                    editProveEvidenceDate.text = _currentProveEvidenceDate;

                                    List splitsProveDate = _dtProve.toUtc().toLocal().toString().split(" ");
                                    List splitsProveTime = proveEvidenceTime.toString().split(" ");
                                    _dtProve = DateTime.parse(splitsProveDate[0].toString() + " " + splitsProveTime[1].toString());
                                    print(_dtProve.toString());
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                      focusNode: myFocusNodeProveEvidenceDate,
                      controller: editProveEvidenceDate,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: textStyleData,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          FontAwesomeIcons.calendarAlt,
                          color: Colors.grey,
                        ),
                      ),
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
                          "เวลา",
                          style: textStyleLabel,
                        ),
                        Text(
                          "*",
                          style: textStyleStar,
                        ),
                      ],
                    ),
                  ),
                  /*Container(
                        padding: paddingData,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new ListTile(
                              title: Text(
                                _currentProveTime, style: textStyleData,),
                              onTap: () {

                              },
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),*/
                  Padding(
                    padding: paddingData,
                    child: TextField(
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
                                initialDateTime: proveEvidenceTime,
                                onDateTimeChanged: (DateTime newDateTime) {
                                  setState(() {
                                    proveEvidenceTime = newDateTime;
                                    _currentProveEvidenceTime = dateFormatTime.format(proveEvidenceTime).toString();
                                    editProveEvidenceTime.text = _currentProveEvidenceTime;

                                    List splitsProveDate = _dtProve.toUtc().toLocal().toString().split(" ");
                                    List splitsProveTime = proveEvidenceTime.toString().split(" ");
                                    _dtProve = DateTime.parse(splitsProveDate[0].toString() + " " + splitsProveTime[1].toString());
                                    print(_dtProve.toString());
                                  });
                                },
                              ),
                            );
                          },
                        );
                      },
                      focusNode: myFocusNodeProveEvidenceTime,
                      controller: editProveEvidenceTime,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      style: textStyleData,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "คำสั่ง",
                      style: textStyleLabel,
                    ),
                  ),
                  Container(
                    padding: paddingData,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          //padding: paddingData,
                          child: TextField(
                            focusNode: myFocusNodeProveCommand,
                            controller: editProveCommand,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textStyleData,
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
                          "ผู้พิสูจน์ของกลาง",
                          style: textStyleLabel,
                        ),
                        Text(
                          "*",
                          style: textStyleStar,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: paddingData,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          //padding: paddingData,
                          child: TextField(
                            enabled: false,
                            focusNode: myFocusNodeProvePerson,
                            controller: editProvePerson,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textStyleData,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        /*Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),*/
                      ],
                    ),
                  ),
                  IsProve
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เลขที่หนังสือนำส่ง Lab",
                                style: textStyleLabel,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: ((size.width * 75) / 100) / 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          //padding: paddingData,
                                          child: TextField(
                                            focusNode: myFocusNodeProveLabNumber,
                                            controller: editProveLabNumber,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
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
                                    padding: paddingData,
                                    child: new Text(
                                      "/",
                                      style: textStyleData,
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
                                            focusNode: myFocusNodeProveLabYear,
                                            controller: editProveLabYear,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
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
                              child: Text(
                                "วันที่นำส่ง",
                                style: textStyleLabel,
                              ),
                            ),
                            /*Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new ListTile(
                                  title: Text(
                                    _currentDeliverDate, style: textStyleData,),
                                  trailing: Icon(
                                      FontAwesomeIcons.calendarAlt, size: 28.0),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicDialog(
                                              Current: _dtDeliverDate);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(
                                          s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] +
                                          " " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                      setState(() {
                                        _dtDeliverDate = s;
                                        _currentDeliverDate = date;
                                      });
                                    });
                                  },
                                ),
                                Container(
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),*/
                            Padding(
                              padding: paddingData,
                              child: TextField(
                                enableInteractiveSelection: false,
                                onTap: () {
                                  FocusScope.of(context).requestFocus(new FocusNode());
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DynamicDialog(Current: _dtDeliverDate);
                                      }).then((s) {
                                    String date = "";
                                    List splits = dateFormatDate.format(s).toString().split(" ");
                                    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                                    setState(() {
                                      _dtDeliverDate = s;
                                      _currentDeliverDate = date;
                                      editDeliverDate.text = _currentDeliverDate;
                                    });
                                  });
                                  //_selectDate(context);
                                },
                                focusNode: myFocusNodeDeliverDate,
                                controller: editDeliverDate,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    FontAwesomeIcons.calendarAlt,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เวลา",
                                style: textStyleLabel,
                              ),
                            ),
                            Padding(
                              padding: paddingData,
                              child: TextField(
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
                                          initialDateTime: deliverTime,
                                          onDateTimeChanged: (DateTime newDateTime) {
                                            setState(() {
                                              deliverTime = newDateTime;
                                              _currentDeliverTime = dateFormatTime.format(deliverTime).toString();
                                              editDeliverTime.text = _currentDeliverTime;

                                              List splitsArrestDate = _dtDeliverDate.toUtc().toLocal().toString().split(" ");
                                              List splitsArrestTime = deliverTime.toString().split(" ");
                                              _deliverDate = splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString();
                                            });
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                                focusNode: myFocusNodeDeliverTime,
                                controller: editDeliverTime,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              height: 1.0,
                              color: Colors.grey[300],
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เลขที่คำร้อง",
                                style: textStyleLabel,
                              ),
                            ),
                            Container(
                              padding: paddingData,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeProvePetitionNumber,
                                      controller: editProvePetitionNumber,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization.words,
                                      style: textStyleData,
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
                              child: Text(
                                "เลขที่รายงานผล",
                                style: textStyleLabel,
                              ),
                            ),
                            Container(
                              padding: paddingData,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeProveReportNumber,
                                      controller: editProveReportNumber,
                                      textCapitalization: TextCapitalization.words,
                                      keyboardType: TextInputType.number,
                                      style: textStyleData,
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
                        )
                      : Container()
                ],
              ),
            ),
            _onEdited ? _buildTaxValueProductPreview(context) : _buildTaxValueProduct(context, size),

            /*Container(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(18.0),
                    child: GestureDetector(
                      onTap: () {
                        _navigateProveResult(context,true,false);
                      },
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text("สรุปผลรายงานการพิสูจน์",
                              style: textStyleLabel,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18.0,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),*/
          ],
        ),
      ));
    }

    Widget _buildContent_saved(BuildContext context) {
      String staff_name = "";
      itemsProveStaff.forEach((item) {
        if (item.CONTRIBUTOR_ID == 25) {
          staff_name = item.TITLE_SHORT_NAME_TH.toString() + item.FIRST_NAME + " " + item.LAST_NAME;
        }
      });

      return Container(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 18.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border(
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )),
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "วันที่พิสูจน์",
                            style: textStyleLabel,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: paddingData,
                              child: Text(
                                _convertDate(itemsProveMain.PROVE_DATE) + ' ' + _convertTime(itemsProveMain.PROVE_DATE),
                                style: textStyleData,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "คำสั่ง",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemsProveMain.COMMAND != null ? itemsProveMain.COMMAND.toString() : "",
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ผู้พิสูจน์ของกลาง",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            staff_name,
                            style: textStyleData,
                          ),
                        ),
                        itemsProveMain.IS_SCIENCE == 1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "เลขที่หนังสือนำส่ง Lab",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  Padding(
                                    padding: paddingData,
                                    child: Text(
                                      itemsProveScience.DELIVERY_DOC_NO_1 + " / " + itemsProveScience.DELIVERY_DOC_NO_2,
                                      style: textStyleData,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "วันที่นำส่ง",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  Padding(
                                    padding: paddingData,
                                    child: Text(
                                      _convertDate(itemsProveScience.DELIVERY_DOC_DATE) + " " + _convertTime(itemsProveScience.DELIVERY_DOC_DATE),
                                      style: textStyleData,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "เลขที่คำร้องขอ",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  Padding(
                                    padding: paddingData,
                                    child: Text(
                                      itemsProveScience.REQUEST_DOC_NO.toString(),
                                      style: textStyleData,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "เลขที่รายงานผล",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  Padding(
                                    padding: paddingData,
                                    child: Text(
                                      itemsProveScience.RESULT_DOC_NO.toString(),
                                      style: textStyleData,
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                    !IsCompareComplete
                        ? Align(
                            alignment: Alignment.topRight,
                            child: PopupMenuButton<Constants>(
                              onSelected: choiceAction,
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.black,
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
                            ),
                          )
                        : Container()
                  ],
                )),
            _buildTaxValueProductPreview(context),
          ],
        )),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
            //height: 34.0,
            // decoration: BoxDecoration(
            //     color: Colors.grey[200],
            //     border: Border(
            //       top: BorderSide(color: Colors.grey[300], width: 1.0),
            //       //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            //     )),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(
                    'ILG60_B_03_00_05_00', style: textStylePageName,),
                )
              ],
            ),*/
            ),
        Expanded(
          child: _onSaved ? _buildContent_saved(context) : _buildContent(context),
        ),
      ],
    );
  }
//************************end_tab_3*******************************

//************************start_tab_4*******************************
  Widget _buildContent_tab_4() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery.of(context).size;
      return /*SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 4.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border(
                        //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding:
                              EdgeInsets.only(right: 18.0, top: 8, bottom: 8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    IsDeliveredStorage = !IsDeliveredStorage;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: IsDeliveredStorage
                                        ? Color(0xff3b69f3)
                                        : Colors.white,
                                    border: Border.all(
                                        width: 1.5, color: Colors.black38),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: IsDeliveredStorage
                                          ? Icon(
                                        Icons.check,
                                        size: 16.0,
                                        color: Colors.white,
                                      )
                                          : Container(
                                        height: 16.0,
                                        width: 16.0,
                                        color: Colors.transparent,
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "นำส่งของกลางเพื่อจัดเก็บ",
                                style: textStyleLabel,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IsDeliveredStorage
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "เลขที่หนังสือนำส่ง",
                                  style: textStyleLabel,
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Padding(
                                  padding: paddingData,
                                  child: new Text(
                                    "กค.",
                                    style: textStyleLabel,
                                  ),
                                ),
                                Container(
                                  width: ((size.width * 75) / 100) / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode:
                                          myFocusNodeDeriveredNumber,
                                          controller: editDeriveredNumber,
                                          keyboardType: TextInputType.number,
                                          textCapitalization:
                                          TextCapitalization.words,
                                          style: textStyleData,
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
                                  padding: paddingData,
                                  child: new Text(
                                    "/",
                                    style: textStyleData,
                                  ),
                                ),
                                Container(
                                  width: ((size.width * 75) / 100) / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeDeriveredYear,
                                          controller: editDeriveredYear,
                                          keyboardType: TextInputType.number,
                                          textCapitalization:
                                          TextCapitalization.words,
                                          style: textStyleData,
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
                                  "วันที่ออกหนังสือ",
                                  style: textStyleLabel,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          */ /*Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new ListTile(
                                  title: Text(
                                    _currentDeriveredDate, style: textStyleData,),
                                  trailing: Icon(
                                      FontAwesomeIcons.calendarAlt, size: 28.0),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicDialog(
                                              Current: _dtDerivered);
                                        }).then((s) {
                                      String date = "";
                                      List splits = dateFormatDate.format(
                                          s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] +
                                          " " +
                                          (int.parse(splits[3]) + 543)
                                              .toString();
                                      setState(() {
                                        _dtDerivered=s;
                                        _currentDeriveredDate=date;
                                      });
                                    });
                                  },
                                ),
                                Container(
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),*/ /*
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DynamicDialog(
                                          Current: _dtDerivered);
                                    }).then((s) {
                                  String date = "";
                                  List splits = dateFormatDate
                                      .format(s)
                                      .toString()
                                      .split(" ");
                                  date = splits[0] +
                                      " " +
                                      splits[1] +
                                      " " +
                                      (int.parse(splits[3]) + 543).toString();
                                  setState(() {
                                    _dtDerivered = s;
                                    _currentDeriveredDate = date;
                                    editDeriveredDate.text =
                                        _currentDeriveredDate;
                                  });
                                });
                                //_selectDate(context);
                              },
                              focusNode: myFocusNodeDeriveredDate,
                              controller: editDeriveredDate,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  FontAwesomeIcons.calendarAlt,
                                  color: Colors.grey,
                                ),
                              ),
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
                                  "เวลา",
                                  style: textStyleLabel,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingData,
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _buildBottomPicker(
                                      CupertinoDatePicker(
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: deriveredTime,
                                        onDateTimeChanged:
                                            (DateTime newDateTime) {
                                          setState(() {
                                            deriveredTime = newDateTime;
                                            _currentDeriveredTime =
                                                dateFormatTime
                                                    .format(deriveredTime)
                                                    .toString();
                                            editDeriveredTime.text =
                                                _currentDeriveredTime;

                                            List splitsArrestDate =
                                            _dtDerivered
                                                .toUtc()
                                                .toLocal()
                                                .toString()
                                                .split(" ");
                                            List splitsArrestTime =
                                            deriveredTime
                                                .toString()
                                                .split(" ");
                                            _deriveredDate =
                                                splitsArrestDate[0]
                                                    .toString() +
                                                    " " +
                                                    splitsArrestTime[1]
                                                        .toString();
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              focusNode: myFocusNodeDeriveredTime,
                              controller: editDeriveredTime,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textStyleData,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
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
                                  "ผู้นำส่งของกลางไปจัดเก็บ",
                                  style: textStyleLabel,
                                ),
                                Text(
                                  "*",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    enabled: false,
                                    focusNode: myFocusNodeDeriveredPersonName,
                                    controller: editDeriveredPersonName,
                                    keyboardType: TextInputType.text,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    style: textStyleData,
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
                            child: Text(
                              "หน่วยงานต้นทาง",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeDeriveredDepartment,
                                    controller: editDeriveredDepartment,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    style: textStyleData,
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
                            child: Text(
                              "คลังจัดเก็บ",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeDeriveredStockName,
                                    controller: editDeriveredStockName,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    style: textStyleData,
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
                            child: Text(
                              "วิธีการขนส่ง",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    focusNode: myFocusNodeDeriveredTransport,
                                    controller: editDeriveredTransport,
                                    textCapitalization:
                                    TextCapitalization.words,
                                    style: textStyleData,
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
                      )
                          : Container()
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Container(
                    padding: EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(
                              color: Colors.grey[300], width: 1.0),
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "เลือกของกลางเพื่อจัดเก็บ",
                            style: textStyleLabel,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "เลือกทั้งหมด",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                    EdgeInsets.only(
                                        left: 18.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          IsProductStorageAll =
                                          !IsProductStorageAll;

                                          if (IsProductStorageAll) {
                                            itemsProveArrestProduct.forEach((item) {
                                              item.IS_CHECK = true;
                                            });
                                          } else {
                                            itemsProveArrestProduct.forEach((item) {
                                              item.IS_CHECK = false;
                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.circular(
                                              4.0),
                                          color: IsProductStorageAll
                                              ? Color(0xff3b69f3)
                                              : Colors.white,
                                          border: Border.all(
                                              width: 1.5,
                                              color: Colors.black38),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: IsProductStorageAll
                                                ? Icon(
                                              Icons.check,
                                              size: 16.0,
                                              color: Colors.white,
                                            )
                                                : Container(
                                              height: 16.0,
                                              width: 16.0,
                                              color: Colors.transparent,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.0),
                  child: Container(
                    padding: EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border(
                          //top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(
                              color: Colors.grey[300], width: 1.0),
                        )),
                    child: Container(
                      padding: paddingData,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // new
                        itemCount: itemsProveArrestProduct.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int j) {

                          return Container(
                            padding: paddingData,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      padding: paddingLabel,
                                      child: Text(
                                        (j + 1).toString() +
                                            ". " +
                                            (itemsProveArrestProduct[j]
                                                .PRODUCT_GROUP_NAME != null
                                                ? (itemsProveArrestProduct[j]
                                                .PRODUCT_GROUP_NAME
                                                .toString() + '/')
                                                : '') +
                                            (itemsProveArrestProduct[j]
                                                .PRODUCT_CATEGORY_NAME != null
                                                ? (itemsProveArrestProduct[j]
                                                .PRODUCT_CATEGORY_NAME
                                                .toString() + '/')
                                                : '') +
                                            (itemsProveArrestProduct[j]
                                                .PRODUCT_TYPE_NAME != null
                                                ? (itemsProveArrestProduct[j]
                                                .PRODUCT_TYPE_NAME
                                                .toString() + '/')
                                                : '') +
                                            (itemsProveArrestProduct[j]
                                                .PRODUCT_BRAND_NAME_TH != null
                                                ? (itemsProveArrestProduct[j]
                                                .PRODUCT_BRAND_NAME_TH
                                                .toString() + '/')
                                                : '') +
                                            (itemsProveArrestProduct[j]
                                                .PRODUCT_BRAND_NAME_EN != null
                                                ? (itemsProveArrestProduct[j]
                                                .PRODUCT_BRAND_NAME_EN
                                                .toString() + '')
                                                : ''),
                                        style: textStyleData,
                                      ),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.only(
                                          left: 18.0, top: 8, bottom: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            itemsProveArrestProduct[j].IS_CHECK =
                                            !itemsProveArrestProduct[j].IS_CHECK;

                                            int count = 0;
                                            itemsProveArrestProduct.forEach((ev) {
                                              if (ev.IS_CHECK) {
                                                count++;
                                              }
                                            });
                                            count == itemsProveArrestProduct.length
                                                ? IsProductStorageAll = true
                                                : IsProductStorageAll = false;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.circular(
                                                4.0),
                                            color: itemsProveArrestProduct[j].IS_CHECK
                                                ? Color(0xff3b69f3)
                                                : Colors.white,
                                            border: Border.all(
                                                width: 1.5,
                                                color: Colors.black38),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.all(
                                                  4.0),
                                              child: itemsProveArrestProduct[j].IS_CHECK
                                                  ? Icon(
                                                Icons.check,
                                                size: 16.0,
                                                color: Colors.white,
                                              )
                                                  : Container(
                                                height: 16.0,
                                                width: 16.0,
                                                color: Colors.transparent,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                itemsProveArrestProduct[j].IS_CHECK
                                    ?Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: ((size.width * 75) / 100) / 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: paddingLabel,
                                            child: Text("จำนวน", style: textStyleLabel,),
                                          ),
                                          Padding(
                                            padding: paddingData,
                                            child: TextField(
                                              focusNode: itemsProveArrestProduct[j].controller.myFocusNodeQuantity,
                                              controller: itemsProveArrestProduct[j].controller.editQuantity,
                                              keyboardType: TextInputType.number,
                                              textCapitalization: TextCapitalization
                                                  .words,
                                              style: textStyleData,
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
                                      width: ((size.width * 75) / 100) / 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: paddingLabel,
                                            child: Text(
                                              "ปริมาณ", style: textStyleLabel,),
                                          ),
                                          Padding(
                                            padding: paddingData,
                                            child: TextField(
                                              focusNode: itemsProveArrestProduct[j].controller.myFocusNodeVolume,
                                              controller: itemsProveArrestProduct[j].controller.editVolume,
                                              keyboardType: TextInputType.number,
                                              textCapitalization: TextCapitalization
                                                  .words,
                                              style: textStyleData,
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
                                )
                                    :Container(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      );*/
          Container(
        width: size.width,
        padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
                //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
        child: new Container(
          //padding: paddingData,
          child: TextField(
            focusNode: myFocusNodeRemark,
            controller: editRemark,
            keyboardType: TextInputType.multiline,
            textCapitalization: TextCapitalization.words,
            style: textStyleData,
            maxLines: 20,
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[800], width: 0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[600], width: 0.5),
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String staff_name = "";
      itemsProveStaff.forEach((item) {
        if (item.CONTRIBUTOR_ID == 26) {
          staff_name = item.TITLE_SHORT_NAME_TH.toString() + item.FIRST_NAME + " " + item.LAST_NAME;
        }
      });

      var size = MediaQuery.of(context).size;

      return /*Container(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                      //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "เลขที่หนังสือนำส่ง",
                          style: textStyleLabel,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: paddingData,
                            child: Text(
                              itemsProveMain.DELIVERY_DOC_NO_1!=null
                                  ?(itemsProveMain.DELIVERY_DOC_NO_1 +
                                  '/' +
                                  itemsProveMain.DELIVERY_DOC_NO_2)
                                  :"",
                              style: textStyleData,
                            ),
                          ),
                        ],
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
                          "วันที่ออกหนังสือ",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemsProveMain.DELIVERY_DOC_DATE!=null
                              ?(_convertDate(itemsProveMain.DELIVERY_DOC_DATE) +
                              ' ' +
                              _convertTime1(itemsProveMain.DELIVERY_DOC_DATE))
                              :"",
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้นำส่งของกลางไปจัดเก็บ",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemsProveMain.DELIVERY_DOC_NO_1!=null
                              ?staff_name
                              :"",
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "หน่วยงานต้นทาง",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemsProveMain.DELIVERY_DOC_NO_1!=null
                              ?itemsProveMain.DELIVERY_OFFICE_NAME.toString()
                              :"",
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "คลังจัดเก็บ",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemsProveMain.DELIVERY_DOC_NO_1!=null
                              ?""
                              :"",
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "วิธีการขนส่ง",
                          style: textStyleLabel,
                        ),
                      ),
                      Padding(
                        padding: paddingData,
                        child: Text(
                          itemsProveMain.DELIVERY_DOC_NO_1!=null
                              ?""
                              :"",
                          style: textStyleData,
                        ),
                      ),
                    ],
                  ),
                  !IsCompareComplete
                      ?Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton<Constants>(
                      onSelected: choiceAction,
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.black,
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
                                  child: Text(contants.text,
                                      style: TextStyle(
                                          fontFamily: FontStyles().FontFamily)),
                                )
                              ],
                            ),
                          );
                        }).toList();
                      },
                    ),
                  )
                      :Container()
                ],
              )),
        ),
      );*/
          Container(
              width: size.width,
              padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "สรุปผลการพิสูจน์",
                          style: textStyleLabel,
                        ),
                      ),
                      !IsCompareComplete
                          ? Align(
                              alignment: Alignment.topRight,
                              child: PopupMenuButton<Constants>(
                                onSelected: choiceAction,
                                icon: Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
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
                              ),
                            )
                          : Container()
                    ],
                  ),
                  Container(
                    padding: paddingData,
                    child: Text(
                      itemsProveMain.PROVE_RESULT == null ? "" : itemsProveMain.PROVE_RESULT.toString(),
                      style: textStyleData,
                    ),
                  )
                ],
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
            //     color: Colors.grey[200],
            //     border: Border(
            //       top: BorderSide(color: Colors.grey[300], width: 1.0),
            //       //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            //     )),
            /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(
                    'ILG60_B_03_00_09_00', style: textStylePageName,),
                )
              ],
            ),*/
            ),
        Expanded(
          child: _onSaved ? _buildContent_saved(context) : _buildContent(context),
        ),
      ],
    );
  }
//************************end_tab_4*******************************

//************************start_tab_5*****************************
  Widget _buildContent_tab_5() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            padding: EdgeInsets.only(top: 0.0),
            itemCount: itemsFormsTab3.length,
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
                      title: Text(
                        (index + 1).toString() + '. ' + itemsFormsTab3[index].FormsName,
                        style: textInputStyleTitle,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[300],
                      ),
                      onTap: () {
                        _navigate_preview_form(context, itemsFormsTab3[index]);
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
              //   top: BorderSide(color: Colors.grey[300], width: 1.0),
              //   //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              // )),
              /*child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(
                      'ILG60_B_03_00_10_00', style: textStylePageName,),
                  )
                ],
              ),*/
              ),
          Expanded(
            child: _buildContent(),
          )
        ],
      ),
    );
  }

  Future<bool> onLoadActionPreviewForms(Map map, ItemsLawsuitForms item) async {
    if (item.FormsCode.isNotEmpty) {
      if (item.FormsCode.trim() == "ILG60_00_05_001") {
        await new TransectionFuture().apiRequestILG60_00_05_001(map).then((onValue) {
          print("res PDF 05_001 : " + onValue);
        });
      } else if (item.FormsCode.trim() == "ILG60_00_05_002") {
        await new TransectionFuture().apiRequestILG60_00_05_002(map).then((onValue) {
          print("res PDF 05_002 : " + onValue);
        });
      } else if (item.FormsCode.trim() == "ILG60_00_05_003") {
        await new TransectionFuture().apiRequestILG60_00_05_003(map).then((onValue) {
          print("res PDF 05_003 : " + onValue);
        });
      }
    }

    setState(() {});
    return true;
  }

  _navigate_preview_form(BuildContext context, ItemsLawsuitForms item) async {
    Map map = {"ProveID": itemsProveMain.PROVE_ID};
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionPreviewForms(map, item);
    Navigator.pop(context);

    String dir = (await getApplicationDocumentsDirectory()).path;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest8Dowload(
                Title: item.FormsName,
                FILE_PATH: item.FormsCode.isNotEmpty ? (dir + '/' + item.FormsCode + '.pdf') : item.FormsCode,
              )),
    );
  }
//************************end_tab_5*******************************
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
