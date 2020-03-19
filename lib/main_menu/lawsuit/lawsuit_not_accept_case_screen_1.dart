import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_suspect2.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_product.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/lawsuit_accept_case_penalty_screen.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';
import 'package:prototype_app_pang/zan/future/person_net_future.dart';
import 'package:prototype_app_pang/zan/model/person_net_main.dart';

import 'future/lawsuit_future.dart';
import 'model/lawsuit_arrest_main.dart';
import 'model/lawsuit_form_list.dart';
import 'model/lawsuit_main.dart';

const double _kPickerSheetHeight = 216.0;

class LawsuitNotAcceptCaseMainScreenFragment extends StatefulWidget {
  ItemsLawsuitArrestMain itemsLawsuitMain;
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsLawsuitMain itemsPreview;
  bool IsPreview;
  LawsuitNotAcceptCaseMainScreenFragment({
    Key key,
    @required this.itemsLawsuitMain,
    @required this.ItemsPerson,
    @required this.IsPreview,
    @required this.itemsPreview,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<LawsuitNotAcceptCaseMainScreenFragment> with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลรับคำกล่าวโทษ'),
    Choice(title: 'ข้อมูลคดี'),
  ];

  ItemsLawsuitArrestMain _itemsLawsuitArrestMain;
  ItemsLawsuitMain _itemsLawsuitMain;
  var _itemsStaff;
  var _itemStaffUpdate;

  List<ItemsLawsuitForms> itemsFormsTab3 = [];

  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = Styles.textStyleStar;

  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textDataTitleStyle = TextStyle(fontSize: 18, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2), fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  var dateFormatDate, dateFormatTime;

  final FocusNode myFocusNodeLawsuitPersonName = FocusNode();
  TextEditingController editLawsuitPersonName = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _itemsLawsuitArrestMain = widget.itemsLawsuitMain;

    String title = widget.ItemsPerson.TITLE_SHORT_NAME_TH != null ? widget.ItemsPerson.TITLE_SHORT_NAME_TH : "";
    String firstname = widget.ItemsPerson.FIRST_NAME != null ? widget.ItemsPerson.FIRST_NAME : "";
    String lastname = widget.ItemsPerson.LAST_NAME != null ? widget.ItemsPerson.LAST_NAME : "";
    editLawsuitPersonName.text = title + firstname + " " + lastname;
    _itemsStaff = widget.ItemsPerson;

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    if (widget.IsPreview) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = false;
      _itemsLawsuitArrestMain = widget.itemsLawsuitMain;
      _itemsLawsuitMain = widget.itemsPreview;

      itemsFormsTab3 = [];
      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ 1/55", "ILG60_00_04_001"));
      /*itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มคำให้การของผู้กล่าวโทษ 2/54","ILG60_00_04_002"));
                    itemsFormsTab3.add(new ItemsLawsuitForms("คำร้องขอให้เปรียบเทียบคดี คด.1","ILG60_00_06_004"));*/
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController = TabController(length: choices.length, vsync: this);
      _tabPageSelector = new TabPageSelector(controller: tabController);
      //tabController.animateTo(choices.length - 1);
    }
  }

  /*****************************view tab1**************************/
  //node focus
  final FocusNode myFocusNodeReason = FocusNode();

  //textfield
  TextEditingController editReason = new TextEditingController();

  /**********************Droupdown View *****************************/
  List<String> dropdownItemsTab3 = ['ผู้จับกุม', 'ผู้ร่วมจับกุม'];

  @override
  void dispose() {
    super.dispose();
    editLawsuitPersonName.dispose();
    /*****************************dispose focus tab 1**************************/
  }

  void _setTextField() {
    editReason.text = _itemsLawsuitMain.REMARK_NOT_LAWSUIT;
  }

  /*****************************method for main tab**************************/
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onFinish = false;
        _onEdited = true;

        final pos = tabController.length - 1;
        choices.removeAt(pos);
        tabController = TabController(initialIndex: 0, length: choices.length, vsync: this);
        _tabPageSelector = new TabPageSelector(controller: tabController);

        _setTextField();
      } else {
        _onDeleted = true;
        _showDeleteAlertDialog();
      }
    });
  }

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
                Navigator.pop(context, _itemsLawsuitMain);
                setState(() {
                  onDeleted();
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void onDeleted() async {
    Map map = {"LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID};
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionInsLawsuitDelete(map);
    Navigator.pop(context, _itemsLawsuitMain);
  }

  Future<bool> onLoadActionInsLawsuitDelete(Map map) async {
    Map map_indic = {
      "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
    };
    await new LawsuitFuture().apiRequestLawsuiltArrestIndictmentupdDeleteIndictmentComplete(map_indic).then((onValue) {
      print("Delete IndictmentComplete : " + onValue.Msg);
    });
    Map map_arrest = {
      "ARREST_ID": _itemsLawsuitArrestMain.ARREST_ID,
    };
    await new LawsuitFuture().apiRequestLawsuiltArrestIndictmentupdDeleteArrestComplete(map_arrest).then((onValue) {
      print("Delete ArrestComplete : " + onValue.Msg);
    });
    await new LawsuitFuture().apiRequestLawsuitupdDelete(map).then((onValue) {
      print(onValue.IsSuccess);
      setState(() {
        /* _onSaved = false;
        _onEdited = false;
        _onSave = false;
        clearTextfield();
        choices.removeAt(choices.length - 1);*/

        Navigator.pop(context, _itemsLawsuitMain);
      });
    });
    setState(() {});
    return true;
  }

  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

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

                    itemsFormsTab3 = [];
                    itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ 1/55", "ILG60_00_04_001"));
                    /*itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มคำให้การของผู้กล่าวโทษ 2/54","ILG60_00_04_002"));
                    itemsFormsTab3.add(new ItemsLawsuitForms("คำร้องขอให้เปรียบเทียบคดี คด.1","ILG60_00_06_004"));*/
                    choices.add(Choice(title: 'แบบฟอร์ม'));
                    tabController = TabController(length: choices.length, vsync: this);
                    _tabPageSelector = new TabPageSelector(controller: tabController);
                    tabController.animateTo(choices.length - 1);
                  });
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }

  void clearTextfield() {
    editReason.clear();
  }

  void onSaved(BuildContext mContext) async {
    if (editReason.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณากรอกเหตุผล');
    } else {
      if (!_onEdited) {
        List<Map> LawsuitDetail = [];
        _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.forEach((item) {
          LawsuitDetail.add({
            "LAWSUIT_DETAIL_ID": "",
            "LAWSUIT_ID": "",
            "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
            "COURT_ID": "",
            "LAWSUIT_TYPE": 1,
            "LAWSUIT_END": 1,
            "COURT_NAME": "",
            "UNDECIDE_NO_1": "",
            "UNDECIDE_NO_YEAR_1": "",
            "DECIDE_NO_1": "",
            "DECIDE_NO_YEAR_1": "",
            "UNDECIDE_NO_2": "",
            "UNDECIDE_NO_YEAR_2": "",
            "DECIDE_NO_2": "",
            "DECIDE_NO_YEAR_2": "",
            "JUDGEMENT_NO": "",
            "JUDGEMENT_NO_YEAR": "",
            "JUDGEMENT_DATE": "",
            "IS_IMPRISON": "",
            "IMPRISON_TIME": "",
            "IMPRISON_TIME_UNIT": "",
            "IS_FINE": "",
            "FINE": "",
            "IS_PAYONCE": "",
            "FINE_DATE": "",
            "PAYMENT_PERIOD": "",
            "PAYMENT_PERIOD_DUE": "",
            "PAYMENT_PERIOD_DUE_UNIT": "",
            "PAYMENT_CHANNEL": "",
            "PAYMENT_BANK": "",
            "PAYMENT_REF_NO": "",
            "PAYMENT_DATE": "",
            "IS_DISMISS": "",
            "IS_ACTIVE": 1,
            "PAYMENT_BANK": "",
            "PAYMENT_CHANNEL": "",
            "PAYMENT_DATE": "",
            "PAYMENT_REF_NO": "",
            "UNJUDGEMENT_NO": "",
            "UNJUDGEMENT_NO_YEAR": ""
          });
        });

        Map map = {
          "LAWSUIT_ID": "",
          "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
          "OFFICE_ID": "",
          "OFFICE_CODE": "",
          "OFFICE_NAME": _itemsStaff.OPERATION_OFFICE_NAME,
          "IS_LAWSUIT": 0,
          "REMARK_NOT_LAWSUIT": editReason.text,
          "LAWSUIT_NO": "",
          "LAWSUIT_NO_YEAR": "",
          "LAWSUIT_DATE": "",
          "TESTIMONY": "",
          "DELIVERY_DOC_NO_1": "",
          "DELIVERY_DOC_NO_2": "",
          "DELIVERY_DOC_DATE": "",
          "IS_OUTSIDE": 1,
          "IS_SEIZE": 1,
          "IS_ACTIVE": 1,
          "CREATE_DATE": DateTime.now().toString(),
          "CREATE_USER_ACCOUNT_ID": 5,
          "UPDATE _DATE": DateTime.now().toString(),
          "UPDATE _USER_ACCOUNT_ID": 5,
          "LawsuitStaff": [
            {
              "STAFF_ID": "",
              "LAWSUIT_ID": "",
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
              "MANAGEMENT_WORK_DEPT_CODE": "",
              "MANAGEMENT_WORK_DEPT_NAME": "",
              "MANAGEMENT_WORK_DEPT_LEVEL": "",
              "MANAGEMENT_OFFICE_CODE": "",
              "MANAGEMENT_OFFICE_NAME": _itemsStaff.OPERATION_OFFICE_NAME,
              "MANAGEMENT_OFFICE_SHORT_NAME": "",
              "REPRESENT_POS_CODE": "",
              "REPRESENT_POS_NAME": "",
              "REPRESENT_POS_LEVEL": "",
              "REPRESENT_POS_LEVEL_NAME": "",
              "REPRESENT_DEPT_CODE": "",
              "REPRESENT_DEPT_NAME": "",
              "REPRESENT_DEPT_LEVEL": "",
              "REPRESENT_UNDER_DEPT_CODE": "",
              "REPRESENT_UNDER_DEPT_NAME": "",
              "REPRESENT_UNDER_DEPT_LEVEL": "",
              "REPRESENT_WORK_DEPT_CODE": "",
              "REPRESENT_WORK_DEPT_NAME": "",
              "REPRESENT_WORK_DEPT_LEVEL": "",
              "REPRESENT_OFFICE_CODE": "",
              "REPRESENT_OFFICE_NAME": "",
              "REPRESENT_OFFICE_SHORT_NAME": "",
              "STATUS": 1,
              "REMARK": "",
              "CONTRIBUTOR_ID": 16,
              "IS_ACTIVE": 1
            }
          ],
          "LawsuitDetail": LawsuitDetail
        };

        //print(map.toString());

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onLoadActionInsLawsuitAll(map);
        Navigator.pop(context);
      } else {
        List<Map> LawsuitDetail = [];

        _itemsLawsuitMain.LawsuitDetail.forEach((item) {
          LawsuitDetail.add({
            "LAWSUIT_DETAIL_ID": item.LAWSUIT_DETAIL_ID,
            "LAWSUIT_ID": item.LAWSUIT_ID,
            "INDICTMENT_DETAIL_ID": item.INDICTMENT_DETAIL_ID,
            "COURT_ID": "",
            "LAWSUIT_TYPE": 1,
            "LAWSUIT_END": 1,
            "COURT_NAME": "",
            "UNDECIDE_NO_1": "",
            "UNDECIDE_NO_YEAR_1": "",
            "DECIDE_NO_1": "",
            "DECIDE_NO_YEAR_1": "",
            "UNDECIDE_NO_2": "",
            "UNDECIDE_NO_YEAR_2": "",
            "DECIDE_NO_2": "",
            "DECIDE_NO_YEAR_2": "",
            "JUDGEMENT_NO": "",
            "JUDGEMENT_NO_YEAR": "",
            "JUDGEMENT_DATE": "",
            "IS_IMPRISON": "",
            "IMPRISON_TIME": "",
            "IMPRISON_TIME_UNIT": "",
            "IS_FINE": "",
            "FINE": "",
            "IS_PAYONCE": "",
            "FINE_DATE": "",
            "PAYMENT_PERIOD": "",
            "PAYMENT_PERIOD_DUE": "",
            "PAYMENT_PERIOD_DUE_UNIT": "",
            "PAYMENT_CHANNEL": "",
            "PAYMENT_BANK": "",
            "PAYMENT_REF_NO": "",
            "PAYMENT_DATE": "",
            "IS_DISMISS": "",
            "IS_ACTIVE": 1,
            "PAYMENT_BANK": "",
            "PAYMENT_CHANNEL": "",
            "PAYMENT_DATE": "",
            "PAYMENT_REF_NO": "",
            "UNJUDGEMENT_NO": "",
            "UNJUDGEMENT_NO_YEAR": ""
          });
        });

        Map map = {
          "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID,
          "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
          "OFFICE_ID": _itemsLawsuitMain.OFFICE.OFFICE_ID,
          "OFFICE_CODE": _itemsLawsuitMain.OFFICE.OFFICE_CODE,
          "OFFICE_NAME": _itemsLawsuitMain.OFFICE.OFFICE_NAME,
          "IS_LAWSUIT": _itemsLawsuitMain.IS_LAWSUIT,
          "REMARK_NOT_LAWSUIT": editReason.text,
          "LAWSUIT_NO": "",
          "LAWSUIT_NO_YEAR": "",
          "LAWSUIT_DATE": "",
          "TESTIMONY": "",
          "DELIVERY_DOC_NO_1": "",
          "DELIVERY_DOC_NO_2": "",
          "DELIVERY_DOC_DATE": "",
          "IS_OUTSIDE": 1,
          "IS_SEIZE": 1,
          "IS_ACTIVE": 1,
          "CREATE_DATE": DateTime.now().toString(),
          "CREATE_USER_ACCOUNT_ID": 5,
          "UPDATE _DATE": DateTime.now().toString(),
          "UPDATE _USER_ACCOUNT_ID": 5,
          "LawsuitDetail": LawsuitDetail
        };
        List<Map> map_staff = [];
        if (_itemStaffUpdate != null) {
          map_staff.add({
            "STAFF_ID": _itemsLawsuitMain.LawsuitStaff[0].STAFF_ID,
            "LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID,
            "STAFF_REF_ID": _itemStaffUpdate.STAFF_REF_ID,
            "TITLE_ID": _itemStaffUpdate.TITLE_ID,
            "STAFF_CODE": "",
            "ID_CARD": "",
            "STAFF_TYPE": _itemStaffUpdate.STAFF_TYPE,
            "TITLE_NAME_TH": _itemStaffUpdate.TITLE_SHORT_NAME_TH,
            "TITLE_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": _itemStaffUpdate.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": "",
            "FIRST_NAME": _itemStaffUpdate.FIRST_NAME,
            "LAST_NAME": _itemStaffUpdate.LAST_NAME,
            "AGE": "",
            "OPERATION_DEPT_CODE": _itemStaffUpdate.OPERATION_DEPT_CODE != null ? _itemStaffUpdate.OPERATION_DEPT_CODE : "",
            "OPERATION_DEPT_LEVEL": _itemStaffUpdate.OPERATION_DEPT_LEVEL != null ? _itemStaffUpdate.OPERATION_DEPT_LEVEL : "",
            "OPERATION_DEPT_NAME": _itemStaffUpdate.OPERATION_DEPT_NAME != null ? _itemStaffUpdate.OPERATION_DEPT_NAME : "",
            "OPERATION_OFFICE_CODE": _itemStaffUpdate.OPERATION_OFFICE_CODE != null ? _itemStaffUpdate.OPERATION_OFFICE_CODE : "",
            "OPERATION_OFFICE_NAME": _itemStaffUpdate.OPERATION_OFFICE_NAME != null ? _itemStaffUpdate.OPERATION_OFFICE_NAME : "",
            "OPERATION_OFFICE_SHORT_NAME": _itemStaffUpdate.OPERATION_OFFICE_SHORT_NAME != null ? _itemStaffUpdate.OPERATION_OFFICE_SHORT_NAME : "",
            "OPERATION_POS_CODE": _itemStaffUpdate.OPERATION_POS_CODE != null ? _itemStaffUpdate.OPERATION_POS_CODE : "",
            "OPERATION_POS_LEVEL_NAME": _itemStaffUpdate.OPREATION_POS_LAVEL_NAME != null ? _itemStaffUpdate.OPREATION_POS_LAVEL_NAME : "",
            "OPERATION_UNDER_DEPT_CODE": _itemStaffUpdate.OPERATION_UNDER_DEPT_CODE != null ? _itemStaffUpdate.OPERATION_UNDER_DEPT_CODE : "",
            "OPERATION_UNDER_DEPT_LEVEL": _itemStaffUpdate.OPERATION_UNDER_DEPT_LEVEL != null ? _itemStaffUpdate.OPERATION_UNDER_DEPT_LEVEL : "",
            "OPERATION_UNDER_DEPT_NAME": _itemStaffUpdate.OPERATION_UNDER_DEPT_NAME != null ? _itemStaffUpdate.OPERATION_UNDER_DEPT_NAME : "",
            "OPERATION_WORK_DEPT_CODE": _itemStaffUpdate.OPERATION_WORK_DEPT_CODE != null ? _itemStaffUpdate.OPERATION_WORK_DEPT_CODE : "",
            "OPERATION_WORK_DEPT_LEVEL": _itemStaffUpdate.OPERATION_WORK_DEPT_LEVEL != null ? _itemStaffUpdate.OPERATION_WORK_DEPT_LEVEL : "",
            "OPERATION_WORK_DEPT_NAME": _itemStaffUpdate.OPERATION_WORK_DEPT_NAME != null ? _itemStaffUpdate.OPERATION_WORK_DEPT_NAME : "",
            "OPREATION_POS_LEVEL": _itemStaffUpdate.OPREATION_POS_LEVEL != null ? _itemStaffUpdate.OPREATION_POS_LEVEL : "",
            "OPREATION_POS_NAME": _itemStaffUpdate.OPREATION_POS_NAME != null ? _itemStaffUpdate.OPREATION_POS_NAME : "",
            "MANAGEMENT_WORK_DEPT_CODE": "",
            "MANAGEMENT_WORK_DEPT_NAME": "",
            "MANAGEMENT_WORK_DEPT_LEVEL": "",
            "MANAGEMENT_OFFICE_CODE": "",
            "MANAGEMENT_OFFICE_NAME": "",
            "MANAGEMENT_OFFICE_SHORT_NAME": "",
            "REPRESENT_POS_CODE": "",
            "REPRESENT_POS_NAME": "",
            "REPRESENT_POS_LEVEL": "",
            "REPRESENT_POS_LEVEL_NAME": "",
            "REPRESENT_DEPT_CODE": "",
            "REPRESENT_DEPT_NAME": "",
            "REPRESENT_DEPT_LEVEL": "",
            "REPRESENT_UNDER_DEPT_CODE": "",
            "REPRESENT_UNDER_DEPT_NAME": "",
            "REPRESENT_UNDER_DEPT_LEVEL": "",
            "REPRESENT_WORK_DEPT_CODE": "",
            "REPRESENT_WORK_DEPT_NAME": "",
            "REPRESENT_WORK_DEPT_LEVEL": "",
            "REPRESENT_OFFICE_CODE": "",
            "REPRESENT_OFFICE_NAME": "",
            "REPRESENT_OFFICE_SHORT_NAME": "",
            "STATUS": 1,
            "REMARK": "",
            "CONTRIBUTOR_ID": 16,
            "IS_ACTIVE": 1
          });
        }

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onLoadActionInsLawsuitUpAll(map, map_staff.isEmpty, map_staff);
        Navigator.pop(context);
      }
    }
  }

  Future<bool> onLoadActionInsLawsuitUpAll(Map map, bool IsStaffUpdate, List<Map> map_staff) async {
    await new LawsuitFuture().apiRequestLawsuitupdAll(map).then((onValue) {
      print("UPDATE : " + onValue.IsSuccess.toString());
    });
    if (!IsStaffUpdate) {
      await new LawsuitFuture().apiRequestLawsuitStaffupdAll(map_staff).then((onValue) {
        print("UPDATE STAFF : " + onValue.Msg);
      });
    }
    if (_itemsLawsuitMain.LAWSUIT_ID != null) {
      Map map = {"LAWSUIT_ID": _itemsLawsuitMain.LAWSUIT_ID};
      await new LawsuitFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
        _itemsLawsuitMain = onValue;
      });

      _onSaved = true;
      _onFinish = true;
      //add item tab 3
      itemsFormsTab3 = [];
      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ 1/55", "ILG60_00_04_001"));
      /*itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มคำให้การของผู้กล่าวโทษ 2/54","ILG60_00_04_002"));
      itemsFormsTab3.add(new ItemsLawsuitForms("คำร้องขอให้เปรียบเทียบคดี คด.1","ILG60_00_06_004"));*/
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController = TabController(length: choices.length, vsync: this);
      _tabPageSelector = new TabPageSelector(controller: tabController);
      tabController.animateTo(choices.length - 1);
    }

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionInsLawsuitAll(Map map) async {
    int LAWSUIT_ID;
    await new LawsuitFuture().apiRequestLawsuitinsAll(map).then((onValue) {
      print(onValue.IsSuccess);
      LAWSUIT_ID = onValue.LAWSUIT_ID;
    });
    Map map_indic = {
      "INDICTMENT_ID": _itemsLawsuitArrestMain.INDICTMENT_ID,
    };
    await new LawsuitFuture().apiRequestLawsuiltArrestIndictmentupdIndictmentComplete(map_indic).then((onValue) {
      print("Update IndictmentComplete : " + onValue.Msg);
    });
    Map map_arrest = {
      "ARREST_ID": _itemsLawsuitArrestMain.ARREST_ID,
    };
    await new LawsuitFuture().apiRequestLawsuiltArrestIndictmentupdArrestComplete(map_arrest).then((onValue) {
      print("Update ArrestComplete : " + onValue.Msg);
    });
    if (LAWSUIT_ID != null) {
      Map map = {"LAWSUIT_ID": LAWSUIT_ID};
      await new LawsuitFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
        _itemsLawsuitMain = onValue;
      });

      _onSaved = true;
      _onFinish = true;
      //add item tab 3
      itemsFormsTab3 = [];
      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มบันทึกรับคำกล่าวโทษ 1/55", "ILG60_00_04_001"));
      /*itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์มคำให้การของผู้กล่าวโทษ 2/54","ILG60_00_04_002"));
      itemsFormsTab3.add(new ItemsLawsuitForms("คำร้องขอให้เปรียบเทียบคดี คด.1","ILG60_00_06_004"));*/
      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController = TabController(length: choices.length, vsync: this);
      _tabPageSelector = new TabPageSelector(controller: tabController);
      tabController.animateTo(choices.length - 1);
    }

    setState(() {});
    return true;
  }

  /*****************************method for main tab1**************************/
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // final List<Widget> rowContents = <Widget>[
    //   new SizedBox(
    //       width: width / 3,
    //       child: new Center(
    //         child: new FlatButton(
    //           onPressed: () {
    //             _onSaved ? Navigator.pop(context, "Back") :
    //             _showCancelAlertDialog(context);
    //           },
    //           padding: EdgeInsets.all(10.0),
    //           child: new Row(
    //             children: <Widget>[
    //               new Icon(Icons.arrow_back_ios, color: Colors.white,),
    //               !_onSaved
    //                   ? new Text("ยกเลิก", style: appBarStyle,)
    //                   : new Container(),
    //             ],
    //           ),
    //         ),
    //       )
    //   ),
    //   Expanded(
    //       child: Center(child: Text("", style: appBarStyle),
    //       )),
    //   new SizedBox(
    //       width: width / 3,
    //       child: new Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: <Widget>[
    //           _onSaved ? (_onSave ? new FlatButton(
    //               onPressed: () {
    //                 setState(() {
    //                   _onSaved = true;
    //                   _onSave = false;
    //                   _onEdited = false;
    //                 });
    //                 //TabScreenArrest1().createAcceptAlert(context);
    //               },
    //               child: Text('บันทึก', style: appBarStyle))
    //               :
    //           Container())
    //               :
    //           new FlatButton(
    //               onPressed: () {
    //                 onSaved(context);
    //               },
    //               child: Text('บันทึก', style: appBarStyle)),
    //         ],
    //       )
    //   )
    // ];
    final btnCancle = new FlatButton(
      onPressed: () {
        _onSaved ? Navigator.pop(context, "Back") : _showCancelAlertDialog(context);
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
                  : Container())
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
                //Navigator.pop(context,widget.itemsCaseInformation);
              }
            } else {
              //Navigator.pop(context,widget.itemsCaseInformation);
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
                      'รับคำกล่าวโทษ',
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
        //         title: Text('รับคำกล่าวโทษ',style: appBarStyle,),
        //         centerTitle: true,
        //         flexibleSpace: new BottomAppBar(
        //           elevation: 0.0,
        //           color: Color(0xff2e76bc),
        //           child: new Row(
        //               children: rowContents),
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
        //               isScrollable: choices.length != 2 ? true : false,
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

  //************************start_tab_1*****************************
  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      String title = "", firstname = "", lastname = "";
      if (_onEdited) {
        _itemsLawsuitMain.LawsuitStaff.forEach((staff) {
          title = staff.TITLE_SHORT_NAME_TH != null ? staff.TITLE_SHORT_NAME_TH : staff.TITLE_NAME_TH;
          firstname = staff.FIRST_NAME != null ? staff.FIRST_NAME : "";
          lastname = staff.LAST_NAME != null ? staff.LAST_NAME : "";
        });
      } else {
        title = widget.ItemsPerson.TITLE_SHORT_NAME_TH != null ? widget.ItemsPerson.TITLE_SHORT_NAME_TH : "";
        firstname = widget.ItemsPerson.FIRST_NAME != null ? widget.ItemsPerson.FIRST_NAME : "";
        lastname = widget.ItemsPerson.LAST_NAME != null ? widget.ItemsPerson.LAST_NAME : "";
      }
      return Container(
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
                    "ชื่อเจ้าพนักงาน",
                    style: textStyleLabel,
                  ),
                ),
                /*Padding(
                padding: paddingData,
                child: Text(
                  title+firstname+" "+lastname, style: textStyleData,),
              ),*/
                Container(
                  padding: paddingData,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        //padding: paddingData,
                        child: TextField(
                          enableInteractiveSelection: false,
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            //_navigateSearchStaff(context);
                          },
                          focusNode: myFocusNodeLawsuitPersonName,
                          controller: editLawsuitPersonName,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            //suffixIcon: Icon(Icons.search,color: Colors.grey,),
                          ),
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
                        "เหตุผล",
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
                    child: Container(
                      padding: EdgeInsets.only(top: 8.0),
                      child: TextField(
                        maxLines: 10,
                        focusNode: myFocusNodeReason,
                        controller: editReason,
                        style: textStyleData,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500], width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400], width: 0.5),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String title = "";
      String firstname = "";
      String lastname = "";

      _itemsLawsuitMain.LawsuitStaff.forEach((item) {
        title = item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH;
        firstname = item.FIRST_NAME;
        lastname = item.LAST_NAME;
      });

      return Container(
        padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
                //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
        child: Stack(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Text(
                      _itemsLawsuitMain.IS_LAWSUIT == 0 ? "ไม่รับคดี" : "",
                      style: textDataTitleStyle,
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
                  "ชื่อเจ้าพนักงาน",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  title + firstname + " " + lastname,
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "เหตุผล",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  _itemsLawsuitMain.REMARK_NOT_LAWSUIT,
                  style: textStyleData,
                ),
              ),
            ],
          ),
          _itemsLawsuitMain.IS_OUTSIDE == 1
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
        ]),
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
                  child: new Text(
                    'ILG60_B_02_00_05_00', style: textStylePageName,),
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

//************************start_tab_2*****************************
  buildCollapsed() {
    String arrest_date = "";
    DateTime dt_occourrence = DateTime.parse(_itemsLawsuitArrestMain.OCCURRENCE_DATE);
    print(dt_occourrence.toString());
    List splits = dateFormatDate.format(dt_occourrence).toString().split(" ");
    arrest_date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            _itemsLawsuitArrestMain.ARREST_CODE,
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
            "วันที่จับกุม",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _convertDate(_itemsLawsuitArrestMain.OCCURRENCE_DATE) + " " + _convertTime(_itemsLawsuitArrestMain.OCCURRENCE_DATE),
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
            _itemsLawsuitArrestMain.ACCUSER_TITLE_NAME_TH + _itemsLawsuitArrestMain.ACCUSER_FIRST_NAME + " " + _itemsLawsuitArrestMain.ACCUSER_LAST_NAME,
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
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
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
                        (j + 1).toString() + '. ' + _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH + _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].FIRST_NAME + " " + _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].LAST_NAME,
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
                          Map map = {"TEXT_SEARCH": "", "PERSON_ID": _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].PERSON_ID};
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
        /*Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.SUBSECTION_NAME,
            style: textStyleData,),
        ),*/
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: new Padding(
                padding: paddingData,
                child: Text(
                  _itemsLawsuitArrestMain.SUBSECTION_NAME,
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
        )),
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
            _itemsLawsuitArrestMain.GUILTBASE_NAME,
            style: textStyleData,
          ),
        ),
      ],
    );
  }

  _navigatePreviewpernalty(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Pernalty(
                itemsLawsuitMain: _itemsLawsuitArrestMain,
              )),
    );
  }

  buildExpanded() {
    String address = "error";
    /*_itemsLawsuitArrestMain.LawsuitLocale.forEach((item) {
      address = item.ADDRESS_NO+(item.ALLEY==null?"":" ซอย "+item.ALLEY)
          +(item.ROAD==null?"":" ถนน "+item.ROAD)
          + " อำเภอ/เขต " +  item.DISTRICT_NAME_TH
          + " ตำบล/แขวง " +
          item.SUB_DISTRICT_NAME_TH + " จังหวัด " +
          item.PROVINCE_NAME_TH;
    });*/

    String arrest_date = "";
    DateTime dt_occourrence = DateTime.parse(_itemsLawsuitArrestMain.OCCURRENCE_DATE);
    print(dt_occourrence.toString());
    List splits = dateFormatDate.format(dt_occourrence).toString().split(" ");
    arrest_date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
            _itemsLawsuitArrestMain.ARREST_CODE,
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
            "วันที่จับกุม",
            style: textStyleLabel,
          ),
        ),
        Padding(
          padding: paddingData,
          child: Text(
            _convertDate(_itemsLawsuitArrestMain.OCCURRENCE_DATE) + " " + _convertTime(_itemsLawsuitArrestMain.OCCURRENCE_DATE),
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
            _itemsLawsuitArrestMain.ACCUSER_TITLE_NAME_TH + _itemsLawsuitArrestMain.ACCUSER_FIRST_NAME + " " + _itemsLawsuitArrestMain.ACCUSER_LAST_NAME,
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
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail.length,
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
                      (j + 1).toString() + '. ' + _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH + _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].FIRST_NAME + " " + _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].LAST_NAME,
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
                          Map map = {"TEXT_SEARCH": "", "PERSON_ID": _itemsLawsuitArrestMain.LawsuitArrestIndictmentDetail[j].PERSON_ID};
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
        /*Padding(
          padding: paddingData,
          child: Text(
            _itemsLawsuitArrestMain.SUBSECTION_NAME,
            style: textStyleData,),
        ),*/
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: new Padding(
                padding: paddingData,
                child: Text(
                  _itemsLawsuitArrestMain.SUBSECTION_NAME,
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
        )),
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
            _itemsLawsuitArrestMain.GUILTBASE_NAME,
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
            _itemsLawsuitArrestMain.ARREST_OFFICE_NAME.toString(),
            style: textStyleData,
          ),
        ),
        /*Padding(
          padding: paddingData,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text("ของกลางลำดับ "+(j+1).toString(), style: textStyleLabel,),
                  ),
                  new Padding(
                    padding: paddingData,
                    child: Text(
                      _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].PRODUCT_CATEGORY_NAME+" / "+
                          _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_TH
                      ,
                      style: textStyleData,),
                  ),
                  Row(
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
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].QUANTITY.toString(),
                                style: textStyleData,),
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
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].QUANTITY_UNIT,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ขนาด", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].SIZES.toString(),
                                style: textStyleData,),
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
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].SIZES_UNIT,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text("ปริมาณสุทธิ", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].VOLUMN.toString(),
                                style: textStyleData,),
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
                              child: Text("หน่วย", style: textStyleLabel,),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[j].VOLUMN_UNIT,
                                style: textStyleData,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  j<_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length-1?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          width: Width,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ):Container()
                ],
              );
            },
          ),
        ),*/
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
            _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length == 0
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
                        itemCount: _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct.length,
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
                                              ItemsProduct: _itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index],
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
                                          (index + 1).toString() + ". " + new SetProductName(_itemsLawsuitArrestMain.LawsuitArrestIndictmentProduct[index]).PRODUCT_NAME.toString(),
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
      return Container(
        padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
                //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
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
                      'ILG60_B_02_00_04_00', style: textStylePageName,),
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

//************************end_tab_2*******************************

//************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(top: 0.0, bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
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

  Future<bool> onLoadActionPreviewForms(Map map) async {
    await new TransectionFuture().apiRequestILG60_00_04_001(map).then((onValue) {
      print("res PDF 04_001 : " + onValue);
    });
    setState(() {});
    return true;
  }

  _navigate_preview_form(BuildContext context, ItemsLawsuitForms item) async {
    Map map = {"LawsuitID": _itemsLawsuitMain.LAWSUIT_ID};
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionPreviewForms(map);
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
