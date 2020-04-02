import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:geocoder/model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/Model/choice.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment_detail.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment_edit.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment_product_edit.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main_edit.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_staff.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category_SRP.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_GROUP_category_SRP_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/response/item_arrest_response_indicment.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_3/tab_screen_arrest_3_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_create.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_created.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_creating.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_edit.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_evidence.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/future/item_transection.dart';
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_2.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_location.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_main.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_1/tab_screen_arrest_1_map_custom.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_2/tab_screen_arrest_2_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_3/tab_screen_arrest_3_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_4/tab_screen_arrest_4_add.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_5/tab_screen_arrest_5_add.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_product.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:location/location.dart' as Locations;
import 'package:flutter/services.dart';
import 'package:async_loader/async_loader.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_7.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_8.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_search.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_screen_arrest/tab_arrest_8/tab_screen_arrest_8_dowload.dart';
import 'package:prototype_app_pang/model/Constants.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/ItemsPersonInfomation.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/items_OAGMasStaff.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/picker/date_picker_arrest.dart';
import 'package:video_player/video_player.dart';

import 'model/item_arrest_5.dart';
import 'model/master/item_document.dart';
import 'model/master/item_product_GROUP_category.dart';

const double _kPickerSheetHeight = 216.0;

class ArrestMainScreenFragment extends StatefulWidget {
  final ItemsListArrestMain ITEMS_ARREST;
  ItemsListArrestMainEdit ITEMS_ARREST_EDIT;
  bool IsPreview;
  bool IsUpdate;
  bool IsCreate;
  /*String ARREST_CODE;
  bool IsArrestCode;
  ItemsListTransection itemsListTransection;*/
  // ItemsPersonInformation ItemsPerson;
  ItemsOAGMasStaff ItemsPerson;
  ItemsMasterTitleResponse itemsTitle;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  List<ItemsListArrest6Section> ItemsGuiltbase;
  List<ItemsListDocument> itemsListDocument;
  ArrestMainScreenFragment({
    Key key,
    @required this.ITEMS_ARREST,
    @required this.ITEMS_ARREST_EDIT,
    @required this.IsPreview,
    @required this.IsUpdate,
    @required this.IsCreate,
    @required this.ItemsPerson,
    @required this.itemsTitle,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
    @required this.itemsListDocument,
    /* @required this.ARREST_CODE,
    @required this.IsArrestCode,
    @required this.itemsListTransection,*/
    @required this.ItemsGuiltbase,
  }) : super(key: key);
  @override
  _ArrestMainScreenFragmentState createState() => new _ArrestMainScreenFragmentState();
}

class _ArrestMainScreenFragmentState extends State<ArrestMainScreenFragment> with TickerProviderStateMixin {
  ArrestFuture future = new ArrestFuture();

  final formatter = new NumberFormat("#,###.###");
  final formatter_product = new NumberFormat("#,##0.000");

  //app bar
  TextStyle tabStyle = TextStyle(fontSize: 16.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);

  TextStyle textDataTitleStyle = TextStyle(fontSize: 18.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textDataStyleSub = TextStyle(fontSize: 14.0, color: Colors.black54, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textLabelDeleteStyle = TextStyle(fontSize: 16.0, color: Colors.red, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSubCont = TextStyle(fontSize: 14.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily);
  TextStyle textStyleLink = TextStyle(color: Color(0xff4564c2), fontFamily: FontStyles().FontFamily);
  TextStyle textStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);

  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSub = TextStyle(fontSize: 16.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily);

  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

  //paffing
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  EdgeInsets paddingInputBoxSub = EdgeInsets.only(top: 8.0, bottom: 8.0);

  ItemsListArrestMain _arrestMain;
  ItemsListArrestMainEdit _arrestMainEdit;
  ItemsListArrestLocation _itemsLocale = null;

  TabController tabController;
  TabPageSelector _tabPageSelector;
  int _currentIndex = 0;
  VoidCallback onChanged;

  bool _onSaved = false;
  bool _onEdited = false;
  bool _onDeleted = false;
  bool _onSave = false;
  bool _onFinish = false;

  bool TESTIMONY = false;

  bool IsPlace = false;

  List<Constants> constants = const <Constants>[
    const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
    const Constants(text: 'ลบ', icon: Icons.delete_outline),
  ];

  final GlobalKey<AsyncLoaderState> _asyncLoaderState = new GlobalKey<AsyncLoaderState>();

  List<Choice> choices = <Choice>[
    Choice(title: 'ข้อมูลการจับกุม'),
    Choice(title: 'ใบแจ้งความ'),
    Choice(title: 'ผู้จับกุม/ผู้ร่วมจับกุม'),
    Choice(title: 'ผู้ต้องหา'),
    Choice(title: 'ของกลาง'),
    Choice(title: 'ข้อกล่าวหา'),
    Choice(title: 'พฤติกรรมการจับ'),
  ];

  String _arrestDate;
  String _currentDateArrestTH, _currentDateArrestEN, _currentDateCreateTH, _currentDateCreateEN;
  DateTime _dtArrest, _dtMaxDate, _dtMinDate, _dtCreate;

  //is delete
  List<int> list_delete_lawbreaker = [];
  List<int> list_delete_notice = [];
  List<int> list_delete_staff = [];
  List<int> list_delete_product = [];
  List<int> list_delete_indicment = [];
  List<int> list_delete_indicment_delt = [];
  List<int> list_delete_indicment_pro = [];

  //is add
  List list_add_lawbreaker = [];
  List list_add_notice = [];
  List list_add_staff = [];
  List list_add_product = [];
  List list_add_indicment = [];
  List<Map> list_add_product_for_edit = [];
  List<Map> list_add_product_for_edit_product_id_null = [];

  //is update
  List list_update_product = [];
  List list_update_indicment = [];
  List list_update_indicment_pro = [];
  ItemsListArrestLocation list_update_location;

  List<ItemsListTransection> _itemTransection = [];
  String transection_no;
  bool IsArrestCode;
  bool InsertNotSuccess = false;
  //on show dialog
  Future<bool> onLoadActionInsAll(/*Map map*/) async {
    List<Map> ArrestIndictment = [];
    List<Map> ArrestProduct = [];
    InsertNotSuccess = false;

    //**************************Running Arrest Code*********************
    Map map_transec = {"RUNNING_TABLE": "OPS_ARREST", "RUNNING_OFFICE_CODE": _itemsLocale.SUB_DISTICT.OFFICE_CODE};
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
        transection_no = "TN" + _itemsLocale.SUB_DISTICT.OFFICE_CODE + date_auto + "00001";
      }
    });
    print("transection_no : " + transection_no);

    await future.apiRequestInsAll(putDataRequest()).then((onValue) async {
      print("ARREST_ID : " + onValue.ARREST_ID.toString());
      if (onValue != null && onValue.ARREST_ID != 0) {
        _itemsInitTab6.forEach((item) {
          List<Map> ArrestLawbreaker = [];
          List<Map> ArrestProductInside = [];

          //IndicmentProduct
          item.ArrestIndictmentProduct.forEach((item) {
            ArrestProductInside.add({
              "FINE_ESTIMATE": "",
              "INDICTMENT_DETAIL_ID": "",
              "IS_ACTIVE": 1,
              "IS_ILLEGAL": 1,
              "PRODUCT_BRAND_NAME_EN": "",
              "PRODUCT_BRAND_NAME_TH": "",
              "PRODUCT_CATEGORY_NAME": "",
              "PRODUCT_GROUP_NAME": "",
              "PRODUCT_ID": onValue.ArrestProduct[item.INDEX].PRODUCT_ID,
              "PRODUCT_INDICTMENT_ID": "",
              "PRODUCT_MODEL_NAME_EN": "",
              "PRODUCT_MODEL_NAME_TH": "",
              "PRODUCT_SUBBRAND_NAME_EN": "",
              "PRODUCT_SUBBRAND_NAME_TH": "",
              "PRODUCT_SUBSETTYPE_NAME": "",
              "PRODUCT_SUBTYPE_NAME": "",
              "PRODUCT_TYPE_NAME": "",
              "QUANTITY": item.QUANTITY,
              "QUANTITY_UNIT": item.QUANTITY_UNIT,
              "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
              "SIZES": item.SIZES,
              "SIZES_UNIT": item.SIZES_UNIT,
              "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
              "VOLUMN": item.VOLUMN,
              "VOLUMN_UNIT": item.VOLUMN_UNIT,
              "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID
            });
          });

          //IndicmentDetail
          if (item.ArrestIndictmentDetail.length > 0) {
            item.ArrestIndictmentDetail.forEach((item) {
              ArrestLawbreaker.add({
                "ArrestIndictmentProduct": ArrestProductInside,
                "FINE_ESTIMATE": "",
                "FIRST_NAME": "",
                "INDICTMENT_DETAIL_ID": "",
                "INDICTMENT_ID": "",
                "IS_ACTIVE": 1,
                "LAST_NAME": "",
                "LAWBREAKER_ID": onValue.ArrestLawbreaker[item.INDEX].LAWBREAKER_ID,
                "MIDDLE_NAME": "",
                "OTHER_NAME": "",
                "TITLE_NAME_EN": "",
                "TITLE_NAME_TH": "",
                "TITLE_SHORT_NAME_EN": "",
                "TITLE_SHORT_NAME_TH": ""
              });
            });
          } else {
            ArrestLawbreaker.add({
              "ArrestIndictmentProduct": ArrestProductInside,
              "FINE_ESTIMATE": "",
              "FIRST_NAME": "",
              "INDICTMENT_DETAIL_ID": "",
              "INDICTMENT_ID": "",
              "IS_ACTIVE": 1,
              "LAST_NAME": "",
              "LAWBREAKER_ID": "",
              "MIDDLE_NAME": "",
              "OTHER_NAME": "",
              "TITLE_NAME_EN": "",
              "TITLE_NAME_TH": "",
              "TITLE_SHORT_NAME_EN": "",
              "TITLE_SHORT_NAME_TH": ""
            });
          }

          ArrestIndictment.add({
            "ARREST_ID": onValue.ARREST_ID,
            "ArrestIndictmentDetail": ArrestLawbreaker,
            "FINE": item.FINE,
            "FINE_ESTIMATE": item.FINE_ESTIMATE,
            "GUILTBASE_ID": item.GUILTBASE_ID,
            "GUILTBASE_NAME": item.GUILTBASE_NAME,
            "INDICTMENT_ID": "",
            "IS_ACTIVE": 1,
            "IS_COMPARE": "",
            "IS_LAWSUIT_COMPLETE": 0,
            "IS_PROVE": "",
            "PENALTY_DESC": item.PENALTY_DESC,
            "SECTION_NAME": item.SECTION_NAME,
            "SUBSECTION_DESC": item.SUBSECTION_DESC,
            "SUBSECTION_NAME": item.SUBSECTION_NAME
          });
        });
        //Update Notice
        List<Map> map_notice = [];
        _itemsDataTab2.forEach((item) {
          map_notice.add({"NOTICE_ID": item.NOTICE_ID, "ARREST_ID": onValue.ARREST_ID});
        });
        await future.apiRequestArrestNoticeupdByCon(map_notice).then((onValue) {
          print("Notice : " + onValue.Msg);
        });

        //inset Indicment
        ItemsArrestResponseIndicment item_indicment;
        await future.apiRequestInsIndictment(ArrestIndictment).then((onValue) {
          print("Indic : " + onValue.Msg);
          item_indicment = onValue;
        });

        /*for(int i=0;i<_itemsInitTab6.length;i++){
          for(int j=0;j<_itemsInitTab6[i].ArrestIndictmentProduct.length;j++){
            for(int k=0;k<item_indicment.ArrestIndictment[i].ArrestIndictmentDetail.length;k++){
              ArrestProduct.add({
                "PRODUCT_INDICTMENT_ID": "",
                "PRODUCT_ID": onValue.ArrestProduct[_itemsInitTab6[i].ArrestIndictmentProduct[j].INDEX].PRODUCT_ID,
                "INDICTMENT_ID": item_indicment.ArrestIndictment[i].ArrestIndictmentDetail[k].INDICTMENT_DETAIL_ID,
                "SIZES_UNIT_ID": _itemsInitTab6[i].ArrestIndictmentProduct[j].SIZES_UNIT_ID,
                "QUATITY_UNIT_ID": _itemsInitTab6[i].ArrestIndictmentProduct[j].QUATITY_UNIT_ID,
                "VOLUMN_UNIT_ID": _itemsInitTab6[i].ArrestIndictmentProduct[j].VOLUMN_UNIT_ID,
                "SIZES": _itemsInitTab6[i].ArrestIndictmentProduct[j].SIZES,
                "SIZES_UNIT": _itemsInitTab6[i].ArrestIndictmentProduct[j].SIZES_UNIT,
                "QUANTITY": _itemsInitTab6[i].ArrestIndictmentProduct[j].QUANTITY,
                "QUANTITY_UNIT": _itemsInitTab6[i].ArrestIndictmentProduct[j].QUANTITY_UNIT,
                "VOLUMN": _itemsInitTab6[i].ArrestIndictmentProduct[j].VOLUMN,
                "VOLUMN_UNIT": _itemsInitTab6[i].ArrestIndictmentProduct[j].VOLUMN_UNIT,
                "FINE_ESTIMATE": "",
                "IS_ILLEGAL": 1,
                "IS_ACTIVE": 1
              });
            }
          }
        }
        print("ArrestProduct : "+ArrestProduct.length.toString());

        if(ArrestProduct.isNotEmpty) {
          String IsSuccess_indic;
          await future.apiRequestArrestIndictmentProductinsAll(ArrestProduct)
              .then((onValue) {
            if (onValue != null) {
              print("Indic Product : " + onValue.Msg);
              IsSuccess_indic = onValue.IsSuccess;
            }
          });
          if (IsSuccess_indic == null || IsSuccess_indic == "False") {
            Navigator.pop(context);
            new NetworkDialog(context, "บันทึกข้อมูลส่วนข้อกล่าวหาไม่สำเร็จ!");
          }
        }*/

        /*List<Map> _arrJsonImg=[];
        if(itemsVideoFile!=null){
          String base64Image = base64Encode(itemsVideoFile.FILE_CONTENT.readAsBytesSync());
          _arrJsonImg.add({
            "DATA_SOURCE": "",
            "DOCUMENT_ID": "",
            "DOCUMENT_NAME": transection_no,
            "DOCUMENT_OLD_NAME": itemsVideoFile.DOCUMENT_OLD_NAME,
            "DOCUMENT_TYPE": "3",
            "FILE_TYPE": "mp4",
            "FOLDER": "Document",
            "IS_ACTIVE": "1",
            "REFERENCE_CODE": onValue.ARREST_ID,
            "CONTENT":base64Image
          });
        }

        for(int i=0;i<_arrJsonImg.length;i++){
          await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i]).then((onValue) {
            print("["+i.toString()+"] : "+onValue.DOCUMENT_ID.toString());
          });
        }*/
        if (itemsVideoFile.length > 0) {
          print("itemsVideoFile.length");
          for (int i = 0; i < itemsVideoFile.length; i++) {
            List splits = itemsVideoFile[i].DOCUMENT_NAME.split(".");
            Map map = {
              "DATA_SOURCE": "",
              "DOCUMENT_ID": "",
              "DOCUMENT_NAME": /*transection_no + "_video.mp4"*/ itemsVideoFile[i].DOCUMENT_NAME,
              "DOCUMENT_OLD_NAME": itemsVideoFile[i].FILE_CONTENT.path,
              "DOCUMENT_TYPE": "3",
              "FILE_TYPE": splits.last,
              "FOLDER": splits.last.toString().endsWith("mp4") ? "vdo" : "document",
              "IS_ACTIVE": "1",
              "REFERENCE_CODE": onValue.ARREST_ID,
              "CONTENT": ""
            };
            await new TransectionFuture().apiRequestDocumentinsAll(map, itemsVideoFile[i].FILE_CONTENT).then((onValue) {
              print(onValue.Msg + ", " + onValue.DOCUMENT_ID.toString());
            });
          }
        }

        if (IsArrestCode) {
          Map map_tran_up = {
            "RUNNING_ID": _itemTransection.last.RUNNING_ID,
          };
          await new TransectionFuture().apiRequestTransactionRunningupdByCon(map_tran_up).then((onValue) {
            print("Update Transection : " + onValue.Msg);
          });
        } else {
          Map map_tran_ins = {"RUNNING_OFFICE_ID": 30, "RUNNING_OFFICE_CODE": _itemsLocale.SUB_DISTICT.OFFICE_CODE, "RUNNING_TABLE": "OPS_ARREST", "RUNNING_PREFIX": "TN"};
          await new TransectionFuture().apiRequestTransactionRunninginsAll(map_tran_ins).then((onValue) {
            print("Insert Transection : " + onValue.Msg);
          });
        }

        Map MAP_ARREST_ID = {'ARREST_ID': onValue.ARREST_ID};
        await future.apiRequestGet(MAP_ARREST_ID).then((onValue) {
          _arrestMain = onValue;

          onValue.ArrestIndictment.forEach((f) {
            _tempIndictmentEdit.add(f);
          });

          //sort staff
          _arrestMain.ArrestStaff.sort((a, b) {
            return a.STAFF_ID.compareTo(b.STAFF_ID);
          });

          _setItemProductOps();
        });
        await future.apiRequestGetEdit(MAP_ARREST_ID).then((onValue) {
          _arrestMainEdit = onValue;
        });

        //get VDO
        Map map = {"DOCUMENT_TYPE": 3, "REFERENCE_CODE": onValue.ARREST_ID};

        await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
          List<ItemsListDocument> items = [];
          onValue.forEach((item) {
            if (int.parse(item.IS_ACTIVE) == 1) {
              items.add(item);
            }
          });

          List<ItemsListDocument> items_doc = [];
          print(items.length);
          items.forEach((f) {
            File _file = new File(f.DOCUMENT_OLD_NAME);
            items_doc.add(new ItemsListDocument(
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

            _controller = VideoPlayerController.file(_file)
              ..addListener(listener)
              ..setVolume(1.0)
              ..initialize()
              ..setLooping(false)
              ..play();
          });
          itemsVideoFile = items_doc;
        });

        widget.IsCreate = false;
        _onSaved = true;
        _onFinish = true;
        choices.add(Choice(title: 'แบบฟอร์ม'));
        int index = 6;
        tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
        _tabPageSelector = new TabPageSelector(controller: tabController);
        tabController.animateTo((choices.length - 1));

        _itemsDataTab8 = [];
        _itemsDataTab8.add(ItemsListArrest8("แบบฟอร์มบันทึกการจับ 2/39", "ILG60_00_03_001"));
      } else {
        InsertNotSuccess = true;
        /*Navigator.pop(context);
        new NetworkDialog(context,"บันทึกข้อมูลไม่สำเร็จ!");*/
      }
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionMasPersonupdDelete(Map map) async {
    await new ArrestFuture().apiRequestMasPersonupdDelete(map).then((onValue) {
      if (onValue.SUCCESS == true) {
        print("MasPersonupdDelete : ${onValue.SUCCESS}");
      }
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionDelete(Map map) async {
    await future.apiRequestDelete(map).then((onValue) {
      if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
        print(onValue.Msg);
      }
    });
    Navigator.pop(context);
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionArrestLawbreakerupdDelete(
      Map map_arrest,
      List<Map> map_del_notice,
      List<Map> map_del_law,
      List<Map> map_del_indic_detail,
      List<Map> map_del_staff,
      List<Map> map_del_pro,
      List<Map> map_del_indic_product,
      List<Map> map_del_indic_all,
      List<Map> map_upadd_notice,
      List<Map> map_upadd_staff,
      List<Map> map_upadd_law,
      List<Map> map_upadd_pro,
      List<Map> map_upadd_indic,
      List<Map> map_up_indic,
      List<Map> map_up_indic_pro,
      List<Map> map_up_indic_delt,
      List<Map> map_up_pro,
      bool IsDelNotice,
      bool IsDelLawbreaker,
      bool IsDelIndicmentDetail,
      bool IsDelStaff,
      bool IsDelProduct,
      bool IsDelIndicmentProduct,
      bool IsDelIndicment,
      bool IsUpAddNotice,
      bool IsUpAddStaff,
      bool IsUpAddLawbreaker,
      bool IsUpAddProduct,
      bool IsUpAddIndicmen,
      bool IsUpIndicmen,
      bool IsUpIndicmenPro,
      bool IsUpIndicmenDelt,
      bool IsUpProduct) async {
    await future.apiRequestArrestupdByCon(map_arrest).then((onValue) {
      if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
        print("Up Arrest : " + onValue.Msg);
        //Navigator.pop(context);
      }
    });

    //Update Contibutor Staff
    List<Map> mapUpStaff = [];
    _arrestMain.ArrestStaff.forEach((item) {
      int conn;
      if (item.ArrestType.toString().trim().endsWith("ผู้จับกุม")) {
        conn = 14;
      } else if (item.ArrestType.toString().trim().endsWith("ผู้ร่วมจับกุม")) {
        conn = 15;
      } else {
        conn = 10;
      }
      if (conn != item.CONTRIBUTOR_ID) {
        print("conn : " + conn.toString());
        mapUpStaff.add({
          "STAFF_ID": item.STAFF_ID,
          "ARREST_ID": _arrestMain.ARREST_ID,
          "STAFF_REF_ID": item.STAFF_REF_ID,
          "TITLE_ID": "",
          "STAFF_CODE": "",
          "ID_CARD": item.ID_CARD,
          "STAFF_TYPE": item.STAFF_TYPE,
          "TITLE_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "TITLE_NAME_EN": "Mister",
          "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
          "FIRST_NAME": item.FIRST_NAME,
          "LAST_NAME": item.LAST_NAME,
          "AGE": "",
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
          "MANAGEMENT_POS_CODE": "",
          "MANAGEMENT_POS_NAME": item.MANAGEMENT_POS_NAME != null ? item.MANAGEMENT_POS_NAME : "",
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
          "STATUS": 1,
          "REMARK": "",
          "CONTRIBUTOR_ID": item.ArrestType == "ผู้จับกุม" ? 14 : (item.ArrestType == "ผู้สั่งการ" ? 10 : 15),
          "IS_ACTIVE": 1
        });
      }
    });

    await future.apiRequestArrestStaffupdByCon(mapUpStaff).then((onValue) {
      if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
        print("Up Contibutor Staff : " + onValue.Msg);
        //Navigator.pop(context);
      }
    });

    if (!IsDelNotice) {
      await future.apiRequestArrestNoticeupdDelete(map_del_notice).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Del Notice : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }

    if (!IsDelLawbreaker) {
      print("del law : " + map_del_law.toString());
      await future.apiRequestArrestLawbreakerupdDelete(map_del_law).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Del Lawbreaker : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsDelIndicmentDetail) {
      await future.apiRequestArrestIndictmentDetailupdDelete(map_del_indic_detail).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Del IndicDetail : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsDelStaff) {
      await future.apiRequestArrestStaffupdDelete(map_del_staff).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Del Staff : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsDelProduct) {
      await future.apiRequestArrestProductupdDelete(map_del_pro).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Del Product : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsDelIndicmentProduct) {
      await future.apiRequestArrestIndictmentProductupdDelete(map_del_indic_product).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Del IndicProduct : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }

    if (!IsDelIndicment) {
      await future.apiRequestArrestIndictmentupdDelete(map_del_indic_all).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Del Indictment : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }
    if (!IsUpAddNotice) {
      await future.apiRequestArrestNoticeupdByCon(map_upadd_notice).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Add Notice : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }

    if (!IsUpAddStaff) {
      await future.apiRequestArrestStaffinsAll(map_upadd_staff).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Add Staff : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }

    List tempLawbreaker = [];
    List<Map> tempMap = [];
    List<Map> tempProduct = [];
    // ======================== Add new people to already indictment ========================
    if (!IsUpAddLawbreaker) {
      await future.apiRequestArrestLawbreakerinsAll(map_upadd_law).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Add Law : " + onValue.Msg);
          onValue.ArrestLawbreaker.forEach((f) {
            tempLawbreaker.add(f);
          });
          //Navigator.pop(context);
        }
      });

      if (list_add_indicment.length > 0) {
        list_add_indicment.forEach((f) {
          f.ArrestIndictmentDetail.forEach((item) {
            // print("ArrestIndictmentDetail LAWBREAKER_ID2: ${item.LAWBREAKER_ID}");
            if (item.LAWBREAKER_ID == null) {
              tempLawbreaker.forEach((f) {
                // print("list_add person1: ${item.PERSON_ID}, f1: ${f.PERSON_ID}");
                if (f.PERSON_ID == item.PERSON_ID) {
                  item.LAWBREAKER_ID = f.LAWBREAKER_ID;
                }
              });
            }
          });
        });
      }

      // print("object map_up_indic_delt: ${map_up_indic_delt.length}");
      if (map_up_indic_delt.length > 0) {
        map_up_indic_delt.forEach((f) {
          if (f["LAWBREAKER_ID"] == null) {
            tempLawbreaker.forEach((item) {
              // print("list_add person2: ${item.PERSON_ID}, f2: ${f.PERSON_ID}");
              if (item.PERSON_ID == f["PERSON_ID"]) {
                tempMap.add({
                  "FINE_ESTIMATE": "",
                  "FIRST_NAME": "",
                  "INDICTMENT_DETAIL_ID": "",
                  "INDICTMENT_ID": f["INDICTMENT_ID"],
                  "IS_ACTIVE": 1,
                  "LAST_NAME": "",
                  "LAWBREAKER_ID": item.LAWBREAKER_ID,
                  "MIDDLE_NAME": "",
                  "OTHER_NAME": "",
                  "TITLE_NAME_EN": "",
                  "TITLE_NAME_TH": "",
                  "TITLE_SHORT_NAME_EN": "",
                  "TITLE_SHORT_NAME_TH": "",
                });
              }
            });
          }
        });
      }
    }

    if (!IsUpIndicmenDelt) {
      print("object map_up_indic_delt: ${map_up_indic_delt.length}");
      if (map_up_indic_delt.length > 0) {
        map_up_indic_delt.forEach((f) {
          if (f["LAWBREAKER_ID"] != null) {
            tempMap.add({
              "FINE_ESTIMATE": "",
              "FIRST_NAME": "",
              "INDICTMENT_DETAIL_ID": "",
              "INDICTMENT_ID": f["INDICTMENT_ID"],
              "IS_ACTIVE": 1,
              "LAST_NAME": "",
              "LAWBREAKER_ID": f["LAWBREAKER_ID"],
              "MIDDLE_NAME": "",
              "OTHER_NAME": "",
              "TITLE_NAME_EN": "",
              "TITLE_NAME_TH": "",
              "TITLE_SHORT_NAME_EN": "",
              "TITLE_SHORT_NAME_TH": "",
            });
          }
        });
      }
      if (tempMap.length > 0) {
        await future.apiRequestArrestIndictmentDetailinsAll(tempMap).then((onValue) {
          if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
            print("Up Add Indictment Detail : " + onValue.Msg);
            //Navigator.pop(context);
          }
        });
      }
    }

    // ========================== Insert new product ==================================================
    List tempResProduct = [];
    if (!IsUpAddProduct) {
      await future.apiRequestArrestProductinsAll(map_upadd_pro).then((onValue) {
        // print("result add pro : " + onValue.Msg.toString());
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          // print("Add Product : " + onValue.Msg);
          onValue.ArrestProduct.forEach((f) {
            tempResProduct.add(f);
          });
          //Navigator.pop(context);
        }
      });

      // add new product in new indictment
      if (list_add_indicment.length > 0) {
        list_add_indicment.forEach((f) {
          f.ArrestIndictmentProduct.forEach((item) {
            if (item.PRODUCT_ID == null) {
              for (var i = 0; i < tempResProduct.length; i++) {
                // print("list_add product: ${item.PRODUCT_REF_CODE}, tempResProduct: ${tempResProduct[i].PRODUCT_REF_CODE}");
                if (item.PRODUCT_REF_CODE == tempResProduct[i].PRODUCT_REF_CODE) {
                  item.PRODUCT_ID = tempResProduct[i].PRODUCT_ID;
                }
              }
            }
          });
        });
      }
      // **************************** add product haven't PRODUCT_ID
      _arrestMain.ArrestIndictment.forEach((f) {
        _arrestMainEdit.ArrestIndictment.forEach((f2) {
          if (f.INDICTMENT_ID != null) {
            if (f.INDICTMENT_ID == f2.INDICTMENT_ID) {
              f2.ArrestIndictmentDetail.forEach((f2_detail) async {
                if (f2_detail.INDICTMENT_DETAIL_ID != null) {
                  List tempProdID = [];
                  f2.ArrestIndictmentDetail[0].ArrestIndictmentProduct.forEach((f2_prod) {
                    tempProdID.add(f2_prod.PRODUCT_ID);
                  });
                  // print("tempProdID_old: ${tempProdID.toString()}");
                  List tempProdID2 = [];
                  f.ArrestIndictmentProduct.forEach((f_prod) {
                    tempProdID2.add(f_prod.PRODUCT_ID);
                  });
                  // print("tempProdID2_new_: ${tempProdID2.toString()}");
                  f.ArrestIndictmentProduct.where((m) => !tempProdID.contains(m.PRODUCT_ID)).map((obj) {
                    if (obj.PRODUCT_ID == null) {
                      for (var j = 0; j < tempResProduct.length; j++) {
                        if (obj.PRODUCT_REF_CODE == tempResProduct[j].PRODUCT_REF_CODE) {
                          // print("obj.PRODUCT_REF_CODE: ${obj.PRODUCT_REF_CODE}");
                          // print("tempResProduct[j].PRODUCT_REF_CODE: ${tempResProduct[j].PRODUCT_REF_CODE}");

                          list_add_product_for_edit.add({
                            "FINE_ESTIMATE": "",
                            "INDICTMENT_DETAIL_ID": f2_detail.INDICTMENT_DETAIL_ID,
                            "IS_ACTIVE": 1,
                            "IS_ILLEGAL": 1,
                            "PRODUCT_BRAND_NAME_EN": obj.PRODUCT_BRAND_NAME_EN,
                            "PRODUCT_BRAND_NAME_TH": obj.PRODUCT_BRAND_NAME_TH,
                            "PRODUCT_CATEGORY_NAME": obj.PRODUCT_CATEGORY_NAME,
                            "PRODUCT_GROUP_NAME": obj.PRODUCT_GROUP_NAME,
                            "PRODUCT_ID": tempResProduct[j].PRODUCT_ID,
                            "PRODUCT_INDICTMENT_ID": "",
                            "PRODUCT_MODEL_NAME_EN": obj.PRODUCT_MODEL_NAME_EN,
                            "PRODUCT_MODEL_NAME_TH": obj.PRODUCT_MODEL_NAME_TH,
                            "PRODUCT_SUBBRAND_NAME_EN": obj.PRODUCT_SUBBRAND_NAME_EN,
                            "PRODUCT_SUBBRAND_NAME_TH": obj.PRODUCT_SUBBRAND_NAME_TH,
                            "PRODUCT_SUBSETTYPE_NAME": obj.PRODUCT_SUBSETTYPE_NAME,
                            "PRODUCT_SUBTYPE_NAME": obj.PRODUCT_SUBTYPE_NAME,
                            "PRODUCT_TYPE_NAME": obj.PRODUCT_TYPE_NAME,
                            "QUANTITY": obj.QUANTITY,
                            "QUANTITY_UNIT": obj.QUANTITY_UNIT,
                            "QUATITY_UNIT_ID": obj.QUATITY_UNIT_ID,
                            "SIZES": obj.SIZES,
                            "SIZES_UNIT": obj.SIZES_UNIT,
                            "SIZES_UNIT_ID": obj.SIZES_UNIT_ID,
                            "VOLUMN": obj.VOLUMN,
                            "VOLUMN_UNIT": obj.VOLUMN_UNIT,
                            "VOLUMN_UNIT_ID": obj.VOLUMN_UNIT_ID,
                          });
                        }
                      }
                    }
                  }).toList();
                }
              });
            }
          }
        });
      });

      print("list_add_product_for_edit_product_id_null: ${list_add_product_for_edit_product_id_null.length}");
      if (list_add_product_for_edit_product_id_null.length > 0) {
        await future.apiRequestArrestIndictmentProductinsAll(list_add_product_for_edit_product_id_null).then((onValue) {
          if (onValue != null) {
            print("Up Add Indictment Product [haven't pro id]: " + onValue.Msg);
          }
        });
      }
    }
    // ==============================================================================================
    // ========================== Insert product that it have product id ============================
    _arrestMain.ArrestIndictment.forEach((f) {
      _arrestMainEdit.ArrestIndictment.forEach((f2) {
        if (f.INDICTMENT_ID != null) {
          if (f.INDICTMENT_ID == f2.INDICTMENT_ID) {
            f2.ArrestIndictmentDetail.forEach((f2_detail) {
              if (f2_detail.INDICTMENT_DETAIL_ID != null) {
                List tempProdID = [];
                f2.ArrestIndictmentDetail[0].ArrestIndictmentProduct.forEach((f2_prod) {
                  tempProdID.add(f2_prod.PRODUCT_ID);
                });
                // print("tempProdID_old: ${tempProdID.toString()}");
                List tempProdID2 = [];
                f.ArrestIndictmentProduct.forEach((f_prod) {
                  tempProdID2.add(f_prod.PRODUCT_ID);
                });
                // print("tempProdID2_new_: ${tempProdID2.toString()}");
                f.ArrestIndictmentProduct.where((m) => !tempProdID.contains(m.PRODUCT_ID)).map((obj) {
                  if (obj.PRODUCT_ID != null) {
                    list_add_product_for_edit.add({
                      "FINE_ESTIMATE": "",
                      "INDICTMENT_DETAIL_ID": f2_detail.INDICTMENT_DETAIL_ID,
                      "IS_ACTIVE": 1,
                      "IS_ILLEGAL": 1,
                      "PRODUCT_BRAND_NAME_EN": obj.PRODUCT_BRAND_NAME_EN,
                      "PRODUCT_BRAND_NAME_TH": obj.PRODUCT_BRAND_NAME_TH,
                      "PRODUCT_CATEGORY_NAME": obj.PRODUCT_CATEGORY_NAME,
                      "PRODUCT_GROUP_NAME": obj.PRODUCT_GROUP_NAME,
                      "PRODUCT_ID": obj.PRODUCT_ID,
                      "PRODUCT_INDICTMENT_ID": "",
                      "PRODUCT_MODEL_NAME_EN": obj.PRODUCT_MODEL_NAME_EN,
                      "PRODUCT_MODEL_NAME_TH": obj.PRODUCT_MODEL_NAME_TH,
                      "PRODUCT_SUBBRAND_NAME_EN": obj.PRODUCT_SUBBRAND_NAME_EN,
                      "PRODUCT_SUBBRAND_NAME_TH": obj.PRODUCT_SUBBRAND_NAME_TH,
                      "PRODUCT_SUBSETTYPE_NAME": obj.PRODUCT_SUBSETTYPE_NAME,
                      "PRODUCT_SUBTYPE_NAME": obj.PRODUCT_SUBTYPE_NAME,
                      "PRODUCT_TYPE_NAME": obj.PRODUCT_TYPE_NAME,
                      "QUANTITY": obj.QUANTITY,
                      "QUANTITY_UNIT": obj.QUANTITY_UNIT,
                      "QUATITY_UNIT_ID": obj.QUATITY_UNIT_ID,
                      "SIZES": obj.SIZES,
                      "SIZES_UNIT": obj.SIZES_UNIT,
                      "SIZES_UNIT_ID": obj.SIZES_UNIT_ID,
                      "VOLUMN": obj.VOLUMN,
                      "VOLUMN_UNIT": obj.VOLUMN_UNIT,
                      "VOLUMN_UNIT_ID": obj.VOLUMN_UNIT_ID,
                    });
                  }
                }).toList();
              }
            });
          }
        }
      });
    });
    print("list_add_product_for_edit: ${list_add_product_for_edit.length}");
    if (list_add_product_for_edit.length > 0) {
      await future.apiRequestArrestIndictmentProductinsAll(list_add_product_for_edit).then((onValue) {
        if (onValue != null) {
          print("Up Add Indictment Product [have pro id]: " + onValue.Msg);
        }
      });
    }
    // ==============================================================================================
    // ========================== Insert new มาตรา ==================================================
    List<Map> map_upadd_indicment = [];
    if (list_add_indicment.length > 0) {
      list_add_indicment.forEach((f) {
        List<Map> ArrestLawbreaker = [];
        List<Map> ArrestProductInside = [];

        f.ArrestIndictmentProduct.forEach((item) {
          ArrestProductInside.add({
            "PRODUCT_INDICTMENT_ID": "",
            "PRODUCT_ID": item.PRODUCT_ID,
            "INDICTMENT_ID": "",
            "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
            "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
            "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
            "SIZES": item.SIZES,
            "SIZES_UNIT": item.SIZES_UNIT,
            "QUANTITY": item.QUANTITY,
            "QUANTITY_UNIT": item.QUANTITY_UNIT,
            "VOLUMN": item.VOLUMN,
            "VOLUMN_UNIT": item.VOLUMN_UNIT,
            "FINE_ESTIMATE": "",
            "IS_ILLEGAL": 1,
            "IS_ACTIVE": 1
          });
        });
        // print(ArrestProductInside.toString());

        if (f.ArrestIndictmentDetail.length > 0) {
          f.ArrestIndictmentDetail.forEach((item) {
            // print("LAWBREAKER_ID: ${item.LAWBREAKER_ID}");
            ArrestLawbreaker.add({
              // "ArrestIndictmentProduct": ArrestProductInside,
              "FINE_ESTIMATE": "",
              "FIRST_NAME": "",
              "INDICTMENT_DETAIL_ID": "",
              "INDICTMENT_ID": "",
              "IS_ACTIVE": 1,
              "LAST_NAME": "",
              // "LAWBREAKER_ID": _arrestMain.ArrestLawbreaker[item.INDEX].LAWBREAKER_ID,
              "LAWBREAKER_ID": item.LAWBREAKER_ID,
              "MIDDLE_NAME": "",
              "OTHER_NAME": "",
              "TITLE_NAME_EN": "",
              "TITLE_NAME_TH": "",
              "TITLE_SHORT_NAME_EN": "",
              "TITLE_SHORT_NAME_TH": ""
            });
          });
          // print(ArrestLawbreaker.toString());
        } else {
          ArrestLawbreaker.add({
            "ArrestIndictmentProduct": ArrestProductInside,
            "FINE_ESTIMATE": "",
            "FIRST_NAME": "",
            "INDICTMENT_DETAIL_ID": "",
            "INDICTMENT_ID": "",
            "IS_ACTIVE": 1,
            "LAST_NAME": "",
            "LAWBREAKER_ID": "",
            "MIDDLE_NAME": "",
            "OTHER_NAME": "",
            "TITLE_NAME_EN": "",
            "TITLE_NAME_TH": "",
            "TITLE_SHORT_NAME_EN": "",
            "TITLE_SHORT_NAME_TH": ""
          });
        }

        map_upadd_indicment.add({
          "ARREST_ID": _arrestMain.ARREST_ID,
          "ArrestIndictmentDetail": ArrestLawbreaker,
          // "ArrestIndictmentProduct": ArrestProductInside,
          "ArrestIndictmentProduct": [],
          "FINE": f.FINE,
          "FINE_ESTIMATE": f.FINE_ESTIMATE,
          "GUILTBASE_ID": f.GUILTBASE_ID,
          "GUILTBASE_NAME": f.GUILTBASE_NAME,
          "INDICTMENT_ID": "",
          "IS_ACTIVE": 1,
          "IS_COMPARE": "",
          "IS_LAWSUIT_COMPLETE": 0,
          "IS_PROVE": "",
          "PENALTY_DESC": f.PENALTY_DESC,
          "SECTION_NAME": f.SECTION_NAME,
          "SUBSECTION_DESC": f.SUBSECTION_DESC,
          "SUBSECTION_NAME": f.SUBSECTION_NAME
        });
      });

      if (map_upadd_indicment.length > 0) {
        ItemsArrestResponseIndicment item_indicment;
        List<int> tempIndicmentID = [];
        await future.apiRequestInsIndictment(map_upadd_indicment).then((onValue) {
          if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
            print("Add Indictment : " + onValue.Msg);
            //Navigator.pop(context);
            item_indicment = onValue;
            onValue.ArrestIndictment.forEach((f) {
              f.ArrestIndictmentDetail.forEach((f2) {
                tempIndicmentID.add(f2.INDICTMENT_DETAIL_ID);
              });
            });
          }
        });

        List<Map> tempProductAddIndicment = [];
        for (int i = 0; i < list_add_indicment.length; i++) {
          for (int j = 0; j < list_add_indicment[i].ArrestIndictmentProduct.length; j++) {
            for (int k = 0; k < tempIndicmentID.length; k++) {
              if (list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_ID != null) {
                tempProductAddIndicment.add({
                  "FINE_ESTIMATE": "",
                  "INDICTMENT_DETAIL_ID": tempIndicmentID[k],
                  "IS_ACTIVE": 1,
                  "IS_ILLEGAL": 1,
                  "PRODUCT_BRAND_NAME_EN": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_EN,
                  "PRODUCT_BRAND_NAME_TH": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_TH,
                  "PRODUCT_CATEGORY_NAME": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_CATEGORY_NAME,
                  "PRODUCT_GROUP_NAME": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_GROUP_NAME,
                  "PRODUCT_ID": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_ID,
                  "PRODUCT_INDICTMENT_ID": "",
                  "PRODUCT_MODEL_NAME_EN": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_EN,
                  "PRODUCT_MODEL_NAME_TH": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_TH,
                  "PRODUCT_SUBBRAND_NAME_EN": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_EN,
                  "PRODUCT_SUBBRAND_NAME_TH": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_TH,
                  "PRODUCT_SUBSETTYPE_NAME": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_SUBSETTYPE_NAME,
                  "PRODUCT_SUBTYPE_NAME": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_SUBTYPE_NAME,
                  "PRODUCT_TYPE_NAME": list_add_indicment[i].ArrestIndictmentProduct[j].PRODUCT_TYPE_NAME,
                  "QUANTITY": list_add_indicment[i].ArrestIndictmentProduct[j].QUANTITY,
                  "QUANTITY_UNIT": list_add_indicment[i].ArrestIndictmentProduct[j].QUANTITY_UNIT,
                  "QUATITY_UNIT_ID": list_add_indicment[i].ArrestIndictmentProduct[j].QUATITY_UNIT_ID,
                  "SIZES": list_add_indicment[i].ArrestIndictmentProduct[j].SIZES,
                  "SIZES_UNIT": list_add_indicment[i].ArrestIndictmentProduct[j].SIZES_UNIT,
                  "SIZES_UNIT_ID": list_add_indicment[i].ArrestIndictmentProduct[j].SIZES_UNIT_ID,
                  "VOLUMN": list_add_indicment[i].ArrestIndictmentProduct[j].VOLUMN,
                  "VOLUMN_UNIT": list_add_indicment[i].ArrestIndictmentProduct[j].VOLUMN_UNIT,
                  "VOLUMN_UNIT_ID": list_add_indicment[i].ArrestIndictmentProduct[j].VOLUMN_UNIT_ID,
                });
              }
            }
          }
        }
        print("tempProductAddIndicment: ${tempProductAddIndicment.length}");
        if (tempProductAddIndicment.length > 0) {
          await future.apiRequestArrestIndictmentProductinsAll(tempProductAddIndicment).then((onValue) {
            if (onValue != null) {
              print("Up Add Indictment Product [New indicment]: " + onValue.Msg);
            }
          });
        }
      }
    }
    // ==============================================================================================

    if (!IsUpIndicmen) {
      await future.apiRequestArrestIndictmentupdByCon(map_up_indic).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Update Indictment : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });

      /*await future.apiRequestArrestIndictmentProductinsAll(map_up_indic_pro)
          .then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Add Indictment Product : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });*/
    }

    if (!IsUpIndicmenPro) {
      /*await future.apiRequestArrestIndictmentProductupdByCon(map_up_indic_pro)
          .then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Up Indictment Product : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
      await future.apiRequestArrestIndictmentProductinsAll(map_up_indic_pro)
          .then((onValue) {
        if (onValue.IsSuccess.endsWith("True") &&
            onValue.Msg.endsWith("Complete")) {
          print("Add Indictment Product : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });*/
    }

    if (!IsUpProduct) {
      await future.apiRequestArrestProductupdByCon(map_up_pro).then((onValue) {
        if (onValue.IsSuccess.endsWith("True") && onValue.Msg.endsWith("Complete")) {
          print("Up Product : " + onValue.Msg);
          //Navigator.pop(context);
        }
      });
    }

    for (int i = 0; i < itemsVideoFileDelete.length; i++) {
      Map map = {"DOCUMENT_ID": itemsVideoFileDelete[i].DOCUMENT_ID};
      print(map);
      await new TransectionFuture().apiRequestDocumentupdDelete(map).then((onValue) {
        print("Del VDO : " + onValue.Msg);
      });
    }

    if (itemsVideoFileAdd.length > 0) {
      for (int i = 0; i < itemsVideoFileAdd.length; i++) {
        List splits = itemsVideoFileAdd[i].DOCUMENT_NAME.split(".");
        Map map = {
          "DATA_SOURCE": "",
          "DOCUMENT_ID": "",
          "DOCUMENT_NAME": /*_arrestMain.ARREST_CODE+"_video.mp4"*/ itemsVideoFile[i].DOCUMENT_NAME,
          "DOCUMENT_OLD_NAME": itemsVideoFileAdd[i].FILE_CONTENT.path,
          "DOCUMENT_TYPE": "3",
          "FILE_TYPE": splits.last,
          "FOLDER": splits.last.toString().endsWith("mp4") ? "vdo" : "document",
          "IS_ACTIVE": "1",
          "REFERENCE_CODE": _arrestMain.ARREST_ID,
          "CONTENT": ""
        };

        await new TransectionFuture().apiRequestDocumentinsAll(map, itemsVideoFileAdd[i].FILE_CONTENT).then((onValue) {
          print("Add Up VDO : " + onValue.Msg + ", " + onValue.DOCUMENT_ID.toString());
        });
      }
    }

    //load data again
    Map MAP_ARREST_ID = {"ARREST_ID": _arrestMain.ARREST_ID};
    await future.apiRequestGet(MAP_ARREST_ID).then((onValue) {
      _arrestMain = onValue;

      _tempIndictmentEdit = [];
      onValue.ArrestIndictment.forEach((f) {
        _tempIndictmentEdit.add(f);
      });

      //sort staff
      _arrestMain.ArrestStaff.sort((a, b) {
        return a.STAFF_ID.compareTo(b.STAFF_ID);
      });

      _setItemProductOps();
    });

    await future.apiRequestGetEdit(MAP_ARREST_ID).then((onValue) {
      _arrestMainEdit = onValue;
    });

    // ====================================== Insert product to new people on already indictment ============================
    List<Map> tempNewPeople = [];
    List<ItemsListArrestIndictmentProductEdit> tempProdNewPeople = [];
    List<int> listLength = [];
    int maxLength = 0;

    _arrestMainEdit.ArrestIndictment.forEach((f) {
      tempProdNewPeople = [];
      // listLength = [];
      // maxLength = 0;
      // f.ArrestIndictmentDetail.forEach((element) {
      //   listLength.add(element.ArrestIndictmentProduct.length);
      // });
      // maxLength = listLength.reduce(max);
      // print("maxLength: ${maxLength}");
      // f.ArrestIndictmentDetail.forEach((element) {
      //   if (element.ArrestIndictmentProduct.length == maxLength) {
      //     tempProdNewPeople = element.ArrestIndictmentProduct;
      //   }
      // });
      for (var i = 0; i < f.ArrestIndictmentDetail.length; i++) {
        for (var j = 0; j < f.ArrestIndictmentDetail[i].ArrestIndictmentProduct.length; j++) {
          if (f.ArrestIndictmentDetail[i].ArrestIndictmentProduct.length != 0) {
            tempProdNewPeople = f.ArrestIndictmentDetail[i].ArrestIndictmentProduct;
            break;
          }
        }
      }
      f.ArrestIndictmentDetail.forEach((f_detail) {
        // print("f_detail.ArrestIndictmentProduct: ${f_detail.ArrestIndictmentProduct.length}");
        // print("f.INDICTMENT_DETAIL_ID: ${f_detail.INDICTMENT_DETAIL_ID}");
        if (f_detail.ArrestIndictmentProduct.length == 0 && tempProdNewPeople.length != 0) {
          tempProdNewPeople.forEach((temp_prod) {
            tempNewPeople.add({
              "FINE_ESTIMATE": "",
              "INDICTMENT_DETAIL_ID": f_detail.INDICTMENT_DETAIL_ID,
              "IS_ACTIVE": 1,
              "IS_ILLEGAL": 1,
              "PRODUCT_BRAND_NAME_EN": temp_prod.PRODUCT_BRAND_NAME_EN,
              "PRODUCT_BRAND_NAME_TH": temp_prod.PRODUCT_BRAND_NAME_TH,
              "PRODUCT_CATEGORY_NAME": temp_prod.PRODUCT_CATEGORY_NAME,
              "PRODUCT_GROUP_NAME": temp_prod.PRODUCT_GROUP_NAME,
              "PRODUCT_ID": temp_prod.PRODUCT_ID,
              "PRODUCT_INDICTMENT_ID": "",
              "PRODUCT_MODEL_NAME_EN": temp_prod.PRODUCT_MODEL_NAME_EN,
              "PRODUCT_MODEL_NAME_TH": temp_prod.PRODUCT_MODEL_NAME_TH,
              "PRODUCT_SUBBRAND_NAME_EN": temp_prod.PRODUCT_SUBBRAND_NAME_EN,
              "PRODUCT_SUBBRAND_NAME_TH": temp_prod.PRODUCT_SUBBRAND_NAME_TH,
              "PRODUCT_SUBSETTYPE_NAME": "",
              "PRODUCT_SUBTYPE_NAME": temp_prod.PRODUCT_SUBTYPE_NAME,
              "PRODUCT_TYPE_NAME": temp_prod.PRODUCT_TYPE_NAME,
              "QUANTITY": temp_prod.QUANTITY,
              "QUANTITY_UNIT": temp_prod.QUANTITY_UNIT,
              "QUATITY_UNIT_ID": temp_prod.QUATITY_UNIT_ID,
              "SIZES": temp_prod.SIZES,
              "SIZES_UNIT": temp_prod.SIZES_UNIT,
              "SIZES_UNIT_ID": temp_prod.SIZES_UNIT_ID,
              "VOLUMN": temp_prod.VOLUMN,
              "VOLUMN_UNIT": temp_prod.VOLUMN_UNIT,
              "VOLUMN_UNIT_ID": temp_prod.VOLUMN_UNIT_ID,
            });
          });
        }
      });
    });
    print("tempNewPeople: ${tempNewPeople.length}");
    if (tempNewPeople.length > 0) {
      await future.apiRequestArrestIndictmentProductinsAll(tempNewPeople).then((onValue) {
        if (onValue != null) {
          print("New people to indictment : " + onValue.Msg);
        }
      });
      //load data again
      Map MAP_ARREST_ID = {"ARREST_ID": _arrestMain.ARREST_ID};
      await future.apiRequestGet(MAP_ARREST_ID).then((onValue) {
        _arrestMain = onValue;

        _tempIndictmentEdit = [];
        onValue.ArrestIndictment.forEach((f) {
          _tempIndictmentEdit.add(f);
        });

        //sort staff
        _arrestMain.ArrestStaff.sort((a, b) {
          return a.STAFF_ID.compareTo(b.STAFF_ID);
        });

        _setItemProductOps();
      });

      await future.apiRequestGetEdit(MAP_ARREST_ID).then((onValue) {
        _arrestMainEdit = onValue;
      });
    }
    // ======================================================================================================================

    //get VDO
    Map map = {"DOCUMENT_TYPE": 3, "REFERENCE_CODE": _arrestMain.ARREST_ID};

    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((item) {
        if (int.parse(item.IS_ACTIVE) == 1) {
          items.add(item);
        }
      });

      List<ItemsListDocument> items_doc = [];
      print(items.length);
      items.forEach((f) {
        File _file = new File(f.DOCUMENT_OLD_NAME);
        items_doc.add(new ItemsListDocument(
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
        _controller = VideoPlayerController.file(_file)
          ..addListener(listener)
          ..setVolume(1.0)
          ..initialize()
          ..setLooping(false)
          ..play();
      });
      itemsVideoFile = items_doc;
    });

    list_delete_notice = [];
    list_delete_lawbreaker = [];
    list_delete_staff = [];
    list_delete_product = [];
    list_delete_indicment = [];
    list_delete_indicment_delt = [];
    list_delete_indicment_pro = [];
    list_add_notice = [];
    list_add_lawbreaker = [];
    list_add_staff = [];
    list_add_product = [];
    list_add_indicment = [];
    list_update_product = [];
    list_update_indicment = [];
    list_update_indicment_pro = [];
    list_add_product_for_edit = [];
    list_add_product_for_edit_product_id_null = [];

    //add & go to tab forms
    widget.IsUpdate = false;
    widget.IsCreate = false;
    widget.IsPreview = true;

    //clear list document
    itemsVideoFileDelete = [];
    itemsVideoFileAdd = [];

    _onEdited = false;
    _onSaved = true;
    _onFinish = true;
    choices.add(Choice(title: 'แบบฟอร์ม'));
    int index = 6;
    tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
    tabController.animateTo((choices.length - 1));

    _itemsDataTab8 = [];
    _itemsDataTab8.add(ItemsListArrest8("แบบฟอร์มบันทึกการจับ 2/39", "ILG60_00_03_001"));

    setState(() {});
    return true;
  }

  /*Future<bool> onLoadActionArrestIndictmentDetailupdDelete(List<Map> map) async {
    await future.apiRequestArrestIndictmentDetailupdDelete(map).then((onValue) {
      if(onValue.IsSuccess.endsWith("True")&&onValue.Msg.endsWith("Complete")){
        print("Del IndicDetail : "+onValue.Msg);
        //Navigator.pop(context);
      }
    });
    setState(() {});
    return true;
  }*/
  Location _locationService = new Location();
  @override
  void initState() {
    super.initState();

    listener = () {
      setState(() {});
    };

    // print("object: ${widget.ITEMS_ARREST.ARREST_ID}");

    //get vdo
    List<ItemsListDocument> _itemsDoc = [];
    if (widget.itemsListDocument != null) {
      widget.itemsListDocument.forEach((f) {
        File _file = new File(f.DOCUMENT_OLD_NAME);
        _itemsDoc.add(new ItemsListDocument(
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

        _controller = VideoPlayerController.file(_file)
          ..addListener(listener)
          ..setVolume(1.0)
          ..initialize()
          ..setLooping(false)
          ..play();
      });
      itemsVideoFile = _itemsDoc;
      isVideo = true;
    }
    print("done 1");
    _arrestMain = widget.ITEMS_ARREST;
    _arrestMainEdit = widget.ITEMS_ARREST_EDIT;

    /*****************************controller main tab**************************/
    tabController = TabController(length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);

    /*****************************initData for tab1**************************/
    initializeDateFormatting();
    dateFormatDate = new DateFormat.yMMMMd('th');
    dateFormatTime = new DateFormat.Hm('th');
    dateFormatDate_tab5 = new DateFormat('yMMdd');
    // Date tab 1
    String date = "";
    List splits = dateFormatDate.format(DateTime.now()).toString().split(" ");
    date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();
    editArrestDate.text = date;
    // Date tab 5
    String _tempdate_tab5 = "";
    _tempdate_tab5 = dateFormatDate_tab5.format(DateTime.now()).toString();
    arrestDate_tab5 = _tempdate_tab5;
    editArrestDateCreate.text = date;
    _time = dateFormatTime.format(DateTime.now()).toString();
    editArrestTime.text = _time;

    _currentDateArrestTH = date;
    _currentDateCreateTH = date;

    _currentDateArrestEN = DateTime.now().toString();
    _currentDateCreateEN = DateTime.now().toString();

    _arrestDate = DateTime.now().toString();
    _dtArrest = DateTime.now();
    _dtMaxDate = DateTime.now();
    _dtCreate = DateTime.now();
    _dtMinDate = DateTime.now();

    if (widget.IsPreview) {
      _onSaved = widget.IsPreview;
      _onEdited = widget.IsUpdate;
      _onFinish = widget.IsPreview;

      //sort staff
      _arrestMain.ArrestStaff.sort((a, b) {
        return a.STAFF_ID.compareTo(b.STAFF_ID);
      });

      _onSelectCountry(
        1,
        _arrestMain.ArrestLocale.first.PROVINCE_NAME_TH,
        _arrestMain.ArrestLocale.first.DISTRICT_NAME_TH,
        _arrestMain.ArrestLocale.first.SUB_DISTRICT_NAME_TH,
      );

      _setItemProductOps();

      choices.add(Choice(title: 'แบบฟอร์ม'));
      tabController = TabController(length: choices.length, vsync: this);

      _itemsDataTab8 = [];
      _itemsDataTab8.add(ItemsListArrest8("แบบฟอร์มบันทึกการจับ 2/39", "ILG60_00_03_001"));
    } else if (widget.IsCreate) {
      _itemsDataTab3.add(widget.ItemsPerson);
      editArrestNumber.text = "Auto Gen";
      // =========================== ArrestType tab 3 ===========================
      if (!(_itemsDataTab3.first.ArrestType).endsWith("ผู้จับกุม")) {
        _itemsDataTab3.first.ArrestType = "ผู้จับกุม";
      }
      // ========================================================================

      initPlatformState();
    } else if (widget.IsUpdate) {
      print("widget.IsUpdate == true !!!!");
      _arrestMain.ArrestIndictment.forEach((f) {
        _tempIndictmentEdit.add(f);
      });

      _onSelectCountry(
        1,
        _arrestMain.ArrestLocale.first.PROVINCE_NAME_TH,
        _arrestMain.ArrestLocale.first.DISTRICT_NAME_TH,
        _arrestMain.ArrestLocale.first.SUB_DISTRICT_NAME_TH,
      );

      //sort staff
      _arrestMain.ArrestStaff.sort((a, b) {
        return a.STAFF_ID.compareTo(b.STAFF_ID);
      });

      _onSaved = widget.IsPreview;
      _onEdited = widget.IsUpdate;

      _setItemProductOps();

      List<String> list = [];
      list.add(_arrestMain.BEHAVIOR_1);
      list.add(_arrestMain.BEHAVIOR_2);
      list.add(_arrestMain.BEHAVIOR_3);
      list.add(_arrestMain.BEHAVIOR_4);
      list.add(_arrestMain.BEHAVIOR_5);
      String behavior = "";
      list.forEach((string) {
        if (string != null) {
          behavior += string;
        }
      });
      String address = "";
      String _tempLocation = "";
      String police_station = "";
      _arrestMain.ArrestLocale.forEach((item) {
        address = (item.LOCATION == null ? "" : item.LOCATION + " ") +
            (item.ADDRESS_NO != null ? item.ADDRESS_NO + " " : "") +
            (item.LANE == null ? "" : "ซอย " + item.LANE + " ") +
            (item.ROAD == null ? "" : "ถนน " + item.ROAD + " ") +
            "อำเภอ/เขต " +
            (item.DISTRICT_NAME_TH + " ") +
            "ตำบล/แขวง " +
            (item.SUB_DISTRICT_NAME_TH + " ") +
            "จังหวัด " +
            item.PROVINCE_NAME_TH;
        // address = item.LOCATION;
        _tempLocation = item.LOCATION;
        police_station = item.POLICE_STATION;
      });
      print("Address ver 1");
      editArrestNumber.text = _arrestMain.ARREST_CODE;
      //editArrestNumber.text="Auto Gen";
      editArrestLocation.text = address;
      arrestLocation = _tempLocation;
      editArrestPoliceStation.text = police_station;
      editArrestPlace.text = _arrestMain.OFFICE_NAME;

      editArrestBehavior.text = behavior;
      TESTIMONY = _arrestMain.IS_REQUEST == 1 ? true : false;
      editNotificationOfRights.text = _arrestMain.IS_REQUEST == 1 ? _arrestMain.REQUEST_DESC : "ได้ดำเนินการตามที่ข้าพเจ้าร้องขอ";

      /*_arrestMain.ArrestNotice.forEach((f){
        _itemsDataTab2.add(f);
      });*/
    }
  }

  void setBehavior(text) {
    setState(() {
      String name = widget.ItemsPerson.TITLE_SHORT_NAME_TH + widget.ItemsPerson.FIRST_NAME + " " + widget.ItemsPerson.LAST_NAME;
      editArrestBehavior.text = "ข้าพเจ้า " + name + " พร้อมด้วยสายตรวจได้ทำการจับกุมในวันที่ " + _currentDateArrestTH + text;
      editNotificationOfRights.text = TESTIMONY ? "ได้ดำเนินการตามที่ข้าพเจ้าร้องขอ" : "";
    });
  }

  Map putDataRequest() {
    Map locale;
    List<Map> lawsuitBreaker = new List();
    List<Map> staff = new List();
    List<Map> product = new List();
    List<Map> productMapping = new List();

    _itemsDataTab3.forEach((f) {
      staff.add({
        "STAFF_ID": "",
        "ARREST_ID": "",
        "STAFF_REF_ID": f.STAFF_ID,
        "TITLE_ID": f.TITLE_ID,
        "STAFF_CODE": "",
        "ID_CARD": f.ID_CARD,
        "STAFF_TYPE": f.STAFF_TYPE,
        "TITLE_NAME_TH": f.TITLE_SHORT_NAME_TH,
        "TITLE_NAME_EN": "",
        "TITLE_SHORT_NAME_TH": f.TITLE_SHORT_NAME_TH,
        "FIRST_NAME": f.FIRST_NAME,
        "LAST_NAME": f.LAST_NAME,
        "AGE": "",
        "OPERATION_DEPT_CODE": f.OPERATION_DEPT_CODE != null ? f.OPERATION_DEPT_CODE : "",
        "OPERATION_DEPT_LEVEL": f.OPERATION_DEPT_LEVEL != null ? f.OPERATION_DEPT_LEVEL : "",
        "OPERATION_DEPT_NAME": f.OPERATION_DEPT_NAME != null ? f.OPERATION_DEPT_NAME : "",
        "OPERATION_OFFICE_CODE": f.OPERATION_OFFICE_CODE != null ? f.OPERATION_OFFICE_CODE : "",
        "OPERATION_OFFICE_NAME": f.OPERATION_OFFICE_NAME != null ? f.OPERATION_OFFICE_NAME : "",
        "OPERATION_OFFICE_SHORT_NAME": f.OPERATION_OFFICE_SHORT_NAME != null ? f.OPERATION_OFFICE_SHORT_NAME : "",
        "OPERATION_POS_CODE": f.OPERATION_POS_CODE != null ? f.OPERATION_POS_CODE : "",
        "OPERATION_POS_LEVEL_NAME": f.OPREATION_POS_LAVEL_NAME != null ? f.OPREATION_POS_LAVEL_NAME : "",
        "OPERATION_UNDER_DEPT_CODE": f.OPERATION_UNDER_DEPT_CODE != null ? f.OPERATION_UNDER_DEPT_CODE : "",
        "OPERATION_UNDER_DEPT_LEVEL": f.OPERATION_UNDER_DEPT_LEVEL != null ? f.OPERATION_UNDER_DEPT_LEVEL : "",
        "OPERATION_UNDER_DEPT_NAME": f.OPERATION_UNDER_DEPT_NAME != null ? f.OPERATION_UNDER_DEPT_NAME : "",
        "OPERATION_WORK_DEPT_CODE": f.OPERATION_WORK_DEPT_CODE != null ? f.OPERATION_WORK_DEPT_CODE : "",
        "OPERATION_WORK_DEPT_LEVEL": f.OPERATION_WORK_DEPT_LEVEL != null ? f.OPERATION_WORK_DEPT_LEVEL : "",
        "OPERATION_WORK_DEPT_NAME": f.OPERATION_WORK_DEPT_NAME != null ? f.OPERATION_WORK_DEPT_NAME : "",
        "OPREATION_POS_LEVEL": f.OPREATION_POS_LEVEL != null ? f.OPREATION_POS_LEVEL : "",
        "OPREATION_POS_NAME": f.OPREATION_POS_NAME != null ? f.OPREATION_POS_NAME : "",
        "MANAGEMENT_POS_CODE": "",
        "MANAGEMENT_POS_NAME": f.MANAGEMENT_POS_NAME != null ? f.MANAGEMENT_POS_NAME : "",
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
        "STATUS": 1,
        "REMARK": "",
        "CONTRIBUTOR_ID": f.ArrestType == "ผู้จับกุม" ? 14 : (f.ArrestType == "ผู้สั่งการ" ? 10 : 15),
        "IS_ACTIVE": 1
      });
    });

    //ที่อยู่
    locale = {
      "LOCALE_ID": "",
      "ARREST_ID": "",
      "SUB_DISTRICT_ID": _itemsLocale.SUB_DISTICT.SUB_DISTRICT_ID,
      "GPS": _itemsLocale.GPS,
      "ADDRESS_NO": _itemsLocale.ADDRESS_NO != null ? _itemsLocale.ADDRESS_NO : "",
      "VILLAGE_NO": "",
      "BUILDING_NAME": "",
      "ROOM_NO": "",
      "ALLEY": "",
      "FLOOR": "",
      "VILLAGE_NAME": "",
      "LANE": _itemsLocale.LANE != null ? _itemsLocale.LANE : "",
      "ROAD": _itemsLocale.ROAD != null ? _itemsLocale.ROAD : "",
      "ADDRESS_TYPE": 4,
      "ADDRESS_STATUS": 0,
      "POLICE_STATION": editArrestPoliceStation.text == null ? "" : editArrestPoliceStation.text,
      // "LOCATION": editArrestLocation.text,
      "LOCATION": arrestLocation,
      "IS_ACTIVE": 1
    };

    //ผู้ต้องหา
    _itemsDataTab4.forEach((item) {
      lawsuitBreaker.add({
        "LAWBREAKER_ID": "",
        "ARREST_ID": "",
        "PERSON_ID": item.PERSON_ID,
        "TITLE_ID": item.TITLE_ID,
        "PERSON_TYPE": item.PERSON_TYPE,
        "ENTITY_TYPE": item.ENTITY_TYPE,
        "TITLE_NAME_TH": item.TITLE_NAME_TH,
        "TITLE_NAME_EN": item.TITLE_NAME_EN,
        "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
        "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
        "FIRST_NAME": item.FIRST_NAME,
        "MIDDLE_NAME": item.MIDDLE_NAME,
        "LAST_NAME": item.LAST_NAME,
        "OTHER_NAME": item.OTHER_NAME,
        "COMPANY_NAME": item.COMPANY_NAME,
        "COMPANY_REGISTRATION_NO": "",
        "EXCISE_REGISTRATION_NO": "",
        "ID_CARD": item.ID_CARD,
        "AGE": item.AGE,
        "PASSPORT_NO": item.PASSPORT_NO,
        "CAREER": "",
        "PERSON_DESC": "",
        "EMAIL": "",
        "TEL_NO": "",
        "MISTREAT_NO": item.MISTREAT_NO,
        "IS_ACTIVE": 1
      });
    });
    //ของกลาง
    _itemsDataTab5.forEach((item) {
      /*productMapping.add(
          {
            "PRODUCT_ID": "",
            "ARREST_ID": "",
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
            "PRODUCT_GROUP_CODE": "",
            "PRODUCT_GROUP_NAME": item.PRODUCT_GROUP_NAME!=null?item.PRODUCT_GROUP_NAME:"",
            "PRODUCT_CATEGORY_CODE": "",
            "PRODUCT_CATEGORY_NAME": item.PRODUCT_CATEGORY_NAME!=null?item.PRODUCT_CATEGORY_NAME:"",
            "PRODUCT_TYPE_CODE": "",
            "PRODUCT_TYPE_NAME": item.PRODUCT_TYPE_NAME!=null?item.PRODUCT_TYPE_NAME:"",
            "PRODUCT_SUBTYPE_CODE": "",
            "PRODUCT_SUBTYPE_NAME": item.PRODUCT_SUBTYPE_NAME!=null?item.PRODUCT_SUBTYPE_NAME:"",
            "PRODUCT_SUBSETTYPE_CODE": "",
            "PRODUCT_SUBSETTYPE_NAME": item.PRODUCT_SUBSETTYPE_NAME!=null?item.PRODUCT_SUBSETTYPE_NAME:"",
            "PRODUCT_BRAND_CODE": "",
            "PRODUCT_BRAND_NAME_TH": item.PRODUCT_BRAND_NAME_TH!=null?item.PRODUCT_BRAND_NAME_TH:"",
            "PRODUCT_BRAND_NAME_EN": item.PRODUCT_BRAND_NAME_EN!=null?item.PRODUCT_BRAND_NAME_EN:"",
            "PRODUCT_SUBBRAND_CODE": "",
            "PRODUCT_SUBBRAND_NAME_TH": item.PRODUCT_SUBBRAND_NAME_TH!=null?item.PRODUCT_SUBBRAND_NAME_TH:"",
            "PRODUCT_SUBBRAND_NAME_EN": item.PRODUCT_SUBBRAND_NAME_EN!=null?item.PRODUCT_SUBBRAND_NAME_EN:"",
            "PRODUCT_MODEL_CODE": "",
            "PRODUCT_MODEL_NAME_TH": item.PRODUCT_MODEL_NAME_TH!=null?item.PRODUCT_MODEL_NAME_TH:"",
            "PRODUCT_MODEL_NAME_EN": item.PRODUCT_MODEL_NAME_EN!=null?item.PRODUCT_MODEL_NAME_EN:"",
            "IS_TAX_VALUE": 1,
            "TAX_VALUE": "",
            "IS_TAX_VOLUMN": 1,
            "TAX_VOLUMN": "",
            "TAX_VOLUMN_UNIT": "",
            "LICENSE_PLATE": "",
            "ENGINE_NO": "",
            "CHASSIS_NO": "",
            "PRODUCT_DESC": (item.PRODUCT_GROUP_NAME != null
                ? (item.PRODUCT_GROUP_NAME
                .toString() + ' ')
                : '') +
                (item.PRODUCT_CATEGORY_NAME != null
                    ? (item.PRODUCT_CATEGORY_NAME
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_TYPE_NAME != null
                    ? (item.PRODUCT_TYPE_NAME
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_BRAND_NAME_TH != null
                    ? (item.PRODUCT_BRAND_NAME_TH
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_BRAND_NAME_EN != null
                    ? (item.PRODUCT_BRAND_NAME_EN
                    .toString() + ' ')
                    : '') +

                (item.PRODUCT_SUBBRAND_NAME_TH != null
                    ? (item.PRODUCT_SUBBRAND_NAME_TH
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_SUBBRAND_NAME_EN != null
                    ? (item.PRODUCT_SUBBRAND_NAME_EN
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_MODEL_NAME_TH != null
                    ? (item.PRODUCT_MODEL_NAME_TH
                    .toString() + ' ')
                    : '') +
                (item.PRODUCT_MODEL_NAME_EN != null
                    ? (item.PRODUCT_MODEL_NAME_EN
                    .toString() + ' ')
                    : '')
                */ /*item.PRODUCT_DESC*/ /*,
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
            "REMARK": "",
            "IS_DOMESTIC": item.IS_DOMESTIC,
            "IS_ILLEGAL": 1,
            "IS_ACTIVE": 1,
          }
      );*/
    });

    //ของกลาง
    _itemsDataTab5.forEach((item) {
      product.add({
        "PRODUCT_ID": "",
        "ARREST_ID": "",
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
        "PRODUCT_GROUP_CODE": "",
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
        "QUANTITY": item.QUANTITY,
        "QUANTITY_UNIT": item.QUANTITY_UNIT,
        "VOLUMN": item.VOLUMN,
        "VOLUMN_UNIT": item.VOLUMN_UNIT,
        "REMARK": item.REMARK,
        "IS_DOMESTIC": item.IS_DOMESTIC,
        "IS_ILLEGAL": 1,
        "IS_ACTIVE": 1,
        "ArrestProductMapping": productMapping
      });
    });

    //print(product.toString());
    //editArrestBehavior.text = product.toString();

    Map map_arrest = {
      "ARREST_ID": "",
      "OFFICE_ID": 13,
      "ARREST_CODE": /*widget.ARREST_CODE*/ transection_no,
      "OFFICE_CODE": _itemsLocale.SUB_DISTICT.OFFICE_CODE,
      "OFFICE_NAME": editArrestPlace.text,
      "ARREST_DATE": _arrestDate,
      "OCCURRENCE_DATE": _dtCreate.toString(),
      "BEHAVIOR_1": editArrestBehavior.text,
      "BEHAVIOR_2": "",
      "BEHAVIOR_3": "",
      "BEHAVIOR_4": "",
      "BEHAVIOR_5": "",
      "TESTIMONY": "",
      "IS_REQUEST": TESTIMONY ? 1 : 0,
      "REQUEST_DESC": TESTIMONY ? editNotificationOfRights.text : "",
      "IS_LAWSUIT_COMPLETE": 0,
      "IS_ACTIVE": 1,
      "CREATE_DATE": DateTime.now().toString(),
      "CREATE_USER_ACCOUNT_ID": 13,
      "UPDATE_DATE": "",
      "UPDATE_USER_ACCOUNT_ID": 0,
      "ArrestStaff": staff,
      "ArrestLocale": [locale],
      "ArrestLawbreaker": lawsuitBreaker,
      "ArrestProduct": product
    };

    /*print("staff "+staff.toString());
    print("locale "+locale.toString());
    print("lawsuitBreaker "+lawsuitBreaker.toString());
    print("product "+product.toString());
    print("map_arrest "+map_arrest.toString());*/

    return map_arrest;
  }

  /*****************************view tab1**************************/
  //node focus
  final FocusNode myFocusNodeArrestNumber = FocusNode();
  final FocusNode myFocusNodeArrestDate = FocusNode();
  final FocusNode myFocusNodeArrestTime = FocusNode();
  final FocusNode myFocusNodeArrestLocation = FocusNode();
  final FocusNode myFocusNodeArrestDateCreate = FocusNode();
  final FocusNode myFocusNodeArrestPlace = FocusNode();
  final FocusNode myFocusNodeArrestPoliceStation = FocusNode();

  //textfield
  TextEditingController editArrestNumber = new TextEditingController();
  TextEditingController editArrestDate = new TextEditingController();
  TextEditingController editArrestTime = new TextEditingController();
  TextEditingController editArrestLocation = new TextEditingController();
  TextEditingController editArrestDateCreate = new TextEditingController();
  TextEditingController editArrestPlace = new TextEditingController();
  TextEditingController editArrestPoliceStation = new TextEditingController();

  //date
  var dateFormatDate, dateFormatTime, dateFormatDate_tab5;
  DateTime _currentDate = DateTime(2019, 2, 3);
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = '';
  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;
  String arrestDate_tab5 = "";

  //location
  Locations.LocationData _startLocation;
  Locations.LocationData _currentLocation;
  StreamSubscription<Locations.LocationData> _locationSubscription;
  Locations.Location _location = new Locations.Location();
  bool _permission = false;
  String error;
  String placeAddress = "";

  //time
  DateTime time = DateTime.now();
  String _time;
  String arrestLocation = "";

  // ========================== tab_3 ==========================
  bool canDelete_arrestType = false;
  // ===========================================================

  /**************************list model*******************************/
  List _itemsDataTab2 = [];
  //List<ItemsPersonInformation> _itemsDataTab3 = [];
  List _itemsDataTab3 = [];
  List _itemsDataTab4 = [];
  List _itemsDataTab5 = [];
  List _itemsDataTab5Ops = [];
  List _itemsDataTab5OpsSaved = [];
  List<ItemsListArrest7> _itemsDataTab7 = [];
  List<ItemsListArrest8> _itemsDataTab8 = [];

  /**********************Droupdown View *****************************/

  /************************view tab 6*******************************/
  bool IsSelected_tab6 = false;
  final FocusNode myFocusNodeSearchTab6 = FocusNode();
  List _itemsInitTab6 = [];
  List _tempIndictmentEdit = [];
  int _tempOldGuiltBaseID = 0;

  List _tempLawbreakerIndictDetID = [];

  /*****************************view tab 7**************************/
  final FocusNode myFocusNodeArrestBehavior = FocusNode();
  final FocusNode myFocusNodeNotificationOfRights = FocusNode();

  TextEditingController editArrestBehavior = new TextEditingController();
  TextEditingController editNotificationOfRights = new TextEditingController();

  String _tempTextLawsuitBreaker = "";
  String _tempEvidence = "พร้อมได้ยึดของกลาง ดังนี้ ";
  String _tempEvidenceItem = "";
  String _tempSection = "";

  @override
  void dispose() {
    super.dispose();
    /*****************************dispose focus tab 1**************************/
    tabController.dispose();

    myFocusNodeArrestNumber.dispose();
    myFocusNodeArrestDate.dispose();
    myFocusNodeArrestTime.dispose();
    myFocusNodeArrestLocation.dispose();
    myFocusNodeArrestDateCreate.dispose();
    myFocusNodeArrestPlace.dispose();
    editArrestDate.dispose();
    myFocusNodeArrestPoliceStation.dispose();
    /*****************************dispose focus tab 6**************************/
    myFocusNodeSearchTab6.dispose();
    /*****************************dispose focus tab 7**************************/
    myFocusNodeArrestBehavior.dispose();
    myFocusNodeNotificationOfRights.dispose();

    if (_controller != null) {
      _controller.dispose();
    }
  }

  /*****************************method for main tab**************************/
  void whenAnimationTab() async {
    int init_index = tabController.index;
    final pos = tabController.length - 1;
    setState(() {
      choices.removeAt(pos);
      // tabController.animateTo(0);
      // tabController = TabController(initialIndex: 0, length: choices.length, vsync: this);
      // _tabPageSelector = new TabPageSelector(controller: tabController);
      print("init_index: ${init_index}");
      if (init_index == 7) {
        tabController.animateTo(0);
        int index = tabController.index;
        tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
        _tabPageSelector = new TabPageSelector(controller: tabController);
      } else {
        int index = tabController.index;
        tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
        _tabPageSelector = new TabPageSelector(controller: tabController);
      }
    });
  }

  void choiceAction(Constants constants) async {
    setState(() {
      if (constants.text.endsWith("แก้ไข")) {
        _currentIndex = 0;
        _onEdited = true;
        _onSaved = false;
        _onFinish = false;
        widget.IsPreview = false;
        widget.IsCreate = false;
        widget.IsCreate = false;
        widget.IsUpdate = true;

        whenAnimationTab();

        List<String> list = [];
        list.add(_arrestMain.BEHAVIOR_1);
        list.add(_arrestMain.BEHAVIOR_2);
        list.add(_arrestMain.BEHAVIOR_3);
        list.add(_arrestMain.BEHAVIOR_4);
        list.add(_arrestMain.BEHAVIOR_5);
        String behavior = "";
        list.forEach((string) {
          if (string != null) {
            behavior += string;
          }
        });
        String address = "";
        String _tempLocation = "";
        String police_station = "";
        _arrestMain.ArrestLocale.forEach((item) {
          address = (item.LOCATION == null ? "" : item.LOCATION + " ") +
              (item.ADDRESS_NO != null ? item.ADDRESS_NO + " " : "") +
              (item.LANE == null ? "" : "ซอย " + item.LANE + " ") +
              (item.ROAD == null ? "" : "ถนน " + item.ROAD + " ") +
              "อำเภอ/เขต " +
              (item.DISTRICT_NAME_TH + " ") +
              "ตำบล/แขวง " +
              (item.SUB_DISTRICT_NAME_TH + " ") +
              "จังหวัด " +
              item.PROVINCE_NAME_TH;
          // address = item.LOCATION;
          _tempLocation = item.LOCATION;
          police_station = item.POLICE_STATION != null ? item.POLICE_STATION : "";
        });
        print("Address ver 2");
        editArrestNumber.text = _arrestMain.ARREST_CODE;
        editArrestLocation.text = address;
        arrestLocation = _tempLocation;
        editArrestPoliceStation.text = police_station;
        editArrestPlace.text = _arrestMain.OFFICE_NAME;

        editArrestBehavior.text = behavior;
        TESTIMONY = _arrestMain.IS_REQUEST == 1 ? true : false;
        editNotificationOfRights.text = _arrestMain.IS_REQUEST == 1 ? _arrestMain.REQUEST_DESC : "ได้ดำเนินการตามที่ข้าพเจ้าร้องขอ";

        _arrestMain.ArrestIndictment.forEach((f) {
          _tempIndictmentEdit.add(f);
        });
      } else {
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
                Navigator.pop(context);
                setState(() {
                  onDelete();
                });
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

  CupertinoAlertDialog _createCupertinoDeleteItemsDialog(index, String type, int itemPersonID) {
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
                  print("type del : " + type);
                  if (type.endsWith("Staff")) {
                    //_itemsDataTab3.removeAt(index);

                    if (_onEdited) {
                      if (_arrestMain.ArrestStaff[index].STAFF_ID != null) {
                        print("case :: A");
                        list_delete_staff.add(_arrestMain.ArrestStaff[index].STAFF_ID);
                      } else {
                        print("case :: B");
                        list_add_staff.removeAt((index - (_arrestMain.ArrestStaff.length - list_add_staff.length)));
                      }
                      _arrestMain.ArrestStaff.removeAt(index);
                    } else {
                      _itemsDataTab3.removeAt(index);
                    }
                  } else if (type.endsWith("Person")) {
                    _itemsInitTab6.forEach((head) {
                      for (int i = 0; i < head.ArrestIndictmentDetail.length; i++) {
                        print(head.ArrestIndictmentDetail[i].PERSON_ID);
                        if (head.ArrestIndictmentDetail[i].PERSON_ID == _itemsDataTab4[index].PERSON_ID) {
                          head.ArrestIndictmentDetail.removeAt(i);
                        }
                      }
                    });
                    // =========================================== Delete Mas Person ======================================
                    if (itemPersonID != null) {
                      onDeleteMasPerson(itemPersonID);
                    }
                    _itemsDataTab4.removeAt(index);
                    // ====================================================================================================
                    // =========================================== SET BEHAVIOR ===========================================
                    String textLawsuitBreaker = "";
                    // _itemsDataTab4 = ชื่อผู้ต้องหา
                    // name suspect
                    textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " + _itemsDataTab4.length.toString() + " คน " + (_itemsDataTab4.length == 0 ? "" : "คือ ");
                    _itemsDataTab4.forEach((item) {
                      textLawsuitBreaker += item.PERSON_TYPE == 2
                          ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.COMPANY_NAME
                          : item.PERSON_TYPE == 0
                              ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.FIRST_NAME + " " + item.LAST_NAME + " "
                              : (item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN : item.TITLE_NAME_EN) + item.FIRST_NAME + " " + item.LAST_NAME + " ";
                    });
                    _tempTextLawsuitBreaker = textLawsuitBreaker;
                    setBehavior(textLawsuitBreaker + (_tempEvidenceItem == "" ? "" : (_tempEvidence + _tempEvidenceItem)) + (_itemsInitTab6.length == 0 ? "" : _tempSection));
                    // ====================================================================================================
                  } else if (type.endsWith("Product")) {
                    _itemsInitTab6.forEach((item) {
                      for (int i = 0; i < item.ArrestIndictmentProduct.length; i++) {
                        if (item.ArrestIndictmentProduct[i].PRODUCT_MAPPING_ID == _itemsDataTab5[index].PRODUCT_MAPPING_ID) {
                          item.ArrestIndictmentProduct.removeAt(i);
                        }
                      }
                    });
                    _itemsDataTab5.removeAt(index);
                    _itemsDataTab5Ops.removeAt(index);

                    // =========================================== SET BEHAVIOR ===========================================
                    String EvidenceItem = "";
                    String Section = "";
                    // _itemsInitTab6 = ข้อกล่าวหา

                    //จำนวนและรายการของกลาง
                    int index_pro = 0;
                    _itemsDataTab5.forEach((f) {
                      index_pro++;
                      EvidenceItem += f.PRODUCT_DESC.toString() + (index_pro != _itemsDataTab5.length ? ", " : " ");
                    });
                    _tempEvidenceItem = EvidenceItem;
                    //ข้อกล่าวหา
                    Section = "ในข้อกล่าวหา ";
                    int index_sec = 0;
                    _itemsInitTab6.forEach((item) {
                      index_sec++;
                      Section += (item.ArrestIndictmentDetail.length > 1 ? "ร่วมกัน" : "") + item.GUILTBASE_NAME + (index_sec != _itemsInitTab6.length ? ", " : " ");
                    });
                    _tempSection = Section;
                    //ใส่ข้อมูลลง text
                    setBehavior(_tempTextLawsuitBreaker + (_tempEvidenceItem == "" ? "" : (_tempEvidence + _tempEvidenceItem)) + (_itemsInitTab6.length == 0 ? "" : _tempSection));
                    // ====================================================================================================
                  } else if (type.endsWith("Indicment")) {
                    _itemsInitTab6.removeAt(index);
                    // =========================================== SET BEHAVIOR ===========================================
                    String Section = "";
                    // _itemsInitTab6 = ข้อกล่าวหา
                    //ข้อกล่าวหา
                    Section = "ในข้อกล่าวหา ";
                    int index_sec = 0;
                    _itemsInitTab6.forEach((item) {
                      index_sec++;
                      Section += (item.ArrestIndictmentDetail.length > 1 ? "ร่วมกัน" : "") + item.GUILTBASE_NAME + (index_sec != _itemsInitTab6.length ? ", " : " ");
                    });
                    _tempSection = Section;
                    setBehavior(_tempTextLawsuitBreaker + (_tempEvidenceItem == "" ? "" : (_tempEvidence + _tempEvidenceItem)) + (_itemsInitTab6.length == 0 ? "" : Section));
                    // ====================================================================================================
                  } else if (type.endsWith("PersonUp")) {
                    /*_arrestMain.ArrestIndictment.forEach((head) {
                      for(int i=0;i<head.ArrestIndictmentDetail.length;i++){
                        print(head.ArrestIndictmentDetail[i].LAWBREAKER_ID);
                        if(head.ArrestIndictmentDetail[i].LAWBREAKER_ID == _arrestMain.ArrestLawbreaker[index].LAWBREAKER_ID){
                          head.ArrestIndictmentDetail.removeAt(i);
                        }
                      }
                    });
                    list_delete_lawbreaker.add(
                        _arrestMain.ArrestLawbreaker[index].LAWBREAKER_ID);
                    _arrestMain.ArrestLawbreaker.removeAt(index);*/

                    if (_onEdited) {
                      if (_arrestMain.ArrestLawbreaker[index].LAWBREAKER_ID != null) {
                        print("case :: A");
                        list_delete_lawbreaker.add(_arrestMain.ArrestLawbreaker[index].LAWBREAKER_ID);
                        _arrestMain.ArrestIndictment.forEach((head) {
                          for (int i = 0; i < head.ArrestIndictmentDetail.length; i++) {
                            // print(head.ArrestIndictmentDetail[i].LAWBREAKER_ID);
                            if (head.ArrestIndictmentDetail[i].LAWBREAKER_ID == _arrestMain.ArrestLawbreaker[index].LAWBREAKER_ID) {
                              head.ArrestIndictmentDetail.removeAt(i);
                            }
                          }
                        });
                      } else {
                        print("case :: B");
                        list_add_lawbreaker.removeAt((index - (_arrestMain.ArrestLawbreaker.length - list_add_lawbreaker.length)));
                      }
                      if (itemPersonID != null) {
                        onDeleteMasPerson(itemPersonID);
                      }

                      for (var i = 0; i < _arrestMainEdit.ArrestLawbreaker.length; i++) {
                        if (_arrestMain.ArrestLawbreaker[index].PERSON_ID == _arrestMainEdit.ArrestLawbreaker[i].PERSON_ID) {
                          _arrestMainEdit.ArrestLawbreaker.removeAt(i);
                        }
                      }

                      _arrestMain.ArrestLawbreaker.removeAt(index);

                      List tempIDDel = [];
                      for (var i = 0; i < _arrestMain.ArrestIndictment.length; i++) {
                        // print("i: ${i}, length: ${_arrestMain.ArrestIndictment[i].ArrestIndictmentDetail.length}");
                        if (_arrestMain.ArrestIndictment[i].ArrestIndictmentDetail.length == 0) {
                          tempIDDel.add(_arrestMain.ArrestIndictment[i].INDICTMENT_ID);
                          // _arrestMain.ArrestIndictment.removeAt(i);
                        }
                      }
                      // print("tempIDDel: ${tempIDDel.toString()}");
                      if (tempIDDel.length > 0) {
                        tempIDDel.forEach((f) {
                          _arrestMain.ArrestIndictment.removeWhere((item) => item.INDICTMENT_ID == f);
                          list_delete_indicment.add(f);

                          _arrestMainEdit.ArrestIndictment.removeWhere((item) => item.INDICTMENT_ID == f);
                        });
                      }
                    } else {
                      if (itemPersonID != null) {
                        onDeleteMasPerson(itemPersonID);
                      }
                      _itemsDataTab4.removeAt(index);
                    }
                  } else if (type.endsWith("StaffUp")) {
                    list_delete_staff.add(_arrestMain.ArrestStaff[index].STAFF_ID);
                    _arrestMain.ArrestStaff.removeAt(index);
                  } else if (type.endsWith("ProductUp")) {
                    /*_arrestMain.ArrestIndictment.forEach((item){
                      for(int i=0;i<item.ArrestIndictmentProduct.length;i++){
                        if(item.ArrestIndictmentProduct[i].PRODUCT_ID == _arrestMain.ArrestProduct[index].PRODUCT_ID){
                          item.ArrestIndictmentProduct.removeAt(i);
                        }
                      }
                    });
                    list_delete_product.add(_arrestMain.ArrestProduct[index].PRODUCT_ID);
                    _arrestMain.ArrestProduct.removeAt(index);
                    _itemsDataTab5OpsSaved.removeAt(index);*/

                    if (_onEdited) {
                      if (_arrestMain.ArrestProduct[index].PRODUCT_ID != null) {
                        print("case :: A");
                        list_delete_product.add(_arrestMain.ArrestProduct[index].PRODUCT_ID);
                        _arrestMain.ArrestIndictment.forEach((item) {
                          for (int i = 0; i < item.ArrestIndictmentProduct.length; i++) {
                            if (item.ArrestIndictmentProduct[i].PRODUCT_ID != null) {
                              if (item.ArrestIndictmentProduct[i].PRODUCT_ID == _arrestMain.ArrestProduct[index].PRODUCT_ID) {
                                item.ArrestIndictmentProduct.removeAt(i);
                              }
                            }
                          }
                        });

                        for (var i = 0; i < _arrestMain.ArrestIndictment.length; i++) {
                          list_update_indicment.removeWhere((item) => item.INDICTMENT_ID == _arrestMain.ArrestIndictment[i].INDICTMENT_ID);
                          // print("length0: ${list_update_indicment.length}");
                          list_update_indicment.add(_arrestMain.ArrestIndictment[i]);
                          // print("length1: ${list_update_indicment.length}");
                        }
                      } else {
                        print("case :: B");
                        // if (list_update_indicment.length > 0) {
                        _arrestMain.ArrestIndictment.forEach((item) {
                          for (int i = 0; i < item.ArrestIndictmentProduct.length; i++) {
                            if (item.ArrestIndictmentProduct[i].PRODUCT_REF_CODE != null && _arrestMain.ArrestProduct[index].PRODUCT_REF_CODE != null) {
                              // print("object2: ${_arrestMain.ArrestProduct[index].PRODUCT_REF_CODE}");
                              // print("object: ${item.ArrestIndictmentProduct[i].PRODUCT_REF_CODE}");
                              if (item.ArrestIndictmentProduct[i].PRODUCT_REF_CODE == _arrestMain.ArrestProduct[index].PRODUCT_REF_CODE) {
                                item.ArrestIndictmentProduct.removeAt(i);
                              }
                            }
                          }
                        });

                        for (var i = 0; i < _arrestMain.ArrestIndictment.length; i++) {
                          list_update_indicment.removeWhere((item) => item.INDICTMENT_ID == _arrestMain.ArrestIndictment[i].INDICTMENT_ID);
                          // print("length0: ${list_update_indicment.length}");
                          list_update_indicment.add(_arrestMain.ArrestIndictment[i]);
                          // print("length1: ${list_update_indicment.length}");
                        }
                        // }

                        list_add_product.removeWhere((item) => item.PRODUCT_REF_CODE == _arrestMain.ArrestProduct[index].PRODUCT_REF_CODE);
                        // list_add_product.removeAt((index - (_arrestMain.ArrestProduct.length - list_add_product.length)));
                      }

                      // print("i: ${index}, length1: ${_arrestMain.ArrestProduct.length}");
                      _arrestMain.ArrestProduct.removeAt(index);
                      // print("length1: ${_arrestMain.ArrestProduct.length}");
                      _itemsDataTab5OpsSaved = [];
                      _arrestMain.ArrestProduct.forEach((f) {
                        _itemsDataTab5OpsSaved.add(f);
                      });

                      List tempIDDel = [];
                      for (var i = 0; i < _arrestMain.ArrestIndictment.length; i++) {
                        // print("i: ${i}, length: ${_arrestMain.ArrestIndictment[i].ArrestIndictmentDetail.length}");
                        if (_arrestMain.ArrestIndictment[i].ArrestIndictmentProduct.length == 0) {
                          tempIDDel.add(_arrestMain.ArrestIndictment[i].INDICTMENT_ID);
                          // _arrestMain.ArrestIndictment.removeAt(i);
                        }
                      }

                      if (tempIDDel.length > 0) {
                        tempIDDel.forEach((f) {
                          _arrestMain.ArrestIndictment.removeWhere((item) => item.INDICTMENT_ID == f);
                          list_delete_indicment.add(f);

                          _arrestMainEdit.ArrestIndictment.removeWhere((item) => item.INDICTMENT_ID == f);
                        });
                      }
                    } else {
                      _itemsDataTab5.removeAt(index);
                    }
                  } else if (type.endsWith("IndicmentUp")) {
                    /*list_delete_indicment.add(_arrestMain.ArrestIndictment[index].INDICTMENT_ID);
                    _arrestMain.ArrestIndictment.removeAt(index);*/
                    if (_onEdited) {
                      if (_arrestMain.ArrestIndictment[index].INDICTMENT_ID != null) {
                        print("case :: A");
                        list_delete_indicment.add(_arrestMain.ArrestIndictment[index].INDICTMENT_ID);
                      } else {
                        print("case :: B");
                        list_add_indicment.removeAt((index - (_arrestMain.ArrestIndictment.length - list_add_indicment.length)));
                      }
                      _arrestMain.ArrestIndictment.removeAt(index);
                    } else {
                      _itemsDataTab2.removeAt(index);
                    }
                  } else if (type.endsWith("Notice")) {
                    if (_onEdited) {
                      if (_arrestMain.ArrestNotice[index].NOTICE_ID != null) {
                        print("case :: A");
                        list_delete_notice.add(_arrestMain.ArrestNotice[index].NOTICE_ID);
                      } else {
                        print("case :: B");
                        list_add_notice.removeAt((index - (_arrestMain.ArrestNotice.length - list_add_notice.length)));
                      }
                      _arrestMain.ArrestNotice.removeAt(index);
                    } else {
                      _itemsDataTab2.removeAt(index);
                    }
                  } else if (type.endsWith("NoticeUp")) {
                    list_delete_notice.add(_arrestMain.ArrestNotice[index].NOTICE_ID);
                  }
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showDeleteItemsAlertDialog(index, String type, int itemPersonID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDeleteItemsDialog(index, type, itemPersonID);
      },
    );
  }

  /*****************************method for main tab1**************************/
  void clearTextField() {
    editArrestNumber.clear();
    editArrestDate.clear();
    editArrestTime.clear();
    editArrestLocation.clear();
    editArrestDateCreate.clear();
    editArrestPlace.clear();
  }

  String _placeName = "", _addressno = "", _province = "", _distict = "", _sub_distinct = "", _lane = "", _gps = "", _road = "";
  ItemsMasterProvinceResponse ItemProvince;
  ItemsMasterDistictResponse ItemDistrict;
  ItemsMasterSubDistictResponse ItemSubDistrict;

  ItemsListSubDistict sSubDistrict;
  ItemsListDistict sDistrict;
  ItemsListProvince sProvince;

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

    /*print("featureName " + place.featureName.toString());
    print("adminArea " + place.adminArea);
    print("subLocality " + place.subLocality.toString());
    print("locality " + place.locality.toString());
    print("subAdminArea " + place.subAdminArea.toString());
    print("coordinates " + place.coordinates.toString());
    print("thoroughfare " + place.thoroughfare.toString());
    print("subThoroughfare " + place.subThoroughfare.toString());
    print("postalCode " + place.postalCode.toString());
    print("addressLine "+place.addressLine.toString());
    print("countryCode "+place.countryCode.toString());
    print("countryName "+place.countryName.toString());*/

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

    _onSelectCountry(1, _province, _distict, _sub_distinct);

    setState(() {});
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

    setState(() {
      _startLocation = location;
      getPlaceAddress(location.latitude, location.longitude);
    });
  }

  Future<DateTime> _selectDate(context) async {
    return await showDatePicker(
      context: context,
      locale: Locale('th', 'TH'),
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    );
  }

  _navigateMap(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest1MapCustom(
                itemsLocale: _itemsLocale,
                IsPageArrest: true,
              )),
    );
    if (result.toString() != "Back") {
      if (_onEdited) {
        list_update_location = result;
        String address = (list_update_location.Other != null ? list_update_location.Other + " " : "") +
            (list_update_location.ADDRESS_NO != null ? list_update_location.ADDRESS_NO + " " : "") +
            (list_update_location.LANE.isEmpty ? "" : "ซอย " + list_update_location.LANE + " ") +
            (list_update_location.ROAD.isEmpty ? "" : "ถนน " + list_update_location.ROAD + " ") +
            "ตำบล/แขวง " +
            (list_update_location.SUB_DISTICT.SUB_DISTRICT_NAME_TH + " ") +
            "อำเภอ/เขต " +
            (list_update_location.DISTICT.DISTRICT_NAME_TH + " ") +
            "จังหวัด " +
            list_update_location.PROVINCE.PROVINCE_NAME_TH;
        editArrestLocation.text = address.trim();
        arrestLocation = list_update_location.Other;
        print("Address ver 3");
        if (list_update_location.IsPlace) {
          editArrestPlace.text = address.trim();
        }

        setState(() {
          _itemsLocale = list_update_location;
        });
      } else {
        setState(() {
          _itemsLocale = result;
        });
        String address = (_itemsLocale.Other != null ? _itemsLocale.Other + " " : "") +
            (_itemsLocale.ADDRESS_NO != null ? _itemsLocale.ADDRESS_NO + " " : "") +
            (_itemsLocale.LANE.isEmpty ? "" : "ซอย " + _itemsLocale.LANE + " ") +
            (_itemsLocale.ROAD.isEmpty ? "" : "ถนน " + _itemsLocale.ROAD + " ") +
            "ตำบล/แขวง " +
            (_itemsLocale.SUB_DISTICT.SUB_DISTRICT_NAME_TH + " ") +
            "อำเภอ/เขต " +
            (_itemsLocale.DISTICT.DISTRICT_NAME_TH + " ") +
            "จังหวัด " +
            _itemsLocale.PROVINCE.PROVINCE_NAME_TH;
        editArrestLocation.text = address.trim();
        arrestLocation = _itemsLocale.Other;
        print("Address ver 4");
        if (_itemsLocale.IsPlace) {
          editArrestPlace.text = address.trim();
        }
      }
    }
  }

  //test async
  getMessage() async {
    return new Future.delayed(Duration(seconds: 3), () {
      print('finish');
    });
  }

  void onDelete() async {
    Map map = {"ARREST_ID": _arrestMain.ARREST_ID};
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

  // ================================ Delete mas person tab 4 ================================
  void onDeleteMasPerson(int personId) async {
    Map map_person_del = {"PERSON_ID": personId};
    print('map_person_del ${map_person_del}');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionMasPersonupdDelete(map_person_del);
    Navigator.pop(context);
  }
  // =========================================================================================

  bool IsCheckStaff() {
    bool IsCheck = false;
    if (_onEdited) {
      _arrestMain.ArrestStaff.forEach((item) {
        if (item.ArrestType.toString().endsWith("ผู้จับกุม")) {
          IsCheck = true;
        }
      });
    } else {
      _itemsDataTab3.forEach((item) {
        if (item.ArrestType.toString().endsWith("ผู้จับกุม")) {
          IsCheck = true;
        }
      });
    }
    return IsCheck;
  }

  void onSaved(mContext) async {
    if ((_onEdited ? _arrestMain.ArrestIndictment.length : _itemsInitTab6.length) == 0) {
      new VerifyDialog(mContext, 'กรุณาเพิ่มข้อมูลส่วนข้อกล่าวหา');
    } else if (editArrestLocation.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณาเพิ่มสถานที่เกิดเหตุ');
    } else if (editArrestPlace.text.isEmpty) {
      new VerifyDialog(mContext, 'กรุณาเพิ่มสถานที่เขียน');
    } else if (!IsCheckStaff()) {
      new VerifyDialog(mContext, 'กรุณาเลือกผู้จับกุม');
    } else {
      //request
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
      if (_onEdited) {
        List<Map> map_del_notice = [];
        List<Map> map_del_staff_id = [];
        List<Map> map_del_law_id = [];
        List<Map> map_del_pro_id = [];
        List<Map> map_del_indic_id = [];
        List<Map> map_del_indic_detail_id = [];
        List<Map> map_del_indic_product_id = [];
        List<Map> map_up_notice = [];
        List<Map> map_up_staff = [];
        List<Map> map_upadd_lawbreaker = [];
        List<Map> map_upadd_product = [];
        List<Map> map_upadd_indicment = [];
        List<Map> map_up_indicment = [];
        List<Map> map_up_indicment_detail = [];
        List<Map> map_up_indicment_pro = [];
        List<Map> map_up_product = [];
        List<Map> test = [];
        Map map_upd_lawbreaker;

        if (list_delete_notice.length > 0 ||
            list_delete_lawbreaker.length > 0 ||
            list_delete_staff.length > 0 ||
            list_delete_product.length > 0 ||
            list_delete_indicment.length > 0 ||
            list_add_notice.length > 0 ||
            list_add_staff.length > 0 ||
            list_add_lawbreaker.length > 0 ||
            list_add_product.length > 0 ||
            list_add_indicment.length > 0 ||
            list_update_indicment.length > 0 ||
            list_update_product != null ||
            list_update_indicment_pro != null ||
            list_delete_indicment_delt.length > 0 ||
            list_delete_indicment_pro.length > 0) {
          //**************************Delete*********************************

          list_delete_notice.forEach((f) {
            map_del_notice.add({"NOTICE_ID": f});
          });

          list_delete_lawbreaker.forEach((item) {
            _arrestMain.ArrestIndictment.forEach((indic) {
              indic.ArrestIndictmentDetail.forEach((indicDetail) {
                if (item == indicDetail.LAWBREAKER_ID) {
                  map_del_indic_detail_id.add({"INDICTMENT_DETAIL_ID": indicDetail.INDICTMENT_DETAIL_ID});
                }
              });
            });
            map_del_law_id.add({"LAWBREAKER_ID": item});
          });
          list_delete_staff.forEach((item) {
            map_del_staff_id.add({"STAFF_ID": item});
          });

          list_delete_product.forEach((item) {
            _arrestMain.ArrestIndictment.forEach((indic) {
              indic.ArrestIndictmentProduct.forEach((indicProduct) {
                if (item == indicProduct.PRODUCT_ID) {
                  map_del_indic_product_id.add({"PRODUCT_INDICTMENT_ID": indicProduct.PRODUCT_INDICTMENT_ID});
                }
              });
              map_del_pro_id.add({"PRODUCT_ID": item});
            });
          });
          list_delete_indicment.forEach((item) {
            map_del_indic_id.add({"INDICTMENT_ID": item});
          });

          //**************************Update*********************************
          list_add_notice.forEach((f) {
            map_up_notice.add({"NOTICE_ID": f.NOTICE_ID, "ARREST_ID": _arrestMain.ARREST_ID});
          });

          list_add_staff.forEach((f) {
            map_up_staff.add({
              "STAFF_ID": "",
              "ARREST_ID": _arrestMain.ARREST_ID,
              "STAFF_REF_ID": f.STAFF_ID,
              "TITLE_ID": "",
              "STAFF_CODE": "",
              "ID_CARD": f.ID_CARD,
              "STAFF_TYPE": f.STAFF_TYPE,
              "TITLE_NAME_TH": f.TITLE_SHORT_NAME_TH,
              "TITLE_NAME_EN": "Mister",
              "TITLE_SHORT_NAME_TH": f.TITLE_SHORT_NAME_TH,
              "FIRST_NAME": f.FIRST_NAME,
              "LAST_NAME": f.LAST_NAME,
              "AGE": "",
              "OPERATION_DEPT_CODE": f.OPERATION_DEPT_CODE != null ? f.OPERATION_DEPT_CODE : "",
              "OPERATION_DEPT_LEVEL": f.OPERATION_DEPT_LEVEL != null ? f.OPERATION_DEPT_LEVEL : "",
              "OPERATION_DEPT_NAME": f.OPERATION_DEPT_NAME != null ? f.OPERATION_DEPT_NAME : "",
              "OPERATION_OFFICE_CODE": f.OPERATION_OFFICE_CODE != null ? f.OPERATION_OFFICE_CODE : "",
              "OPERATION_OFFICE_NAME": f.OPERATION_OFFICE_NAME != null ? f.OPERATION_OFFICE_NAME : "",
              "OPERATION_OFFICE_SHORT_NAME": f.OPERATION_OFFICE_SHORT_NAME != null ? f.OPERATION_OFFICE_SHORT_NAME : "",
              "OPERATION_POS_CODE": f.OPERATION_POS_CODE != null ? f.OPERATION_POS_CODE : "",
              "OPERATION_POS_LEVEL_NAME": f.OPREATION_POS_LAVEL_NAME != null ? f.OPREATION_POS_LAVEL_NAME : "",
              "OPERATION_UNDER_DEPT_CODE": f.OPERATION_UNDER_DEPT_CODE != null ? f.OPERATION_UNDER_DEPT_CODE : "",
              "OPERATION_UNDER_DEPT_LEVEL": f.OPERATION_UNDER_DEPT_LEVEL != null ? f.OPERATION_UNDER_DEPT_LEVEL : "",
              "OPERATION_UNDER_DEPT_NAME": f.OPERATION_UNDER_DEPT_NAME != null ? f.OPERATION_UNDER_DEPT_NAME : "",
              "OPERATION_WORK_DEPT_CODE": f.OPERATION_WORK_DEPT_CODE != null ? f.OPERATION_WORK_DEPT_CODE : "",
              "OPERATION_WORK_DEPT_LEVEL": f.OPERATION_WORK_DEPT_LEVEL != null ? f.OPERATION_WORK_DEPT_LEVEL : "",
              "OPERATION_WORK_DEPT_NAME": f.OPERATION_WORK_DEPT_NAME != null ? f.OPERATION_WORK_DEPT_NAME : "",
              "OPREATION_POS_LEVEL": f.OPREATION_POS_LEVEL != null ? f.OPREATION_POS_LEVEL : "",
              "OPREATION_POS_NAME": f.OPREATION_POS_NAME != null ? f.OPREATION_POS_NAME : "",
              "MANAGEMENT_POS_CODE": "",
              "MANAGEMENT_POS_NAME": f.MANAGEMENT_POS_NAME != null ? f.MANAGEMENT_POS_NAME : "",
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
              "STATUS": 1,
              "REMARK": "",
              "CONTRIBUTOR_ID": f.ArrestType == "ผู้จับกุม" ? 14 : (f.ArrestType == "ผู้สั่งการ" ? 10 : 15),
              "IS_ACTIVE": 1
            });
          });

          list_add_lawbreaker.forEach((f) {
            map_upadd_lawbreaker.add({
              "LAWBREAKER_ID": "",
              "ARREST_ID": _arrestMain.ARREST_ID,
              "PERSON_ID": f.PERSON_ID,
              "TITLE_ID": f.TITLE_ID,
              "PERSON_TYPE": f.PERSON_TYPE,
              "ENTITY_TYPE": f.ENTITY_TYPE,
              "TITLE_NAME_TH": f.TITLE_NAME_TH,
              "TITLE_NAME_EN": f.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": f.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": f.TITLE_SHORT_NAME_EN,
              "FIRST_NAME": f.FIRST_NAME,
              "MIDDLE_NAME": f.MIDDLE_NAME,
              "LAST_NAME": f.LAST_NAME,
              "OTHER_NAME": f.OTHER_NAME,
              "COMPANY_NAME": f.COMPANY_NAME,
              "COMPANY_REGISTRATION_NO": "",
              "EXCISE_REGISTRATION_NO": "",
              "ID_CARD": f.ID_CARD,
              "AGE": f.AGE,
              "PASSPORT_NO": f.PASSPORT_NO,
              "CAREER": "",
              "PERSON_DESC": "",
              "EMAIL": "",
              "TEL_NO": "",
              "MISTREAT_NO": f.MISTREAT_NO,
              "IS_ACTIVE": 1
            });
          });

          List<Map> productMapping = [];
          list_add_product.forEach((item) {
            productMapping.add({
              "PRODUCT_ID": "",
              "ARREST_ID": _arrestMain.ARREST_ID,
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
              "PRODUCT_GROUP_CODE": "",
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
              "QUANTITY": item.QUANTITY,
              "QUANTITY_UNIT": item.QUANTITY_UNIT,
              "VOLUMN": item.VOLUMN,
              "VOLUMN_UNIT": item.VOLUMN_UNIT,
              "REMARK": item.REMARK,
              "IS_DOMESTIC": 1,
              "IS_ILLEGAL": 1,
              "IS_ACTIVE": 1,
            });
            map_upadd_product.add({
              "PRODUCT_ID": "",
              "ARREST_ID": _arrestMain.ARREST_ID,
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
              "PRODUCT_GROUP_CODE": "",
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
              "QUANTITY": item.QUANTITY,
              "QUANTITY_UNIT": item.QUANTITY_UNIT,
              "VOLUMN": item.VOLUMN,
              "VOLUMN_UNIT": item.VOLUMN_UNIT,
              "REMARK": item.REMARK,
              "IS_DOMESTIC": 1,
              "IS_ILLEGAL": 1,
              "IS_ACTIVE": 1,
              "ArrestProductMapping": []
              /*"ArrestProductMapping": productMapping*/
            });
          });
          // ======================= Check change to new GUILTBASE ===========================
          list_update_indicment.forEach((f) {
            _arrestMainEdit.ArrestIndictment.forEach((f2) {
              if (f.INDICTMENT_ID == f2.INDICTMENT_ID) {
                if (f.GUILTBASE_ID != f2.GUILTBASE_ID) {
                  // f.ArrestIndictmentProduct.forEach((item) {
                  //   test.add({
                  //     "PRODUCT_INDICTMENT_ID": "",
                  //     "PRODUCT_ID": item.PRODUCT_ID,
                  //     "INDICTMENT_ID": "",
                  //     "SIZES_UNIT_ID": item.SIZES_UNIT_ID,
                  //     "QUATITY_UNIT_ID": item.QUATITY_UNIT_ID,
                  //     "VOLUMN_UNIT_ID": item.VOLUMN_UNIT_ID,
                  //     "SIZES": item.SIZES,
                  //     "SIZES_UNIT": item.SIZES_UNIT,
                  //     "QUANTITY": item.QUANTITY,
                  //     "QUANTITY_UNIT": item.QUANTITY_UNIT,
                  //     "VOLUMN": item.VOLUMN,
                  //     "VOLUMN_UNIT": item.VOLUMN_UNIT,
                  //     "FINE_ESTIMATE": "",
                  //     "IS_ILLEGAL": 1,
                  //     "IS_ACTIVE": 1
                  //   });
                  // });
                  map_up_indicment.add({
                    "INDICTMENT_ID": f.INDICTMENT_ID,
                    "ARREST_ID": _arrestMain.ARREST_ID,
                    "GUILTBASE_ID": f.GUILTBASE_ID,
                    "FINE_ESTIMATE": f.FINE_ESTIMATE,
                    "IS_LAWSUIT_COMPLETE": 0,
                    "IS_ACTIVE": 1,
                  });
                }
              }
            });
            print("map_up_indicment: ${map_up_indicment.length}");
            // ========================= Add people to already indicment ======================
            f.ArrestIndictmentDetail.forEach((i) {
              // print("ArrestIndictmentDetail INDICTMENT_DETAIL_ID: ${i.INDICTMENT_DETAIL_ID}");
              // print("ArrestIndictmentDetail LAWBREAKER_ID: ${i.LAWBREAKER_ID}");
              if (i.INDICTMENT_DETAIL_ID == null && i.LAWBREAKER_ID != null) {
                map_up_indicment_detail.add({
                  // // "ArrestIndictmentProduct": map_up_indicment_pro,
                  // "FINE_ESTIMATE": "",
                  // "FIRST_NAME": "",
                  // "INDICTMENT_DETAIL_ID": "",
                  "INDICTMENT_ID": f.INDICTMENT_ID,
                  // "IS_ACTIVE": 1,
                  // "LAST_NAME": "",
                  "LAWBREAKER_ID": i.LAWBREAKER_ID,
                  // "MIDDLE_NAME": "",
                  // "OTHER_NAME": "",
                  // "TITLE_NAME_EN": "",
                  // "TITLE_NAME_TH": "",
                  // "TITLE_SHORT_NAME_EN": "",
                  // "TITLE_SHORT_NAME_TH": "",
                  // // "ArrestIndictmentProduct": test,
                });
                print("map_up_indicment_detail LAWBREAKER_ID != null: ${map_up_indicment_detail.length}");
              } else if (i.INDICTMENT_DETAIL_ID == null && i.LAWBREAKER_ID == null) {
                map_up_indicment_detail.add({
                  // // "ArrestIndictmentProduct": map_up_indicment_pro,
                  // "FINE_ESTIMATE": "",
                  // "FIRST_NAME": "",
                  // "INDICTMENT_DETAIL_ID": "",
                  "INDICTMENT_ID": f.INDICTMENT_ID,
                  // "IS_ACTIVE": 1,
                  // "LAST_NAME": "",
                  "LAWBREAKER_ID": i.LAWBREAKER_ID,
                  // "MIDDLE_NAME": "",
                  // "OTHER_NAME": "",
                  // "TITLE_NAME_EN": "",
                  // "TITLE_NAME_TH": "",
                  // "TITLE_SHORT_NAME_EN": "",
                  // "TITLE_SHORT_NAME_TH": "",
                  // // "ArrestIndictmentProduct": test,
                  "PERSON_ID": i.PERSON_ID,
                });
                print("map_up_indicment_detail LAWBREAKER_ID == null: ${map_up_indicment_detail.length}");
              }
            });
          });
          // ===========================================================

          list_update_product.forEach((item) {
            map_up_product.add({
              "PRODUCT_ID": item.PRODUCT_ID,
              "ARREST_ID": _arrestMain.ARREST_ID,
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
              "PRODUCT_GROUP_CODE": "",
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
              "QUANTITY": item.QUANTITY,
              "QUANTITY_UNIT": item.QUANTITY_UNIT,
              "VOLUMN": item.VOLUMN,
              "VOLUMN_UNIT": item.VOLUMN_UNIT,
              "REMARK": item.REMARK,
              "IS_DOMESTIC": item.IS_DOMESTIC,
              "IS_ILLEGAL": 1,
              "IS_ACTIVE": 1,
              "ArrestProductMapping": []
            });
          });

          if (list_delete_indicment_delt.length > 0) {
            list_delete_indicment_delt.forEach((f) {
              map_del_indic_detail_id.add({"INDICTMENT_DETAIL_ID": f});
            });
          }

          // ======================================= delete product in indicment =====================================
          _arrestMain.ArrestIndictment.forEach((f) {
            _arrestMainEdit.ArrestIndictment.forEach((f2) {
              if (f.INDICTMENT_ID == f2.INDICTMENT_ID) {
                List tempProdIDNew = [];
                f.ArrestIndictmentProduct.forEach((f_prod) {
                  if (f_prod.PRODUCT_ID != null) {
                    tempProdIDNew.add(f_prod.PRODUCT_ID);
                  }
                });
                // print("Del ProdIDNew: ${tempProdIDNew.toString()}");
                f2.ArrestIndictmentDetail.forEach((f2_detail) {
                  f2_detail.ArrestIndictmentProduct.where((m) => !tempProdIDNew.contains(m.PRODUCT_ID)).map((obj) {
                    print("Del PRODUCT_ID: ${obj.PRODUCT_ID}, Del PRODUCT_INDICTMENT_ID: ${obj.PRODUCT_INDICTMENT_ID}");
                    map_del_indic_product_id.add({"PRODUCT_INDICTMENT_ID": obj.PRODUCT_INDICTMENT_ID});
                  }).toList();
                });
              }
            });
          });
        }
        // =========================================================================================================

        Map local;
        if (list_update_location != null) {
          local = {
            "LOCALE_ID": _arrestMain.ArrestLocale[0].LOCALE_ID,
            "ARREST_ID": _arrestMain.ARREST_ID,
            "SUB_DISTRICT_ID": list_update_location.SUB_DISTICT.SUB_DISTRICT_ID,
            "GPS": list_update_location.GPS != null ? list_update_location.GPS : "",
            "ADDRESS_NO": list_update_location.ADDRESS_NO != null ? list_update_location.ADDRESS_NO : "",
            "VILLAGE_NO": "",
            "BUILDING_NAME": "",
            "ROOM_NO": "",
            "FLOOR": "",
            "VILLAGE_NAME": "",
            "ALLEY": "",
            "LANE": list_update_location.LANE != null ? list_update_location.LANE : "",
            "ROAD": list_update_location.ROAD != null ? list_update_location.ROAD : "",
            "ADDRESS_TYPE": 4,
            "ADDRESS_STATUS": 0,
            "POLICE_STATION": editArrestPoliceStation.text == null ? "" : editArrestPoliceStation.text,
            // "LOCATION": editArrestLocation.text,
            "LOCATION": arrestLocation,
            "IS_ACTIVE": 1
          };
        } else {
          local = {
            "LOCALE_ID": _arrestMain.ArrestLocale[0].LOCALE_ID,
            "ARREST_ID": _arrestMain.ARREST_ID,
            "SUB_DISTRICT_ID": _arrestMain.ArrestLocale[0].SUB_DISTRICT_ID,
            "GPS": _arrestMain.ArrestLocale[0].GPS != null ? _arrestMain.ArrestLocale[0].GPS : "",
            "ADDRESS_NO": _arrestMain.ArrestLocale[0].ADDRESS_NO != null ? _arrestMain.ArrestLocale[0].ADDRESS_NO : "",
            "VILLAGE_NO": "",
            "BUILDING_NAME": "",
            "ROOM_NO": "",
            "FLOOR": "",
            "VILLAGE_NAME": "",
            "ALLEY": "",
            "LANE": _arrestMain.ArrestLocale[0].LANE != null ? _arrestMain.ArrestLocale[0].LANE : "",
            "ROAD": _arrestMain.ArrestLocale[0].ROAD != null ? _arrestMain.ArrestLocale[0].ROAD : "",
            "ADDRESS_TYPE": 4,
            "ADDRESS_STATUS": 0,
            "POLICE_STATION":
                /*_arrestMain.ArrestLocale[0].POLICE_STATION!=null
                ?_arrestMain.ArrestLocale[0].POLICE_STATION:""*/
                editArrestPoliceStation.text == null ? "" : editArrestPoliceStation.text,
            "LOCATION": _arrestMain.ArrestLocale[0].LOCATION,
            "IS_ACTIVE": 1
          };
        }

        Map map_arrest = {
          "ARREST_ID": _arrestMain.ARREST_ID,
          "OFFICE_ID": 13,
          "ARREST_CODE": _arrestMain.ARREST_CODE,
          "OFFICE_CODE": _arrestMain.OFFICE_CODE,
          "OFFICE_NAME": editArrestPlace.text,
          "ARREST_DATE": _arrestDate.toString(),
          "OCCURRENCE_DATE": _dtCreate.toString(),
          "BEHAVIOR_1": editArrestBehavior.text,
          "BEHAVIOR_2": "",
          "BEHAVIOR_3": "",
          "BEHAVIOR_4": "",
          "BEHAVIOR_5": "",
          "TESTIMONY": "",
          "IS_REQUEST": TESTIMONY == true ? 1 : 0,
          "REQUEST_DESC": TESTIMONY ? editNotificationOfRights.text : "",
          "IS_LAWSUIT_COMPLETE": 0,
          "IS_ACTIVE": 1,
          "CREATE_DATE": DateTime.now().toString(),
          "CREATE_USER_ACCOUNT_ID": 13,
          "UPDATE_DATE": "",
          "UPDATE_USER_ACCOUNT_ID": 0,
          "ArrestLocale": [local]
        };

        print("is update pro : " + map_upadd_product.isEmpty.toString());

        await onLoadActionArrestLawbreakerupdDelete(
          map_arrest,
          map_del_notice,
          map_del_law_id,
          map_del_indic_detail_id,
          map_del_staff_id,
          map_del_pro_id,
          map_del_indic_product_id,
          map_del_indic_id,
          map_up_notice,
          map_up_staff,
          map_upadd_lawbreaker,
          map_upadd_product,
          map_upadd_indicment,
          map_up_indicment,
          map_up_indicment_pro,
          map_up_indicment_detail,
          map_up_product,
          map_del_notice.isEmpty,
          map_del_law_id.isEmpty,
          map_del_indic_detail_id.isEmpty,
          map_del_staff_id.isEmpty,
          map_del_pro_id.isEmpty,
          map_del_indic_product_id.isEmpty,
          map_del_indic_id.isEmpty,
          map_up_notice.isEmpty,
          map_up_staff.isEmpty,
          map_upadd_lawbreaker.isEmpty,
          map_upadd_product.isEmpty,
          map_upadd_indicment.isEmpty,
          map_up_indicment.isEmpty,
          map_up_indicment_pro.isEmpty,
          map_up_indicment_detail.isEmpty,
          map_up_product.isEmpty,
        );

        //load data again
        Map MAP_ARREST_ID = {"ARREST_ID": _arrestMain.ARREST_ID};
        await future.apiRequestGet(MAP_ARREST_ID).then((onValue) {
          _arrestMain = onValue;

          //sort staff
          _arrestMain.ArrestStaff.sort((a, b) {
            return a.STAFF_ID.compareTo(b.STAFF_ID);
          });

          _setItemProductOps();
        });
      } else {
        setState(() {
          if (_controller != null) {
            _controller.setVolume(0.0);
            _controller.removeListener(listener);
            _controller = null;
          }
        });

        await onLoadActionInsAll(/*putDataRequest()*/);
      }
      Navigator.pop(context);

      if (InsertNotSuccess) {
        new NetworkDialog(context, "บันทึกข้อมูลไม่สำเร็จ!");
      }
    }
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
                Navigator.pop(mContext);
              },
              child: new Text('ยกเลิก', style: ButtonCancelStyle)),
          new CupertinoButton(
              onPressed: () {
                Navigator.pop(mContext);
                //Navigator.pop(mContext);
                if (!_onEdited) {
                  Navigator.pop(mContext, "Back");
                } else {
                  /*if (mounted) {
                    setState(() {
                      _onEdited = false;
                      _onSaved = true;
                      _onFinish = true;



                      _itemsDataTab8 = [];
                      _itemsDataTab8.add(ItemsListArrest8("แบบฟอร์มบันทึกการจับ 2/39","ILG60_00_03_001"));
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
    print("onRadata!!!!!");
    Map MAP_ARREST_ID = {'ARREST_ID': _arrestMain.ARREST_ID};
    await future.apiRequestGet(MAP_ARREST_ID).then((onValue) {
      _arrestMain = onValue;

      onValue.ArrestIndictment.forEach((f) {
        _tempIndictmentEdit.add(f);
      });

      //sort staff
      _arrestMain.ArrestStaff.sort((a, b) {
        return a.STAFF_ID.compareTo(b.STAFF_ID);
      });

      _setItemProductOps();
    });

    await future.apiRequestGetEdit(MAP_ARREST_ID).then((onValue) {
      _arrestMainEdit = onValue;
    });

    //get VDO
    Map map = {"DOCUMENT_TYPE": 3, "REFERENCE_CODE": _arrestMain.ARREST_ID};

    await new TransectionFuture().apiRequestGetDocumentByCon(map).then((onValue) {
      List<ItemsListDocument> items = [];
      onValue.forEach((item) {
        if (int.parse(item.IS_ACTIVE) == 1) {
          items.add(item);
        }
      });

      List<ItemsListDocument> items_doc = [];
      print(items.length);
      items.forEach((f) {
        File _file = new File(f.DOCUMENT_OLD_NAME);
        items_doc.add(new ItemsListDocument(
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

        _controller = VideoPlayerController.file(_file)
          ..addListener(listener)
          ..setVolume(1.0)
          ..initialize()
          ..setLooping(false)
          ..play();
      });
      itemsVideoFile = items_doc;
    });

    _onEdited = false;
    widget.IsCreate = false;
    _onSaved = true;
    _onFinish = true;

    setState(() {
      choices.add(Choice(title: 'แบบฟอร์ม'));
    });
    int index = 6;
    // int index = 7;
    tabController = TabController(initialIndex: index, length: choices.length, vsync: this);
    _tabPageSelector = new TabPageSelector(controller: tabController);
    tabController.animateTo((choices.length - 1));

    _itemsDataTab8 = [];
    _itemsDataTab8.add(ItemsListArrest8("แบบฟอร์มบันทึกการจับ 2/39", "ILG60_00_03_001"));

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

  Future<bool> onLoadAction() async {
    await new Future.delayed(const Duration(seconds: 3));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    /**********************async loading******************************/
    var _asyncLoader = new AsyncLoader(
      key: _asyncLoaderState,
      initState: () async => await getMessage(),
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) => new Text('Sorry, there was an error loading your joke'),
      renderSuccess: ({data}) => new Text(data),
    );

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final btnCancle = new FlatButton(
      onPressed: () {
        /*_onEdited ?
                setState(() {
                  _onSave = false;
                  _onEdited = false;
                }) :*/
        _onSaved ? Navigator.pop(context) : _showCancelAlertDialog(context);
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
                        /* setState(() {
                      _onSaved = true;
                      _onSave = false;
                      _onEdited = false;
                    });*/
                        //TabScreenArrest1().createAcceptAlert(context);
                      },
                      child: Text('บันทึก', style: appBarStyle))
                  : _onSaved && _arrestMain.IS_LAWSUIT_COMPLETE == 1
                      ? Container()
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
                        ))
              : new FlatButton(
                  onPressed: () {
                    onSaved(context);
                    //editTestimony.text=putDataRequest().toString();
                  },
                  child: Text('บันทึก', style: appBarStyle)),
        ],
      )
    ];
    return Scaffold(
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
                  'งานจับกุม',
                  style: appBarStyle,
                ),
                leading: btnCancle,
                actions: btnSave,
                automaticallyImplyLeading: false,
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
                          _buildContent_tab_2(),
                          _buildContent_tab_3(),
                          _buildContent_tab_4(),
                          _buildContent_tab_5(),
                          _buildContent_tab_6(),
                          _buildContent_tab_7(),
                          _buildContent_tab_8(),
                        ]
                      : <Widget>[
                          _buildContent_tab_1(),
                          _buildContent_tab_2(),
                          _buildContent_tab_3(),
                          _buildContent_tab_4(),
                          _buildContent_tab_5(),
                          _buildContent_tab_6(),
                          _buildContent_tab_7(),
                        ],
                )
              ],
            ),
          ),
        ),
      ),
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
                            child: Text(
                              "เลขที่ใบจับกุม",
                              style: textLabelStyle,
                            ),
                          ),
                          new Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              enabled: false,
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
                          //_buildLine,
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
                                        initialDateTime: _dtArrest,
                                        onDateTimeChanged: (DateTime s) {
                                          setState(() {
                                            _currentDateArrestEN = s.toString();
                                            print(_currentDateArrestEN);
                                            String date = "";
                                            List splits = dateFormatDate.format(s).toString().split(" ");
                                            date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                            _dtArrest = s;
                                            _currentDateArrestTH = date;
                                            editArrestDate.text = _currentDateArrestTH;

                                            //_arrestDate = _dtArrest.toString();

                                            List splitsArrestDate = _dtArrest.toUtc().toLocal().toString().split(" ");
                                            List splitsArrestTime = time.toString().split(" ");
                                            _arrestDate = splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString();
                                            //print(_arrestDate);
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              focusNode: myFocusNodeArrestDate,
                              controller: editArrestDate,
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
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "เวลาจับกุม",
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
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.time,
                                        initialDateTime: time,
                                        onDateTimeChanged: (DateTime newDateTime) {
                                          setState(() {
                                            time = newDateTime;
                                            _time = dateFormatTime.format(time).toString();
                                            editArrestTime.text = _time;

                                            List splitsArrestDate = _dtArrest.toUtc().toLocal().toString().split(" ");
                                            List splitsArrestTime = time.toString().split(" ");
                                            _arrestDate = splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString();
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              focusNode: myFocusNodeArrestTime,
                              controller: editArrestTime,
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
                                  "สถานที่เกิดเหตุ",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textLabelDeleteStyle,
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
                                _navigateMap(context);
                              },
                              focusNode: myFocusNodeArrestLocation,
                              controller: editArrestLocation,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                suffixIcon: Icon(
                                  FontAwesomeIcons.mapMarkerAlt,
                                  color: Color(0xff087de1),
                                ),
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "วันที่เขียน",
                              style: textLabelStyle,
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              enableInteractiveSelection: false,
                              onTap: () {
                                FocusScope.of(context).requestFocus(new FocusNode());
                                /*showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ArrestDynamicDialog(
                                        Current: _dtCreate,
                                        MaxDate: _dtMaxDate,
                                        MinDate: _dtArrest,
                                      );
                                    }).then((s) {
                                  _currentDateCreateEN = s.toString();
                                  String date = "";
                                  List splits = dateFormatDate.format(
                                      s).toString().split(" ");
                                  date = splits[0] + " " + splits[1] +
                                      " " +
                                      (int.parse(splits[3]) + 543)
                                          .toString();
                                  setState(() {
                                    _dtCreate = s;
                                    _currentDateCreateTH = date;
                                    editArrestDateCreate.text =
                                        _currentDateCreateTH;
                                    //myFocusNodeArrestDateCreate.dispose();
                                  });
                                });*/

                                showCupertinoModalPopup<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _buildBottomPicker(
                                      CupertinoDatePicker(
                                        minimumDate: _dtArrest,
                                        maximumDate: _dtMaxDate,
                                        maximumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) + 1,
                                        minimumYear: int.parse(DateFormat("yyyy").format(DateTime.now())) - 1,
                                        mode: CupertinoDatePickerMode.date,
                                        initialDateTime: _dtCreate,
                                        onDateTimeChanged: (DateTime s) {
                                          setState(() {
                                            _currentDateCreateEN = s.toString();
                                            String date = "";
                                            List splits = dateFormatDate.format(s).toString().split(" ");
                                            date = splits[0] + " " + splits[1] + " " + (int.parse(splits[3]) + 543).toString();

                                            _dtCreate = s;
                                            _currentDateCreateTH = date;
                                            editArrestDateCreate.text = _currentDateCreateTH;
                                            //myFocusNodeArrestDate.dispose();

                                            List splitsArrestDate = _dtCreate.toUtc().toLocal().toString().split(" ");
                                            List splitsArrestTime = DateTime.now().toString().split(" ");
                                            _dtCreate = DateTime.parse(splitsArrestDate[0].toString() + " " + splitsArrestTime[1].toString());
                                            //print(_dtCreate.toString());
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              focusNode: myFocusNodeArrestDateCreate,
                              controller: editArrestDateCreate,
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
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "เขียนที่",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  "*",
                                  style: textLabelDeleteStyle,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              style: textInputStyle,
                              focusNode: myFocusNodeArrestPlace,
                              controller: editArrestPlace,
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              // "ส่งพนักงานสืบสวนที่",
                              "สถานีตำรวจท้องที่เกิดเหตุ",
                              style: textLabelStyle,
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              style: textInputStyle,
                              focusNode: myFocusNodeArrestPoliceStation,
                              controller: editArrestPoliceStation,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,

                          //Select Video
                          _buildButtonVideoPicker(),
                          //Display Video
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              '* อัพโหลดไฟล์ได้ไม่เกิน 200 MB',
                              textAlign: TextAlign.start,
                              style: textLabelDeleteStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            itemsVideoFile.length > 0
                ? _previewVideo(_controller) /*_previewVideo(context)*/
                : Container()
          ],
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      String address = "";
      String _tempLocation = "";
      String police_station = "";
      _arrestMain.ArrestLocale.forEach((item) {
        address = (item.LOCATION == null ? "" : item.LOCATION + " ") +
            (item.ADDRESS_NO == null ? "" : item.ADDRESS_NO + " ") +
            (item.LANE == null ? "" : "ซอย " + item.LANE + " ") +
            (item.ROAD == null ? "" : "ถนน " + item.ROAD + " ") +
            "อำเภอ/เขต " +
            (item.DISTRICT_NAME_TH.toString() + " ") +
            "ตำบล/แขวง " +
            (item.SUB_DISTRICT_NAME_TH.toString() + " ") +
            "จังหวัด " +
            item.PROVINCE_NAME_TH.toString();
        // address = item.LOCATION;
        _tempLocation = item.LOCATION;
        police_station = item.POLICE_STATION;
      });
      arrestLocation = _tempLocation;
      print("Address ver 5");

      //OCCURRENCE_DATE
      DateTime dt_occourrence = DateTime.parse(_arrestMain.ARREST_DATE);
      String arrestDate = "";
      List splits1 = dateFormatDate.format(dt_occourrence).toString().split(" ");
      arrestDate = splits1[0] + " " + splits1[1] + " " + (int.parse(splits1[3]) + 543).toString();
      String arrestTime = "เวลา " + dateFormatTime.format(dt_occourrence).toString();
      //ARREST_DATE
      DateTime dt_arrest = DateTime.parse(_arrestMain.OCCURRENCE_DATE);
      String arrestCreateDate = "";
      List splits2 = dateFormatDate.format(dt_arrest).toString().split(" ");
      arrestCreateDate = splits2[0] + " " + splits2[1] + " " + (int.parse(splits2[3]) + 543).toString();
      String arrestCreateTime = "เวลา " + dateFormatTime.format(dt_arrest).toString();

      String arrestNumber = _arrestMain.ARREST_CODE;
      String arrestPlace = _arrestMain.OFFICE_NAME;

      return _arrestMain == null
          ? Container()
          : Container(
              padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 4.0, bottom: 12.0, left: 22.0, right: 22.0),
                      child: Card(
                        elevation: 0.0,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เลขที่ใบจับกุม",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                arrestNumber,
                                style: textInputStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "วันที่จับกุม",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                arrestDate + " " + arrestTime,
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "สถานที่เกิดเหตุ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                address,
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "วันที่เขียน",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                arrestCreateDate + " " + arrestCreateTime,
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เขียนที่",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                arrestPlace,
                                style: textInputStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                // "ส่งพนักงานสืบสวนที่",
                                "สถานีตำรวจท้องที่เกิดเหตุ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                police_station != null ? police_station : "-",
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemsVideoFile != null ? _previewVideo(_controller) : Container()
                  ],
                ),
              ),
            );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   //height: 34.0,
          //   decoration: BoxDecoration(
          //       color: Colors.grey[200],
          //       border: Border(
          //         top: BorderSide(color: Colors.grey[300], width: 1.0),
          //         //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
          //       )),
          //   /*child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: <Widget>[
          //       Padding(
          //         padding: EdgeInsets.all(8.0),
          //         child: new Text('ILG60_B_01_00_03_00',
          //           style: textStylePageName,),
          //       )
          //     ],
          //   ),*/
          // ),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: new ListView(padding: EdgeInsets.only(top: 0), children: <Widget>[
                _onSaved ? _buildContent_saved(context) : _buildContent(context),
              ]),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_1*******************************

//************************start_tab_2*****************************
  _navigateSearchTab2(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest2Search(
                ItemsPerson: widget.ItemsPerson,
              )),
    );
    if (_onEdited) {
      List items = result;
      items.forEach((f) {
        print(f.NOTICE_CODE);
        var item = f;
        list_add_notice.add(item);
        _arrestMain.ArrestNotice.add(item);
        _itemsDataTab2.add(item);
      });
    } else {
      List items = result;
      if (_itemsDataTab2.length > 0) {
        for (var i = 0; i < result.length; i++) {
          _itemsDataTab2.add(result[i]);
        }
      } else {
        _itemsDataTab2 = result;
      }
    }
    setState(() {});
  }

  Widget _buildContent_tab_2() {
    //data result when search data
    Widget _buildContent() {
      return (_onEdited ? _arrestMain.ArrestNotice.length : _itemsDataTab2.length) == 0
          ? Center(
              child: Padding(
                padding: paddingInputBox,
                child: Text(
                  "ค้นหาใบแจ้งความที่ช่องค้นหา",
                  style: TextStyle(fontSize: 20.0, fontFamily: FontStyles().FontFamily),
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.only(bottom: 12.0),
              child: ListView.builder(
                itemCount: _onEdited ? _arrestMain.ArrestNotice.length : _itemsDataTab2.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  List itemNotice = [];
                  if (_onEdited) {
                    itemNotice = _arrestMain.ArrestNotice;
                  } else {
                    itemNotice = _itemsDataTab2;
                  }

                  String title = itemNotice[index].STAFF_TITLE_SHORT_NAME_TH != null ? itemNotice[index].STAFF_TITLE_SHORT_NAME_TH : itemNotice[index].STAFF_TITLE_NAME_TH;
                  String firstname = itemNotice[index].STAFF_FIRST_NAME != null ? itemNotice[index].STAFF_FIRST_NAME : "";
                  String lastname = itemNotice[index].STAFF_LAST_NAME != null ? itemNotice[index].STAFF_LAST_NAME : "";
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                      child: Container(
                        padding: EdgeInsets.all(18.0),
                        decoration: BoxDecoration(
                            //color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: index == 0
                                ? Border(
                                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                  )
                                : Border(
                                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                  )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "เลขที่ใบแจ้งความ",
                                style: textLabelStyle,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: paddingInputBox,
                                    child: Text(
                                      itemNotice[index].NOTICE_CODE,
                                      style: textDataStyle,
                                    ),
                                  ),
                                ),
                                Center(
                                    child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showDeleteItemsAlertDialog(index, "Notice", null);
                                    });
                                  },
                                  child: Container(
                                      child: Text(
                                    "ลบ",
                                    style: textLabelDeleteStyle,
                                  )),
                                )),
                              ],
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "ผู้รับแจ้งความ " + title + firstname + " " + lastname,
                                style: textDataStyleSub,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
    }

    Widget _buildContent_saved(BuildContext context) {
      return ListView.builder(
          itemCount: _arrestMain.ArrestNotice.length,
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
                                  "เลขที่ใบเเจ้งความ",
                                  style: textLabelStyle,
                                ),
                              ),
                              Padding(
                                padding: paddingInputBox,
                                child: Text(
                                  _arrestMain.ArrestNotice[index].NOTICE_CODE,
                                  style: textInputStyle,
                                ),
                              ),
                              Container(
                                padding: paddingInputBox,
                                child: Text(
                                  "ผู้รับแจ้งความ " + _arrestMain.ArrestNotice[index].STAFF_TITLE_SHORT_NAME_TH + _arrestMain.ArrestNotice[index].STAFF_FIRST_NAME + " " + _arrestMain.ArrestNotice[index].STAFF_LAST_NAME,
                                  style: textDataSubStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              //height: 34.0,
              // decoration: BoxDecoration(
              //     //color: Colors.grey[200],
              //     border: Border(
              //   top: BorderSide(color: Colors.grey[300], width: 1.0),
              // )),
              child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  /*Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_05_00',
                          style: textStylePageName,),
                      ),*/
                ],
              ),
              _onSaved
                  ? Container()
                  : Container(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: new Card(
                          elevation: 0.0,
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              _navigateSearchTab2(context);
                            },
                            child: new ListTile(
                              leading: new Icon(Icons.search),
                              title: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'ค้นหาใบแจ้งความ',
                                    style: TextStyle(fontSize: 16.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          )),
          Expanded(
            child: new ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: _onSaved ? _buildContent_saved(context) : _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

//************************end_tab_2*******************************

//************************start_tab_3*****************************
  List _id_staff = [];
  List _id_staff_previos = [];
  _navigateSearchTab3(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest3Search(
                ItemsMain: _arrestMain,
                itemsTitle: widget.itemsTitle,
              )),
    );

    if (result.toString() != "back") {
      if (_onEdited) {
        List items = result;
        /*_arrestMain.ArrestStaff.forEach((item) {
          _id_staff.add(item.STAFF_ID);
          _id_staff_previos.add(item.STAFF_ID);
        });*/
        items.forEach((item) {
          //_id_staff.add(item.STAFF_ID);
          _arrestMain.ArrestStaff.add(item);
          list_add_staff.add(item);
        });
        /*var _removeDupicate = _id_staff.toSet().toList();
        List ItemsAll = [];
        List ItemsAll1 = [];
        for (int i = 0; i < _removeDupicate.length; i++) {
          for (int j = 0; j < _arrestMain.ArrestStaff.length; j++) {
            if (_removeDupicate[i] ==
                _arrestMain.ArrestStaff[j].STAFF_ID) {
              ItemsAll.add(_arrestMain.ArrestStaff[j]);
              ItemsAll1.add(_arrestMain.ArrestStaff[j]);
              break;
            }
          }
        }
        _arrestMain.ArrestStaff = ItemsAll;

        for (int i = 0; i < _id_staff_previos.length; i++) {
          ItemsAll1.removeWhere((item) => item.STAFF_ID == _id_staff_previos[i]);
        }
        list_add_staff = ItemsAll1;
        */
      } else {
        List items = result;
        items.forEach((item) {
          //_id_staff.add(item.STAFF_ID);
          _itemsDataTab3.add(item);
        });
        /*var _removeDupicate = _id.toSet().toList();
        List ItemsAll = [];
        for (int i = 0; i < _removeDupicate.length; i++) {
          for (int j = 0; j < _itemsDataTab3.length; j++) {
            if (_removeDupicate[i] == _itemsDataTab3[j].STAFF_ID) {
              ItemsAll.add(_itemsDataTab3[j]);
              break;
            }
          }
        }
        _itemsDataTab3 = ItemsAll;*/
        //_itemsDataTab3.add(item);
      }
    }
  }

  Widget _buildContent_tab_3() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: _onEdited ? _arrestMain.ArrestStaff.length : _itemsDataTab3.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            List itemStaff = [];
            if (_onEdited) {
              itemStaff = _arrestMain.ArrestStaff;
            } else {
              itemStaff = _itemsDataTab3;
            }

            String level = itemStaff[index].OPREATION_POS_LAVEL_NAME != null ? itemStaff[index].OPREATION_POS_LAVEL_NAME : "";
            String position = itemStaff[index].MANAGEMENT_POS_NAME != null ? itemStaff[index].MANAGEMENT_POS_NAME : "-";
            String office = "";
            if (itemStaff[index].OPERATION_OFFICE_SHORT_NAME != null) {
              if (itemStaff[index].OPERATION_OFFICE_SHORT_NAME.toString().isEmpty) {
                office = itemStaff[index].OPERATION_OFFICE_NAME;
              } else {
                office = itemStaff[index].OPERATION_OFFICE_SHORT_NAME;
              }
            } else {
              office = itemStaff[index].OPERATION_OFFICE_NAME;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                child: Container(
                    padding: EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: index == 0
                            ? Border(
                                //top: BorderSide(color: Colors.grey[300], width: 1.0),
                                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                              )
                            : Border(
                                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                              )),
                    child: Column(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: paddingInputBox,
                                    child: Text(
                                      itemStaff[index].TITLE_SHORT_NAME_TH + itemStaff[index].FIRST_NAME + " " + itemStaff[index].LAST_NAME,
                                      style: textDataStyle,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    itemStaff[index].IsCreated
                                        ? Container(
                                            padding: EdgeInsets.only(right: 22.0),
                                            child: Center(
                                                child: InkWell(
                                              onTap: () {
                                                _navigateEditStaff(context, itemStaff[index], index);
                                              },
                                              child: index == 0
                                                  ? Container()
                                                  : Container(
                                                      child: Text(
                                                      "แก้ไข",
                                                      style: textLabelDeleteStyle,
                                                    )),
                                            )),
                                          )
                                        : Container(),
                                    Center(
                                        child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _showDeleteItemsAlertDialog(index, "Staff", null);
                                        });
                                      },
                                      child: index == 0
                                          ? Container()
                                          : !itemStaff[index].ArrestType.endsWith("ผู้จับกุม")
                                              ? Container(
                                                  child: Text(
                                                  "ลบ",
                                                  style: textLabelDeleteStyle,
                                                ))
                                              : Container(),
                                    )),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "ตำแหน่ง : " + position,
                                style: textDataStyleSub,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: paddingInputBox,
                                    child: Text(
                                      "สังกัด : " + office,
                                      //itemStaff[index].OPERATION_OFFICE_NAME,
                                      style: textDataStyleSub,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        itemStaff.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: itemStaff[index].ArrestType,
                                          isDense: true,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              if (newValue == "ผู้จับกุม") {
                                                for (int i = 0; i < itemStaff.length; i++) {
                                                  if (index != i) {
                                                    if (itemStaff[i].ArrestType.endsWith("ผู้จับกุม")) {
                                                      itemStaff[i].ArrestType = "ผู้ร่วมจับกุม";
                                                    }
                                                  } else {
                                                    itemStaff[index].ArrestType = newValue;
                                                  }
                                                }
                                              } else {
                                                itemStaff[index].ArrestType = newValue;
                                              }
                                              // if (itemStaff[index].ArrestType.endsWith("ผู้จับกุม")) {
                                              //   for (int i = 0; i < itemStaff.length; i++) {
                                              //     if (index != i) {
                                              //       if (itemStaff[i].ArrestType.endsWith("ผู้จับกุม")) {
                                              //         itemStaff[i].ArrestType = "ผู้ร่วมจับกุม";
                                              //       }
                                              //       /*else{
                                              //           itemStaff[i]
                                              //               .ArrestType =
                                              //           "ผู้สั่งการ";
                                              //         }*/
                                              //     }
                                              //   }
                                              // }
                                            });
                                          },
                                          items: itemStaff[index].ArrestTypeItems.map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: textDataStyle,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            );
          },
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      /*_arrestMain.ArrestStaff.sort((a, b) {
          return a.CONTRIBUTOR_ID.compareTo(b.CONTRIBUTOR_ID);
        });*/

      return ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemCount: _arrestMain.ArrestStaff.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          String office = "";
          if (_arrestMain.ArrestStaff[index].OPERATION_OFFICE_SHORT_NAME != null) {
            if (_arrestMain.ArrestStaff[index].OPERATION_OFFICE_SHORT_NAME.toString().isEmpty) {
              office = _arrestMain.ArrestStaff[index].OPERATION_OFFICE_NAME;
            } else {
              office = _arrestMain.ArrestStaff[index].OPERATION_OFFICE_SHORT_NAME;
            }
          } else {
            office = _arrestMain.ArrestStaff[index].OPERATION_OFFICE_NAME;
          }

          return Padding(
            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
            child: Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  //color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: index == 0
                      ? Border(
                          //top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                      : Border(
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: paddingInputBox,
                              child: Text(
                                _arrestMain.ArrestStaff[index].TITLE_SHORT_NAME_TH + _arrestMain.ArrestStaff[index].FIRST_NAME + " " + _arrestMain.ArrestStaff[index].LAST_NAME,
                                style: textDataStyle,
                              ),
                            ),
                          ),
                          _onEdited
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    _arrestMain.ArrestStaff[index].STAFF_TYPE == 0
                                        ? Container(
                                            padding: EdgeInsets.only(right: 22.0),
                                            child: Center(
                                                child: InkWell(
                                              onTap: () {
                                                _navigateEditStaff(context, _arrestMain.ArrestStaff[index], index);
                                              },
                                              child: _arrestMain.ArrestStaff[index].CONTRIBUTOR_ID == 14
                                                  ? Container()
                                                  : Container(
                                                      child: Text(
                                                      "แก้ไข",
                                                      style: textLabelDeleteStyle,
                                                    )),
                                            )),
                                          )
                                        : Container(),
                                    Center(
                                        child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _showDeleteItemsAlertDialog(index, "StaffUp", null);
                                        });
                                      },
                                      child: _arrestMain.ArrestStaff[index].CONTRIBUTOR_ID == 14
                                          ? Container()
                                          : Container(
                                              child: Text(
                                              "ลบ",
                                              style: textLabelDeleteStyle,
                                            )),
                                    ))
                                  ],
                                )
                              : Container(),
                        ],
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          "ตำแหน่ง : " + _arrestMain.ArrestStaff[index].MANAGEMENT_POS_NAME != null ? _arrestMain.ArrestStaff[index].MANAGEMENT_POS_NAME : "-",
                          style: textDataStyleSub,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "สังกัด : " + office.toString(),
                                style: textDataStyleSub,
                              ),
                            ),
                          ),
                          _onEdited
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Center(
                                      child: Container(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: _arrestMain.ArrestStaff[index].ArrestType,
                                            isDense: true,
                                            onChanged: (String newValue) {
                                              setState(() {
                                                if (newValue == "ผู้จับกุม") {
                                                  for (int i = 0; i < _arrestMain.ArrestStaff.length; i++) {
                                                    if (index != i) {
                                                      if (_arrestMain.ArrestStaff[i].ArrestType.endsWith("ผู้จับกุม")) {
                                                        _arrestMain.ArrestStaff[i].ArrestType = "ผู้ร่วมจับกุม";
                                                      }
                                                    } else {
                                                      _arrestMain.ArrestStaff[index].ArrestType = newValue;
                                                    }
                                                  }
                                                } else {
                                                  _arrestMain.ArrestStaff[index].ArrestType = newValue;
                                                }

                                                // if (!_arrestMain.ArrestStaff[index].ArrestType.endsWith("ผู้จับกุม")) {
                                                //   _arrestMain.ArrestStaff[index].ArrestType = newValue;
                                                // }
                                                // if (_arrestMain.ArrestStaff[index].ArrestType.endsWith("ผู้จับกุม")) {
                                                //   for (int i = 0; i < _arrestMain.ArrestStaff.length; i++) {
                                                //     if (index != i) {
                                                //       _arrestMain.ArrestStaff[i].ArrestType = "ผู้ร่วมจับกุม";
                                                //     }
                                                //   }
                                                // }
                                              });
                                            },
                                            items: _arrestMain.ArrestStaff[index].ArrestTypeItems.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: textDataStyle,
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Padding(
                                  padding: paddingInputBox,
                                  child: Text(
                                    _arrestMain.ArrestStaff[index].CONTRIBUTOR_ID == 14 ? "ผู้จับกุม" : (_arrestMain.ArrestStaff[index].CONTRIBUTOR_ID == 10 ? "ผู้สั่งการ" : "ผู้ร่วมจับกุม"),
                                    style: textDataStyle,
                                  ),
                                ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
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
                  //height: 34.0,
                  // decoration: BoxDecoration(
                  //     //color: Colors.grey[200],
                  //     border: Border(
                  //   top: BorderSide(color: Colors.grey[300], width: 1.0),
                  //   //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  // )),
                  /*child: Column(
                    children: <Widget>[Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text('ILG60_B_01_00_08_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
                  ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _onSaved ? _buildContent_saved(context) : _buildContent(),
                ),
              ),
            ],
          ),
        ),
        _onSaved
            ? Container()
            : Align(
                alignment: Alignment.bottomRight,
                child: new Padding(
                  padding: EdgeInsets.all(18.0),
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff087de1),
                    onPressed: () {
                      _navigateSearchTab3(context);
                    },
                    mini: false,
                    child: new Icon(Icons.add),
                  ),
                ),
              )
      ],
    );
  }

  _navigateEditStaff(BuildContext context, ItemsListArrestStaff items, index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest3Create(
                Items: items,
                IsUpdate: true,
                ItemsMain: _arrestMain,
                itemsTitle: widget.itemsTitle,
              )),
    );
    if (result.toString() != "Back") {
      if (widget.IsUpdate || _onEdited) {
        _arrestMain.ArrestStaff[index] = result;
      } else {
        var items = result;
        print("Back : " + items.FIRST_NAME.toString());
        setState(() {
          _itemsDataTab3[index] = result;
        });
      }
    }
    //_arrestMain.ArrestStaff[index] = result;
  }
//************************end_tab_3*******************************

//************************start_tab_4*******************************
  List _id = [];
  _navigateScreenAddTab4(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest4Add(
                itemsTitle: widget.itemsTitle,
                IsNotice: false,
              )),
    );
    if (result.toString() != "back") {
      if (_onEdited) {
        List _id_law_previos = [];
        List _temp_id = [];
        List items = result;
        _arrestMain.ArrestLawbreaker.forEach((item) {
          _id.add(item.PERSON_ID);
          // _id_law_previos.add(item.PERSON_ID);
        });

        _arrestMainEdit.ArrestLawbreaker.forEach((item) {
          // print("object2: ${item.PERSON_ID}");
          _id_law_previos.add(item.PERSON_ID);
        });

        _temp_id = _id_law_previos;

        items.forEach((item) {
          _id.add(item.PERSON_ID);
          _arrestMain.ArrestLawbreaker.add(item);
          // print("LAWBREAKER_ID: ${item.LAWBREAKER_ID}");
          // print("PERSON_ID: ${item.PERSON_ID}");
        });

        var _removeDupicate = _id.toSet().toList();
        List ItemsAll = [];
        List ItemsAll1 = [];

        for (int i = 0; i < _removeDupicate.length; i++) {
          for (int j = 0; j < _arrestMain.ArrestLawbreaker.length; j++) {
            if (_removeDupicate[i] == _arrestMain.ArrestLawbreaker[j].PERSON_ID) {
              // print("_removeDupicate: ${_removeDupicate[i]}, ${_arrestMain.ArrestLawbreaker[j].PERSON_ID}");

              ItemsAll.add(_arrestMain.ArrestLawbreaker[j]);
              ItemsAll1.add(_arrestMain.ArrestLawbreaker[j]);
              break;
            }
          }
        }

        _arrestMain.ArrestLawbreaker = ItemsAll;

        for (int i = 0; i < _temp_id.length; i++) {
          //_id_law_previos
          ItemsAll1.removeWhere((item) => item.PERSON_ID == _temp_id[i]);
        }

        list_add_lawbreaker = ItemsAll1;
        // print("object: ${list_add_lawbreaker.length}");
      } else {
        List items = result;
        //List itemsInit = _itemsDataTab4;
        items.forEach((item) {
          _id.add(item.PERSON_ID);
          _itemsDataTab4.add(item);
        });
        var _removeDupicate = _id.toSet().toList();
        print(_removeDupicate);
        List ItemsAll = [];
        for (int i = 0; i < _removeDupicate.length; i++) {
          for (int j = 0; j < _itemsDataTab4.length; j++) {
            if (_removeDupicate[i] == _itemsDataTab4[j].PERSON_ID) {
              ItemsAll.add(_itemsDataTab4[j]);
              break;
            }
          }
        }
        _itemsDataTab4 = ItemsAll;

        // =========================================== SET BEHAVIOR ===========================================
        String textLawsuitBreaker = "";
        // _itemsDataTab4 = ชื่อผู้ต้องหา
        // จำนวนและชื่อของผู้ต้องหา
        textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " + _itemsDataTab4.length.toString() + " คน " + (_itemsDataTab4.length == 0 ? "" : "คือ ");
        _itemsDataTab4.forEach((item) {
          textLawsuitBreaker += item.PERSON_TYPE == 2
              ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.COMPANY_NAME
              : item.PERSON_TYPE == 0
                  ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.FIRST_NAME + " " + item.LAST_NAME + " "
                  : (item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN : item.TITLE_NAME_EN) + item.FIRST_NAME + " " + item.LAST_NAME + " ";
        });
        _tempTextLawsuitBreaker = textLawsuitBreaker;
        setBehavior(textLawsuitBreaker + (_tempEvidenceItem == "" ? "" : (_tempEvidence + _tempEvidenceItem)) + (_itemsInitTab6.length == 0 ? "" : _tempSection));
        // ====================================================================================================
      }
    }
    //_itemsDataTab4.add(item);
  }

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

    setState(() {});
    return true;
  }

  _navigateCreaet(BuildContext mContext, var itemPerson, int index) async {
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
    await onLoadActionCountryMaster(itemPerson);
    Navigator.pop(context);

    if (itemsCountry != null) {
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest4Create(
                  ItemTitle: itemsTitle,
                  ItemCountry: itemsCountry,
                  IsUpdate: true,
                  IsNotice: false,
                  ItemsPerson: itemPerson,
                  ItemsDocument: itemsDocument,
                  Title: itemPerson.PERSON_TYPE == 2
                      ? (itemPerson.TITLE_SHORT_NAME_TH != null ? itemPerson.TITLE_SHORT_NAME_TH.toString() : itemPerson.TITLE_NAME_TH.toString()) + itemPerson.COMPANY_NAME.toString()
                      : itemPerson.PERSON_TYPE == 0
                          ? (itemPerson.TITLE_SHORT_NAME_TH != null ? itemPerson.TITLE_SHORT_NAME_TH.toString() : "") + itemPerson.FIRST_NAME.toString() + " " + itemPerson.LAST_NAME.toString()
                          : (itemPerson.TITLE_SHORT_NAME_EN != null ? itemPerson.TITLE_SHORT_NAME_EN.toString() : "") + itemPerson.FIRST_NAME.toString() + " " + itemPerson.LAST_NAME.toString(),
                )),
      );
      if (result.toString() != "back") {
        print("Return");
        List item = result;
        item.forEach((f) {
          _itemsDataTab4[index] = f;
        });
        //Navigator.pop(context, result);
      }
    }
  }

  Widget _buildContent_tab_4() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: _itemsDataTab4.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: paddingLabel,
                              child: Text(
                                _itemsDataTab4[index].PERSON_TYPE == 2
                                    ? (_itemsDataTab4[index].TITLE_SHORT_NAME_TH != null ? _itemsDataTab4[index].TITLE_SHORT_NAME_TH : _itemsDataTab4[index].TITLE_NAME_TH) + _itemsDataTab4[index].COMPANY_NAME
                                    : _itemsDataTab4[index].PERSON_TYPE == 0
                                        ? (_itemsDataTab4[index].TITLE_SHORT_NAME_TH != null ? _itemsDataTab4[index].TITLE_SHORT_NAME_TH : _itemsDataTab4[index].TITLE_NAME_TH) + _itemsDataTab4[index].FIRST_NAME.toString() + " " + _itemsDataTab4[index].LAST_NAME.toString()
                                        : (_itemsDataTab4[index].TITLE_SHORT_NAME_EN != null ? _itemsDataTab4[index].TITLE_SHORT_NAME_EN : _itemsDataTab4[index].TITLE_NAME_EN) + _itemsDataTab4[index].FIRST_NAME.toString() + " " + _itemsDataTab4[index].LAST_NAME.toString(),
                                style: textInputStyle,
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              _itemsDataTab4[index].IsCreate
                                  ? Container(
                                      padding: EdgeInsets.only(right: 22.0),
                                      child: Center(
                                          child: InkWell(
                                        onTap: () {
                                          _navigateCreaet(context, _itemsDataTab4[index], index);
                                        },
                                        child: Container(
                                            child: Text(
                                          "แก้ไข",
                                          style: textLabelDeleteStyle,
                                        )),
                                      )),
                                    )
                                  : Container(),
                              Center(
                                  child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _showDeleteItemsAlertDialog(index, "Person", _itemsDataTab4[index].IsCreate ? _itemsDataTab4[index].PERSON_ID : null);
                                  });
                                },
                                child: Container(
                                    child: Text(
                                  "ลบ",
                                  style: textLabelDeleteStyle,
                                )),
                              )),
                            ],
                          )
                        ],
                      ),
                      _itemsDataTab4[index].MISTREAT_NO != 0
                          ? Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "จำนวนครั้งการกระทำผิด " + _itemsDataTab4[index].MISTREAT_NO.toString() + " ครั้ง",
                                style: textInputStyleSubCont,
                              ),
                            )
                          : Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "ไม่พบการกระทำผิด",
                                style: textInputStyleSubCont,
                              ),
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: _arrestMain.ArrestLawbreaker.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: paddingLabel,
                              child: Text(
                                _arrestMain.ArrestLawbreaker[index].PERSON_TYPE == 2
                                    ? (_arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_TH != null ? _arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_TH : _arrestMain.ArrestLawbreaker[index].TITLE_NAME_TH) + _arrestMain.ArrestLawbreaker[index].COMPANY_NAME
                                    : _arrestMain.ArrestLawbreaker[index].PERSON_TYPE == 0
                                        ? (_arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_TH != null ? _arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_TH : _arrestMain.ArrestLawbreaker[index].TITLE_NAME_TH) +
                                            _arrestMain.ArrestLawbreaker[index].FIRST_NAME +
                                            " " +
                                            _arrestMain.ArrestLawbreaker[index].LAST_NAME
                                        : (_arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_EN != null ? _arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_EN : _arrestMain.ArrestLawbreaker[index].TITLE_NAME_EN) +
                                            _arrestMain.ArrestLawbreaker[index].FIRST_NAME +
                                            " " +
                                            _arrestMain.ArrestLawbreaker[index].LAST_NAME,
                                style: textInputStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _arrestMain.ArrestLawbreaker[index].MISTREAT_NO != 0
                          ? Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "จำนวนครั้งการกระทำผิด " + _arrestMain.ArrestLawbreaker[index].MISTREAT_NO.toString() + " ครั้ง",
                                style: textInputStyleSubCont,
                              ),
                            )
                          : Padding(
                              padding: paddingInputBox,
                              child: Text(
                                "ยังไม่เคยกระทำผิด",
                                style: textInputStyleSubCont,
                              ),
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    Widget _buildContent_edited(BuildContext context) {
      return Container(
        padding: EdgeInsets.only(bottom: 12.0),
        child: ListView.builder(
          padding: EdgeInsets.only(top: 0),
          itemCount: _arrestMain.ArrestLawbreaker.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return SingleChildScrollView(
              child: Padding(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: paddingLabel,
                              child: Text(
                                _arrestMain.ArrestLawbreaker[index].PERSON_TYPE == 2
                                    ? (_arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_TH != null ? _arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_TH : _arrestMain.ArrestLawbreaker[index].TITLE_NAME_TH) + _arrestMain.ArrestLawbreaker[index].COMPANY_NAME
                                    : _arrestMain.ArrestLawbreaker[index].PERSON_TYPE == 0
                                        ? (_arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_TH != null ? _arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_TH : _arrestMain.ArrestLawbreaker[index].TITLE_NAME_TH) +
                                            _arrestMain.ArrestLawbreaker[index].FIRST_NAME.toString() +
                                            " " +
                                            _arrestMain.ArrestLawbreaker[index].LAST_NAME.toString()
                                        : (_arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_EN != null ? _arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_EN : _arrestMain.ArrestLawbreaker[index].TITLE_NAME_EN) +
                                            _arrestMain.ArrestLawbreaker[index].FIRST_NAME.toString() +
                                            " " +
                                            _arrestMain.ArrestLawbreaker[index].LAST_NAME.toString(),
                                // _arrestMain.ArrestLawbreaker[index].TITLE_SHORT_NAME_TH + _arrestMain.ArrestLawbreaker[index].FIRST_NAME + " " + _arrestMain.ArrestLawbreaker[index].LAST_NAME,
                                style: textInputStyle,
                              ),
                            ),
                          ),
                          _onSaved
                              ? Container()
                              : Row(
                                  children: <Widget>[
                                    _arrestMain.ArrestLawbreaker[index].IsCreate
                                        ? Container(
                                            padding: EdgeInsets.only(right: 22.0),
                                            child: Center(
                                                child: InkWell(
                                              onTap: () {
                                                _navigateCreaet(context, _arrestMain.ArrestLawbreaker[index], index);
                                              },
                                              child: Container(
                                                  child: Text(
                                                "แก้ไข",
                                                style: textLabelDeleteStyle,
                                              )),
                                            )),
                                          )
                                        : Container(),
                                    Center(
                                        child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _showDeleteItemsAlertDialog(index, "PersonUp", _arrestMain.ArrestLawbreaker[index].IsCreate ? _arrestMain.ArrestLawbreaker[index].PERSON_ID : null);
                                        });
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
                      ),
                      Padding(
                        padding: paddingInputBox,
                        child: Text(
                          "จำนวนครั้งการกระทำผิด " + _arrestMain.ArrestLawbreaker[index].MISTREAT_NO.toString() + " ครั้ง",
                          style: textInputStyleSubCont,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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
                  //height: 34.0,
                  // decoration: BoxDecoration(
                  //     //color: Colors.grey[200],
                  //     border: Border(
                  //   top: BorderSide(color: Colors.grey[300], width: 1.0),
                  // )),
                  /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_11_00',
                          style: textStylePageName,),
                      ),
                    ],
                  ),
                  ],
                )*/
                  ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _onSaved ? _buildContent_saved(context) : (_onEdited ? _buildContent_edited(context) : _buildContent()),
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
                      _navigateScreenAddTab4(context);
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

  //************************end_tab_4*****************************

  //************************start_tab_5*****************************
  List itemsProductGroup = [];
  Future<bool> onLoadActionProductGroupMaster() async {
    Map map = {
      "systemId": "WSS",
      "userName": "wss001",
      "password": "123456",
      "ipAddress": "10.1.1.1",
      "requestData": {},
    };
    List<int> _ids = [];
    List _tempItemsProductGroup = [];

    List<ItemsListProductGROUPCategorySRPResponse> _items = [];
    // Map itemOther = {
    //   'PRODUCT_GROUP_ID': "88",
    //   'PRODUCT_GROUP_CODE': "88",
    //   'PRODUCT_GROUP_NAME': "ของอื่น ๆ จากระบบคดี",
    //   'IS_ACTIVE': 1,
    //   'CREATE_DATE': "",
    //   'CREATE_USER_ACCOUNT_ID': "",
    //   'UPDATE_DATE': "",
    //   'UPDATE_USER_ACCOUNT_ID': "",
    //   'GROUP_STATUS': "",
    // };
    await new ArrestFutureMaster().apiRequestInquiryDutyGroup(map).then((onValue) {
      print('Request_InquiryDutyGroup: ${onValue.ResponseMessage}');
      (onValue.ResponseData).forEach((item) {
        if (item.GROUP_STATUS == "N") {
          _tempItemsProductGroup.add(item);
        }
      });
    });
    // _tempItemsProductGroup.add(itemOther);
    itemsProductGroup = _tempItemsProductGroup;
    setState(() {});
    return true;
  }

  //Old
  // Future<bool> onLoadActionProductGroupMaster() async {
  //   Map map = {
  //     "TEXT_SEARCH": "",
  //     //"PRODUCT_GROUP_ID": ""
  //   };
  //   List<int> _ids = [];
  //   List<ItemsListProductGROUPCategory> _items = [];
  //   await new ArrestFutureMaster().apiRequestMasProductGROUPCategoryForLiquorgetByCon(map).then((onValue) {
  //     onValue.forEach((f) {
  //       _ids.add(f.PRODUCT_GROUP_ID);
  //     });
  //     _items = onValue;
  //   });
  //   var distinctIds = _ids.toSet().toList();
  //   List<ItemsListProductGROUPCategory> _items_real = [];
  //   for (int i = 0; i < distinctIds.length; i++) {
  //     for (int j = 0; j < _items.length; j++) {
  //       if (_items[j].PRODUCT_GROUP_ID == 13) {
  //         print(_items[j].PRODUCT_GROUP_NAME);
  //         if (distinctIds[i] == _items[j].PRODUCT_GROUP_ID) {
  //           _items_real.add(_items[j]);
  //         }
  //       } else {
  //         if (distinctIds[i] == _items[j].PRODUCT_GROUP_ID) {
  //           _items_real.add(_items[j]);
  //           break;
  //         }
  //       }
  //     }
  //   }
  //   itemsProductGroup = _items_real;

  //   setState(() {});
  //   return true;
  // }

  List _id_pro_tab_5 = [];
  List _id_pro_previos = [];

  _navigateScreenAddTab5(BuildContext context) async {
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
    await onLoadActionProductGroupMaster();
    Navigator.pop(context);

    if (itemsProductGroup != null) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest5Search(
                  IsNotice: false,
                  IsSearch: true,
                  IsUpdate: false,
                  arrestDate: arrestDate_tab5,
                  ItemsProductGroup: itemsProductGroup,
                )),
      );
      /*final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            TabScreenArrest5Creating(
              IsSearch:true,
              IsUpdate: false,
              ItemsProductGroup: itemsProductGroup,
              itemsMasProductSize: widget.itemsMasProductSize,
              itemsMasProductUnit: widget.itemsMasProductUnit,
            )),
      );*/
      if (result.toString() != "back") {
        if (_onEdited) {
          /*List items = result;
          _arrestMain.ArrestProduct.forEach((item){
            if(item.PRODUCT_MAPPING_ID!=null){
              _id_pro.add(item.PRODUCT_MAPPING_ID);
              _id_pro_previos.add(item.PRODUCT_MAPPING_ID);
            }
          });
          items.forEach((item){
            if(item.PRODUCT_MAPPING_ID!=null){
              _id_pro.add(item.PRODUCT_MAPPING_ID);
              _arrestMain.ArrestProduct.add(item);
            }
          });
          //print("AA : "+_id_pro_previos.length.toString());
          var _removeDupicate = _id_pro.toSet().toList();
          List ItemsAll=[];
          List ItemsAll1=[];
          for(int i=0;i<_removeDupicate.length;i++){
            for(int j=0;j<  _arrestMain.ArrestProduct.length;j++){
              if(_removeDupicate[i] ==  _arrestMain.ArrestProduct[j].PRODUCT_MAPPING_ID){
                ItemsAll.add(  _arrestMain.ArrestProduct[j]);
                ItemsAll1.add(  _arrestMain.ArrestProduct[j]);
                break;
              }
            }
          }
          _arrestMain.ArrestProduct = ItemsAll;
          for(int i=0;i<_id_pro_previos.length;i++){
            ItemsAll1.removeWhere((item) => item.PRODUCT_MAPPING_ID == _id_pro_previos[i]);
          }
          list_add_product=ItemsAll1;
          items.forEach((item){
            _arrestMain.ArrestProduct.add(item);
            list_add_product.add(item);
          });*/

          ItemsListArrest5Test itm = result;
          itm.ItemsListArrest5Mas.forEach((item) {
            _arrestMain.ArrestProduct.add(item);
            list_add_product.add(item);
          });
          itm.ItemsListArrest5Ops.forEach((item) {
            _itemsDataTab5OpsSaved.add(item);
          });
        } else {
          ItemsListArrest5Test itm = result;
          itm.ItemsListArrest5Mas.forEach((item) {
            _id_pro_tab_5.add(item.PRODUCT_CODE);
            print("id: $_id_pro_tab_5");
            _itemsDataTab5.add(item);
          });
          itm.ItemsListArrest5Ops.forEach((item) {
            _itemsDataTab5Ops.add(item);
          });

          // ส่วนเช็คว่ามีข้อมูลตัวไหนที่ user กดเข้ามาแล้วซ้ำกัน
          var _removeDupicate = _id_pro_tab_5.toSet().toList();
          List ItemsAll = [];
          for (int i = 0; i < _removeDupicate.length; i++) {
            for (int j = 0; j < _itemsDataTab5.length; j++) {
              if (_removeDupicate[i] == _itemsDataTab5[j].PRODUCT_CODE) {
                ItemsAll.add(_itemsDataTab5[j]);
                break;
              }
            }
          }
          print(_id_pro_tab_5.toString());
          _itemsDataTab5 = ItemsAll;

          // ====================================== SET BEHAVIOR ======================================
          String EvidenceItem = "";
          // _itemsDataTab5 = name of evidence

          int index_pro = 0;
          _itemsDataTab5.forEach((f) {
            index_pro++;
            EvidenceItem += f.PRODUCT_DESC.toString() + (index_pro != _itemsDataTab5.length ? ", " : " ");
          });
          _tempEvidenceItem = EvidenceItem;
          setBehavior(_tempTextLawsuitBreaker + (EvidenceItem == "" ? "" : (_tempEvidence + EvidenceItem)) + (_itemsInitTab6.length == 0 ? "" : _tempSection));
          // ==========================================================================================

          /*List items = result;
          print(result.toString());
          items.forEach((item){
            */ /*if(item.PRODUCT_MAPPING_ID!=null){
              _id_pro.add(item.PRODUCT_MAPPING_ID);
            }*/ /*
            _itemsDataTab5.add(item);
          });*/
          /*var _removeDupicate = _id_pro.toSet().toList();
          List ItemsAll=[];
          for(int i=0;i<_removeDupicate.length;i++){
            for(int j=0;j<_itemsDataTab5.length;j++){
              if(_removeDupicate[i]==_itemsDataTab5[j].PRODUCT_MAPPING_ID){
                ItemsAll.add(_itemsDataTab5[j]);
                break;
              }
            }
          }
          _itemsDataTab5 = ItemsAll;*/
        }
      }
    }
  }

  _navigateScreenEditTab5(BuildContext context, var itemsProduct, int index) async {
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
    await onLoadActionProductGroupMaster();
    Navigator.pop(context);

    if (itemsProductGroup != null) {
      List items = [];
      items.add(itemsProduct);
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest5Edit(
                  IsNotice: false,
                  ItemsData: items,
                  itemsMasProductUnit: widget.itemsMasProductUnit,
                  itemsMasProductSize: widget.itemsMasProductSize,
                )),
      );

      if (result.toString() != "back") {
        if (_onEdited) {
          ItemsListArrest5Test itm = result;
          itm.ItemsListArrest5Mas.forEach((item) {
            item.PRODUCT_ID = _arrestMain.ArrestProduct[index].PRODUCT_ID;
            list_update_product.add(item);
            _arrestMain.ArrestProduct[index] = item;

            _arrestMain.ArrestIndictment.forEach((item) {
              item.ArrestIndictmentProduct.forEach((item) {
                if (_arrestMain.ArrestProduct[index].PRODUCT_ID == item.PRODUCT_ID) {
                  list_update_indicment_pro.add(item);
                  print("Matced : " + item.PRODUCT_INDICTMENT_ID.toString());
                }
              });
            });
          });

          itm.ItemsListArrest5Ops.forEach((item) {
            item.PRODUCT_ID = _arrestMain.ArrestProduct[index].PRODUCT_ID;
            list_update_product.add(item);
            _itemsDataTab5OpsSaved[index] = item;

            _arrestMain.ArrestIndictment.forEach((item) {
              item.ArrestIndictmentProduct.forEach((item) {
                if (_itemsDataTab5OpsSaved[index].PRODUCT_ID == item.PRODUCT_ID) {
                  list_update_indicment_pro.add(item);
                  print("Matced : " + item.PRODUCT_INDICTMENT_ID.toString());
                }
              });
            });
          });

          /*List items = result;
          items.forEach((item) {
            item.PRODUCT_ID = _arrestMain.ArrestProduct[index].PRODUCT_ID;
            list_update_product.add(item);
            _arrestMain.ArrestProduct[index] = item;

            _arrestMain.ArrestIndictment.forEach((item) {
              item.ArrestIndictmentProduct.forEach((item) {
                if(_arrestMain.ArrestProduct[index].PRODUCT_ID==item.PRODUCT_ID){
                  list_update_indicment_pro.add(item);
                  print("Matced : "+item.PRODUCT_INDICTMENT_ID.toString());
                }
              });
            });
          });*/
        } else {
          /*List items = result;
          print(index.toString() + " , " + items.toString());
          items.forEach((item) {
            _itemsDataTab5[index] = item;
          });*/
          ItemsListArrest5Test itm = result;
          itm.ItemsListArrest5Mas.forEach((item) {
            _itemsDataTab5[index] = item;
          });
          itm.ItemsListArrest5Ops.forEach((item) {
            _itemsDataTab5Ops[index] = item;
          });
        }
      }
    }
  }

  Widget _buildContent_tab_5() {
    Widget _buildContent() {
      var size = MediaQuery.of(context).size;
      return ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemCount: _itemsDataTab5.length,
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
                            "ชื่อของกลาง",
                            style: textLabelStyle,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: paddingInputBox,
                                child: Text(
                                  (index + 1).toString() + ". " + _itemsDataTab5[index].PRODUCT_DESC.toString() + (_itemsDataTab5[index].REMARK != null ? (_itemsDataTab5[index].REMARK.toString().isNotEmpty ? " (" + _itemsDataTab5[index].REMARK.toString() + ")" : "") : ""),
                                  style: textInputStyle,
                                ),
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
                                    child: Text(
                                      "ขนาด",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].SIZES != null ? (_itemsDataTab5[index].PRODUCT_GROUP_ID == 13 || _itemsDataTab5[index].PRODUCT_GROUP_ID == 2 ? formatter_product : formatter).format(_itemsDataTab5[index].SIZES).toString() : "",
                                      style: textInputStyle,
                                    ),
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
                                      "หน่วย",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].SIZES_UNIT.toString(),
                                      style: textInputStyle,
                                    ),
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
                                    child: Text(
                                      "จำนวน",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      (_itemsDataTab5[index].QUANTITY.toInt()).toString(),
                                      style: textInputStyle,
                                    ),
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
                                      "หน่วย",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].QUANTITY_UNIT.toString(),
                                      style: textInputStyle,
                                    ),
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
                                    child: Text(
                                      "ปริมาณสุทธิ",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].VOLUMN != null ? (_itemsDataTab5[index].PRODUCT_GROUP_ID == 13 || _itemsDataTab5[index].PRODUCT_GROUP_ID == 2 ? formatter_product : formatter).format(_itemsDataTab5[index].VOLUMN).toString() : "",
                                      style: textInputStyle,
                                    ),
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
                                      "หน่วย",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _itemsDataTab5[index].VOLUMN_UNIT.toString(),
                                      style: textInputStyle,
                                    ),
                                  ),
                                ],
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
                                    _navigateScreenEditTab5(context, _itemsDataTab5[index], index);
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
                                    setState(() {
                                      _showDeleteItemsAlertDialog(index, "Product", null);
                                    });
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
      );
    }

    Widget _buildContent_saved(BuildContext context) {
      var size = MediaQuery.of(context).size;
      return ListView.builder(
        padding: EdgeInsets.only(top: 0),
        itemCount: _arrestMain.ArrestProduct.length,
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
                            "ชื่อของกลาง",
                            style: textLabelStyle,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: paddingInputBox,
                                child: Text(
                                  (index + 1).toString() +
                                      ". " +
                                      _arrestMain.ArrestProduct[index].PRODUCT_DESC.toString() +
                                      (_arrestMain.ArrestProduct[index].REMARK != null ? (_arrestMain.ArrestProduct[index].REMARK.toString().isNotEmpty ? " (" + _arrestMain.ArrestProduct[index].REMARK.toString() + ")" : "") : ""),
                                  style: textInputStyle,
                                ),
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
                                    child: Text(
                                      "ขนาด",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      (_arrestMain.ArrestProduct[index].PRODUCT_GROUP_ID == 13 || _arrestMain.ArrestProduct[index].PRODUCT_GROUP_ID == 2 ? formatter_product : formatter).format(_arrestMain.ArrestProduct[index].SIZES).toString(),
                                      style: textInputStyle,
                                    ),
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
                                      "หน่วย",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _arrestMain.ArrestProduct[index].SIZES_UNIT != null ? _arrestMain.ArrestProduct[index].SIZES_UNIT : "",
                                      style: textInputStyle,
                                    ),
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
                                    child: Text(
                                      "จำนวน",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      (_arrestMain.ArrestProduct[index].QUANTITY.toInt()).toString(),
                                      style: textInputStyle,
                                    ),
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
                                      "หน่วย",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _arrestMain.ArrestProduct[index].QUANTITY_UNIT != null ? _arrestMain.ArrestProduct[index].QUANTITY_UNIT : "",
                                      style: textInputStyle,
                                    ),
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
                                    child: Text(
                                      "ปริมาณสุทธิ",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      (_arrestMain.ArrestProduct[index].PRODUCT_GROUP_ID == 13 || _arrestMain.ArrestProduct[index].PRODUCT_GROUP_ID == 2 ? formatter_product : formatter).format(_arrestMain.ArrestProduct[index].VOLUMN).toString(),
                                      style: textInputStyle,
                                    ),
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
                                      "หน่วย",
                                      style: textLabelStyle,
                                    ),
                                  ),
                                  Container(
                                    padding: paddingLabel,
                                    child: Text(
                                      _arrestMain.ArrestProduct[index].VOLUMN_UNIT != null ? _arrestMain.ArrestProduct[index].VOLUMN_UNIT : "",
                                      style: textInputStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    _onSaved
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(bottom: 12.0, top: 12.0, right: 24.0),
                                      child: InkWell(
                                        onTap: () {
                                          _navigateScreenEditTab5(context, _arrestMain.ArrestProduct[index], index);
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
                                          setState(() {
                                            _showDeleteItemsAlertDialog(index, "ProductUp", null);
                                          });
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
                  //height: 34.0,
                  // decoration: BoxDecoration(
                  //     //color: Colors.grey[200],
                  //     border: Border(
                  //   top: BorderSide(color: Colors.grey[300], width: 1.0),
                  // )),
                  /*child: Column(
                    children: <Widget>[Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: new Text('ILG60_B_01_00_19_00',
                            style: textStylePageName,),
                        ),
                      ],
                    ),
                    ],
                  )*/
                  ),
              Expanded(
                child: new ConstrainedBox(
                  constraints: const BoxConstraints.expand(),
                  child: _onSaved || _onEdited ? _buildContent_saved(context) : _buildContent(),
                ),
              ),
            ],
          ),
        ),
        _onSaved
            ? Container()
            : Align(
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
      ],
    );
  }

  //************************start_tab_6*****************************
  _navigateSearchSelection(
    BuildContext context,
    List ItemLawbreaker,
    List ItemProduct,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest6Search(
                ItemsLawbreaker: ItemLawbreaker,
                ItemsProduct: ItemProduct,
                IsUpdate: false,
              )),
    );

    if (result.toString() != "back") {
      if (_onEdited) {
        var items = result;
        _arrestMain.ArrestIndictment.add(items);
        list_add_indicment.add(items);

        // // =========================================== SET BEHAVIOR ===========================================
        // String textLawsuitBreaker = "";
        // String EvidenceItem = "";
        // String Section = "";

        // print("this is edit");
        // if (_arrestMain.ArrestIndictment.length > 0) {
        //   int index_pro = 0;
        //   _arrestMain.ArrestProduct.forEach((f) {
        //     index_pro++;
        //     EvidenceItem += f.PRODUCT_DESC.toString() + (index_pro != _arrestMain.ArrestProduct.length ? ", " : " ");
        //   });
        //   _tempEvidenceItem = EvidenceItem;

        //   textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " + _arrestMain.ArrestLawbreaker.length.toString() + " คน " + (_arrestMain.ArrestLawbreaker.length == 0 ? "" : "คือ ");
        //   //รายการผู้ต้องหา
        //   _arrestMain.ArrestLawbreaker.forEach((item) {
        //     textLawsuitBreaker += item.PERSON_TYPE == 2
        //         ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.COMPANY_NAME
        //         : item.PERSON_TYPE == 0
        //             ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.FIRST_NAME + " " + item.LAST_NAME + " "
        //             : (item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN : item.TITLE_NAME_EN) + item.FIRST_NAME + " " + item.LAST_NAME + " ";
        //   });
        //   _tempTextLawsuitBreaker = textLawsuitBreaker;

        //   Section = "ในข้อกล่าวหา ";
        //   int index_sec = 0;
        //   _arrestMain.ArrestIndictment.forEach((item) {
        //     index_sec++;
        //     Section += (item.ArrestIndictmentDetail.length > 1 ? "ร่วมกัน" : "") + item.GUILTBASE_NAME + (index_sec != _itemsInitTab6.length ? ", " : " ");
        //   });
        //   _tempSection = Section;
        //   setBehavior(textLawsuitBreaker + (EvidenceItem == "" ? "" : (_tempEvidence + EvidenceItem)) + Section);
        //   // ====================================================================================================
        // }
      } else {
        print(result.toString());
        //_itemsDataTab5 = result;

        setState(() {
          IsSelected_tab6 = true;
          ItemsListArrest6Section item = result;
          _itemsInitTab6.add(item);

          String textLawsuitBreaker = "";
          String EvidenceItem = "";
          String Section = "";
          int counts = 0;

          if (_itemsInitTab6.length > 0) {
            //จำนวนผู้ต้องหา
            counts = _itemsDataTab4.length;

            // =========================================== SET BEHAVIOR ===========================================
            textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " + counts.toString() + " คน " + (counts == 0 ? "" : "คือ ");
            //list evidence
            int index_pro = 0;
            _itemsDataTab5.forEach((f) {
              index_pro++;
              EvidenceItem += f.PRODUCT_DESC.toString() + (index_pro != _itemsDataTab5.length ? ", " : " ");
            });
            _tempEvidenceItem = EvidenceItem;
            //list suspect
            _itemsDataTab4.forEach((item) {
              textLawsuitBreaker += item.PERSON_TYPE == 2
                  ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.COMPANY_NAME
                  : item.PERSON_TYPE == 0
                      ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.FIRST_NAME + " " + item.LAST_NAME + " "
                      : (item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN : item.TITLE_NAME_EN) + item.FIRST_NAME + " " + item.LAST_NAME + " ";
            });
            _tempTextLawsuitBreaker = textLawsuitBreaker;

            Section = "ในข้อกล่าวหา ";
            int index_sec = 0;
            _itemsInitTab6.forEach((item) {
              index_sec++;
              Section += (item.ArrestIndictmentDetail.length > 1 ? "ร่วมกัน" : "") + item.GUILTBASE_NAME + (index_sec != _itemsInitTab6.length ? ", " : " ");
            });
            _tempSection = Section;
            setBehavior(textLawsuitBreaker + (EvidenceItem == "" ? "" : (_tempEvidence + EvidenceItem)) + Section);
          }
          // ====================================================================================================
        });
      }
    }
  }

  _navigateSearchSelectionEdit(BuildContext context, index, itemLawbreaker, itemsProduct) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest6Search(
                ItemsLawbreaker: itemLawbreaker,
                ItemsProduct: itemsProduct,
                IsUpdate: true,
              )),
    );

    if (result.toString() != "back") {
      setState(() {
        if (_onEdited) {
          print("onEdit");
          print("onEdit: $result");

          var item = result;
          List _userNotChooseAgain = [];
          List _userChoose = [];
          List _tempLawReal = [];
          List _tempLawResult = [];
          List _tempChooseIndicmentID = [];
          List _tempUpdateIndicment = [];

          // ========================== Check people that user not choose again ===========================
          _tempIndictmentEdit[index].ArrestIndictmentDetail.forEach((f) {
            _tempLawReal.add(f.LAWBREAKER_ID);
          });
          (item.ArrestIndictmentDetail).forEach((itemResult) {
            _tempLawResult.add(itemResult.LAWBREAKER_ID);
          });
          // print("item _tempLawReal: ${_tempLawReal.toString()}");
          // print("item _tempLawResult: ${_tempLawResult.toString()}");

          _tempLawReal.where((i) => !_tempLawResult.contains(i)).map((obj) {
            _userNotChooseAgain.add(obj);
          }).toList();
          _tempLawReal.where((i) => _tempLawResult.contains(i)).map((obj) {
            _userChoose.add(obj);
          }).toList();
          // print("item _userNotChooseAgain: ${_userNotChooseAgain.toString()}");
          // print("item _userChoose: ${_userChoose.toString()}");
          if (_userChoose.length > 0) {
            _tempIndictmentEdit[index].ArrestIndictmentDetail.forEach((itemMain) {
              _userChoose.forEach((fChoose) {
                if (fChoose == itemMain.LAWBREAKER_ID) {
                  _tempChooseIndicmentID.add(itemMain.INDICTMENT_DETAIL_ID);
                }
              });
              _tempChooseIndicmentID.where((i) => list_delete_indicment_delt.contains(i)).map((obj) {
                list_delete_indicment_delt.removeWhere((item) => item == obj);
              }).toList();
            });
          }
          if (_userNotChooseAgain.length > 0) {
            _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.forEach((itemMain) {
              _userNotChooseAgain.forEach((f) {
                if (f == itemMain.LAWBREAKER_ID) {
                  list_delete_indicment_delt.add(itemMain.INDICTMENT_DETAIL_ID);
                  print("item delete: ${itemMain.INDICTMENT_DETAIL_ID.toString()}");
                }
              });
            });
          }
          print("item after2: ${list_delete_indicment_delt.toString()}");

          // ==============================================================================================
          // if (item.INDICTMENT_ID == _arrestMain.ArrestIndictment[index].INDICTMENT_ID) {
          // ========================== Add old INDICTMENT_DETAIL_ID to new items =========================
          item.ArrestIndictmentDetail.forEach((i) {
            (_tempIndictmentEdit[index].ArrestIndictmentDetail).forEach((f2) {
              // print('old : ${i.LAWBREAKER_ID.toString()}');
              // print('new : ${f2.LAWBREAKER_ID.toString()}');
              if ((i.LAWBREAKER_ID != null) && (f2.LAWBREAKER_ID != null)) {
                if (i.LAWBREAKER_ID == f2.LAWBREAKER_ID) {
                  i.INDICTMENT_DETAIL_ID = f2.INDICTMENT_DETAIL_ID;
                  // print("Have same INDICTMENT_DETAIL_ID ::: ${i.INDICTMENT_DETAIL_ID}");
                }
              }
            });
          });
          _tempOldGuiltBaseID = _arrestMain.ArrestIndictment[index].GUILTBASE_ID;
          // ==============================================================================================
          item.INDICTMENT_ID = _arrestMain.ArrestIndictment[index].INDICTMENT_ID;
          _arrestMain.ArrestIndictment[index] = item;

          list_update_indicment.removeWhere((item) => item.INDICTMENT_ID == _arrestMain.ArrestIndictment[index].INDICTMENT_ID);
          list_update_indicment.add(_arrestMain.ArrestIndictment[index]);
          print("length: ${list_update_indicment.length}");
          // // ==============================================================================================
          // // =========================================== SET BEHAVIOR ===========================================
          // String textLawsuitBreaker = "";
          // String EvidenceItem = "";
          // String Section = "";
          // if (_arrestMain.ArrestIndictment.length > 0) {
          //   textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " + _arrestMain.ArrestLawbreaker.length.toString() + " คน " + (_arrestMain.ArrestLawbreaker.length == 0 ? "" : "คือ ");
          //   Section = "ในข้อกล่าวหา ";
          //   // list evidence
          //   int index_pro = 0;
          //   _arrestMain.ArrestProduct.forEach((f) {
          //     index_pro++;
          //     EvidenceItem += f.PRODUCT_DESC.toString() + (index_pro != _arrestMain.ArrestProduct.length ? ", " : " ");
          //   });
          //   _tempEvidenceItem = EvidenceItem;
          //   //รายการผู้ต้องหา
          //   _arrestMain.ArrestLawbreaker.forEach((item) {
          //     textLawsuitBreaker += item.PERSON_TYPE == 2
          //         ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.COMPANY_NAME
          //         : item.PERSON_TYPE == 0
          //             ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.FIRST_NAME + " " + item.LAST_NAME + " "
          //             : (item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN : item.TITLE_NAME_EN) + item.FIRST_NAME + " " + item.LAST_NAME + " ";
          //   });
          //   _tempTextLawsuitBreaker = textLawsuitBreaker;

          //   int index_sec = 0;
          //   _arrestMain.ArrestIndictment.forEach((item) {
          //     index_sec++;
          //     Section += (item.ArrestIndictmentDetail.length > 1 ? "ร่วมกัน" : "") + item.GUILTBASE_NAME + (index_sec != _itemsInitTab6.length ? ", " : " ");
          //   });
          //   _tempSection = Section;
          //   setBehavior(textLawsuitBreaker + (EvidenceItem == "" ? "" : (_tempEvidence + EvidenceItem)) + Section);
          // }
          // // ====================================================================================================
        } else {
          IsSelected_tab6 = true;
          var item = result;
          _itemsInitTab6[index] = item;

          // =========================================== SET BEHAVIOR ===========================================
          //String textLawsuitBreaker = "";
          //String EvidenceItem = "";
          String Section = "";
          if (_itemsInitTab6.length > 0) {
            /*textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " + _itemsDataTab4.length.toString() + " คน " + (_itemsDataTab4.length == 0 ? "" : "คือ ");
            //จำนวนและรายการของกลาง
            int index_pro = 0;
            _itemsDataTab5.forEach((f) {
              index_pro++;
              EvidenceItem += f.PRODUCT_DESC.toString() + (index_pro != _itemsDataTab5.length ? ", " : " ");
            });
            _tempEvidenceItem = EvidenceItem;
            //รายการผู้ต้องหา
            _itemsDataTab4.forEach((item) {
              textLawsuitBreaker += item.PERSON_TYPE == 2
                  ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.COMPANY_NAME
                  : item.PERSON_TYPE == 0
                      ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.FIRST_NAME + " " + item.LAST_NAME + " "
                      : (item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN : item.TITLE_NAME_EN) + item.FIRST_NAME + " " + item.LAST_NAME + " ";
            });
            _tempTextLawsuitBreaker = textLawsuitBreaker;
            */
            Section = "ในข้อกล่าวหา ";
            int index_sec = 0;
            _itemsInitTab6.forEach((item) {
              index_sec++;
              Section += (item.ArrestIndictmentDetail.length > 1 ? "ร่วมกัน" : "") + item.GUILTBASE_NAME + (index_sec != _itemsInitTab6.length ? ", " : " ");
            });
            _tempSection = Section;
            setBehavior(_tempTextLawsuitBreaker + (_tempEvidenceItem == "" ? "" : (_tempEvidence + _tempEvidenceItem)) + Section);
            // ====================================================================================================
          }
        }
      });
    }
  }

  Widget _buildContent_tab_6() {
    Widget _buildContent() {
      buildCollapsed(index) {
        String suspect = "";
        String subSuspect = "";
        if (_itemsInitTab6[index].ArrestIndictmentDetail.length > 0) {
          //suspect = _itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_TH + _itemsInitTab6[index].ArrestIndictmentDetail[0].FIRST_NAME + " " + _itemsInitTab6[index].ArrestIndictmentDetail[0].LAST_NAME;
          suspect = _itemsInitTab6[index].ArrestIndictmentDetail[0].PERSON_TYPE == 0
              ? (_itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_TH != null ? _itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_TH.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_NAME_TH.toString()) +
                  " " +
                  _itemsInitTab6[index].ArrestIndictmentDetail[0].FIRST_NAME +
                  " " +
                  _itemsInitTab6[index].ArrestIndictmentDetail[0].LAST_NAME
              : _itemsInitTab6[index].ArrestIndictmentDetail[0].PERSON_TYPE == 1
                  ? (_itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_EN != null ? _itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_EN.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_NAME_EN.toString()) +
                      " " +
                      _itemsInitTab6[index].ArrestIndictmentDetail[0].FIRST_NAME +
                      " " +
                      _itemsInitTab6[index].ArrestIndictmentDetail[0].LAST_NAME
                  : (_itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_TH != null ? _itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_TH.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[0].TITLE_NAME_TH.toString()) +
                      _itemsInitTab6[index].ArrestIndictmentDetail[0].COMPANY_NAME.toString();
          if (_itemsInitTab6[index].ArrestIndictmentDetail.length == 2) {
            //subSuspect += _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH + _itemsInitTab6[index].ArrestIndictmentDetail[1].FIRST_NAME + " " + _itemsInitTab6[index].ArrestIndictmentDetail[1].LAST_NAME;
            subSuspect += _itemsInitTab6[index].ArrestIndictmentDetail[1].PERSON_TYPE == 0
                ? (_itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH != null ? _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_NAME_TH.toString()) +
                    " " +
                    _itemsInitTab6[index].ArrestIndictmentDetail[1].FIRST_NAME +
                    " " +
                    _itemsInitTab6[index].ArrestIndictmentDetail[1].LAST_NAME
                : _itemsInitTab6[index].ArrestIndictmentDetail[1].PERSON_TYPE == 1
                    ? (_itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_EN != null ? _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_EN.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_NAME_EN.toString()) +
                        " " +
                        _itemsInitTab6[index].ArrestIndictmentDetail[1].FIRST_NAME +
                        " " +
                        _itemsInitTab6[index].ArrestIndictmentDetail[1].LAST_NAME
                    : (_itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH != null ? _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_NAME_TH.toString()) +
                        _itemsInitTab6[index].ArrestIndictmentDetail[1].COMPANY_NAME.toString();
          } else if (_itemsInitTab6[index].ArrestIndictmentDetail.length > 2) {
            subSuspect += (_itemsInitTab6[index].ArrestIndictmentDetail[1].PERSON_TYPE == 0
                    ? (_itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH != null ? _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_NAME_TH.toString()) +
                        " " +
                        _itemsInitTab6[index].ArrestIndictmentDetail[1].FIRST_NAME +
                        " " +
                        _itemsInitTab6[index].ArrestIndictmentDetail[1].LAST_NAME
                    : _itemsInitTab6[index].ArrestIndictmentDetail[1].PERSON_TYPE == 1
                        ? (_itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_EN != null ? _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_EN.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_NAME_EN.toString()) +
                            " " +
                            _itemsInitTab6[index].ArrestIndictmentDetail[1].FIRST_NAME +
                            " " +
                            _itemsInitTab6[index].ArrestIndictmentDetail[1].LAST_NAME
                        : (_itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH != null ? _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[1].TITLE_NAME_TH.toString()) +
                            _itemsInitTab6[index].ArrestIndictmentDetail[1].COMPANY_NAME.toString()) +
                " และคนอื่นๆ " +
                (_itemsInitTab6[index].ArrestIndictmentDetail.length - 2).toString() +
                " คน";
          }
        } else {
          suspect = "-";
        }

        return Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: paddingInputBox,
                      child: Text(
                        "มาตรา " + _itemsInitTab6[index].SUBSECTION_NAME,
                        style: textDataTitleStyle,
                      ),
                    ),
                  ),
                  IsSelected_tab6
                      ? Column(
                          children: <Widget>[
                            Center(
                                child: InkWell(
                              onTap: () {
                                //set checked suspect
                                _itemsInitTab6[index].ArrestIndictmentDetail.forEach((f) {
                                  for (int i = 0; i < _itemsInitTab6[index].ArrestIndictmentDetail.length; i++) {
                                    if (f.LAWBREAKER_ID == _itemsInitTab6[index].ArrestIndictmentDetail[i].LAWBREAKER_ID) {
                                      _itemsInitTab6[index].ArrestIndictmentDetail[i].IsCheckOffence = true;
                                      break;
                                    }
                                  }
                                });
                                //set checked items
                                _itemsInitTab6[index].ArrestIndictmentProduct.forEach((f) {
                                  for (int i = 0; i < _itemsInitTab6[index].ArrestIndictmentProduct.length; i++) {
                                    if (f.PRODUCT_ID == _itemsInitTab6[index].ArrestIndictmentProduct[i].PRODUCT_ID) {
                                      _itemsInitTab6[index].ArrestIndictmentProduct[i].IsCheckOffence = true;
                                      break;
                                    }
                                  }
                                });
                                _navigateSearchSelectionEdit(
                                    context,
                                    index,
                                    /*_itemsInitTab6[index].ArrestIndictmentDetail*/
                                    _itemsDataTab4,
                                    _itemsInitTab6[index].ArrestIndictmentProduct);
                              },
                              child: Container(
                                  child: Text(
                                "แก้ไข",
                                style: textLabelDeleteStyle,
                              )),
                            )),
                          ],
                        )
                      : Container()
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  !IsSelected_tab6
                      ? Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[300],
                          size: 18,
                        )
                      : Container(),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: paddingInputBox,
                      child: Text(
                        (_itemsInitTab6[index].ArrestIndictmentDetail.length > 1 ? "ร่วมกัน" : "") + _itemsInitTab6[index].GUILTBASE_NAME,
                        style: textDataStyleSub,
                      ),
                    ),
                  ),
                  IsSelected_tab6
                      ? Center(
                          child: InkWell(
                          onTap: () {
                            _showDeleteItemsAlertDialog(index, "Indicment", null);
                          },
                          child: Container(
                              child: Text(
                            "ลบ",
                            style: textLabelDeleteStyle,
                          )),
                        ))
                      : Container(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ผู้ต้องหา",
                      style: textLabelStyle,
                    ),
                  ),
                  Container(
                    padding: paddingInputBox,
                    child: Text(
                      suspect,
                      style: textDataStyle,
                    ),
                  ),
                  _itemsInitTab6[index].ArrestIndictmentDetail.length > 1
                      ? Container(
                          padding: paddingInputBox,
                          child: Text(
                            subSuspect,
                            style: textDataSubStyle,
                          ),
                        )
                      : Container(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ของกลาง ",
                      style: textLabelStyle,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      _itemsInitTab6[index].ArrestIndictmentProduct.length > 0 ? _itemsInitTab6[index].ArrestIndictmentProduct.length.toString() + " รายการ" : "-",
                      style: textDataSubStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }

      buildExpanded(index) {
        var size = MediaQuery.of(context).size;
        return Padding(
          padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: paddingInputBox,
                      child: Text(
                        "มาตรา " + _itemsInitTab6[index].SUBSECTION_NAME,
                        style: textDataTitleStyle,
                      ),
                    ),
                  ),
                  IsSelected_tab6
                      ? Column(
                          children: <Widget>[
                            Center(
                                child: InkWell(
                              onTap: () {
                                //set checked suspect
                                _itemsInitTab6[index].ArrestIndictmentDetail.forEach((f) {
                                  for (int i = 0; i < _itemsInitTab6[index].ArrestIndictmentDetail.length; i++) {
                                    if (f.LAWBREAKER_ID == _itemsInitTab6[index].ArrestIndictmentDetail[i].LAWBREAKER_ID) {
                                      _itemsInitTab6[index].ArrestIndictmentDetail[i].IsCheckOffence = true;
                                      break;
                                    }
                                  }
                                });
                                //set checked items
                                _itemsInitTab6[index].ArrestIndictmentProduct.forEach((f) {
                                  for (int i = 0; i < _itemsInitTab6[index].ArrestIndictmentProduct.length; i++) {
                                    if (f.PRODUCT_ID == _itemsInitTab6[index].ArrestIndictmentProduct[i].PRODUCT_ID) {
                                      _itemsInitTab6[index].ArrestIndictmentProduct[i].IsCheckOffence = true;
                                      break;
                                    }
                                  }
                                });
                                _navigateSearchSelectionEdit(
                                    context,
                                    index,
                                    /*_itemsInitTab6[index].ArrestIndictmentDetail*/
                                    _itemsDataTab4,
                                    _itemsInitTab6[index].ArrestIndictmentProduct);
                              },
                              child: Container(
                                  child: Text(
                                "แก้ไข",
                                style: textLabelDeleteStyle,
                              )),
                            )),
                          ],
                        )
                      : Container()
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: paddingInputBox,
                      child: Text(
                        _itemsInitTab6[index].GUILTBASE_NAME,
                        style: textDataStyleSub,
                      ),
                    ),
                  ),
                  IsSelected_tab6
                      ? Center(
                          child: InkWell(
                          onTap: () {
                            _showDeleteItemsAlertDialog(index, "Indicment", null);
                          },
                          child: Container(
                              child: Text(
                            "ลบ",
                            style: textLabelDeleteStyle,
                          )),
                        ))
                      : Container(),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ผู้ต้องหา",
                      style: textLabelStyle,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // new
                        itemCount: _itemsInitTab6[index].ArrestIndictmentDetail.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int j) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: paddingInputBox,
                                child: Text(
                                  // (j + 1).toString() + ". " + _itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH + _itemsInitTab6[index].ArrestIndictmentDetail[j].FIRST_NAME + " " + _itemsInitTab6[index].ArrestIndictmentDetail[j].LAST_NAME,
                                  _itemsInitTab6[index].ArrestIndictmentDetail.length > 0
                                      ? (j + 1).toString() +
                                          ". " +
                                          (_itemsInitTab6[index].ArrestIndictmentDetail[j].PERSON_TYPE == 0
                                              ? (_itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH != null ? _itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_NAME_TH.toString()) +
                                                  " " +
                                                  _itemsInitTab6[index].ArrestIndictmentDetail[j].FIRST_NAME +
                                                  " " +
                                                  _itemsInitTab6[index].ArrestIndictmentDetail[j].LAST_NAME
                                              : _itemsInitTab6[index].ArrestIndictmentDetail[j].PERSON_TYPE == 1
                                                  ? (_itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_EN != null ? _itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_EN.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_NAME_EN.toString()) +
                                                      " " +
                                                      _itemsInitTab6[index].ArrestIndictmentDetail[j].FIRST_NAME +
                                                      " " +
                                                      _itemsInitTab6[index].ArrestIndictmentDetail[j].LAST_NAME
                                                  : (_itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH != null ? _itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH.toString() : _itemsInitTab6[index].ArrestIndictmentDetail[j].TITLE_NAME_TH.toString()) +
                                                      _itemsInitTab6[index].ArrestIndictmentDetail[j].COMPANY_NAME.toString())
                                      : "-",
                                  style: textDataStyle,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ของกลาง",
                      style: textLabelStyle,
                    ),
                  ),
                  Container(
                    padding: paddingLabel,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        // new
                        itemCount: _itemsInitTab6[index].ArrestIndictmentProduct.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int j) {
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
                                              ItemsProductEdit: _itemsInitTab6[index].ArrestIndictmentProduct[j],
                                              IsComplete: false,
                                              itemsMasProductUnit: widget.itemsMasProductUnit,
                                              itemsMasProductSize: widget.itemsMasProductSize,
                                            )),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        padding: paddingInputBoxSub,
                                        child: Text(
                                          (j + 1).toString() + ". " + _itemsInitTab6[index].ArrestIndictmentProduct[j].PRODUCT_DESC.toString(),
                                          style: textDataStyle,
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
          ),
        );
      }

      //Sort GuiltBase
      List<ItemsListArrest6Section> items_guilt = [null, null, null, null, null, null, null];

      widget.ItemsGuiltbase.forEach((item) {
        if (item.GUILTBASE_ID == 113 || item.GUILTBASE_ID == 121 || item.GUILTBASE_ID == 107 || item.GUILTBASE_ID == 109 || item.GUILTBASE_ID == 94 || item.GUILTBASE_ID == 104 || item.GUILTBASE_ID == 106) {
          if (item.GUILTBASE_ID == 113) {
            items_guilt[0] = item;
          } else if (item.GUILTBASE_ID == 121) {
            items_guilt[1] = item;
          } else if (item.GUILTBASE_ID == 107) {
            items_guilt[2] = item;
          } else if (item.GUILTBASE_ID == 109) {
            items_guilt[3] = item;
          } else if (item.GUILTBASE_ID == 94) {
            items_guilt[4] = item;
          } else if (item.GUILTBASE_ID == 104) {
            items_guilt[5] = item;
          } else if (item.GUILTBASE_ID == 106) {
            items_guilt[6] = item;
          }
        }
      });

      return _onSaved
          ? Container()
          : (_itemsInitTab6.length > 0
              ? new Container(
                  padding: EdgeInsets.only(bottom: 12.0),
                  child: ListView.builder(
                    itemCount: _itemsInitTab6.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Container(
                          padding: EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                              //color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: index == 0
                                  ? Border(
                                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                    )
                                  : Border(
                                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
                                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                    )),
                          child: ExpandableNotifier(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expandable(
                                  collapsed: buildCollapsed(index),
                                  expanded: buildExpanded(index),
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
                        ),
                      );
                    },
                  ),
                )
              : ListView.builder(
                  itemCount: items_guilt.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        _onEdited
                            ? (_itemsDataTab4.length > 0 || _itemsDataTab5OpsSaved.length > 0)
                                ? _navigateSelection_top(
                                    context,
                                    'มาตรา ' + items_guilt[index].SUBSECTION_NAME,
                                    items_guilt[index],
                                    _arrestMain.ArrestLawbreaker,
                                    /*_arrestMain.ArrestProduct*/ _itemsDataTab5OpsSaved)
                                : new VerifyDialog(context, "กรุณาระบุผู้ต้องหาหรือของกลาง")
                            : (_itemsDataTab4.length > 0 || _itemsDataTab5Ops.length > 0)
                                ? _navigateSelection_top(
                                    context,
                                    'มาตรา ' + items_guilt[index].SUBSECTION_NAME,
                                    items_guilt[index],
                                    _itemsDataTab4,
                                    /*_itemsDataTab5*/ _itemsDataTab5Ops)
                                : new VerifyDialog(context, "กรุณาระบุผู้ต้องหาหรือของกลาง");
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Container(
                          padding: EdgeInsets.all(22.0),
                          decoration: BoxDecoration(
                              //color: Colors.white,
                              shape: BoxShape.rectangle,
                              border: index == 0
                                  ? Border(
                                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                    )
                                  : Border(
                                      //top: BorderSide(color: Colors.grey[300], width: 1.0),
                                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                    )),
                          child: Stack(
                            children: <Widget>[
                              ListTile(
                                title: Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    'มาตรา ' + items_guilt[index].SUBSECTION_NAME,
                                    style: textInputStyleTitle,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: paddingInputBox,
                                  child: Text(
                                    items_guilt[index].GUILTBASE_NAME,
                                    style: textInputStyleSub,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey[400],
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ));
    }

    Widget _buildContent_saved(BuildContext context) {
      buildCollapsed(index) {
        String suspect = "";
        String subSuspect = "";
        if (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.length > 0) {
          suspect = _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].PERSON_TYPE == 0
              ? (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_TH != null ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_TH.toString() : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].TITLE_NAME_TH.toString()) +
                  " " +
                  _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].FIRST_NAME +
                  " " +
                  _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].LAST_NAME
              : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].PERSON_TYPE == 1
                  ? (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_EN != null ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_EN.toString() : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].TITLE_NAME_EN.toString()) +
                      " " +
                      _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].FIRST_NAME +
                      " " +
                      _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].LAST_NAME
                  : (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_TH != null ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].TITLE_SHORT_NAME_TH.toString() : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].TITLE_NAME_TH.toString()) +
                      _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[0].COMPANY_NAME.toString();
          if (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.length == 2) {
            subSuspect += _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].PERSON_TYPE == 0
                ? (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH != null ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH.toString() : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_NAME_TH.toString()) +
                    " " +
                    _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].FIRST_NAME +
                    " " +
                    _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].LAST_NAME
                : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].PERSON_TYPE == 1
                    ? (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_EN != null ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_EN.toString() : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_NAME_EN.toString()) +
                        " " +
                        _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].FIRST_NAME +
                        " " +
                        _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].LAST_NAME
                    : (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH != null ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH.toString() : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_NAME_TH.toString()) +
                        _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].COMPANY_NAME.toString();
          } else if (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.length > 2) {
            subSuspect += (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].PERSON_TYPE == 0
                    ? (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH != null ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH.toString() : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_NAME_TH.toString()) +
                        " " +
                        _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].FIRST_NAME +
                        " " +
                        _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].LAST_NAME
                    : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].PERSON_TYPE == 1
                        ? (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_EN != null
                                ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_EN.toString()
                                : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_NAME_EN.toString()) +
                            " " +
                            _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].FIRST_NAME +
                            " " +
                            _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].LAST_NAME
                        : (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH != null
                                ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_SHORT_NAME_TH.toString()
                                : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].TITLE_NAME_TH.toString()) +
                            _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[1].COMPANY_NAME.toString()) +
                " และคนอื่นๆ " +
                (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.length - 2).toString() +
                " คน";
          }
        } else {
          suspect = "-";
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: paddingInputBox,
                    child: Text(
                      "มาตรา " + _arrestMain.ArrestIndictment[index].SUBSECTION_NAME,
                      style: textDataTitleStyle,
                    ),
                  ),
                ),
                _onEdited
                    ? Column(
                        children: <Widget>[
                          Center(
                              child: InkWell(
                            onTap: () {
                              //set checked suspect
                              for (int i = 0; i < _arrestMain.ArrestLawbreaker.length; i++) {
                                _arrestMain.ArrestLawbreaker[i].IsCheckOffence = false;
                              }
                              _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.forEach((f) {
                                for (int i = 0; i < _arrestMain.ArrestLawbreaker.length; i++) {
                                  if (f.LAWBREAKER_ID == _arrestMain.ArrestLawbreaker[i].LAWBREAKER_ID) {
                                    _arrestMain.ArrestLawbreaker[i].IsCheckOffence = true;
                                    // break;
                                  }
                                }
                              });
                              //set checked items
                              for (int i = 0; i < _arrestMain.ArrestProduct.length; i++) {
                                _arrestMain.ArrestProduct[i].IsCheckOffence = false;
                              }
                              _arrestMain.ArrestIndictment[index].ArrestIndictmentProduct.forEach((f) {
                                for (int i = 0; i < _arrestMain.ArrestProduct.length; i++) {
                                  if (f.PRODUCT_ID == _arrestMain.ArrestProduct[i].PRODUCT_ID) {
                                    _arrestMain.ArrestProduct[i].IsCheckOffence = true;
                                    // break;
                                  }
                                }
                              });

                              _navigateSearchSelectionEdit(context, index, _arrestMain.ArrestLawbreaker, _arrestMain.ArrestProduct); //ตัวลิ้ง
                            },
                            child: Container(
                                child: Text(
                              "แก้ไข",
                              style: textLabelDeleteStyle,
                            )),
                          )),
                        ],
                      )
                    : Container(),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _arrestMain.ArrestIndictment[index].GUILTBASE_NAME,
                      style: textDataStyleSub,
                    ),
                  ),
                ),
                _onEdited
                    ? Center(
                        child: InkWell(
                        onTap: () {
                          _showDeleteItemsAlertDialog(index, "IndicmentUp", null);
                        },
                        child: Container(
                            child: Text(
                          "ลบ",
                          style: textLabelDeleteStyle,
                        )),
                      ))
                    : Container(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ผู้ต้องหา",
                    style: textLabelStyle,
                  ),
                ),
                Container(
                  padding: paddingInputBox,
                  child: Text(
                    suspect,
                    style: textDataStyle,
                  ),
                ),
                _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.length > 1
                    ? Container(
                        padding: paddingInputBox,
                        child: Text(
                          subSuspect,
                          style: textDataSubStyle,
                        ),
                      )
                    : Container(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ของกลาง ",
                    style: textLabelStyle,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(
                    _arrestMain.ArrestIndictment[index].ArrestIndictmentProduct.length > 0 ? _arrestMain.ArrestIndictment[index].ArrestIndictmentProduct.length.toString() + " รายการ" : "-",
                    style: textDataSubStyle,
                  ),
                ),
              ],
            ),
          ],
        );
      }

      buildExpanded(index) {
        EdgeInsets paddingLabel = EdgeInsets.only(top: 4.0, bottom: 4.0);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: paddingInputBox,
                    child: Text(
                      "มาตรา " + _arrestMain.ArrestIndictment[index].SUBSECTION_NAME,
                      style: textDataTitleStyle,
                    ),
                  ),
                ),
                _onEdited
                    ? Column(
                        children: <Widget>[
                          Center(
                              child: InkWell(
                            onTap: () {
                              //set checked suspect
                              for (int i = 0; i < _arrestMain.ArrestLawbreaker.length; i++) {
                                _arrestMain.ArrestLawbreaker[i].IsCheckOffence = false;
                              }
                              _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.forEach((f) {
                                for (int i = 0; i < _arrestMain.ArrestLawbreaker.length; i++) {
                                  if (f.LAWBREAKER_ID == _arrestMain.ArrestLawbreaker[i].LAWBREAKER_ID) {
                                    _arrestMain.ArrestLawbreaker[i].IsCheckOffence = true;
                                    // break;
                                  }
                                }
                              });
                              //set checked items
                              for (int i = 0; i < _arrestMain.ArrestProduct.length; i++) {
                                _arrestMain.ArrestProduct[i].IsCheckOffence = false;
                              }
                              _arrestMain.ArrestIndictment[index].ArrestIndictmentProduct.forEach((f) {
                                for (int i = 0; i < _arrestMain.ArrestProduct.length; i++) {
                                  if (f.PRODUCT_ID == _arrestMain.ArrestProduct[i].PRODUCT_ID) {
                                    _arrestMain.ArrestProduct[i].IsCheckOffence = true;
                                    // break;
                                  }
                                }
                              });
                              _navigateSearchSelectionEdit(context, index, _arrestMain.ArrestLawbreaker, _arrestMain.ArrestProduct);
                            },
                            child: Container(
                                child: Text(
                              "แก้ไข",
                              style: textLabelDeleteStyle,
                            )),
                          )),
                        ],
                      )
                    : Container(),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: paddingInputBox,
                    child: Text(
                      _arrestMain.ArrestIndictment[index].GUILTBASE_NAME,
                      style: textDataStyleSub,
                    ),
                  ),
                ),
                _onEdited
                    ? Center(
                        child: InkWell(
                        onTap: () {
                          _showDeleteItemsAlertDialog(index, "IndicmentUp", null);
                        },
                        child: Container(
                            child: Text(
                          "ลบ",
                          style: textLabelDeleteStyle,
                        )),
                      ))
                    : Container(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ผู้ต้องหา",
                    style: textLabelStyle,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // new
                      itemCount: _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int j) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: paddingInputBox,
                              child: Text(
                                // (j + 1).toString() + ". " + _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH + _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].FIRST_NAME + " " + _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].LAST_NAME,
                                (j + 1).toString() +
                                    ". " +
                                    (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].PERSON_TYPE == 0
                                        ? (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH != null
                                                ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH.toString()
                                                : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_NAME_TH.toString()) +
                                            " " +
                                            _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].FIRST_NAME +
                                            " " +
                                            _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].LAST_NAME
                                        : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].PERSON_TYPE == 1
                                            ? (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_EN != null
                                                    ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_EN.toString()
                                                    : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_NAME_EN.toString()) +
                                                " " +
                                                _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].FIRST_NAME +
                                                " " +
                                                _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].LAST_NAME
                                            : (_arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH != null
                                                    ? _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_SHORT_NAME_TH.toString()
                                                    : _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].TITLE_NAME_TH.toString()) +
                                                _arrestMain.ArrestIndictment[index].ArrestIndictmentDetail[j].COMPANY_NAME.toString()),
                                style: textDataStyle,
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ของกลาง",
                    style: textLabelStyle,
                  ),
                ),
                Container(
                  padding: paddingLabel,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      // new
                      itemCount: _arrestMain.ArrestIndictment[index].ArrestIndictmentProduct.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int j) {
                        var item_product;
                        _arrestMain.ArrestProduct.forEach((f) {
                          if (f.PRODUCT_ID != null) {
                            if (_arrestMain.ArrestIndictment[index].ArrestIndictmentProduct[j].PRODUCT_ID == f.PRODUCT_ID) {
                              item_product = f;
                            }
                          } else {
                            if (_arrestMain.ArrestIndictment[index].ArrestIndictmentProduct[j].PRODUCT_REF_CODE == f.PRODUCT_REF_CODE) {
                              item_product = f;
                            }
                          }
                        });

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
                                            ItemsProduct:
                                                /*_arrestMain
                                                .ArrestIndictment[index]
                                                .ArrestIndictmentProduct[j]*/
                                                item_product,
                                            IsComplete: true,
                                          )),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: paddingInputBoxSub,
                                      child: Text(
                                        item_product != null ? (j + 1).toString() + ". " + item_product.PRODUCT_DESC.toString() : "",
                                        style: textDataStyle,
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

      return ListView.builder(
        itemCount: _arrestMain.ArrestIndictment.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(/*top: 4.0, */ bottom: 4.0),
            child: Container(
              padding: EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                  //color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: index == 0
                      ? Border(
                          top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )
                      : Border(
                          //top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )),
              child: ExpandableNotifier(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expandable(
                      collapsed: buildCollapsed(index),
                      expanded: buildExpanded(index),
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
            ),
          );
        },
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  /*Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_22_00',
                          style: textStylePageName,),
                      ),*/
                ],
              ),
              _onSaved
                  ? Container()
                  : Container(
                      //width: itemWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: new Card(
                          elevation: 0.0,
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: new GestureDetector(
                            onTap: () {
                              _onEdited
                                  ? _navigateSearchSelection(
                                      context,
                                      _arrestMain.ArrestLawbreaker,
                                      /*_arrestMain.ArrestProduct*/ _itemsDataTab5OpsSaved)
                                  : _navigateSearchSelection(
                                      context,
                                      _itemsDataTab4,
                                      /*_itemsDataTab5*/ _itemsDataTab5Ops);
                            },
                            child: new ListTile(
                              leading: new Icon(Icons.search),
                              title: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'ค้นหาข้อกล่าวหา',
                                    style: TextStyle(fontSize: 16.0, color: Colors.grey[500], fontFamily: FontStyles().FontFamily),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          )),
          _onSaved
              ? Container()
              : (_itemsInitTab6.length == 0
                  ? Container(
                      padding: EdgeInsets.only(left: 22.0, right: 22.0, bottom: 12.0),
                      child: Text(
                        ' ข้อกล่าวหาที่กระทำผิดเรียงจากมากไปน้อย',
                        style: textStyleTitle,
                      ),
                    )
                  : Container()),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: _onSaved || _onEdited ? _buildContent_saved(context) : _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  _navigateSelection_top(
    // Choose section
    BuildContext context,
    String title,
    ItemsListArrest6Section itemMain,
    List ItemLawbreaker,
    List ItemProduct,
  ) async {
    var result;
    if (ItemLawbreaker.length == 0 && ItemProduct.length > 0) {
      // print("ไม่มีคนแต่มีของกลาง");
      itemMain.ArrestIndictmentDetail = [];
      result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest6Evidence(
                  IsUpdate: false,
                  Title: title,
                  ItemsData: itemMain,
                  ItemsProduct: ItemProduct,
                )),
      );
    } else {
      // print("case2");

      result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TabScreenArrest6Section(
                  Title: title,
                  ItemsLawbreaker: ItemLawbreaker,
                  ItemsProduct: ItemProduct,
                  ItemsSection: itemMain,
                  IsUpdate: false,
                )),
      );
    }
    //_itemsData=result;
    //Navigator.pop(context);
    if (result.toString() != "back") {
      if (_onEdited) {
        var items = result;
        _arrestMain.ArrestIndictment.add(items);
        list_add_indicment.add(items);
      } else {
        //print("mas : "+_itemsDataTab5[0].QUANTITY.toString());
        //print("ops : "+_itemsDataTab5Ops[0].QUANTITY.toString());
        //_itemsDataTab5 = result;

        setState(() {
          IsSelected_tab6 = true;
          ItemsListArrest6Section item = result;
          _itemsInitTab6.add(item);

          // =========================================== SET BEHAVIOR ===========================================
          String textLawsuitBreaker = "";
          String EvidenceItem = "";
          String Section = "";
          int counts = 0;

          if (widget.IsUpdate) {
            if (_arrestMain.ArrestIndictment.length > 0) {
              _arrestMain.ArrestIndictment.forEach((f) {
                counts += f.ArrestIndictmentDetail.length;
              });
              textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " + _arrestMain.ArrestLawbreaker.length.toString() + " คน " + (_arrestMain.ArrestLawbreaker.length == 0 ? "" : "คือ ");
              Section = "ในข้อกล่าวหา ";
              // item & evidence
              int index_pro = 0;
              _arrestMain.ArrestProduct.forEach((f) {
                index_pro++;
                EvidenceItem += f.PRODUCT_DESC.toString() + (index_pro != _arrestMain.ArrestProduct.length ? ", " : " ");
              });
              _tempEvidenceItem = EvidenceItem;
              // list suspect
              _arrestMain.ArrestLawbreaker.forEach((item) {
                textLawsuitBreaker += item.PERSON_TYPE == 2
                    ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.COMPANY_NAME
                    : item.PERSON_TYPE == 0
                        ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.FIRST_NAME + " " + item.LAST_NAME + " "
                        : (item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN : item.TITLE_NAME_EN) + item.FIRST_NAME + " " + item.LAST_NAME + " ";
              });
              _tempTextLawsuitBreaker = textLawsuitBreaker;

              int index_sec = 0;
              _arrestMain.ArrestIndictment.forEach((item) {
                index_sec++;
                Section += (item.ArrestIndictmentDetail.length > 1 ? "ร่วมกัน" : "") + item.GUILTBASE_NAME + (index_sec != _itemsInitTab6.length ? ", " : " ");
              });
              _tempSection = Section;
              setBehavior(textLawsuitBreaker + (EvidenceItem == "" ? "" : (_tempEvidence + EvidenceItem)) + Section);
            }
          } else {
            if (_itemsInitTab6.length > 0) {
              textLawsuitBreaker = " โดยจับกุมตัวผู้ต้องหาจำนวน " + _itemsDataTab4.length.toString() + " ครั้ง " + (_itemsDataTab4.length == 0 ? "" : "คือ ");
              EvidenceItem = "";
              Section = "ในข้อกล่าวหา ";
              //จำนวนและรายการของกลาง
              int index_pro = 0;
              _itemsDataTab5.forEach((f) {
                index_pro++;
                EvidenceItem += f.PRODUCT_DESC.toString() + (index_pro != _itemsDataTab5.length ? ", " : " ");
              });
              _tempEvidenceItem = EvidenceItem;
              // name of suspect
              _itemsDataTab4.forEach((item) {
                textLawsuitBreaker += item.PERSON_TYPE == 2
                    ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.COMPANY_NAME
                    : item.PERSON_TYPE == 0
                        ? (item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH : item.TITLE_NAME_TH) + item.FIRST_NAME + " " + item.LAST_NAME + " "
                        : (item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN : item.TITLE_NAME_EN) + item.FIRST_NAME + " " + item.LAST_NAME + " ";
              });
              _tempTextLawsuitBreaker = textLawsuitBreaker;

              int index_sec = 0;
              _itemsInitTab6.forEach((item) {
                index_sec++;
                Section += (item.ArrestIndictmentDetail.length > 1 ? "ร่วมกัน" : "") + item.GUILTBASE_NAME + (index_sec != _itemsInitTab6.length ? ", " : " ");
              });
              _tempSection = Section;
              setBehavior(textLawsuitBreaker + (EvidenceItem == "" ? "" : (_tempEvidence + EvidenceItem)) + Section);
            }
          }
          // ====================================================================================================
        });
      }
    }
  }

  //************************end_tab_6*****************************

  //************************start_tab_7*****************************
  Widget _buildContent_tab_7() {
    Widget _buildContent() {
      EdgeInsets paddindTextTitle = EdgeInsets.only(bottom: 18.0);
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(bottom: 8.0),
              child: new Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        //top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: paddindTextTitle,
                        child: Text(
                          "พฤติกรรมการจับกุม",
                          style: textLabelStyle,
                        ),
                      ),
                      TextField(
                        style: textInputStyle,
                        maxLines: 10,
                        focusNode: myFocusNodeArrestBehavior,
                        controller: editArrestBehavior,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500], width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400], width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            /* new Container(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Container(
                padding: EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    border: Border(
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                      bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: paddindTextTitle,
                      child: Text(
                        "คำให้การของผู้ต้องหา", style: textLabelStyle,),
                    ),
                    TextField(
                      style: textInputStyle,
                      focusNode: myFocusNodeTestimony,
                      controller: editTestimony,
                      maxLines: 10,
                      decoration: new InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[500], width: 0.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[400], width: 0.5),
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),*/

            new Container(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0),
                        bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 18.0, top: 4, bottom: 4.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    TESTIMONY = !TESTIMONY;
                                    if (TESTIMONY) {
                                      editNotificationOfRights.text = "ได้ดำเนินการตามที่ข้าพเจ้าร้องขอ";
                                    } else {
                                      editNotificationOfRights.text = "";
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: TESTIMONY ? Color(0xff3b69f3) : Colors.white,
                                    border: Border.all(width: 1, color: Colors.black38),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TESTIMONY
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
                                "ร้องขอ",
                                style: textLabelStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextField(
                        enabled: TESTIMONY ? true : false,
                        style: textInputStyle,
                        focusNode: myFocusNodeNotificationOfRights,
                        controller: editNotificationOfRights,
                        maxLines: 10,
                        decoration: new InputDecoration(
                          filled: true,
                          //fillColor: TESTIMONY?Colors.white:Colors.grey[200],
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[500], width: 0.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[400], width: 0.5),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      );
    }

    /*********************************when save data************************************/
    Widget _buildContent_saved() {
      List<String> list = [];
      list.add(_arrestMain.BEHAVIOR_1);
      list.add(_arrestMain.BEHAVIOR_2);
      list.add(_arrestMain.BEHAVIOR_3);
      list.add(_arrestMain.BEHAVIOR_4);
      list.add(_arrestMain.BEHAVIOR_5);
      String behavior = "";
      list.forEach((string) {
        if (string != null) {
          behavior += string;
        }
      });
      var size = MediaQuery.of(context).size;

      return Container(
          height: size.height,
          decoration: BoxDecoration(
              //color: Colors.white,
              border: Border(
            bottom: BorderSide(color: Colors.grey[300], width: 1.0),
          )),
          padding: EdgeInsets.only(
              /*top: 4.0,*/ bottom: 12.0,
              left: 22.0,
              right: 22.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "พฤติกรรมการจับกุม",
                    style: textLabelStyle,
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: Text(
                    behavior,
                    style: textInputStyle,
                  ),
                ),
                /*Padding(
                  padding: paddingInputBox,
                  child: Text("คำให้การของผู้ต้องหา", style: textLabelStyle,),
                ),
                Container(
                  padding: paddingLabel,
                  child: Text(_arrestMain.TESTIMONY!=null?_arrestMain.TESTIMONY:"-",
                    style: textInputStyle,),
                ),*/
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ร้องขอ",
                    style: textLabelStyle,
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: Text(
                    _arrestMain.REQUEST_DESC != null ? _arrestMain.REQUEST_DESC : "-",
                    style: textInputStyle,
                  ),
                ),
              ],
            ),
          ));
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              //height: 34.0,
              // decoration: BoxDecoration(
              //     //color: Colors.grey[200],
              //     border: Border(
              //   top: BorderSide(color: Colors.grey[300], width: 1.0),
              // )),
              /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_27_00',
                          style: textStylePageName,),
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
                child: _onSaved ? _buildContent_saved() : _buildContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //************************end_tab_7*****************************

//************************start_tab_8*****************************

  Widget _buildContent_tab_8() {
    Widget _buildContent() {
      return Container(
        padding: EdgeInsets.only(bottom: 22.0),
        //margin: EdgeInsets.all(4.0),
        child: ListView.builder(
            padding: EdgeInsets.only(top: 0.0),
            itemCount: _itemsDataTab8.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0),
                child: Container(
                  padding: EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      //color: Colors.white,
                      shape: BoxShape.rectangle,
                      border: index == 0
                          ? Border(
                              //top: BorderSide(color: Colors.grey[300], width: 1.0),
                              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                            )
                          : Border(
                              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                            )),
                  child: ListTile(
                      title: Text(
                        (index + 1).toString() + '. ' + _itemsDataTab8[index].FormsName,
                        style: textInputStyle,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[400],
                      ),
                      onTap: () {
                        _navigate_preview_form(context, _itemsDataTab8[index]);
                      }),
                ),
              );
            }),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              //height: 34.0,
              // decoration: BoxDecoration(
              //     //color: Colors.grey[200],
              //     border: Border(
              //   top: BorderSide(color: Colors.grey[300], width: 1.0),
              // )),
              /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_28_00',
                          style: textStylePageName),
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
                child: _buildContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> onLoadActionPreviewForms(Map map) async {
    await new TransectionFuture().apiRequestArrestReport(map).then((onValue) {
      print("res PDF : " + onValue);
    });
    setState(() {});
    return true;
  }

  _navigate_preview_form(BuildContext context, ItemsListArrest8 item) async {
    Map map_gen = {"ArrestCode": _arrestMain.ARREST_CODE};
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        });
    await onLoadActionPreviewForms(map_gen);
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
//************************end_tab_8*****************************

  void _onSelectCountry(int COUNTRY_ID, String ProvinceName, String DistrictName, String SubDistrictName) async {
    await onLoadActionProvinceMaster(COUNTRY_ID, ProvinceName, DistrictName, SubDistrictName);
  }

  Future<bool> onLoadActionProvinceMaster(int COUNTRY_ID, String ProvinceName, String DistrictName, String SubDistrictName) async {
    Map map = {"TEXT_SEARCH": "", "COUNTRY_ID": COUNTRY_ID};
    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      ItemProvince = onValue;

      ItemProvince.RESPONSE_DATA.forEach((province) {
        if (ProvinceName.trim().endsWith(province.PROVINCE_NAME_TH.trim())) {
          sProvince = province;
          onLoadActionDistinctMaster(sProvince.PROVINCE_ID, DistrictName, SubDistrictName);
        }
      });
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionDistinctMaster(int PROVINCE_ID, String DistrictName, String SubDistrictName) async {
    Map map = {"TEXT_SEARCH": "", "DISTRICT_ID": "", "PROVINCE_ID": PROVINCE_ID};
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      ItemDistrict = onValue;
      ItemDistrict.RESPONSE_DATA.forEach((district) {
        if (DistrictName.trim().endsWith(district.DISTRICT_NAME_TH.trim())) {
          setState(() {
            sSubDistrict = null;
            sDistrict = district;
            this.onLoadActionSubDistinctMaster(sDistrict.DISTRICT_ID, SubDistrictName);
          });
        }
      });
      setState(() {});
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionSubDistinctMaster(int DISTRICT_ID, String SubDistrictName) async {
    Map map = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": "", "DISTRICT_ID": DISTRICT_ID};
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      ItemSubDistrict = onValue;
      if (ItemSubDistrict != null) {
        ItemSubDistrict.RESPONSE_DATA.forEach((subdistrict) {
          if (SubDistrictName.trim().endsWith(subdistrict.SUB_DISTRICT_NAME_TH.trim())) {
            setState(() {
              sSubDistrict = subdistrict;

              if (widget.IsPreview || widget.IsUpdate) {
                String Other = "";
                _arrestMain.ArrestLocale.forEach((item) {
                  List splits = item.LOCATION.split(" ");
                  print(splits[splits.length - 1]);
                  if (splits[splits.length - 1].toString().trim() != sProvince.PROVINCE_NAME_TH) {
                    Other = splits[splits.length - 1];
                  } else {
                    Other = "";
                  }
                });

                //finish
                _itemsLocale = new ItemsListArrestLocation(sProvince, sDistrict, sSubDistrict, _arrestMain.ArrestLocale.first.ROAD != null ? _arrestMain.ArrestLocale.first.ROAD : "", _arrestMain.ArrestLocale.first.LANE != null ? _arrestMain.ArrestLocale.first.LANE : "",
                    _arrestMain.ArrestLocale.first.ADDRESS_NO != null ? _arrestMain.ArrestLocale.first.ADDRESS_NO : "", _arrestMain.ArrestLocale.first.GPS != null ? _arrestMain.ArrestLocale.first.GPS : "", placeAddress, false, Other);
              } else {
                //finish
                _itemsLocale = new ItemsListArrestLocation(sProvince, sDistrict, sSubDistrict, _road, _lane, _addressno, _gps, placeAddress, false, "");
              }

              String address = (_itemsLocale.Other == null || _itemsLocale.Other.isEmpty ? "" : _itemsLocale.Other + " ") +
                  (_itemsLocale.ADDRESS_NO == null || _itemsLocale.ADDRESS_NO.isEmpty ? "" : _itemsLocale.ADDRESS_NO + " ") +
                  (_itemsLocale.LANE == null || _itemsLocale.LANE.isEmpty ? "" : "ซอย " + _itemsLocale.LANE + " ") +
                  (_itemsLocale.ROAD == null || _itemsLocale.ROAD.isEmpty ? "" : "ถนน " + _itemsLocale.ROAD + " ") +
                  "ตำบล/แขวง " +
                  (_itemsLocale.SUB_DISTICT.SUB_DISTRICT_NAME_TH + " ") +
                  "อำเภอ/เขต " +
                  (_itemsLocale.DISTICT.DISTRICT_NAME_TH + " ") +
                  "จังหวัด " +
                  _itemsLocale.PROVINCE.PROVINCE_NAME_TH;
              editArrestLocation.text = address.trim();
              arrestLocation = _itemsLocale.Other;
              print("Address ver 6");
            });
          }
        });
      }
    });
    setState(() {});
    return true;
  }

  //test
  void _setItemProductOps() {
    List item_ops = [];
    _arrestMain.ArrestProduct.forEach((item) {
      item_ops.add(new ItemsListArrestOps(
          item.PRODUCT_MAPPING_ID,
          item.PRODUCT_CODE,
          item.PRODUCT_REF_CODE,
          item.PRODUCT_ID,
          item.PRODUCT_GROUP_ID,
          item.PRODUCT_CATEGORY_ID,
          item.PRODUCT_TYPE_ID,
          item.PRODUCT_SUBTYPE_ID,
          item.PRODUCT_SUBSETTYPE_ID,
          item.PRODUCT_BRAND_ID,
          item.PRODUCT_SUBBRAND_ID,
          item.PRODUCT_MODEL_ID,
          item.PRODUCT_TAXDETAIL_ID,
          item.UNIT_ID,
          item.PRODUCT_GROUP_NAME,
          item.PRODUCT_CATEGORY_NAME,
          item.PRODUCT_TYPE_NAME,
          item.PRODUCT_SUBTYPE_NAME,
          item.PRODUCT_SUBSETTYPE_NAME,
          item.PRODUCT_BRAND_NAME_TH,
          item.PRODUCT_BRAND_NAME_EN,
          null,
          item.PRODUCT_SUBBRAND_NAME_TH,
          item.PRODUCT_SUBBRAND_NAME_EN,
          item.PRODUCT_MODEL_NAME_TH,
          item.PRODUCT_MODEL_NAME_EN,
          item.SIZES_UNIT_ID,
          item.QUANTITY,
          item.VOLUMN_UNIT_ID,
          item.SIZES,
          item.QUATITY_UNIT_ID,
          item.VOLUMN,
          item.SIZES_UNIT,
          item.QUANTITY_UNIT,
          item.VOLUMN_UNIT,
          null,
          item.TAX_VALUE,
          item.TAX_VOLUMN,
          item.TAX_VOLUMN_UNIT,
          item.DEGREE,
          item.SUGAR,
          item.CO2,
          item.PRICE,
          item.PRODUCT_DESC,
          item.COMPANYNAME,
          item.REMARK,
          item.IS_DOMESTIC,
          item.IsCheck,
          item.IsCheckOffence,
          item.Arrest6Controller,
          item.INDEX));
    });

    ItemsListArrest5Test items_test = new ItemsListArrest5Test(_arrestMain.ArrestProduct, item_ops);
    _arrestMain.ArrestProduct = items_test.ItemsListArrest5Mas;
    _itemsDataTab5OpsSaved = items_test.ItemsListArrest5Ops;
  }

  //Upload Video
  bool isVideo = false;
  VideoPlayerController _controller;
  VoidCallback listener;
  List<ItemsListDocument> itemsVideoFile = [];
  List<ItemsListDocument> itemsVideoFileAdd = [];
  List<ItemsListDocument> itemsVideoFileDelete = [];

  Future<File> _imageFile;

  //get file รูปภาพ
  Future getImage(ImageSource source, mContext) async {
    //var image = await FilePicker.getMultiFilePath(type: source, fileExtension: "FROM ANY");
    var image = await ImagePicker.pickImage(source: source);
    setState(() {
      if (_onEdited) {
        itemsVideoFileAdd.add(new ItemsListDocument(FILE_CONTENT: image, DOCUMENT_NAME: image.path.split("/").last, DOCUMENT_OLD_NAME: image.path));
      }
      itemsVideoFile.add(new ItemsListDocument(FILE_CONTENT: image, DOCUMENT_NAME: image.path.split("/").last, DOCUMENT_OLD_NAME: image.path));
    });
    Navigator.pop(mContext);
  }

  //get file
  Future getFile(FileType source, mContext) async {
    var image = await FilePicker.getMultiFilePath(type: source, fileExtension: "FROM ANY");
    bool isOverSize = false;
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < image.length; i++) {
        String _name = image.keys.toList()[i];
        File _path = File(image.values.toList()[i].toString());
        String sPath = image.values.toList()[i].toString();

        print(_path.lengthSync().toString() + " , " + filesize(_path.lengthSync()).toString());
        List splits = filesize(_path.lengthSync()).toString().split(" ");
        if (splits.length > 0) {
          if (double.parse(splits[0]) <= 200) {
            if (_onEdited) {
              if (_path != null && mounted) {
                List splits = _path.path.split("/");
                itemsVideoFileAdd.add(new ItemsListDocument(FILE_CONTENT: _path, DOCUMENT_NAME: _name, DOCUMENT_OLD_NAME: image.values.toList()[i].toString(), FILE_PATH: sPath));

                itemsVideoFile.add(new ItemsListDocument(FILE_CONTENT: _path, DOCUMENT_NAME: _name, DOCUMENT_OLD_NAME: image.values.toList()[i].toString(), FILE_PATH: sPath));

                List splitsNameFile = _name.split(".");
                if (splitsNameFile.last.toString().endsWith("mp4")) {
                  setState(() {
                    _controller = VideoPlayerController.file(_path)
                      ..addListener(listener)
                      ..setVolume(1.0)
                      ..initialize()
                      ..setLooping(false)
                      ..play();
                  });
                }
              }
            } else {
              if (_path != null && mounted) {
                List splits = _path.path.split("/");
                itemsVideoFile.add(new ItemsListDocument(FILE_CONTENT: _path.absolute, DOCUMENT_OLD_NAME: splits[splits.length - 1], DOCUMENT_NAME: splits[splits.length - 1], FILE_PATH: _path.path));

                List splitsNameFile = _name.split(".");
                if (splitsNameFile.last.toString().endsWith("mp4")) {
                  setState(() {
                    _controller = VideoPlayerController.file(_path)
                      ..addListener(listener)
                      ..setVolume(1.0)
                      ..initialize()
                      ..setLooping(false)
                      ..play();
                  });
                }
              }
            }
          } else {
            isVideo = false;
            isOverSize = true;
          }
        } else {
          //
        }
      }
    });
    Navigator.pop(mContext);
    if (isOverSize) {
      new EmptyDialog(context, "ไฟล์ที่เลือกมีขนาดเกินกำหนด");
    }
  }

  //get file วิดิโอ
  Future getVideo(ImageSource source, mContext) async {
    setState(() {
      if (_controller != null) {
        _controller.setVolume(0.0);
        _controller.removeListener(listener);
      }
      print(isVideo);
      if (isVideo) {
        ImagePicker.pickVideo(source: source).then((File file) {
          print(file.lengthSync().toString() + " , " + filesize(file.lengthSync()).toString());
          List splits = filesize(file.lengthSync()).toString().split(" ");
          if (splits.length > 0) {
            print(splits[0]);
            if (double.parse(splits[0]) <= 200) {
              if (_onEdited) {
                if (file != null && mounted) {
                  List splits = file.path.split("/");
                  itemsVideoFileAdd.add(new ItemsListDocument(FILE_CONTENT: file.absolute, DOCUMENT_OLD_NAME: splits[splits.length - 1], DOCUMENT_NAME: splits[splits.length - 1], FILE_PATH: file.path));

                  itemsVideoFile.add(new ItemsListDocument(FILE_CONTENT: file.absolute, DOCUMENT_OLD_NAME: splits[splits.length - 1], DOCUMENT_NAME: splits[splits.length - 1], FILE_PATH: file.path));

                  setState(() {
                    _controller = VideoPlayerController.file(file)
                      ..addListener(listener)
                      ..setVolume(1.0)
                      ..initialize()
                      ..setLooping(false)
                      ..play();
                  });
                }
              } else {
                if (file != null && mounted) {
                  List splits = file.path.split("/");
                  itemsVideoFile.add(new ItemsListDocument(FILE_CONTENT: file.absolute, DOCUMENT_OLD_NAME: splits[splits.length - 1], DOCUMENT_NAME: splits[splits.length - 1], FILE_PATH: file.path));

                  setState(() {
                    _controller = VideoPlayerController.file(file)
                      ..addListener(listener)
                      ..setVolume(1.0)
                      ..initialize()
                      ..setLooping(false)
                      ..play();
                  });
                }
              }
            } else {
              isVideo = false;
              new EmptyDialog(context, "ไฟล์ที่เลือกขนาดเกินกำหนด");
            }
          }
        });
      } else {
        //
      }
    });
    Navigator.pop(mContext);
  }

//แสดง popup ให้เลือกรูปจากกล้องหรือแกลอรี่
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    width: width / 3.5,
                    height: height / 7,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Icon(
                      Icons.videocam,
                      color: Colors.blue,
                      size: 38.0,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      isVideo = true;
                      getVideo(ImageSource.camera, context);
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: width / 3.5,
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
                    setState(() {
                      isVideo = false;
                      getImage(ImageSource.camera, context);
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: width / 3.5,
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
                    setState(() {
                      isVideo = true;

                      //getVideo(ImageSource.gallery, context);
                      getFile(FileType.ANY, context);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonVideoPicker() {
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
                //width: size.width / 2.2,
                padding: EdgeInsets.all(4.0),
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
                              "อัพโหลดไฟล์/ภาพ/วีดีโอ",
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

  Widget _previewVideo(VideoPlayerController controller) {
    /*if (controller == null) {
      return  Text(
        */ /*'* อัพโหลดไฟล์ได้ไม่เกิน 200 MB \nหรือ ความยาวประมาณ 1 นาที'*/ /*"",
        textAlign: TextAlign.start,style: textLabelDeleteStyle,
      );
    } else if (controller.value.initialized) {*/
    return Padding(
      padding: EdgeInsets.only(top: 0.3, bottom: 0.3),
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
        ),
        child:
            /*ListTile(
              leading: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.white30),
                ),
                //margin: const EdgeInsets.only(top: 32.0, left: 16.0),
                padding: const EdgeInsets.all(3.0),
                child: AspectRatioVideo(
                    controller
                ),
              ),
              title: Text(itemsVideoFile.DOCUMENT_NAME.toString(),
                style: textInputStyleTitle,),
              trailing: new ButtonTheme(
                minWidth: 44.0,
                padding: new EdgeInsets.all(0.0),
                child: new FlatButton(
                  child: !_onSaved?Icon(Icons.delete_outline, size: 32.0,color: Colors.grey[500],):Icon(null),
                  onPressed: () {
                    _showDeleteVideoAlertDialog(itemsVideoFile);
                  },
                ),
              ),
              onTap: () {
                //
              }
          ),*/
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: itemsVideoFile.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  String _imgFile;
                  List splits = itemsVideoFile[index].DOCUMENT_NAME.split(".");
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
                          border: index == 0
                              ? Border(
                                  top: BorderSide(color: Colors.grey[300], width: 1.0),
                                  bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                                )
                              : Border(
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
                            child:
                                /*splits.last.toString().trim().endsWith("mp4")
                          ? AspectRatioVideo(controller)
                          :*/
                                (splits.last.toString().trim().endsWith("jpg") || splits.last.toString().trim().endsWith("png")
                                    ? Image.file(
                                        itemsVideoFile[index].FILE_CONTENT,
                                        fit: BoxFit.cover,
                                      )
                                    : Image(fit: BoxFit.cover, image: new AssetImage(_imgFile))),
                          ),
                          title: Text(
                            itemsVideoFile[index].DOCUMENT_NAME,
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
                                    if (itemsVideoFile[index].DOCUMENT_ID != null) {
                                      print("case :: A");
                                      itemsVideoFileDelete.add(itemsVideoFile[index]);
                                    } else {
                                      print("case :: B");
                                      print(index.toString() + " - " + (itemsVideoFile.length - itemsVideoFileAdd.length).toString() + " = " + (index - (itemsVideoFile.length - itemsVideoFileAdd.length)).toString());
                                      itemsVideoFileAdd.removeAt((index - (itemsVideoFile.length - itemsVideoFileAdd.length)));
                                    }
                                  }
                                  itemsVideoFile.removeAt(index);
                                  if (itemsVideoFile.length == 0) {
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
      ),
    );
    /*} else {
      return Text(
        'Error Loading Video',
        textAlign: TextAlign.center,
        style: textLabelDeleteStyle,
      );
    }*/
  }

  CupertinoAlertDialog _createCupertinoDeleteVideoDialog(ItemsListDocument doc) {
    return new CupertinoAlertDialog(
        content: new Padding(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0),
          child: Text(
            "ยืนยันการลบข้อมูล",
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
                  if (_controller != null) {
                    _controller.setVolume(0.0);
                    _controller.removeListener(listener);
                    _controller = null;
                    itemsVideoFileDelete.remove(doc);
                  }
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showDeleteVideoAlertDialog(doc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoDeleteVideoDialog(doc);
      },
    );
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller.setVolume(0.0);
      _controller.removeListener(listener);
    }
    super.deactivate();
  }
}

class AspectRatioVideo extends StatefulWidget {
  final VideoPlayerController controller;

  AspectRatioVideo(this.controller);

  @override
  AspectRatioVideoState createState() => new AspectRatioVideoState();
}

class AspectRatioVideoState extends State<AspectRatioVideo> {
  VideoPlayerController get controller => widget.controller;
  bool initialized = false;

  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      if (!mounted) {
        return;
      }
      if (initialized != controller.value.initialized) {
        initialized = controller.value.initialized;
        setState(() {});
      }
    };
    controller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    if (initialized) {
      final Size size = controller.value.size;
      return new Center(
        child: new AspectRatio(
          aspectRatio: size.width / size.height,
          child: new VideoPlayer(controller),
        ),
      );
    } else {
      return new Container();
    }
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
