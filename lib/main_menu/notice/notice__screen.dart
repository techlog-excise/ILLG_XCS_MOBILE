import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_location.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_get_office.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_map_custom.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_add.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_add.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_edit.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/evidence_search_staff.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_get_staff.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/lawsuit/model/lawsuit_form_list.dart';
import 'package:prototype_app_pang/main_menu/notice/model/item_notice_5.dart';
import 'package:prototype_app_pang/main_menu/notice/tab_screen_notice_5_add.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';
import 'future/notice_future.dart';
import 'model/item_notice_main.dart';
import 'model/item_notice_product.dart';
import 'model/item_notice_staff.dart';
import 'package:location/location.dart' as Locations;
import 'dart:async';
import 'package:flutter/services.dart';

import 'model/item_notice_suspect.dart';

const double _kPickerSheetHeight = 216.0;
const PrimaryColor = const Color(0xff2e76bc);

class NoticeMainScreenFragment extends StatefulWidget {
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasterTitleResponse itemsTitle;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  ItemsNoticeMain itemsNoticeMain;
  bool IsUpdate;
  bool IsPreview;
  bool IsCreate;
  NoticeMainScreenFragment({
    Key key,
    @required this.ItemsPerson,
    @required this.itemsTitle,
    @required this.itemsMasProductSize,
    @required this.itemsMasProductUnit,
    @required this.itemsNoticeMain,
    @required this.IsUpdate,
    @required this.IsPreview,
    @required this.IsCreate,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<NoticeMainScreenFragment> with TickerProviderStateMixin {
  List _itemsData = [];

  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลใบแจ้งความ'),
    // Choice(title: 'ผู้แจ้งความ'),
    Choice(title: 'ผู้รับแจ้งความ'),
    Choice(title: 'ผู้แจ้งความ'),
    // Choice(title: 'ผู้ต้องสงสัย'),
    Choice(title: 'สินค้าต้องสงสัย'),
  ];

  List<ItemsLawsuitForms> itemsFormsTab3 = [];
  ItemsArrestResponseGetOffice itemsOffice;
  ItemsPersonInformation ItemsData;

  String _officeName = "";
  int officeID;

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
  TextStyle textLabelDeleteStyle = TextStyle(fontSize: 16.0, color: Colors.red, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSubCont = TextStyle(fontSize: 14.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  var dateFormatDate, dateFormatTime;

  final formatter = new NumberFormat("#,###.###");
  final formatter_product = new NumberFormat("#,##0.000");

  //===================== Data ==================================
  ItemsNoticeMain itemsNoticeMain;
  ItemsListArrestLocation _itemsLocale = null;
  List<ItemsListEvidenceGetStaff> _itemsNoticeStaff = [];

  //Product
  List _itemsDataTab5 = [];

  //Location
  Locations.Location _location = new Locations.Location();
  bool _permission = false;
  String error;
  String placeAddress = "", _placeName = "", _addressno = "", _province = "", _distict = "", _sub_distinct = "", _lane = "", _gps = "", _road = "";
  String noticesLocation = "";
  //===================== View ==================================
  ItemsMasterProvinceResponse ItemProvince;
  ItemsMasterDistictResponse ItemDistrict;
  ItemsMasterSubDistictResponse ItemSubDistrict;

  // Local tab 1
  ItemsListSubDistict tab1SubDistrict;
  ItemsListDistict tab1District;
  ItemsListProvince tab1Province;

  // Local tab 2
  ItemsListSubDistict sSubDistrict;
  ItemsListDistict sDistrict;
  ItemsListProvince sProvince;

  List<ItemsListTransection> _itemTransection = [];
  String transection_no;
  String temp_editNoticePersonName;

  //===============Update Data===============
  ItemsListArrestLocation list_update_location;

  //Suspect
  List list_suspect_add = [];
  List list_suspect_del = [];

  //Product
  List list_product_add = [];
  List list_product_upd = [];
  List list_product_del = [];

  //Staff
  List list_staff_add = [];
  List list_staff_upd = [];
  List list_staff_del = [];

  //===================== boolean================================
  bool NoticeType1 = true;
  bool NoticeType2 = false;

  bool Private = true; // แสดงชื่อผู้แจ้งมั้ย true = ไม่แสดง
  bool TextPrivate = false; // แก้ไขชื่อผู้แจ้งได้มั้ย false = แก้ไม่ได้
  bool InformerStatus = false;

  //===================== DateTime================================
  String _noticeDate = DateTime.now().toString();

  String _currentNoticeDate, _currentNoticeTime;

  DateTime _dtNoticeDate = DateTime.now();
  DateTime _dtNoticeTime = DateTime.now();

  var df;
  DateTime _tempDueDate;

  //=====================FocusNode===============================
  //tab-1
  final FocusNode myFocusNodeNoticeNo = FocusNode();
  final FocusNode myFocusNodeNoticeDate = FocusNode();
  final FocusNode myFocusNodeNoticeTime = FocusNode();
  final FocusNode myFocusNodeNoticeDateEnd = FocusNode();
  final FocusNode myFocusNodeNoticeLocation = FocusNode();
  final FocusNode myFocusNodeNoticePlace = FocusNode();

  //tab-2
  final FocusNode myFocusNodeNoticePersonName = FocusNode();
  final FocusNode myFocusNodeNoticeProvince = FocusNode();
  final FocusNode myFocusNodeNoticeDistrict = FocusNode();
  final FocusNode myFocusNodeNoticeSubDistrict = FocusNode();
  final FocusNode myFocusNodeNoticeDetail = FocusNode();

  //tab-3
  final FocusNode myFocusNodeNoticePerson1 = FocusNode();
  final FocusNode myFocusNodeNoticePerson2 = FocusNode();
  final FocusNode myFocusNodeNoticePerson3 = FocusNode();

  //=====================TextEditingController===============================
  //tab-1
  TextEditingController editNoticeNo = new TextEditingController();
  TextEditingController editNoticeDate = new TextEditingController();
  TextEditingController editNoticeTime = new TextEditingController();
  TextEditingController editNoticeDateEnd = new TextEditingController();
  TextEditingController editNoticeLocation = new TextEditingController();
  TextEditingController editNoticePlace = new TextEditingController();

  //tab-2
  TextEditingController editNoticePersonName = new TextEditingController();
  TextEditingController editNoticeProvince = new TextEditingController();
  TextEditingController editNoticeDistrict = new TextEditingController();
  TextEditingController editNoticeSubDistrict = new TextEditingController();
  TextEditingController editNoticeDetail = new TextEditingController();

  //tab-3
  TextEditingController editNoticePerson1 = new TextEditingController();
  TextEditingController editNoticePerson2 = new TextEditingController();
  TextEditingController editNoticePerson3 = new TextEditingController();

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    /*****************************inite date time**************************/
    initializeDateFormatting();
    onGetMasOffice();

    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

    _currentNoticeDate = _convertDate(DateTime.now().toString());
    _currentNoticeTime = _convertTime(DateTime.now().toString());

    //=======================set text when start=======================
    if (widget.IsCreate) {
      print('IsCreate');
      initPlatformState();

      editNoticeNo.text = "Auto Generate";
      editNoticeDateEnd.text = "1";
      editNoticeDate.text = _currentNoticeDate;
      editNoticeTime.text = _currentNoticeTime;

      editNoticePersonName.text = "สายลับขอปิดนาม";
      _onSelectCountry(1, false, null, null, null);

      final now = DateTime.now();
      _tempDueDate = new DateTime(now.year, now.month, now.day, 23, 59, 59);

      /*_itemsNoticeStaff = [];
      addItemInitStaff(widget.ItemsPerson,7,false);
      get_staff_name(_itemsNoticeStaff, 7);*/
    } else {
      //Preview && Update
      itemsNoticeMain = widget.itemsNoticeMain;
      _itemsNoticeStaff = [];

      DateTime _tempDueDateApi;
      _tempDueDateApi = DateTime.parse(widget.itemsNoticeMain.NOTICE_DUE_DATE);
      _tempDueDate = new DateTime(_tempDueDateApi.year, _tempDueDateApi.month, _tempDueDateApi.day, 23, 59, 59);

      if (widget.itemsNoticeMain.NoticeInformer.first.INFORMER_STATUS == 0) {
        Private = true;
        TextPrivate = false;
      }

      itemsNoticeMain.NoticeStaff.forEach((item) {
        ItemsListEvidenceGetStaff evidenceGetStaff = new ItemsListEvidenceGetStaff(
            STAFF_ID: item.STAFF_ID,
            STAFF_TYPE: item.STAFF_TYPE,
            STAFF_CODE: item.STAFF_CODE,
            STAFF_REF_ID: item.STAFF_REF_ID,
            ID_CARD: item.ID_CARD,
            TITLE_ID: item.TITLE_ID,
            TITLE_NAME_TH: item.TITLE_NAME_TH,
            TITLE_SHORT_NAME_TH: item.TITLE_SHORT_NAME_TH,
            FIRST_NAME: item.FIRST_NAME,
            LAST_NAME: item.LAST_NAME,
            OPREATION_POS_NAME: item.OPREATION_POS_NAME,
            OPREATION_POS_LAVEL_NAME: item.OPREATION_POS_LAVEL_NAME,
            OPERATION_OFFICE_CODE: item.OPERATION_OFFICE_CODE,
            OPERATION_OFFICE_NAME: item.OPERATION_OFFICE_NAME,
            OPERATION_OFFICE_SHORT_NAME: item.OPERATION_OFFICE_SHORT_NAME,
            BIRTH_DATE: item.BIRTH_DATE,
            OPERATION_POS_CODE: item.OPERATION_POS_CODE,
            OPREATION_POS_LEVEL: item.OPREATION_POS_LEVEL,
            OPERATION_POS_LEVEL_NAME: item.OPERATION_POS_LEVEL_NAME,
            OPERATION_DEPT_CODE: item.OPERATION_DEPT_CODE,
            OPERATION_DEPT_NAME: item.OPERATION_DEPT_NAME,
            OPERATION_DEPT_LEVEL: item.OPERATION_DEPT_LEVEL,
            OPERATION_UNDER_DEPT_CODE: item.OPERATION_UNDER_DEPT_CODE,
            OPERATION_UNDER_DEPT_NAME: item.OPERATION_UNDER_DEPT_NAME,
            OPERATION_UNDER_DEPT_LEVEL: item.OPERATION_UNDER_DEPT_LEVEL,
            OPERATION_WORK_DEPT_CODE: item.OPERATION_WORK_DEPT_CODE,
            OPERATION_WORK_DEPT_NAME: item.OPERATION_WORK_DEPT_NAME,
            OPERATION_WORK_DEPT_LEVEL: item.OPERATION_WORK_DEPT_LEVEL,
            CONTRIBUTOR_ID: item.CONTRIBUTOR_ID,
            IsCheck: item.IsCheck);

        _itemsNoticeStaff.add(evidenceGetStaff);
      });

      // if (widget.IsPreview) {
      onLoadActionLoadDataLocalePreview(itemsNoticeMain.NoticeLocale.first.SUB_DISTRICT_ID, widget.itemsNoticeMain);
      // }

      getLocaleInforme();

      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsUpdate;

      /*if(itemsNoticeMain.NoticeLocale.length>0){
        if (itemsNoticeMain.NoticeLocale.first.SUB_DISTRICT_ID != null) {
          this.onLoadActionSubDistinctMaster(
              null,
              itemsNoticeMain.NoticeLocale.first.SUB_DISTRICT_ID,
              true,
              null);
        }
      }*/

      if (widget.IsPreview) {
        itemsFormsTab3 = [];
        if (itemsNoticeMain.IS_AUTHORITY == 1) {
          itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์ม(รว.1)", "ILG60_00_02_001"));
        } else {
          itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์ม(รว.2)", "ILG60_00_02_002"));
        }
        choices.add(Choice(title: 'แบบฟอร์ม'));
        tabController = TabController(length: choices.length, vsync: this);
        _tabPageSelector = new TabPageSelector(controller: tabController);
      } else if (widget.IsUpdate) {
        setDataInitForm();
      }
    }

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this, initialIndex: 0);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    _onSaved = widget.IsPreview;
    _onFinish = widget.IsPreview;
  }

  @override
  void dispose() {
    super.dispose();
    //tab-1
    editNoticeNo.dispose();
    editNoticeDate.dispose();
    editNoticeTime.dispose();
    editNoticeDateEnd.dispose();
    editNoticeLocation.dispose();
    editNoticePlace.dispose();

    //tab-2
    editNoticePersonName.dispose();
    editNoticeDetail.dispose();
    if (mounted) {
      setState(() {
        editNoticeProvince.dispose();
        editNoticeDistrict.dispose();
        editNoticeSubDistrict.dispose();
      });
    }
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

  Future<bool> onGetMasOffice() async {
    Map map_office = {"TEXT_SEARCH": "", "OFFICE_ID": ""};
    await new ArrestFutureMaster().apiRequestMasOfficegetByCon(map_office).then((onValue) {
      itemsOffice = onValue;

      // ItemsPersonInformation _itemPerson = widget.ItemsPerson;
      ItemsOAGMasStaff _itemPerson = widget.ItemsPerson;
      String itemOfficeCode = _itemPerson.OPERATION_OFFICE_CODE;

      itemsOffice.RESPONSE_DATA.forEach((item) {
        if (item.OFFICE_CODE == itemOfficeCode) {
          // _officeName = item.OFFICE_NAME;
          _officeName = item.OFFICE_SHORT_NAME;
        }
      });
      editNoticePlace.text = _officeName;

      print(_officeName);
    });
  }

  Future<bool> onGetMasOffice2(String code) async {
    Map map_office = {"TEXT_SEARCH": code, "OFFICE_ID": ""};
    await new ArrestFutureMaster().apiRequestMasOfficegetByCon(map_office).then((onValue) {
      ItemsArrestResponseGetOffice itemsOffice;
      itemsOffice = onValue;

      itemsOffice.RESPONSE_DATA.forEach((item) {
        officeID = item.OFFICE_ID;
      });

      print("itemsOffice id: ${officeID.toString()}");
    });
  }

  //get locale informe
  void getLocaleInforme() async {
    if (itemsNoticeMain.NoticeInformer.length > 0) {
      await onLoadActionLoadDataLocaleInforme(itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID);
    }
  }

  //set Data init
  void setDataInitForm() async {
    if (itemsNoticeMain.NoticeInformer.length > 0) {
      if (itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID != null) {
        /*this.onLoadActionSubDistinctMaster(
            null,
            itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID,
            true,
            null);*/
        print("SUB_DISTRICT_ID: ${itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID}");
        // ถ้า SUB_DISTRICT_ID = 0 คือหน้า show ผู้แจ้งความ พวกจังหวัดไรงี้จะไม่มีค่า มันคนละตัวกับ tab 1
        if (itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID != 0) {
          await onLoadActionDataInforme(itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID);
        } else {
          _onSelectCountry(1, false, null, null, null);
        }
      }
    }

    //=========================tab-1===============================
    onLoadActionDataLocalEdit(itemsNoticeMain.NoticeLocale.first.SUB_DISTRICT_ID);

    editNoticeNo.text = itemsNoticeMain.NOTICE_CODE;
    if (itemsNoticeMain.IS_AUTHORITY == 0) {
      NoticeType1 = false;
      NoticeType2 = true;
    } else {
      NoticeType1 = true;
      NoticeType2 = false;
    }
    _dtNoticeDate = DateTime.parse(itemsNoticeMain.NOTICE_DATE);
    _dtNoticeTime = DateTime.parse(itemsNoticeMain.NOTICE_DATE);
    _currentNoticeDate = _convertDate(_dtNoticeDate.toString());
    _currentNoticeTime = _convertTime(_dtNoticeTime.toString());
    editNoticeDate.text = _currentNoticeDate;
    editNoticeTime.text = _currentNoticeTime;

    editNoticeDateEnd.text = itemsNoticeMain.NOTICE_DUE.toString();
    // editNoticeLocation.text = itemsNoticeMain.NoticeLocale.first.LOCATION;
    editNoticePlace.text = itemsNoticeMain.OFFICE_NAME.toString();

    //=========================tab-2===============================
    if (itemsNoticeMain.NoticeInformer.length > 0) {
      editNoticePersonName.text = itemsNoticeMain.NoticeInformer.first.FIRST_NAME;
      temp_editNoticePersonName = editNoticePersonName.text;

      if (itemsNoticeMain.NoticeInformer.first.INFORMER_STATUS == 1) {
        Private = false; // แสดงชื่อผู้แจ้งมั้ย true = ไม่แสดง
        TextPrivate = true; // แก้ไขชื่อผู้แจ้งได้มั้ย false = แก้ไม่ได้
        InformerStatus = true;
      }

      if (sProvince != null || sDistrict != null) {
        _onSelectProvince(sProvince.PROVINCE_ID);
        _onSelectDistrict(sDistrict.DISTRICT_ID);

        editNoticeProvince.text = sProvince.PROVINCE_NAME_TH;
        editNoticeDistrict.text = sDistrict.DISTRICT_NAME_TH;
        editNoticeSubDistrict.text = sSubDistrict.SUB_DISTRICT_NAME_TH;
      }

      editNoticeDetail.text = itemsNoticeMain.NoticeInformer.first.INFORMER_INFO;
    }

    //=========================tab-3===============================
    if (itemsNoticeMain.NoticeStaff.length > 0) {
      editNoticePerson1.text = get_staff_name(itemsNoticeMain.NoticeStaff, 7) != null ? get_staff_name(itemsNoticeMain.NoticeStaff, 7) : "";
      editNoticePerson2.text = get_staff_name(itemsNoticeMain.NoticeStaff, 8) != null ? get_staff_name(itemsNoticeMain.NoticeStaff, 8) : "";
      editNoticePerson3.text = get_staff_name(itemsNoticeMain.NoticeStaff, 9) != null ? get_staff_name(itemsNoticeMain.NoticeStaff, 9) : "";
    }

    _itemsNoticeStaff = [];
    itemsNoticeMain.NoticeStaff.forEach((item) {
      ItemsListEvidenceGetStaff evidenceGetStaff = new ItemsListEvidenceGetStaff(
          STAFF_ID: item.STAFF_ID,
          STAFF_TYPE: item.STAFF_TYPE,
          STAFF_CODE: item.STAFF_CODE,
          STAFF_REF_ID: item.STAFF_REF_ID,
          ID_CARD: item.ID_CARD,
          TITLE_ID: item.TITLE_ID,
          TITLE_NAME_TH: item.TITLE_NAME_TH,
          TITLE_SHORT_NAME_TH: item.TITLE_SHORT_NAME_TH,
          FIRST_NAME: item.FIRST_NAME,
          LAST_NAME: item.LAST_NAME,
          OPREATION_POS_NAME: item.OPREATION_POS_NAME,
          OPREATION_POS_LAVEL_NAME: item.OPREATION_POS_LAVEL_NAME,
          OPERATION_OFFICE_CODE: item.OPERATION_OFFICE_CODE,
          OPERATION_OFFICE_NAME: item.OPERATION_OFFICE_NAME,
          OPERATION_OFFICE_SHORT_NAME: item.OPERATION_OFFICE_SHORT_NAME,
          BIRTH_DATE: item.BIRTH_DATE,
          OPERATION_POS_CODE: item.OPERATION_POS_CODE,
          OPREATION_POS_LEVEL: item.OPREATION_POS_LEVEL,
          OPERATION_POS_LEVEL_NAME: item.OPERATION_POS_LEVEL_NAME,
          OPERATION_DEPT_CODE: item.OPERATION_DEPT_CODE,
          OPERATION_DEPT_NAME: item.OPERATION_DEPT_NAME,
          OPERATION_DEPT_LEVEL: item.OPERATION_DEPT_LEVEL,
          OPERATION_UNDER_DEPT_CODE: item.OPERATION_UNDER_DEPT_CODE,
          OPERATION_UNDER_DEPT_NAME: item.OPERATION_UNDER_DEPT_NAME,
          OPERATION_UNDER_DEPT_LEVEL: item.OPERATION_UNDER_DEPT_LEVEL,
          OPERATION_WORK_DEPT_CODE: item.OPERATION_WORK_DEPT_CODE,
          OPERATION_WORK_DEPT_NAME: item.OPERATION_WORK_DEPT_NAME,
          OPERATION_WORK_DEPT_LEVEL: item.OPERATION_WORK_DEPT_LEVEL,
          CONTRIBUTOR_ID: item.CONTRIBUTOR_ID,
          IsCheck: item.IsCheck);

      _itemsNoticeStaff.add(evidenceGetStaff);
    });

    _noticeDate = DateTime.parse(itemsNoticeMain.NOTICE_DATE).toString();
  }

  //===========================Get Location==================================
  void getPlaceAddress(latitude, longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    var place = addresses.first;
    placeAddress = place.addressLine;

    _placeName = place.featureName.toString() + " " + place.thoroughfare.toString();
    _addressno = place.subThoroughfare;
    _province = place.adminArea;
    _gps = place.coordinates.latitude.toString() + "," + coordinates.longitude.toString();
    placeAddress = place.addressLine;

    if (place.subLocality != null) {
      if (place.subLocality.contains("เขต")) {
        List splits = place.subLocality.split(" ");
        _distict = place.subLocality.replaceAll("เขต", "").trim();
      }
    } else {
      if (place.subAdminArea.contains("อำเภอ")) {
        List splits = place.subAdminArea.split(" ");
        _distict = place.subAdminArea.replaceAll("อำเภอ", "").trim();
      }
    }

    List addressLine = place.addressLine.split(" ");
    for (int i = 0; i < addressLine.length; i++) {
      if (addressLine[i].toString().endsWith("ซอย")) {
        _lane = addressLine[i + 1];
      } else if (addressLine[i].toString().endsWith("ถนน")) {
        _road = addressLine[i + 1];
      } else if (addressLine[i].toString().endsWith("แขวง")) {
        _sub_distinct = addressLine[i + 1];
      } else if (addressLine[i].toString().endsWith("ตำบล")) {
        _sub_distinct = addressLine[i + 1];
      }
    }

    print("_province " + _province.toString());
    print("_distict " + _distict.toString());
    print("_sub_distinct " + _sub_distinct.toString());

    _onSelectCountry(1, true, _province, _distict, _sub_distinct);

    if (mounted) {
      setState(() {});
    }
  }

  initPlatformState() async {
    Locations.LocationData location;
    try {
      _permission = await _location.hasPermission();
      location = await _location.getLocation();
      error = null;

      print("_permission : " + _permission.toString());
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }
      location = null;
    }
    print(error);

    if (mounted) {
      setState(() {
        getPlaceAddress(location.latitude, location.longitude);
      });
    }
  }

  /*****************************method for main tab**************************/
  void choiceAction(Constants constants) {
    print(constants.text);
    if (mounted) {
      setState(() {
        if (constants.text.endsWith("แก้ไข")) {
          _onSaved = false;
          _onFinish = false;
          _onEdited = true;
          int init_index = tabController.index;

          final pos = tabController.length - 1;
          choices.removeAt(pos);
          if (init_index == 4) {
            tabController.animateTo(0);
            int index = tabController.index;
            tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
            _tabPageSelector = new TabPageSelector(controller: tabController);
          } else {
            int index = tabController.index;
            tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
            _tabPageSelector = new TabPageSelector(controller: tabController);
          }

          setDataInitForm();
        } else {
          _onDeleted = true;
          _showDeleteAlertDialog();
        }
      });
    }
  }

  //===========================model dialod========================

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
                if (mounted) {
                  setState(() {
                    onDelete();
                  });
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void onDelete() async {
    Map map = {"NOTICE_ID": itemsNoticeMain.NOTICE_ID};
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
    await onLoadActionDelete(map);
    Navigator.pop(context);
  }

  Future<bool> onLoadActionDelete(Map map) async {
    await NoticeFuture().apiRequestNoticeupdDelete(map).then((onValue) {
      print("Delete Notice : " + onValue.Msg.toString());
    });
    Navigator.pop(context);
    if (mounted) {
      setState(() {});
    }
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
                /*if(widget.IsUpdate) {
                  Navigator.pop(mContext,"Back");
                }else{
                  setState(() {
                    _onSaved=true;
                    _onFinish = true;

                    itemsFormsTab3 = [];
                    if(itemsNoticeMain.IS_AUTHORITY==1){
                      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์ม(รว.1)","ILG60_00_02_001"));
                    }else{
                      itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์ม(รว.2)","ILG60_00_02_002"));
                    }
                    choices.add(Choice(title: 'แบบฟอร์ม'));
                    tabController =
                        TabController(length: choices.length, vsync: this);
                    _tabPageSelector =
                    new TabPageSelector(controller: tabController);
                    tabController.animateTo(choices.length - 1);
                  });
                }*/
                if (!_onEdited) {
                  Navigator.pop(mContext, "Back");
                } else {
                  /*if (mounted) {
                    setState(() {
                      _onSaved = true;
                      _onFinish = true;

                      itemsFormsTab3 = [];
                      if (itemsNoticeMain.IS_AUTHORITY == 1) {
                        itemsFormsTab3.add(new ItemsLawsuitForms(
                            "เเบบฟอร์ม(รว.1)", "ILG60_00_02_001"));
                      } else {
                        itemsFormsTab3.add(new ItemsLawsuitForms(
                            "เเบบฟอร์ม(รว.2)", "ILG60_00_02_002"));
                      }
                      choices.add(Choice(title: 'แบบฟอร์ม'));
                      tabController =
                          TabController(length: choices.length, vsync: this);
                      _tabPageSelector =
                      new TabPageSelector(controller: tabController);
                      tabController.animateTo(choices.length - 1);
                    });
                  }*/
                  onReData();
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  //Re Data When Cancel Edited
  void onReData() async {
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
    await onLoadActionReData();
    Navigator.pop(context);
  }

  Future<bool> onLoadActionReData() async {
    //Get Locale Informe
    if (itemsNoticeMain.NoticeInformer.length > 0) {
      if (itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID != 0) {
        await onLoadActionLoadDataLocaleInforme(itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID);
      } else {
        editNoticeProvince.text = "";
        editNoticeDistrict.text = "";
        editNoticeSubDistrict.text = "";
        sProvince = null;
        sDistrict = null;
        sSubDistrict = null;
        _onSelectCountry(1, false, null, null, null);
      }
    }

    Map MAP_ARREST_ID = {'NOTICE_ID': itemsNoticeMain.NOTICE_ID};
    await NoticeFuture().apiRequestNoticegetByCon(MAP_ARREST_ID).then((onValue) {
      print('backkkkkkkkkk');
      itemsNoticeMain = onValue;
    });

    widget.IsCreate = false;
    _onSaved = true;
    _onFinish = true;
    itemsFormsTab3 = [];
    if (itemsNoticeMain.IS_AUTHORITY == 1) {
      itemsFormsTab3.add(new ItemsLawsuitForms("แบบฟอร์ม(รว.1)", "ILG60_00_02_001"));
    } else {
      itemsFormsTab3.add(new ItemsLawsuitForms("แบบฟอร์ม(รว.2)", "ILG60_00_02_002"));
    }
    choices.add(Choice(title: 'แบบฟอร์ม'));
    int index = 3;
    tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
    tabController.animateTo((choices.length - 1));

    setState(() {});
    return true;
  }

  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }

  CupertinoAlertDialog _createCupertinoDeleteItemsDialog(index, String type) {
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
                if (mounted) {
                  setState(() {
                    if (type.endsWith("Product")) {
                      if (_onEdited) {
                        if (itemsNoticeMain.NoticeProduct[index].PRODUCT_ID != null) {
                          print("case :: A");
                          list_product_del.add(itemsNoticeMain.NoticeProduct[index]);
                        } else {
                          print("case :: B");
                          list_product_add.removeAt((index - (itemsNoticeMain.NoticeProduct.length - list_product_add.length)));
                        }
                        itemsNoticeMain.NoticeProduct.removeAt(index);
                      } else {
                        _itemsDataTab5.removeAt(index);
                      }
                    }
                  });
                }
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showDeleteItemsAlertDialog(index, String type) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDeleteItemsDialog(index, type);
      },
    );
  }

  //===============================model dialog end=============================

  //Create
  Map mapDataCreate() {
    List<Map> mapLocale = [];
    List<Map> mapInforme = [];
    List<Map> mapStaff = [];
    List<Map> mapSuspect = [];
    List<Map> mapProduct = [];

    mapInforme.add({
      "NOTICE_ID": "",
      "INFORMER_ID": "",
      "ADDRESS_NO": "",
      "AGE": "",
      "ALLEY": "",
      "BUILDING_NAME": "",
      "CAREER": "",
      "EMAIL": "",
      // "FIRST_NAME": "สายลับขอปิดนาม",
      "FIRST_NAME": editNoticePersonName.text,
      "FLOOR": "",
      "GPS": "",
      "ID_CARD": "",
      "INFORMER_FINGER_PRINT": "",
      "INFORMER_INFO": editNoticeDetail.text,
      "INFORMER_PHOTO": "",
      "INFORMER_STATUS": InformerStatus ? 1 : 0,
      "IS_ACTIVE": 1,
      "LANE": "",
      "LAST_NAME": "",
      "MIDDLE_NAME": "",
      "OTHER_NAME": "",
      "PERSON_DESC": "",
      "POSITION": "",
      "ROAD": "",
      "ROOM_NO": "",
      // "SUB_DISTRICT_ID": sSubDistrict.SUB_DISTRICT_ID,
      "SUB_DISTRICT_ID": sSubDistrict != null ? sSubDistrict.SUB_DISTRICT_ID : 0,
      "TEL_NO": "",
      "TITLE_ID": "",
      "TITLE_NAME_EN": "",
      "TITLE_NAME_TH": "",
      "TITLE_SHORT_NAME_EN": "",
      "TITLE_SHORT_NAME_TH": "",
      "VILLAGE_NAME": "",
      "VILLAGE_NO": ""
    });

    mapLocale.add({
      "LOCALE_ID": "",
      "NOTICE_ID": "",
      "SUB_DISTRICT_ID": _itemsLocale.SUB_DISTICT.SUB_DISTRICT_ID,
      "GPS": _itemsLocale.GPS,
      "ADDRESS_NO": _itemsLocale.ADDRESS_NO,
      "VILLAGE_NO": "",
      "BUILDING_NAME": "",
      "ROOM_NO": "",
      "ALLEY": "",
      "FLOOR": "",
      "VILLAGE_NAME": "",
      "LANE": _itemsLocale.LANE != null ? _itemsLocale.LANE : "",
      "ROAD": _itemsLocale.ROAD,
      "ADDRESS_TYPE": "",
      "ADDRESS_STATUS": 0,
      "POLICE_STATION": "",
      // "LOCATION": editNoticeLocation.text,
      "LOCATION": noticesLocation,
      "IS_ACTIVE": 1
    });

    _itemsDataTab5.forEach((item) {
      mapProduct.add({
        "NOTICE_ID": "",
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
        "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
        "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
        "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
        // "PRODUCT_GROUP_CODE": "",
        "PRODUCT_GROUP_CODE": item.PRODUCT_GROUP_CODE,
        "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME != null ? item.PRODUCT_GROUP_NAME : "",
        "PRODUCT_CATEGORY_CODE": "",
        "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME != null ? item.PRODUCT_CATEGORY_NAME : "",
        "PRODUCT_TYPE_CODE": "",
        "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME != null ? item.PRODUCT_TYPE_NAME : "",
        "PRODUCT_SUBTYPE_CODE": "",
        "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME != null ? item.PRODUCT_SUBTYPE_NAME : "",
        "PRODUCT_SUBSETTYPE_CODE": "",
        "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME != null ? item.PRODUCT_SUBSETTYPE_NAME : "",
        "PRODUCT_BRAND_CODE": "",
        "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH != null ? item.PRODUCT_BRAND_NAME_TH : "",
        "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN != null ? item.PRODUCT_BRAND_NAME_EN : "",
        "PRODUCT_SUBBRAND_CODE": "",
        "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH != null ? item.PRODUCT_SUBBRAND_NAME_TH : "",
        "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN != null ? item.PRODUCT_SUBBRAND_NAME_EN : "",
        "PRODUCT_MODEL_CODE": "",
        "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH != null ? item.PRODUCT_MODEL_NAME_TH : "",
        "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN != null ? item.PRODUCT_MODEL_NAME_EN : "",
        "IS_TAX_VALUE": 1,
        "TAX_VALUE": item.TAX_VALUE,
        "IS_TAX_VOLUMN": 1,
        "TAX_VOLUMN": item.TAX_VOLUMN,
        "TAX_VOLUMN_UNIT": item.TAX_VOLUMN_UNIT,
        "LICENSE_PLATE": "",
        "ENGINE_NO": "",
        "CHASSIS_NO": "",
        "PRODUCT_DESC": item.PRODUCT_DESC,
        "SUGAR": item.SUGAR,
        "CO2": item.CO2,
        "DEGREE": item.DEGREE,
        "PRICE": item.PRICE,
        "SIZES": item.SIZES,
        "SIZES_UNIT": item.SIZES_UNIT,
        "QUANTITY": item.QUANTITY != null ? item.QUANTITY : "",
        "QUANTITY_UNIT": item.QUANTITY_UNIT,
        "VOLUMN": item.VOLUMN != null ? item.VOLUMN : "",
        "VOLUMN_UNIT": item.VOLUMN_UNIT,
        "REMARK": item.REMARK,
        "IS_DOMESTIC": item.IS_DOMESTIC,
        "IS_ILLEGAL": 1,
        "IS_ACTIVE": 1,
      });
    });

    _itemsNoticeStaff.forEach((item) {
      mapStaff.add({
        "AGE": "",
        "CONTRIBUTOR_ID": item.CONTRIBUTOR_ID,
        "FIRST_NAME": item.FIRST_NAME,
        "ID_CARD": item.ID_CARD,
        "IS_ACTIVE": 1,
        "LAST_NAME": item.LAST_NAME,
        "NOTICE_ID": "",
        "STAFF_CODE": item.STAFF_CODE != null ? item.STAFF_CODE : "",
        "STAFF_ID": "",
        "STAFF_REF_ID": item.STAFF_ID,
        "STAFF_TYPE": item.STAFF_TYPE,
        "STATUS": 1,
        "TITLE_ID": item.TITLE_ID,
        "TITLE_NAME_EN": "",
        "TITLE_NAME_TH": item.TITLE_NAME_TH,
        "TITLE_SHORT_NAME_EN": "",
        "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
        "OPERATION_DEPT_CODE": item.OPERATION_DEPT_CODE != null ? item.OPERATION_DEPT_CODE : "",
        "OPERATION_DEPT_LEVEL": item.OPERATION_DEPT_LEVEL != null ? item.OPERATION_DEPT_LEVEL : "",
        "OPERATION_DEPT_NAME": item.OPERATION_DEPT_NAME != null ? item.OPERATION_DEPT_NAME : "",
        "OPERATION_OFFICE_CODE": item.OPERATION_OFFICE_CODE != null ? item.OPERATION_OFFICE_CODE : "",
        "OPERATION_OFFICE_NAME": item.OPERATION_OFFICE_NAME != null ? item.OPERATION_OFFICE_NAME : "",
        "OPERATION_OFFICE_SHORT_NAME": item.OPERATION_OFFICE_SHORT_NAME != null ? item.OPERATION_OFFICE_SHORT_NAME : "",
        "OPERATION_POS_CODE": item.OPERATION_POS_CODE != null ? item.OPERATION_POS_CODE : "",
        "OPERATION_POS_LEVEL_NAME": item.OPREATION_POS_LAVEL_NAME != null ? item.OPREATION_POS_LAVEL_NAME : "",
        "OPERATION_UNDER_DEPT_CODE": item.OPERATION_UNDER_DEPT_CODE != null ? item.OPERATION_UNDER_DEPT_CODE : "",
        "OPERATION_UNDER_DEPT_LEVEL": item.OPERATION_UNDER_DEPT_LEVEL != null ? item.OPERATION_UNDER_DEPT_LEVEL : "",
        "OPERATION_UNDER_DEPT_NAME": item.OPERATION_UNDER_DEPT_NAME != null ? item.OPERATION_UNDER_DEPT_NAME : "",
        "OPERATION_WORK_DEPT_CODE": item.OPERATION_WORK_DEPT_CODE != null ? item.OPERATION_WORK_DEPT_CODE : "",
        "OPERATION_WORK_DEPT_LEVEL": item.OPERATION_WORK_DEPT_LEVEL != null ? item.OPERATION_WORK_DEPT_LEVEL : "",
        "OPERATION_WORK_DEPT_NAME": item.OPERATION_WORK_DEPT_NAME != null ? item.OPERATION_WORK_DEPT_NAME : "",
        "OPREATION_POS_LEVEL": item.OPREATION_POS_LEVEL != null ? item.OPREATION_POS_LEVEL : "",
        "OPREATION_POS_NAME": item.OPREATION_POS_NAME != null ? item.OPREATION_POS_NAME : "",
        "REMARK": "",
        "REPRESENT_DEPT_CODE": "",
        "REPRESENT_DEPT_LEVEL": "",
        "REPRESENT_DEPT_NAME": "",
        "REPRESENT_OFFICE_CODE": "",
        "REPRESENT_OFFICE_NAME": "",
        "REPRESENT_OFFICE_SHORT_NAME": "",
        "REPRESENT_POS_CODE": "",
        "REPRESENT_POS_LEVEL": "",
        "REPRESENT_POS_LEVEL_NAME": "",
        "REPRESENT_POS_NAME": "",
        "REPRESENT_UNDER_DEPT_CODE": "",
        "REPRESENT_UNDER_DEPT_LEVEL": "",
        "REPRESENT_UNDER_DEPT_NAME": "",
        "REPRESENT_WORK_DEPT_CODE": "",
        "REPRESENT_WORK_DEPT_LEVEL": "",
        "REPRESENT_WORK_DEPT_NAME": "",
        "MANAGEMENT_DEPT_CODE": "",
        "MANAGEMENT_DEPT_LEVEL": "",
        "MANAGEMENT_DEPT_NAME": "",
        "MANAGEMENT_OFFICE_CODE": "",
        "MANAGEMENT_OFFICE_NAME": "",
        "MANAGEMENT_OFFICE_SHORT_NAME": "",
        "MANAGEMENT_POS_CODE": "",
        "MANAGEMENT_POS_LEVEL": "",
        "MANAGEMENT_POS_LEVEL_NAME": "",
        "MANAGEMENT_POS_NAME": "",
        "MANAGEMENT_UNDER_DEPT_CODE": "",
        "MANAGEMENT_UNDER_DEPT_LEVEL": "",
        "MANAGEMENT_UNDER_DEPT_NAME": "",
        "MANAGEMENT_WORK_DEPT_CODE": "",
        "MANAGEMENT_WORK_DEPT_LEVEL": "",
        "MANAGEMENT_WORK_DEPT_NAME": "",
      });
    });

    Map map = {
      "NOTICE_ID": "",
      // "OFFICE_ID": "",
      "OFFICE_ID": officeID,
      "NOTICE_CODE": transection_no,
      "OFFICE_CODE": _itemsLocale.SUB_DISTICT.OFFICE_CODE,
      "OFFICE_NAME": editNoticePlace.text,
      "NOTICE_DATE": _noticeDate,
      "NOTICE_DUE": editNoticeDateEnd.text.isEmpty ? "" : int.parse(editNoticeDateEnd.text),
      "NOTICE_DUE_DATE": editNoticeDateEnd.text.isEmpty ? "" : _tempDueDate.add(Duration(days: int.parse(editNoticeDateEnd.text) - 1)).toString(),
      "COMMUNICATION_CHANNEL": 4,
      "IS_ARREST": 0,
      "IS_AUTHORITY": NoticeType1 ? 1 : 0,
      "IS_ACTIVE": 1,
      "IS_MATCH": 0,
      "CREATE_DATE": DateTime.now().toString(),
      "CREATE_USER_ACCOUNT_ID": "",
      "UPDATE_DATE": "",
      "UPDATE_USER_ACCOUNT_ID": "",
      "NoticeInformer": mapInforme,
      "NoticeLocale": mapLocale,
      "NoticeSuspect": mapSuspect,
      "NoticeProduct": mapProduct,
      "NoticeStaff": mapStaff
    };

    return map;
  }

  //Update
  Map mapDataUpdate() {
    List<Map> mapLocale = [];
    List<Map> mapInforme = [];

    itemsNoticeMain.NoticeInformer.forEach((item) {
      mapInforme.add({
        "NOTICE_ID": item.NOTICE_ID,
        "INFORMER_ID": item.INFORMER_ID,
        "ADDRESS_NO": "",
        "AGE": "",
        "ALLEY": "",
        "BUILDING_NAME": "",
        "CAREER": "",
        "EMAIL": "",
        // "FIRST_NAME": "สายลับขอปิดนาม",
        "FIRST_NAME": editNoticePersonName.text,
        "FLOOR": "",
        "GPS": "",
        "ID_CARD": "",
        "INFORMER_FINGER_PRINT": "",
        "INFORMER_INFO": editNoticeDetail.text,
        "INFORMER_PHOTO": "",
        "INFORMER_STATUS": InformerStatus ? 1 : 0,
        "IS_ACTIVE": 1,
        "LANE": "",
        "LAST_NAME": "",
        "MIDDLE_NAME": "",
        "OTHER_NAME": "",
        "PERSON_DESC": "",
        "POSITION": "",
        "ROAD": "",
        "ROOM_NO": "",
        "SUB_DISTRICT_ID": sSubDistrict != null ? sSubDistrict.SUB_DISTRICT_ID : 0,
        // "SUB_DISTRICT_ID": editNoticeSubDistrict.text,
        "TEL_NO": "",
        "TITLE_ID": "",
        "TITLE_NAME_EN": "",
        "TITLE_NAME_TH": "",
        "TITLE_SHORT_NAME_EN": "",
        "TITLE_SHORT_NAME_TH": "",
        "VILLAGE_NAME": "",
        "VILLAGE_NO": ""
      });
    });

    itemsNoticeMain.NoticeLocale.forEach((item) {
      mapLocale.add({
        "LOCALE_ID": item.LOCALE_ID,
        "NOTICE_ID": item.NOTICE_ID,
        "SUB_DISTRICT_ID": _itemsLocale != null ? _itemsLocale.SUB_DISTICT.SUB_DISTRICT_ID : item.SUB_DISTRICT_ID,
        "GPS": _itemsLocale != null ? _itemsLocale.GPS : item.GPS,
        "ADDRESS_NO": _itemsLocale != null ? _itemsLocale.ADDRESS_NO : item.ADDRESS_NO,
        "VILLAGE_NO": "",
        "BUILDING_NAME": "",
        "ROOM_NO": "",
        "ALLEY": "",
        "FLOOR": "",
        "VILLAGE_NAME": "",
        "LANE": _itemsLocale != null ? _itemsLocale.LANE : item.LANE,
        "ROAD": _itemsLocale != null ? _itemsLocale.ROAD : item.ROAD,
        "ADDRESS_TYPE": "",
        "ADDRESS_STATUS": 0,
        "POLICE_STATION": "",
        // "LOCATION": editNoticeLocation.text,
        "LOCATION": noticesLocation,
        "IS_ACTIVE": 1
      });
    });

    Map mapNotice = {
      "NOTICE_ID": itemsNoticeMain.NOTICE_ID,
      // "OFFICE_ID": "",
      "OFFICE_ID": officeID,
      "NOTICE_CODE": itemsNoticeMain.NOTICE_CODE,
      "OFFICE_CODE": _itemsLocale != null ? _itemsLocale.SUB_DISTICT.OFFICE_CODE : itemsNoticeMain.OFFICE_CODE,
      "OFFICE_NAME": editNoticePlace.text,
      "NOTICE_DATE": _noticeDate,
      "NOTICE_DUE": editNoticeDateEnd.text.isEmpty ? "" : int.parse(editNoticeDateEnd.text),
      "NOTICE_DUE_DATE": editNoticeDateEnd.text.isEmpty ? "" : _tempDueDate.add(Duration(days: int.parse(editNoticeDateEnd.text) - 1)).toString(),
      "COMMUNICATION_CHANNEL": 4,
      "IS_ARREST": 0,
      "IS_AUTHORITY": NoticeType1 ? 1 : 0,
      "IS_ACTIVE": 1,
      "IS_MATCH": 0,
      "CREATE_DATE": DateTime.now().toString(),
      "CREATE_USER_ACCOUNT_ID": "",
      "UPDATE_DATE": "",
      "UPDATE_USER_ACCOUNT_ID": "",
      "NoticeInformer": mapInforme,
      "NoticeLocale": mapLocale,
    };

    return mapNotice;
  }

  void onSaved(BuildContext mContext) async {
    if (editNoticeDateEnd.text.isNotEmpty) {
      print(DateFormat("yyyy-MM").format(DateTime.now()) + "-" + (int.parse(DateFormat("dd").format(DateTime.now())) + (int.parse(editNoticeDateEnd.text) - 1)).toString());
    }
    //tab1
    if (editNoticeDateEnd.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณาระบุข้อมูล "ใช้ได้ภายในกำหนด(วัน)"');
    } else if (noticesLocation == "" || editNoticeLocation.text.isEmpty) {
      // editNoticeLocation.text.isEmpty
      new VerifyDialog(mContext, 'กรุณาระบุข้อมูล "สถานที่เกิดเหตุ"');
    } else if (editNoticePlace.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณาระบุข้อมูล "เขียนที่"');
    } else if (editNoticePersonName.text == "" || editNoticePersonName.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณาระบุข้อมูล "ชื่อผู้แจ้ง"');
    } //tab3
    else if (NoticeType2 && editNoticePerson1.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณาระบุข้อมูล "ผู้รับเเจ้งความ"');
    } else if (NoticeType1 && editNoticePerson2.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณาระบุข้อมูล "ผู้มีอำนาจรับแจ้งความ"');
    } //tab2
    else if (editNoticeDetail.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณาระบุข้อมูล "รายละเอียดแจ้งความ"');
    }
    // else if (_onEdited && itemsNoticeMain.NoticeSuspect.length == 0 && itemsNoticeMain.NoticeProduct.length == 0) {
    //   new VerifyDialog(mContext, 'กรุณาระบุข้อมูล "สินค้าต้องสงสัย"');
    // }
    else {
      //request
      if (!_onEdited) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return /*WillPopScope(
              onWillPop: () {},
              child: Center(
                child: CupertinoActivityIndicator(
                ),
              ),
            );*/
                  Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onGetMasOffice2(_itemsLocale.SUB_DISTICT.OFFICE_CODE);
        await onLoadActionInsAll();

        Navigator.pop(context);
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return /*WillPopScope(
              onWillPop: () {},
              child: Center(
                child: CupertinoActivityIndicator(
                ),
              ),
            );*/
                  Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onGetMasOffice2(_itemsLocale != null ? _itemsLocale.SUB_DISTICT.OFFICE_CODE : itemsNoticeMain.OFFICE_CODE);
        await onLoadActionUpdAll();
        Navigator.pop(context);
      }
    }
  }

  bool IsArrestCode;
  bool InsertNotSuccess = false;

  //on show dialog
  Future<bool> onLoadActionInsAll() async {
    InsertNotSuccess = false;
    //**************************Running Notice Code*********************
    Map map_transec = {"RUNNING_TABLE": "OPS_NOTICE", "RUNNING_OFFICE_CODE": _itemsLocale.SUB_DISTICT.OFFICE_CODE};
    await new TransectionFuture().apiRequestTransactionRunninggetByCon(map_transec).then((onValue) {
      _itemTransection = onValue;
      if (_itemTransection.length != 0) {
        IsArrestCode = true;
        transection_no = (_itemTransection.last.RUNNING_NO + 1).toString();
        if (transection_no.length != 5) {
          String sum = "";
          for (int i = 0; i < 5 - transection_no.length; i++) {
            sum += "0";
          }
          transection_no = _itemTransection.last.RUNNING_PREFIX + _itemTransection.last.RUNNING_OFFICE_CODE + _itemTransection.last.RUNNING_YEAR + sum + transection_no;
        }
      } else {
        IsArrestCode = false;
        DateFormat format_auto = DateFormat("yyyy");
        String date_auto = (int.parse(format_auto.format(DateTime.now()).toString()) + 543).toString().substring(2);
        transection_no = "LS" + _itemsLocale.SUB_DISTICT.OFFICE_CODE + date_auto + "00001";
      }
    });
    print("transection_no : " + transection_no);
    //print(mapData());

    await NoticeFuture().apiRequestNoticeinsAll(mapDataCreate()).then((onValue) async {
      if (onValue != null && onValue.NOTICE_ID != 0) {
        if (IsArrestCode) {
          Map map_tran_up = {
            "RUNNING_ID": _itemTransection.last.RUNNING_ID,
          };
          await new TransectionFuture().apiRequestTransactionRunningupdByCon(map_tran_up).then((onValue) {
            print("Update Transection : " + onValue.Msg);
          });
        } else {
          Map map_tran_ins = {"RUNNING_OFFICE_ID": 30, "RUNNING_OFFICE_CODE": _itemsLocale.SUB_DISTICT.OFFICE_CODE, "RUNNING_TABLE": "OPS_NOTICE", "RUNNING_PREFIX": "LS"};
          await new TransectionFuture().apiRequestTransactionRunninginsAll(map_tran_ins).then((onValue) {
            print("Insert Transection : " + onValue.Msg);
          });
        }

        Map MAP_ARREST_ID = {'NOTICE_ID': onValue.NOTICE_ID};
        await NoticeFuture().apiRequestNoticegetByCon(MAP_ARREST_ID).then((onValue) {
          itemsNoticeMain = onValue;
        });

        //Get Locale Informe
        if (itemsNoticeMain.NoticeInformer.length > 0) {
          if (itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID != 0) {
            await onLoadActionLoadDataLocaleInforme(itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID);
            print("Complete : " + sProvince.PROVINCE_NAME_TH);
            print("Complete : " + sDistrict.DISTRICT_NAME_TH);
            print("Complete : " + sSubDistrict.SUB_DISTRICT_NAME_TH);
          } else {}
        }

        widget.IsCreate = false;
        _onSaved = true;
        _onFinish = true;
        itemsFormsTab3 = [];
        if (itemsNoticeMain.IS_AUTHORITY == 1) {
          itemsFormsTab3.add(new ItemsLawsuitForms("แบบฟอร์ม(รว.1)", "ILG60_00_02_001"));
        } else {
          itemsFormsTab3.add(new ItemsLawsuitForms("แบบฟอร์ม(รว.2)", "ILG60_00_02_002"));
        }
        int index = 3;
        choices.add(Choice(title: 'แบบฟอร์ม'));
        tabController = TabController(length: choices.length, vsync: this, initialIndex: index);
        _tabPageSelector = new TabPageSelector(controller: tabController);
        tabController.animateTo((choices.length - 1));
      } else {
        InsertNotSuccess = true;
      }
    });
    if (mounted) {
      setState(() {});
    }
    return true;
  }

  //======================Update Notice=======================
  Future<bool> onLoadActionUpdAll() async {
    InsertNotSuccess = false;
    await NoticeFuture().apiRequestNoticeupdByCon(mapDataUpdate()).then((onValue) async {
      if (onValue.IsSuccess.trim().endsWith("True")) {
        print("Update Notice : " + onValue.IsSuccess);

        List<Map> mapSuspectDel = [];
        List<Map> mapSuspectAdd = [];
        List<Map> mapProductDel = [];
        List<Map> mapProductAdd = [];
        List<Map> mapProductUpd = [];
        List<Map> mapStaffDel = [];
        List<Map> mapStaffAdd = [];
        List<Map> mapStaffUpd = [];

        // //====================Delete Suspect============
        // list_suspect_del.forEach((item) {
        //   mapSuspectDel.add({"SUSPECT_ID": item.SUSPECT_ID});
        // });
        // for (int i = 0; i < mapSuspectDel.length; i++) {
        //   await NoticeFuture().apiRequestNoticeSuspectupdDelete(mapSuspectDel[i]).then((onValue) async {
        //     print("Del Suspect : " + onValue.IsSuccess.toString());
        //   });
        // }
        // //====================Add Suspect===============
        // list_suspect_add.forEach((item) {
        //   mapSuspectAdd.add({
        //     "SUSPECT_ID": "",
        //     "NOTICE_ID": itemsNoticeMain.NOTICE_ID,
        //     "PERSON_ID": item.PERSON_ID,
        //     "TITLE_ID": item.TITLE_ID,
        //     "PERSON_TYPE": item.PERSON_TYPE,
        //     "ENTITY_TYPE": item.ENTITY_TYPE,
        //     "TITLE_NAME_TH": item.TITLE_NAME_TH,
        //     "TITLE_NAME_EN": item.TITLE_NAME_EN,
        //     "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
        //     "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
        //     "FIRST_NAME": item.FIRST_NAME,
        //     "MIDDLE_NAME": item.MIDDLE_NAME,
        //     "LAST_NAME": item.LAST_NAME,
        //     "OTHER_NAME": item.OTHER_NAME,
        //     "COMPANY_NAME": "",
        //     "COMPANY_REGISTRATION_NO": "",
        //     "EXCISE_REGISTRATION_NO": "",
        //     "ID_CARD": item.ID_CARD,
        //     "AGE": item.AGE,
        //     "PASSPORT_NO": item.PASSPORT_NO,
        //     "CAREER": "",
        //     "PERSON_DESC": "",
        //     "EMAIL": "",
        //     "TEL_NO": "",
        //     "MISTREAT_NO": item.MISTREAT_NO,
        //     "IS_ACTIVE": 1
        //   });
        // });
        // for (int i = 0; i < mapSuspectAdd.length; i++) {
        //   await NoticeFuture().apiRequestNoticeSupectinsAll(mapSuspectAdd[i]).then((onValue) async {
        //     print("Add Suspect : " + onValue.IsSuccess.toString());
        //   });
        // }

        //====================Delete Product============
        list_product_del.forEach((item) {
          mapProductDel.add({"PRODUCT_ID": item.PRODUCT_ID});
        });
        for (int i = 0; i < mapProductDel.length; i++) {
          await NoticeFuture().apiRequestNoticeProductupdDelete(mapProductDel[i]).then((onValue) async {
            print("Del Product : " + onValue.IsSuccess.toString());
          });
        }
        //====================Add Product===============
        list_product_add.forEach((item) {
          mapProductAdd.add({
            "NOTICE_ID": itemsNoticeMain.NOTICE_ID,
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
            "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
            "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
            "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
            "PRODUCT_GROUP_CODE": item.PRODUCT_GROUP_CODE,
            "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME != null ? item.PRODUCT_GROUP_NAME : "",
            "PRODUCT_CATEGORY_CODE": "",
            "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME != null ? item.PRODUCT_CATEGORY_NAME : "",
            "PRODUCT_TYPE_CODE": "",
            "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME != null ? item.PRODUCT_TYPE_NAME : "",
            "PRODUCT_SUBTYPE_CODE": "",
            "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME != null ? item.PRODUCT_SUBTYPE_NAME : "",
            "PRODUCT_SUBSETTYPE_CODE": "",
            "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME != null ? item.PRODUCT_SUBSETTYPE_NAME : "",
            "PRODUCT_BRAND_CODE": "",
            "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH != null ? item.PRODUCT_BRAND_NAME_TH : "",
            "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN != null ? item.PRODUCT_BRAND_NAME_EN : "",
            "PRODUCT_SUBBRAND_CODE": "",
            "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH != null ? item.PRODUCT_SUBBRAND_NAME_TH : "",
            "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN != null ? item.PRODUCT_SUBBRAND_NAME_EN : "",
            "PRODUCT_MODEL_CODE": "",
            "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH != null ? item.PRODUCT_MODEL_NAME_TH : "",
            "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN != null ? item.PRODUCT_MODEL_NAME_EN : "",
            "IS_TAX_VALUE": 1,
            "TAX_VALUE": item.TAX_VALUE,
            "IS_TAX_VOLUMN": 1,
            "TAX_VOLUMN": item.TAX_VOLUMN,
            "TAX_VOLUMN_UNIT": item.TAX_VOLUMN_UNIT,
            "LICENSE_PLATE": "",
            "ENGINE_NO": "",
            "CHASSIS_NO": "",
            "PRODUCT_DESC": item.PRODUCT_DESC,
            "SUGAR": item.SUGAR,
            "CO2": item.CO2,
            "DEGREE": item.DEGREE,
            "PRICE": item.PRICE,
            "SIZES": item.SIZES,
            "SIZES_UNIT": item.SIZES_UNIT,
            "QUANTITY": item.QUANTITY != null ? item.QUANTITY : "",
            "QUANTITY_UNIT": item.QUANTITY_UNIT,
            "VOLUMN": item.VOLUMN != null ? item.VOLUMN : "",
            "VOLUMN_UNIT": item.VOLUMN_UNIT,
            "REMARK": item.REMARK,
            "IS_DOMESTIC": item.IS_DOMESTIC,
            "IS_ILLEGAL": 1,
            "IS_ACTIVE": 1,
          });
        });
        for (int i = 0; i < mapProductAdd.length; i++) {
          await NoticeFuture().apiRequestNoticeProductinsAll(mapProductAdd[i]).then((onValue) async {
            print("Add Product : " + onValue.IsSuccess.toString());
          });
        }
        //====================Update Product============
        list_product_upd.forEach((item) {
          mapProductUpd.add({
            "PRODUCT_ID": item.PRODUCT_ID,
            "NOTICE_ID": item.NOTICE_ID,
            "PRODUCT_MAPPING_ID": "",
            "PRODUCT_CODE": "",
            "PRODUCT_REF_CODE": "",
            "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
            "PRODUCT_CATEGORY_ID": "",
            "PRODUCT_TYPE_ID": "",
            "PRODUCT_SUBTYPE_ID": "",
            "PRODUCT_SUBSETTYPE_ID": "",
            "PRODUCT_BRAND_ID": "",
            "PRODUCT_SUBBRAND_ID": "",
            "PRODUCT_MODEL_ID": "",
            "PRODUCT_TAXDETAIL_ID": "",
            "SIZES_UNIT_ID": "",
            "QUATITY_UNIT_ID": "",
            "VOLUMN_UNIT_ID": "",
            "PRODUCT_GROUP_CODE": item.PRODUCT_GROUP_CODE,
            "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME != null ? item.PRODUCT_GROUP_NAME : "",
            "PRODUCT_CATEGORY_CODE": "",
            "PRODUCT_CATEGORY_NAME": "",
            "PRODUCT_TYPE_CODE": "",
            "PRODUCT_TYPE_NAME": "",
            "PRODUCT_SUBTYPE_CODE": "",
            "PRODUCT_SUBTYPE_NAME": "",
            "PRODUCT_SUBSETTYPE_CODE": "",
            "PRODUCT_SUBSETTYPE_NAME": "",
            "PRODUCT_BRAND_CODE": "",
            "PRODUCT_BRAND_NAME_TH": "",
            "PRODUCT_BRAND_NAME_EN": "",
            "PRODUCT_SUBBRAND_CODE": "",
            "PRODUCT_SUBBRAND_NAME_TH": "",
            "PRODUCT_SUBBRAND_NAME_EN": "",
            "PRODUCT_MODEL_CODE": "",
            "PRODUCT_MODEL_NAME_TH": "",
            "PRODUCT_MODEL_NAME_EN": "",
            "IS_TAX_VALUE": "",
            "TAX_VALUE": "",
            "IS_TAX_VOLUMN": "",
            "TAX_VOLUMN": "",
            "TAX_VOLUMN_UNIT": "",
            "LICENSE_PLATE": "",
            "ENGINE_NO": "",
            "CHASSIS_NO": "",
            "PRODUCT_DESC": item.PRODUCT_DESC,
            "SUGAR": "",
            "CO2": "",
            "DEGREE": "",
            "PRICE": "",
            "SIZES": "",
            "SIZES_UNIT": "",
            "QUANTITY": "",
            "QUANTITY_UNIT": "",
            "VOLUMN": "",
            "VOLUMN_UNIT": "",
            "REMARK": "",
            "IS_DOMESTIC": "",
            "IS_ILLEGAL": "",
            "IS_ACTIVE": 1
          }
              //   {
              //   "PRODUCT_ID": item.PRODUCT_ID,
              //   "NOTICE_ID": item.NOTICE_ID,
              //   "PRODUCT_MAPPING_ID": item.PRODUCT_MAPPING_ID,
              //   "PRODUCT_CODE": item.PRODUCT_CODE,
              //   "PRODUCT_REF_CODE": item.PRODUCT_REF_CODE,
              //   "PRODUCT_GROUP_ID": item.PRODUCT_GROUP_ID,
              //   "PRODUCT_CATEGORY_ID": item.PRODUCT_CATEGORY_ID,
              //   "PRODUCT_TYPE_ID": item.PRODUCT_TYPE_ID,
              //   "PRODUCT_SUBTYPE_ID": item.PRODUCT_SUBTYPE_ID,
              //   "PRODUCT_SUBSETTYPE_ID": item.PRODUCT_SUBSETTYPE_ID,
              //   "PRODUCT_BRAND_ID": item.PRODUCT_BRAND_ID,
              //   "PRODUCT_SUBBRAND_ID": item.PRODUCT_SUBBRAND_ID,
              //   "PRODUCT_MODEL_ID": item.PRODUCT_MODEL_ID,
              //   "PRODUCT_TAXDETAIL_ID": item.PRODUCT_TAXDETAIL_ID,
              //   "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
              //   "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
              //   "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
              //   // "PRODUCT_GROUP_CODE": "",
              //   "PRODUCT_GROUP_CODE": item.PRODUCT_GROUP_CODE,
              //   "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME != null ? item.PRODUCT_GROUP_NAME : "",
              //   "PRODUCT_CATEGORY_CODE": "",
              //   "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME != null ? item.PRODUCT_CATEGORY_NAME : "",
              //   "PRODUCT_TYPE_CODE": "",
              //   "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME != null ? item.PRODUCT_TYPE_NAME : "",
              //   "PRODUCT_SUBTYPE_CODE": "",
              //   "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME != null ? item.PRODUCT_SUBTYPE_NAME : "",
              //   "PRODUCT_SUBSETTYPE_CODE": "",
              //   "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME != null ? item.PRODUCT_SUBSETTYPE_NAME : "",
              //   "PRODUCT_BRAND_CODE": "",
              //   "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH != null ? item.PRODUCT_BRAND_NAME_TH : "",
              //   "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN != null ? item.PRODUCT_BRAND_NAME_EN : "",
              //   "PRODUCT_SUBBRAND_CODE": "",
              //   "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH != null ? item.PRODUCT_SUBBRAND_NAME_TH : "",
              //   "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN != null ? item.PRODUCT_SUBBRAND_NAME_EN : "",
              //   "PRODUCT_MODEL_CODE": "",
              //   "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH != null ? item.PRODUCT_MODEL_NAME_TH : "",
              //   "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN != null ? item.PRODUCT_MODEL_NAME_EN : "",
              //   "IS_TAX_VALUE": 1,
              //   "TAX_VALUE": item.TAX_VALUE,
              //   "IS_TAX_VOLUMN": 1,
              //   "TAX_VOLUMN": item.TAX_VOLUMN,
              //   "TAX_VOLUMN_UNIT": item.TAX_VOLUMN_UNIT,
              //   "LICENSE_PLATE": "",
              //   "ENGINE_NO": "",
              //   "CHASSIS_NO": "",
              //   "PRODUCT_DESC": item.PRODUCT_DESC,
              //   "SUGAR": item.SUGAR,
              //   "CO2": item.CO2,
              //   "DEGREE": item.DEGREE,
              //   "PRICE": item.PRICE,
              //   "SIZES": item.SIZES,
              //   "SIZES_UNIT": item.SIZES_UNIT,
              //   "QUANTITY": item.QUANTITY,
              //   "QUANTITY_UNIT": item.QUANTITY_UNIT,
              //   "VOLUMN": item.VOLUMN,
              //   "VOLUMN_UNIT": item.VOLUMN_UNIT,
              //   "REMARK": item.REMARK,
              //   "IS_DOMESTIC": item.IS_DOMESTIC,
              //   "IS_ILLEGAL": 1,
              //   "IS_ACTIVE": 1,
              // }
              );
        });
        for (int i = 0; i < mapProductUpd.length; i++) {
          await NoticeFuture().apiRequestNoticeProductupdByCon(mapProductUpd[i]).then((onValue) async {
            print("Update Product : " + onValue.IsSuccess.toString());
          });
        }

        //====================Delete Staff============
        itemsNoticeMain.NoticeStaff.forEach((item) {
          if (editNoticePerson1.text.isEmpty && get_staff_name(itemsNoticeMain.NoticeStaff, 7) != null) {
            if (item.CONTRIBUTOR_ID == 7) {
              list_staff_del.add(item);
            }
          }
          if (editNoticePerson2.text.isEmpty && get_staff_name(itemsNoticeMain.NoticeStaff, 8) != null) {
            if (item.CONTRIBUTOR_ID == 8) {
              list_staff_del.add(item);
            }
          }
          if (editNoticePerson3.text.isEmpty && get_staff_name(itemsNoticeMain.NoticeStaff, 9) != null) {
            if (item.CONTRIBUTOR_ID == 9) {
              list_staff_del.add(item);
            }
          }
        });
        list_staff_del.forEach((item) {
          mapStaffDel.add({"STAFF_ID": item.STAFF_ID});
        });
        for (int i = 0; i < mapStaffDel.length; i++) {
          await NoticeFuture().apiRequestNoticeStaffupdDelete(mapStaffDel[i]).then((onValue) async {
            print("Del Staff : " + onValue.IsSuccess.toString());
          });
        }
        //====================Add Staff===============
        list_staff_add.forEach((item) {
          mapStaffAdd.add({
            "AGE": "",
            "CONTRIBUTOR_ID": item.CONTRIBUTOR_ID,
            "FIRST_NAME": item.FIRST_NAME,
            "ID_CARD": item.ID_CARD,
            "IS_ACTIVE": 1,
            "LAST_NAME": item.LAST_NAME,
            "NOTICE_ID": itemsNoticeMain.NOTICE_ID,
            "STAFF_CODE": item.STAFF_CODE != null ? item.STAFF_CODE : "",
            "STAFF_ID": "",
            "STAFF_REF_ID": item.STAFF_ID,
            "STAFF_TYPE": item.STAFF_TYPE,
            "STATUS": 1,
            "TITLE_ID": item.TITLE_ID,
            "TITLE_NAME_EN": "",
            "TITLE_NAME_TH": item.TITLE_NAME_TH,
            "TITLE_SHORT_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
            "OPERATION_DEPT_CODE": item.OPERATION_DEPT_CODE != null ? item.OPERATION_DEPT_CODE : "",
            "OPERATION_DEPT_LEVEL": item.OPERATION_DEPT_LEVEL != null ? item.OPERATION_DEPT_LEVEL : "",
            "OPERATION_DEPT_NAME": item.OPERATION_DEPT_NAME != null ? item.OPERATION_DEPT_NAME : "",
            "OPERATION_OFFICE_CODE": item.OPERATION_OFFICE_CODE != null ? item.OPERATION_OFFICE_CODE : "",
            "OPERATION_OFFICE_NAME": item.OPERATION_OFFICE_NAME != null ? item.OPERATION_OFFICE_NAME : "",
            "OPERATION_OFFICE_SHORT_NAME": item.OPERATION_OFFICE_SHORT_NAME != null ? item.OPERATION_OFFICE_SHORT_NAME : "",
            "OPERATION_POS_CODE": item.OPERATION_POS_CODE != null ? item.OPERATION_POS_CODE : "",
            "OPERATION_POS_LEVEL_NAME": item.OPREATION_POS_LAVEL_NAME != null ? item.OPREATION_POS_LAVEL_NAME : "",
            "OPERATION_UNDER_DEPT_CODE": item.OPERATION_UNDER_DEPT_CODE != null ? item.OPERATION_UNDER_DEPT_CODE : "",
            "OPERATION_UNDER_DEPT_LEVEL": item.OPERATION_UNDER_DEPT_LEVEL != null ? item.OPERATION_UNDER_DEPT_LEVEL : "",
            "OPERATION_UNDER_DEPT_NAME": item.OPERATION_UNDER_DEPT_NAME != null ? item.OPERATION_UNDER_DEPT_NAME : "",
            "OPERATION_WORK_DEPT_CODE": item.OPERATION_WORK_DEPT_CODE != null ? item.OPERATION_WORK_DEPT_CODE : "",
            "OPERATION_WORK_DEPT_LEVEL": item.OPERATION_WORK_DEPT_LEVEL != null ? item.OPERATION_WORK_DEPT_LEVEL : "",
            "OPERATION_WORK_DEPT_NAME": item.OPERATION_WORK_DEPT_NAME != null ? item.OPERATION_WORK_DEPT_NAME : "",
            "OPREATION_POS_LEVEL": item.OPREATION_POS_LEVEL != null ? item.OPREATION_POS_LEVEL : "",
            "OPREATION_POS_NAME": item.OPREATION_POS_NAME != null ? item.OPREATION_POS_NAME : "",
            "REMARK": "",
            "REPRESENT_DEPT_CODE": "",
            "REPRESENT_DEPT_LEVEL": "",
            "REPRESENT_DEPT_NAME": "",
            "REPRESENT_OFFICE_CODE": "",
            "REPRESENT_OFFICE_NAME": "",
            "REPRESENT_OFFICE_SHORT_NAME": "",
            "REPRESENT_POS_CODE": "",
            "REPRESENT_POS_LEVEL": "",
            "REPRESENT_POS_LEVEL_NAME": "",
            "REPRESENT_POS_NAME": "",
            "REPRESENT_UNDER_DEPT_CODE": "",
            "REPRESENT_UNDER_DEPT_LEVEL": "",
            "REPRESENT_UNDER_DEPT_NAME": "",
            "REPRESENT_WORK_DEPT_CODE": "",
            "REPRESENT_WORK_DEPT_LEVEL": "",
            "REPRESENT_WORK_DEPT_NAME": "",
            "MANAGEMENT_DEPT_CODE": "",
            "MANAGEMENT_DEPT_LEVEL": "",
            "MANAGEMENT_DEPT_NAME": "",
            "MANAGEMENT_OFFICE_CODE": "",
            "MANAGEMENT_OFFICE_NAME": "",
            "MANAGEMENT_OFFICE_SHORT_NAME": "",
            "MANAGEMENT_POS_CODE": "",
            "MANAGEMENT_POS_LEVEL": "",
            "MANAGEMENT_POS_LEVEL_NAME": "",
            "MANAGEMENT_POS_NAME": "",
            "MANAGEMENT_UNDER_DEPT_CODE": "",
            "MANAGEMENT_UNDER_DEPT_LEVEL": "",
            "MANAGEMENT_UNDER_DEPT_NAME": "",
            "MANAGEMENT_WORK_DEPT_CODE": "",
            "MANAGEMENT_WORK_DEPT_LEVEL": "",
            "MANAGEMENT_WORK_DEPT_NAME": "",
          });
        });
        for (int i = 0; i < mapStaffAdd.length; i++) {
          await NoticeFuture().apiRequestNoticeStaffinsAll(mapStaffAdd[i]).then((onValue) async {
            print("Add Staff : " + onValue.IsSuccess.toString());
          });
        }
        //====================Update Staff============
        list_staff_upd.forEach((item) {
          print(item.FIRST_NAME);
          mapStaffUpd.add({
            "AGE": "",
            "CONTRIBUTOR_ID": item.CONTRIBUTOR_ID,
            "FIRST_NAME": item.FIRST_NAME,
            "ID_CARD": item.ID_CARD,
            "IS_ACTIVE": 1,
            "LAST_NAME": item.LAST_NAME,
            "NOTICE_ID": itemsNoticeMain.NOTICE_ID,
            "STAFF_CODE": item.STAFF_CODE != null ? item.STAFF_CODE : "",
            "STAFF_ID": item.STAFF_ID,
            "STAFF_REF_ID": item.STAFF_REF_ID,
            "STAFF_TYPE": item.STAFF_TYPE,
            "STATUS": 1,
            "TITLE_ID": item.TITLE_ID,
            "TITLE_NAME_EN": "",
            "TITLE_NAME_TH": item.TITLE_NAME_TH,
            "TITLE_SHORT_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
            "OPERATION_DEPT_CODE": item.OPERATION_DEPT_CODE != null ? item.OPERATION_DEPT_CODE : "",
            "OPERATION_DEPT_LEVEL": item.OPERATION_DEPT_LEVEL != null ? item.OPERATION_DEPT_LEVEL : "",
            "OPERATION_DEPT_NAME": item.OPERATION_DEPT_NAME != null ? item.OPERATION_DEPT_NAME : "",
            "OPERATION_OFFICE_CODE": item.OPERATION_OFFICE_CODE != null ? item.OPERATION_OFFICE_CODE : "",
            "OPERATION_OFFICE_NAME": item.OPERATION_OFFICE_NAME != null ? item.OPERATION_OFFICE_NAME : "",
            "OPERATION_OFFICE_SHORT_NAME": item.OPERATION_OFFICE_SHORT_NAME != null ? item.OPERATION_OFFICE_SHORT_NAME : "",
            "OPERATION_POS_CODE": item.OPERATION_POS_CODE != null ? item.OPERATION_POS_CODE : "",
            "OPERATION_POS_LEVEL_NAME": item.OPREATION_POS_LAVEL_NAME != null ? item.OPREATION_POS_LAVEL_NAME : "",
            "OPERATION_UNDER_DEPT_CODE": item.OPERATION_UNDER_DEPT_CODE != null ? item.OPERATION_UNDER_DEPT_CODE : "",
            "OPERATION_UNDER_DEPT_LEVEL": item.OPERATION_UNDER_DEPT_LEVEL != null ? item.OPERATION_UNDER_DEPT_LEVEL : "",
            "OPERATION_UNDER_DEPT_NAME": item.OPERATION_UNDER_DEPT_NAME != null ? item.OPERATION_UNDER_DEPT_NAME : "",
            "OPERATION_WORK_DEPT_CODE": item.OPERATION_WORK_DEPT_CODE != null ? item.OPERATION_WORK_DEPT_CODE : "",
            "OPERATION_WORK_DEPT_LEVEL": item.OPERATION_WORK_DEPT_LEVEL != null ? item.OPERATION_WORK_DEPT_LEVEL : "",
            "OPERATION_WORK_DEPT_NAME": item.OPERATION_WORK_DEPT_NAME != null ? item.OPERATION_WORK_DEPT_NAME : "",
            "OPREATION_POS_LEVEL": item.OPREATION_POS_LEVEL != null ? item.OPREATION_POS_LEVEL : "",
            "OPREATION_POS_NAME": item.OPREATION_POS_NAME != null ? item.OPREATION_POS_NAME : "",
            "REMARK": "",
            "REPRESENT_DEPT_CODE": "",
            "REPRESENT_DEPT_LEVEL": "",
            "REPRESENT_DEPT_NAME": "",
            "REPRESENT_OFFICE_CODE": "",
            "REPRESENT_OFFICE_NAME": "",
            "REPRESENT_OFFICE_SHORT_NAME": "",
            "REPRESENT_POS_CODE": "",
            "REPRESENT_POS_LEVEL": "",
            "REPRESENT_POS_LEVEL_NAME": "",
            "REPRESENT_POS_NAME": "",
            "REPRESENT_UNDER_DEPT_CODE": "",
            "REPRESENT_UNDER_DEPT_LEVEL": "",
            "REPRESENT_UNDER_DEPT_NAME": "",
            "REPRESENT_WORK_DEPT_CODE": "",
            "REPRESENT_WORK_DEPT_LEVEL": "",
            "REPRESENT_WORK_DEPT_NAME": "",
            "MANAGEMENT_DEPT_CODE": "",
            "MANAGEMENT_DEPT_LEVEL": "",
            "MANAGEMENT_DEPT_NAME": "",
            "MANAGEMENT_OFFICE_CODE": "",
            "MANAGEMENT_OFFICE_NAME": "",
            "MANAGEMENT_OFFICE_SHORT_NAME": "",
            "MANAGEMENT_POS_CODE": "",
            "MANAGEMENT_POS_LEVEL": "",
            "MANAGEMENT_POS_LEVEL_NAME": "",
            "MANAGEMENT_POS_NAME": "",
            "MANAGEMENT_UNDER_DEPT_CODE": "",
            "MANAGEMENT_UNDER_DEPT_LEVEL": "",
            "MANAGEMENT_UNDER_DEPT_NAME": "",
            "MANAGEMENT_WORK_DEPT_CODE": "",
            "MANAGEMENT_WORK_DEPT_LEVEL": "",
            "MANAGEMENT_WORK_DEPT_NAME": "",
          });
        });
        for (int i = 0; i < mapStaffUpd.length; i++) {
          await NoticeFuture().apiRequestNoticeStaffupdByCon(mapStaffUpd[i]).then((onValue) async {
            print("Update Staff : " + onValue.IsSuccess.toString());
          });
        }

        Map MAP_ARREST_ID = {'NOTICE_ID': itemsNoticeMain.NOTICE_ID};
        await NoticeFuture().apiRequestNoticegetByCon(MAP_ARREST_ID).then((onValue) {
          itemsNoticeMain = onValue;
        });

        //Get Locale Informe
        if (itemsNoticeMain.NoticeInformer.length > 0) {
          if (itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID != 0) {
            await onLoadActionLoadDataLocaleInforme(itemsNoticeMain.NoticeInformer.first.SUB_DISTRICT_ID);
          } else {
            // _onSelectCountry(1, false, null, null, null);
          }
        }
        widget.IsCreate = false;
        _onSaved = true;
        _onFinish = true;
        itemsFormsTab3 = [];
        if (itemsNoticeMain.IS_AUTHORITY == 1) {
          itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์ม(รว.1)", "ILG60_00_02_001"));
        } else {
          itemsFormsTab3.add(new ItemsLawsuitForms("เเบบฟอร์ม(รว.2)", "ILG60_00_02_002"));
        }
        int index = 3;
        choices.add(Choice(title: 'แบบฟอร์ม'));
        tabController = TabController(length: choices.length, vsync: this, initialIndex: index);
        _tabPageSelector = new TabPageSelector(controller: tabController);
        tabController.animateTo((choices.length - 1));

        list_suspect_del = [];
        list_suspect_add = [];
        list_product_add = [];
        list_product_del = [];
        list_product_upd = [];
        list_staff_add = [];
        list_staff_del = [];
        list_staff_upd = [];
      } else {
        InsertNotSuccess = true;
      }
    });
    if (mounted) {
      setState(() {});
    }
    return true;
  }

  /*****************************method for main tab1**************************/
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final btnCancle = new FlatButton(
      onPressed: () {
        _onSaved ? Navigator.pop(context, "Back") : _showCancelAlertDialog(context);
      },
      padding: EdgeInsets.all(10.0),
      child: new Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
    );
    final List<Widget> btnSave = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          !_onSaved
              ? new FlatButton(
                  onPressed: () {
                    onSaved(context);
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
                              child: Text(
                                contants.text,
                                style: TextStyle(fontFamily: FontStyles().FontFamily),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList();
                  },
                )
        ],
      )
    ];
    return WillPopScope(
        onWillPop: () {
          if (mounted) {
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
          }
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
                      'ใบแจ้งความนำจับ',
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
                        isScrollable: true,
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
                              // _buildContent_tab_2(),
                              _buildContent_tab_3(),
                              _buildContent_tab_2(),
                              // _buildContent_tab_4(),
                              _buildContent_tab_5(),
                              _buildContent_tab_6(),
                            ]
                          : <Widget>[
                              _buildContent_tab_1(),
                              // _buildContent_tab_2(),
                              _buildContent_tab_3(),
                              _buildContent_tab_2(),
                              // _buildContent_tab_4(),
                              _buildContent_tab_5(),
                            ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildLine(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return _buildLine;
  }

  //************************start_tab_1*****************************

  // Get Location
  _navigateMap(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest1MapCustom(
                itemsLocale: _itemsLocale,
                IsPageArrest: false,
              )),
    );
    if (result.toString() != "Back") {
      if (_onEdited) {
        list_update_location = result;
        String address = list_update_location.Other +
            " " +
            list_update_location.ADDRESS_NO +
            (list_update_location.LANE.isEmpty ? "" : " ซอย " + list_update_location.LANE) +
            (list_update_location.ROAD.isEmpty ? "" : " ถนน " + list_update_location.ROAD) +
            " ตำบล/แขวง " +
            list_update_location.SUB_DISTICT.SUB_DISTRICT_NAME_TH +
            " อำเภอ/เขต " +
            list_update_location.DISTICT.DISTRICT_NAME_TH +
            " จังหวัด " +
            list_update_location.PROVINCE.PROVINCE_NAME_TH;

        editNoticeLocation.text = address.trim();
        noticesLocation = list_update_location.Other;
        if (list_update_location.IsPlace) {
          editNoticePlace.text = address.trim();
        }

        if (mounted) {
          setState(() {
            _itemsLocale = list_update_location;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _itemsLocale = result;
          });
          String address = _itemsLocale.Other +
              " " +
              _itemsLocale.ADDRESS_NO +
              (_itemsLocale.LANE.isEmpty ? "" : " ซอย " + _itemsLocale.LANE) +
              (_itemsLocale.ROAD.isEmpty ? "" : " ถนน " + _itemsLocale.ROAD) +
              " ตำบล/แขวง " +
              _itemsLocale.SUB_DISTICT.SUB_DISTRICT_NAME_TH +
              " อำเภอ/เขต " +
              _itemsLocale.DISTICT.DISTRICT_NAME_TH +
              " จังหวัด " +
              _itemsLocale.PROVINCE.PROVINCE_NAME_TH;
          editNoticeLocation.text = address.trim();
          noticesLocation = _itemsLocale.Other;
          if (_itemsLocale.IsPlace) {
            editNoticePlace.text = address.trim();
          }
        }
      }
    }
  }

  Widget _buildContent_tab_1() {
    Widget _buildContent(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0, bottom: 44.0),
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
                    "เลขที่ใบแจ้งความ",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: TextField(
                    enabled: false,
                    focusNode: myFocusNodeNoticeNo,
                    controller: editNoticeNo,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: textStyleData,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "อำนาจรับแจ้งความ",
                        style: textStyleLabel,
                      ),
                      Text(
                        _onEdited ? "" : "*",
                        style: textStyleStar,
                      ),
                    ],
                  ),
                ),
                _onEdited
                    ? Padding(
                        padding: paddingData,
                        child: Text(
                          itemsNoticeMain.IS_AUTHORITY == 1 ? "มีอำนาจ" : "ไม่มีอำนาจ",
                          style: textStyleData,
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 12),
                              //width: size.width / 2.4,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      if (mounted) {
                                        setState(() {
                                          NoticeType1 = true;
                                          NoticeType2 = false;
                                        });
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: NoticeType1 ? Color(0xff3b69f3) : Colors.white,
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: NoticeType1
                                              ? Icon(
                                                  Icons.check,
                                                  size: 25.0,
                                                  color: Colors.white,
                                                )
                                              : Container(
                                                  height: 25.0,
                                                  width: 25.0,
                                                  color: Colors.transparent,
                                                )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Text(
                                      'มีอำนาจ',
                                      style: textStyleData,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                //width: size.width / 2.4,
                                child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    if (mounted) {
                                      setState(() {
                                        NoticeType2 = true;
                                        NoticeType1 = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: NoticeType2 ? Color(0xff3b69f3) : Colors.white,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: NoticeType2
                                            ? Icon(
                                                Icons.check,
                                                size: 25.0,
                                                color: Colors.white,
                                              )
                                            : Container(
                                                height: 25.0,
                                                width: 25.0,
                                                color: Colors.transparent,
                                              )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    'ไม่มีอำนาจ',
                                    style: textStyleData,
                                  ),
                                )
                              ],
                            ))
                          ],
                        ),
                      ),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "วันที่รับแจ้งความ",
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
                              maximumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) + 1,
                              minimumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) - 1,
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: _dtNoticeDate,
                              onDateTimeChanged: (DateTime s) {
                                if (mounted) {
                                  setState(() {
                                    _dtNoticeDate = s;
                                    _tempDueDate = new DateTime(s.year, s.month, s.day, 23, 59, 59);

                                    _currentNoticeDate = _convertDate(s.toString());
                                    editNoticeDate.text = _currentNoticeDate;

                                    List splitsArrestDate = _dtNoticeDate.toUtc().toLocal().toString().split(" ");
                                    List splitsArrestTime = _dtNoticeTime.toString().split(" ");

                                    _noticeDate = splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString();
                                  });
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                    focusNode: myFocusNodeNoticeDate,
                    controller: editNoticeDate,
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
                _buildLine(context),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "เวลารับแจ้งความ",
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
                              initialDateTime: _dtNoticeTime,
                              onDateTimeChanged: (DateTime newDateTime) {
                                if (mounted) {
                                  setState(() {
                                    _dtNoticeTime = newDateTime;
                                    editNoticeTime.text = _convertTime(_dtNoticeTime.toString());

                                    List splitsArrestDate = _dtNoticeDate.toUtc().toLocal().toString().split(" ");
                                    List splitsArrestTime = _dtNoticeTime.toString().split(" ");
                                    _noticeDate = splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString();
                                  });
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                    focusNode: myFocusNodeNoticeTime,
                    controller: editNoticeTime,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: textStyleData,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine(context),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "ใช้ได้ภายในกำหนด(วัน)",
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
                    focusNode: myFocusNodeNoticeDateEnd,
                    controller: editNoticeDateEnd,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                    style: textStyleData,
                    onChanged: (text) {
                      if (text[0] == "0") {
                        editNoticeDateEnd.text = "";
                      }
                    },
                    onSubmitted: (text) {
                      if (text == "") {
                        editNoticeDateEnd.text = "1";
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine(context),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "สถานที่เกิดเหตุ",
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
                      _navigateMap(context);
                    },
                    focusNode: myFocusNodeNoticeLocation,
                    controller: editNoticeLocation,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    textCapitalization: TextCapitalization.words,
                    style: textStyleData,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Color(0xff087de1),
                      ),
                    ),
                  ),
                ),
                _buildLine(context),
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
                Padding(
                  padding: paddingData,
                  child: TextField(
                    focusNode: myFocusNodeNoticePlace,
                    controller: editNoticePlace, // มี ปห ตรงนี้
                    keyboardType: TextInputType.multiline,
                    // maxLines: 3,
                    textCapitalization: TextCapitalization.words,
                    style: textStyleData,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine(context),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0, bottom: 44.0),
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
                    "เลขที่ใบแจ้งความ",
                    style: textStyleLabel,
                  ),
                ),
                Container(
                  padding: paddingData,
                  child: Text(
                    itemsNoticeMain.NOTICE_CODE.toString(),
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "อำนาจรับแจ้งความ",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    itemsNoticeMain.IS_AUTHORITY == 1 ? "มีอำนาจ" : "ไม่มีอำนาจ",
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "วันที่รับแจ้งความ",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    _convertDate(itemsNoticeMain.NOTICE_DATE) + " " + _convertTime(itemsNoticeMain.NOTICE_DATE),
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ใช้ได้ภายในกำหนด(วัน)",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    itemsNoticeMain.NOTICE_DUE.toString(),
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "สถานที่เกิดเหตุ",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    itemsNoticeMain.NoticeLocale.length > 0 ? (itemsNoticeMain.NoticeLocale.first.LOCATION != null ? editNoticeLocation.text : "").toString() : "",
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
                    itemsNoticeMain.OFFICE_NAME,
                    style: textStyleData,
                  ),
                ),
              ],
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
              // decoration: BoxDecoration(
              //     border: Border(
              //   bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              // )),
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
  Widget _buildContent_tab_2() {
    var size = MediaQuery.of(context).size;

    /*String Province="",
        District="",
        SubDistrict="";
    void getLocale(int SUB_DISTRICT_ID)async{
      await onLoadActionLoadDataLocaleInforme(SUB_DISTRICT_ID);
      setState(() {
        Province = sProvince.PROVINCE_NAME_TH;
        District = sDistrict.DISTRICT_NAME_TH;
        SubDistrict = sSubDistrict.SUB_DISTRICT_NAME_TH;
      });
    }*/

    Widget _buildContent(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0, bottom: 44.0),
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
                  child: Row(
                    children: <Widget>[
                      Text(
                        "ชื่อผู้แจ้ง",
                        style: textStyleLabel,
                      ),
                      Text(
                        "*",
                        style: textStyleStar,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          Private = !Private;
                          TextPrivate = !TextPrivate;
                          InformerStatus = !InformerStatus;
                          if (_onEdited == true) {
                            if (Private == true) {
                              editNoticePersonName.text = "สายลับขอปิดนาม";
                            } else {
                              if (temp_editNoticePersonName == "สายลับขอปิดนาม") {
                                editNoticePersonName.text = "";
                              } else {
                                editNoticePersonName.text = temp_editNoticePersonName;
                              }
                            }
                          } else {
                            if (Private == true) {
                              editNoticePersonName.text = "สายลับขอปิดนาม";
                            } else {
                              editNoticePersonName.text = "";
                            }
                          }

                          // if (Private == true) {
                          //   if (_onEdited == true) {
                          //     if (editNoticePersonName.text == "สายลับขอปิดนาม") {
                          //       editNoticePersonName.text = "สายลับขอปิดนาม";
                          //     } else {
                          //       editNoticePersonName.text = temp_editNoticePersonName;
                          //     }
                          //   } else {
                          //     editNoticePersonName.text = "สายลับขอปิดนาม";
                          //   }
                          // } else {
                          //   editNoticePersonName.text = "";
                          // }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Private ? Color(0xff3b69f3) : Colors.white,
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Private
                                ? Icon(
                                    Icons.check,
                                    size: 20.0,
                                    color: Colors.white,
                                  )
                                : Container(
                                    height: 20.0,
                                    width: 20.0,
                                    color: Colors.transparent,
                                  )),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0),
                        child: Text(
                          'ไม่เปิดเผยตัว',
                          style: textStyleData,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        // padding: paddingData,
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          // color: Color.fromRGBO(240, 240, 242, 1.0),
                          padding: EdgeInsets.only(top: 0),
                          child: TextField(
                            enabled: TextPrivate,
                            focusNode: myFocusNodeNoticePersonName,
                            controller: editNoticePersonName,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: textStyleData,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'กรุณาระบุข้อมูล "ชื่อผู้แจ้ง"',
                            ),
                          ),
                        ),
                        Private ? Container() : _buildLine(context),
                      ],
                    )),
                  ],
                ),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "จังหวัด",
                        style: textStyleLabel,
                      )
                    ],
                  ),
                ),
                Container(width: size.width, child: _textListProvince),
                _buildLine(context),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "อำเภอ/เขต",
                        style: textStyleLabel,
                      )
                    ],
                  ),
                ),
                Container(width: size.width, child: _textListDistrict),
                _buildLine(context),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "ตำบล/แขวง",
                        style: textStyleLabel,
                      )
                    ],
                  ),
                ),
                Container(width: size.width, child: _textListSubDistrict),
                _buildLine(context),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "รายละเอียดแจ้งความ",
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
                    focusNode: myFocusNodeNoticeDetail,
                    controller: editNoticeDetail,
                    maxLines: 10,
                    textCapitalization: TextCapitalization.words,
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
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String PersonName = "", Detail = "";
      itemsNoticeMain.NoticeInformer.forEach((item) {
        PersonName = item.FIRST_NAME;
        Detail = item.INFORMER_INFO;
      });

      return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0, bottom: 44.0),
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
                    "ชื่อผู้แจ้ง",
                    style: textStyleLabel,
                  ),
                ),
                Container(
                  padding: paddingData,
                  child: Text(
                    PersonName,
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "จังหวัด",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    sProvince != null ? sProvince.PROVINCE_NAME_TH.toString() : "",
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "อำเภอ/เขต",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    sDistrict != null ? sDistrict.DISTRICT_NAME_TH.toString() : "",
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ตำบล/แขวง",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    sSubDistrict != null ? sSubDistrict.SUB_DISTRICT_NAME_TH.toString() : "",
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "รายละเอียดแจ้งความ",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    Detail.toString(),
                    style: textStyleData,
                  ),
                ),
              ],
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
              // decoration: BoxDecoration(
              //     border: Border(
              //   bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              // )),
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

  //************************end_tab_2*******************************

  //************************start_tab_3*****************************
  Widget _buildContent_tab_3() {
    var size = MediaQuery.of(context).size;

    Widget _buildContent(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0, bottom: 44.0),
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
                NoticeType2
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "ผู้รับเเจ้งความ",
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  //padding: paddingData,
                                  child: TextField(
                                    enableInteractiveSelection: false,
                                    onTap: () {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      _navigateSearchStaff(context, 7);
                                    },
                                    focusNode: myFocusNodeNoticePerson1,
                                    controller: editNoticePerson1,
                                    keyboardType: TextInputType.text,
                                    textCapitalization: TextCapitalization.words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                _buildLine(context),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),
                NoticeType1
                    ? Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "ผู้มีอำนาจรับแจ้งความ",
                              style: textStyleLabel,
                            ),
                            Text(
                              "*",
                              style: textStyleStar,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: paddingLabel,
                        child: Text(
                          "ผู้มีอำนาจรับแจ้งความ",
                          style: textStyleLabel,
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
                            _navigateSearchStaff(context, 8);
                          },
                          focusNode: myFocusNodeNoticePerson2,
                          controller: editNoticePerson2,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      _buildLine(context),
                    ],
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ผู้รับรอง",
                    style: textStyleLabel,
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
                            _navigateSearchStaff(context, 9);
                          },
                          focusNode: myFocusNodeNoticePerson3,
                          controller: editNoticePerson3,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      _buildLine(context),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0, bottom: 44.0),
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
                itemsNoticeMain.IS_AUTHORITY == 0
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ผู้รับเเจ้งความ",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            padding: paddingData,
                            child: Text(
                              get_staff_name(itemsNoticeMain.NoticeStaff, 7) != null ? get_staff_name(itemsNoticeMain.NoticeStaff, 7) : "",
                              style: textStyleData,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ผู้มีอำนาจรับเเจ้งความ",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    get_staff_name(itemsNoticeMain.NoticeStaff, 8) != null ? get_staff_name(itemsNoticeMain.NoticeStaff, 8) : "",
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ผู้รับรอง",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    get_staff_name(itemsNoticeMain.NoticeStaff, 9) != null ? get_staff_name(itemsNoticeMain.NoticeStaff, 9) : "",
                    style: textStyleData,
                  ),
                ),
              ],
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
              // decoration: BoxDecoration(
              //     border: Border(
              //   bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              // )),
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

  //************************end_tab_3*******************************

  //************************start_tab_5*****************************
  _navigateScreenEditTab5(BuildContext context, var itemsProduct, int index, var groubitemproduct) async {
    List _tempItemProductTab5 = [];
    ItemsListNotice itemsListNotice;
    if (_onEdited) {
      print('ปุ่มแก้ไข กรณีกดแก้ไขข้อมูลที่เคยอัพขึ้น server แล้ว : ${_onEdited.toString()}');
      print('ทดสอบ NOTICE_ID: ${itemsNoticeMain.NoticeProduct[index].NOTICE_ID}');

      ItemsListNotice _itemsListNotice = new ItemsListNotice(
          PRODUCT_MAPPING_ID: null,
          PRODUCT_CODE: null,
          PRODUCT_REF_CODE: null,
          NOTICE_ID: itemsNoticeMain.NoticeProduct[index].NOTICE_ID,
          PRODUCT_ID: itemsNoticeMain.NoticeProduct[index].PRODUCT_ID,
          PRODUCT_GROUP_ID: itemsNoticeMain.NoticeProduct[index].PRODUCT_GROUP_ID,
          PRODUCT_GROUP_CODE: itemsNoticeMain.NoticeProduct[index].PRODUCT_GROUP_CODE,
          PRODUCT_CATEGORY_ID: null,
          PRODUCT_TYPE_ID: null,
          PRODUCT_SUBTYPE_ID: null,
          PRODUCT_SUBSETTYPE_ID: null,
          PRODUCT_BRAND_ID: null,
          PRODUCT_SUBBRAND_ID: null,
          PRODUCT_MODEL_ID: null,
          PRODUCT_TAXDETAIL_ID: null,
          UNIT_ID: null,
          PRODUCT_CATEGORY_NAME: null,
          PRODUCT_GROUP_NAME: itemsNoticeMain.NoticeProduct[index].PRODUCT_GROUP_NAME,
          PRODUCT_TYPE_NAME: null,
          PRODUCT_SUBTYPE_NAME: null,
          PRODUCT_SUBSETTYPE_NAME: null,
          PRODUCT_BRAND_NAME_TH: null,
          PRODUCT_BRAND_NAME_EN: null,
          PRODUCT_SUBBRAND_CODE: null,
          PRODUCT_SUBBRAND_NAME_TH: null,
          PRODUCT_SUBBRAND_NAME_EN: null,
          PRODUCT_MODEL_NAME_TH: null,
          PRODUCT_MODEL_NAME_EN: null,
          SIZES_UNIT_ID: null,
          QUATITY_UNIT_ID: null,
          VOLUMN_UNIT_ID: null,
          SIZES: null,
          QUANTITY: null,
          VOLUMN: null,
          SIZES_UNIT: null,
          QUANTITY_UNIT: null,
          VOLUMN_UNIT: null,
          FINE_ESTIMATE: null,
          TAX_VALUE: null,
          TAX_VOLUMN: null,
          TAX_VOLUMN_UNIT: null,
          DEGREE: null,
          SUGAR: null,
          CO2: null,
          PRICE: null,
          PRODUCT_DESC: itemsNoticeMain.NoticeProduct[index].PRODUCT_DESC,
          REMARK: null,
          IS_DOMESTIC: null,
          INDEX: null);
      itemsListNotice = _itemsListNotice;
    } else {
      print('ปุ่มแก้ไข กรณีไม่เคยอัพขึ้น server : ${_onEdited.toString()}');
      ItemsListNotice _itemsListNotice = new ItemsListNotice(
          PRODUCT_MAPPING_ID: null,
          PRODUCT_CODE: null,
          PRODUCT_REF_CODE: null,
          NOTICE_ID: _itemsDataTab5[index].NOTICE_ID,
          PRODUCT_ID: null,
          PRODUCT_GROUP_ID: _itemsDataTab5[index].PRODUCT_GROUP_ID,
          PRODUCT_GROUP_CODE: _itemsDataTab5[index].PRODUCT_GROUP_CODE,
          PRODUCT_CATEGORY_ID: null,
          PRODUCT_TYPE_ID: null,
          PRODUCT_SUBTYPE_ID: null,
          PRODUCT_SUBSETTYPE_ID: null,
          PRODUCT_BRAND_ID: null,
          PRODUCT_SUBBRAND_ID: null,
          PRODUCT_MODEL_ID: null,
          PRODUCT_TAXDETAIL_ID: null,
          UNIT_ID: null,
          PRODUCT_CATEGORY_NAME: null,
          PRODUCT_GROUP_NAME: _itemsDataTab5[index].PRODUCT_GROUP_NAME,
          PRODUCT_TYPE_NAME: null,
          PRODUCT_SUBTYPE_NAME: null,
          PRODUCT_SUBSETTYPE_NAME: null,
          PRODUCT_BRAND_NAME_TH: null,
          PRODUCT_BRAND_NAME_EN: null,
          PRODUCT_SUBBRAND_CODE: null,
          PRODUCT_SUBBRAND_NAME_TH: null,
          PRODUCT_SUBBRAND_NAME_EN: null,
          PRODUCT_MODEL_NAME_TH: null,
          PRODUCT_MODEL_NAME_EN: null,
          SIZES_UNIT_ID: null,
          QUATITY_UNIT_ID: null,
          VOLUMN_UNIT_ID: null,
          SIZES: null,
          QUANTITY: null,
          VOLUMN: null,
          SIZES_UNIT: null,
          QUANTITY_UNIT: null,
          VOLUMN_UNIT: null,
          FINE_ESTIMATE: null,
          TAX_VALUE: null,
          TAX_VOLUMN: null,
          TAX_VOLUMN_UNIT: null,
          DEGREE: null,
          SUGAR: null,
          CO2: null,
          PRICE: null,
          PRODUCT_DESC: _itemsDataTab5[index].PRODUCT_DESC,
          REMARK: null,
          IS_DOMESTIC: null,
          INDEX: null);
      itemsListNotice = _itemsListNotice;
    }

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
    // await onLoadActionProductGroupMaster();
    await onLoadActionMasProductGroupgetByCon();
    Navigator.pop(context);

    if (itemsProductGroup != null) {
      List items = [];
      items.add(itemsProduct);
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenNotice5Add(
                  itemProduct: _itemsData,
                  itemProductTab5: itemsListNotice,
                  temp_itemsDataTab5: groubitemproduct,
                  onEdit: true,
                )),
      );

      if (result.toString() != "back") {
        if (_onEdited) {
          print('แก้ไข กรณีส่งข้อมูลไปแล้ว ${result.toString()}');
          ItemsListNotice itm = result;
          itm.PRODUCT_GROUP_ID = itemsNoticeMain.NoticeProduct[index].PRODUCT_GROUP_ID;
          list_product_upd.add(itm);
          itemsNoticeMain.NoticeProduct[index] = itm;
        } else {
          print('แก้ไข กรณียังไม่ส่งข้อมูล ${result.toString()}');
          ItemsListNotice itm = result;
          _itemsDataTab5[index] = itm;
        }
      }
    }
  }

  Widget _buildContent_tab_5() {
    var size = MediaQuery.of(context).size;

    Widget _buildContent(BuildContext context) {
      return SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: _onEdited ? itemsNoticeMain.NoticeProduct.length : _itemsDataTab5.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            List itemProduct = [];
            if (_onEdited) {
              itemProduct = itemsNoticeMain.NoticeProduct;
            } else {
              itemProduct = _itemsDataTab5;
            }

            return Padding(
              padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
              child: Container(
                  transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                  padding: EdgeInsets.all(22.0),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              itemProduct[index].PRODUCT_GROUP_NAME,
                              // itemProduct[index]['PRODUCT_GROUP_NAME'],
                              style: textStyleLabel,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: paddingData,
                                  child: Text(
                                    itemProduct[index].PRODUCT_DESC == '' || itemProduct[index].PRODUCT_DESC == null ? '-' : itemProduct[index].PRODUCT_DESC.toString(),
                                    style: textStyleData,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.only(bottom: 12.0, top: 12.0, right: 24.0),
                                  child: InkWell(
                                    onTap: () {
                                      _navigateScreenEditTab5(context, itemProduct[index], index, itemProduct);
                                    },
                                    child: Container(
                                        child: Text(
                                      "แก้ไข",
                                      style: textLabelDeleteStyle,
                                    )),
                                  )),
                              Container(
                                  padding: EdgeInsets.only(bottom: 12.0, top: 12.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (mounted) {
                                        setState(() {
                                          _showDeleteItemsAlertDialog(index, "Product");
                                        });
                                      }
                                    },
                                    child: Container(
                                        child: Text(
                                      "ลบ",
                                      style: textLabelDeleteStyle,
                                    )),
                                  )),
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
            );
          },
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      return ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemCount: itemsNoticeMain.NoticeProduct.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
                padding: EdgeInsets.all(22.0),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            itemsNoticeMain.NoticeProduct[index].PRODUCT_GROUP_NAME.toString(),
                            style: textStyleLabel,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: paddingData,
                                child: Text(
                                  itemsNoticeMain.NoticeProduct[index].PRODUCT_DESC == '' || itemsNoticeMain.NoticeProduct[index].PRODUCT_DESC == null ? '-' : itemsNoticeMain.NoticeProduct[index].PRODUCT_DESC.toString(),
                                  // itemProduct[index]['PRODUCT_DESC'] == null ? '-' : itemProduct[index]['PRODUCT_DESC'].toString() + (itemProduct[index]['REMARK'] != null ? (itemProduct[index]['REMARK'].toString().isNotEmpty ? " (" + itemProduct[index]['REMARK'].toString() + ")" : "") : ""),
                                  // 'test',
                                  style: textStyleData,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )),
          );
        },
      );
    }

    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  // decoration: BoxDecoration(
                  //     border: Border(
                  //   top: BorderSide(color: Colors.grey[300], width: 1.0),
                  // )),
                  ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _onSaved ? _buildContent_saved(context) : _buildContent(context),
                ),
              ),
            ],
          ),
        ),
        !_onSaved
            ? Align(
                alignment: Alignment.bottomRight,
                child: new Padding(
                  padding: EdgeInsets.all(18.0),
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff087de1),
                    onPressed: () {
                      _navigateScreenAddTab5(context);
                    },
                    mini: false,
                    child: new Icon(Icons.add),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  //************************end_tab_5*******************************

  Future<bool> onLoadActionPreviewForms(Map map) async {
    if (itemsNoticeMain.IS_AUTHORITY == 1) {
      await new TransectionFuture().apiRequestILG60_00_02_001(map).then((onValue) {
        print("res PDF 02_001 : " + onValue);
      });
    } else {
      await new TransectionFuture().apiRequestILG60_00_02_002(map).then((onValue) {
        print("res PDF 02_002 : " + onValue);
      });
    }

    if (mounted) {
      setState(() {});
    }
    return true;
  }

  _navigate_preview_form(BuildContext context, ItemsLawsuitForms item) async {
    Map map = {"NoticeCode": itemsNoticeMain.NOTICE_CODE};
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

//************************start_tab_6*****************************
  Widget _buildContent_tab_6() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            padding: EdgeInsets.only(top: 0),
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
                        itemsFormsTab3[index].FormsName,
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

  //================================= view =============================

  AutoCompleteTextField<ItemsListProvince> _textListProvince;
  AutoCompleteTextField _textListDistrict;
  AutoCompleteTextField _textListSubDistrict;

  void setAutoCompleteProvince() {
    GlobalKey key_province = new GlobalKey<AutoCompleteTextFieldState<ItemsListProvince>>();

    _textListProvince = new AutoCompleteTextField<ItemsListProvince>(
      style: textStyleData,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      itemSubmitted: (item) {
        setState(() {
          _textListProvince.textField.controller.text = item.PROVINCE_NAME_TH.toString();

          sProvince = item;

          editNoticeDistrict.text = "";
          editNoticeSubDistrict.text = "";
          sDistrict = null;
          sSubDistrict = null;

          _onSelectProvince(sProvince.PROVINCE_ID);
        });
        if (!mounted) return;
      },
      key: key_province,
      clearOnSubmit: false,
      controller: editNoticeProvince,
      suggestions: ItemProvince.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sProvince == null
          ? new Padding(
              child: new ListTile(
                title: new Text(
                  suggestion.PROVINCE_NAME_TH,
                  style: textStyleData,
                ),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PROVINCE_ID == b.PROVINCE_ID ? 0 : a.PROVINCE_ID > b.PROVINCE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProvince = null;
        return suggestion.PROVINCE_NAME_TH.toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteDistrict() {
    GlobalKey key_districe = new GlobalKey<AutoCompleteTextFieldState<ItemsListDistict>>();
    _textListDistrict = new AutoCompleteTextField<ItemsListDistict>(
      style: textStyleData,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editNoticeDistrict,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListDistrict.textField.controller.text = item.DISTRICT_NAME_TH.toString();

          sDistrict = item;
          ItemDistrict.RESPONSE_DATA.forEach((f) {
            if (f.DISTRICT_NAME_TH.endsWith(sDistrict.DISTRICT_NAME_TH)) {
              editNoticeSubDistrict.text = "";
              sSubDistrict = null;
              _onSelectDistrict(f.DISTRICT_ID);
            }
          });
        });
        if (!mounted) return;
      },
      key: key_districe,
      suggestions: ItemDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sDistrict == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.DISTRICT_NAME_TH, style: textStyleData),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.DISTRICT_ID == b.DISTRICT_ID ? 0 : a.DISTRICT_ID > b.DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sDistrict = null;
        return suggestion.DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteSubDistrict() {
    GlobalKey key_subDistrict = new GlobalKey<AutoCompleteTextFieldState<ItemsListSubDistict>>();
    _textListSubDistrict = new AutoCompleteTextField<ItemsListSubDistict>(
      style: textStyleData,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editNoticeSubDistrict,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListSubDistrict.textField.controller.text = item.SUB_DISTRICT_NAME_TH.toString();

          sSubDistrict = item;
        });
        if (!mounted) return;
      },
      key: key_subDistrict,
      suggestions: ItemSubDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sSubDistrict == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.SUB_DISTRICT_NAME_TH, style: textStyleData),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.SUB_DISTRICT_ID == b.SUB_DISTRICT_ID ? 0 : a.SUB_DISTRICT_ID > b.SUB_DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sSubDistrict = null;
        return suggestion.SUB_DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
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

  String get_staff_name(var Items, int CONTRIBUTOR_ID) {
    String name;
    Items.forEach((item) {
      if (item.CONTRIBUTOR_ID == CONTRIBUTOR_ID) {
        name = item.TITLE_SHORT_NAME_TH + item.FIRST_NAME + " " + item.LAST_NAME;
      }
    });
    return name;
  }

  //========================== Building ==============================
  void _onSelectCountry(int COUNTRY_ID, bool IsInit, String ProvinceName, String DistrictName, String SubDistrictName) async {
    await onLoadActionProvinceMaster(COUNTRY_ID, IsInit, ProvinceName, DistrictName, SubDistrictName);
  }

  void _onSelectProvince(int PROVINCE_ID) async {
    await onLoadActionDistinctMaster(PROVINCE_ID, false, null, null);
  }

  void _onSelectDistrict(int DISTRICT_ID) async {
    await onLoadActionSubDistinctMaster(DISTRICT_ID, false, null);
  }

  //Notice Load map preview
  Future<bool> onLoadActionLoadDataLocalePreview(int SUB_DISTRICT_ID, ItemsNoticeMain items) async {
    ItemsListSubDistict tempSubDistrict;
    ItemsListDistict tempDistrict;
    ItemsListProvince tempProvince;

    Map map = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": SUB_DISTRICT_ID, "DISTRICT_ID": ""};
    //Get SubDistrict
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      if (onValue.RESPONSE_DATA.length > 0) {
        tempSubDistrict = onValue.RESPONSE_DATA.first;
      }
    });

    //Get District
    map = {"TEXT_SEARCH": "", "DISTRICT_ID": tempSubDistrict.DISTRICT_ID, "PROVINCE_ID": ""};
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      if (onValue.RESPONSE_DATA.length > 0) {
        tempDistrict = onValue.RESPONSE_DATA.first;
      }
    });

    //Get Province
    map = {"TEXT_SEARCH": "", "COUNTRY_ID": "", "PROVINCE_ID": tempDistrict.PROVINCE_ID};
    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      if (onValue.RESPONSE_DATA.length > 0) {
        tempProvince = onValue.RESPONSE_DATA.first;
      }
    });

    String address = (items.NoticeLocale.first.LOCATION == null ? "" : items.NoticeLocale.first.LOCATION) +
        " " +
        (items.NoticeLocale.first.ADDRESS_NO != null ? items.NoticeLocale.first.ADDRESS_NO : "") +
        (items.NoticeLocale.first.LANE == null ? "" : "ซอย " + items.NoticeLocale.first.LANE) +
        (items.NoticeLocale.first.ROAD == null ? "" : " ถนน " + itemsNoticeMain.NoticeLocale.first.ROAD) +
        " ตำบล/แขวง " +
        tempSubDistrict.SUB_DISTRICT_NAME_TH +
        " อำเภอ/เขต " +
        tempDistrict.DISTRICT_NAME_TH +
        " จังหวัด " +
        tempProvince.PROVINCE_NAME_TH;
    print('address: ${items.NoticeLocale.first.ADDRESS_NO}');

    editNoticeLocation.text = address.trim();
    noticesLocation = items.NoticeLocale.first.LOCATION == null ? "" : items.NoticeLocale.first.LOCATION;

    if (mounted) {
      setState(() {});
    }
    return true;
  }

  //Notice Informe
  Future<bool> onLoadActionLoadDataLocaleInforme(int SUB_DISTRICT_ID) async {
    Map map = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": SUB_DISTRICT_ID, "DISTRICT_ID": ""};
    //Get SubDistrict
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      if (onValue.RESPONSE_DATA.length > 0) {
        sSubDistrict = onValue.RESPONSE_DATA.first;
      }
    });
    //Get District
    map = {"TEXT_SEARCH": "", "DISTRICT_ID": sSubDistrict.DISTRICT_ID, "PROVINCE_ID": ""};
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      if (onValue.RESPONSE_DATA.length > 0) {
        sDistrict = onValue.RESPONSE_DATA.first;
      }
    });
    //Get Province
    map = {"TEXT_SEARCH": "", "COUNTRY_ID": "", "PROVINCE_ID": sDistrict.PROVINCE_ID};
    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      if (onValue.RESPONSE_DATA.length > 0) {
        sProvince = onValue.RESPONSE_DATA.first;
      }
    });

    if (mounted) {
      setState(() {});
    }
    return true;
  }

  Future<bool> onLoadActionLoadDataAddressMaster(int PROVINCE_ID) async {
    Map map = {"TEXT_SEARCH": "", "DISTRICT_ID": "", "PROVINCE_ID": PROVINCE_ID};
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      ItemDistrict = onValue;
      ItemDistrict.RESPONSE_DATA.forEach((district) {
        if (mounted) {
          setState(() {
            sSubDistrict = null;
            sDistrict = district;
            this.onLoadActionSubDistinctMaster(sDistrict.DISTRICT_ID, false, null);
          });
        }
      });
      if (mounted) {
        setState(() {});
      }
    });
    Map map_dist = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": "", "DISTRICT_ID": sDistrict.DISTRICT_ID};
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map_dist).then((onValue) {
      ItemSubDistrict = onValue;
    });

    return true;
  }

  Future<bool> onLoadActionProvinceMaster(int COUNTRY_ID, bool IsInit, String ProvinceName, String DistrictName, String SubDistrictName) async {
    Map map = {
      "TEXT_SEARCH": "",
      "PROVINCE_ID": "",
      "COUNTRY_ID": COUNTRY_ID,
    };
    print("province : " + map.toString());

    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      ItemProvince = onValue;
      if (ItemProvince.SUCCESS && ItemProvince.RESPONSE_DATA.length > 0) {
        if (IsInit) {
          //tab-1
          ItemProvince.RESPONSE_DATA.forEach((province) {
            if (ProvinceName.trim().endsWith(province.PROVINCE_NAME_TH.trim())) {
              // sProvince = province;
              tab1Province = province;
              onLoadActionDistinctMaster(tab1Province.PROVINCE_ID, IsInit, DistrictName, SubDistrictName);
            }
          });
        } else {
          //tab-2
          setAutoCompleteProvince();
        }
      }
    });
    if (mounted) {
      setState(() {});
    }
    return true;
  }

  Future<bool> onLoadActionDistinctMaster(int PROVINCE_ID, bool IsInit, String DistrictName, String SubDistrictName) async {
    Map map = {"TEXT_SEARCH": "", "DISTRICT_ID": "", "PROVINCE_ID": PROVINCE_ID};
    print("district : " + map.toString());
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      ItemDistrict = onValue;
      if (ItemDistrict.SUCCESS && ItemDistrict.RESPONSE_DATA.length > 0) {
        if (IsInit) {
          //tab-1
          ItemDistrict.RESPONSE_DATA.forEach((district) {
            if (DistrictName.trim().endsWith(district.DISTRICT_NAME_TH.trim())) {
              if (mounted) {
                setState(() {
                  // sSubDistrict = null;
                  // sDistrict = district;
                  tab1SubDistrict = null;
                  tab1District = district;
                  this.onLoadActionSubDistinctMaster(tab1District.DISTRICT_ID, IsInit, SubDistrictName);
                });
              }
            }
          });
        } else {
          //tab-2
          setAutoCompleteDistrict();
        }
      }
    });
    if (mounted) {
      setState(() {});
    }
    return true;
  }

  // เอาไว้ Load map tab 1 ตอนกดแก้ไข
  Future<bool> onLoadActionDataLocalEdit(int SUB_DISTRICT_ID) async {
    Map map = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": SUB_DISTRICT_ID != null ? SUB_DISTRICT_ID : "", "DISTRICT_ID": ""};
    String Other = "";

    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      ItemSubDistrict = onValue;
      print('SUCCESS: ${ItemSubDistrict.SUCCESS}');

      if (ItemSubDistrict.SUCCESS && ItemSubDistrict.RESPONSE_DATA.length > 0) {
        onValue.RESPONSE_DATA.forEach((item) {
          if (item.SUB_DISTRICT_ID == SUB_DISTRICT_ID) {
            // sSubDistrict = item;
            tab1SubDistrict = item;
            print('tab1SubDistrict: ${tab1SubDistrict.PROVINCE_ID}');
          }
        });
      }
    });

    //District
    map = {"TEXT_SEARCH": "", "DISTRICT_ID": "", "PROVINCE_ID": tab1SubDistrict.PROVINCE_ID};
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      ItemDistrict = onValue;
      if (ItemDistrict.SUCCESS && ItemDistrict.RESPONSE_DATA.length > 0) {
        onValue.RESPONSE_DATA.forEach((item) {
          if (item.DISTRICT_ID == tab1SubDistrict.DISTRICT_ID) {
            // sDistrict = item;
            tab1District = item;
          }
        });
      }
    });

    //Province
    map = {
      "TEXT_SEARCH": "",
      "PROVINCE_ID": "",
      "COUNTRY_ID": 1,
    };
    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      ItemProvince = onValue;
      if (ItemProvince.SUCCESS && ItemProvince.RESPONSE_DATA.length > 0) {
        onValue.RESPONSE_DATA.forEach((item) {
          if (item.PROVINCE_ID == tab1SubDistrict.PROVINCE_ID) {
            // sProvince = item;
            tab1Province = item;
          }
        });
      }
    });

    _itemsLocale = new ItemsListArrestLocation(tab1Province, tab1District, tab1SubDistrict, itemsNoticeMain.NoticeLocale.first.ROAD != null ? itemsNoticeMain.NoticeLocale.first.ROAD : "", itemsNoticeMain.NoticeLocale.first.LANE != null ? itemsNoticeMain.NoticeLocale.first.LANE : "",
        itemsNoticeMain.NoticeLocale.first.ADDRESS_NO != null ? itemsNoticeMain.NoticeLocale.first.ADDRESS_NO : "", itemsNoticeMain.NoticeLocale.first.GPS != null ? itemsNoticeMain.NoticeLocale.first.GPS : "", placeAddress, false, itemsNoticeMain.NoticeLocale.first.LOCATION);
  }

  // เอาไว้ Load map tab 3
  Future<bool> onLoadActionSubDistinctMaster(int DISTRICT_ID, bool IsInit, String SubDistrictName) async {
    Map map = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": "", "DISTRICT_ID": DISTRICT_ID};
    print(map);
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      ItemSubDistrict = onValue;
      if (ItemSubDistrict.SUCCESS && ItemSubDistrict.RESPONSE_DATA.length > 0) {
        if (IsInit) {
          //tab-1
          ItemSubDistrict.RESPONSE_DATA.forEach((items) {
            if (SubDistrictName.trim().endsWith(items.SUB_DISTRICT_NAME_TH.trim())) {
              if (mounted) {
                setState(() {
                  tab1SubDistrict = items;
                  if (widget.IsPreview /*||widget.IsUpdate*/) {
                    //finish
                    _itemsLocale = new ItemsListArrestLocation(tab1Province, tab1District, tab1SubDistrict, itemsNoticeMain.NoticeLocale.first.ROAD != null ? itemsNoticeMain.NoticeLocale.first.ROAD : "", itemsNoticeMain.NoticeLocale.first.LANE != null ? itemsNoticeMain.NoticeLocale.first.LANE : "",
                        itemsNoticeMain.NoticeLocale.first.ADDRESS_NO != null ? itemsNoticeMain.NoticeLocale.first.ADDRESS_NO : "", itemsNoticeMain.NoticeLocale.first.GPS != null ? itemsNoticeMain.NoticeLocale.first.GPS : "", placeAddress, false, itemsNoticeMain.NoticeLocale.first.LOCATION);
                  } else {
                    //finish
                    _itemsLocale = new ItemsListArrestLocation(tab1Province, tab1District, tab1SubDistrict, _road, _lane, _addressno, _gps, placeAddress, false, "");
                  }

                  String address = (_itemsLocale.Other == null || _itemsLocale.Other == "" ? "" : _itemsLocale.Other) +
                      (_itemsLocale.ADDRESS_NO != null || _itemsLocale.ADDRESS_NO == "" ? _itemsLocale.ADDRESS_NO : "") +
                      (_itemsLocale.LANE == null || _itemsLocale.LANE == "" ? "" : " ซอย " + _itemsLocale.LANE) +
                      (_itemsLocale.ROAD == null || _itemsLocale.ROAD == "" ? "" : " ถนน " + _itemsLocale.ROAD) +
                      " ตำบล/แขวง " +
                      _itemsLocale.SUB_DISTICT.SUB_DISTRICT_NAME_TH +
                      " อำเภอ/เขต " +
                      _itemsLocale.DISTICT.DISTRICT_NAME_TH +
                      " จังหวัด " +
                      _itemsLocale.PROVINCE.PROVINCE_NAME_TH;
                  editNoticeLocation.text = address.trim();
                  // noticesLocation = list_update_location.Other;
                });
              }
            }
          });
        } else {
          //tab-2
          setAutoCompleteSubDistrict();
        }
      }
    });
    if (mounted) {
      setState(() {});
    }
    return true;
  }

  Future<bool> onLoadActionDataInforme(int SUB_DISTRICT_ID) async {
    //SubDistrict
    Map map = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": SUB_DISTRICT_ID != null ? SUB_DISTRICT_ID : "", "DISTRICT_ID": ""};
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      print("onValue: ${onValue.toString()}");
      ItemSubDistrict = onValue;
      if (ItemSubDistrict.SUCCESS && ItemSubDistrict.RESPONSE_DATA.length > 0) {
        onValue.RESPONSE_DATA.forEach((item) {
          if (item.SUB_DISTRICT_ID == SUB_DISTRICT_ID) {
            sSubDistrict = item;
          }
        });
      }
    });
    setAutoCompleteSubDistrict();
    editNoticeSubDistrict.text = sSubDistrict.SUB_DISTRICT_NAME_TH;

    //District
    map = {"TEXT_SEARCH": "", "DISTRICT_ID": "", "PROVINCE_ID": sSubDistrict.PROVINCE_ID};
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      ItemDistrict = onValue;
      if (ItemDistrict.SUCCESS && ItemDistrict.RESPONSE_DATA.length > 0) {
        onValue.RESPONSE_DATA.forEach((item) {
          if (item.DISTRICT_ID == sSubDistrict.DISTRICT_ID) {
            sDistrict = item;
          }
        });
      }
    });
    setAutoCompleteDistrict();
    editNoticeDistrict.text = sDistrict.DISTRICT_NAME_TH;

    //Province
    map = {
      "TEXT_SEARCH": "",
      "PROVINCE_ID": "",
      "COUNTRY_ID": 1,
    };
    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      ItemProvince = onValue;
      if (ItemProvince.SUCCESS && ItemProvince.RESPONSE_DATA.length > 0) {
        onValue.RESPONSE_DATA.forEach((item) {
          if (item.PROVINCE_ID == sSubDistrict.PROVINCE_ID) {
            sProvince = item;
          }
        });
      }
    });
    setAutoCompleteProvince();
    editNoticeProvince.text = sProvince.PROVINCE_NAME_TH;

    if (mounted) {
      setState(() {});
    }
    return true;
  }

  _navigateSearchStaff(BuildContext context, int CONTRIBUTOR_ID) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TabScreenSearchStaff(CONTRIBUTOR_ID: CONTRIBUTOR_ID)),
    );

    if (result.toString() != "back") {
      var Item = result;
      if (_onEdited) {
        if (_itemsNoticeStaff.length > 0) {
          if (_itemsNoticeStaff.where((food) => food.CONTRIBUTOR_ID == (Item.CONTRIBUTOR_ID)).toList().length > 0) {
            for (int i = 0; i < _itemsNoticeStaff.length; i++) {
              if (Item.CONTRIBUTOR_ID == _itemsNoticeStaff[i].CONTRIBUTOR_ID) {
                //update
                Item.STAFF_ID = _itemsNoticeStaff[i].STAFF_ID;
                list_staff_upd.add(Item);
                _itemsNoticeStaff[i] = Item;
              }
            }
          } else {
            //add
            list_staff_add.add(Item);
            _itemsNoticeStaff.add(Item);
          }
        } else {
          //add
          list_staff_add.add(Item);
          _itemsNoticeStaff.add(Item);
        }
      } else {
        if (_itemsNoticeStaff.length > 0) {
          if (_itemsNoticeStaff.where((food) => food.CONTRIBUTOR_ID == (Item.CONTRIBUTOR_ID)).toList().length > 0) {
            for (int i = 0; i < _itemsNoticeStaff.length; i++) {
              if (Item.CONTRIBUTOR_ID == _itemsNoticeStaff[i].CONTRIBUTOR_ID) {
                _itemsNoticeStaff[i] = Item;
              }
            }
          } else {
            _itemsNoticeStaff.add(Item);
          }
        } else {
          _itemsNoticeStaff.add(Item);
        }
      }

      editNoticePerson1.text = get_staff_name(_itemsNoticeStaff, 7);
      editNoticePerson2.text = get_staff_name(_itemsNoticeStaff, 8);
      editNoticePerson3.text = get_staff_name(_itemsNoticeStaff, 9);
    }
  }

  //Suspect
  ItemsMasterTitleResponse itemsTitle;
  ItemsMasterCountryResponse itemsCountry;
  List<ItemsListDocument> itemsDocument = [];

  //on show dialog
  Future<bool> onLoadActionCountryMaster(var itemPerson) async {
    Map map_title = {"TEXT_SEARCH": ""};
    await new ArrestFutureMaster().apiRequestMasTitlegetByCon(map_title).then((onValue) {
      itemsTitle = onValue;
    });
    Map map_country = {"TEXT_SEARCH": ""};
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map_country).then((onValue) {
      itemsCountry = onValue;
    });

    Map map = {"DOCUMENT_TYPE": 3, "REFERENCE_CODE": itemPerson.PERSON_ID};

    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((item) {
        if (int.parse(item.IS_ACTIVE) == 1) {
          items.add(item);
        }
      });
      itemsDocument = items;
    });

    if (mounted) {
      setState(() {});
    }
    return true;
  }

  Future<bool> onLoadActionMasProductGroupgetByCon() async {
    Map map = {
      "PRODUCT_GROUP_ID": "",
    };
    print(map);
    await new ArrestFutureMaster().apiRequestMasProductGroupgetByCon(map).then((onValue) {
      //_itemsData = onValue;
      List _items = [];
      onValue.forEach((item) {
        _items.add(item);
      });
      _itemsData = _items;
      // print(_itemsData.toString());
    });
    setState(() {});
    return true;
  }

  //Product
  _navigateScreenAddTab5(BuildContext context) async {
    ItemsListNotice itemsListNotice = new ItemsListNotice(
        PRODUCT_MAPPING_ID: null,
        PRODUCT_CODE: null,
        PRODUCT_REF_CODE: null,
        PRODUCT_ID: null,
        PRODUCT_GROUP_ID: null,
        PRODUCT_GROUP_CODE: null,
        PRODUCT_CATEGORY_ID: null,
        PRODUCT_TYPE_ID: null,
        PRODUCT_SUBTYPE_ID: null,
        PRODUCT_SUBSETTYPE_ID: null,
        PRODUCT_BRAND_ID: null,
        PRODUCT_SUBBRAND_ID: null,
        PRODUCT_MODEL_ID: null,
        PRODUCT_TAXDETAIL_ID: null,
        UNIT_ID: null,
        PRODUCT_CATEGORY_NAME: null,
        PRODUCT_GROUP_NAME: null,
        PRODUCT_TYPE_NAME: null,
        PRODUCT_SUBTYPE_NAME: null,
        PRODUCT_SUBSETTYPE_NAME: null,
        PRODUCT_BRAND_NAME_TH: null,
        PRODUCT_BRAND_NAME_EN: null,
        PRODUCT_SUBBRAND_CODE: null,
        PRODUCT_SUBBRAND_NAME_TH: null,
        PRODUCT_SUBBRAND_NAME_EN: null,
        PRODUCT_MODEL_NAME_TH: null,
        PRODUCT_MODEL_NAME_EN: null,
        SIZES_UNIT_ID: null,
        QUATITY_UNIT_ID: null,
        VOLUMN_UNIT_ID: null,
        SIZES: null,
        QUANTITY: null,
        VOLUMN: null,
        SIZES_UNIT: null,
        QUANTITY_UNIT: null,
        VOLUMN_UNIT: null,
        FINE_ESTIMATE: null,
        TAX_VALUE: null,
        TAX_VOLUMN: null,
        TAX_VOLUMN_UNIT: null,
        DEGREE: null,
        SUGAR: null,
        CO2: null,
        PRICE: null,
        PRODUCT_DESC: null,
        REMARK: null,
        IS_DOMESTIC: null,
        INDEX: null);
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
    // await onLoadActionProductGroupMaster();
    await onLoadActionMasProductGroupgetByCon();
    Navigator.pop(context);

    if (itemsProductGroup != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenNotice5Add(
                  itemProduct: _itemsData,
                  itemProductTab5: itemsListNotice,
                  temp_itemsDataTab5: _onEdited ? itemsNoticeMain.NoticeProduct : _itemsDataTab5,
                  onEdit: false,
                )),
      );

      if (result.toString() != "back") {
        print("กรณีไม่ได้กดย้อนกลับ");
        if (_onEdited) {
          print("กรณีไม่ได้กดย้อนกลับ และกดเพิ่ม ในการแก้ไขข้อมูลที่ถูกส่งเข้า server แล้ว");
          ItemsListNotice itm = result;
          itemsNoticeMain.NoticeProduct.add(itm);
          list_product_add.add(itm);
        } else {
          print("กรณีไม่ได้กดย้อนกลับ และกดเพิ่ม");
          ItemsListNotice itm = result;
          _itemsDataTab5.add(itm);
        }
      }
    }
  }

  List<ItemsListProductGROUPCategory> itemsProductGroup = [];

  //on show dialog
  Future<bool> onLoadActionProductGroupMaster() async {
    Map map = {
      "TEXT_SEARCH": "",
      //"PRODUCT_GROUP_ID": ""
    };
    List<int> _ids = [];
    List<ItemsListProductGROUPCategory> _items = [];
    await new ArrestFutureMaster().apiRequestMasProductGROUPCategoryForLiquorgetByCon(map).then((onValue) {
      onValue.forEach((f) {
        _ids.add(f.PRODUCT_GROUP_ID);
      });
      _items = onValue;
    });
    var distinctIds = _ids.toSet().toList();
    List<ItemsListProductGROUPCategory> _items_real = [];
    for (int i = 0; i < distinctIds.length; i++) {
      for (int j = 0; j < _items.length; j++) {
        if (_items[j].PRODUCT_GROUP_ID == 13) {
          print(_items[j].PRODUCT_GROUP_NAME);
          if (distinctIds[i] == _items[j].PRODUCT_GROUP_ID) {
            _items_real.add(_items[j]);
          }
        } else {
          if (distinctIds[i] == _items[j].PRODUCT_GROUP_ID) {
            _items_real.add(_items[j]);
            break;
          }
        }
      }
    }
    itemsProductGroup = _items_real;

    if (mounted) {
      setState(() {});
    }
    return true;
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
