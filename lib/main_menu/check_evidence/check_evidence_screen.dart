import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_8.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_warehouse.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_add.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/delivery_book_search_screen.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection_item.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/prove/model/prove_arrest_product.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/SetProductNameProve.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/picker/date_picker_return.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';
import 'evidence_search_staff.dart';
import 'future/check_evidence_future.dart';
import 'model/evidence_arrest.dart';
import 'model/evidence_get_staff.dart';
import 'model/evidence_item.dart';
import 'model/evidence_main.dart';

class CheckEvidenceMainScreenFragment extends StatefulWidget {
  ItemsEvidenceMain itemsEvidenceMain;
  ItemsEvidenceArrest itemsEvidenceArrest;
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  List<ItemsProveArrestProduct> itemsProveArrestProduct;
  ItemsMasWarehouseResponse itemsMasWarehouse;
  List<ItemsListDocument> ItemsDocument;
  String title;
  bool IsCreate;
  bool IsUpdate;
  bool IsPreview;
  int EVIDENCE_TYPE;

  // 3 = สร้างข้อมูลนำส่ง, ตรวจรับจากหน่วยภายนอก
  // 4 = สร้างข้อมูลนำส่ง, ตรวจรับจากการนำออกไปใช้ในราชการ
  // 1 = ตรวจรับจากหน่วยภายนอก
  // 0 = ตรวจรับจากหน่วยภายใน
  // 2 = ตรวจรับจากการนำออกไปใช้ในราชการ
  CheckEvidenceMainScreenFragment({
    Key key,
    @required this.itemsEvidenceMain,
    @required this.itemsEvidenceArrest,
    @required this.ItemsPerson,
    @required this.IsCreate,
    @required this.IsUpdate,
    @required this.title,
    @required this.IsPreview,
    @required this.EVIDENCE_TYPE,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
    @required this.itemsProveArrestProduct,
    @required this.itemsMasWarehouse,
    @required this.ItemsDocument,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<CheckEvidenceMainScreenFragment> with TickerProviderStateMixin {
  TabController tabController;
  TabPageSelector _tabPageSelector;
  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;
  //ตรวจรับกา่รนำออก
  bool _onExport = false;
  //ตรวจรับจากหน่วยงานภายใน
  bool _onWithOut = false;
  //ตรวจรับจากหน่วยงานภายใน(Prove)
  bool IsReceiveProve = false;

  bool IsCreate = false;

  List<Choice> choices = [];

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete),
  ];

  //style text
  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textStyleData1 = TextStyle(fontSize: 18, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSubData = TextStyle(fontSize: 16, color: Colors.black38, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle textStyleStar = Styles.textStyleStar;
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleSub = TextStyle(fontSize: 16, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelEditNonCheckStyle = TextStyle(fontSize: 16.0, color: Colors.red[100], fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff31517c), fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2), fontFamily: FontStyles().FontFamily);

  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

  //item หลักทั้งหมด
  ItemsEvidenceMain itemMain;
  //ข้อมูลนำส่ง
  ItemsEvidenceArrest itemsEvidenceArrest;
  //item ของกลาง
  List<ItemsEvidenceInItem> itemEvidence = [];
  List<ItemsEvidenceInItem> list_add_evidence_item = [];
  List<ItemsEvidenceInItem> list_del_evidence_item = [];

  //item controller ข้อมูลนำส่ง
  List<ItemsCheckEvidenceDetailController> itemEvidenceDetailCon;
  //item forms
  List<ItemsListArrest8> itemsFormsTab = [];

  //วันที่อละเวลาปัจจุบัน
  String _currentDevieredDate, _currentReturnDate = "", _currentGetDate, _currentDevieredTime, _currentGetTime;
  var dateFormatDate, dateFormatTime;
  //_dt
  DateTime _dtReturn = DateTime.now();
  //node focus ข้อมูลการนำส่ง
  final FocusNode myFocusNodeCheckEvidenceNumber = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceNumberOutside = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePerson = FocusNode();
  final FocusNode myFocusNodeCheckEvidencePosition = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceDepartment = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceComment = FocusNode();
  final FocusNode myFocusNodeCheckEvidenceStock = FocusNode();
  final FocusNode myFocusNodeDevieredDate = FocusNode();
  final FocusNode myFocusNodeDevieredTime = FocusNode();
  final FocusNode myFocusNodeCaseNumber = FocusNode();
  final FocusNode myFocusNodeReturnDate = FocusNode();

  final FocusNode myFocusNodeGetDate = FocusNode();
  final FocusNode myFocusNodeGetTime = FocusNode();

  final FocusNode myFocusPresidentCommittee = FocusNode();
  final FocusNode myFocusCommittee = FocusNode();
  final FocusNode myFocusSecretary = FocusNode();

  //****************เพิ่มเติม*************************
  final FocusNode myFocusNodeStockGet = FocusNode();
  TextEditingController editStockGet = new TextEditingController();
  //****************ปิด เพิ่มเติม*************************

  //textfield ข้อมูลการนำส่ง
  TextEditingController editCheckEvidenceNumber = new TextEditingController();
  TextEditingController editCheckEvidenceNumberOutside = new TextEditingController();
  TextEditingController editCheckEvidencePerson = new TextEditingController();
  TextEditingController editCheckEvidencePosition = new TextEditingController();
  TextEditingController editCheckEvidenceDepartment = new TextEditingController();
  TextEditingController editCheckEvidenceComment = new TextEditingController();
  TextEditingController editCheckEvidenceStock = new TextEditingController();
  TextEditingController editDevieredDate = new TextEditingController();
  TextEditingController editDevieredTime = new TextEditingController();
  TextEditingController editCaseNumber = new TextEditingController();
  TextEditingController editReturnDate = new TextEditingController();

  TextEditingController editGetDate = new TextEditingController();
  TextEditingController editGetTime = new TextEditingController();

  TextEditingController editPresidentCommittee = new TextEditingController();
  TextEditingController editCommittee = new TextEditingController();
  TextEditingController editSecretary = new TextEditingController();

  //node focus ข้อมูลการนำส่ง
  final FocusNode myFocusNodeCheckEvidencePersonGet = FocusNode();
  //textfield ข้อมูลการนำส่ง
  TextEditingController editCheckEvidencePersonGet = new TextEditingController();

  //dropdown คลังจัดเก็บ
  ItemsListWarehouse dropdownValueStock;
  ItemsMasWarehouseResponse dropdownItemsStock;

  List<Widget> list_widget_tab = [];
  String _title;

  DateTime _dtGet = DateTime.now();

  //node focus นำส่งเพื่อจัดเก็บ
  final FocusNode myFocusNodeDeriveredDate = FocusNode();
  final FocusNode myFocusNodeDeriveredTime = FocusNode();
  final FocusNode myFocusNodeDeriveredNumber = FocusNode();
  final FocusNode myFocusNodeDeriveredYear = FocusNode();
  final FocusNode myFocusNodeDeriveredPersonName = FocusNode();
  final FocusNode myFocusNodeDeriveredDepartment = FocusNode();
  final FocusNode myFocusNodeDeriveredStockName = FocusNode();
  final FocusNode myFocusNodeDeriveredTransport = FocusNode();
  //textfield นำส่งเพื่อจัดเก็บ
  TextEditingController editDeriveredDate = new TextEditingController();
  TextEditingController editDeriveredTime = new TextEditingController();
  TextEditingController editDeriveredNumber = new TextEditingController();
  TextEditingController editDeriveredYear = new TextEditingController();
  TextEditingController editDeriveredPersonName = new TextEditingController();
  TextEditingController editDeriveredDepartment = new TextEditingController();
  TextEditingController editDeriveredStockName = new TextEditingController();
  TextEditingController editDeriveredTransport = new TextEditingController();

  List<ItemsProveArrestProduct> itemsProveArrestProduct;

  String _currentDeriveredDate, _currentDeriveredTime;

  DateTime _dtDerivered = DateTime.now();
  DateTime deriveredTime = DateTime.now();
  String _deriveredDate = DateTime.now().toString();

  bool IsProductStorageAll = false;

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    dropdownItemsStock = widget.itemsMasWarehouse;

    if (widget.title.length > 18) {
      _title = widget.title.substring(0, 18) + '...';
    } else {
      _title = widget.title;
    }

    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    //วันและเวลาที่ส่ง
    _currentDevieredDate = date;
    _currentDevieredTime = dateFormatTime.format(DateTime.now()).toString();
    //วันและเวลาที่รับ
    _currentGetDate = date;
    _currentGetTime = dateFormatTime.format(DateTime.now()).toString();

    if (!widget.IsCreate) {
      _onFinish = widget.IsPreview;
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsUpdate;

      print("EVIDENCE_TYPE 0 : " + widget.EVIDENCE_TYPE.toString());

      List<ItemsListDocument> items = [];
      print(widget.ItemsDocument.length);
      widget.ItemsDocument.forEach((f) {
        File _file = new File(f.DOCUMENT_OLD_NAME);
        items.add(new ItemsListDocument(
          DOCUMENT_ID: f.DOCUMENT_ID,
          REFERENCE_CODE: f.REFERENCE_CODE,
          FILE_PATH: f.FILE_PATH,
          DATA_SOURCE: f.DATA_SOURCE,
          DOCUMENT_TYPE: f.DOCUMENT_TYPE,
          DOCUMENT_NAME: f.DOCUMENT_NAME,
          IS_ACTIVE: f.IS_ACTIVE,
          DOCUMENT_OLD_NAME: f.DOCUMENT_OLD_NAME,
          CONTENT: f.CONTENT,
          FILE_TYPE: f.FILE_TYPE,
          FOLDER: f.FOLDER,
          FILE_CONTENT: _file,
        ));
      });
      _arrItemsImageFile = items;

      if (widget.EVIDENCE_TYPE == 0) {
        _onExport = true;
        IsReceiveProve = true;
        //ภายใน
        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          //เพิ่มมา ^^
          Choice(title: 'ตรวจรับของกลาง'),
          Choice(title: 'ข้อมูลคดี'),
        ];
        itemsEvidenceArrest = widget.itemsEvidenceArrest;
        itemMain = widget.itemsEvidenceMain;
        itemEvidence = itemMain.EvidenceInItem;

        itemEvidence.forEach((item) {
          _setCalItem(item);
        });

        itemsProveArrestProduct = widget.itemsProveArrestProduct;
        itemsProveArrestProduct.sort((a, b) => a.PRODUCT_GROUP_ID.compareTo(b.PRODUCT_GROUP_ID));

        itemsProveArrestProduct.forEach((item) {
          item.controller.editQuantity.text = item.QUANTITY.toString();
          item.controller.editVolume.text = item.VOLUMN.toString();
        });
        /*itemMain.EvidenceInStaff.forEach((item){
          itemsListEvidenceStaff.add(new ItemsListEvidenceGetStaff(
              STAFF_ID: null,
              STAFF_TYPE: item.STAFF_TYPE,
              STAFF_CODE: item.STAFF_CODE,
              STAFF_REF_ID: item.STAFF_REF_ID,
              ID_CARD: item.ID_CARD,
              TITLE_NAME_TH: item.TITLE_NAME_TH,
              TITLE_SHORT_NAME_TH: item.TITLE_SHORT_NAME_TH,
              FIRST_NAME: item.FIRST_NAME,
              LAST_NAME: item.LAST_NAME,
              OPREATION_POS_NAME: item.OPREATION_POS_NAME,
              OPREATION_POS_LAVEL_NAME: null,
              OPERATION_OFFICE_NAME: item.OPERATION_OFFICE_NAME,
              OPERATION_OFFICE_SHORT_NAME: item.OPERATION_OFFICE_SHORT_NAME,
              CONTRIBUTOR_ID: item.CONTRIBUTOR_ID,
              IsCheck: false
          ));
        });
        add_staff_to(59);
        add_staff_to(60);*/

      } else if (widget.EVIDENCE_TYPE == 1) {
        //ภายนอก
        _onWithOut = true;

        itemsEvidenceArrest = widget.itemsEvidenceArrest;
        itemMain = widget.itemsEvidenceMain;

        itemEvidence.forEach((item) {
          _setCalItem(item);
        });

        itemMain.EvidenceInStaff.forEach((item) {
          itemsListEvidenceStaff.add(new ItemsListEvidenceGetStaff(
              STAFF_ID: null,
              STAFF_TYPE: item.STAFF_TYPE,
              STAFF_CODE: item.STAFF_CODE,
              STAFF_REF_ID: item.STAFF_REF_ID,
              ID_CARD: item.ID_CARD,
              TITLE_NAME_TH: item.TITLE_NAME_TH,
              TITLE_SHORT_NAME_TH: item.TITLE_SHORT_NAME_TH,
              FIRST_NAME: item.FIRST_NAME,
              LAST_NAME: item.LAST_NAME,
              OPREATION_POS_NAME: item.OPREATION_POS_NAME,
              OPREATION_POS_LAVEL_NAME: null,
              OPERATION_OFFICE_NAME: item.OPERATION_OFFICE_NAME,
              OPERATION_OFFICE_SHORT_NAME: item.OPERATION_OFFICE_SHORT_NAME,
              CONTRIBUTOR_ID: item.CONTRIBUTOR_ID,
              IsCheck: false));
        });
        add_staff_to(60);

        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          Choice(title: 'ตรวจรับของกลาง'),
        ];
      } else if (widget.EVIDENCE_TYPE == 2) {
        _onExport = true;
        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          Choice(title: 'ตรวจรับของกลาง'),
        ];

        add_staff_to(59);
        add_staff_to(60);
      } else if (widget.EVIDENCE_TYPE == 3 || widget.EVIDENCE_TYPE == 4) {
        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          Choice(title: 'ตรวจรับของกลาง'),
        ];
        if (widget.EVIDENCE_TYPE == 4) {
          _onExport = true;
        }

        add_staff_to(59);
        add_staff_to(60);
      }
      _setDataSaved();
    } else {
      IsCreate = widget.IsCreate;
      _onSaved = widget.IsPreview;
      _onFinish = widget.IsPreview;

      print("EVIDENCE TYPE : " + widget.EVIDENCE_TYPE.toString());

      editDevieredDate.text = _currentDevieredDate;
      editDevieredTime.text = _currentDevieredTime;
      editGetDate.text = _currentDevieredDate;
      editGetTime.text = _currentDevieredTime;

      if (widget.EVIDENCE_TYPE == 0) {
        IsReceiveProve = true;
        //วันและเวลานำส่งเพื่อจัดเก็บ
        _currentDeriveredDate = date;
        _currentDeriveredTime = dateFormatTime.format(DateTime.now()).toString();

        editDeriveredDate.text = _currentDeriveredDate;
        editDeriveredTime.text = _currentDeriveredTime;

        _deriveredDate = DateTime.now().toString();
        //editDeriveredYear.text = _convertYear(DateTime.now().toString());
        itemsProveArrestProduct = widget.itemsProveArrestProduct;
        itemsProveArrestProduct.sort((a, b) => a.PRODUCT_GROUP_ID.compareTo(b.PRODUCT_GROUP_ID));

        itemsProveArrestProduct.forEach((item) {
          item.controller.editQuantity.text = item.QUANTITY.toString();
          item.controller.editVolume.text = item.VOLUMN.toString();
        });

        _onExport = true;
        //ภายใน
        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          //เพิ่มมา ^^
          Choice(title: 'ตรวจรับของกลาง'),
          Choice(title: 'ข้อมูลคดี'),
        ];
        itemsEvidenceArrest = widget.itemsEvidenceArrest;
        itemMain = widget.itemsEvidenceMain;

        itemEvidence.forEach((item) {
          _setCalItem(item);
        });

        add_staff_to(59);
        add_staff_to(60);

        itemsProveArrestProduct.forEach((item) {
          item.controller.editQuantity.text = item.QUANTITY != null ? item.QUANTITY.toInt().toString() : "";
          item.controller.editVolume.text = item.VOLUMN != null ? item.VOLUMN.toString() : "";
        });

        editDeriveredPersonName.text = get_staff_name(itemsListEvidenceStaff, 59);
        editDeriveredDepartment.text = get_office_name(itemsListEvidenceStaff, 59);
        editCheckEvidencePersonGet.text = get_staff_name(itemsListEvidenceStaff, 60);
      } else if (widget.EVIDENCE_TYPE == 1) {
        //ภายนอก
        _onWithOut = true;

        itemsEvidenceArrest = widget.itemsEvidenceArrest;
        /*itemMain = widget.itemsEvidenceMain;

        itemEvidence.forEach((item){
          _setCalItem(item);
        });

        itemMain.EvidenceInStaff.forEach((item){
          itemsListEvidenceStaff.add(new ItemsListEvidenceGetStaff(
              STAFF_ID: null,
              STAFF_TYPE: item.STAFF_TYPE,
              STAFF_CODE: item.STAFF_CODE,
              STAFF_REF_ID: item.STAFF_REF_ID,
              ID_CARD: item.ID_CARD,
              TITLE_NAME_TH: item.TITLE_NAME_TH,
              TITLE_SHORT_NAME_TH: item.TITLE_SHORT_NAME_TH,
              FIRST_NAME: item.FIRST_NAME,
              LAST_NAME: item.LAST_NAME,
              OPREATION_POS_NAME: item.OPREATION_POS_NAME,
              OPREATION_POS_LAVEL_NAME: null,
              OPERATION_OFFICE_NAME: item.OPERATION_OFFICE_NAME,
              OPERATION_OFFICE_SHORT_NAME: item.OPERATION_OFFICE_SHORT_NAME,
              CONTRIBUTOR_ID: item.CONTRIBUTOR_ID,
              IsCheck: false
          ));
        });
        add_staff_to(60);*/

        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          Choice(title: 'ตรวจรับของกลาง'),
        ];
      } else if (widget.EVIDENCE_TYPE == 2) {
        _onExport = true;
        add_staff_to(59);
        add_staff_to(60);

        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          Choice(title: 'ตรวจรับของกลาง'),
        ];
      } else if (widget.EVIDENCE_TYPE == 3 || widget.EVIDENCE_TYPE == 4) {
        add_staff_to(59);
        add_staff_to(60);

        choices = <Choice>[
          Choice(title: 'ข้อมูลการนำส่ง'),
          Choice(title: 'ตรวจรับของกลาง'),
        ];
        if (widget.EVIDENCE_TYPE == 4) {
          _onExport = true;
        }
      }

      /*String staff_name =widget.ItemsPerson.TITLE_SHORT_NAME_TH.toString()+
          widget.ItemsPerson.FIRST_NAME+" "+widget.ItemsPerson.LAST_NAME;*/
      editCheckEvidencePersonGet.text = get_staff_name(itemsListEvidenceStaff, 60);
      editCheckEvidencePerson.text = get_staff_name(itemsListEvidenceStaff, 59);
    }

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
  }

  void _setCalItem(ItemsEvidenceInItem item) {
    item.ItemsController.editDeliveredNumber.text = item.DELIVERY_QTY.toInt().toString();
    item.ItemsController.editDefectiveNumber.text = item.DAMAGE_QTY.toInt().toString();
    item.ItemsController.editTotalNumber.text = (item.DELIVERY_QTY - item.DAMAGE_QTY).toInt().toString();

    item.ItemsController.editDeliveredVolumn.text = item.DELIVERY_NET_VOLUMN.toString();
    item.ItemsController.editDefectiveVolumn.text = item.DAMAGE_NET_VOLUMN.toString();
    item.ItemsController.editTotalVolumn.text = (item.DELIVERY_NET_VOLUMN - item.DAMAGE_NET_VOLUMN).toString();

    item.ItemsController.editProductUnit.text = item.DELIVERY_QTY_UNIT.toString();
    item.ItemsController.editVolumeUnit.text = item.DELIVERY_NET_VOLUMN_UNIT.toString();
  }

  void _setDataSaved() {
    _onFinish = true;
    //เพิ่ม tab แบบฟอร์ม
    choices.add(Choice(title: 'แบบฟอร์ม'));
    //เพิ่ม item forms
    itemsFormsTab = [];
    itemsFormsTab.add(new ItemsListArrest8("บันทึกตรวจรับของกลางเพื่อเก็บรักษา (ขก.2)", ""));
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
  }

  @override
  void dispose() {
    super.dispose();
    editCheckEvidenceNumber.dispose();
    editCheckEvidenceNumberOutside.dispose();
    editCheckEvidencePerson.dispose();
    editCheckEvidencePosition.dispose();
    editCheckEvidenceDepartment.dispose();
    editCheckEvidenceComment.dispose();
    editCheckEvidenceStock.dispose();

    editCommittee.dispose();
    editPresidentCommittee.dispose();
    editSecretary.dispose();

    editCheckEvidencePersonGet.dispose();

    if (itemEvidence.length > 0) {
      itemEvidence.forEach((item) {
        item.ItemsController.editDeliveredNumber.dispose();
        item.ItemsController.editDefectiveNumber.dispose();
        item.ItemsController.editDefectiveNumberUnit.dispose();
        item.ItemsController.editDeliveredVolumn.dispose();
        item.ItemsController.editDefectiveVolumn.dispose();
        item.ItemsController.editDefectiveVolumnUnit.dispose();
        item.ItemsController.editEvidenceComment.dispose();
      });
    }

    editStockGet.dispose();
    editDeriveredDate.dispose();
    editDeriveredTime.dispose();
    editDeriveredNumber.dispose();
    editDeriveredYear.dispose();
    editDeriveredPersonName.dispose();
    editDeriveredDepartment.dispose();
    editDeriveredStockName.dispose();
    editDeriveredTransport.dispose();
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
    //tab_1
    if (widget.EVIDENCE_TYPE == 0) {
      editDeriveredDate.text = _convertDate(itemMain.DELIVERY_DATE);
      editDeriveredTime.text = _convertTime1(itemMain.DELIVERY_DATE);

      List splits = itemMain.DELIVERY_NO.split("/");
      editDeriveredNumber.text = splits[0].substring(3);
      editDeriveredYear.text = splits[1];

      editDeriveredPersonName.text = get_staff_name(itemMain.EvidenceInStaff, 59);
      editDeriveredDepartment.text = get_office_name(itemMain.EvidenceInStaff, 59);
      editDeriveredTransport.text = itemMain.REMARK != null ? itemMain.REMARK : "";

      int count_check = 0;
      itemMain.EvidenceInItem.forEach((itm) {
        for (int i = 0; i < itemsProveArrestProduct.length; i++) {
          if (itm.PRODUCT_MAPPING_ID == itemsProveArrestProduct[i].PRODUCT_MAPPING_ID) {
            itemsProveArrestProduct[i].IS_CHECK = true;

            count_check++;
            itemsProveArrestProduct[i].controller.editQuantity.text = itm.DELIVERY_QTY.toInt().toString();
            itemsProveArrestProduct[i].controller.editVolume.text = itm.DELIVERY_NET_VOLUMN.toString();
            break;
          }
        }
      });
      if (count_check == itemsProveArrestProduct.length) {
        IsProductStorageAll = true;
      }
    }

    _dtGet = DateTime.parse(itemMain.EVIDENCE_IN_DATE);
    _currentGetDate = _convertDate(_dtGet.toString());
    _currentGetTime = dateFormatTime.format(_dtGet).toString();
    editGetDate.text = _currentGetDate;
    editGetTime.text = _currentGetTime;

    editCheckEvidencePersonGet.text = get_staff_name(itemMain.EvidenceInStaff, 60);

    //ประธานกรรมการ
    editPresidentCommittee.text = get_staff_name(itemMain.EvidenceInStaff, 61);
    //กรรมการ
    editCommittee.text = get_staff_name(itemMain.EvidenceInStaff, 62);
    //กรรมการและเลขานุการ
    editSecretary.text = get_staff_name(itemMain.EvidenceInStaff, 63);

    itemEvidence.forEach((item) {
      _setCalItem(item);
    });

    itemMain.EvidenceInItem.forEach((item) {
      item.EvidenceOutStockBalance.forEach((item) {
        dropdownItemsStock.RESPONSE_DATA.forEach((itm) {
          if (itm.WAREHOUSE_ID == item.WAREHOUSE_ID) {
            dropdownValueStock = itm;
          }
        });
      });
    });
  }

  /*****************************method for main tab**************************/
  //เมื่อกด popup แสดงการแก้ไขหรือลบ
  void choiceAction(Constants constants) {
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
        _showDeleteAllAlertDialog();
      }
    });
  }

  //คำสั่งที่เลือกอย่างไดอย่างหนึ่งใน delete dialog
  CupertinoAlertDialog _createCupertinoDeleteAllDialog() {
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
                onDeleted();
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  //แสดง dialog ลบรายการ
  void _showDeleteAllAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDeleteAllDialog();
      },
    );
  }

  void onDeleted() async {
    Map map_evidence = {"EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID};
    List<Map> map_evidence_item = [];
    itemEvidence.forEach((item) {
      map_evidence_item.add({"EVIDENCE_IN_ITEM_ID": item.EVIDENCE_IN_ITEM_ID});
    });
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionInsLawsuitDelete(map_evidence, map_evidence_item);
    Navigator.pop(context, "Delete");
  }

  Future<bool> onLoadActionInsLawsuitDelete(Map map_evidence, List<Map> map_evidence_item) async {
    await new CheckEvidenceFuture().apiRequestEvidenceInupdDelete(map_evidence).then((onValue) {
      print("Delete EvidenceIn : " + onValue.Msg);
    });
    await new CheckEvidenceFuture().apiRequestEvidenceInItemupdDelete(map_evidence_item).then((onValue) {
      print("Delete EvidenceInItem : " + onValue.Msg);
    });

    /*_onSaved = false;
    _onEdited = true;
    _onSave = false;
    choices.removeAt(choices.length-1);*/
    Navigator.pop(context);

    setState(() {});
    return true;
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
                  if (_onEdited) {
                    list_del_evidence_item.add(itemEvidence[index]);
                    itemEvidence.removeAt(index);
                  } else {
                    list_add_evidence_item.forEach((f) {
                      if (f.PRODUCT_GROUP_ID == itemEvidence[index].PRODUCT_CATEGORY_ID) {
                        list_add_evidence_item.remove(f);
                      }
                    });

                    itemEvidence.removeAt(index);
                  }
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
    if (widget.EVIDENCE_TYPE == 0) {
      if (editDeriveredNumber.text.isEmpty || editDeriveredYear.text.isEmpty) {
        new VerifyDialog(mContext, 'กรุณากรอกเลขที่หนังสือนำส่งเพื่อจัดเก็บ');
      } else if (dropdownValueStock == null) {
        new VerifyDialog(mContext, 'กรุณาเลือกคลังจัดเก็บเพื่อตรวจรับ');
      } else if (itemEvidence.length == 0) {
        new VerifyDialog(mContext, 'กรุณาเพิ่มของกลาง');
      } else {
        if (!_onEdited) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              });
          await onLoadActionEvidenceUpdAll();
          Navigator.pop(context);
        } else {
          //update

          bool IsOvereQauntity = false;
          bool IsOvereVolumn = false;
          itemEvidence.forEach((item) {
            if (int.parse(item.ItemsController.editTotalNumber.text) < 0) {
              IsOvereQauntity = true;
            }
            if (double.parse(item.ItemsController.editTotalVolumn.text) < 0) {
              IsOvereVolumn = true;
            }
          });

          if (IsOvereQauntity) {
            new VerifyDialog(mContext, 'จำนวนนำส่งต้องไม่น้อยกว่าจำนวนชำรุด');
          } else if (IsOvereVolumn) {
            new VerifyDialog(mContext, 'ปริมาณนำส่งต้องไม่น้อยกว่าปริมาณชำรุด');
          } else {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                });
            await onLoadActionEvidenceUpdAll();
            Navigator.pop(context);
          }
        }
        /*bool IsOvereQauntity=false;
        bool IsOvereVolumn=false;
        itemEvidence.forEach((item){
          if(int.parse(item.ItemsController.editTotalNumber.text)<0){
            IsOvereQauntity=true;
          }
          if(double.parse(item.ItemsController.editTotalVolumn.text)<0){
            IsOvereVolumn=true;
          }
        });

        if(IsOvereQauntity){
          new VerifyDialog(mContext, 'จำนวนนำส่งต้องไม่น้อยกว่าจำนวนชำรุด');
        }else if(IsOvereVolumn){
          new VerifyDialog(mContext, 'ปริมาณนำส่งต้องไม่น้อยกว่าปริมาณชำรุด');
        }else{
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              });
          await onLoadActionEvidenceUpdAll();
          Navigator.pop(context);
        }*/
      }
    } else if (widget.EVIDENCE_TYPE == 0 || widget.EVIDENCE_TYPE == 3 || widget.EVIDENCE_TYPE == 4) {
      if (IsReceiveProve) {
        print('this IsReceiveProve');
        if (editDeriveredNumber.text.isEmpty || editDeriveredYear.text.isEmpty) {
          new VerifyDialog(mContext, 'กรุณากรอกเลขที่หนังสือนำส่งเพื่อจัดเก็บ');
        } else if (editDeriveredDepartment.text.isEmpty) {
          new VerifyDialog(mContext, 'กรุณากรอกหน่วยงานต้นทางนำส่งเพื่อจัดเก็บ');
        } else if (dropdownValueStock == null) {
          new VerifyDialog(mContext, 'กรุณาเลือกคลังจัดเก็บเพื่อตรวจรับ');
        } /*else if (IsOverItemDelivered) {
          new VerifyDialog(mContext, 'จำนวนหรือปริมาณนำส่งต้องไม่เกินจำนวนที่มีอยู่');
        }*/
        else {
          if (!_onEdited) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                });
            await onLoadActionEvidenceInsAll(widget.EVIDENCE_TYPE);
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
            await onLoadActionEvidenceUpdAll();
            Navigator.pop(context);
          }
        }
      } else {
        if (editCheckEvidenceNumber.text.isEmpty) {
          new VerifyDialog(mContext, 'กรุณากรอกเลขหนังสือนำส่งจัดเก็บ');
        } /* else if (editCheckEvidenceNumberOutside.text.isEmpty) {
        new VerifyDialog(mContext, 'กรุณากรอกเลขหนังสือจากภายนอก');
      }*/
        else if (editCheckEvidenceDepartment.text.isEmpty && widget.EVIDENCE_TYPE != 4) {
          new VerifyDialog(mContext, 'กรุณากรอกหน่วยงานนำส่ง');
        } else if (dropdownValueStock == null) {
          new VerifyDialog(mContext, 'กรุณาเลือกคลังจัดเก็บ');
        } else {
          bool IsOvereQauntity = false;
          bool IsOvereVolumn = false;
          itemEvidence.forEach((item) {
            if (int.parse(item.ItemsController.editTotalNumber.text) < 0) {
              IsOvereQauntity = true;
            }
            if (double.parse(item.ItemsController.editTotalVolumn.text) < 0) {
              IsOvereVolumn = true;
            }
          });

          if (IsOvereQauntity) {
            new VerifyDialog(mContext, 'จำนวนนำส่งต้องไม่น้อยกว่าจำนวนชำรุด');
          } else if (IsOvereVolumn) {
            new VerifyDialog(mContext, 'ปริมาณนำส่งต้องไม่น้อยกว่าปริมาณชำรุด');
          } else {
            if (!_onEdited) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  });
              await onLoadActionEvidenceInsAll(widget.EVIDENCE_TYPE);
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
              await onLoadActionEvidenceUpdAll();
              Navigator.pop(context);
            }
          }
        }
      }
    }

    /*showDialog(
    barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(
            ),
          );
        });
    await onLoadAction();
    Navigator.pop(context);

    setState(() {
      //เมื่อกดบันทึก
      _onSaved = true;
      _onFinish = true;


      _setDataSaved();
      //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
      tabController.animateTo((choices.length - 1));
    });*/
  }

  bool IsCreateStaff = false;
  List<Map> _createMapStaff(bool IsUpdate, int CONTRIBUTOR_ID, List<int> list_contributor) {
    List<Map> items = [];
    if (IsUpdate) {
      if (!_onEdited) {
        IsCreateStaff = true;
        itemsListEvidenceStaff.forEach((item) {
          if (item.CONTRIBUTOR_ID != 59) {
            print("CONTRIBUTOR_ID : " + item.CONTRIBUTOR_ID.toString());
            items.add({
              "EVIDENCE_IN_STAFF_ID": "",
              "EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID,
              "STAFF_REF_ID": item.STAFF_REF_ID,
              "TITLE_ID": "",
              "STAFF_CODE": item.STAFF_CODE,
              "ID_CARD": item.ID_CARD,
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
              "OPERATION_OFFICE_CODE": item.OPERATION_OFFICE_CODE,
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
          }
        });
      } else {
        //กรณีกดแก้ไข
        print("กรณีกดแก้ไข");
        itemMain.EvidenceInStaff.forEach((item) {
          if (item.CONTRIBUTOR_ID != 58 || item.CONTRIBUTOR_ID != 60) {
            for (int i = 0; i < itemsListEvidenceStaff.length; i++) {
              if (item.CONTRIBUTOR_ID == itemsListEvidenceStaff[i].CONTRIBUTOR_ID) {
                items.add({
                  "EVIDENCE_IN_STAFF_ID": item.EVIDENCE_IN_STAFF_ID,
                  "EVIDENCE_IN_ID": item.EVIDENCE_IN_ID,
                  "STAFF_REF_ID": itemsListEvidenceStaff[i].STAFF_REF_ID,
                  "TITLE_ID": "",
                  "STAFF_CODE": itemsListEvidenceStaff[i].STAFF_CODE,
                  "ID_CARD": itemsListEvidenceStaff[i].ID_CARD,
                  "STAFF_TYPE": itemsListEvidenceStaff[i].STAFF_TYPE,
                  "TITLE_NAME_TH": itemsListEvidenceStaff[i].TITLE_SHORT_NAME_TH,
                  "TITLE_NAME_EN": "",
                  "TITLE_SHORT_NAME_TH": itemsListEvidenceStaff[i].TITLE_SHORT_NAME_TH,
                  "TITLE_SHORT_NAME_EN": "",
                  "FIRST_NAME": itemsListEvidenceStaff[i].FIRST_NAME,
                  "LAST_NAME": itemsListEvidenceStaff[i].LAST_NAME,
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
                  "OPERATION_OFFICE_CODE": itemsListEvidenceStaff[i].OPERATION_OFFICE_CODE,
                  "OPERATION_OFFICE_NAME": itemsListEvidenceStaff[i].OPERATION_OFFICE_NAME,
                  "OPERATION_OFFICE_SHORT_NAME": itemsListEvidenceStaff[i].OPERATION_OFFICE_SHORT_NAME,
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
                break;
              }
            }
          }
        });

        //กรณีที่มาเพิ่ม staff ทีหลัง
        itemsListEvidenceStaff.forEach((item) {
          if (get_staff_name(itemMain.EvidenceInStaff, item.CONTRIBUTOR_ID) == null) {
            setState(() {
              IsCreateStaff = true;
            });
            items.add({
              "EVIDENCE_IN_STAFF_ID": "",
              "EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID,
              "STAFF_REF_ID": item.STAFF_REF_ID,
              "TITLE_ID": "",
              "STAFF_CODE": item.STAFF_CODE,
              "ID_CARD": item.ID_CARD,
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
              "OPERATION_OFFICE_CODE": item.OPERATION_OFFICE_CODE,
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
          }
        });
      }
    } else {
      /*list_contributor.forEach((item){
        items.add({
          "EVIDENCE_IN_STAFF_ID": "",
          "EVIDENCE_IN_ID": "",
          "STAFF_REF_ID": "",
          "TITLE_ID": "",
          "STAFF_CODE": "",
          "ID_CARD": "",
          "STAFF_TYPE": widget.ItemsPerson.STAFF_TYPE,
          "TITLE_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
          "TITLE_NAME_EN": "",
          "TITLE_SHORT_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
          "TITLE_SHORT_NAME_EN": "",
          "FIRST_NAME": widget.ItemsPerson.FIRST_NAME,
          "LAST_NAME":widget.ItemsPerson.LAST_NAME,
          "AGE": "",
          "OPERATION_POS_CODE": "",
          "OPREATION_POS_NAME": widget.ItemsPerson.LAST_NAME,
          "OPREATION_POS_LEVEL": "",
          "OPERATION_POS_LEVEL_NAME": widget.ItemsPerson.OPREATION_POS_LAVEL_NAME,
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
          "CONTRIBUTOR_ID": item,
          "IS_ACTIVE": 1
        });
      });*/
      itemsListEvidenceStaff.forEach((item) {
        items.add({
          "EVIDENCE_IN_STAFF_ID": "",
          "EVIDENCE_IN_ID": "",
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

  List<Map> _createMapEvidenceItem(bool IsUpdate, List transec) {
    List<Map> items = [];
    List<Map> items_balance = [];
    if (_onEdited) {
      if (list_add_evidence_item.length > 0) {
        for (int i = 0; i < list_add_evidence_item.length; i++) {
          items.add({
            "EVIDENCE_IN_ITEM_ID": "",
            "EVIDENCE_IN_ITEM_CODE": transec[i],
            "EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID,
            "PRODUCT_MAPPING_ID": "",
            "PRODUCT_CODE": list_add_evidence_item[i].PRODUCT_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_CODE,
            "PRODUCT_REF_CODE": list_add_evidence_item[i].PRODUCT_REF_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_REF_CODE,
            "PRODUCT_GROUP_ID": list_add_evidence_item[i].PRODUCT_GROUP_ID,
            "PRODUCT_CATEGORY_ID": list_add_evidence_item[i].PRODUCT_CATEGORY_ID,
            "PRODUCT_TYPE_ID": list_add_evidence_item[i].PRODUCT_TYPE_ID,
            "PRODUCT_SUBTYPE_ID": list_add_evidence_item[i].PRODUCT_SUBTYPE_ID,
            "PRODUCT_SUBSETTYPE_ID": list_add_evidence_item[i].PRODUCT_SUBSETTYPE_ID,
            "PRODUCT_BRAND_ID": list_add_evidence_item[i].PRODUCT_BRAND_ID,
            "PRODUCT_SUBBRAND_ID": list_add_evidence_item[i].PRODUCT_SUBBRAND_ID,
            "PRODUCT_MODEL_ID": list_add_evidence_item[i].PRODUCT_MODEL_ID,
            "PRODUCT_TAXDETAIL_ID": list_add_evidence_item[i].PRODUCT_TAXDETAIL_ID,
            "PRODUCT_GROUP_CODE": list_add_evidence_item[i].PRODUCT_GROUP_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_GROUP_CODE,
            "PRODUCT_GROUP_NAME": list_add_evidence_item[i].PRODUCT_GROUP_NAME == null ? "" : list_add_evidence_item[i].PRODUCT_GROUP_NAME,
            "PRODUCT_CATEGORY_CODE": list_add_evidence_item[i].PRODUCT_CATEGORY_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_CATEGORY_CODE,
            "PRODUCT_CATEGORY_NAME": list_add_evidence_item[i].PRODUCT_CATEGORY_NAME == null ? "" : list_add_evidence_item[i].PRODUCT_CATEGORY_NAME,
            "PRODUCT_TYPE_CODE": list_add_evidence_item[i].PRODUCT_TYPE_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_TYPE_CODE,
            "PRODUCT_TYPE_NAME": list_add_evidence_item[i].PRODUCT_TYPE_NAME == null ? "" : list_add_evidence_item[i].PRODUCT_TYPE_NAME,
            "PRODUCT_SUBTYPE_CODE": list_add_evidence_item[i].PRODUCT_SUBTYPE_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_SUBTYPE_CODE,
            "PRODUCT_SUBTYPE_NAME": list_add_evidence_item[i].PRODUCT_SUBTYPE_NAME == null ? "" : list_add_evidence_item[i].PRODUCT_SUBTYPE_NAME,
            "PRODUCT_SUBSETTYPE_CODE": list_add_evidence_item[i].PRODUCT_SUBSETTYPE_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_SUBSETTYPE_CODE,
            "PRODUCT_SUBSETTYPE_NAME": list_add_evidence_item[i].PRODUCT_SUBSETTYPE_NAME == null ? "" : list_add_evidence_item[i].PRODUCT_SUBSETTYPE_NAME,
            "PRODUCT_BRAND_CODE": list_add_evidence_item[i].PRODUCT_BRAND_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_BRAND_CODE,
            "PRODUCT_BRAND_NAME_TH": list_add_evidence_item[i].PRODUCT_BRAND_NAME_TH == null ? "" : list_add_evidence_item[i].PRODUCT_BRAND_NAME_TH,
            "PRODUCT_BRAND_NAME_EN": list_add_evidence_item[i].PRODUCT_BRAND_NAME_EN == null ? "" : list_add_evidence_item[i].PRODUCT_BRAND_NAME_EN,
            "PRODUCT_SUBBRAND_CODE": list_add_evidence_item[i].PRODUCT_SUBBRAND_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_SUBBRAND_CODE,
            "PRODUCT_SUBBRAND_NAME_TH": list_add_evidence_item[i].PRODUCT_SUBBRAND_NAME_TH == null ? "" : list_add_evidence_item[i].PRODUCT_SUBBRAND_NAME_TH,
            "PRODUCT_SUBBRAND_NAME_EN": list_add_evidence_item[i].PRODUCT_SUBBRAND_NAME_EN == null ? "" : list_add_evidence_item[i].PRODUCT_SUBBRAND_NAME_EN,
            "PRODUCT_MODEL_CODE": list_add_evidence_item[i].PRODUCT_MODEL_CODE == null ? "" : list_add_evidence_item[i].PRODUCT_MODEL_CODE,
            "PRODUCT_MODEL_NAME_TH": list_add_evidence_item[i].PRODUCT_MODEL_NAME_TH == null ? "" : list_add_evidence_item[i].PRODUCT_MODEL_NAME_TH,
            "PRODUCT_MODEL_NAME_EN": list_add_evidence_item[i].PRODUCT_MODEL_NAME_EN == null ? "" : list_add_evidence_item[i].PRODUCT_MODEL_NAME_EN,
            "LICENSE_PLATE": list_add_evidence_item[i].LICENSE_PLATE,
            "ENGINE_NO": list_add_evidence_item[i].ENGINE_NO,
            "CHASSIS_NO": list_add_evidence_item[i].CHASSIS_NO,
            "PRODUCT_DESC": list_add_evidence_item[i].PRODUCT_DESC,
            "SUGAR": list_add_evidence_item[i].SUGAR,
            "CO2": list_add_evidence_item[i].CO2,
            "DEGREE": list_add_evidence_item[i].DEGREE,
            "PRICE": list_add_evidence_item[i].PRICE,
            "DELIVERY_QTY": list_add_evidence_item[i].DELIVERY_QTY,
            "DELIVERY_QTY_UNIT": list_add_evidence_item[i].DELIVERY_QTY_UNIT,
            "DELIVERY_SIZE": list_add_evidence_item[i].DELIVERY_SIZE,
            "DELIVERY_SIZE_UNIT": list_add_evidence_item[i].DELIVERY_SIZE_UNIT,
            "DELIVERY_NET_VOLUMN": list_add_evidence_item[i].DELIVERY_NET_VOLUMN,
            "DELIVERY_NET_VOLUMN_UNIT": list_add_evidence_item[i].DELIVERY_NET_VOLUMN_UNIT,
            "DAMAGE_QTY": int.parse(list_add_evidence_item[i].ItemsController.editDefectiveNumber.text),
            "DAMAGE_QTY_UNIT": list_add_evidence_item[i].DELIVERY_QTY_UNIT,
            "DAMAGE_SIZE": list_add_evidence_item[i].DELIVERY_SIZE,
            "DAMAGE_SIZE_UNIT": list_add_evidence_item[i].DELIVERY_SIZE_UNIT,
            "DAMAGE_NET_VOLUMN": double.parse(list_add_evidence_item[i].ItemsController.editDefectiveVolumn.text),
            "DAMAGE_NET_VOLUMN_UNIT": list_add_evidence_item[i].DELIVERY_NET_VOLUMN_UNIT,
            "IS_DOMESTIC": 0,
            "IS_ACTIVE": 1,
            "EvidenceOutStockBalance": [
              {
                "STOCK_ID": "",
                "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID,
                "EVIDENCE_IN_ITEM_ID": itemMain.EVIDENCE_IN_ID,
                "RECEIVE_QTY": list_add_evidence_item[i].ItemsController.editTotalNumber.text,
                "RECEIVE_QTY_UNIT": list_add_evidence_item[i].ItemsController.editTotalNumberUnit.text,
                "RECEIVE_SIZE": itemEvidence[i].DELIVERY_SIZE,
                "RECEIVE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
                "RECEIVE_NET_VOLUMN": list_add_evidence_item[i].ItemsController.editTotalVolumn.text,
                "RECEIVE_NET_VOLUMN_UNIT": /*list_add_evidence_item[i].ItemsController.editTotalVolumnUnit.text*/ itemEvidence[i].DELIVERY_SIZE_UNIT,
                "BALANCE_QTY": itemEvidence[i].DELIVERY_QTY,
                "BALANCE_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
                "BALANCE_SIZE": itemEvidence[i].DELIVERY_SIZE,
                "BALANCE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
                "BALANCE_NET_VOLUMN": list_add_evidence_item[i].ItemsController.editTotalVolumn.text,
                "BALANCE_NET_VOLUMN_UNIT": /*list_add_evidence_item[i].ItemsController.editTotalVolumnUnit.text*/ itemEvidence[i].DELIVERY_SIZE_UNIT,
                "IS_FINISH": 2,
                "IS_RECEIVE": 1
              }
            ]
          });
        }
      } else {
        for (int i = 0; i < itemEvidence.length; i++) {
          int STOCK_ID = 0;
          list_add_evidence_item.forEach((f) {
            f.EvidenceOutStockBalance.forEach((st) {
              STOCK_ID = st.STOCK_ID;
            });
          });

          items.add({
            "EVIDENCE_IN_ITEM_ID": itemEvidence[i].EVIDENCE_IN_ITEM_ID,
            "EVIDENCE_IN_ITEM_CODE": itemEvidence[i].EVIDENCE_IN_ITEM_CODE,
            "EVIDENCE_IN_ID": itemEvidence[i].EVIDENCE_IN_ID,
            "PRODUCT_MAPPING_ID": itemEvidence[i].PRODUCT_MAPPING_ID,
            "PRODUCT_CODE": itemEvidence[i].PRODUCT_CODE == null ? "" : itemEvidence[i].PRODUCT_CODE,
            "PRODUCT_REF_CODE": itemEvidence[i].PRODUCT_REF_CODE == null ? "" : itemEvidence[i].PRODUCT_REF_CODE,
            "PRODUCT_GROUP_ID": itemEvidence[i].PRODUCT_GROUP_ID,
            "PRODUCT_CATEGORY_ID": itemEvidence[i].PRODUCT_CATEGORY_ID,
            "PRODUCT_TYPE_ID": itemEvidence[i].PRODUCT_TYPE_ID,
            "PRODUCT_SUBTYPE_ID": itemEvidence[i].PRODUCT_SUBTYPE_ID,
            "PRODUCT_SUBSETTYPE_ID": itemEvidence[i].PRODUCT_SUBSETTYPE_ID,
            "PRODUCT_BRAND_ID": itemEvidence[i].PRODUCT_BRAND_ID,
            "PRODUCT_SUBBRAND_ID": itemEvidence[i].PRODUCT_SUBBRAND_ID,
            "PRODUCT_MODEL_ID": itemEvidence[i].PRODUCT_MODEL_ID,
            "PRODUCT_TAXDETAIL_ID": itemEvidence[i].PRODUCT_TAXDETAIL_ID,
            "PRODUCT_GROUP_CODE": itemEvidence[i].PRODUCT_GROUP_CODE == null ? "" : itemEvidence[i].PRODUCT_GROUP_CODE,
            "PRODUCT_GROUP_NAME": itemEvidence[i].PRODUCT_GROUP_NAME == null ? "" : itemEvidence[i].PRODUCT_GROUP_NAME,
            "PRODUCT_CATEGORY_CODE": itemEvidence[i].PRODUCT_CATEGORY_CODE == null ? "" : itemEvidence[i].PRODUCT_CATEGORY_CODE,
            "PRODUCT_CATEGORY_NAME": itemEvidence[i].PRODUCT_CATEGORY_NAME == null ? "" : itemEvidence[i].PRODUCT_CATEGORY_NAME,
            "PRODUCT_TYPE_CODE": itemEvidence[i].PRODUCT_TYPE_CODE == null ? "" : itemEvidence[i].PRODUCT_TYPE_CODE,
            "PRODUCT_TYPE_NAME": itemEvidence[i].PRODUCT_TYPE_NAME == null ? "" : itemEvidence[i].PRODUCT_TYPE_NAME,
            "PRODUCT_SUBTYPE_CODE": itemEvidence[i].PRODUCT_SUBTYPE_CODE == null ? "" : itemEvidence[i].PRODUCT_SUBTYPE_CODE,
            "PRODUCT_SUBTYPE_NAME": itemEvidence[i].PRODUCT_SUBTYPE_NAME == null ? "" : itemEvidence[i].PRODUCT_SUBTYPE_NAME,
            "PRODUCT_SUBSETTYPE_CODE": itemEvidence[i].PRODUCT_SUBSETTYPE_CODE == null ? "" : itemEvidence[i].PRODUCT_SUBSETTYPE_CODE,
            "PRODUCT_SUBSETTYPE_NAME": itemEvidence[i].PRODUCT_SUBSETTYPE_NAME == null ? "" : itemEvidence[i].PRODUCT_SUBSETTYPE_NAME,
            "PRODUCT_BRAND_CODE": itemEvidence[i].PRODUCT_BRAND_CODE == null ? "" : itemEvidence[i].PRODUCT_BRAND_CODE,
            "PRODUCT_BRAND_NAME_TH": itemEvidence[i].PRODUCT_BRAND_NAME_TH == null ? "" : itemEvidence[i].PRODUCT_BRAND_NAME_TH,
            "PRODUCT_BRAND_NAME_EN": itemEvidence[i].PRODUCT_BRAND_NAME_EN == null ? "" : itemEvidence[i].PRODUCT_BRAND_NAME_EN,
            "PRODUCT_SUBBRAND_CODE": itemEvidence[i].PRODUCT_SUBBRAND_CODE == null ? "" : itemEvidence[i].PRODUCT_SUBBRAND_CODE,
            "PRODUCT_SUBBRAND_NAME_TH": itemEvidence[i].PRODUCT_SUBBRAND_NAME_TH == null ? "" : itemEvidence[i].PRODUCT_SUBBRAND_NAME_TH,
            "PRODUCT_SUBBRAND_NAME_EN": itemEvidence[i].PRODUCT_SUBBRAND_NAME_EN == null ? "" : itemEvidence[i].PRODUCT_SUBBRAND_NAME_EN,
            "PRODUCT_MODEL_CODE": itemEvidence[i].PRODUCT_MODEL_CODE == null ? "" : itemEvidence[i].PRODUCT_MODEL_CODE,
            "PRODUCT_MODEL_NAME_TH": itemEvidence[i].PRODUCT_MODEL_NAME_TH == null ? "" : itemEvidence[i].PRODUCT_MODEL_NAME_TH,
            "PRODUCT_MODEL_NAME_EN": itemEvidence[i].PRODUCT_MODEL_NAME_EN == null ? "" : itemEvidence[i].PRODUCT_MODEL_NAME_EN,
            "LICENSE_PLATE": itemEvidence[i].LICENSE_PLATE,
            "ENGINE_NO": itemEvidence[i].ENGINE_NO,
            "CHASSIS_NO": itemEvidence[i].CHASSIS_NO,
            "PRODUCT_DESC": itemEvidence[i].PRODUCT_DESC,
            "SUGAR": itemEvidence[i].SUGAR,
            "CO2": itemEvidence[i].CO2,
            "DEGREE": itemEvidence[i].DEGREE,
            "PRICE": itemEvidence[i].PRICE,
            "DELIVERY_QTY": itemEvidence[i].DELIVERY_QTY,
            "DELIVERY_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
            "DELIVERY_SIZE": itemEvidence[i].DELIVERY_SIZE,
            "DELIVERY_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
            "DELIVERY_NET_VOLUMN": itemEvidence[i].DELIVERY_NET_VOLUMN,
            "DELIVERY_NET_VOLUMN_UNIT": itemEvidence[i].DELIVERY_NET_VOLUMN_UNIT,
            "DAMAGE_QTY": int.parse(itemEvidence[i].ItemsController.editDefectiveNumber.text),
            "DAMAGE_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
            "DAMAGE_SIZE": itemEvidence[i].DELIVERY_SIZE,
            "DAMAGE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
            "DAMAGE_NET_VOLUMN": double.parse(itemEvidence[i].ItemsController.editDefectiveVolumn.text),
            "DAMAGE_NET_VOLUMN_UNIT": itemEvidence[i].DELIVERY_NET_VOLUMN_UNIT,
            "IS_DOMESTIC": 0,
            "IS_ACTIVE": 1,
            "EvidenceOutStockBalance": [
              {
                "STOCK_ID": STOCK_ID,
                "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID,
                "EVIDENCE_IN_ITEM_ID": itemMain.EVIDENCE_IN_ID,
                "RECEIVE_QTY": itemEvidence[i].ItemsController.editTotalNumber.text,
                "RECEIVE_QTY_UNIT": itemEvidence[i].ItemsController.editTotalNumberUnit.text,
                "RECEIVE_SIZE": itemEvidence[i].DELIVERY_SIZE,
                "RECEIVE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
                "RECEIVE_NET_VOLUMN": itemEvidence[i].ItemsController.editTotalVolumn.text,
                "RECEIVE_NET_VOLUMN_UNIT": /*itemEvidence[i].ItemsController.editTotalVolumnUnit.text*/ itemEvidence[i].DELIVERY_SIZE_UNIT,
                "BALANCE_QTY": itemEvidence[i].DELIVERY_QTY,
                "BALANCE_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
                "BALANCE_SIZE": itemEvidence[i].DELIVERY_SIZE,
                "BALANCE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
                "BALANCE_NET_VOLUMN": itemEvidence[i].ItemsController.editTotalVolumn.text,
                "BALANCE_NET_VOLUMN_UNIT": /*itemEvidence[i].ItemsController.editTotalVolumnUnit.text*/ itemEvidence[i].DELIVERY_SIZE_UNIT,
                "IS_FINISH": 2,
                "IS_RECEIVE": 1
              }
            ]
          });
        }
      }
    } else {
      for (int i = 0; i < itemEvidence.length; i++) {
        if (IsUpdate) {
          print("this recieve in : " + itemMain.IS_RECEIVE.toString() + ", " + transec[i]);

          items.add({
            "EVIDENCE_IN_ITEM_ID": /*itemEvidence[i].EVIDENCE_IN_ITEM_ID*/ "",
            "EVIDENCE_IN_ITEM_CODE": itemMain.IS_RECEIVE == 1 ? itemEvidence[i].EVIDENCE_IN_ITEM_CODE : transec[i],
            "EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID,
            "PRODUCT_MAPPING_ID": itemEvidence[i].PRODUCT_MAPPING_ID,
            "PRODUCT_CODE": itemEvidence[i].PRODUCT_CODE == null ? "" : itemEvidence[i].PRODUCT_CODE,
            "PRODUCT_REF_CODE": itemEvidence[i].PRODUCT_REF_CODE == null ? "" : itemEvidence[i].PRODUCT_REF_CODE,
            "PRODUCT_GROUP_ID": itemEvidence[i].PRODUCT_GROUP_ID,
            "PRODUCT_CATEGORY_ID": itemEvidence[i].PRODUCT_CATEGORY_ID,
            "PRODUCT_TYPE_ID": itemEvidence[i].PRODUCT_TYPE_ID,
            "PRODUCT_SUBTYPE_ID": itemEvidence[i].PRODUCT_SUBTYPE_ID,
            "PRODUCT_SUBSETTYPE_ID": itemEvidence[i].PRODUCT_SUBSETTYPE_ID,
            "PRODUCT_BRAND_ID": itemEvidence[i].PRODUCT_BRAND_ID,
            "PRODUCT_SUBBRAND_ID": itemEvidence[i].PRODUCT_SUBBRAND_ID,
            "PRODUCT_MODEL_ID": itemEvidence[i].PRODUCT_MODEL_ID,
            "PRODUCT_TAXDETAIL_ID": itemEvidence[i].PRODUCT_TAXDETAIL_ID,
            "PRODUCT_GROUP_CODE": itemEvidence[i].PRODUCT_GROUP_CODE == null ? "" : itemEvidence[i].PRODUCT_GROUP_CODE,
            "PRODUCT_GROUP_NAME": itemEvidence[i].PRODUCT_GROUP_NAME == null ? "" : itemEvidence[i].PRODUCT_GROUP_NAME,
            "PRODUCT_CATEGORY_CODE": itemEvidence[i].PRODUCT_CATEGORY_CODE == null ? "" : itemEvidence[i].PRODUCT_CATEGORY_CODE,
            "PRODUCT_CATEGORY_NAME": itemEvidence[i].PRODUCT_CATEGORY_NAME == null ? "" : itemEvidence[i].PRODUCT_CATEGORY_NAME,
            "PRODUCT_TYPE_CODE": itemEvidence[i].PRODUCT_TYPE_CODE == null ? "" : itemEvidence[i].PRODUCT_TYPE_CODE,
            "PRODUCT_TYPE_NAME": itemEvidence[i].PRODUCT_TYPE_NAME == null ? "" : itemEvidence[i].PRODUCT_TYPE_NAME,
            "PRODUCT_SUBTYPE_CODE": itemEvidence[i].PRODUCT_SUBTYPE_CODE == null ? "" : itemEvidence[i].PRODUCT_SUBTYPE_CODE,
            "PRODUCT_SUBTYPE_NAME": itemEvidence[i].PRODUCT_SUBTYPE_NAME == null ? "" : itemEvidence[i].PRODUCT_SUBTYPE_NAME,
            "PRODUCT_SUBSETTYPE_CODE": itemEvidence[i].PRODUCT_SUBSETTYPE_CODE == null ? "" : itemEvidence[i].PRODUCT_SUBSETTYPE_CODE,
            "PRODUCT_SUBSETTYPE_NAME": itemEvidence[i].PRODUCT_SUBSETTYPE_NAME == null ? "" : itemEvidence[i].PRODUCT_SUBSETTYPE_NAME,
            "PRODUCT_BRAND_CODE": itemEvidence[i].PRODUCT_BRAND_CODE == null ? "" : itemEvidence[i].PRODUCT_BRAND_CODE,
            "PRODUCT_BRAND_NAME_TH": itemEvidence[i].PRODUCT_BRAND_NAME_TH == null ? "" : itemEvidence[i].PRODUCT_BRAND_NAME_TH,
            "PRODUCT_BRAND_NAME_EN": itemEvidence[i].PRODUCT_BRAND_NAME_EN == null ? "" : itemEvidence[i].PRODUCT_BRAND_NAME_EN,
            "PRODUCT_SUBBRAND_CODE": itemEvidence[i].PRODUCT_SUBBRAND_CODE == null ? "" : itemEvidence[i].PRODUCT_SUBBRAND_CODE,
            "PRODUCT_SUBBRAND_NAME_TH": itemEvidence[i].PRODUCT_SUBBRAND_NAME_TH == null ? "" : itemEvidence[i].PRODUCT_SUBBRAND_NAME_TH,
            "PRODUCT_SUBBRAND_NAME_EN": itemEvidence[i].PRODUCT_SUBBRAND_NAME_EN == null ? "" : itemEvidence[i].PRODUCT_SUBBRAND_NAME_EN,
            "PRODUCT_MODEL_CODE": itemEvidence[i].PRODUCT_MODEL_CODE == null ? "" : itemEvidence[i].PRODUCT_MODEL_CODE,
            "PRODUCT_MODEL_NAME_TH": itemEvidence[i].PRODUCT_MODEL_NAME_TH == null ? "" : itemEvidence[i].PRODUCT_MODEL_NAME_TH,
            "PRODUCT_MODEL_NAME_EN": itemEvidence[i].PRODUCT_MODEL_NAME_EN == null ? "" : itemEvidence[i].PRODUCT_MODEL_NAME_EN,
            "LICENSE_PLATE": itemEvidence[i].LICENSE_PLATE,
            "ENGINE_NO": itemEvidence[i].ENGINE_NO,
            "CHASSIS_NO": itemEvidence[i].CHASSIS_NO,
            "PRODUCT_DESC": itemEvidence[i].PRODUCT_DESC,
            "SUGAR": itemEvidence[i].SUGAR,
            "CO2": itemEvidence[i].CO2,
            "DEGREE": itemEvidence[i].DEGREE,
            "PRICE": itemEvidence[i].PRICE,
            "DELIVERY_QTY": itemEvidence[i].DELIVERY_QTY,
            "DELIVERY_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
            "DELIVERY_SIZE": itemEvidence[i].DELIVERY_SIZE,
            "DELIVERY_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
            "DELIVERY_NET_VOLUMN": itemEvidence[i].DELIVERY_NET_VOLUMN,
            "DELIVERY_NET_VOLUMN_UNIT": itemEvidence[i].DELIVERY_NET_VOLUMN_UNIT,
            "DAMAGE_QTY": /*double.parse(
                itemEvidence[i].ItemsController.editDefectiveNumber.text)*/
                itemEvidence[i].ItemsController.editDefectiveNumber.text,
            "DAMAGE_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
            "DAMAGE_SIZE": itemEvidence[i].DELIVERY_SIZE,
            "DAMAGE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
            "DAMAGE_NET_VOLUMN": /*double.parse(
                itemEvidence[i].ItemsController.editDefectiveVolumn.text)*/
                itemEvidence[i].ItemsController.editDefectiveVolumn.text,
            "DAMAGE_NET_VOLUMN_UNIT": itemEvidence[i].DELIVERY_NET_VOLUMN_UNIT,
            "IS_DOMESTIC": 0,
            "IS_ACTIVE": 1,
            "EvidenceOutStockBalance": [
              {
                "STOCK_ID": "",
                "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID,
                "EVIDENCE_IN_ITEM_ID": itemMain.EVIDENCE_IN_ID,
                "RECEIVE_QTY": itemEvidence[i].ItemsController.editTotalNumber.text,
                "RECEIVE_QTY_UNIT": itemEvidence[i].ItemsController.editTotalNumberUnit.text,
                "RECEIVE_SIZE": itemEvidence[i].DELIVERY_SIZE,
                "RECEIVE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
                "RECEIVE_NET_VOLUMN": itemEvidence[i].ItemsController.editTotalVolumn.text,
                "RECEIVE_NET_VOLUMN_UNIT": /*itemEvidence[i].ItemsController.editTotalVolumnUnit.text*/ itemEvidence[i].DELIVERY_SIZE_UNIT,
                "BALANCE_QTY": itemEvidence[i].DELIVERY_QTY,
                "BALANCE_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
                "BALANCE_SIZE": itemEvidence[i].DELIVERY_SIZE,
                "BALANCE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
                "BALANCE_NET_VOLUMN": itemEvidence[i].ItemsController.editTotalVolumn.text,
                "BALANCE_NET_VOLUMN_UNIT": /*itemEvidence[i].ItemsController.editTotalVolumnUnit.text*/ itemEvidence[i].DELIVERY_SIZE_UNIT,
                "IS_FINISH": 2,
                "IS_RECEIVE": 1
              }
            ]
          });
        } else {
          items.add({
            "EVIDENCE_IN_ITEM_ID": "",
            "EVIDENCE_IN_ITEM_CODE": transec[i],
            "EVIDENCE_IN_ID": "",
            "PRODUCT_MAPPING_ID": "",
            "PRODUCT_CODE": itemEvidence[i].PRODUCT_CODE == null ? "" : itemEvidence[i].PRODUCT_CODE,
            "PRODUCT_REF_CODE": itemEvidence[i].PRODUCT_REF_CODE == null ? "" : itemEvidence[i].PRODUCT_REF_CODE,
            "PRODUCT_GROUP_ID": itemEvidence[i].PRODUCT_GROUP_ID,
            "PRODUCT_CATEGORY_ID": itemEvidence[i].PRODUCT_CATEGORY_ID,
            "PRODUCT_TYPE_ID": itemEvidence[i].PRODUCT_TYPE_ID,
            "PRODUCT_SUBTYPE_ID": itemEvidence[i].PRODUCT_SUBTYPE_ID,
            "PRODUCT_SUBSETTYPE_ID": itemEvidence[i].PRODUCT_SUBSETTYPE_ID,
            "PRODUCT_BRAND_ID": itemEvidence[i].PRODUCT_BRAND_ID,
            "PRODUCT_SUBBRAND_ID": itemEvidence[i].PRODUCT_SUBBRAND_ID,
            "PRODUCT_MODEL_ID": itemEvidence[i].PRODUCT_MODEL_ID,
            "PRODUCT_TAXDETAIL_ID": itemEvidence[i].PRODUCT_TAXDETAIL_ID,
            "PRODUCT_GROUP_CODE": itemEvidence[i].PRODUCT_GROUP_CODE == null ? "" : itemEvidence[i].PRODUCT_GROUP_CODE,
            "PRODUCT_GROUP_NAME": itemEvidence[i].PRODUCT_GROUP_NAME == null ? "" : itemEvidence[i].PRODUCT_GROUP_NAME,
            "PRODUCT_CATEGORY_CODE": itemEvidence[i].PRODUCT_CATEGORY_CODE == null ? "" : itemEvidence[i].PRODUCT_CATEGORY_CODE,
            "PRODUCT_CATEGORY_NAME": itemEvidence[i].PRODUCT_CATEGORY_NAME == null ? "" : itemEvidence[i].PRODUCT_CATEGORY_NAME,
            "PRODUCT_TYPE_CODE": itemEvidence[i].PRODUCT_TYPE_CODE == null ? "" : itemEvidence[i].PRODUCT_TYPE_CODE,
            "PRODUCT_TYPE_NAME": itemEvidence[i].PRODUCT_TYPE_NAME == null ? "" : itemEvidence[i].PRODUCT_TYPE_NAME,
            "PRODUCT_SUBTYPE_CODE": itemEvidence[i].PRODUCT_SUBTYPE_CODE == null ? "" : itemEvidence[i].PRODUCT_SUBTYPE_CODE,
            "PRODUCT_SUBTYPE_NAME": itemEvidence[i].PRODUCT_SUBTYPE_NAME == null ? "" : itemEvidence[i].PRODUCT_SUBTYPE_NAME,
            "PRODUCT_SUBSETTYPE_CODE": itemEvidence[i].PRODUCT_SUBSETTYPE_CODE == null ? "" : itemEvidence[i].PRODUCT_SUBSETTYPE_CODE,
            "PRODUCT_SUBSETTYPE_NAME": itemEvidence[i].PRODUCT_SUBSETTYPE_NAME == null ? "" : itemEvidence[i].PRODUCT_SUBSETTYPE_NAME,
            "PRODUCT_BRAND_CODE": itemEvidence[i].PRODUCT_BRAND_CODE == null ? "" : itemEvidence[i].PRODUCT_BRAND_CODE,
            "PRODUCT_BRAND_NAME_TH": itemEvidence[i].PRODUCT_BRAND_NAME_TH == null ? "" : itemEvidence[i].PRODUCT_BRAND_NAME_TH,
            "PRODUCT_BRAND_NAME_EN": itemEvidence[i].PRODUCT_BRAND_NAME_EN == null ? "" : itemEvidence[i].PRODUCT_BRAND_NAME_EN,
            "PRODUCT_SUBBRAND_CODE": itemEvidence[i].PRODUCT_SUBBRAND_CODE == null ? "" : itemEvidence[i].PRODUCT_SUBBRAND_CODE,
            "PRODUCT_SUBBRAND_NAME_TH": itemEvidence[i].PRODUCT_SUBBRAND_NAME_TH == null ? "" : itemEvidence[i].PRODUCT_SUBBRAND_NAME_TH,
            "PRODUCT_SUBBRAND_NAME_EN": itemEvidence[i].PRODUCT_SUBBRAND_NAME_EN == null ? "" : itemEvidence[i].PRODUCT_SUBBRAND_NAME_EN,
            "PRODUCT_MODEL_CODE": itemEvidence[i].PRODUCT_MODEL_CODE == null ? "" : itemEvidence[i].PRODUCT_MODEL_CODE,
            "PRODUCT_MODEL_NAME_TH": itemEvidence[i].PRODUCT_MODEL_NAME_TH == null ? "" : itemEvidence[i].PRODUCT_MODEL_NAME_TH,
            "PRODUCT_MODEL_NAME_EN": itemEvidence[i].PRODUCT_MODEL_NAME_EN == null ? "" : itemEvidence[i].PRODUCT_MODEL_NAME_EN,
            "LICENSE_PLATE": itemEvidence[i].LICENSE_PLATE,
            "ENGINE_NO": itemEvidence[i].ENGINE_NO,
            "CHASSIS_NO": itemEvidence[i].CHASSIS_NO,
            "PRODUCT_DESC": itemEvidence[i].PRODUCT_DESC,
            "SUGAR": itemEvidence[i].SUGAR,
            "CO2": itemEvidence[i].CO2,
            "DEGREE": itemEvidence[i].DEGREE,
            "PRICE": itemEvidence[i].PRICE,
            "DELIVERY_QTY": itemEvidence[i].DELIVERY_QTY,
            "DELIVERY_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
            "DELIVERY_SIZE": itemEvidence[i].DELIVERY_SIZE,
            "DELIVERY_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
            "DELIVERY_NET_VOLUMN": itemEvidence[i].DELIVERY_NET_VOLUMN,
            "DELIVERY_NET_VOLUMN_UNIT": itemEvidence[i].DELIVERY_NET_VOLUMN_UNIT,
            "DAMAGE_QTY": int.parse(itemEvidence[i].ItemsController.editDefectiveNumber.text),
            "DAMAGE_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
            "DAMAGE_SIZE": itemEvidence[i].DELIVERY_SIZE,
            "DAMAGE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
            "DAMAGE_NET_VOLUMN": double.parse(itemEvidence[i].ItemsController.editDefectiveVolumn.text),
            "DAMAGE_NET_VOLUMN_UNIT": itemEvidence[i].DELIVERY_NET_VOLUMN_UNIT,
            "IS_DOMESTIC": 0,
            "IS_ACTIVE": 1,
            "EvidenceOutStockBalance": [
              {
                "STOCK_ID": "",
                "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID,
                "EVIDENCE_IN_ITEM_ID": "",
                "RECEIVE_QTY": itemEvidence[i].ItemsController.editTotalNumber.text,
                "RECEIVE_QTY_UNIT": itemEvidence[i].ItemsController.editTotalNumberUnit.text,
                "RECEIVE_SIZE": itemEvidence[i].DELIVERY_SIZE,
                "RECEIVE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
                "RECEIVE_NET_VOLUMN": itemEvidence[i].ItemsController.editTotalVolumn.text,
                "RECEIVE_NET_VOLUMN_UNIT": /*itemEvidence[i].ItemsController.editTotalVolumnUnit.text*/ itemEvidence[i].DELIVERY_SIZE_UNIT,
                "BALANCE_QTY": itemEvidence[i].DELIVERY_QTY,
                "BALANCE_QTY_UNIT": itemEvidence[i].DELIVERY_QTY_UNIT,
                "BALANCE_SIZE": itemEvidence[i].DELIVERY_SIZE,
                "BALANCE_SIZE_UNIT": itemEvidence[i].DELIVERY_SIZE_UNIT,
                "BALANCE_NET_VOLUMN": itemEvidence[i].ItemsController.editTotalVolumn.text,
                "BALANCE_NET_VOLUMN_UNIT": /*itemEvidence[i].ItemsController.editTotalVolumnUnit.text*/ itemEvidence[i].DELIVERY_SIZE_UNIT,
                "IS_FINISH": 2,
                "IS_RECEIVE": 1
              }
            ]
          });
        }
      }
    }

    return items;
  }

  Future<String> _transection_running() async {
    Map map_transec = {"RUNNING_TABLE": "OPS_EVIDENCE_IN", "RUNNING_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE};
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
        transection_no = "RC" + widget.ItemsPerson.OPERATION_OFFICE_CODE + date_auto + "00001";
      }
    });
    print("transection_no [1] : " + transection_no);
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
      Map map_tran_ins = {"RUNNING_OFFICE_ID": 30, "RUNNING_OFFICE_CODE": widget.ItemsPerson.OPERATION_OFFICE_CODE, "RUNNING_TABLE": "OPS_EVIDENCE_IN", "RUNNING_PREFIX": "RC"};
      print(map_tran_ins.toString());
      await new TransectionFuture().apiRequestTransactionRunninginsAll(map_tran_ins).then((onValue) {
        print("Insert Transection : " + onValue.Msg);
      });
    }
  }

  List<String> transec = [];
  Future<List<String>> _setTransecEvidenceItem(bool IsUpdate, List<ItemsEvidenceInItem> itemEvidence) async {
    List<String> transec = [];
    if (IsUpdate) {
      if (itemMain != null) {
        // set item code upd
        if (itemMain.IS_RECEIVE != 1) {
          for (int i = 0; i < itemEvidence.length; i++) {
            Map map_transec = {"RUNNING_PREFIX": "IN", "PRODUCT_GROUP_ID": itemEvidence[i].PRODUCT_GROUP_ID.toString(), "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID};
            await new TransectionFuture().apiRequestTransactionRunningItemgetByCon(map_transec).then((onValue) {
              _itemTransectionitem = onValue;
              print("_itemTransectionitem : " + _itemTransectionitem.length.toString());
              if (_itemTransectionitem.length != 0) {
                IsEvidenceItemCode = true;
                transection_item_no = (_itemTransectionitem.first.RUNNING_NO + 1).toString();
                if (transection_item_no.length != 5) {
                  String sum = "";
                  for (int i = 0; i < 5 - transection_item_no.length; i++) {
                    sum += "0";
                  }
                  transection_item_no = sum + transection_item_no;
                }
                String warehouse_no = "1";
                if (warehouse_no != 3) {
                  String sum = "";
                  for (int i = 0; i < 3 - warehouse_no.toString().length; i++) {
                    sum += "0";
                  }
                  warehouse_no = sum + warehouse_no;
                }
                String product_group_no = itemEvidence[i].PRODUCT_GROUP_ID.toString();
                if (product_group_no != 4) {
                  String sum = "";
                  for (int i = 0; i < 4 - product_group_no.toString().length; i++) {
                    sum += "0";
                  }
                  product_group_no = sum + product_group_no;
                }

                transection_item_no = /*_itemTransectionitem.last.RUNNING_PREFIX*/ "IN" + warehouse_no + product_group_no + _itemTransectionitem.last.RUNNING_YEAR + transection_item_no;
              } else {
                IsEvidenceItemCode = false;
                DateFormat format_auto = DateFormat("yyyy");
                String date_auto = (int.parse(format_auto.format(DateTime.now()).toString()) + 543).toString().substring(2);

                String warehouse_no = "1";
                if (warehouse_no != 3) {
                  String sum = "";
                  for (int i = 0; i < 3 - warehouse_no.toString().length; i++) {
                    sum += "0";
                  }
                  warehouse_no = sum + warehouse_no;
                }
                String product_group_no = itemEvidence[i].PRODUCT_GROUP_ID.toString();
                if (product_group_no != 4) {
                  String sum = "";
                  for (int i = 0; i < 4 - product_group_no.toString().length; i++) {
                    sum += "0";
                  }
                  product_group_no = sum + product_group_no;
                }

                transection_item_no = "IN" + warehouse_no + product_group_no + date_auto + "00001";
              }
            });
            print("transection_item_no : " + transection_item_no);
            transec.add(transection_item_no);

            //running evidence item
            if (IsEvidenceItemCode) {
              Map map_tran_up = {
                "RUNNING_ID": _itemTransectionitem.last.RUNNING_ID,
              };
              await new TransectionFuture().apiRequestTransactionRunningItemupdByCon(map_tran_up).then((onValue) {
                print("Update Transection Item : " + onValue.Msg);
              });
            } else {
              Map map_tran_ins = {"RUNNING_PREFIX": "IN", "PRODUCT_GROUP_ID": itemEvidence[i].PRODUCT_GROUP_ID.toString(), "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID};
              print(map_tran_ins.toString());
              await new TransectionFuture().apiRequestTransactionRunningIteminsAll(map_tran_ins).then((onValue) {
                print("Insert Transection Item : " + onValue.Msg);
              });
            }
          }
        }
      }
    } else {
      // set item code ins
      for (int i = 0; i < itemEvidence.length; i++) {
        Map map_transec = {"RUNNING_PREFIX": "IN", "PRODUCT_GROUP_ID": itemEvidence[i].PRODUCT_GROUP_ID.toString(), "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID};
        await new TransectionFuture().apiRequestTransactionRunningItemgetByCon(map_transec).then((onValue) {
          _itemTransectionitem = onValue;
          print("_itemTransectionitem : " + _itemTransectionitem.length.toString());
          if (_itemTransectionitem.length != 0) {
            IsEvidenceItemCode = true;
            transection_item_no = (_itemTransectionitem.first.RUNNING_NO + 1).toString();
            if (transection_item_no.length != 5) {
              String sum = "";
              for (int i = 0; i < 5 - transection_item_no.length; i++) {
                sum += "0";
              }
              transection_item_no = sum + transection_item_no;
            }
            String warehouse_no = "1";
            if (warehouse_no != 3) {
              String sum = "";
              for (int i = 0; i < 3 - warehouse_no.toString().length; i++) {
                sum += "0";
              }
              warehouse_no = sum + warehouse_no;
            }
            String product_group_no = itemEvidence[i].PRODUCT_GROUP_ID.toString();
            if (product_group_no != 4) {
              String sum = "";
              for (int i = 0; i < 4 - product_group_no.toString().length; i++) {
                sum += "0";
              }
              product_group_no = sum + product_group_no;
            }

            transection_item_no = /*_itemTransectionitem.last.RUNNING_PREFIX*/
                "IN" + warehouse_no + product_group_no + _itemTransectionitem.last.RUNNING_YEAR + transection_item_no;
          } else {
            IsEvidenceItemCode = false;
            DateFormat format_auto = DateFormat("yyyy");
            String date_auto = (int.parse(format_auto.format(DateTime.now()).toString()) + 543).toString().substring(2);

            String warehouse_no = "1";
            if (warehouse_no != 3) {
              String sum = "";
              for (int i = 0; i < 3 - warehouse_no.toString().length; i++) {
                sum += "0";
              }
              warehouse_no = sum + warehouse_no;
            }
            String product_group_no = itemEvidence[i].PRODUCT_GROUP_ID.toString();
            if (product_group_no != 4) {
              String sum = "";
              for (int i = 0; i < 4 - product_group_no.toString().length; i++) {
                sum += "0";
              }
              product_group_no = sum + product_group_no;
            }

            transection_item_no = "IN" + warehouse_no + product_group_no + date_auto + "00001";
          }
        });
        print("transection_item_no : " + transection_item_no);
        transec.add(transection_item_no);

        //running evidence item
        if (IsEvidenceItemCode) {
          Map map_tran_up = {
            "RUNNING_ID": _itemTransectionitem.last.RUNNING_ID,
          };
          await new TransectionFuture().apiRequestTransactionRunningItemupdByCon(map_tran_up).then((onValue) {
            print("Update Transection Item : " + onValue.Msg);
          });
        } else {
          Map map_tran_ins = {"RUNNING_PREFIX": "IN", "PRODUCT_GROUP_ID": itemEvidence[i].PRODUCT_GROUP_ID.toString(), "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID};
          print(map_tran_ins.toString());
          await new TransectionFuture().apiRequestTransactionRunningIteminsAll(map_tran_ins).then((onValue) {
            print("Insert Transection Item : " + onValue.Msg);
          });
        }
      }
    }

    return transec;
  }

  List<ItemsListTransection> _itemTransection = [];
  List<ItemsListTransectionItem> _itemTransectionitem = [];
  String transection_no, transection_item_no;
  bool IsEvidenceCode, IsEvidenceItemCode;

  Future<bool> onLoadActionEvidenceInsAll(int EVIDENCE_IN_TYPE) async {
    String tran_evidence_no;
    await _transection_running().then((s) {
      print("report : " + s);
      tran_evidence_no = s;
    });

    List tran_item = [];
    await _setTransecEvidenceItem(false, itemEvidence).then((on) {
      tran_item = on;
    });
    print("_setTransecEvidenceItem : " + tran_item.length.toString());

    Map map_evidence;
    /*= {
        "EVIDENCE_IN_ID": "",
        "PROVE_ID": "",
        "EVIDENCE_IN_CODE": tran_evidence_no,
        "EVIDENCE_IN_DATE": DateTime.now().toString(),
        "RETURN_DATE": "",
        "IS_RECEIVE": 1,
        "DELIVERY_NO": editCheckEvidenceNumber.text,
        "DELIVERY_DATE": DateTime.now().toString(),
        "EVIDENCE_IN_TYPE": EVIDENCE_IN_TYPE,
        "REMARK": editCheckEvidenceComment.text,
        "IS_ACTIVE": 1,
        "IS_EDIT": 1,
        "EvidenceInItem": _createMapEvidenceItem(false, tran_item),
        "EvidenceInStaff": _createMapStaff(false, 13,[13])
      };*/
    if (EVIDENCE_IN_TYPE == 0) {
      map_evidence = {
        "EVIDENCE_IN_ID": "",
        "PROVE_ID": itemsEvidenceArrest.PROVE_ID,
        "EVIDENCE_IN_CODE": transection_no,
        "EVIDENCE_IN_DATE": DateTime.now().toString(),
        "RETURN_DATE": "",
        "IS_RECEIVE": 1,
        "DELIVERY_NO": "กค." + editDeriveredNumber.text + "/" + editDeriveredYear.text,
        "DELIVERY_DATE": _deriveredDate.toString(),
        "EVIDENCE_IN_TYPE": 0,
        "REMARK": editDeriveredTransport.text,
        "IS_ACTIVE": 1,
        "IS_EDIT": 1,
        "EvidenceInItem": _createMapEvidenceItem(false, tran_item),
        "EvidenceInStaff": _createMapStaff(false, 59, [59])
      };
    } else if (EVIDENCE_IN_TYPE == 3) {
      map_evidence = {
        "EVIDENCE_IN_ID": "",
        "PROVE_ID": "",
        "EVIDENCE_IN_CODE": transection_no,
        "EVIDENCE_IN_DATE": DateTime.now().toString(),
        "RETURN_DATE": _dtReturn != null ? _dtReturn.toString() : "",
        "IS_RECEIVE": 1,
        "DELIVERY_NO": editCheckEvidenceNumber.text,
        "DELIVERY_DATE": _deriveredDate.toString(),
        "EVIDENCE_IN_TYPE": 1,
        "REMARK": editCheckEvidenceComment.text,
        "IS_ACTIVE": 1,
        "IS_EDIT": 1,
        "EvidenceInItem": _createMapEvidenceItem(false, tran_item),
        "EvidenceInStaff": _createMapStaff(false, 59, [59])
      };
    } else if (EVIDENCE_IN_TYPE == 4) {
      map_evidence = {
        "EVIDENCE_IN_ID": "",
        "PROVE_ID": "",
        "EVIDENCE_IN_CODE": transection_no,
        "EVIDENCE_IN_DATE": DateTime.now().toString(),
        "RETURN_DATE": "",
        "IS_RECEIVE": 1,
        "DELIVERY_NO": editCheckEvidenceNumber.text,
        "DELIVERY_DATE": _deriveredDate.toString(),
        "EVIDENCE_IN_TYPE": 2,
        "REMARK": editCheckEvidenceComment.text,
        "IS_ACTIVE": 1,
        "IS_EDIT": 1,
        "EvidenceInItem": _createMapEvidenceItem(false, tran_item),
        "EvidenceInStaff": _createMapStaff(false, 59, [59])
      };
    }

    int EVIDENCE_IN_ID;
    await new CheckEvidenceFuture().apiRequestEvidenceIninsAll(map_evidence).then((onValue) {
      EVIDENCE_IN_ID = onValue.EVIDENCE_IN_ID;
      print("Insert EvidenceIn :" + onValue.Msg.toString());
      print(onValue.EVIDENCE_IN_ID.toString());
    });

    _transection_update();

    //getByCon
    if (EVIDENCE_IN_ID != null) {
      Map map_con = {"EVIDENCE_IN_ID": EVIDENCE_IN_ID, "PROVE_ID": IsReceiveProve ? itemsEvidenceArrest.PROVE_ID : ""};
      await new CheckEvidenceFuture().apiRequestEvidenceIngetByCon(map_con).then((onValue) {
        if (onValue != null) {
          itemMain = onValue;
          itemEvidence = itemMain.EvidenceInItem;
        } else {
          //error
        }
      });

      List<Map> _arrJsonImg = [];
      int index = 0;
      _arrItemsImageFile.forEach((_file) {
        String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
        index++;
        _arrJsonImg.add({
          "DATA_SOURCE": "",
          "DOCUMENT_ID": "",
          "DOCUMENT_NAME": itemMain.EVIDENCE_IN_CODE + "_" + index.toString(),
          "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
          "DOCUMENT_TYPE": "11",
          "FILE_TYPE": "jpg",
          "FOLDER": "product",
          "IS_ACTIVE": "1",
          "REFERENCE_CODE": itemMain.EVIDENCE_IN_ID,
          "CONTENT": base64Image
        });
      });

      for (int i = 0; i < _arrJsonImg.length; i++) {
        await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i], _arrItemsImageFile[i].FILE_CONTENT).then((onValue) {
          print("[" + i.toString() + "] : " + onValue.DOCUMENT_ID.toString());
        });
      }
    }

    if (itemMain != null) {
      Map map = {"DOCUMENT_TYPE": 11, "REFERENCE_CODE": itemMain.EVIDENCE_IN_ID};
      await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
        List<ItemsListDocument> items = [];
        onValue.forEach((f) {
          File _file = new File(f.DOCUMENT_OLD_NAME);
          items.add(new ItemsListDocument(
            DOCUMENT_ID: f.DOCUMENT_ID,
            REFERENCE_CODE: f.REFERENCE_CODE,
            FILE_PATH: f.FILE_PATH,
            DATA_SOURCE: f.DATA_SOURCE,
            DOCUMENT_TYPE: f.DOCUMENT_TYPE,
            DOCUMENT_NAME: f.DOCUMENT_NAME,
            IS_ACTIVE: f.IS_ACTIVE,
            DOCUMENT_OLD_NAME: f.DOCUMENT_OLD_NAME,
            CONTENT: f.CONTENT,
            FILE_TYPE: f.FILE_TYPE,
            FOLDER: f.FOLDER,
            FILE_CONTENT: _file,
          ));
        });
        _arrItemsImageFile = items;
        setState(() {});
      });
    }

    //update transection
    List<Map> map_balance = [];
    itemEvidence.forEach((item) {
      map_balance.add({
        "STOCK_ID": "4", //hard_code
        "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID, //hard_code
        "EVIDENCE_IN_ITEM_ID": item.EVIDENCE_IN_ITEM_ID,
        "RECEIVE_QTY": item.ItemsController.editTotalNumber.text,
        "RECEIVE_QTY_UNIT": item.ItemsController.editTotalNumberUnit.text,
        "RECEIVE_NET_VOLUMN": item.ItemsController.editTotalVolumn.text,
        "RECEIVE_NET_VOLUMN_UNIT": item.ItemsController.editTotalVolumnUnit.text,
        "IS_FINISH": 2,
        "IS_RECEIVE": 1
      });
    });

    /*//update Balance Stock
    await new CheckEvidenceFuture()
        .apiRequestEvidenceInStockBalanceupdByCon(map_balance)
        .then((onValue) {
      print("Update Balance Stock : "+onValue.Msg);
    });*/

    itemsListEvidenceStaff = [];
    //เมื่อกดบันทึก
    _onSaved = true;
    _onFinish = true;
    //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
    _setDataSaved();

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionEvidenceUpdAll() async {
    String tran_evidence_no;
    await _transection_running().then((s) {
      tran_evidence_no = s;
    });

    //running item code
    List tran_item = [];
    if (_onEdited) {
      await _setTransecEvidenceItem(false, list_add_evidence_item).then((on) {
        tran_item = on;
      });
    } else {
      await _setTransecEvidenceItem(false, itemEvidence).then((on) {
        tran_item = on;
      });
    }

    Map map_evidence;
    if (widget.EVIDENCE_TYPE == 0) {
      map_evidence = {
        "EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID,
        "PROVE_ID": itemMain.PROVE_ID,
        "EVIDENCE_IN_CODE": itemMain.IS_RECEIVE == 0 ? transection_no : itemMain.EVIDENCE_IN_CODE,
        "EVIDENCE_IN_DATE": itemMain.IS_RECEIVE == 0 ? DateTime.now().toString() : transection_no,
        "RETURN_DATE": "",
        "IS_RECEIVE": 1,
        "DELIVERY_NO": "กค." + editDeriveredNumber.text + "/" + editDeriveredYear.text,
        "DELIVERY_DATE": _deriveredDate.toString(),
        "EVIDENCE_IN_TYPE": itemMain.EVIDENCE_IN_TYPE,
        "REMARK": editDeriveredTransport.text,
        "IS_ACTIVE": 1,
        "IS_EDIT": 1,
        /*"EvidenceInItem": _createMapEvidenceItem(true, tran_item),*/
        /*"EvidenceInStaff": _createMapStaff(true, 59,[])*/
      };
    } else if (widget.EVIDENCE_TYPE == 3) {
      map_evidence = {
        "EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID,
        "PROVE_ID": "",
        "EVIDENCE_IN_CODE": itemMain.EVIDENCE_IN_CODE,
        "EVIDENCE_IN_DATE": itemMain.EVIDENCE_IN_DATE,
        "RETURN_DATE": _dtReturn != null ? _dtReturn.toString() : "",
        "IS_RECEIVE": 1,
        "DELIVERY_NO": editCheckEvidenceNumber.text,
        "DELIVERY_DATE": _deriveredDate.toString(),
        "EVIDENCE_IN_TYPE": 1,
        "REMARK": editCheckEvidenceComment.text,
        "IS_ACTIVE": 1,
        "IS_EDIT": 1,
        "EvidenceInItem": _createMapEvidenceItem(false, tran_item),
        "EvidenceInStaff": _createMapStaff(false, 59, [59])
      };
    } else if (widget.EVIDENCE_TYPE == 4) {
      map_evidence = {
        "EVIDENCE_IN_ID": "",
        "PROVE_ID": "",
        "EVIDENCE_IN_CODE": transection_no,
        "EVIDENCE_IN_DATE": DateTime.now().toString(),
        "RETURN_DATE": "",
        "IS_RECEIVE": 1,
        "DELIVERY_NO": editCheckEvidenceNumber.text,
        "DELIVERY_DATE": _deriveredDate.toString(),
        "EVIDENCE_IN_TYPE": 2,
        "REMARK": editCheckEvidenceComment.text,
        "IS_ACTIVE": 1,
        "IS_EDIT": 1,
        "EvidenceInItem": _createMapEvidenceItem(false, tran_item),
        "EvidenceInStaff": _createMapStaff(false, 59, [59])
      };
    }

    //รับของกลาง
    if (itemMain.IS_RECEIVE == 0) {
      await new CheckEvidenceFuture().apiRequestEvidenceInIteminsAll(_createMapEvidenceItem(true, tran_item)).then((onValue) {
        print("Add Upd EvidenceInItem :" + onValue.Msg.toString());
      });

      //update running
      _transection_update();
    }

    //update
    await new CheckEvidenceFuture().apiRequestEvidenceInupdByCon(map_evidence).then((onValue) {
      print("Update EvidenceIn : " + onValue.Msg.toString());
    });

    //แก้ไข staff
    if (_onEdited) {
      //กรณีเพิ่ม staff มาทีหลัง

      //เรียกเพื่อ check bool ว่ามีการเพิ่ม staff หรือไม่
      _createMapStaff(true, null, []);

      if (IsCreateStaff) {
        print("_createMapStaff : " + _createMapStaff(true, null, []).length.toString());
        await new CheckEvidenceFuture().apiRequestEvidenceInStaffinsAll(_createMapStaff(true, null, [])).then((onValue) {
          print("Upd Add EvidenceInStaff : " + onValue.Msg.toString());
        });
      } else {
        print("_createMapStaff : " + _createMapStaff(true, null, []).length.toString());
        await new CheckEvidenceFuture().apiRequestEvidenceInStaffupdByCon(_createMapStaff(true, null, [])).then((onValue) {
          print("Upd EvidenceInStaff : " + onValue.Msg.toString());
        });
      }
    } else {
      //เพิ่ม staff
      print("_createMapStaff : " + _createMapStaff(true, null, []).length.toString());
      await new CheckEvidenceFuture().apiRequestEvidenceInStaffinsAll(_createMapStaff(true, null, [])).then((onValue) {
        print("Ins EvidenceInStaff : " + onValue.Msg.toString());
      });
    }

    print("EVIDENCE_IN_ID : " + itemMain.EVIDENCE_IN_ID.toString());
    print("PROVE_ID : " + itemMain.PROVE_ID.toString());

    await new CheckEvidenceFuture().apiRequestEvidenceInItemupdByCon(_createMapEvidenceItem(true, tran_item)).then((onValue) {
      print("Update EvidenceInItem :" + onValue.Msg.toString());
    });

    //Delete
    List<Map> map_del_item = [];
    list_del_evidence_item.forEach((item) {
      map_del_item.add({"EVIDENCE_IN_ITEM_ID": item.EVIDENCE_IN_ITEM_ID});
    });
    if (map_del_item.length > 0) {
      await new CheckEvidenceFuture().apiRequestEvidenceInItemupdDelete(map_del_item).then((onValue) {
        print("Up Delete Evidence Item : " + onValue.Msg);
      });
    }
    //Insert
    /*List tran_item = [];
    await _setTransecEvidenceItem(false,itemEvidence).then((on){
      tran_item = on;
    });*/

    if (list_add_evidence_item.length > 0) {
      await new CheckEvidenceFuture().apiRequestEvidenceInIteminsAll(_createMapEvidenceItem(false, tran_item)).then((onValue) {
        print("Add EvidenceInItem :" + onValue.Msg.toString());
      });
    }

    //update transection
    List<Map> map_balance = [];
    itemEvidence.forEach((item) {
      map_balance.add({
        "STOCK_ID": "4", //hard_code
        "WAREHOUSE_ID": dropdownValueStock.WAREHOUSE_ID, //hard_code
        "EVIDENCE_IN_ITEM_ID": item.EVIDENCE_IN_ITEM_ID,
        "RECEIVE_QTY": item.ItemsController.editTotalNumber.text,
        "RECEIVE_QTY_UNIT": item.ItemsController.editTotalNumberUnit.text,
        "RECEIVE_NET_VOLUMN": item.ItemsController.editTotalVolumn.text,
        "RECEIVE_NET_VOLUMN_UNIT": item.ItemsController.editTotalVolumnUnit.text,
        "IS_FINISH": 2,
        "IS_RECEIVE": 1
      });
    });
    /*//update Balance Stock
    await new CheckEvidenceFuture()
        .apiRequestEvidenceInStockBalanceupdByCon(map_balance)
        .then((onValue) {
          print("Update Balance Stock : "+onValue.Msg);
    });*/

    for (int i = 0; i < _arrItemsImageFileDelete.length; i++) {
      Map map = {"DOCUMENT_ID": _arrItemsImageFileDelete[i]};
      print(map);
      await new TransectionFuture().apiRequestDocumentupdDelete(map).then((onValue) {
        print("Delete [" + i.toString() + "] : " + onValue.Msg.toString());
      });
    }

    if (itemMain.IS_RECEIVE == 0) {
      List<Map> _arrJsonImg = [];
      int index = 0;
      _arrItemsImageFile.forEach((_file) {
        String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
        index++;
        _arrJsonImg.add({
          "DATA_SOURCE": "",
          "DOCUMENT_ID": "",
          "DOCUMENT_NAME": transection_no + "_" + index.toString(),
          "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
          "DOCUMENT_TYPE": "11",
          "FILE_TYPE": "jpg",
          "FOLDER": "product",
          "IS_ACTIVE": "1",
          "REFERENCE_CODE": itemMain.EVIDENCE_IN_ID,
          "CONTENT": base64Image
        });
      });

      for (int i = 0; i < _arrJsonImg.length; i++) {
        await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i], _arrItemsImageFile[i].FILE_CONTENT).then((onValue) {
          print("[" + i.toString() + "] : " + onValue.DOCUMENT_ID.toString());
        });
      }
    } else {
      print("Update Doc");
      List<Map> _arrJsonImg = [];
      int index = _arrItemsImageFile.length;
      _arrItemsImageFileAdd.forEach((_file) {
        String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
        index++;
        _arrJsonImg.add({
          "DATA_SOURCE": "",
          "DOCUMENT_ID": "",
          "DOCUMENT_NAME": itemMain.EVIDENCE_IN_CODE + "_" + index.toString(),
          "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
          "DOCUMENT_TYPE": "11",
          "FILE_TYPE": "jpg",
          "FOLDER": "product",
          "IS_ACTIVE": "1",
          "REFERENCE_CODE": itemMain.EVIDENCE_IN_ID,
          "CONTENT": base64Image
        });
      });
      for (int i = 0; i < _arrJsonImg.length; i++) {
        await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i], _arrItemsImageFileAdd[i].FILE_CONTENT).then((onValue) {
          print("Update Add [" + i.toString() + "] : " + onValue.DOCUMENT_ID.toString());
        });
      }
    }

    //getByCon
    Map map_con = {"EVIDENCE_IN_ID": itemMain.EVIDENCE_IN_ID, "PROVE_ID": itemMain.PROVE_ID};
    await new CheckEvidenceFuture().apiRequestEvidenceIngetByCon(map_con).then((onValue) {
      itemMain = onValue;
      itemEvidence = itemMain.EvidenceInItem;
    });

    Map map = {"DOCUMENT_TYPE": 11, "REFERENCE_CODE": itemMain.EVIDENCE_IN_ID};
    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((f) {
        File _file = new File(f.DOCUMENT_OLD_NAME);
        items.add(new ItemsListDocument(
          DOCUMENT_ID: f.DOCUMENT_ID,
          REFERENCE_CODE: f.REFERENCE_CODE,
          FILE_PATH: f.FILE_PATH,
          DATA_SOURCE: f.DATA_SOURCE,
          DOCUMENT_TYPE: f.DOCUMENT_TYPE,
          DOCUMENT_NAME: f.DOCUMENT_NAME,
          IS_ACTIVE: f.IS_ACTIVE,
          DOCUMENT_OLD_NAME: f.DOCUMENT_OLD_NAME,
          CONTENT: f.CONTENT,
          FILE_TYPE: f.FILE_TYPE,
          FOLDER: f.FOLDER,
          FILE_CONTENT: _file,
        ));
      });
      _arrItemsImageFile = items;
      setState(() {});
    });

    IsCreateStaff = false;

    list_add_evidence_item = [];
    list_del_evidence_item = [];
    itemsListEvidenceStaff = [];

    _arrItemsImageFileDelete = [];
    _arrItemsImageFileAdd = [];
    //เมื่อกดบันทึก
    _onSaved = true;
    _onFinish = true;
    _onEdited = false;
    //ให้ไปที่ tab แบบฟอร์มตอนกดบันทึก
    _setDataSaved();

    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final List<Widget> rowContents = <Widget>[
      new SizedBox(
          width: width / 4,
          child: new Center(
            child: new FlatButton(
              onPressed: () {
                /* _onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :*/
                if (_onSaved) {
                  Navigator.pop(context, "Back");
                } else {
                  _showCancelAlertDialog(context);
                }
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
            ),
          )),
      Expanded(
          child: Center(
        child: Text("", style: appBarStyle),
      )),
      new SizedBox(
          width: width / 4,
          child: new Row(
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
          ))
    ];

    List<Widget> _tabs = [];
    if (widget.EVIDENCE_TYPE == 0) {
      //ภายใน
      if (_onFinish) {
        _tabs = <Widget>[
          _buildContent_tab_1(),
          //เพิ่มมา ^^
          _buildContent_tab_2(),
          _buildContent_tab_infor(),
          _buildContent_tab_3(),
        ];
      } else {
        _tabs = <Widget>[
          _buildContent_tab_1(),
          //เพิ่มมา ^^
          _buildContent_tab_2(),
          _buildContent_tab_infor(),
        ];
      }
    } else if (widget.EVIDENCE_TYPE == 1) {
      //ภายนอก
      if (_onFinish) {
        _tabs = <Widget>[
          _buildContent_tab_1(),
          _buildContent_tab_2(),
          _buildContent_tab_3(),
        ];
      } else {
        _tabs = <Widget>[
          _buildContent_tab_1(),
          _buildContent_tab_2(),
        ];
      }
    } else if (widget.EVIDENCE_TYPE == 2) {
      //นำออก
    } else if (widget.EVIDENCE_TYPE == 3 || widget.EVIDENCE_TYPE == 4) {
      if (_onFinish) {
        _tabs = <Widget>[
          _buildContent_tab_1(),
          _buildContent_tab_2(),
          _buildContent_tab_3(),
        ];
      } else {
        _tabs = <Widget>[
          _buildContent_tab_1(),
          _buildContent_tab_2(),
        ];
      }
    }

    /*if(itemMain!=null&&!widget.IsCreate){
      if(itemMain.CheckEvidenceType==1){
        list_widget_tab = _onFinish?[
          _buildContent_tab_2(),
          _buildContent_tab_infor(),
          _buildContent_tab_3(),
        ]:[
          _buildContent_tab_2(),
          _buildContent_tab_infor(),
        ];
      }else{
        list_widget_tab=_onFinish ? <Widget>[
          _buildContent_tab_1(),
          _buildContent_tab_2(),
          _buildContent_tab_3(),
        ] :
        <Widget>[
          _buildContent_tab_1(),
          _buildContent_tab_2(),
        ];
      }
    }else{
      list_widget_tab=_onFinish ? <Widget>[
        _buildContent_tab_1(),
        _buildContent_tab_2(),
        _buildContent_tab_3(),
      ] :
      <Widget>[
        _buildContent_tab_1(),
        _buildContent_tab_2(),
      ];
    }*/

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
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              primary: true,
              pinned: false,
              title: Text(
                _title,
                style: appBarStyle,
              ),
              centerTitle: true,
              flexibleSpace: new BottomAppBar(
                elevation: 0.0,
                color: Color(0xff2e76bc),
                child: new Row(children: rowContents),
              ),
              automaticallyImplyLeading: false,
            ),
            SliverFillRemaining(
              child: Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(140.0),
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey[500],
                      labelStyle: tabStyle,
                      controller: tabController,
                      isScrollable: choices.length > 2 ? true : false,
                      tabs: choices.map((Choice choice) {
                        return Tab(
                          text: choice.title,
                        );
                      }).toList(),
                    ),
                  ),
                  body: Stack(
                    children: <Widget>[
                      BackgroundContent(),
                      TabBarView(
                        //physics: NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: _tabs,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  //************************end_tab_1*******************************
  //ItemsMasterProductGroupResponse itemsProductGroup;
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

    setState(() {});
    return true;
  }

  _navigateEvidence(BuildContext context, bool IsSearch, bool IsUpdate, ItemsEvidenceInItem items, index) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionProductGroupMaster();
    Navigator.pop(context);

    if (!IsUpdate) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            /* builder: (context) => CheckEvidenceSearchScreenFragment(
              IsSearch:IsSearch,
              IsUpdate: IsUpdate,
              ItemsDataProduct: items,
              ItemsProductGroup: itemsProductGroup,
              itemsMasProductUnit: widget.itemsMasProductUnit,
              itemsMasProductSize: widget.itemsMasProductSize,
            )),*/
            builder: (context) => TabScreenArrest5Add(
                  IsSearch: IsSearch,
                  IsUpdate: IsUpdate,
                  ItemsProductGroup: itemsProductGroup,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                )),
      );
      if (result.toString() != "back") {
        setState(() {
          /*if(_onEdited){
            ItemsEvidenceInItem item = result;
            itemEvidence.add(item);
            list_add_evidence_item.add(item);
            itemEvidence.forEach((item){
              _setCalItem(item);
            });
          }else{*/
          List items = result.ItemsListArrest5Mas;
          List<ItemsEvidenceInItem> items_evidence_in = [];
          items.forEach((item) {
            items_evidence_in.add(new ItemsEvidenceInItem(
              EVIDENCE_IN_ITEM_ID: null,
              EVIDENCE_IN_ITEM_CODE: null,
              EVIDENCE_IN_ID: null,
              PRODUCT_MAPPING_ID: item.PRODUCT_MAPPING_ID,
              PRODUCT_CODE: item.PRODUCT_CODE,
              PRODUCT_REF_CODE: item.PRODUCT_REF_CODE,
              PRODUCT_GROUP_ID: item.PRODUCT_GROUP_ID,
              PRODUCT_CATEGORY_ID: item.PRODUCT_CATEGORY_ID,
              PRODUCT_TYPE_ID: item.PRODUCT_TYPE_ID,
              PRODUCT_SUBTYPE_ID: item.PRODUCT_SUBTYPE_ID,
              PRODUCT_SUBSETTYPE_ID: item.PRODUCT_SUBSETTYPE_ID,
              PRODUCT_BRAND_ID: item.PRODUCT_BRAND_ID,
              PRODUCT_SUBBRAND_ID: item.PRODUCT_SUBBRAND_ID,
              PRODUCT_MODEL_ID: item.PRODUCT_MODEL_ID,
              PRODUCT_TAXDETAIL_ID: item.PRODUCT_TAXDETAIL_ID,
              PRODUCT_GROUP_CODE: null,
              PRODUCT_GROUP_NAME: item.PRODUCT_GROUP_NAME,
              PRODUCT_CATEGORY_CODE: null,
              PRODUCT_CATEGORY_NAME: item.PRODUCT_CATEGORY_NAME,
              PRODUCT_TYPE_CODE: null,
              PRODUCT_TYPE_NAME: item.PRODUCT_TYPE_NAME,
              PRODUCT_SUBTYPE_CODE: null,
              PRODUCT_SUBTYPE_NAME: item.PRODUCT_SUBTYPE_NAME,
              PRODUCT_SUBSETTYPE_CODE: null,
              PRODUCT_SUBSETTYPE_NAME: item.PRODUCT_SUBSETTYPE_NAME,
              PRODUCT_BRAND_CODE: null,
              PRODUCT_BRAND_NAME_TH: item.PRODUCT_BRAND_NAME_TH,
              PRODUCT_BRAND_NAME_EN: item.PRODUCT_BRAND_NAME_EN,
              PRODUCT_SUBBRAND_CODE: null,
              PRODUCT_SUBBRAND_NAME_TH: item.PRODUCT_SUBBRAND_NAME_TH,
              PRODUCT_SUBBRAND_NAME_EN: item.PRODUCT_SUBBRAND_NAME_EN,
              PRODUCT_MODEL_CODE: null,
              PRODUCT_MODEL_NAME_TH: item.PRODUCT_MODEL_NAME_TH,
              PRODUCT_MODEL_NAME_EN: item.PRODUCT_MODEL_NAME_EN,
              LICENSE_PLATE: "",
              ENGINE_NO: "",
              CHASSIS_NO: "",
              PRODUCT_DESC: item.PRODUCT_DESC,
              SUGAR: item.SUGAR,
              CO2: item.CO2,
              DEGREE: item.DEGREE,
              PRICE: item.PRICE,
              DELIVERY_QTY: item.QUANTITY,
              DELIVERY_QTY_UNIT: item.QUANTITY_UNIT,
              DELIVERY_SIZE: item.SIZES,
              DELIVERY_SIZE_UNIT: item.SIZES_UNIT,
              DELIVERY_NET_VOLUMN: item.VOLUMN,
              DELIVERY_NET_VOLUMN_UNIT: item.VOLUMN_UNIT,
              DAMAGE_QTY: /*item.QUANTITY*/ 0,
              DAMAGE_QTY_UNIT: item.QUANTITY_UNIT,
              DAMAGE_SIZE: item.SIZES,
              DAMAGE_SIZE_UNIT: item.SIZES_UNIT,
              DAMAGE_NET_VOLUMN: /*item.VOLUMN*/ 0,
              DAMAGE_NET_VOLUMN_UNIT: item.VOLUMN_UNIT,
              IS_DOMESTIC: 1,
              IS_ACTIVE: 1,
              ItemsController: new ItemsCheckEvidenceDetailController(
                  new ExpandableController(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  null,
                  null,
                  null,
                  null),
              EvidenceOutStockBalance: [],
            ));
          });

          items_evidence_in.forEach((item) {
            itemEvidence.add(item);

            itemEvidence.forEach((item) {
              _setCalItem(item);
            });
          });

          //}
        });
      }
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            /* builder: (context) => CheckEvidenceSearchScreenFragment(
              IsSearch:IsSearch,
              IsUpdate: IsUpdate,
              ItemsDataProduct: items,
              ItemsProductGroup: itemsProductGroup,
              itemsMasProductUnit: widget.itemsMasProductUnit,
              itemsMasProductSize: widget.itemsMasProductSize,
            )),*/
            builder: (context) => TabScreenArrest5Add(
                  IsSearch: IsSearch,
                  IsUpdate: IsUpdate,
                  ItemsProductGroup: itemsProductGroup,
                  itemsMasProductSize: widget.itemsMasProductSize,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                )),
      );
      if (result.toString() != "Back") {
        setState(() {
          ItemsEvidenceInItem item = result;
          itemEvidence[index] = item;
          _setCalItem(itemEvidence[index]);
        });
      }
    }
  }

  navigateDeliveredBook(BuildContext context, index, bool IsUpdate) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DeliveryBookSearchScreenFragment(
                IsUpdate: IsUpdate,
              )),
    );
    if (result.toString() != "Back") {
      setState(() {
        if (_onEdited) {
          List<ItemsEvidenceInItem> item = result;
          item.forEach((item) {
            itemEvidence[index] = item;
          });
          itemEvidence.forEach((item) {
            _setCalItem(item);
          });
        } else {
          List<ItemsEvidenceInItem> item = result;
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

  Widget _buildContent_tab_1() {
    //style content
    var size = MediaQuery.of(context).size;

    Widget _buildContent(BuildContext context) {
      return SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(22.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: _onExport
                  ? (!IsReceiveProve
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      focusNode: myFocusNodeCheckEvidenceNumber,
                                      controller: editCheckEvidenceNumber,
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
                                    "วันที่นำส่ง",
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
                                      enabled: false,
                                      focusNode: myFocusNodeDevieredDate,
                                      controller: editDevieredDate,
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
                            Container(
                              padding: paddingLabel,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    //padding: paddingData,
                                    child: TextField(
                                      enabled: false,
                                      focusNode: myFocusNodeDevieredTime,
                                      controller: editDevieredTime,
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
                                    "ผู้นำส่ง",
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
                                      enabled: false,
                                      focusNode: myFocusNodeCheckEvidencePerson,
                                      controller: editCheckEvidencePerson,
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
                          ],
                        )

                      //นำส่งของกลางภายในจาก prove
                      : _buildDeliveredFromProve(context))
                  //ข้อมูลนำส่งจากภายนอก
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "เลขหนังสือนำส่งจัดเก็บจากหน่วยงานภายนอก",
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
                                  focusNode: myFocusNodeCheckEvidenceNumber,
                                  controller: editCheckEvidenceNumber,
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
                        /*Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "เลขหนังสือจากภายนอก", style: textStyleLabel,),
                            Text("*", style: textStyleStar,),
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
                                focusNode: myFocusNodeCheckEvidenceNumberOutside,
                                controller: editCheckEvidenceNumberOutside,
                                keyboardType: TextInputType.text,
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
                      ),*/
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "หน่วยงานนำส่ง",
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
                                  focusNode: myFocusNodeCheckEvidenceDepartment,
                                  controller: editCheckEvidenceDepartment,
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
                                "วันที่นำส่ง",
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
                                  enabled: false,
                                  focusNode: myFocusNodeDevieredDate,
                                  controller: editDevieredDate,
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
                                "เวลานำส่ง",
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
                                  enabled: false,
                                  focusNode: myFocusNodeDevieredTime,
                                  controller: editDevieredTime,
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
                                "วันที่กำหนดคืนของกลาง",
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
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return DynamicReturnDialog(Current: _dtReturn);
                                        }).then((s) {
                                      _currentReturnDate = s.toString();
                                      String date = "";
                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
                                      setState(() {
                                        _dtReturn = s;
                                        _currentReturnDate = date;
                                        editReturnDate.text = _currentReturnDate;
                                        //myFocusNodeArrestDate.dispose();
                                      });
                                    });
                                    //_selectDate(context);
                                  },
                                  focusNode: myFocusNodeReturnDate,
                                  controller: editReturnDate,
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
                            ],
                          ),
                        ),
                        /*Container(
                        padding: paddingLabel,
                        child: Row(
                          children: <Widget>[
                            Text(
                              "เลขคดี", style: textStyleLabel,),
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
                                focusNode: myFocusNodeCaseNumber,
                                controller: editCaseNumber,
                                keyboardType: TextInputType.text,
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
                      ),*/
                        Container(
                          padding: paddingLabel,
                          child: Row(
                            children: <Widget>[
                              Text(
                                "เหตุผลในการนำส่ง",
                                style: textStyleLabel,
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
                                  focusNode: myFocusNodeCheckEvidenceComment,
                                  controller: editCheckEvidenceComment,
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
                      ],
                    ),
            ),
          ],
        ),
      ));
    }

    Widget _buildContent_saved(BuildContext context) {
      return SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(22.0),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                ),
                child: _onExport
                    ? (!IsReceiveProve
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขหนังสือนำส่ง",
                                  style: textStyleLabel,
                                ),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  itemMain.DELIVERY_NO.toString(),
                                  style: textStyleData,
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
                                  "วันที่นำส่ง",
                                  style: textStyleLabel,
                                ),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  _convertDate(itemMain.DELIVERY_DATE) + " " + _convertTime1(itemMain.DELIVERY_DATE),
                                  style: textStyleData,
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ผู้นำส่ง",
                                  style: textStyleLabel,
                                ),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  get_staff_name(itemMain.EvidenceInStaff, 59),
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
                                      itemMain.DELIVERY_NO.toString(),
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
                                  _convertDate(itemMain.DELIVERY_DATE) + ' ' + _convertTime1(itemMain.DELIVERY_DATE),
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
                                  get_staff_name(itemMain.EvidenceInStaff, 59) != null ? get_staff_name(itemMain.EvidenceInStaff, 59) : "",
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
                                  get_office_name(itemMain.EvidenceInStaff, 59) != null ? get_office_name(itemMain.EvidenceInStaff, 59) : "",
                                  style: textStyleData,
                                ),
                              ),
                              /*Container(
                            padding: paddingLabel,
                            child: Text(
                              "คลังจัดเก็บ",
                              style: textStyleLabel,
                            ),
                          ),
                          Padding(
                            padding: paddingData,
                            child: Text(
                              get_warehouse_name()!=null
                                  ?get_warehouse_name()
                                  :"",
                              style: textStyleData,
                            ),
                          ),*/
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
                                  itemMain.REMARK != null ? itemMain.REMARK : "",
                                  style: textStyleData,
                                ),
                              ),

                              //Item Delivered
                              _buildItemDelivered(size)
                            ],
                          ))
                    : widget.EVIDENCE_TYPE == 3 || widget.EVIDENCE_TYPE == 4
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เลขหนังสือนำส่งจัดเก็บจากหน่วยงานภายนอก",
                                  style: textStyleLabel,
                                ),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  itemMain.DELIVERY_NO.toString(),
                                  style: textStyleData,
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
                                  "วันที่นำส่ง",
                                  style: textStyleLabel,
                                ),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  _convertDate(itemMain.DELIVERY_DATE) + " " + _convertTime1(itemMain.DELIVERY_DATE),
                                  style: textStyleData,
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "วันที่กำหนดคืนของกลาง",
                                  style: textStyleLabel,
                                ),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  itemMain.RETURN_DATE != null ? _convertDate(itemMain.RETURN_DATE) : "",
                                  style: textStyleData,
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "หน่วยงานนำส่ง",
                                  style: textStyleLabel,
                                ),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  "".toString(),
                                  style: textStyleData,
                                ),
                              ),
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "เหตุผลในการนำส่ง",
                                  style: textStyleLabel,
                                ),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  itemMain.REMARK != null ? itemMain.REMARK : "",
                                  style: textStyleData,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                      itemMain.DELIVERY_NO.toString(),
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
                                  _convertDate(itemMain.DELIVERY_DATE) + ' ' + _convertTime1(itemMain.DELIVERY_DATE),
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
                                  get_staff_name(itemMain.EvidenceInStaff, 59) != null ? get_staff_name(itemMain.EvidenceInStaff, 59) : "",
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
                                  get_office_name(itemMain.EvidenceInStaff, 59) != null ? get_office_name(itemMain.EvidenceInStaff, 59) : "",
                                  style: textStyleData,
                                ),
                              ),
                              /*Container(
                          padding: paddingLabel,
                          child: Text(
                            "คลังจัดเก็บ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            "",
                            style: textStyleData,
                          ),
                        ),*/
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
                                  itemMain.REMARK != null ? itemMain.REMARK : "",
                                  style: textStyleData,
                                ),
                              ),

                              //Item Delivered
                              _buildItemDelivered(size)
                            ],
                          )),
          ],
        ),
      ));
    }

    return _onWithOut
        ? Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                    border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
                /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(
                    'ILG60_B_05_00_05_00', style: textStylePageName,),
                )
              ],
            ),*/
              ),
              Expanded(
                child: _buildContent_saved(context),
              ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                    border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
                /*child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: new Text(
                    'ILG60_B_05_00_10_00', style: textStylePageName,),
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
//************************end_tab_1*******************************

  //************************start_tab_2*****************************
  //รูปภาพ
  Future<File> _imageFile;
  List<ItemsListDocument> _arrItemsImageFile = [];
  List<ItemsListDocument> _arrItemsImageFileAdd = [];
  List<int> _arrItemsImageFileDelete = [];
  bool isImage = false;
  VoidCallback listener;

  //get file รูปภาพ
  Future getImage(ImageSource source, mContext) async {
    var image = await ImagePicker.pickImage(source: source, maxHeight: 1024, maxWidth: 1024);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      if (_onEdited) {
        _arrItemsImageFileAdd.add(new ItemsListDocument(FILE_CONTENT: image, DOCUMENT_OLD_NAME: image.path));
      }
      _arrItemsImageFile.add(new ItemsListDocument(FILE_CONTENT: image, DOCUMENT_NAME: image.path, DOCUMENT_OLD_NAME: image.path));
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
    return Container(
      padding: EdgeInsets.only(top: 18.0, bottom: 12.0),
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
                              color: Color(0xff31517c),
                            ),
                          ),
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              "อัพโหลดรูปภาพ",
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
                    _onSaved ? null : (_onExport ? navigateDeliveredBook(context, null, false) : _navigateEvidence(context, true, false, null, null));
                  },
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          /*Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Icon(
                              null, size: 32, color: uploadColor,),
                          ),*/
                          Container(
                            //padding: EdgeInsets.all(4.0),
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
                        _arrItemsImageFile[index].FILE_CONTENT,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      _arrItemsImageFile[index].DOCUMENT_NAME,
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
                                color: Colors.grey[500],
                              )
                            : Icon(null),
                        onPressed: () {
                          setState(() {
                            if (widget.IsUpdate) {
                              try {
                                _arrItemsImageFileDelete.add(_arrItemsImageFile[index].DOCUMENT_ID);
                              } catch (e) {
                                _arrItemsImageFileAdd.removeAt(index);
                              }
                            }
                            _arrItemsImageFile.removeAt(index);
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

  String _setItemName(ItemsEvidenceInItem item) {
    String name = "";
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

  Widget _buildContent_tab_2() {
    Widget _buildExpandableContent(int index) {
      var size = MediaQuery.of(context).size;

      EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
      EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
      Widget _buildExpanded(index) {
        return Stack(
          children: <Widget>[
            _onExport
                ? (!IsReceiveProve
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "เลขทะเบียนบัญชี",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            padding: paddingData,
                            child: Text(
                              itemEvidence[index].EVIDENCE_IN_ITEM_CODE,
                              style: textStyleData,
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ชื่อของกลาง",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            padding: paddingData,
                            child: Text(
                              new SetProductName(itemEvidence[index]).PRODUCT_NAME,
                              //_setItemName(itemEvidence[index])
                              style: textStyleData,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  width: ((size.width * 75) / 100) / 2.8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Text(
                                          "จำนวนนำส่ง",
                                          style: textStyleLabel,
                                        ),
                                      ),
                                      IgnorePointer(
                                        ignoring: true,
                                        child: Padding(
                                          padding: paddingData,
                                          child: TextField(
                                            focusNode: itemEvidence[index].ItemsController.myFocusNodeDeliveredNumber,
                                            controller: itemEvidence[index].ItemsController.editDeliveredNumber,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
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
                                  width: ((size.width * 75) / 100) / 2.7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Text(
                                          "จำนวนชำรุด",
                                          style: textStyleLabel,
                                        ),
                                      ),
                                      Padding(
                                        padding: paddingData,
                                        child: TextField(
                                          focusNode: itemEvidence[index].ItemsController.myFocusNodeDefectiveNumber,
                                          controller: itemEvidence[index].ItemsController.editDefectiveNumber,
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
                                  padding: EdgeInsets.only(right: 12.0),
                                  width: ((size.width * 75) / 100) / 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Text(
                                          "จำนวนรับ",
                                          style: textStyleLabel,
                                        ),
                                      ),
                                      new IgnorePointer(
                                        ignoring: true,
                                        child: Padding(
                                          padding: paddingData,
                                          child: TextField(
                                            focusNode: itemEvidence[index].ItemsController.myFocusNodeToalNumber,
                                            controller: itemEvidence[index].ItemsController.editTotalNumber,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
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
                                  width: ((size.width * 75) / 100) / 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Text(
                                          "หน่วย",
                                          style: textStyleLabel,
                                        ),
                                      ),
                                      IgnorePointer(
                                        ignoring: true,
                                        child: Padding(
                                          padding: paddingData,
                                          child: TextField(
                                            /*focusNode: itemEvidence[index]
                                      .ItemsController
                                      .myFocusNodeToalNumberUnit,
                                  controller: itemEvidence[index]
                                      .ItemsController.editTotalNumberUnit,
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization
                                      .words,*/
                                            enabled: false,
                                            focusNode: new FocusNode(),
                                            controller: itemEvidence[index].ItemsController.editProductUnit,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 12.0),
                                  width: ((size.width * 75) / 100) / 2.8,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Text(
                                          "ปริมาณนำส่ง",
                                          style: textStyleLabel,
                                        ),
                                      ),
                                      IgnorePointer(
                                        ignoring: true,
                                        child: Padding(
                                          padding: paddingData,
                                          child: TextField(
                                            focusNode: itemEvidence[index].ItemsController.myFocusNodeDeliveredVolumn,
                                            controller: itemEvidence[index].ItemsController.editDeliveredVolumn,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
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
                                  width: ((size.width * 75) / 100) / 2.7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Text(
                                          "ปริมาณชำรุด",
                                          style: textStyleLabel,
                                        ),
                                      ),
                                      Padding(
                                        padding: paddingData,
                                        child: TextField(
                                          focusNode: itemEvidence[index].ItemsController.myFocusNodeDefectiveVolumn,
                                          controller: itemEvidence[index].ItemsController.editDefectiveVolumn,
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
                                  padding: EdgeInsets.only(right: 12.0),
                                  width: ((size.width * 75) / 100) / 3.0,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Text(
                                          "ปริมาณรับ",
                                          style: textStyleLabel,
                                        ),
                                      ),
                                      new IgnorePointer(
                                        ignoring: true,
                                        child: Padding(
                                          padding: paddingData,
                                          child: TextField(
                                            focusNode: itemEvidence[index].ItemsController.myFocusNodeToaVolumn,
                                            controller: itemEvidence[index].ItemsController.editTotalVolumn,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
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
                                  width: ((size.width * 75) / 100) / 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingLabel,
                                        child: Text(
                                          "หน่วย",
                                          style: textStyleLabel,
                                        ),
                                      ),
                                      IgnorePointer(
                                        ignoring: true,
                                        child: Padding(
                                          padding: paddingData,
                                          child: TextField(
                                            /*focusNode: itemEvidence[index]
                                      .ItemsController
                                      .myFocusNodeToaVolumnUnit,
                                  controller: itemEvidence[index]
                                      .ItemsController.editTotalVolumnUnit,
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization
                                      .words,*/
                                            enabled: false,
                                            focusNode: new FocusNode(),
                                            controller: itemEvidence[index].ItemsController.editVolumeUnit,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
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
                              "หมายเหตุ",
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
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    focusNode: itemEvidence[index].ItemsController.myFocusNodeEvidenceComment,
                                    controller: itemEvidence[index].ItemsController.editEvidenceComment,
                                    textCapitalization: TextCapitalization.words,
                                    style: textStyleData,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
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
                          ),
                        ],
                      )
                    : _buildItemFromProve(size, index))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "เลขทะเบียนบัญชี",
                          style: textStyleLabel,
                        ),
                      ),
                      Container(
                        padding: paddingData,
                        child: Text(
                          'Auto Gen',
                          style: textStyleData,
                        ),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ชื่อของกลาง",
                          style: textStyleLabel,
                        ),
                      ),
                      Container(
                        padding: paddingData,
                        child: Text(
                          _setItemName(itemEvidence[index]),
                          style: textStyleData,
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 12.0),
                              width: ((size.width * 75) / 100) / 2.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "จำนวนนำส่ง",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  Padding(
                                    padding: paddingData,
                                    child: TextField(
                                      enabled: false,
                                      focusNode: itemEvidence[index].ItemsController.myFocusNodeDeliveredNumber,
                                      controller: itemEvidence[index].ItemsController.editDeliveredNumber,
                                      keyboardType: TextInputType.number,
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
                            Container(
                              padding: EdgeInsets.only(right: 12.0),
                              width: ((size.width * 75) / 100) / 2.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "จำนวนชำรุด",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  Padding(
                                    padding: paddingData,
                                    child: TextField(
                                      focusNode: itemEvidence[index].ItemsController.myFocusNodeDefectiveNumber,
                                      controller: itemEvidence[index].ItemsController.editDefectiveNumber,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization.words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (text) {
                                        setState(() {
                                          double total_qauntity = itemEvidence[index].DELIVERY_QTY - double.parse(text);
                                          itemEvidence[index].ItemsController.editTotalNumber.text = total_qauntity.toInt().toString();
                                        });
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
                              width: ((size.width * 75) / 100) / 3.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "จำนวนรับ",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  new IgnorePointer(
                                    ignoring: true,
                                    child: Padding(
                                      padding: paddingData,
                                      child: TextField(
                                        focusNode: itemEvidence[index].ItemsController.myFocusNodeToalNumber,
                                        controller: itemEvidence[index].ItemsController.editTotalNumber,
                                        keyboardType: TextInputType.number,
                                        textCapitalization: TextCapitalization.words,
                                        style: textStyleData,
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
                              width: ((size.width * 75) / 100) / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "หน่วย",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  /*Container(
                              //padding: paddingInputBox,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: itemEvidence[index]
                                      .EvidenceDetailController
                                      .dropdownValueProductUnit,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      itemEvidence[index].EvidenceDetailController
                                          .dropdownValueProductUnit =
                                          newValue;
                                    });
                                  },
                                  items: itemEvidence[index]
                                      .EvidenceDetailController
                                      .dropdownItemsProductUnit
                                      .map<DropdownMenuItem<String>>((
                                      String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style: textStyleData,),
                                    );
                                  })
                                      .toList(),
                                ),
                              ),
                            ),*/
                                  Padding(
                                    padding: paddingData,
                                    child: TextField(
                                      enabled: false,
                                      focusNode: new FocusNode(),
                                      controller: itemEvidence[index].ItemsController.editProductUnit,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization.words,
                                      style: textStyleData,
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
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 12.0),
                              width: ((size.width * 75) / 100) / 2.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "ปริมาณนำส่ง",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  Padding(
                                    padding: paddingData,
                                    child: TextField(
                                      enabled: false,
                                      focusNode: itemEvidence[index].ItemsController.myFocusNodeDeliveredVolumn,
                                      controller: itemEvidence[index].ItemsController.editDeliveredVolumn,
                                      keyboardType: TextInputType.number,
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
                            Container(
                              padding: EdgeInsets.only(right: 12.0),
                              width: ((size.width * 75) / 100) / 2.7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "ปริมาณชำรุด",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  Padding(
                                    padding: paddingData,
                                    child: TextField(
                                      focusNode: itemEvidence[index].ItemsController.myFocusNodeDefectiveVolumn,
                                      controller: itemEvidence[index].ItemsController.editDefectiveVolumn,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization.words,
                                      style: textStyleData,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (text) {
                                        double total_volumn = itemEvidence[index].DELIVERY_NET_VOLUMN - double.parse(text);
                                        itemEvidence[index].ItemsController.editTotalVolumn.text = total_volumn.toString();
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
                              width: ((size.width * 75) / 100) / 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      "ปริมาณรับ",
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  new IgnorePointer(
                                    ignoring: true,
                                    child: Padding(
                                      padding: paddingData,
                                      child: TextField(
                                        focusNode: itemEvidence[index].ItemsController.myFocusNodeToaVolumn,
                                        controller: itemEvidence[index].ItemsController.editTotalVolumn,
                                        keyboardType: TextInputType.number,
                                        textCapitalization: TextCapitalization.words,
                                        style: textStyleData,
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
                                      style: textStyleLabel,
                                    ),
                                  ),
                                  /*Container(
                              //padding: paddingInputBox,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: itemEvidence[index]
                                      .EvidenceDetailController
                                      .dropdownValueVolumeUnit,
                                  onChanged: (String newValue) {
                                    setState(() {
                                      itemEvidence[index].EvidenceDetailController
                                          .dropdownValueVolumeUnit =
                                          newValue;
                                    });
                                  },
                                  items: itemEvidence[index]
                                      .EvidenceDetailController
                                      .dropdownItemsVolumeUnit
                                      .map<DropdownMenuItem<String>>((
                                      String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,style: textStyleData,),
                                    );
                                  })
                                      .toList(),
                                ),
                              ),
                            ),*/
                                  Padding(
                                    padding: paddingData,
                                    child: TextField(
                                      enabled: false,
                                      focusNode: new FocusNode(),
                                      controller: itemEvidence[index].ItemsController.editVolumeUnit,
                                      keyboardType: TextInputType.number,
                                      textCapitalization: TextCapitalization.words,
                                      style: textStyleData,
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
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "หมายเหตุ",
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
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                focusNode: itemEvidence[index].ItemsController.myFocusNodeEvidenceComment,
                                controller: itemEvidence[index].ItemsController.editEvidenceComment,
                                textCapitalization: TextCapitalization.words,
                                style: textStyleData,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
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
                      ),
                    ],
                  ),
            widget.EVIDENCE_TYPE == 3 || widget.EVIDENCE_TYPE == 4
                ? Padding(
                    padding: EdgeInsets.only(top: 36.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(6.0),
                                child: InkWell(
                                    onTap: () {
                                      _onExport ? navigateDeliveredBook(context, index, true) : _navigateEvidence(context, false, true, itemEvidence[index], index);
                                    },
                                    child: Text(
                                      "แก้ไข",
                                      style: textLabelEditNonCheckStyle,
                                    ))),
                            Container(
                                padding: EdgeInsets.all(6.0),
                                child: InkWell(
                                    onTap: () {
                                      _showDeleteEvidenceAlertDialog(index);
                                    },
                                    child: Text(
                                      "ลบ",
                                      style: textLabelEditNonCheckStyle,
                                    ))),
                          ],
                        )),
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
                style: textStyleLabel,
              ),
            ),
            Container(
              padding: paddingData,
              child: Text(
                itemEvidence[index].EVIDENCE_IN_ITEM_CODE != null ? itemEvidence[index].EVIDENCE_IN_ITEM_CODE : "Auto Gen",
                style: textStyleData,
              ),
            ),
            Container(
              padding: paddingLabel,
              child: Text(
                "ชื่อของกลาง",
                style: textStyleLabel,
              ),
            ),
            Container(
              padding: paddingData,
              child: Text(
                _setItemName(itemEvidence[index]),
                style: textStyleData,
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
                child:
                    /*_onExport?Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "เลขที่รับ", style: textStyleLabel,),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        "Auto Gen", style: textStyleData,),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "วันที่รับ", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
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
                              enabled: false,
                              focusNode: myFocusNodeGetDate,
                              controller: editGetDate,
                              keyboardType: TextInputType.text,
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
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "เวลา", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
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
                              enabled: false,
                              focusNode: myFocusNodeGetTime,
                              controller: editGetTime,
                              keyboardType: TextInputType.text,
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
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "ผู้ตรวจรับ", style: textStyleLabel,),
                          Text("*", style: textStyleStar,),
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
                              focusNode: myFocusNodeCheckEvidencePersonGet,
                              controller: editCheckEvidencePersonGet,
                              keyboardType: TextInputType.text,
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
                    :*/
                    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "เลขที่รับ",
                        style: textStyleLabel,
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        "Auto Gen",
                        style: textStyleData,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "วันที่รับ",
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
                              enabled: false,
                              focusNode: myFocusNodeGetDate,
                              controller: editGetDate,
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
                    Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              enabled: false,
                              focusNode: myFocusNodeGetTime,
                              controller: editGetTime,
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
                            "ผู้ตรวจรับของกลาง",
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
                              enabled: false,
                              focusNode: myFocusNodeCheckEvidencePersonGet,
                              controller: editCheckEvidencePersonGet,
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
                            "ประธานกรรมการ ",
                            style: textStyleLabel,
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
                                _navigateSearchStaff(context, 61);
                                //
                              },
                              focusNode: myFocusPresidentCommittee,
                              controller: editPresidentCommittee,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textStyleData,
                              decoration: InputDecoration(border: InputBorder.none, suffixIcon: Icon(Icons.person_add)),
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
                            "กรรมการ ",
                            style: textStyleLabel,
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
                                _navigateSearchStaff(context, 62);
                              },
                              focusNode: myFocusCommittee,
                              controller: editCommittee,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textStyleData,
                              decoration: InputDecoration(border: InputBorder.none, suffixIcon: Icon(Icons.person_add)),
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
                            "กรรมการและเลขานุการ  ",
                            style: textStyleLabel,
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
                                _navigateSearchStaff(context, 63);
                              },
                              focusNode: myFocusSecretary,
                              controller: editSecretary,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              style: textStyleData,
                              decoration: InputDecoration(border: InputBorder.none, suffixIcon: Icon(Icons.person_add)),
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
                            "คลังจัดเก็บ",
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
                      width: size.width,
                      padding: paddingLabel,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<ItemsListWarehouse>(
                          value: dropdownValueStock,
                          onChanged: (ItemsListWarehouse newValue) {
                            setState(() {
                              dropdownValueStock = newValue;
                            });
                          },
                          items: dropdownItemsStock.RESPONSE_DATA.map<DropdownMenuItem<ItemsListWarehouse>>((ItemsListWarehouse value) {
                            return DropdownMenuItem<ItemsListWarehouse>(
                              value: value,
                              child: Text(
                                value.WAREHOUSE_NAME.toString(),
                                style: textStyleData,
                              ),
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
                  //padding: EdgeInsets.all(18.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: widget.EVIDENCE_TYPE == 3 || widget.EVIDENCE_TYPE == 4 ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.start,
                      children: <Widget>[_buildButtonImgPicker(), widget.EVIDENCE_TYPE == 3 || widget.EVIDENCE_TYPE == 4 ? _buildButtonSelectEvidence() : Container()],
                    ),
                  )),
              _buildDataImage(context),
            ],
          ),
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      var size = MediaQuery.of(context).size;

      Widget _buildExpandableContent(int index) {
        var size = MediaQuery.of(context).size;
        EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
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
                      style: textStyleLabel,
                    ),
                  ),
                  Container(
                    padding: paddingData,
                    child: Text(
                      itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(),
                      style: textStyleData,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ชื่อของกลาง",
                      style: textStyleLabel,
                    ),
                  ),
                  Container(
                    padding: paddingData,
                    child: Text(
                      _setItemName(itemEvidence[index]).toString(),
                      style: textStyleData,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: ((size.width * 75) / 100) / 2.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "จำนวนนำส่ง",
                                  style: textStyleLabel,
                                ),
                              ),
                              Container(
                                padding: paddingData,
                                child: Text(
                                  itemEvidence[index].DELIVERY_QTY.toInt().toString(),
                                  style: textStyleData,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ((size.width * 75) / 100) / 2.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "จำนวนชำรุด",
                                  style: textStyleLabel,
                                ),
                              ),
                              Container(
                                padding: paddingData,
                                child: Text(
                                  itemEvidence[index].DAMAGE_QTY.toInt().toString(),
                                  style: textStyleData,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ((size.width * 75) / 100) / 3.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "จำนวนรับ",
                                  style: textStyleLabel,
                                ),
                              ),
                              Container(
                                padding: paddingData,
                                child: Text(
                                  (itemEvidence[index].DELIVERY_QTY - itemEvidence[index].DAMAGE_QTY).toInt().toString(),
                                  style: textStyleData,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ((size.width * 75) / 100) / 3.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "หน่วย",
                                  style: textStyleLabel,
                                ),
                              ),
                              Container(
                                padding: paddingData,
                                child: Text(
                                  itemEvidence[index].DELIVERY_QTY_UNIT.toString(),
                                  style: textStyleData,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: ((size.width * 75) / 100) / 2.8,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ปริมาณนำส่ง",
                                  style: textStyleLabel,
                                ),
                              ),
                              Container(
                                padding: paddingData,
                                child: Text(
                                  itemEvidence[index].DELIVERY_NET_VOLUMN.toString(),
                                  style: textStyleData,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ((size.width * 75) / 100) / 2.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ปริมาณชำรุด",
                                  style: textStyleLabel,
                                ),
                              ),
                              Container(
                                padding: paddingData,
                                child: Text(
                                  itemEvidence[index].DAMAGE_NET_VOLUMN.toString(),
                                  style: textStyleData,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ((size.width * 75) / 100) / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "ปริมาณรับ",
                                  style: textStyleLabel,
                                ),
                              ),
                              Container(
                                padding: paddingData,
                                child: Text(
                                  (itemEvidence[index].DELIVERY_NET_VOLUMN - itemEvidence[index].DAMAGE_NET_VOLUMN).toString(),
                                  style: textStyleData,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ((size.width * 75) / 100) / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "หน่วย",
                                  style: textStyleLabel,
                                ),
                              ),
                              Container(
                                padding: paddingData,
                                child: Text(
                                  itemEvidence[index].DELIVERY_NET_VOLUMN_UNIT.toString(),
                                  style: textStyleData,
                                ),
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
                      "หมายเหตุ",
                      style: textStyleLabel,
                    ),
                  ),
                  Container(
                    padding: paddingData,
                    child: Text(
                      '',
                      style: textStyleData,
                    ),
                  ),
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
                  style: textStyleLabel,
                ),
              ),
              Container(
                padding: paddingData,
                child: Text(
                  itemEvidence[index].EVIDENCE_IN_ITEM_CODE.toString(),
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "ชื่อของกลาง",
                  style: textStyleLabel,
                ),
              ),
              Container(
                padding: paddingData,
                child: Text(
                  _setItemName(itemEvidence[index]).toString(),
                  style: textStyleData,
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
              child: _onExport
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "เลขที่รับ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemMain.EVIDENCE_IN_CODE,
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "วันที่รับ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            _convertDate(itemMain.EVIDENCE_IN_DATE) + " " + _convertTime1(itemMain.EVIDENCE_IN_DATE),
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ผู้ตรวจรับของกลาง",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            get_staff_name(itemMain.EvidenceInStaff, 60) != null ? get_staff_name(itemMain.EvidenceInStaff, 60).toString() : "",
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ประธานกรรมการ ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            get_staff_name(itemMain.EvidenceInStaff, 61) != null ? get_staff_name(itemMain.EvidenceInStaff, 61) : "",
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "กรรมการ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            get_staff_name(itemMain.EvidenceInStaff, 62) != null ? get_staff_name(itemMain.EvidenceInStaff, 62) : "",
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "กรรมการและเลขานุการ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            get_staff_name(itemMain.EvidenceInStaff, 63) != null ? get_staff_name(itemMain.EvidenceInStaff, 63) : "",
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
                            get_warehouse_name() != null ? get_warehouse_name() : "",
                            style: textStyleData,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "เลขที่รับ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemMain.EVIDENCE_IN_CODE.toString(),
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "วันที่รับ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            _convertDate(itemMain.EVIDENCE_IN_DATE) + " " + _convertTime1(itemMain.EVIDENCE_IN_DATE),
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ผู้ตรวจรับของกลาง",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            get_staff_name(itemMain.EvidenceInStaff, 60) != null ? get_staff_name(itemMain.EvidenceInStaff, 60) : "",
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ประธานกรรมการ ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            get_staff_name(itemMain.EvidenceInStaff, 61) != null ? get_staff_name(itemMain.EvidenceInStaff, 61) : "",
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "กรรมการ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            get_staff_name(itemMain.EvidenceInStaff, 62) != null ? get_staff_name(itemMain.EvidenceInStaff, 62) : "",
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "กรรมการและเลขานุการ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            get_staff_name(itemMain.EvidenceInStaff, 63) != null ? get_staff_name(itemMain.EvidenceInStaff, 63) : "",
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
                            get_warehouse_name() != null ? get_warehouse_name() : "",
                            style: textStyleData,
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
            _onSaved
                ? Container()
                : Container(
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
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_05_00_06_00', style: textStylePageName,),
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
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            /*child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: new Text(
                      'ILG60_B_05_00_09_00', style: textStylePageName,),
                  )
                ],
              ),*/
          ),
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  _navigate_preview_form(BuildContext context, ItemsListArrest8 item) async {
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

  //ข้อมูลคดี
  //************************start_tab_infor*****************************
  Widget _buildContent_tab_infor() {
    Widget _buildContent(BuildContext context) {
      var size = MediaQuery.of(context).size;

      String prefix = "";
      if (itemsEvidenceArrest.LAWSUIT_IS_OUTSIDE == 1) {
        prefix = "น. ";
      }

      return Container(
          padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0, bottom: 44.0),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /*Container(
                padding: paddingLabel,
                child: Text("เลขหนังสือนำส่ง", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  itemsEvidenceArrest.DELIVERY_DOC_NO_1+"/"+itemsEvidenceArrest.DELIVERY_DOC_NO_2.toString(),
                  style: textStyleData,),
              ),
              Padding(
                padding: paddingData,
                child: Container(
                  height: 1.0,
                  color: Colors.grey[300],
                ),
              ),*/
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
                  itemsEvidenceArrest.ARREST_CODE,
                  style: textStyleData1,
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
                  _convertDate(itemsEvidenceArrest.OCCURRENCE_DATE) + " " + _convertTime(itemsEvidenceArrest.OCCURRENCE_TIME),
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
                  itemsEvidenceArrest.SUBSECTION_NAME != null ? itemsEvidenceArrest.SUBSECTION_NAME.toString() : "",
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
                  itemsEvidenceArrest.GUILTBASE_NAME,
                  style: textStyleData,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "เลขที่รับคำกล่าวโทษ  ",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  prefix + itemsEvidenceArrest.LAWSUIT_NO + "/" + _convertYear(itemsEvidenceArrest.LAWSUIT_NO_YEAR),
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
                  _convertDate(itemsEvidenceArrest.LAWSUIT_DATE) + " " + _convertTime(itemsEvidenceArrest.LAWSUIT_TIME),
                  style: textStyleData,
                ),
              ),
              /*Container(
                padding: paddingLabel,
                child: Text("วันที่นำส่ง", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  _convertDate(itemsEvidenceArrest.DELIVERY_DATE)+" "+_convertTime(itemsEvidenceArrest.DELIVERY_TIME),
                  style: textStyleData,),
              ),
              Container(
                padding: paddingLabel,
                child: Text("ผู้นำส่ง", style: textStyleLabel,),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  itemsEvidenceArrest.RECEIVER_TITLE_NAME.toString()+""+
                      itemsEvidenceArrest.RECEIVER_FIRST_NAME+" "+itemsEvidenceArrest.RECEIVER_LAST_NAME,
                  style: textStyleData,),
              ),*/
            ],
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
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                )),
            /*child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: new Text(
                        'ILG60_B_04_00_04_00', style: textStylePageName,),
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
    String result = "เวลา " + sDate.substring(0, 5) + " น.";
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

  List<ItemsListEvidenceGetStaff> itemsListEvidenceStaff = [];
  void add_staff_to(int CONTRIBUTOR_ID) {
    /*59=ผู้นำส่งของกลาง (ขก.1) /ผู้ส่งมอบ (ขก.2)
      60=เจ้าหน้าที่ตรวจรับของกลาง (ขก.1)
      61=ประธานกรรมการ (ขก.2)
      62=กรรมการ (ขก.2)
      63=กรรมการและเลขานการ (ขก.2)*/

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
        OPREATION_POS_NAME: widget.ItemsPerson.OPREATION_POS_NAME,
        OPREATION_POS_LAVEL_NAME: widget.ItemsPerson.OPREATION_POS_LAVEL_NAME,
        OPERATION_OFFICE_CODE: widget.ItemsPerson.OPERATION_OFFICE_CODE,
        OPERATION_OFFICE_NAME: widget.ItemsPerson.OPERATION_OFFICE_NAME,
        OPERATION_OFFICE_SHORT_NAME: widget.ItemsPerson.OPERATION_OFFICE_SHORT_NAME,
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

  String get_warehouse_name() {
    String warehouse;
    itemMain.EvidenceInItem.forEach((item) {
      item.EvidenceOutStockBalance.forEach((item) {
        widget.itemsMasWarehouse.RESPONSE_DATA.forEach((itm) {
          if (itm.WAREHOUSE_ID == item.WAREHOUSE_ID) {
            warehouse = itm.WAREHOUSE_NAME.toString();
          }
        });
      });
    });
    return warehouse;
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
        /*if (itemMain.EvidenceInStaff.length > 0) {
          for(int i=0;i<itemMain.EvidenceInStaff.length;i++){
            if (Item.CONTRIBUTOR_ID == itemMain.EvidenceInStaff[i].CONTRIBUTOR_ID) {
              itemMain.EvidenceInStaff[i]=Item;
            }
          }
        }*/
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
      }
      editPresidentCommittee.text = get_staff_name(itemsListEvidenceStaff, 61);
      editCommittee.text = get_staff_name(itemsListEvidenceStaff, 62);
      editSecretary.text = get_staff_name(itemsListEvidenceStaff, 63);
    }
  }

  Widget _buildDeliveredFromProve(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            //padding: paddingData,
                            child: TextField(
                              focusNode: myFocusNodeDeriveredNumber,
                              controller: editDeriveredNumber,
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
                              focusNode: myFocusNodeDeriveredYear,
                              controller: editDeriveredYear,
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
                            initialDateTime: _dtDerivered,
                            onDateTimeChanged: (DateTime s) {
                              setState(() {
                                String date = "";
                                List splits = dateFormatDate.format(s).toString().split(" ");
                                date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                _dtDerivered = s;
                                _currentDeriveredDate = date;
                                editDeriveredDate.text = _currentDeriveredDate;

                                List splitsRecieveDate = _dtDerivered.toUtc().toLocal().toString().split(" ");
                                List splitsRecieveTime = deriveredTime.toString().split(" ");
                                _deriveredDate = splitsRecieveDate[0].toString() + " " + splitsRecieveTime[1].toString();
                                print(_deriveredDate.toString());
                              });
                            },
                          ),
                        );
                      },
                    );
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
                    FocusScope.of(context).requestFocus(new FocusNode());
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return _buildBottomPicker(
                          CupertinoDatePicker(
                            use24hFormat: true,
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: deriveredTime,
                            onDateTimeChanged: (DateTime newDateTime) {
                              setState(() {
                                deriveredTime = newDateTime;
                                _currentDeriveredTime = dateFormatTime.format(deriveredTime).toString();
                                editDeriveredTime.text = _currentDeriveredTime;

                                List splitsArrestDate = _dtDerivered.toUtc().toLocal().toString().split(" ");
                                List splitsArrestTime = deriveredTime.toString().split(" ");
                                _deriveredDate = splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString();
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
                        enabled: false,
                        focusNode: myFocusNodeDeriveredDepartment,
                        controller: editDeriveredDepartment,
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
              /*Container(
                padding: paddingLabel,
                child: Row(
                  children: <Widget>[
                    Text(
                      "คลังจัดเก็บ",
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
                    Container(
                      width: size.width,
                      padding: paddingLabel,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<ItemsListWarehouse>(
                          value: dropdownValueDeliveredStock,
                          onChanged: (ItemsListWarehouse newValue) {
                            setState(() {
                              dropdownValueDeliveredStock = newValue;
                            });
                          },
                          items: dropdownItemsStock.RESPONSE_DATA
                              .map<DropdownMenuItem<ItemsListWarehouse>>((ItemsListWarehouse value) {
                            return DropdownMenuItem<ItemsListWarehouse>(
                              value: value,
                              child: Text(value.WAREHOUSE_NAME.toString(), style: textStyleData,),
                            );
                          })
                              .toList(),
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),*/
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
        itemsProveArrestProduct.length > 0
            ? Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        /*bottom: BorderSide(
                      color: Colors.grey[300], width: 1.0),*/
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
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        IsProductStorageAll = !IsProductStorageAll;

                                        if (IsProductStorageAll) {
                                          itemEvidence.clear();
                                          itemsProveArrestProduct.forEach((item) {
                                            item.IS_CHECK = true;
                                            itemEvidence.add(new ItemsEvidenceInItem(
                                                EVIDENCE_IN_ITEM_ID: null,
                                                EVIDENCE_IN_ITEM_CODE: null,
                                                EVIDENCE_IN_ID: null,
                                                PRODUCT_MAPPING_ID: item.PRODUCT_MAPPING_ID,
                                                PRODUCT_CODE: item.PRODUCT_CODE,
                                                PRODUCT_REF_CODE: item.PRODUCT_REF_CODE,
                                                PRODUCT_GROUP_ID: item.PRODUCT_GROUP_ID,
                                                PRODUCT_CATEGORY_ID: item.PRODUCT_CATEGORY_ID,
                                                PRODUCT_TYPE_ID: item.PRODUCT_TYPE_ID,
                                                PRODUCT_SUBTYPE_ID: item.PRODUCT_SUBTYPE_ID,
                                                PRODUCT_SUBSETTYPE_ID: item.PRODUCT_SUBSETTYPE_ID,
                                                PRODUCT_BRAND_ID: item.PRODUCT_BRAND_ID,
                                                PRODUCT_SUBBRAND_ID: item.PRODUCT_SUBBRAND_ID,
                                                PRODUCT_MODEL_ID: item.PRODUCT_MODEL_ID,
                                                PRODUCT_TAXDETAIL_ID: item.PRODUCT_TAXDETAIL_ID,
                                                PRODUCT_GROUP_CODE: item.PRODUCT_GROUP_CODE != null ? int.parse(item.PRODUCT_GROUP_CODE) : null,
                                                PRODUCT_GROUP_NAME: item.PRODUCT_GROUP_NAME,
                                                PRODUCT_CATEGORY_CODE: item.PRODUCT_CATEGORY_CODE != null ? int.parse(item.PRODUCT_CATEGORY_CODE) : null,
                                                PRODUCT_CATEGORY_NAME: item.PRODUCT_CATEGORY_NAME,
                                                PRODUCT_TYPE_CODE: item.PRODUCT_TYPE_CODE != null ? int.parse(item.PRODUCT_TYPE_CODE) : null,
                                                PRODUCT_TYPE_NAME: item.PRODUCT_TYPE_NAME,
                                                PRODUCT_SUBTYPE_CODE: item.PRODUCT_SUBTYPE_CODE != null ? int.parse(item.PRODUCT_SUBTYPE_CODE) : null,
                                                PRODUCT_SUBTYPE_NAME: item.PRODUCT_SUBTYPE_NAME,
                                                PRODUCT_SUBSETTYPE_CODE: item.PRODUCT_SUBSETTYPE_CODE != null ? int.parse(item.PRODUCT_SUBSETTYPE_CODE) : null,
                                                PRODUCT_SUBSETTYPE_NAME: item.PRODUCT_SUBSETTYPE_NAME,
                                                PRODUCT_BRAND_CODE: item.PRODUCT_BRAND_CODE != null ? int.parse(item.PRODUCT_BRAND_CODE) : null,
                                                PRODUCT_BRAND_NAME_TH: item.PRODUCT_BRAND_NAME_TH != null ? item.PRODUCT_BRAND_NAME_TH : "",
                                                PRODUCT_BRAND_NAME_EN: item.PRODUCT_BRAND_NAME_EN,
                                                PRODUCT_SUBBRAND_CODE: item.PRODUCT_SUBBRAND_CODE != null ? int.parse(item.PRODUCT_SUBBRAND_CODE) : null,
                                                PRODUCT_SUBBRAND_NAME_TH: item.PRODUCT_SUBBRAND_NAME_TH,
                                                PRODUCT_SUBBRAND_NAME_EN: item.PRODUCT_SUBBRAND_NAME_EN,
                                                PRODUCT_MODEL_CODE: item.PRODUCT_MODEL_CODE != null ? int.parse(item.PRODUCT_MODEL_CODE) : null,
                                                PRODUCT_MODEL_NAME_TH: item.PRODUCT_MODEL_NAME_TH,
                                                PRODUCT_MODEL_NAME_EN: item.PRODUCT_MODEL_NAME_EN,
                                                LICENSE_PLATE: item.LICENSE_PLATE,
                                                ENGINE_NO: item.ENGINE_NO,
                                                CHASSIS_NO: item.CHASSIS_NO,
                                                PRODUCT_DESC: item.PRODUCT_DESC,
                                                SUGAR: item.SUGAR,
                                                CO2: item.CO2,
                                                DEGREE: item.DEGREE,
                                                PRICE: item.PRICE,
                                                DELIVERY_QTY: double.parse(item.controller.editQuantity.text),
                                                DELIVERY_QTY_UNIT: item.QUANTITY_UNIT,
                                                DELIVERY_SIZE: item.SIZES != null ? item.SIZES : 0,
                                                DELIVERY_SIZE_UNIT: item.SIZES_UNIT,
                                                DELIVERY_NET_VOLUMN: double.parse(item.controller.editVolume.text),
                                                DELIVERY_NET_VOLUMN_UNIT: item.VOLUMN_UNIT,
                                                DAMAGE_QTY: 0,
                                                DAMAGE_QTY_UNIT: "",
                                                DAMAGE_SIZE: 0,
                                                DAMAGE_SIZE_UNIT: "",
                                                DAMAGE_NET_VOLUMN: 0,
                                                DAMAGE_NET_VOLUMN_UNIT: "",
                                                IS_DOMESTIC: item.IS_DOMESTIC,
                                                IS_ACTIVE: null,
                                                ItemsController: new ItemsCheckEvidenceDetailController(
                                                    new ExpandableController(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new FocusNode(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    new TextEditingController(),
                                                    null,
                                                    null,
                                                    null,
                                                    null),
                                                EvidenceOutStockBalance: []));
                                          });

                                          itemEvidence.forEach((f) {
                                            _setCalItem(f);
                                          });
                                        } else {
                                          itemsProveArrestProduct.forEach((item) {
                                            item.IS_CHECK = false;
                                          });
                                          if (itemEvidence.length > 0) {
                                            itemEvidence.clear();
                                          }
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(4.0),
                                        color: IsProductStorageAll ? Color(0xff3b69f3) : Colors.white,
                                        border: Border.all(width: 1.5, color: Colors.black38),
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
              )
            : Container(),
        Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
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
                    width: MediaQuery.of(context).size.width,
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
                                  (j + 1).toString() + ". " + new SetProductProveName(itemsProveArrestProduct[j]).PRODUCT_PROVE_NAME,
                                  style: textStyleData,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 18.0, top: 8, bottom: 8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    itemsProveArrestProduct[j].IS_CHECK = !itemsProveArrestProduct[j].IS_CHECK;

                                    int count = 0;
                                    itemsProveArrestProduct.forEach((ev) {
                                      if (ev.IS_CHECK) {
                                        count++;
                                      }
                                    });
                                    count == itemsProveArrestProduct.length ? IsProductStorageAll = true : IsProductStorageAll = false;

                                    if (itemsProveArrestProduct[j].IS_CHECK) {
                                      itemEvidence.add(new ItemsEvidenceInItem(
                                          EVIDENCE_IN_ITEM_ID: null,
                                          EVIDENCE_IN_ITEM_CODE: null,
                                          EVIDENCE_IN_ID: null,
                                          PRODUCT_MAPPING_ID: itemsProveArrestProduct[j].PRODUCT_MAPPING_ID,
                                          PRODUCT_CODE: itemsProveArrestProduct[j].PRODUCT_CODE,
                                          PRODUCT_REF_CODE: itemsProveArrestProduct[j].PRODUCT_REF_CODE,
                                          PRODUCT_GROUP_ID: itemsProveArrestProduct[j].PRODUCT_GROUP_ID,
                                          PRODUCT_CATEGORY_ID: itemsProveArrestProduct[j].PRODUCT_CATEGORY_ID,
                                          PRODUCT_TYPE_ID: itemsProveArrestProduct[j].PRODUCT_TYPE_ID,
                                          PRODUCT_SUBTYPE_ID: itemsProveArrestProduct[j].PRODUCT_SUBTYPE_ID,
                                          PRODUCT_SUBSETTYPE_ID: itemsProveArrestProduct[j].PRODUCT_SUBSETTYPE_ID,
                                          PRODUCT_BRAND_ID: itemsProveArrestProduct[j].PRODUCT_BRAND_ID,
                                          PRODUCT_SUBBRAND_ID: itemsProveArrestProduct[j].PRODUCT_SUBBRAND_ID,
                                          PRODUCT_MODEL_ID: itemsProveArrestProduct[j].PRODUCT_MODEL_ID,
                                          PRODUCT_TAXDETAIL_ID: itemsProveArrestProduct[j].PRODUCT_TAXDETAIL_ID,
                                          PRODUCT_GROUP_CODE: itemsProveArrestProduct[j].PRODUCT_GROUP_CODE != null ? int.parse(itemsProveArrestProduct[j].PRODUCT_GROUP_CODE) : null,
                                          PRODUCT_GROUP_NAME: itemsProveArrestProduct[j].PRODUCT_GROUP_NAME,
                                          PRODUCT_CATEGORY_CODE: itemsProveArrestProduct[j].PRODUCT_CATEGORY_CODE != null ? int.parse(itemsProveArrestProduct[j].PRODUCT_CATEGORY_CODE) : null,
                                          PRODUCT_CATEGORY_NAME: itemsProveArrestProduct[j].PRODUCT_CATEGORY_NAME,
                                          PRODUCT_TYPE_CODE: itemsProveArrestProduct[j].PRODUCT_TYPE_CODE != null ? int.parse(itemsProveArrestProduct[j].PRODUCT_TYPE_CODE) : null,
                                          PRODUCT_TYPE_NAME: itemsProveArrestProduct[j].PRODUCT_TYPE_NAME,
                                          PRODUCT_SUBTYPE_CODE: itemsProveArrestProduct[j].PRODUCT_SUBTYPE_CODE != null ? int.parse(itemsProveArrestProduct[j].PRODUCT_SUBTYPE_CODE) : null,
                                          PRODUCT_SUBTYPE_NAME: itemsProveArrestProduct[j].PRODUCT_SUBTYPE_NAME,
                                          PRODUCT_SUBSETTYPE_CODE: itemsProveArrestProduct[j].PRODUCT_SUBSETTYPE_CODE != null ? int.parse(itemsProveArrestProduct[j].PRODUCT_SUBSETTYPE_CODE) : null,
                                          PRODUCT_SUBSETTYPE_NAME: itemsProveArrestProduct[j].PRODUCT_SUBSETTYPE_NAME,
                                          PRODUCT_BRAND_CODE: itemsProveArrestProduct[j].PRODUCT_BRAND_CODE != null ? int.parse(itemsProveArrestProduct[j].PRODUCT_BRAND_CODE) : null,
                                          PRODUCT_BRAND_NAME_TH: itemsProveArrestProduct[j].PRODUCT_BRAND_NAME_TH,
                                          PRODUCT_BRAND_NAME_EN: itemsProveArrestProduct[j].PRODUCT_BRAND_NAME_EN,
                                          PRODUCT_SUBBRAND_CODE: itemsProveArrestProduct[j].PRODUCT_SUBBRAND_CODE != null ? int.parse(itemsProveArrestProduct[j].PRODUCT_SUBBRAND_CODE) : null,
                                          PRODUCT_SUBBRAND_NAME_TH: itemsProveArrestProduct[j].PRODUCT_SUBBRAND_NAME_TH,
                                          PRODUCT_SUBBRAND_NAME_EN: itemsProveArrestProduct[j].PRODUCT_SUBBRAND_NAME_EN,
                                          PRODUCT_MODEL_CODE: itemsProveArrestProduct[j].PRODUCT_MODEL_CODE != null ? int.parse(itemsProveArrestProduct[j].PRODUCT_MODEL_CODE) : null,
                                          PRODUCT_MODEL_NAME_TH: itemsProveArrestProduct[j].PRODUCT_MODEL_NAME_TH,
                                          PRODUCT_MODEL_NAME_EN: itemsProveArrestProduct[j].PRODUCT_MODEL_NAME_EN,
                                          LICENSE_PLATE: itemsProveArrestProduct[j].LICENSE_PLATE,
                                          ENGINE_NO: itemsProveArrestProduct[j].ENGINE_NO,
                                          CHASSIS_NO: itemsProveArrestProduct[j].CHASSIS_NO,
                                          PRODUCT_DESC: itemsProveArrestProduct[j].PRODUCT_DESC,
                                          SUGAR: itemsProveArrestProduct[j].SUGAR,
                                          CO2: itemsProveArrestProduct[j].CO2,
                                          DEGREE: itemsProveArrestProduct[j].DEGREE,
                                          PRICE: itemsProveArrestProduct[j].PRICE,
                                          DELIVERY_QTY: double.parse(itemsProveArrestProduct[j].controller.editQuantity.text),
                                          DELIVERY_QTY_UNIT: itemsProveArrestProduct[j].QUANTITY_UNIT,
                                          DELIVERY_SIZE: itemsProveArrestProduct[j].SIZES != null ? itemsProveArrestProduct[j].SIZES : 0,
                                          DELIVERY_SIZE_UNIT: itemsProveArrestProduct[j].SIZES_UNIT,
                                          DELIVERY_NET_VOLUMN: double.parse(itemsProveArrestProduct[j].controller.editVolume.text),
                                          DELIVERY_NET_VOLUMN_UNIT: itemsProveArrestProduct[j].VOLUMN_UNIT,
                                          DAMAGE_QTY: 0,
                                          DAMAGE_QTY_UNIT: "",
                                          DAMAGE_SIZE: 0,
                                          DAMAGE_SIZE_UNIT: "",
                                          DAMAGE_NET_VOLUMN: 0,
                                          DAMAGE_NET_VOLUMN_UNIT: "",
                                          IS_DOMESTIC: itemsProveArrestProduct[j].IS_DOMESTIC,
                                          IS_ACTIVE: null,
                                          ItemsController: new ItemsCheckEvidenceDetailController(
                                              new ExpandableController(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new FocusNode(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              new TextEditingController(),
                                              null,
                                              null,
                                              null,
                                              null),
                                          EvidenceOutStockBalance: []));

                                      itemEvidence.forEach((f) {
                                        _setCalItem(f);
                                      });
                                    } else {
                                      if (itemEvidence.length > 0) {
                                        /*itemEvidence.forEach((f){
                                          if(f.PRODUCT_MAPPING_ID==itemsProveArrestProduct[j].PRODUCT_MAPPING_ID){
                                            itemEvidence.remove(f);
                                          }
                                        });*/
                                        itemEvidence.removeAt(j);
                                      }
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: itemsProveArrestProduct[j].IS_CHECK ? Color(0xff3b69f3) : Colors.white,
                                    border: Border.all(width: 1.5, color: Colors.black38),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
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
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: ((size.width * 75) / 100) / 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            "จำนวน",
                                            style: textStyleLabel,
                                          ),
                                        ),
                                        Padding(
                                          padding: paddingData,
                                          child: TextField(
                                            focusNode: itemsProveArrestProduct[j].controller.myFocusNodeQuantity,
                                            controller: itemsProveArrestProduct[j].controller.editQuantity,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (text) {
                                              if (text.isNotEmpty) {
                                                if (itemEvidence.length > 0) {
                                                  itemEvidence.forEach((f) {
                                                    if (f.PRODUCT_MAPPING_ID == itemsProveArrestProduct[j].PRODUCT_MAPPING_ID) {
                                                      setState(() {
                                                        f.DELIVERY_QTY = double.parse(text);
                                                      });
                                                    }
                                                  });
                                                  itemEvidence.forEach((f) {
                                                    _setCalItem(f);
                                                  });
                                                }
                                              }
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
                                    width: ((size.width * 75) / 100) / 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: paddingLabel,
                                          child: Text(
                                            "ปริมาณ",
                                            style: textStyleLabel,
                                          ),
                                        ),
                                        Padding(
                                          padding: paddingData,
                                          child: TextField(
                                            focusNode: itemsProveArrestProduct[j].controller.myFocusNodeVolume,
                                            controller: itemsProveArrestProduct[j].controller.editVolume,
                                            keyboardType: TextInputType.number,
                                            textCapitalization: TextCapitalization.words,
                                            style: textStyleData,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            onChanged: (text) {
                                              if (text.isNotEmpty) {
                                                if (itemEvidence.length > 0) {
                                                  itemEvidence.forEach((f) {
                                                    if (f.PRODUCT_MAPPING_ID == itemsProveArrestProduct[j].PRODUCT_MAPPING_ID) {
                                                      setState(() {
                                                        f.DELIVERY_NET_VOLUMN = double.parse(text);
                                                      });
                                                    }
                                                  });
                                                  itemEvidence.forEach((f) {
                                                    _setCalItem(f);
                                                  });
                                                }
                                              }
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
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildItemDelivered(var size) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border(
              //top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Container(
                padding: paddingLabel,
                child: Text(
                  "รายการของกลางที่นำส่ง",
                  style: textStyleLabel,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.only(bottom: 22.0),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                    )),
                child: ListView.builder(
                    itemCount: itemMain.EvidenceInItem.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ชื่อของกลาง",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            padding: paddingData,
                            child: Text(
                              _setItemName(itemEvidence[index]),
                              style: textStyleData,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    width: ((size.width * 75) / 100) / 2.8,
                                    child: Container(
                                      padding: paddingLabel,
                                      child: Text(
                                        "จำนวนนำส่ง",
                                        style: textStyleLabel,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    width: ((size.width * 75) / 100) / 2.8,
                                    child: Container(
                                      padding: paddingLabel,
                                      child: Text(
                                        itemMain.EvidenceInItem[index].DELIVERY_QTY.toInt().toString(),
                                        style: textStyleData,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    width: ((size.width * 75) / 100) / 2.8,
                                    child: Container(
                                      padding: paddingLabel,
                                      child: Text(
                                        "ปริมาณนำส่ง",
                                        style: textStyleLabel,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 12.0),
                                    width: ((size.width * 75) / 100) / 2.8,
                                    child: Container(
                                      padding: paddingLabel,
                                      child: Text(
                                        itemMain.EvidenceInItem[index].DELIVERY_NET_VOLUMN.toString(),
                                        style: textStyleData,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      );
                    }))
          ],
        ));
  }

  //Time Picker
  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
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

  Widget _buildItemFromProve(var size, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "เลขทะเบียนบัญชี",
            style: textStyleLabel,
          ),
        ),
        Container(
          padding: paddingData,
          child: Text(
            "Auto Gen",
            style: textStyleData,
          ),
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "ชื่อของกลาง",
            style: textStyleLabel,
          ),
        ),
        Container(
          padding: paddingData,
          child: Text(
            _setItemName(itemEvidence[index]),
            style: textStyleData,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 12.0),
                width: ((size.width * 75) / 100) / 2.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "จำนวนนำส่ง",
                        style: textStyleLabel,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          focusNode: itemEvidence[index].ItemsController.myFocusNodeDeliveredNumber,
                          controller: itemEvidence[index].ItemsController.editDeliveredNumber,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
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
                width: ((size.width * 75) / 100) / 2.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "จำนวนชำรุด",
                        style: textStyleLabel,
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: itemEvidence[index].ItemsController.myFocusNodeDefectiveNumber,
                        controller: itemEvidence[index].ItemsController.editDefectiveNumber,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          setState(() {
                            double total_qauntity = itemEvidence[index].DELIVERY_QTY - double.parse(text);
                            itemEvidence[index].ItemsController.editTotalNumber.text = total_qauntity.toInt().toString();
                          });
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
                width: ((size.width * 75) / 100) / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "จำนวนรับ",
                        style: textStyleLabel,
                      ),
                    ),
                    new IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          focusNode: itemEvidence[index].ItemsController.myFocusNodeToalNumber,
                          controller: itemEvidence[index].ItemsController.editTotalNumber,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
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
                width: ((size.width * 75) / 100) / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "หน่วย",
                        style: textStyleLabel,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          /*focusNode: itemEvidence[index]
                                      .ItemsController
                                      .myFocusNodeToalNumberUnit,
                                  controller: itemEvidence[index]
                                      .ItemsController.editTotalNumberUnit,
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization
                                      .words,*/
                          enabled: false,
                          focusNode: new FocusNode(),
                          controller: itemEvidence[index].ItemsController.editProductUnit,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 12.0),
                width: ((size.width * 75) / 100) / 2.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ปริมาณนำส่ง",
                        style: textStyleLabel,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          focusNode: itemEvidence[index].ItemsController.myFocusNodeDeliveredVolumn,
                          controller: itemEvidence[index].ItemsController.editDeliveredVolumn,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
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
                width: ((size.width * 75) / 100) / 2.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ปริมาณชำรุด",
                        style: textStyleLabel,
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: TextField(
                        focusNode: itemEvidence[index].ItemsController.myFocusNodeDefectiveVolumn,
                        controller: itemEvidence[index].ItemsController.editDefectiveVolumn,
                        keyboardType: TextInputType.number,
                        textCapitalization: TextCapitalization.words,
                        style: textStyleData,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          double total_volumn = itemEvidence[index].DELIVERY_NET_VOLUMN - double.parse(text);
                          itemEvidence[index].ItemsController.editTotalVolumn.text = total_volumn.toString();
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
                width: ((size.width * 75) / 100) / 3.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ปริมาณรับ",
                        style: textStyleLabel,
                      ),
                    ),
                    new IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          focusNode: itemEvidence[index].ItemsController.myFocusNodeToaVolumn,
                          controller: itemEvidence[index].ItemsController.editTotalVolumn,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
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
                width: ((size.width * 75) / 100) / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "หน่วย",
                        style: textStyleLabel,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Padding(
                        padding: paddingData,
                        child: TextField(
                          enabled: false,
                          focusNode: new FocusNode(),
                          controller: itemEvidence[index].ItemsController.editVolumeUnit,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.words,
                          style: textStyleData,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
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
            "หมายเหตุ",
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
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  focusNode: itemEvidence[index].ItemsController.myFocusNodeEvidenceComment,
                  controller: itemEvidence[index].ItemsController.editEvidenceComment,
                  textCapitalization: TextCapitalization.words,
                  style: textStyleData,
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
        ),
      ],
    );
  }
}
