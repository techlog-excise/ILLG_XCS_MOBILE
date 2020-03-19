import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

import 'future/lawsuit_future.dart';
import 'model/item_lawsuit_deatail.dart';
import 'model/lawsuit_arrest_main.dart';
import 'model/lawsuit_indicment_detail.dart';
import 'model/lawsuit_main.dart';
import 'model/lawsuit_mas_court.dart';

const double _kPickerSheetHeight = 216.0;

class LawsuitAcceptSentenceScreenFragment extends StatefulWidget {
  ItemsListLawsuitDetail ItemSentence;
  ItemsLawsuitListIndicmentDetail indicmentDetail;
  List<ItemsLawsuitMasCourt> itemsLawsuitMasCourt;
  ItemsLawsuitMain itemsLawsuitMain;
  ItemsLawsuitArrestMain itemsLawsuitArrestMain;
  List<ItemsListDocument> itemDocument;
  bool IsPreview;
  bool IsCreate;
  LawsuitAcceptSentenceScreenFragment({
    Key key,
    @required this.ItemSentence,
    @required this.indicmentDetail,
    @required this.itemsLawsuitMasCourt,
    @required this.itemsLawsuitMain,
    @required this.itemsLawsuitArrestMain,
    @required this.itemDocument,
    @required this.IsPreview,
    @required this.IsCreate,
  }) : super(key: key);
  @override
  _FragmentState createState() => new _FragmentState();
}

class _FragmentState extends State<LawsuitAcceptSentenceScreenFragment> with TickerProviderStateMixin {
  //เมื่อบันทึกข้อมูล
  bool _onSaved = false;
  bool _onSave = false;
  //เมื่อแก้ไขข้อมูล
  bool _onEdited = false;
  //เมื่อลบข้อมูล
  bool _onDeleted = false;
  //เมื่อทำรายการเสร็จ
  bool _onFinish = false;

  //จ่ายครั้งเดียว
  bool _isOneTime = true;
  //แบ่งจ่ายเป็นงวด
  bool _isPeriod = false;

  //คำพิพากษาศาล
  //ศาลยกฟ้อง
  bool _isDismissed = false;
  //สั่งจำคุก
  bool _isImprison = false;
  //สั่งปรับ
  bool _isFine = false;

  //dropdown หน่วยการชำระเงินเป็นงวด
  ListDateUnitModel dropdownValueFine;
  List<ListDateUnitModel> dropdownItemsFine = [
    new ListDateUnitModel(DateUnitID: 0, DateUnitName: "วัน"),
    new ListDateUnitModel(DateUnitID: 1, DateUnitName: "สัปดาห์"),
    new ListDateUnitModel(DateUnitID: 2, DateUnitName: "เดือน"),
    new ListDateUnitModel(DateUnitID: 3, DateUnitName: "ปี"),
  ];
  //dropdown หน่วยการสั่งจำคุก
  ListDateUnitModel dropdownValueImprison;
  List<ListDateUnitModel> dropdownItemsImprison = [
    new ListDateUnitModel(DateUnitID: 0, DateUnitName: "วัน"),
    new ListDateUnitModel(DateUnitID: 1, DateUnitName: "เดือน"),
    new ListDateUnitModel(DateUnitID: 2, DateUnitName: "ปี"),
  ];

  //dropdown ช่องทางการชำระเงินจากศาล
  ListChannelModel dropdownValuePaymentChannel = null;
  List<ListChannelModel> dropdownItemsPaymentChannel = [new ListChannelModel(ChannelID: 0, ChannelName: "เช็ค"), new ListChannelModel(ChannelID: 1, ChannelName: "โอนจากธนาคาร")];
  //dropdown ธนาคาร
  ListBankModel dropdownValueBank = null;
  List<ListBankModel> dropdownItemsBank = [new ListBankModel(BankID: 0, BankName: 'กรุงศรีฯ'), new ListBankModel(BankID: 1, BankName: 'กรุงไทย'), new ListBankModel(BankID: 2, BankName: 'กสิกรไทย')];

  ListCourtEndModel dropdownValueCourtEnd = null;
  List<ListCourtEndModel> dropdownItemsCourtEnd = [new ListCourtEndModel(CourtEndID: 0, CourtEndName: "ศาลชั้นต้น"), new ListCourtEndModel(CourtEndID: 1, CourtEndName: "ศาลอุทรณ์"), new ListCourtEndModel(CourtEndID: 2, CourtEndName: "ศาลฎีกา")];

  //node focus
  //ชื่อศาล
  final FocusNode myFocusNodeCourtName = FocusNode();
  //คดีแดงศาลชั้นต้น
  final FocusNode myFocusNodeCivilCourtUndecidedCase = FocusNode();
  final FocusNode myFocusNodeCivilCourtUndecidedYear = FocusNode();
  //คดีแดงศาลชั้นต้น
  final FocusNode myFocusNodeCivilCourtDecidedCase = FocusNode();
  final FocusNode myFocusNodeCivilCourtDecidedYear = FocusNode();
  //คดีแดงศาลอุทธรณ์
  final FocusNode myFocusNodeCourtofAppealsUndecidedCase = FocusNode();
  final FocusNode myFocusNodeCourtofAppealsUndecidedYear = FocusNode();
  //คดีแดงศาลอุทธรณ์
  final FocusNode myFocusNodeCourtofAppealsDecidedCase = FocusNode();
  final FocusNode myFocusNodeCourtofAppealsDecidedYear = FocusNode();
  //คดีแดงศาลฎีกา
  final FocusNode myFocusNodeSupremeCourtUndecidedCase = FocusNode();
  final FocusNode myFocusNodeSupremeCourtUndecidedYear = FocusNode();
  //คดีแดงศาลฎีกา
  final FocusNode myFocusNodeSupremeCourtDecidedCase = FocusNode();
  final FocusNode myFocusNodeSupremeCourtDecidedYear = FocusNode();

  //วันและเวลาอ่านคำพิพากษา
  final FocusNode myFocusNodeDateReadCase = FocusNode();
  final FocusNode myFocusNodeTimeReadCase = FocusNode();
  //วันที่ชำระค่าปรับ
  final FocusNode myFocusNodeDateFine = FocusNode();
  //วันที่รับเงินจากศาล
  final FocusNode myFocusNodeDateBill = FocusNode();
  //วันที่เริ่มชำระค่าปรับ
  final FocusNode myFocusNodeStartPayment = FocusNode();
  //เลขที่เช็คหรือเลขที่บัญชี
  final FocusNode myFocusNodeBookBank = FocusNode();
  //จำนวนเงินจากศาล
  final FocusNode myFocusNodeCheckValue = FocusNode();

  final FocusNode myFocusNodeFineValue = FocusNode();
  final FocusNode myFocusNodeImprison = FocusNode();
  final FocusNode myFocusNodePeriod = FocusNode();
  final FocusNode myFocusNodePeriodNum = FocusNode();

  //ชื่อศาล
  TextEditingController editCourtName = new TextEditingController();
  //คดีดำศาลชั้นต้น
  TextEditingController editCivilCourtUndecidedCase = new TextEditingController();
  TextEditingController editCivilCourtUndecidedYear = new TextEditingController();
  DateTime _dtUndecidedYear = DateTime.now();
  //คดีแดงศาลชั้นต้น
  TextEditingController editCivilCourtDecidedCase = new TextEditingController();
  TextEditingController editCivilCourtDecidedYear = new TextEditingController();
  DateTime _dtDecidedYear = DateTime.now();
  //คดีดำศาลอุทธรณ์
  TextEditingController editCourtofAppealsUndecidedCase = new TextEditingController();
  TextEditingController editCourtofAppealsUndecidedYear = new TextEditingController();
  DateTime _dtAppealsUndecidedYear = DateTime.now();
  //คดีแดงศาลอุทธรณ์
  TextEditingController editCourtofAppealsDecidedCase = new TextEditingController();
  TextEditingController editCourtofAppealsDecidedYear = new TextEditingController();
  DateTime _dtCourtofAppealsDecidedYear = DateTime.now();
  //คดีดำศาลฎีกา
  TextEditingController editSupremeCourtUndecidedCase = new TextEditingController();
  TextEditingController editSupremeCourtUndecidedYear = new TextEditingController();
  DateTime _dtSupremeCourtUndecidedYear = DateTime.now();
  //คดีแดงศาลฎีกา
  TextEditingController editSupremeCourtDecidedCase = new TextEditingController();
  TextEditingController editSupremeCourtDecidedYear = new TextEditingController();
  DateTime _dtSupremeCourtDecidedYear = DateTime.now();
  //วันและเวลาอ่านคำพิพากษา
  TextEditingController editDateReadCase = new TextEditingController();
  TextEditingController editTimeReadCase = new TextEditingController();

  //วันที่ชำระค่าปรับ
  TextEditingController editDateFine = new TextEditingController();
  //วันที่เริ่มชำระค่าปรับ
  TextEditingController editDateStartPayment = new TextEditingController();
  //วันที่รับเงินจากศาล
  TextEditingController editDateBill = TextEditingController();
  //เลขที่เช็คหรือเลขที่บัญชี
  TextEditingController editBookBank = new TextEditingController();
  //จำนวนเงินจากศาล
  TextEditingController editCheckValue = new TextEditingController();

  TextEditingController editFineValue = new TextEditingController();
  TextEditingController editImprison = new TextEditingController();
  TextEditingController editPeriod = new TextEditingController();
  TextEditingController editPeriodNum = new TextEditingController();

  final formatter = new NumberFormat("#,###.#");
  final formatter1 = new NumberFormat("####");
  final formatter_fine = new NumberFormat("#,##0.00");

  //วันเดือนปี เวลา ปัจจุบัน
  String _currentDate, _currentTime;
  var dateFormatDate, dateFormatTime;

  DateTime _dtcurrentDate = DateTime.now();

  DateTime _initDate = DateTime.now();
  DateTime _initTime = DateTime.now();
  //วันที่กำหนดชำระค่าปรับของผู้ต้องหา
  String _currentDateFine;
  DateTime _dtDateFine = DateTime.now();
  //วันที่เริ่มชำระค่าปรับ
  String _currentDateStartPayment;
  DateTime _dtDateStartPayment = DateTime.now();
  //วันที่รับเงินจากศาล
  String _currentDateBill;
  DateTime _dtDateBill = DateTime.now();

  DateTime _dtUndecidedDateFine = DateTime.now();
  DateTime _dtDecidedDateFine = DateTime.now();

  //รูปภาพ
  List<ItemsListDocument> _arrItemsImageFileInit = [];
  List<ItemsListDocument> _arrItemsImageFile = [];
  List<ItemsListDocument> _arrItemsImageFileAdd = [];
  List<int> _arrItemsImageFileDelete = [];
  bool isImage = false;
  VoidCallback listener;

  //model คำพิพากษาศาล
  ItemsListLawsuitDetail itemMain;
  ItemsLawsuitListIndicmentDetail indicmentDetail;
  ItemsLawsuitMain itemsLawsuitMain;
  ItemsLawsuitArrestMain itemsLawsuitArrestMain;

  //style text
  TextStyle textStyleLabel = Styles.textStyleLabel;
  TextStyle textStyleData = Styles.textStyleData;
  TextStyle textStyleData1 = TextStyle(fontSize: 16, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSubData = TextStyle(fontSize: 16, color: Colors.black38, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(color: Colors.grey[400], fontFamily: FontStyles().FontFamily, fontSize: 12.0);
  TextStyle textStyleStar = Styles.textStyleStar;
  EdgeInsets paddingData = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
  TextStyle textStyleSub = TextStyle(fontSize: 16, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff31517c), fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(fontSize: 16.0, color: Color(0xff4564c2), fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);

  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    //set วันเดือนปี เวลา ปัจจุบัน
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    _currentDate = date;
    _currentDateFine = date;
    _currentTime = dateFormatTime.format(DateTime.now()).toString();

    editDateReadCase.text = _currentDate;
    editTimeReadCase.text = _currentTime;

    editDateFine.text = _currentDateFine;
    editDateBill.text = _currentDateFine;
    editDateStartPayment.text = _currentDateFine;

    itemMain = widget.ItemSentence;
    indicmentDetail = widget.indicmentDetail;
    itemsLawsuitMain = widget.itemsLawsuitMain;
    itemsLawsuitArrestMain = widget.itemsLawsuitArrestMain;
    setAutoCompleteTitle();

    if (widget.IsPreview) {
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsCreate;
      _onFinish = widget.IsPreview;

      List<ItemsListDocument> itemDoc = [];
      widget.itemDocument.forEach((f) {
        if (int.parse(f.IS_ACTIVE) == 1) {
          itemDoc.add(f);
        }
      });
      _arrItemsImageFileInit = itemDoc;
      _arrItemsImageFile = itemDoc;

      if ((itemMain.UNDECIDE_NO_1 != 0 || itemMain.UNDECIDE_NO_YEAR_1 != null) && (itemMain.DECIDE_NO_1 != 0 || itemMain.DECIDE_NO_YEAR_1 != null)) {
        dropdownValueCourtEnd = dropdownItemsCourtEnd[0];
      } else if ((itemMain.UNDECIDE_NO_2 != 0 || itemMain.UNDECIDE_NO_YEAR_2 != null) && (itemMain.DECIDE_NO_2 != 0 || itemMain.DECIDE_NO_YEAR_2 != null)) {
        dropdownValueCourtEnd = dropdownItemsCourtEnd[1];
      } else if ((itemMain.UNJUDGEMENT_NO != 0 || itemMain.UNJUDGEMENT_NO_YEAR != null) && (itemMain.JUDGEMENT_NO != 0 || itemMain.JUDGEMENT_NO_YEAR != null)) {
        dropdownValueCourtEnd = dropdownItemsCourtEnd[2];
      } else {}
    } else {
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsPreview;
      _onFinish = widget.IsPreview;
    }

    /*_isFine=itemMain.IS_FINE==0?false:true;
    //_isPeriod=itemMain.IS_PAYONCE==0?false:true;
    _isImprison=itemMain.IS_IMPRISON==0?false:true;
    _isDismissed=false;

    if(itemMain.IS_PAYONCE==1){
      _setInitData1();
      _isPeriod=false;
      _isOneTime=true;
    }else{
      _isPeriod=true;
      _isOneTime=false;
      //_setInitData2();
    }

    if(widget.IsPreview){
      _onSaved=widget.IsPreview;
      _onFinish=widget.IsPreview;
      _onSave=widget.IsPreview;
      _onEdited=widget.IsUpdate;
    }else{
      _onSaved=widget.IsPreview;
      _onFinish=widget.IsPreview;
      _onSave=widget.IsPreview;
      _onEdited=widget.IsUpdate;
    }*/
  }

  @override
  void dispose() {
    super.dispose();
    editCourtName.dispose();
    editFineValue.dispose();
    editImprison.dispose();
    editPeriod.dispose();
    editPeriodNum.dispose();
    editDateReadCase.dispose();
    editDateFine.dispose();
    editDateBill.dispose();

    editCivilCourtUndecidedCase.dispose();
    editCivilCourtUndecidedYear.dispose();
    editCivilCourtDecidedCase.dispose();
    editCivilCourtDecidedYear.dispose();
    editCourtofAppealsUndecidedCase.dispose();
    editCourtofAppealsUndecidedYear.dispose();
    editCourtofAppealsDecidedCase.dispose();
    editCourtofAppealsDecidedYear.dispose();
    editSupremeCourtUndecidedCase.dispose();
    editSupremeCourtUndecidedYear.dispose();
    editSupremeCourtDecidedCase.dispose();
    editSupremeCourtDecidedYear.dispose();
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

  // set text data ชำระครั้งเดียว
  void _setInitData1() {
    /*String sentence_date = "";
    String fine_date = "";
    DateTime dt_sentence_date = DateTime.parse(itemMain.JUDGEMENT_DATE);
    */ /*DateTime dt_fine_date = DateTime.parse(itemMain.FINE_DATE);*/ /*
    DateTime dt_fine_date = itemMain.FINE_DATE!=null
        ?DateTime.parse(itemMain.FINE_DATE)
        :DateTime.now();
    List splitsSentenceDate = dateFormatDate.format(dt_sentence_date).toString().split(
        " ");
    List splitsFineDate = dateFormatDate.format(dt_fine_date).toString().split(
        " ");
    sentence_date = splitsSentenceDate[0] + " " + splitsSentenceDate[1] + " " +
        (int.parse(splitsSentenceDate[3]) + 543).toString();
    fine_date = splitsFineDate[0] + " " + splitsFineDate[1] + " " +
        (int.parse(splitsFineDate[3]) + 543).toString();

    String DECIDE_NO_YEAR_2 = "";
    String UNDECIDE_NO_YEAR_2 = "";
    DateTime dt_Decide_date = DateTime.parse(itemMain.DECIDE_NO_YEAR_2);
    DateTime dt_Undecide_date = DateTime.parse(itemMain.UNDECIDE_NO_YEAR_2);
    List splitsDecideDate = dateFormatDate.format(dt_Decide_date).toString().split(
        " ");
    List splitsUndecideDate = dateFormatDate.format(dt_Undecide_date).toString().split(
        " ");
    DECIDE_NO_YEAR_2=(int.parse(splitsDecideDate[3]) + 543).toString();
    UNDECIDE_NO_YEAR_2=(int.parse(splitsUndecideDate[3]) + 543).toString();


    editCourtName.text=itemMain.COURT_NAME;
    editUndecidedCase.text=itemMain.UNDECIDE_NO_2.toString();
    editUndecidedYear.text=UNDECIDE_NO_YEAR_2;
    editDecidedCase.text=itemMain.DECIDE_NO_2.toString();
    editDecidedYear.text=DECIDE_NO_YEAR_2;
    editFineValue.text=formatter1.format(itemMain.FINE).toString();
    editImprison.text=formatter1.format(itemMain.IMPRISON_TIME).toString();
    if(itemMain.IMPRISON_TIME_UNIT==0){
      dropdownValueImprison = "วัน";
    }else if(itemMain.IMPRISON_TIME_UNIT==1){
      dropdownValueImprison = "เดือน";
    }else{
      dropdownValueImprison = "ปี";
    }*/

    widget.itemsLawsuitMasCourt.forEach((f) {
      if (f.COURT_ID == itemMain.COURT_ID) {
        itemsLawsuitMasCourt = f;
      }
    });
    editCourtName.text = itemsLawsuitMasCourt.COURT_NAME;

    editCivilCourtUndecidedCase.text = itemMain.UNDECIDE_NO_1 != 0 ? itemMain.UNDECIDE_NO_1.toString() : "";
    editCivilCourtUndecidedYear.text = itemMain.UNDECIDE_NO_YEAR_1 != null ? _convertNoYear(itemMain.UNDECIDE_NO_YEAR_1).toString() : "";

    editCivilCourtDecidedCase.text = itemMain.DECIDE_NO_1 != 0 ? itemMain.DECIDE_NO_1.toString() : "";
    editCivilCourtDecidedYear.text = itemMain.DECIDE_NO_YEAR_1 != null ? _convertNoYear(itemMain.DECIDE_NO_YEAR_1).toString() : "";

    editCourtofAppealsUndecidedCase.text = itemMain.UNDECIDE_NO_2 != 0 ? itemMain.UNDECIDE_NO_2.toString() : "";
    editCourtofAppealsUndecidedYear.text = itemMain.UNDECIDE_NO_YEAR_2 != null ? _convertNoYear(itemMain.UNDECIDE_NO_YEAR_2).toString() : "";

    editCourtofAppealsDecidedCase.text = itemMain.DECIDE_NO_2 != 0 ? itemMain.DECIDE_NO_2.toString() : "";
    editCourtofAppealsDecidedYear.text = itemMain.DECIDE_NO_YEAR_2 != null ? _convertNoYear(itemMain.DECIDE_NO_YEAR_2).toString() : "";

    editSupremeCourtUndecidedCase.text = itemMain.UNJUDGEMENT_NO != null ? itemMain.UNJUDGEMENT_NO.toString() : "";
    editSupremeCourtUndecidedYear.text = itemMain.UNJUDGEMENT_NO_YEAR != null ? _convertNoYear(itemMain.UNJUDGEMENT_NO_YEAR).toString() : "";

    editSupremeCourtDecidedCase.text = itemMain.JUDGEMENT_NO != 0 ? itemMain.JUDGEMENT_NO.toString() : "";
    editSupremeCourtDecidedYear.text = itemMain.JUDGEMENT_NO_YEAR != null ? _convertNoYear(itemMain.JUDGEMENT_NO_YEAR).toString() : "";

    editDateReadCase.text = _convertDate(itemMain.JUDGEMENT_DATE);
    _initDate = DateTime.parse(itemMain.JUDGEMENT_DATE);
    editTimeReadCase.text = dateFormatTime.format(DateTime.parse(itemMain.JUDGEMENT_DATE)).toString();
    _initTime = DateTime.parse(itemMain.JUDGEMENT_DATE);

    editDateFine.text = _convertDate(itemMain.FINE_DATE);
    _dtDateFine = DateTime.parse(itemMain.FINE_DATE);

    if (itemMain.IS_PAYONCE == 1) {
      editDateBill.text = _convertDate(itemMain.PAYMENT_DATE);
      _dtDateBill = DateTime.parse(itemMain.PAYMENT_DATE);
    } else {
      editPeriodNum.text = itemMain.PAYMENT_PERIOD.toInt().toString();
      editPeriod.text = itemMain.PAYMENT_PERIOD_DUE.toInt().toString();
      dropdownItemsFine.forEach((f) {
        if (f.DateUnitID == itemMain.PAYMENT_PERIOD_DUE_UNIT) {
          dropdownValueFine = f;
        }
      });
    }

    if (itemMain.IS_DISMISS == 1) {
      _isDismissed = true;
    }
    if (itemMain.IS_FINE == 1) {
      _isFine = true;
      if (itemMain.IS_PAYONCE == 1) {
        _isOneTime = true;
        _isPeriod = false;
      } else {
        _isOneTime = false;
        _isPeriod = true;
      }
    }
    if (itemMain.IS_IMPRISON == 1) {
      _isImprison = true;
    }

    dropdownItemsPaymentChannel.forEach((f) {
      if (f.ChannelID == itemMain.PAYMENT_CHANNEL) {
        dropdownValuePaymentChannel = f;
      }
    });
    editBookBank.text = itemMain.PAYMENT_REF_NO;
    dropdownItemsBank.forEach((f) {
      if (f.BankID == itemMain.PAYMENT_BANK) {
        dropdownValueBank = f;
      }
    });
    editCheckValue.text = formatter_fine.format(itemMain.FINE);
    editImprison.text = itemMain.IMPRISON_TIME.toInt().toString();
    dropdownItemsImprison.forEach((f) {
      if (f.DateUnitID == itemMain.IMPRISON_TIME_UNIT) {
        dropdownValueImprison = f;
      }
    });
  }

  // set text data ชำระเป็นงวด
  void _setInitData2() {
    /*String sentence_date = "";
    String fine_date = "";
    DateTime dt_sentence_date = DateTime.parse(itemMain.JUDGEMENT_DATE);
    */ /*DateTime dt_fine_date = DateTime.parse(itemMain.FINE_DATE);*/ /*
    DateTime dt_fine_date = itemMain.FINE_DATE!=null
        ?DateTime.parse(itemMain.FINE_DATE)
        :DateTime.now();
    List splitsSentenceDate = dateFormatDate.format(dt_sentence_date).toString().split(
        " ");
    List splitsFineDate = dateFormatDate.format(dt_fine_date).toString().split(
        " ");
    sentence_date = splitsSentenceDate[0] + " " + splitsSentenceDate[1] + " " +
        (int.parse(splitsSentenceDate[3]) + 543).toString();
    fine_date = splitsFineDate[0] + " " + splitsFineDate[1] + " " +
        (int.parse(splitsFineDate[3]) + 543).toString();

    String DECIDE_NO_YEAR_2 = "";
    String UNDECIDE_NO_YEAR_2 = "";
    DateTime dt_Decide_date = DateTime.parse(itemMain.DECIDE_NO_YEAR_2);
    DateTime dt_Undecide_date = DateTime.parse(itemMain.UNDECIDE_NO_YEAR_2);
    List splitsDecideDate = dateFormatDate.format(dt_Decide_date).toString().split(
        " ");
    List splitsUndecideDate = dateFormatDate.format(dt_Undecide_date).toString().split(
        " ");
    DECIDE_NO_YEAR_2=(int.parse(splitsDecideDate[3]) + 543).toString();
    UNDECIDE_NO_YEAR_2=(int.parse(splitsUndecideDate[3]) + 543).toString();


    editCourtName.text=itemMain.COURT_NAME;
    */ /*editUndecidedCase.text=itemMain.UNDECIDE_NO_2.toString()+"/"+UNDECIDE_NO_YEAR_2;
    editDecidedCase.text=itemMain.DECIDE_NO_2.toString()+"/"+DECIDE_NO_YEAR_2;*/ /*
    editFineValue.text=formatter1.format(itemMain.FINE).toString();
    editImprison.text=formatter1.format(itemMain.IMPRISON_TIME).toString();
    if(itemMain.IMPRISON_TIME_UNIT==0){
      dropdownValueImprison = "วัน";
    }else if(itemMain.IMPRISON_TIME_UNIT==1){
      dropdownValueImprison = "เดือน";
    }else{
      dropdownValueImprison = "ปี";
    }
    _currentDate=sentence_date;
    _currentDateFine=fine_date;

    editDateReadCase.text= _currentDate;
    editDateFine.text=_currentDateFine;
    editPeriod.text=itemMain.PAYMENT_PERIOD.toString();
    editPeriodNum.text=itemMain.PAYMENT_PERIOD_DUE.toString();

    if(itemMain.PAYMENT_PERIOD_DUE_UNIT==0){
      dropdownValueFine = "วัน";
    }else if(itemMain.PAYMENT_PERIOD_DUE_UNIT==1){
      dropdownValueFine = "สัปดาห์";
    }else if(itemMain.PAYMENT_PERIOD_DUE_UNIT==2){
      dropdownValueFine = "เดือน";
    }else{
      dropdownValueFine = "ปี";
    }*/
  }

  //ล้างย้อมูลใน textfield
  void clearTextfield() {
    editCourtName.clear();
    /*editUndecidedCase.clear();
    editDecidedCase.clear();*/
    editFineValue.clear();
    editImprison.clear();
    editPeriod.clear();
    editPeriodNum.clear();
  }

  //popup เมื่อกดแก้ไขหรือลบ
  void choiceAction(Constants constants) {
    print(constants.text);
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _onSaved = false;
        _onFinish = false;
        _onEdited = true;
        _setInitData1();
      } else {
        _showDeleteAlertDialog();
      }
    });
  }

  //popup delete
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

                onSaved(context, true);
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showDeleteAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog();
      },
    );
  }

  // popup layout ยกเลิกรายการ
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
                  /*setState(() {
                   print(_arrItemsImageFile.length);
                    print(_arrItemsImageFileInit.length);

                   */ /* if (_arrItemsImageFileAdd.length > 0) {
                      for (int i = (_arrItemsImageFile.length -
                          _arrItemsImageFileAdd.length); i <
                          _arrItemsImageFile.length + 1; i++) {
                        print("index : " + i.toString());
                        _arrItemsImageFile.removeAt(i);
                      }
                    }
                    if (_arrItemsImageFileDelete.length > 0) {
                      _arrItemsImageFile = _arrItemsImageFileInit;
                    }*/ /*
                    _arrItemsImageFile = _arrItemsImageFileInit;

                    _arrItemsImageFileAdd = [];
                    _arrItemsImageFileDelete = [];


                    _onSaved = true;
                    _onFinish = true;
                  });*/
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
    Map map = {"LAWSUIT_ID": itemMain.LAWSUIT_ID};
    await new LawsuitFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
      itemsLawsuitMain = onValue;
      itemsLawsuitMain.LawsuitDetail.forEach((f) {
        if (itemMain.LAWSUIT_DETAIL_ID == f.LAWSUIT_DETAIL_ID) {
          itemMain = f;
        }
      });
    });

    Map map_doc = {"DOCUMENT_TYPE": 4, "REFERENCE_CODE": itemMain.LAWSUIT_DETAIL_ID};
    await new TransectionFuture().apiRequestGetDocumentByCon(map_doc).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((f) {
        if (int.parse(f.IS_ACTIVE) == 1) {
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
        }
      });
      widget.itemDocument = items;
      _arrItemsImageFile = items;
      _arrItemsImageFileInit = items;
      setState(() {});
    });

    _arrItemsImageFileDelete = [];
    _arrItemsImageFileAdd = [];

    _onSaved = true;
    _onFinish = true;
    _onEdited = false;

    setState(() {});
    return true;
  }

  // popup method ยกเลิกรายการ
  void _showCancelAlertDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelAlertDialog(context);
      },
    );
  }

  //แสดง popup ปฏิทิน วันอ่านคำพิพากษา
  Future<DateTime> _selectDateSentence(context) async {
    return await showDatePicker(
      context: context,
      firstDate: _initDate,
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }

  //แสดง popup ปฏิทิน วันที่กำหนดชำระค่าปรับของผู้ต้องหา
  Future<DateTime> _selectDateFine(context) async {
    return await showDatePicker(
      context: context,
      firstDate: _initDate,
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }

  //get file รูปภาพ
  Future getImage(ImageSource source, mContext) async {
    //var image = await FilePicker.getMultiFilePath(type: source, fileExtension: "FROM ANY");
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      if (_onEdited) {
        _arrItemsImageFileAdd.add(new ItemsListDocument(
          FILE_CONTENT: image,
          DOCUMENT_OLD_NAME: image.path,
        ));
      }
      _arrItemsImageFile.add(new ItemsListDocument(FILE_CONTENT: image, DOCUMENT_NAME: image.path, DOCUMENT_OLD_NAME: image.path));
    });
    Navigator.pop(mContext);
  }

  //get file
  Future getFile(FileType source, mContext) async {
    var image = await FilePicker.getMultiFilePath(type: source, fileExtension: "FROM ANY");
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < image.length; i++) {
        String _name = image.keys.toList()[i];
        File _path = File(image.values.toList()[i].toString());

        if (_onEdited) {
          _arrItemsImageFileAdd.add(new ItemsListDocument(FILE_CONTENT: _path, DOCUMENT_NAME: _name, DOCUMENT_OLD_NAME: image.values.toList()[i].toString()));
        }
        _arrItemsImageFile.add(new ItemsListDocument(FILE_CONTENT: _path, DOCUMENT_NAME: _name, DOCUMENT_OLD_NAME: image.values.toList()[i].toString()));
      }
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
                  //getImage(ImageSource.gallery,context);
                  getFile(FileType.ANY, context);
                },
              ),
            ],
          )
        ],
      ),
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

  Future<DateTime> _selectDate(context) async {
    return await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.year,
      locale: Locale('th', 'TH'),
      firstDate: DateTime(2018),
      initialDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
  }

  //key press ชื่อศาล
  ItemsLawsuitMasCourt itemsLawsuitMasCourt;
  AutoCompleteTextField _textListCourt;
  GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsLawsuitMasCourt>>();
  void setAutoCompleteTitle() {
    _textListCourt = new AutoCompleteTextField<ItemsLawsuitMasCourt>(
      style: textStyleData,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListCourt.controller.text = item.COURT_NAME.toString();
          itemsLawsuitMasCourt = item;
        });
      },
      key: key,
      controller: editCourtName,
      suggestions: widget.itemsLawsuitMasCourt,
      itemBuilder: (context, suggestion) => itemsLawsuitMasCourt == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.COURT_NAME.toString(), style: textStyleData),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.COURT_ID == b.COURT_ID ? 0 : a.COURT_ID > b.COURT_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        itemsLawsuitMasCourt = null;
        return (suggestion.COURT_NAME != null ? suggestion.COURT_NAME : suggestion.COURT_NAME).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  Widget _buildCourtBody() {
    Widget _content;
    var size = MediaQuery.of(context).size;

    if (dropdownValueCourtEnd != null) {
      if (dropdownValueCourtEnd.CourtEndID == 0) {
        _content = //ศาลชั้นต้น
            Container(
                padding: paddingLabel,
                //width: ((size.width*100)/100)/1.5,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "หมายเลขคดีดำศาลชั้นต้น",
                                  style: textStyleLabel,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: (((size.width * 100) / 100) / 2) / 2.5,
                                    child: Container(
                                      padding: paddingLabel,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                            child: TextField(
                                              focusNode: myFocusNodeCivilCourtUndecidedCase,
                                              controller: editCivilCourtUndecidedCase,
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
                                  ),
                                  new Padding(
                                    padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                                    child: new Text(
                                      "/",
                                      style: textStyleData,
                                    ),
                                  ),
                                  Container(
                                    width: (((size.width * 100) / 100) / 2) / 2.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          //padding: paddingData,
                                          child: TextField(
                                            enableInteractiveSelection: false,
                                            onTap: () {},
                                            focusNode: myFocusNodeCivilCourtUndecidedYear,
                                            controller: editCivilCourtUndecidedYear,
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
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หมายเลขคดีแดงศาลชั้นต้น",
                                style: textStyleLabel,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: (((size.width * 100) / 100) / 2) / 2.5,
                                  child: Container(
                                    padding: paddingLabel,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          //padding: paddingData,
                                          child: TextField(
                                            focusNode: myFocusNodeCivilCourtDecidedCase,
                                            controller: editCivilCourtDecidedCase,
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
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                                  child: new Text(
                                    "/",
                                    style: textStyleData,
                                  ),
                                ),
                                Container(
                                  width: (((size.width * 100) / 100) / 2) / 2.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeCivilCourtDecidedYear,
                                          controller: editCivilCourtDecidedYear,
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
                          ],
                        )
                      ],
                    )));
      } else if (dropdownValueCourtEnd.CourtEndID == 1) {
        _content = //ศาลอุทรณ์
            Container(
                padding: paddingLabel,
                //width: ((size.width*100)/100)/1.5,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "หมายเลขคดีดำศาลอุทรณ์",
                                  style: textStyleLabel,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: (((size.width * 100) / 100) / 2) / 2.5,
                                    child: Container(
                                      padding: paddingLabel,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                            child: TextField(
                                              focusNode: myFocusNodeCourtofAppealsUndecidedCase,
                                              controller: editCourtofAppealsUndecidedCase,
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
                                  ),
                                  new Padding(
                                    padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                                    child: new Text(
                                      "/",
                                      style: textStyleData,
                                    ),
                                  ),
                                  Container(
                                    width: (((size.width * 100) / 100) / 2) / 2.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          //padding: paddingData,
                                          child: TextField(
                                            enableInteractiveSelection: false,
                                            onTap: () {},
                                            focusNode: myFocusNodeCourtofAppealsUndecidedYear,
                                            controller: editCourtofAppealsUndecidedYear,
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
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หมายเลขคดีแดงศาลอุทรณ์",
                                style: textStyleLabel,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: (((size.width * 100) / 100) / 2) / 2.5,
                                  child: Container(
                                    padding: paddingLabel,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          //padding: paddingData,
                                          child: TextField(
                                            focusNode: myFocusNodeCourtofAppealsDecidedCase,
                                            controller: editCourtofAppealsDecidedCase,
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
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                                  child: new Text(
                                    "/",
                                    style: textStyleData,
                                  ),
                                ),
                                Container(
                                  width: (((size.width * 100) / 100) / 2) / 2.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeCourtofAppealsDecidedYear,
                                          controller: editCourtofAppealsDecidedYear,
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
                          ],
                        )
                      ],
                    )));
      } else if (dropdownValueCourtEnd.CourtEndID == 2) {
        _content = //ศาลฎีกา
            Container(
                padding: paddingLabel,
                //width: ((size.width*100)/100)/1.5,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "หมายเลขคดีดำศาลฎีกา",
                                  style: textStyleLabel,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: (((size.width * 100) / 100) / 2) / 2.5,
                                    child: Container(
                                      padding: paddingLabel,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                            child: TextField(
                                              focusNode: myFocusNodeSupremeCourtUndecidedCase,
                                              controller: editSupremeCourtUndecidedCase,
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
                                  ),
                                  new Padding(
                                    padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                                    child: new Text(
                                      "/",
                                      style: textStyleData,
                                    ),
                                  ),
                                  Container(
                                    width: (((size.width * 100) / 100) / 2) / 2.5,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          //padding: paddingData,
                                          child: TextField(
                                            enableInteractiveSelection: false,
                                            onTap: () {},
                                            focusNode: myFocusNodeSupremeCourtUndecidedYear,
                                            controller: editSupremeCourtUndecidedYear,
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
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หมายเลขคดีแดงศาลฎีกา",
                                style: textStyleLabel,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: (((size.width * 100) / 100) / 2) / 2.5,
                                  child: Container(
                                    padding: paddingLabel,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        new Container(
                                          //padding: paddingData,
                                          child: TextField(
                                            focusNode: myFocusNodeSupremeCourtDecidedCase,
                                            controller: editSupremeCourtDecidedCase,
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
                                ),
                                new Padding(
                                  padding: EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
                                  child: new Text(
                                    "/",
                                    style: textStyleData,
                                  ),
                                ),
                                Container(
                                  width: (((size.width * 100) / 100) / 2) / 2.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        //padding: paddingData,
                                        child: TextField(
                                          focusNode: myFocusNodeSupremeCourtDecidedYear,
                                          controller: editSupremeCourtDecidedYear,
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
                          ],
                        )
                      ],
                    )));
      } else {
        _content = Container();
      }
    } else {
      _content = Container();
    }

    return _content;
  }

  //ส่วนของ body
  Widget _buildContent() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Column(
        children: <Widget>[
          Container(
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
                /*Container(
                      padding: paddingLabel,
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 18.0,top: 8,bottom: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isDismissed = !_isDismissed;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: _isDismissed ? Color(0xff3b69f3) : Colors
                                      .white,
                                  border: Border.all(color: Colors.black38,width: 1.5),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: _isDismissed
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
                              "ศาลยกฟ้อง", style: textStyleLabel,),
                          ),
                        ],
                      ),
                    ),*/
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ชื่อผู้ต้องหา",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    indicmentDetail.TITLE_SHORT_NAME_TH.toString() + "" + indicmentDetail.FIRST_NAME.toString() + " " + indicmentDetail.LAST_NAME.toString(),
                    style: textStyleData,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "ชื่อศาล",
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
                      _textListCourt,
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
                    "คำพิพากษาสิ้นสุดชั้น",
                    style: textStyleLabel,
                  ),
                ),
                Container(
                  width: (size.width * 90) / 100,
                  padding: paddingData,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<ListCourtEndModel>(
                      value: dropdownValueCourtEnd,
                      onChanged: (ListCourtEndModel newValue) {
                        setState(() {
                          dropdownValueCourtEnd = newValue;
                        });
                      },
                      items: dropdownItemsCourtEnd.map<DropdownMenuItem<ListCourtEndModel>>((ListCourtEndModel value) {
                        return DropdownMenuItem<ListCourtEndModel>(
                          value: value,
                          child: Text(
                            value.CourtEndName,
                            style: textStyleData1,
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
                _buildCourtBody(),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "วันอ่านคำพิพากษา",
                    style: textStyleLabel,
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
                                    Current: _initDate);
                              }).then((s) {
                            String date = "";
                            List splits = dateFormatDate.format(
                                s).toString().split(" ");
                            date = splits[0] + " " + splits[1] +
                                " " +
                                (int.parse(splits[3]) + 543)
                                    .toString();
                            setState(() {
                              _initDate = s;
                              _currentDate = date;
                              editDateReadCase.text = _currentDate;
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
                              initialDateTime: _initDate,
                              onDateTimeChanged: (DateTime s) {
                                setState(() {
                                  String date = "";
                                  List splits = dateFormatDate.format(s).toString().split(" ");
                                  date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                  _initDate = s;
                                  _currentDate = date;
                                  editDateReadCase.text = _currentDate;
                                });
                              },
                            ),
                          );
                        },
                      );
                    },
                    focusNode: myFocusNodeDateReadCase,
                    controller: editDateReadCase,
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
                    "เวลาอ่านคำพิพากษา",
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
                              initialDateTime: _initTime,
                              onDateTimeChanged: (DateTime newDateTime) {
                                setState(() {
                                  _initTime = newDateTime;
                                  _currentTime = dateFormatTime.format(_initTime).toString();
                                  editTimeReadCase.text = _currentTime;

                                  List splitsArrestDate = _initDate.toUtc().toLocal().toString().split(" ");
                                  List splitsArrestTime = _initTime.toString().split(" ");
                                  _dtcurrentDate = DateTime.parse(splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString());

                                  print("_currentDate : " + _dtcurrentDate.toString());
                                });
                              },
                            ),
                          );
                        },
                      );
                    },
                    focusNode: myFocusNodeTimeReadCase,
                    controller: editTimeReadCase,
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
                    "คำพิพากษาศาล",
                    style: textStyleLabel,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isDismissed = !_isDismissed;
                              if (_isDismissed) {
                                _isImprison = false;
                                _isFine = false;
                              }
                            });
                          },
                          child: Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 18.0, left: 12.0, bottom: 8, top: 8),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isDismissed = !_isDismissed;
                                        if (_isDismissed) {
                                          _isImprison = false;
                                          _isFine = false;
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: _isDismissed ? Color(0xff3b69f3) : Colors.white,
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: _isDismissed
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
                                    "ศาลยกฟ้อง",
                                    style: textStyleData1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isFine = !_isFine;
                              if (_isFine) {
                                _isDismissed = false;
                              }
                            });
                          },
                          child: Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 18.0, left: 12.0, bottom: 8, top: 8),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isFine = !_isFine;
                                        if (_isFine) {
                                          _isDismissed = false;
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: _isFine ? Color(0xff3b69f3) : Colors.white,
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: _isFine
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
                                    "ศาลสั่งปรับ",
                                    style: textStyleData1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        _isFine
                            ? Container(
                                padding: EdgeInsets.only(right: 18.0, left: 12.0, bottom: 8, top: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    /*Container(
                                      padding: paddingLabel,
                                      child: Text("ค่าปรับ",
                                        style: textStyleLabel,),
                                    ),
                                    Container(
                                      padding: paddingData,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: <Widget>[
                                          new Container(
                                            //padding: paddingData,
                                            child: TextField(
                                              focusNode: myFocusNodeFineValue,
                                              controller: editFineValue,
                                              keyboardType: TextInputType
                                                  .number,
                                              textCapitalization: TextCapitalization
                                                  .words,
                                              style: textStyleData,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  suffixText: 'บาท',
                                                  suffixStyle: textStyleSubData
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
                                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              padding: paddingLabel,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(right: 18.0, left: 12.0, bottom: 8, top: 8),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _isOneTime = true;
                                                          _isPeriod = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: _isOneTime ? Color(0xff3b69f3) : Colors.white,
                                                          border: Border.all(color: Colors.black12),
                                                        ),
                                                        child: Padding(
                                                            padding: const EdgeInsets.all(4.0),
                                                            child: _isOneTime
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
                                                      "ชำระครั้งเดียว",
                                                      style: textStyleData1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: paddingLabel,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(right: 18.0, left: 12.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _isPeriod = true;
                                                          _isOneTime = false;
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: _isPeriod ? Color(0xff3b69f3) : Colors.white,
                                                          border: Border.all(color: Colors.black12),
                                                        ),
                                                        child: Padding(
                                                            padding: const EdgeInsets.all(4.0),
                                                            child: _isPeriod
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
                                                      "เเบ่งชำระเป็นงวด",
                                                      style: textStyleData1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                                    _isPeriod
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: paddingLabel,
                                                child: Text(
                                                  "จำนวนงวด",
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
                                                        focusNode: myFocusNodePeriodNum,
                                                        controller: editPeriodNum,
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
                                                  "วันที่เริ่มชำระค่าปรับ",
                                                  style: textStyleLabel,
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
                                                  builder: (
                                                      BuildContext context) {
                                                    return DynamicDialog(
                                                        Current: _dtDateStartPayment);
                                                  }).then((s) {
                                                String date = "";
                                                List splits = dateFormatDate
                                                    .format(
                                                    s).toString().split(" ");
                                                date = splits[0] + " " +
                                                    splits[1] +
                                                    " " +
                                                    (int.parse(splits[3]) +
                                                        543)
                                                        .toString();
                                                setState(() {
                                                  _dtDateStartPayment = s;
                                                  _currentDateStartPayment =
                                                      date;
                                                  editDateStartPayment.text =
                                                      _currentDateStartPayment;
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
                                                            initialDateTime: _dtDateStartPayment,
                                                            onDateTimeChanged: (DateTime s) {
                                                              setState(() {
                                                                String date = "";
                                                                List splits = dateFormatDate.format(s).toString().split(" ");
                                                                date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                                                _dtDateStartPayment = s;
                                                                _currentDateStartPayment = date;
                                                                editDateStartPayment.text = _currentDateStartPayment;
                                                              });
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  focusNode: myFocusNodeStartPayment,
                                                  controller: editDateStartPayment,
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
                                          )
                                        : Container(),
                                    _isPeriod
                                        ? SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  width: ((size.width * 80) / 100) / 2,
                                                  padding: EdgeInsets.only(right: 12.0),
                                                  child: Container(
                                                    padding: paddingData,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          padding: paddingLabel,
                                                          child: Text(
                                                            "รอบชำระค่าปรับทุก",
                                                            style: textStyleLabel,
                                                          ),
                                                        ),
                                                        new Container(
                                                          //padding: paddingData,
                                                          child: TextField(
                                                            focusNode: myFocusNodePeriod,
                                                            controller: editPeriod,
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
                                                ),
                                                Container(
                                                  width: ((size.width * 80) / 100) / 2,
                                                  child: Container(
                                                    padding: paddingData,
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
                                                        new Container(
                                                          width: ((size.width * 80) / 100) / 2,
                                                          //padding: paddingData,
                                                          child: DropdownButtonHideUnderline(
                                                            child: DropdownButton<ListDateUnitModel>(
                                                              value: dropdownValueFine,
                                                              onChanged: (ListDateUnitModel newValue) {
                                                                setState(() {
                                                                  dropdownValueFine = newValue;
                                                                });
                                                              },
                                                              items: dropdownItemsFine.map<DropdownMenuItem<ListDateUnitModel>>((ListDateUnitModel value) {
                                                                return DropdownMenuItem<ListDateUnitModel>(
                                                                  value: value,
                                                                  child: Text(
                                                                    value.DateUnitName,
                                                                    style: textStyleData1,
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
                                                ),
                                              ],
                                            ),
                                          )
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: paddingLabel,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: paddingLabel,
                                                      child: Text(
                                                        "วันที่กำหนดชำระค่าปรับของผู้ต้องหา",
                                                        style: textStyleLabel,
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
                                                        builder: (
                                                            BuildContext context) {
                                                          return DynamicDialog(
                                                              Current: _dtDateFine);
                                                        }).then((s) {
                                                      String date = "";
                                                      List splits = dateFormatDate
                                                          .format(
                                                          s).toString().split(
                                                          " ");
                                                      date = splits[0] + " " +
                                                          splits[1] +
                                                          " " +
                                                          (int.parse(
                                                              splits[3]) +
                                                              543)
                                                              .toString();
                                                      setState(() {
                                                        _dtDateFine = s;
                                                        _currentDateFine = date;
                                                        editDateFine.text =
                                                            _currentDateFine;
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
                                                                  initialDateTime: _dtDateFine,
                                                                  onDateTimeChanged: (DateTime s) {
                                                                    setState(() {
                                                                      String date = "";
                                                                      List splits = dateFormatDate.format(s).toString().split(" ");
                                                                      date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                                                      _dtDateFine = s;
                                                                      _currentDateFine = date;
                                                                      editDateFine.text = _currentDateFine;
                                                                    });
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        focusNode: myFocusNodeDateFine,
                                                        controller: editDateFine,
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
                                              Container(
                                                padding: paddingLabel,
                                                child: Text(
                                                  "วันที่รับเงินจากศาล",
                                                  style: textStyleLabel,
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
                                                  builder: (
                                                      BuildContext context) {
                                                    return DynamicDialog(
                                                        Current: _dtDateBill);
                                                  }).then((s) {
                                                String date = "";
                                                List splits = dateFormatDate
                                                    .format(
                                                    s).toString().split(" ");
                                                date = splits[0] + " " +
                                                    splits[1] +
                                                    " " +
                                                    (int.parse(splits[3]) +
                                                        543)
                                                        .toString();
                                                setState(() {
                                                  _dtDateBill = s;
                                                  _currentDateBill = date;
                                                  editDateBill.text =
                                                      _currentDateFine;
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
                                                            initialDateTime: _dtDateBill,
                                                            onDateTimeChanged: (DateTime s) {
                                                              setState(() {
                                                                String date = "";
                                                                List splits = dateFormatDate.format(s).toString().split(" ");
                                                                date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                                                _dtDateBill = s;
                                                                _currentDateBill = date;
                                                                editDateBill.text = _currentDateFine;
                                                              });
                                                            },
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  focusNode: myFocusNodeDateBill,
                                                  controller: editDateBill,
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
                                                  "ช่องทางการชำระเงินจากศาล",
                                                  style: textStyleLabel,
                                                ),
                                              ),
                                              Container(
                                                padding: paddingData,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    new Container(
                                                      width: size.width,
                                                      //padding: paddingData,
                                                      child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<ListChannelModel>(
                                                          value: dropdownValuePaymentChannel,
                                                          onChanged: (ListChannelModel newValue) {
                                                            setState(() {
                                                              dropdownValuePaymentChannel = newValue;
                                                            });
                                                          },
                                                          items: dropdownItemsPaymentChannel.map<DropdownMenuItem<ListChannelModel>>((ListChannelModel value) {
                                                            return DropdownMenuItem<ListChannelModel>(
                                                              value: value,
                                                              child: Text(
                                                                value.ChannelName,
                                                                style: textStyleData1,
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
                                              Container(
                                                padding: paddingLabel,
                                                child: Text(
                                                  "เลขที่เช็ค/เลขที่บัญชี",
                                                  style: textStyleLabel,
                                                ),
                                              ),
                                              Padding(
                                                padding: paddingData,
                                                child: TextField(
                                                  focusNode: myFocusNodeBookBank,
                                                  controller: editBookBank,
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
                                              Container(
                                                padding: paddingLabel,
                                                child: Text(
                                                  "ธนาคาร",
                                                  style: textStyleLabel,
                                                ),
                                              ),
                                              Container(
                                                padding: paddingData,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    new Container(
                                                      width: size.width,
                                                      //padding: paddingData,
                                                      child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<ListBankModel>(
                                                          value: dropdownValueBank,
                                                          onChanged: (ListBankModel newValue) {
                                                            setState(() {
                                                              dropdownValueBank = newValue;
                                                            });
                                                          },
                                                          items: dropdownItemsBank.map<DropdownMenuItem<ListBankModel>>((ListBankModel value) {
                                                            return DropdownMenuItem<ListBankModel>(
                                                              value: value,
                                                              child: Text(
                                                                value.BankName,
                                                                style: textStyleData1,
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
                                              Container(
                                                padding: paddingLabel,
                                                child: Text(
                                                  "จำนวนเงินจากศาล",
                                                  style: textStyleLabel,
                                                ),
                                              ),
                                              Padding(
                                                padding: paddingData,
                                                child: TextField(
                                                  focusNode: myFocusNodeCheckValue,
                                                  controller: editCheckValue,
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
                                  ],
                                ))
                            : Container(),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isImprison = !_isImprison;
                              if (_isImprison) {
                                _isDismissed = false;
                              }
                            });
                          },
                          child: Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 18.0, left: 12.0, bottom: 8, top: 8),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isImprison = !_isImprison;
                                        if (_isImprison) {
                                          _isDismissed = false;
                                        }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: _isImprison ? Color(0xff3b69f3) : Colors.white,
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: _isImprison
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
                                    "ศาลสั่งจำคุก",
                                    style: textStyleData1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        _isImprison
                            ? Container(
                                padding: EdgeInsets.only(right: 18.0, left: 12.0, bottom: 8, top: 8),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment
                                  //     .spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      // width: ((size.width * 80) / 100) / 2,
                                      width: size.width,
                                      padding: EdgeInsets.only(right: 12.0),
                                      child: Container(
                                        padding: paddingData,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                "สั่งจำคุกเป็นเวลา",
                                                style: textStyleLabel,
                                              ),
                                            ),
                                            new Container(
                                              //padding: paddingData,
                                              child: TextField(
                                                focusNode: myFocusNodeImprison,
                                                controller: editImprison,
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
                                    ),
                                    // Container(
                                    //   width: ((size.width * 80) / 100) / 2,
                                    // child: Container(
                                    //padding: paddingData,
                                    // child: Column(
                                    //   crossAxisAlignment: CrossAxisAlignment
                                    //       .start,
                                    //   children: <Widget>[
                                    //     // Container(
                                    //     //   //padding: paddingLabel,
                                    //     //   child: Text("หน่วย",
                                    //     //     style: textStyleLabel,),
                                    //     // ),
                                    //     // new Container(
                                    //     //   width: ((size.width * 80) / 100) / 2,
                                    //     //   child: DropdownButtonHideUnderline(
                                    //     //     child: DropdownButton<
                                    //     //         ListDateUnitModel>(
                                    //     //       value: dropdownValueImprison,
                                    //     //       onChanged: (
                                    //     //           ListDateUnitModel newValue) {
                                    //     //         setState(() {
                                    //     //           dropdownValueImprison =
                                    //     //               newValue;
                                    //     //         });
                                    //     //       },
                                    //     //       items: dropdownItemsImprison
                                    //     //           .map<DropdownMenuItem<
                                    //     //           ListDateUnitModel>>((
                                    //     //           ListDateUnitModel value) {
                                    //     //         return DropdownMenuItem<
                                    //     //             ListDateUnitModel>(
                                    //     //           value: value,
                                    //     //           child: Text(value.DateUnitName,
                                    //     //             style: textStyleData1,),
                                    //     //         );
                                    //     //       })
                                    //     //           .toList(),
                                    //     //     ),
                                    //     //   ),
                                    //     // ),
                                    //     // Container(
                                    //     //   height: 1.0,
                                    //     //   color: Colors.grey[300],
                                    //     // ),
                                    //   ],
                                    // ),
                                    // ),
                                    // ),
                                  ],
                                ))
                            : Container()
                      ],
                    )),
              ],
            ),
          ),
          Container(
            width: size.width,
            child: _buildButtonImgPicker(),
          ),
          _buildDataImage(context),
        ],
      ),
    ));
  }

  Widget _buildCourtBody_saved(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Widget _content;

    if ((itemMain.UNDECIDE_NO_1 != 0 || itemMain.UNDECIDE_NO_YEAR_1 != null) && (itemMain.DECIDE_NO_1 != 0 || itemMain.DECIDE_NO_YEAR_1 != null)) {
      _content = //ศาลชั้นต้น
          Container(
              padding: paddingLabel,
              //width: ((size.width*100)/100)/1.5,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หมายเลขคดีดำศาลชั้นต้น",
                                style: textStyleLabel,
                              ),
                            ),
                            Container(
                              width: (((size.width * 100) / 100) / 2) / 2.5,
                              child: Container(
                                padding: paddingData,
                                child: Text(
                                  itemMain.UNDECIDE_NO_1 != 0 && itemMain.UNDECIDE_NO_YEAR_1 != null ? (itemMain.UNDECIDE_NO_1.toString() + "/" + _convertNoYear(itemMain.UNDECIDE_NO_YEAR_1).toString()) : "",
                                  style: textStyleData,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "หมายเลขคดีแดงศาลชั้นต้น",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            width: (((size.width * 100) / 100) / 2) / 2.5,
                            child: Container(
                              padding: paddingData,
                              child: Text(
                                itemMain.DECIDE_NO_1 != 0 && itemMain.DECIDE_NO_YEAR_1 != null ? (itemMain.DECIDE_NO_1.toString() + "/" + _convertNoYear(itemMain.DECIDE_NO_YEAR_1).toString()) : "",
                                style: textStyleData,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )));

      dropdownValueCourtEnd = dropdownItemsCourtEnd[0];
    } else if ((itemMain.UNDECIDE_NO_2 != 0 || itemMain.UNDECIDE_NO_YEAR_2 != null) && (itemMain.DECIDE_NO_2 != 0 || itemMain.DECIDE_NO_YEAR_2 != null)) {
      _content = //ศาลอุทรณ์
          Container(
              padding: paddingLabel,
              //width: ((size.width*100)/100)/1.5,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หมายเลขคดีดำศาลอุทรณ์",
                                style: textStyleLabel,
                              ),
                            ),
                            Container(
                              width: (((size.width * 100) / 100) / 2) / 2.5,
                              child: Container(
                                padding: paddingData,
                                child: Text(
                                  itemMain.UNDECIDE_NO_2 != 0 && itemMain.UNDECIDE_NO_YEAR_2 != null ? (itemMain.UNDECIDE_NO_2.toString() + "/" + _convertNoYear(itemMain.UNDECIDE_NO_YEAR_2).toString()) : "",
                                  style: textStyleData,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "หมายเลขคดีแดงศาลอุทรณ์",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            width: (((size.width * 100) / 100) / 2) / 2.5,
                            child: Container(
                              padding: paddingData,
                              child: Text(
                                itemMain.DECIDE_NO_2 != 0 && itemMain.DECIDE_NO_YEAR_2 != null ? (itemMain.DECIDE_NO_2.toString() + "/" + _convertNoYear(itemMain.DECIDE_NO_YEAR_2).toString()) : "",
                                style: textStyleData,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )));
      dropdownValueCourtEnd = dropdownItemsCourtEnd[1];
    } else if ((itemMain.UNJUDGEMENT_NO != 0 || itemMain.UNJUDGEMENT_NO_YEAR != null) && (itemMain.JUDGEMENT_NO != 0 || itemMain.JUDGEMENT_NO_YEAR != null)) {
      _content = //ศาลฎีกา
          Container(
              padding: paddingLabel,
              //width: ((size.width*100)/100)/1.5,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หมายเลขคดีดำศาลฎีกา",
                                style: textStyleLabel,
                              ),
                            ),
                            Container(
                              width: (((size.width * 100) / 100) / 2) / 2.5,
                              child: Container(
                                padding: paddingData,
                                child: Text(
                                  itemMain.UNJUDGEMENT_NO != 0 && itemMain.UNJUDGEMENT_NO_YEAR != null ? (itemMain.UNJUDGEMENT_NO.toString() + "/" + _convertNoYear(itemMain.UNJUDGEMENT_NO_YEAR).toString()) : "",
                                  style: textStyleData,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "หมายเลขคดีแดงศาลฎีกา",
                              style: textStyleLabel,
                            ),
                          ),
                          Container(
                            width: (((size.width * 100) / 100) / 2) / 2.5,
                            child: Container(
                              padding: paddingData,
                              child: Text(
                                itemMain.JUDGEMENT_NO != 0 && itemMain.JUDGEMENT_NO_YEAR != null ? (itemMain.JUDGEMENT_NO.toString() + "/" + _convertNoYear(itemMain.JUDGEMENT_NO_YEAR).toString()) : "",
                                style: textStyleData,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )));

      dropdownValueCourtEnd = dropdownItemsCourtEnd[2];
    } else {
      _content = Container();
    }
    return _content;
  }

  Widget _buildContent_saved(BuildContext context) {
    String IMPRISON_TIME_UNIT = "";
    if (itemMain.IMPRISON_TIME_UNIT == 0) {
      IMPRISON_TIME_UNIT = "วัน";
    } else if (itemMain.IMPRISON_TIME_UNIT == 1) {
      IMPRISON_TIME_UNIT = "เดือน";
    } else {
      IMPRISON_TIME_UNIT = "ปี";
    }

    String PAYMENT_PERIOD_DUE_UNIT = "";
    if (itemMain.PAYMENT_PERIOD_DUE_UNIT == 0) {
      PAYMENT_PERIOD_DUE_UNIT = "วัน";
    } else if (itemMain.PAYMENT_PERIOD_DUE_UNIT == 1) {
      PAYMENT_PERIOD_DUE_UNIT = "สัปดาห์";
    } else if (itemMain.PAYMENT_PERIOD_DUE_UNIT == 2) {
      PAYMENT_PERIOD_DUE_UNIT = "เดือน";
    } else {
      PAYMENT_PERIOD_DUE_UNIT = "ปี";
    }

    String sentence_date = "";
    String fine_date = "";
    //DateTime dt_sentence_date = DateTime.parse(itemMain.JUDGEMENT_DATE);
    DateTime dt_sentence_date = DateTime.now();
    /*DateTime dt_fine_date = DateTime.parse(itemMain.FINE_DATE);*/
    DateTime dt_fine_date = itemMain.FINE_DATE != null ? DateTime.parse(itemMain.FINE_DATE) : DateTime.now();
    List splitsSentenceDate = dateFormatDate.format(dt_sentence_date).toString().split(" ");
    List splitsFineDate = dateFormatDate.format(dt_fine_date).toString().split(" ");
    sentence_date = splitsSentenceDate[0] + " " + splitsSentenceDate[1] + " " + (int.parse(splitsSentenceDate[3]) + 543).toString();
    fine_date = splitsFineDate[0] + " " + splitsFineDate[1] + " " + (int.parse(splitsFineDate[3]) + 543).toString();

    String DECIDE_NO_YEAR_2 = "";
    String UNDECIDE_NO_YEAR_2 = "";
    DateTime dt_Decide_date = /*DateTime.parse(itemMain.DECIDE_NO_YEAR_2);*/ DateTime.now();
    DateTime dt_Undecide_date = /*DateTime.parse(itemMain.UNDECIDE_NO_YEAR_2);*/ DateTime.now();
    List splitsDecideDate = dateFormatDate.format(dt_Decide_date).toString().split(" ");
    List splitsUndecideDate = dateFormatDate.format(dt_Undecide_date).toString().split(" ");
    DECIDE_NO_YEAR_2 = (int.parse(splitsDecideDate[3]) + 543).toString();
    UNDECIDE_NO_YEAR_2 = (int.parse(splitsUndecideDate[3]) + 543).toString();

    var size = MediaQuery.of(context).size;

    return Container(
        child: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 22.0, right: 22.0, top: 22.0, bottom: 22.0),
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
                        "ชื่อผู้ต้องหา",
                        style: textStyleLabel,
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        indicmentDetail.TITLE_SHORT_NAME_TH.toString() + "" + indicmentDetail.FIRST_NAME.toString() + " " + indicmentDetail.LAST_NAME.toString(),
                        style: textStyleData,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "ชื่อศาล",
                        style: textStyleLabel,
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        itemMain.COURT_NAME.toString(),
                        style: textStyleData,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "คำพิพากษาสิ้นสุดชั้น",
                        style: textStyleLabel,
                      ),
                    ),
                    Container(
                      padding: paddingData,
                      child: Text(
                        dropdownValueCourtEnd.CourtEndName.toString(),
                        style: textStyleData,
                      ),
                    ),
                    _buildCourtBody_saved(context),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "วันอ่านคำพิพากษา",
                        style: textStyleLabel,
                      ),
                    ),
                    Padding(
                      padding: paddingData,
                      child: Text(
                        itemMain.JUDGEMENT_DATE != null ? (_convertDate(itemMain.JUDGEMENT_DATE) + " " + _convertTime(itemMain.JUDGEMENT_DATE)) : "",
                        style: textStyleData,
                      ),
                    ),
                    Container(
                      padding: paddingLabel,
                      child: Text(
                        "คำพิพากษาศาล",
                        style: textStyleLabel,
                      ),
                    ),
                    _buildSentence(context),
                  ],
                ),
              ],
            )),
        _buildDataImage(context),
      ],
    )));
  }

  //build layout คำพิพากษา
  Widget _buildSentence(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String IMPRISON_TIME_UNIT = "";
    if (itemMain.IMPRISON_TIME_UNIT == 0) {
      IMPRISON_TIME_UNIT = "วัน";
    } else if (itemMain.IMPRISON_TIME_UNIT == 1) {
      IMPRISON_TIME_UNIT = "เดือน";
    } else {
      IMPRISON_TIME_UNIT = "ปี";
    }

    String PAYMENT_PERIOD_DUE_UNIT = "";
    if (itemMain.PAYMENT_PERIOD_DUE_UNIT == 0) {
      PAYMENT_PERIOD_DUE_UNIT = "วัน";
    } else if (itemMain.PAYMENT_PERIOD_DUE_UNIT == 1) {
      PAYMENT_PERIOD_DUE_UNIT = "สับดาห์";
    } else if (itemMain.PAYMENT_PERIOD_DUE_UNIT == 2) {
      PAYMENT_PERIOD_DUE_UNIT = "เดือน";
    } else {
      PAYMENT_PERIOD_DUE_UNIT = "ปี";
    }

    String PAYMENT_BANK = "";
    if (itemMain.PAYMENT_PERIOD_DUE_UNIT == 0) {
      PAYMENT_BANK = "กรุงศรีฯ";
    } else if (itemMain.PAYMENT_PERIOD_DUE_UNIT == 1) {
      PAYMENT_BANK = "กรุงไทย";
    } else {
      PAYMENT_BANK = "กสิกรไทย";
    }

    String PAYMENT_CHANNEL = "";
    if (itemMain.PAYMENT_PERIOD_DUE_UNIT == 0) {
      PAYMENT_CHANNEL = "เช็ค";
    } else {
      PAYMENT_CHANNEL = "โอนจากธนาคาร";
    }

    List<Widget> _buildBody = [];

    if (itemMain.IS_DISMISS == 1) {
      _isDismissed = true;

      _buildBody.add(Container(
        padding: paddingLabel,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 18.0, left: 12.0, bottom: 8, top: 8),
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xff3b69f3),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.check,
                        size: 16.0,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            Container(
              child: Text(
                "ศาลยกฟ้อง",
                style: textStyleData1,
              ),
            )
          ],
        ),
      ));
    }
    if (itemMain.IS_FINE == 1) {
      _isFine = true;

      _buildBody.add(Container(
          padding: EdgeInsets.only(
              right: 18.0,
              //left: 12.0,
              bottom: 8,
              top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 18.0, bottom: 8, top: 8),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(0xff3b69f3),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.check,
                                size: 16.0,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "ศาลสั่งปรับ",
                        style: textStyleData1,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  "วิธีชำระค่าปรับ",
                  style: textStyleLabel,
                ),
              ),
              Padding(
                padding: paddingData,
                child: Text(
                  itemMain.IS_PAYONCE == 1 ? "ชำระครั้งเดียว" : "เเบ่งชำระเป็นงวด",
                  style: textStyleData,
                ),
              ),
              itemMain.IS_PAYONCE == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "จำนวนงวด",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemMain.PAYMENT_PERIOD.toString(),
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "วันที่เริ่มชำระค่าปรับ",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            _convertDate(itemMain.FINE_DATE),
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          width: ((size.width * 80) / 100) / 2,
                          padding: EdgeInsets.only(right: 12.0),
                          child: Container(
                            padding: paddingData,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "รอบชำระค่าปรับทุก",
                                    style: textStyleLabel,
                                  ),
                                ),
                                Padding(
                                  padding: paddingData,
                                  child: Text(
                                    itemMain.PAYMENT_PERIOD_DUE.toString() + " " + PAYMENT_PERIOD_DUE_UNIT,
                                    style: textStyleData,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: paddingLabel,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingLabel,
                                child: Text(
                                  "วันที่กำหนดชำระค่าปรับของผู้ต้องหา",
                                  style: textStyleLabel,
                                ),
                              ),
                              Padding(
                                padding: paddingData,
                                child: Text(
                                  _convertDate(itemMain.FINE_DATE),
                                  style: textStyleData,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "วันที่รับเงินจากศาล",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            _convertDate(itemMain.PAYMENT_DATE),
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ช่องทางการชำระเงินจากศาล",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            PAYMENT_CHANNEL.toString(),
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "เลขที่เช็ค/เลขที่บัญชี",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            itemMain.PAYMENT_REF_NO.toString(),
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "ธนาคาร",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            PAYMENT_BANK.toString(),
                            style: textStyleData,
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "จำนวนเงินจากศาล",
                            style: textStyleLabel,
                          ),
                        ),
                        Padding(
                          padding: paddingData,
                          child: Text(
                            formatter_fine.format(itemMain.FINE).toString(),
                            style: textStyleData,
                          ),
                        ),
                      ],
                    ),
            ],
          )));
    }
    if (itemMain.IS_IMPRISON == 1) {
      _isImprison = true;

      _buildBody.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: paddingLabel,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      right: 18.0,
                      //left: 12.0,
                      bottom: 8,
                      top: 8),
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xff3b69f3),
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.check,
                            size: 16.0,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "ศาลสั่งจำคุก",
                    style: textStyleData1,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                right: 18.0,
                //left: 12.0,
                bottom: 8,
                top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "สั่งจำคุกเป็นเวลา",
                    style: textStyleLabel,
                  ),
                ),
                Padding(
                  padding: paddingData,
                  child: Text(
                    formatter.format(itemMain.IMPRISON_TIME).toString() + " " + IMPRISON_TIME_UNIT,
                    style: textStyleData,
                  ),
                ),
              ],
            ),
          )
        ],
      ));
    }

    return Column(
      children: _buildBody,
    );
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery.of(context).size;
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
                width: size.width / 2,
                child: MaterialButton(
                  onPressed: () {
                    //_onImageButtonPressed(ImageSource.gallery, context);
                    //getImage();
                    _showDialogImagePicker();
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
                              size: 32,
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

  Widget _buildDataImage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 22.0),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _arrItemsImageFile.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            String _imgFile;
            List splits = _arrItemsImageFile[index].DOCUMENT_NAME.split(".");
            print(splits.last);
            if (splits.last.toString().trim().endsWith("jpg") || splits.last.toString().trim().endsWith("png")) {
              //_imgFile = _arrItemsImageFile[index].FILE_CONTENT;
            } else if (splits.last.toString().trim().endsWith("docx")) {
              _imgFile = "assets/icons/file/doc.png";
            } else if (splits.last.toString().trim().endsWith("xlsx")) {
              _imgFile = "assets/icons/file/xls.png";
            } else if (splits.last.toString().trim().endsWith("pdf")) {
              _imgFile = "assets/icons/file/pdf.png";
            } else if (splits.last.toString().trim().endsWith("txt")) {
              _imgFile = "assets/icons/file/txt.png";
            } else if (splits.last.toString().trim().endsWith("xml")) {
              _imgFile = "assets/icons/file/xml.png";
            } else if (splits.last.toString().trim().endsWith("sql")) {
              _imgFile = "assets/icons/file/sql.png";
            } else if (splits.last.toString().trim().endsWith("ppts")) {
              _imgFile = "assets/icons/file/ppt.png";
            } else if (splits.last.toString().trim().endsWith("zip") || splits.last.toString().trim().endsWith("rar")) {
              _imgFile = "assets/icons/file/zip.png";
            } else {
              _imgFile = "assets/icons/file/folder.png";
            }

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
                      child: splits.last.toString().trim().endsWith("jpg") || splits.last.toString().trim().endsWith("png")
                          ? Image.file(
                              _arrItemsImageFile[index].FILE_CONTENT,
                              fit: BoxFit.cover,
                            )
                          : Image(fit: BoxFit.cover, image: new AssetImage(_imgFile)),
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
                              )
                            : Icon(null),
                        onPressed: () {
                          setState(() {
                            if (_onEdited) {
                              if (_arrItemsImageFile[index].DOCUMENT_ID != null) {
                                print("case :: A");
                                _arrItemsImageFileDelete.add(_arrItemsImageFile[index].DOCUMENT_ID);
                              } else {
                                print("case :: B");
                                print(index.toString() + " - " + (_arrItemsImageFile.length - _arrItemsImageFileAdd.length).toString() + " = " + (index - (_arrItemsImageFile.length - _arrItemsImageFileAdd.length)).toString());
                                _arrItemsImageFileAdd.removeAt((index - (_arrItemsImageFile.length - _arrItemsImageFileAdd.length)));
                              }
                            }
                            _arrItemsImageFile.removeAt(index);
                            if (_arrItemsImageFile.length == 0) {
                              //isImage = false;
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

  String _convertYearToDate(String year) {
    String _date = "";
    DateFormat df = DateFormat("MM-dd");
    if (year.isNotEmpty) {
      _date = DateTime.parse((int.parse(year.trim()) - 543).toString() + "-" + df.format(DateTime.now())).toString();
    } else {
      _date = "";
    }
    return _date;
  }

  void onSaved(BuildContext mContext, bool IsDelete) async {
    List<Map> mapLawsuitDetail = [];
    List<Map> mapLawsuitPayment = [];
    List<Map> mapLawsuitPaymentDetail = [];

    List<Map> mapLawsuitPaymentDel = [];

    if (!IsDelete) {
      if (editCourtName.text.isEmpty) {
        new VerifyDialog(mContext, 'กรุณากเลือกศาล');
      } else {
        bool IsInsertPayment = false;

        itemsLawsuitMain.LawsuitDetail.forEach((detail) {
          if (detail.LAWSUIT_DETAIL_ID == itemMain.LAWSUIT_DETAIL_ID) {
            //Update Pay
            if (detail.LawsuitPayment.length > 0) {
              IsInsertPayment = false;

              if (!_isDismissed) {
                if (!_isOneTime) {
                  if (int.parse(editPeriodNum.text.isEmpty ? 0 : editPeriodNum.text) != detail.LawsuitPayment.length) {
                    IsInsertPayment = true;
                    detail.LawsuitPayment.forEach((f) {
                      mapLawsuitPaymentDel.add({"PAYMENT_ID": f.PAYMENT_ID});
                    });

                    for (int i = 0; i < int.parse(editPeriodNum.text.isEmpty ? 0 : editPeriodNum.text); i++) {
                      mapLawsuitPayment.add({
                        "COMPARE_DETAIL_ID": "",
                        "FINE": _isOneTime ? editCheckValue.text : "",
                        "FINE_TYPE": 0,
                        "IS_ACTIVE": 1,
                        "IS_REQUEST_REWARD": "",
                        "LAWSUIT_DETAIL_ID": itemMain.LAWSUIT_DETAIL_ID,
                        "LawsuitPaymentDetail": mapLawsuitPaymentDetail,
                        "PAYMENT_DATE": "",
                        "PAYMENT_ID": "",
                        "PAYMENT_PERIOD_NO": i + 1,
                      });
                    }
                  } else {
                    detail.LawsuitPayment.forEach((payment) {
                      payment.LawsuitPaymentDetail.forEach((paymentDetail) {
                        mapLawsuitPaymentDetail.add({
                          "IS_ACTIVE": paymentDetail.IS_ACTIVE,
                          "IS_REQUEST_BRIBE": paymentDetail.IS_REQUEST_BRIBE,
                          "NOTICE_ID": paymentDetail.NOTICE_ID,
                          "PAYMENT_DETAIL_ID": paymentDetail.PAYMENT_DETAIL_ID,
                          "PAYMENT_ID": paymentDetail.PAYMENT_ID,
                        });
                      });

                      mapLawsuitPayment.add({
                        "COMPARE_DETAIL_ID": payment.COMPARE_DETAIL_ID,
                        "FINE": payment.FINE,
                        "FINE_TYPE": payment.FINE_TYPE,
                        "IS_ACTIVE": payment.IS_ACTIVE,
                        "IS_REQUEST_REWARD": payment.IS_REQUEST_REWARD,
                        "LAWSUIT_DETAIL_ID": payment.LAWSUIT_DETAIL_ID,
                        "LawsuitPaymentDetail": mapLawsuitPaymentDetail,
                        "PAYMENT_DATE": payment.PAYMENT_DATE,
                        "PAYMENT_ID": payment.PAYMENT_ID,
                        "PAYMENT_PERIOD_NO": payment.PAYMENT_PERIOD_NO,
                      });
                    });
                  }
                }
              }
            }
            //Insert Pay
            else {
              IsInsertPayment = true;
              itemsLawsuitArrestMain.LawsuitNotice.forEach((notice) {
                mapLawsuitPaymentDetail.add({
                  "IS_ACTIVE": 1,
                  "IS_REQUEST_BRIBE": 0,
                  "NOTICE_ID": notice.NOTICE_ID,
                  "PAYMENT_DETAIL_ID": "",
                  "PAYMENT_ID": "",
                });
              });

              if (_isOneTime) {
                mapLawsuitPayment.add({
                  "COMPARE_DETAIL_ID": "",
                  "FINE": _isOneTime ? editCheckValue.text : "",
                  "FINE_TYPE": 0,
                  "IS_ACTIVE": 1,
                  "IS_REQUEST_REWARD": "",
                  "LAWSUIT_DETAIL_ID": itemMain.LAWSUIT_DETAIL_ID,
                  "LawsuitPaymentDetail": mapLawsuitPaymentDetail,
                  "PAYMENT_DATE": "",
                  "PAYMENT_ID": "",
                  "PAYMENT_PERIOD_NO": !_isOneTime ? editPeriodNum.text : "",
                });
              } else {
                for (int i = 0; i < int.parse(editPeriodNum.text); i++) {
                  mapLawsuitPayment.add({
                    "COMPARE_DETAIL_ID": "",
                    "FINE": _isOneTime ? editCheckValue.text : "",
                    "FINE_TYPE": 0,
                    "IS_ACTIVE": 1,
                    "IS_REQUEST_REWARD": "",
                    "LAWSUIT_DETAIL_ID": itemMain.LAWSUIT_DETAIL_ID,
                    "LawsuitPaymentDetail": mapLawsuitPaymentDetail,
                    "PAYMENT_DATE": "",
                    "PAYMENT_ID": "",
                    "PAYMENT_PERIOD_NO": i + 1,
                  });
                }
              }
            }

            mapLawsuitDetail.add({
              "COURT_ID": itemsLawsuitMasCourt.COURT_ID,
              "COURT_NAME": itemsLawsuitMasCourt.COURT_NAME,
              "FINE": _isOneTime ? editCheckValue.text : "",
              "FINE_DATE": _isPeriod ? _dtDateStartPayment.toString() : _dtDateFine.toString(),
              "IMPRISON_TIME": _isImprison ? editImprison.text : "",
              "IMPRISON_TIME_UNIT": dropdownValueImprison != null ? dropdownValueImprison.DateUnitID : "",
              "INDICTMENT_DETAIL_ID": itemMain.INDICTMENT_DETAIL_ID,
              "IS_ACTIVE": itemMain.IS_ACTIVE,
              "IS_DISMISS": _isDismissed ? 1 : 0,
              "IS_FINE": _isFine ? 1 : 0,
              "IS_IMPRISON": _isImprison ? 1 : 0,
              "IS_PAYONCE": _isOneTime ? 1 : 0,
              "JUDGEMENT_DATE": _dtcurrentDate.toString(),
              "LAWSUIT_DETAIL_ID": itemMain.LAWSUIT_DETAIL_ID,
              "LAWSUIT_END": itemMain.LAWSUIT_END,
              "LAWSUIT_ID": itemMain.LAWSUIT_ID,
              "LAWSUIT_TYPE": itemMain.LAWSUIT_TYPE,
              "LawsuitPayment": mapLawsuitPayment,
              "PAYMENT_BANK": dropdownValueBank != null ? dropdownValueBank.BankID : "",
              "PAYMENT_CHANNEL": dropdownValuePaymentChannel != null ? dropdownValuePaymentChannel.ChannelID : "",
              "PAYMENT_DATE": _isOneTime ? _dtDateBill.toString() : "",
              "PAYMENT_PERIOD": _isPeriod ? editPeriodNum.text : "",
              "PAYMENT_PERIOD_DUE": _isPeriod ? editPeriod.text : "",
              "PAYMENT_PERIOD_DUE_UNIT": dropdownValueFine != null ? dropdownValueFine.DateUnitID : "",
              "PAYMENT_REF_NO": _isOneTime ? editBookBank.text : "",
              "UNDECIDE_NO_1": dropdownValueCourtEnd.CourtEndID == 0 ? editCivilCourtUndecidedCase.text : "",
              "UNDECIDE_NO_YEAR_1": dropdownValueCourtEnd.CourtEndID == 0 ? _convertYearToDate(editCivilCourtUndecidedYear.text) : "",
              "DECIDE_NO_1": dropdownValueCourtEnd.CourtEndID == 0 ? editCivilCourtDecidedCase.text : "",
              "DECIDE_NO_YEAR_1": dropdownValueCourtEnd.CourtEndID == 0 ? _convertYearToDate(editCivilCourtDecidedYear.text) : "",
              "UNDECIDE_NO_2": dropdownValueCourtEnd.CourtEndID == 1 ? editCourtofAppealsUndecidedCase.text : "",
              "UNDECIDE_NO_YEAR_2": dropdownValueCourtEnd.CourtEndID == 1 ? _convertYearToDate(editCourtofAppealsUndecidedYear.text) : "",
              "DECIDE_NO_2": dropdownValueCourtEnd.CourtEndID == 1 ? editCourtofAppealsDecidedCase.text : "",
              "DECIDE_NO_YEAR_2": dropdownValueCourtEnd.CourtEndID == 1 ? _convertYearToDate(editCourtofAppealsDecidedYear.text) : "",
              "UNJUDGEMENT_NO": dropdownValueCourtEnd.CourtEndID == 2 ? editSupremeCourtUndecidedCase.text : "",
              "UNJUDGEMENT_NO_YEAR": dropdownValueCourtEnd.CourtEndID == 2 ? _convertYearToDate(editSupremeCourtUndecidedYear.text) : "",
              "JUDGEMENT_NO": dropdownValueCourtEnd.CourtEndID == 2 ? editSupremeCourtDecidedCase.text : "",
              "JUDGEMENT_NO_YEAR": dropdownValueCourtEnd.CourtEndID == 2 ? _convertYearToDate(editSupremeCourtDecidedYear.text) : "",
            });
          } else {
            detail.LawsuitPayment.forEach((payment) {
              payment.LawsuitPaymentDetail.forEach((paymentDetail) {
                mapLawsuitPaymentDetail.add({
                  "IS_ACTIVE": paymentDetail.IS_ACTIVE,
                  "IS_REQUEST_BRIBE": paymentDetail.IS_REQUEST_BRIBE,
                  "NOTICE_ID": paymentDetail.NOTICE_ID,
                  "PAYMENT_DETAIL_ID": paymentDetail.PAYMENT_DETAIL_ID,
                  "PAYMENT_ID": paymentDetail.PAYMENT_ID,
                });
              });

              mapLawsuitPayment.add({
                "COMPARE_DETAIL_ID": payment.COMPARE_DETAIL_ID,
                "FINE": payment.FINE,
                "FINE_TYPE": payment.FINE_TYPE,
                "IS_ACTIVE": payment.IS_ACTIVE,
                "IS_REQUEST_REWARD": payment.IS_REQUEST_REWARD,
                "LAWSUIT_DETAIL_ID": payment.LAWSUIT_DETAIL_ID,
                "LawsuitPaymentDetail": mapLawsuitPaymentDetail,
                "PAYMENT_DATE": DateTime.parse(payment.PAYMENT_DATE).toString(),
                "PAYMENT_ID": payment.PAYMENT_ID,
                "PAYMENT_PERIOD_NO": payment.PAYMENT_PERIOD_NO,
              });
            });

            mapLawsuitDetail.add({
              "COURT_ID": detail.COURT_ID,
              "COURT_NAME": detail.COURT_NAME != null ? detail.COURT_NAME : "",
              "DECIDE_NO_1": detail.DECIDE_NO_1,
              "DECIDE_NO_2": detail.DECIDE_NO_2,
              "DECIDE_NO_YEAR_1": detail.DECIDE_NO_YEAR_1 != null ? detail.DECIDE_NO_YEAR_1 : "",
              "DECIDE_NO_YEAR_2": detail.DECIDE_NO_YEAR_2 != null ? detail.DECIDE_NO_YEAR_2 : "",
              "FINE": detail.FINE,
              "FINE_DATE": detail.FINE_DATE != null ? detail.FINE_DATE : "",
              "IMPRISON_TIME": detail.IMPRISON_TIME,
              "IMPRISON_TIME_UNIT": detail.IMPRISON_TIME_UNIT,
              "INDICTMENT_DETAIL_ID": detail.INDICTMENT_DETAIL_ID,
              "IS_ACTIVE": detail.IS_ACTIVE,
              "IS_DISMISS": detail.IS_DISMISS,
              "IS_FINE": detail.IS_FINE,
              "IS_IMPRISON": detail.IS_IMPRISON,
              "IS_PAYONCE": detail.IS_PAYONCE,
              "JUDGEMENT_DATE": detail.JUDGEMENT_DATE != null ? detail.JUDGEMENT_DATE : "",
              "JUDGEMENT_NO": detail.JUDGEMENT_NO,
              "JUDGEMENT_NO_YEAR": detail.JUDGEMENT_NO_YEAR != null ? detail.JUDGEMENT_NO_YEAR : "",
              "LAWSUIT_DETAIL_ID": detail.LAWSUIT_DETAIL_ID,
              "LAWSUIT_END": detail.LAWSUIT_END,
              "LAWSUIT_ID": detail.LAWSUIT_ID,
              "LAWSUIT_TYPE": detail.LAWSUIT_TYPE,
              "LawsuitPayment": mapLawsuitPayment,
              "PAYMENT_BANK": detail.PAYMENT_BANK,
              "PAYMENT_CHANNEL": detail.PAYMENT_CHANNEL,
              "PAYMENT_DATE": detail.PAYMENT_DATE != null ? detail.PAYMENT_DATE : "",
              "PAYMENT_PERIOD": detail.PAYMENT_PERIOD,
              "PAYMENT_PERIOD_DUE": detail.PAYMENT_PERIOD_DUE,
              "PAYMENT_PERIOD_DUE_UNIT": detail.PAYMENT_PERIOD_DUE_UNIT,
              "PAYMENT_REF_NO": detail.PAYMENT_REF_NO != null ? detail.PAYMENT_REF_NO : "",
              "UNDECIDE_NO_1": detail.UNDECIDE_NO_1,
              "UNDECIDE_NO_2": detail.UNDECIDE_NO_2,
              "UNDECIDE_NO_YEAR_1": detail.UNDECIDE_NO_YEAR_1 != null ? detail.UNDECIDE_NO_YEAR_1 : "",
              "UNDECIDE_NO_YEAR_2": detail.UNDECIDE_NO_YEAR_2 != null ? detail.UNDECIDE_NO_YEAR_2 : "",
              "UNJUDGEMENT_NO": detail.UNJUDGEMENT_NO != null ? detail.UNJUDGEMENT_NO : "",
              "UNJUDGEMENT_NO_YEAR": detail.UNJUDGEMENT_NO_YEAR != null ? detail.UNJUDGEMENT_NO_YEAR : "",
            });
          }
        });

        Map map = {
          "LAWSUIT_ID": itemsLawsuitMain.LAWSUIT_ID,
          "INDICTMENT_ID": itemsLawsuitMain.INDICTMENT_ID,
          "OFFICE_ID": "",
          "OFFICE_CODE": itemsLawsuitMain.OFFICE_CODE,
          "OFFICE_NAME": itemsLawsuitMain.OFFICE_NAME,
          "IS_LAWSUIT": itemsLawsuitMain.IS_LAWSUIT,
          "REMARK_NOT_LAWSUIT": itemsLawsuitMain.REMARK_NOT_LAWSUIT != null ? itemsLawsuitMain.REMARK_NOT_LAWSUIT : "",
          "LAWSUIT_NO": itemsLawsuitMain.LAWSUIT_NO,
          "LAWSUIT_NO_YEAR": DateTime.parse(itemsLawsuitMain.LAWSUIT_NO_YEAR).toString(),
          "LAWSUIT_DATE": DateTime.parse(itemsLawsuitMain.LAWSUIT_DATE).toString(),
          "TESTIMONY": itemsLawsuitMain.TESTIMONY,
          "DELIVERY_DOC_NO_1": itemsLawsuitMain.DELIVERY_DOC_NO_1 != null ? itemsLawsuitMain.DELIVERY_DOC_NO_1 : "",
          "DELIVERY_DOC_NO_2": itemsLawsuitMain.DELIVERY_DOC_NO_2 != null ? itemsLawsuitMain.DELIVERY_DOC_NO_2 : "",
          "DELIVERY_DOC_DATE": itemsLawsuitMain.DELIVERY_DOC_DATE != null ? DateTime.parse(itemsLawsuitMain.DELIVERY_DOC_DATE).toString() : "",
          "IS_OUTSIDE": itemsLawsuitMain.IS_OUTSIDE,
          "IS_SEIZE": itemsLawsuitMain.IS_SEIZE,
          "IS_ACTIVE": itemsLawsuitMain.IS_ACTIVE,
          "CREATE_DATE": itemsLawsuitMain.CREATE_DATE,
          "CREATE_USER_ACCOUNT_ID": itemsLawsuitMain.CREATE_USER_ACCOUNT_ID,
          "UPDATE_DATE": "",
          "UPDATE_USER_ACCOUNT_ID": "",
          "LawsuitDetail": mapLawsuitDetail,
          "LawsuitStaff": [
            {
              "STAFF_ID": itemsLawsuitMain.LawsuitStaff.first.STAFF_ID,
              "LAWSUIT_ID": itemMain.LAWSUIT_ID,
              "STAFF_REF_ID": itemsLawsuitMain.LawsuitStaff.first.STAFF_REF_ID,
              "TITLE_ID": itemsLawsuitMain.LawsuitStaff.first.TITLE_ID,
              "STAFF_CODE": itemsLawsuitMain.LawsuitStaff.first.STAFF_CODE,
              "ID_CARD": "",
              "STAFF_TYPE": itemsLawsuitMain.LawsuitStaff.first.STAFF_TYPE,
              "TITLE_NAME_TH": itemsLawsuitMain.LawsuitStaff.first.TITLE_SHORT_NAME_TH,
              "TITLE_NAME_EN": "",
              "TITLE_SHORT_NAME_TH": itemsLawsuitMain.LawsuitStaff.first.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": "",
              "FIRST_NAME": itemsLawsuitMain.LawsuitStaff.first.FIRST_NAME,
              "LAST_NAME": itemsLawsuitMain.LawsuitStaff.first.LAST_NAME,
              "AGE": "",
              "OPERATION_DEPT_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_CODE : "",
              "OPERATION_DEPT_LEVEL": itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_LEVEL != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_LEVEL : "",
              "OPERATION_DEPT_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_NAME : "",
              "OPERATION_OFFICE_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_CODE : "",
              "OPERATION_OFFICE_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_NAME : "",
              "OPERATION_OFFICE_SHORT_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_SHORT_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_SHORT_NAME : "",
              "OPERATION_POS_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_POS_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_POS_CODE : "",
              "OPERATION_POS_LEVEL_NAME": itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_LAVEL_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_LAVEL_NAME : "",
              "OPERATION_UNDER_DEPT_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_CODE : "",
              "OPERATION_UNDER_DEPT_LEVEL": itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_LEVEL != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_LEVEL : "",
              "OPERATION_UNDER_DEPT_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_NAME : "",
              "OPERATION_WORK_DEPT_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_CODE : "",
              "OPERATION_WORK_DEPT_LEVEL": itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_LEVEL != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_LEVEL : "",
              "OPERATION_WORK_DEPT_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_NAME : "",
              "OPREATION_POS_LEVEL": itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_LEVEL != null ? itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_LEVEL : "",
              "OPREATION_POS_NAME": itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_NAME : "",
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
              "CONTRIBUTOR_ID": itemsLawsuitMain.LawsuitStaff.first.CONTRIBUTOR_ID,
              "IS_ACTIVE": 1
            }
          ],
        };

        print(mapLawsuitPaymentDel.toString());

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onLoadActionUpdLawsuitAll(map, IsInsertPayment, mapLawsuitPayment, mapLawsuitPaymentDel, false, true);
        Navigator.pop(context);

        if (!IsSuccess) {
          new VerifyDialog(mContext, 'บันทึกไม่สำเร็จ');
        }
      }
    } else {
      itemsLawsuitMain.LawsuitDetail.forEach((detail) {
        //add payment id for delete
        detail.LawsuitPayment.forEach((pay) {
          mapLawsuitPayment.add({"PAYMENT_ID": pay.PAYMENT_ID});
        });

        //set item lawsuit detail for delete
        if (detail.LAWSUIT_DETAIL_ID == itemMain.LAWSUIT_DETAIL_ID) {
          mapLawsuitDetail.add({
            "LAWSUIT_DETAIL_ID": itemMain.LAWSUIT_DETAIL_ID,
            "LAWSUIT_ID": itemMain.LAWSUIT_ID,
            "INDICTMENT_DETAIL_ID": itemMain.INDICTMENT_DETAIL_ID,
            "COURT_ID": "",
            "LAWSUIT_TYPE": itemMain.LAWSUIT_TYPE,
            "LAWSUIT_END": itemMain.LAWSUIT_END,
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
        } else {
          detail.LawsuitPayment.forEach((payment) {
            payment.LawsuitPaymentDetail.forEach((paymentDetail) {
              mapLawsuitPaymentDetail.add({
                "IS_ACTIVE": paymentDetail.IS_ACTIVE,
                "IS_REQUEST_BRIBE": paymentDetail.IS_REQUEST_BRIBE,
                "NOTICE_ID": paymentDetail.NOTICE_ID,
                "PAYMENT_DETAIL_ID": paymentDetail.PAYMENT_DETAIL_ID,
                "PAYMENT_ID": paymentDetail.PAYMENT_ID,
              });
            });

            mapLawsuitPayment.add({
              "COMPARE_DETAIL_ID": payment.COMPARE_DETAIL_ID,
              "FINE": payment.FINE,
              "FINE_TYPE": payment.FINE_TYPE,
              "IS_ACTIVE": payment.IS_ACTIVE,
              "IS_REQUEST_REWARD": payment.IS_REQUEST_REWARD,
              "LAWSUIT_DETAIL_ID": payment.LAWSUIT_DETAIL_ID,
              "LawsuitPaymentDetail": mapLawsuitPaymentDetail,
              "PAYMENT_DATE": DateTime.parse(payment.PAYMENT_DATE).toString(),
              "PAYMENT_ID": payment.PAYMENT_ID,
              "PAYMENT_PERIOD_NO": payment.PAYMENT_PERIOD_NO,
            });
          });

          mapLawsuitDetail.add({
            "COURT_ID": detail.COURT_ID,
            "COURT_NAME": detail.COURT_NAME != null ? detail.COURT_NAME : "",
            "DECIDE_NO_1": detail.DECIDE_NO_1,
            "DECIDE_NO_2": detail.DECIDE_NO_2,
            "DECIDE_NO_YEAR_1": detail.DECIDE_NO_YEAR_1 != null ? detail.DECIDE_NO_YEAR_1 : "",
            "DECIDE_NO_YEAR_2": detail.DECIDE_NO_YEAR_2 != null ? detail.DECIDE_NO_YEAR_2 : "",
            "FINE": detail.FINE,
            "FINE_DATE": detail.FINE_DATE != null ? detail.FINE_DATE : "",
            "IMPRISON_TIME": detail.IMPRISON_TIME,
            "IMPRISON_TIME_UNIT": detail.IMPRISON_TIME_UNIT,
            "INDICTMENT_DETAIL_ID": detail.INDICTMENT_DETAIL_ID,
            "IS_ACTIVE": detail.IS_ACTIVE,
            "IS_DISMISS": detail.IS_DISMISS,
            "IS_FINE": detail.IS_FINE,
            "IS_IMPRISON": detail.IS_IMPRISON,
            "IS_PAYONCE": detail.IS_PAYONCE,
            "JUDGEMENT_DATE": detail.JUDGEMENT_DATE != null ? detail.JUDGEMENT_DATE : "",
            "JUDGEMENT_NO": detail.JUDGEMENT_NO,
            "JUDGEMENT_NO_YEAR": detail.JUDGEMENT_NO_YEAR != null ? detail.JUDGEMENT_NO_YEAR : "",
            "LAWSUIT_DETAIL_ID": detail.LAWSUIT_DETAIL_ID,
            "LAWSUIT_END": detail.LAWSUIT_END,
            "LAWSUIT_ID": detail.LAWSUIT_ID,
            "LAWSUIT_TYPE": detail.LAWSUIT_TYPE,
            "LawsuitPayment": mapLawsuitPayment,
            "PAYMENT_BANK": detail.PAYMENT_BANK,
            "PAYMENT_CHANNEL": detail.PAYMENT_CHANNEL,
            "PAYMENT_DATE": detail.PAYMENT_DATE != null ? detail.PAYMENT_DATE : "",
            "PAYMENT_PERIOD": detail.PAYMENT_PERIOD,
            "PAYMENT_PERIOD_DUE": detail.PAYMENT_PERIOD_DUE,
            "PAYMENT_PERIOD_DUE_UNIT": detail.PAYMENT_PERIOD_DUE_UNIT,
            "PAYMENT_REF_NO": detail.PAYMENT_REF_NO != null ? detail.PAYMENT_REF_NO : "",
            "UNDECIDE_NO_1": detail.UNDECIDE_NO_1,
            "UNDECIDE_NO_2": detail.UNDECIDE_NO_2,
            "UNDECIDE_NO_YEAR_1": detail.UNDECIDE_NO_YEAR_1 != null ? detail.UNDECIDE_NO_YEAR_1 : "",
            "UNDECIDE_NO_YEAR_2": detail.UNDECIDE_NO_YEAR_2 != null ? detail.UNDECIDE_NO_YEAR_2 : "",
            "UNJUDGEMENT_NO": detail.UNJUDGEMENT_NO != null ? detail.UNJUDGEMENT_NO : "",
            "UNJUDGEMENT_NO_YEAR": detail.UNJUDGEMENT_NO_YEAR != null ? detail.UNJUDGEMENT_NO_YEAR : "",
          });
        }
      });

      Map map = {
        "LAWSUIT_ID": itemsLawsuitMain.LAWSUIT_ID,
        "INDICTMENT_ID": itemsLawsuitMain.INDICTMENT_ID,
        "OFFICE_ID": "",
        "OFFICE_CODE": itemsLawsuitMain.OFFICE_CODE,
        "OFFICE_NAME": itemsLawsuitMain.OFFICE_NAME,
        "IS_LAWSUIT": itemsLawsuitMain.IS_LAWSUIT,
        "REMARK_NOT_LAWSUIT": itemsLawsuitMain.REMARK_NOT_LAWSUIT != null ? itemsLawsuitMain.REMARK_NOT_LAWSUIT : "",
        "LAWSUIT_NO": itemsLawsuitMain.LAWSUIT_NO,
        "LAWSUIT_NO_YEAR": DateTime.parse(itemsLawsuitMain.LAWSUIT_NO_YEAR).toString(),
        "LAWSUIT_DATE": DateTime.parse(itemsLawsuitMain.LAWSUIT_DATE).toString(),
        "TESTIMONY": itemsLawsuitMain.TESTIMONY,
        "DELIVERY_DOC_NO_1": itemsLawsuitMain.DELIVERY_DOC_NO_1 != null ? itemsLawsuitMain.DELIVERY_DOC_NO_1 : "",
        "DELIVERY_DOC_NO_2": itemsLawsuitMain.DELIVERY_DOC_NO_2 != null ? itemsLawsuitMain.DELIVERY_DOC_NO_2 : "",
        "DELIVERY_DOC_DATE": itemsLawsuitMain.DELIVERY_DOC_DATE != null ? DateTime.parse(itemsLawsuitMain.DELIVERY_DOC_DATE).toString() : "",
        "IS_OUTSIDE": itemsLawsuitMain.IS_OUTSIDE,
        "IS_SEIZE": itemsLawsuitMain.IS_SEIZE,
        "IS_ACTIVE": itemsLawsuitMain.IS_ACTIVE,
        "CREATE_DATE": itemsLawsuitMain.CREATE_DATE,
        "CREATE_USER_ACCOUNT_ID": itemsLawsuitMain.CREATE_USER_ACCOUNT_ID,
        "UPDATE_DATE": "",
        "UPDATE_USER_ACCOUNT_ID": "",
        "LawsuitDetail": mapLawsuitDetail,
        "LawsuitStaff": [
          {
            "STAFF_ID": itemsLawsuitMain.LawsuitStaff.first.STAFF_ID,
            "LAWSUIT_ID": itemMain.LAWSUIT_ID,
            "STAFF_REF_ID": itemsLawsuitMain.LawsuitStaff.first.STAFF_REF_ID,
            "TITLE_ID": itemsLawsuitMain.LawsuitStaff.first.TITLE_ID,
            "STAFF_CODE": itemsLawsuitMain.LawsuitStaff.first.STAFF_CODE,
            "ID_CARD": "",
            "STAFF_TYPE": itemsLawsuitMain.LawsuitStaff.first.STAFF_TYPE,
            "TITLE_NAME_TH": itemsLawsuitMain.LawsuitStaff.first.TITLE_SHORT_NAME_TH,
            "TITLE_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": itemsLawsuitMain.LawsuitStaff.first.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": "",
            "FIRST_NAME": itemsLawsuitMain.LawsuitStaff.first.FIRST_NAME,
            "LAST_NAME": itemsLawsuitMain.LawsuitStaff.first.LAST_NAME,
            "AGE": "",
            "OPERATION_DEPT_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_CODE : "",
            "OPERATION_DEPT_LEVEL": itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_LEVEL != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_LEVEL : "",
            "OPERATION_DEPT_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_DEPT_NAME : "",
            "OPERATION_OFFICE_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_CODE : "",
            "OPERATION_OFFICE_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_NAME : "",
            "OPERATION_OFFICE_SHORT_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_SHORT_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_OFFICE_SHORT_NAME : "",
            "OPERATION_POS_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_POS_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_POS_CODE : "",
            "OPERATION_POS_LEVEL_NAME": itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_LAVEL_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_LAVEL_NAME : "",
            "OPERATION_UNDER_DEPT_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_CODE : "",
            "OPERATION_UNDER_DEPT_LEVEL": itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_LEVEL != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_LEVEL : "",
            "OPERATION_UNDER_DEPT_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_UNDER_DEPT_NAME : "",
            "OPERATION_WORK_DEPT_CODE": itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_CODE != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_CODE : "",
            "OPERATION_WORK_DEPT_LEVEL": itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_LEVEL != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_LEVEL : "",
            "OPERATION_WORK_DEPT_NAME": itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPERATION_WORK_DEPT_NAME : "",
            "OPREATION_POS_LEVEL": itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_LEVEL != null ? itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_LEVEL : "",
            "OPREATION_POS_NAME": itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_NAME != null ? itemsLawsuitMain.LawsuitStaff.first.OPREATION_POS_NAME : "",
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
            "CONTRIBUTOR_ID": itemsLawsuitMain.LawsuitStaff.first.CONTRIBUTOR_ID,
            "IS_ACTIVE": 1
          }
        ],
      };

      print("map : " + mapLawsuitPayment.toString());

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          });
      await onLoadActionUpdLawsuitAll(map, false, mapLawsuitPayment, null, true, false);
      Navigator.pop(context, itemMain);

      if (!IsSuccess) {
        new VerifyDialog(mContext, 'บันทึกไม่สำเร็จ');
      } else {
        _onSaved = false;
        _onEdited = false;
        _onSave = false;
        itemMain;
        clearTextfield();
        Navigator.pop(context, itemMain);
      }
    }
  }

  bool IsSuccess = false;
  Future<bool> onLoadActionUpdLawsuitAll(
    Map map,
    bool IsInsertPayment,
    List<Map> map_pay,
    List<Map> map_pay_del,
    bool IsDelete,
    bool IsCreate,
  ) async {
    IsSuccess = false;

    if (IsInsertPayment) {
      //delete payment
      await new LawsuitFuture().apiRequestLawsuitPaymentupdDelete(map_pay_del).then((onValue) {
        print("PayDetail Del All : " + onValue.Msg);
      });
    }

    await new LawsuitFuture().apiRequestLawsuitupdAll(map).then((onValue) {
      print("Law Update : " + onValue.Msg);
      IsSuccess = onValue.IsSuccess.endsWith("True") ? true : false;
    });

    if (IsSuccess) {
      if (IsInsertPayment) {
        await new LawsuitFuture().apiRequestLawsuitPaymentinsAll(map_pay).then((onValue) {
          print("PayDetail Ins : " + onValue.Msg);
          IsSuccess = onValue.IsSuccess.endsWith("True") ? true : false;
        });
      }
    }

    if (IsSuccess) {
      if (IsCreate) {
        if (_onEdited) {
          /*//Delete Document
          List<Map> _mapDelDoc=[];
          widget.itemDocument.forEach((_file){
            if(_file.DOCUMENT_ID!=null){
              if(_file.IS_ACTIVE==1) {
                _mapDelDoc.add({
                  "DOCUMENT_ID": _file.DOCUMENT_ID
                });
              }
            }
          });
          //Delete Document
          for (int i = 0; i < _mapDelDoc.length; i++) {
            await new TransectionFuture()
                .apiRequestDocumentupdDelete(_mapDelDoc[i])
                .then((onValue) {
              print(
                  "Delete [" + i.toString() + "] : " + onValue.Msg.toString());
            });
          }

          //Adding Document
          List<Map> _arrJsonImg = [];
          _arrItemsImageFile.forEach((_file) {
            String base64Image = base64Encode(
                _file.FILE_CONTENT.readAsBytesSync());
            _arrJsonImg.add({
              "DATA_SOURCE": "",
              "DOCUMENT_ID": "",
              "DOCUMENT_NAME": _file.DOCUMENT_NAME,
              "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
              "DOCUMENT_TYPE": "4",
              "FILE_TYPE": "jpg",
              "FOLDER": "document",
              "IS_ACTIVE": "1",
              "REFERENCE_CODE": itemMain.LAWSUIT_DETAIL_ID,
              "CONTENT": base64Image
            });
          });

          for (int i = 0; i < _arrJsonImg.length; i++) {
            await new TransectionFuture()
                .apiRequestDocumentinsAll(
                _arrJsonImg[i], _arrItemsImageFile[i].FILE_CONTENT)
                .then((onValue) {
              print(
                  "[" + i.toString() + "] : " + onValue.DOCUMENT_ID.toString());
            });
          }*/

          //Adding Document
          List<Map> _arrJsonImg = [];
          int index = _arrItemsImageFile.length;
          _arrItemsImageFileAdd.forEach((_file) {
            String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
            index++;
            _arrJsonImg.add({
              "DATA_SOURCE": "",
              "DOCUMENT_ID": "",
              "DOCUMENT_NAME": "คำพิพากษาศาล_" + itemMain.LAWSUIT_DETAIL_ID.toString() + "_" + index.toString(),
              "DOCUMENT_NAME": _file.DOCUMENT_NAME,
              "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
              "DOCUMENT_TYPE": "4",
              "FILE_TYPE": "jpg",
              "FOLDER": "document",
              "IS_ACTIVE": "1",
              "REFERENCE_CODE": itemMain.LAWSUIT_DETAIL_ID,
              "CONTENT": base64Image
            });
          });
          for (int i = 0; i < _arrJsonImg.length; i++) {
            await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i], _arrItemsImageFileAdd[i].FILE_CONTENT).then((onValue) {
              print("Update Add [" + i.toString() + "] : " + onValue.DOCUMENT_ID.toString());
            });
          }

          //Delete Document
          for (int i = 0; i < _arrItemsImageFileDelete.length; i++) {
            Map map = {"DOCUMENT_ID": _arrItemsImageFileDelete[i]};
            print(map);
            await new TransectionFuture().apiRequestDocumentupdDelete(map).then((onValue) {
              print("Delete [" + i.toString() + "] : " + onValue.Msg.toString());
            });
          }
        } else {
          List<Map> _arrJsonImg = [];
          _arrItemsImageFile.forEach((_file) {
            String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
            _arrJsonImg
                .add({"DATA_SOURCE": "", "DOCUMENT_ID": "", "DOCUMENT_NAME": _file.DOCUMENT_NAME, "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME, "DOCUMENT_TYPE": "4", "FILE_TYPE": "jpg", "FOLDER": "document", "IS_ACTIVE": "1", "REFERENCE_CODE": itemMain.LAWSUIT_DETAIL_ID, "CONTENT": base64Image});
          });

          for (int i = 0; i < _arrJsonImg.length; i++) {
            await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i], _arrItemsImageFile[i].FILE_CONTENT).then((onValue) {
              print("[" + i.toString() + "] : " + onValue.DOCUMENT_ID.toString());
            });
          }
        }
      }

      if (IsDelete) {
        for (int i = 0; i < _arrItemsImageFileDelete.length; i++) {
          Map map = {"DOCUMENT_ID": _arrItemsImageFileDelete[i]};
          print(map);
          await new TransectionFuture().apiRequestDocumentupdDelete(map).then((onValue) {
            print("Delete [" + i.toString() + "] : " + onValue.Msg.toString());
          });
        }

        //delete payment
        await new LawsuitFuture().apiRequestLawsuitPaymentupdDelete(map_pay).then((onValue) {
          print("PayDetail Del : " + onValue.Msg);
        });
      }

      map = {"LAWSUIT_ID": itemMain.LAWSUIT_ID};
      await new LawsuitFuture().apiRequestLawsuitgetByCon(map).then((onValue) {
        itemsLawsuitMain = onValue;
        itemsLawsuitMain.LawsuitDetail.forEach((f) {
          if (itemMain.LAWSUIT_DETAIL_ID == f.LAWSUIT_DETAIL_ID) {
            itemMain = f;
          }
        });
      });

      Map map_doc = {"DOCUMENT_TYPE": 4, "REFERENCE_CODE": itemMain.LAWSUIT_DETAIL_ID};
      await new TransectionFuture().apiRequestGetDocumentByCon(map_doc).then((onValue) {
        List<ItemsListDocument> items = [];
        onValue.forEach((f) {
          if (int.parse(f.IS_ACTIVE) == 1) {
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
          }
        });
        widget.itemDocument = items;
        _arrItemsImageFile = items;
        _arrItemsImageFileInit = items;
        setState(() {});
      });

      _arrItemsImageFileDelete = [];
      _arrItemsImageFileAdd = [];

      _onSaved = true;
      _onFinish = true;
      _onEdited = false;
    } else {}

    setState(() {});
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final List<Widget> rowContents = <Widget>[
      new SizedBox(
          width: width / 3.5,
          child: new Center(
            child: new FlatButton(
              onPressed: () {
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
            ),
          )),
      Expanded(
          child: Center(
        child: Text("", style: appBarStyle),
      )),
      new SizedBox(
          width: width / 3.5,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _onSaved
                  ? (_onSave
                      ? new FlatButton(
                          onPressed: () {
                            print("asdasd");
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
                        onSaved(context, false);
                      },
                      child: Text('บันทึก', style: appBarStyle)),
            ],
          ))
    ];

    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              primary: true,
              pinned: false,
              title: Text(
                'คำพิพากษาศาล',
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
                  body: Stack(
                children: <Widget>[
                  BackgroundContent(),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          //height: 34.0,
                          decoration: BoxDecoration(
                              border: Border(
                            top: BorderSide(color: Colors.grey[300], width: 1.0),
                            //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                          )),
                          /*child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: new Text(
                                'ILG60_B_02_00_06_00', style: textStylePageName,),
                            )
                          ],
                        ),*/
                        ),
                        Expanded(
                          child: _onSaved ? _buildContent_saved(context) : _buildContent(),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
        //bottomNavigationBar: _buildBottom(context),
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

  String _convertNoYear(String sDate) {
    DateTime dt = DateTime.parse(sDate);
    String result = (int.parse(DateFormat("yyyy").format(dt)) + 543).toString();
    return result;
  }
}

class ListBankModel {
  int BankID;
  String BankName;
  ListBankModel({
    this.BankID,
    this.BankName,
  });
}

class ListChannelModel {
  int ChannelID;
  String ChannelName;
  ListChannelModel({
    this.ChannelID,
    this.ChannelName,
  });
}

class ListDateUnitModel {
  int DateUnitID;
  String DateUnitName;
  ListDateUnitModel({
    this.DateUnitID,
    this.DateUnitName,
  });
}

class ListCourtEndModel {
  int CourtEndID;
  String CourtEndName;
  ListCourtEndModel({
    this.CourtEndID,
    this.CourtEndName,
  });
}
