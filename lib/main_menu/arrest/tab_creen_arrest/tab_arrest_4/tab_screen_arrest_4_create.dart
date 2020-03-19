import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_country.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_nationality.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_race.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_title.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prototype_app_pang/main_menu/future/transection_future.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:image/image.dart' as Img;
import 'package:prototype_app_pang/styles/myStyle.dart';

class TabScreenArrest4Create extends StatefulWidget {
  bool IsUpdate;
  bool IsNotice;
  ItemsMasterTitleResponse ItemTitle;
  var ItemsPerson;
  List<ItemsListDocument> ItemsDocument;
  ItemsMasterCountryResponse ItemCountry;
  String Title;
  TabScreenArrest4Create({
    Key key,
    @required this.IsUpdate,
    @required this.IsNotice,
    @required this.ItemTitle,
    @required this.ItemsPerson,
    @required this.ItemsDocument,
    @required this.ItemCountry,
    @required this.Title,
  }) : super(key: key);
  @override
  _TabScreenArrest4CreateState createState() => new _TabScreenArrest4CreateState();
}

class _TabScreenArrest4CreateState extends State<TabScreenArrest4Create> {
  //node type1
  final FocusNode myFocusNodeIDNo = FocusNode();

  final FocusNode myFocusNodeFirstNameSus = FocusNode();
  final FocusNode myFocusNodeLastNameSus = FocusNode();
  final FocusNode myFocusNodeRace = FocusNode();
  final FocusNode myFocusNodeNationality = FocusNode();
  final FocusNode myFocusNodeCareer = FocusNode();

  final FocusNode myFocusNodeFirstNameFather_1 = FocusNode();
  final FocusNode myFocusNodeLastNameFather_1 = FocusNode();
  final FocusNode myFocusNodeFirstNameMother_1 = FocusNode();
  final FocusNode myFocusNodeLastNameMother_1 = FocusNode();
  final FocusNode myFocusNodePlace = FocusNode();

  //node type1
  TextEditingController editIDNo = new TextEditingController();
  TextEditingController editPassportNo = new TextEditingController();
  TextEditingController editPassportCountry = new TextEditingController();

  // Title Thai Info
  TextEditingController editFirstNameSus = new TextEditingController();
  TextEditingController editLastNameSus = new TextEditingController();
  TextEditingController editRace = new TextEditingController();
  TextEditingController editNationality = new TextEditingController();
  TextEditingController editCareer = new TextEditingController();

  // Title Thai Family
  TextEditingController editFirstNameFather = new TextEditingController();
  TextEditingController editLastNameFather = new TextEditingController();
  TextEditingController editFirstNameMother = new TextEditingController();
  TextEditingController editLastNameMother = new TextEditingController();
  TextEditingController editPlace = new TextEditingController();

  TextEditingController editTitleName = new TextEditingController();
  TextEditingController editTitleNameFather = new TextEditingController();
  TextEditingController editTitleNameMother = new TextEditingController();
  TextEditingController editTitleRace = new TextEditingController();
  TextEditingController editTitleNationality = new TextEditingController();

  TextEditingController editCountry = new TextEditingController();
  TextEditingController editProvince = new TextEditingController();
  TextEditingController editDistrict = new TextEditingController();
  TextEditingController editSubDistrict = new TextEditingController();

  ItemsMasterGetPersonResponse _getPersonResponse;

  // Title Thai
  ItemsListTitle sTitle;
  ItemsListTitle sTitleMother;
  ItemsListTitle sTitleFather;

  ItemsMasterCountryResponse ItemCountry;
  ItemsMasterProvinceResponse ItemProvince;
  ItemsMasterDistictResponse ItemDistrict;
  ItemsMasterSubDistictResponse ItemSubDistrict;
  ItemsMasRaceResponse ItemMasRace;
  ItemsMasNationalityResponse ItemNationality;

  // Address Thai
  ItemsListSubDistict sSubDistrict;
  ItemsListDistict sDistrict;
  ItemsListProvince sProvince;
  ItemsListCountry sCountry;
  ItemsListRace sRace;
  ItemsListNational sNational;

  AutoCompleteTextField _textListTitleName;
  AutoCompleteTextField _textListTitleNameFather;
  AutoCompleteTextField _textListTitleNameMother;
  AutoCompleteTextField _textListRace;
  AutoCompleteTextField _textListNationality;

  AutoCompleteTextField _textListCountry;
  AutoCompleteTextField _textListProvince;
  AutoCompleteTextField _textListDistrict;
  AutoCompleteTextField _textListSubDistrict;
  // ------------------------------------------------------------------------------------

  // ----------------------------- Var Company ------------------------------------------
  final FocusNode myFocusNodeIDNo_Company = FocusNode();
  final FocusNode myFocusNodeEntityNo_Company = FocusNode();
  final FocusNode myFocusNodeCompanyName = FocusNode();
  final FocusNode myFocusNodeExciseRegistrationNo_Company = FocusNode();
  final FocusNode myFocusNodeCompanyNameTitle = FocusNode();

  final FocusNode myFocusNodeCompany_agentFirstName = FocusNode();
  final FocusNode myFocusNodeCompany_agentLastName = FocusNode();

  final FocusNode myFocusNodeFirstNameFather_2 = FocusNode();
  final FocusNode myFocusNodeLastNameFather_2 = FocusNode();
  final FocusNode myFocusNodeFirstNameMother_2 = FocusNode();
  final FocusNode myFocusNodeLastNameMother_2 = FocusNode();

  //node type2
  TextEditingController editTitleNameAgentCompany = new TextEditingController();
  TextEditingController editIDNo_Company = new TextEditingController();
  TextEditingController editCompanyRegistrationNo_Company = new TextEditingController();
  TextEditingController editCompanyName = new TextEditingController();
  TextEditingController editExciseRegistrationNo_Company = new TextEditingController();
  TextEditingController editCompanyNameTitle = new TextEditingController();

  TextEditingController editCompany_agentFirstName = new TextEditingController();
  TextEditingController editCompany_agentLastName = new TextEditingController();

  TextEditingController editFirstNameFather_2 = new TextEditingController();
  TextEditingController editLastNameFather_2 = new TextEditingController();
  TextEditingController editFirstNameMother_2 = new TextEditingController();
  TextEditingController editLastNameMother_2 = new TextEditingController();

  TextEditingController editRaceOrganize = new TextEditingController();
  TextEditingController editNationality_company = new TextEditingController();

  TextEditingController editCompanyTitle = new TextEditingController();

  TextEditingController editCountry_company = new TextEditingController();
  TextEditingController editProvince2 = new TextEditingController();
  TextEditingController editDistrict2 = new TextEditingController();
  TextEditingController editSubDistrict2 = new TextEditingController();

  // Title Company
  ItemsListTitle sTitleHeadCompany;

  // Address Company
  ItemsListTitle _itemCompanyTitleValue;
  ItemsListCountry sCountry_company;
  ItemsListSubDistict sSubDistrict_company;
  ItemsListDistict sDistrict_company;
  ItemsListProvince sProvince_company;
  ItemsListRace sRace_company;
  ItemsListNational sNational_company;

  AutoCompleteTextField _textListCompanyTitle;
  AutoCompleteTextField _textListTitleNameCompany_agent;
  AutoCompleteTextField _textListTitleNameFatherHeadCompany;
  AutoCompleteTextField _textListTitleNameMotherHeadCompany;

  AutoCompleteTextField _textListRaceOrganize;
  AutoCompleteTextField _textListNationalityCompany;

  AutoCompleteTextField _textListCountry_company;
  AutoCompleteTextField _textListProvince2;
  AutoCompleteTextField _textListDistrict2;
  AutoCompleteTextField _textListSubDistrict2;
  // ---------------------------------------------------------------------------------

  // ----------------------------- Var Foreigner -------------------------------------
  // Focus Foriegner Info
  final FocusNode myFocusNodeFirstNameSus_foreigner = FocusNode();
  final FocusNode myFocusNodeLastNameSus_foreigner = FocusNode();
  final FocusNode myFocusNodeCareer_foreigner = FocusNode();

  final FocusNode myFocusNodeFirstNameFather_foreigner = FocusNode();
  final FocusNode myFocusNodeLastNameFather_foreigner = FocusNode();
  final FocusNode myFocusNodeFirstNameMother_foreigner = FocusNode();
  final FocusNode myFocusNodeLastNameMother_foreigner = FocusNode();

  final FocusNode myFocusNodePassportNo = FocusNode();
  final FocusNode myFocusNodePassportCountry = FocusNode();
  // Title Foreigner Info
  TextEditingController editTitleName_foreigner = new TextEditingController();
  TextEditingController editFirstNameSus_foreigner = new TextEditingController();
  TextEditingController editLastNameSus_foreigner = new TextEditingController();
  TextEditingController editRace_foreigner = new TextEditingController();
  TextEditingController editNationality_foreigner = new TextEditingController();
  TextEditingController editCareer_foreigner = new TextEditingController();
  // TextEditingController editRace_foreigner = new TextEditingController();

  // Title Foreigner Family
  TextEditingController editTitleNameFather_foreigner = new TextEditingController();
  TextEditingController editFirstNameFather_foreigner = new TextEditingController();
  TextEditingController editLastNameFather_foreigner = new TextEditingController();

  TextEditingController editTitleNameMother_foreigner = new TextEditingController();
  TextEditingController editFirstNameMother_foreigner = new TextEditingController();
  TextEditingController editLastNameMother_foreigner = new TextEditingController();

  TextEditingController editCountry_foreigner = new TextEditingController();

  // Title Foreigner
  ItemsListTitle sTitle_foreigner;
  ItemsListTitle sTitleMother_foreigner;
  ItemsListTitle sTitleFather_foreigner;

  // Address Foreigner
  ItemsListCountry sCountry_foreigner;
  ItemsListRace sRace_foreigner;
  ItemsListNational sNational_foreigner;

  // AutoComplete Foreigner
  AutoCompleteTextField _textListTitle_foreigner;
  AutoCompleteTextField _textListTitleNameFather_foreigner;
  AutoCompleteTextField _textListTitleNameMother_foreigner;
  AutoCompleteTextField _textListRace_foreigner;
  AutoCompleteTextField _textListNationality_foreigner;

  AutoCompleteTextField _textListCountry_foreigner;
  // ---------------------------------------------------------------------------------

  bool _suspectThai = false; // Thai
  bool _suspectCompany = false; // Organize
  bool _suspectForeigner = false; // Foreigner

  bool _entityLegal = true;
  bool _entityPeople = false;
  int entity = 1; // บุคคลธรรมดา 0, นิติบุคคล 1

  List<ItemsListArrestLawbreaker> _itemData = [];

  Future<File> _imageFile;
  List<ItemsListDocument> _arrItemsImageFile = [];

  List<ItemsListDocument> _arrItemsImageFileAdd = [];
  List<int> _arrItemsImageFileDelete = [];

  bool isImage = false;
  VoidCallback listener;

  Color labelColor = Color(0xff087de1);
  TextStyle textSearchByImgStyle = TextStyle(fontSize: 16.0, color: Colors.blue.shade400, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textStyleSelect = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  TextStyle textStyleStar = Styles.textStyleStar;

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    // ------------------- Call init setAutoCompleteTitle Thai ----------------------
    setAutoCompleteCountry();
    setAutoCompleteTitle();
    setAutoCompleteTitleFather();
    setAutoCompleteTitleMother();
    // ------------------------------------------------------------------------------

    // ------------------- Call init setAutoCompleteTitle Company -------------------
    setAutoCompleteCountry_company();
    setAutoCompleteCompanyTitle();
    setAutoCompleteTitleAgentCompany();
    // ------------------------------------------------------------------------------

    // ------------------- Call init setAutoCompleteTitle Foreigner -----------------
    setAutoCompleteCountry_foreigner();
    setAutoCompleteTitle_foreigner();
    setAutoCompleteTitleFather_foreigner();
    setAutoCompleteTitleMother_foreigner();

    // ------------------------------------------------------------------------------

    if (widget.IsUpdate) {
      List<ItemsListDocument> items = [];
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

      widget.ItemsPerson.PERSON_TYPE == 0 ? _suspectThai = true : widget.ItemsPerson.PERSON_TYPE == 1 ? _suspectForeigner = true : _suspectCompany = true;

      if (widget.ItemsPerson.PERSON_TYPE == 0) {
        // PERSON_TYPE == 0 > [Normal Peolpe] ******************************************************************
        if (widget.ItemsPerson.MAS_PERSON_ADDRESS.length > 0) {
          int SUB_DISTRICT_ID;
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item) {
            SUB_DISTRICT_ID = item.SUB_DISTRICT_ID;
          });
          if (SUB_DISTRICT_ID != null) {
            this.onLoadActionSubDistinctMaster(null, SUB_DISTRICT_ID, true);
          }
        } else {
          _onSelectCountry(1);
        }

        // ------------------------------------- TITLE Thai ---------------------------------------------------
        if (widget.ItemsPerson.TITLE_ID != null) {
          Map map_title = {
            "TITLE_ID": widget.ItemsPerson.TITLE_ID,
            "TITLE_NAME_TH": widget.ItemsPerson.TITLE_NAME_TH,
            "TITLE_NAME_EN": widget.ItemsPerson.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": widget.ItemsPerson.TITLE_SHORT_NAME_EN,
            "IS_ACTIVE": 1,
          };
          var body_title = json.encode(map_title);
          sTitle = ItemsListTitle.fromJson(json.decode(body_title));

          editTitleName.text = sTitle.TITLE_SHORT_NAME_TH != null ? sTitle.TITLE_SHORT_NAME_TH.toString() : sTitle.TITLE_NAME_TH.toString();
        }
        // ----------------------------------------------------------------------------------------------------
        // ------------------------------------- TITLE Family Thai --------------------------------------------
        if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length > 0) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 1) {
              editFirstNameFather.text = item.FIRST_NAME.toString();
              editLastNameFather.text = item.LAST_NAME.toString();
              Map map_title = {
                "TITLE_ID": item.TITLE_ID,
                "TITLE_NAME_TH": item.TITLE_NAME_TH,
                "TITLE_NAME_EN": item.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
                "IS_ACTIVE": 1,
              };
              var body_title = json.encode(map_title);
              sTitleFather = ItemsListTitle.fromJson(json.decode(body_title));
              if (sTitleFather != null) {
                // editTitleNameFather.text = sTitleFather.TITLE_SHORT_NAME_TH.toString();
                editTitleNameFather.text = sTitleFather.TITLE_SHORT_NAME_TH != null ? sTitleFather.TITLE_SHORT_NAME_TH.toString() : sTitleFather.TITLE_NAME_TH.toString();
              }
            } else if (item.RELATIONSHIP_ID == 2) {
              editFirstNameMother.text = item.FIRST_NAME.toString();
              editLastNameMother.text = item.LAST_NAME.toString();

              Map map_title = {
                "TITLE_ID": item.TITLE_ID,
                "TITLE_NAME_TH": item.TITLE_NAME_TH,
                "TITLE_NAME_EN": item.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
                "IS_ACTIVE": 1,
              };
              var body_title = json.encode(map_title);
              sTitleMother = ItemsListTitle.fromJson(json.decode(body_title));
              if (sTitleMother != null) {
                // editTitleNameMother.text = sTitleMother.TITLE_SHORT_NAME_TH.toString();
                editTitleNameMother.text = sTitleMother.TITLE_SHORT_NAME_TH != null ? sTitleMother.TITLE_SHORT_NAME_TH.toString() : sTitleMother.TITLE_NAME_TH.toString();
              }
            }
          });
        }
        // ----------------------------------------------------------------------------------------------------

        // ------------------------------------- FIRST_NAME Foreigner ---------------------------------------
        editFirstNameSus.text = widget.ItemsPerson.FIRST_NAME;
        // --------------------------------------------------------------------------------------------------

        // ------------------------------------- LAST_NAME Foreigner ----------------------------------------
        editLastNameSus.text = widget.ItemsPerson.LAST_NAME;
        // --------------------------------------------------------------------------------------------------

        // ------------------------------------- ID_CARD ------------------------------------------------
        editIDNo.text = widget.ItemsPerson.ID_CARD;
        // --------------------------------------------------------------------------------------------------

        // ------------------------------------- CAREER -----------------------------------------------------
        editCareer.text = widget.ItemsPerson.CAREER != null ? widget.ItemsPerson.CAREER : "";
        // --------------------------------------------------------------------------------------------------

        if (widget.ItemsPerson.NATIONALITY_ID != null) {
          this.onLoadActionNationalMaster(true, widget.ItemsPerson.NATIONALITY_ID);
        }
        if (widget.ItemsPerson.RACE_ID != null) {
          this.onLoadActionRaceMaster(true, widget.ItemsPerson.RACE_ID);
        }
      } else if (widget.ItemsPerson.PERSON_TYPE == 1) {
        // PERSON_TYPE == 1 > [Foreigner Peolpe] ******************************************************************
        // ------------------------------------- TITLE Foreigner ----------------------------------------------
        if (widget.ItemsPerson.TITLE_ID != null) {
          Map map_title = {
            "TITLE_ID": widget.ItemsPerson.TITLE_ID,
            "TITLE_NAME_TH": widget.ItemsPerson.TITLE_NAME_TH,
            "TITLE_NAME_EN": widget.ItemsPerson.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": widget.ItemsPerson.TITLE_SHORT_NAME_EN,
            "IS_ACTIVE": 1,
          };
          var body_title = json.encode(map_title);
          sTitle_foreigner = ItemsListTitle.fromJson(json.decode(body_title));
          editTitleName_foreigner.text = sTitle_foreigner.TITLE_SHORT_NAME_EN != null ? sTitle_foreigner.TITLE_SHORT_NAME_EN.toString() : sTitle_foreigner.TITLE_NAME_EN.toString();

          // if (sTitle_foreigner.TITLE_SHORT_NAME_TH != null) {
          //   editTitleName_foreigner.text = sTitle_foreigner.TITLE_SHORT_NAME_TH.toString();
          // } else {
          //   editTitleName_foreigner.text = sTitle_foreigner.TITLE_SHORT_NAME_EN.toString();
          // }
        }
        // ----------------------------------------------------------------------------------------------------
        // ------------------------------------- TITLE Family Foreigner ---------------------------------------
        if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length > 0) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 1) {
              editFirstNameFather_foreigner.text = item.FIRST_NAME.toString();
              editLastNameFather_foreigner.text = item.LAST_NAME.toString();
              Map map_title = {
                "TITLE_ID": item.TITLE_ID,
                "TITLE_NAME_TH": item.TITLE_NAME_TH,
                "TITLE_NAME_EN": item.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
                "IS_ACTIVE": 1,
              };
              var body_title = json.encode(map_title);
              sTitleFather_foreigner = ItemsListTitle.fromJson(json.decode(body_title));
              if (sTitleFather_foreigner != null) {
                editTitleNameFather_foreigner.text = sTitleFather_foreigner.TITLE_SHORT_NAME_EN != null ? sTitleFather_foreigner.TITLE_SHORT_NAME_EN.toString() : sTitleFather_foreigner.TITLE_NAME_EN.toString();
                // editTitleNameFather_foreigner.text = sTitleFather_foreigner.TITLE_SHORT_NAME_TH.toString();
              }
            } else if (item.RELATIONSHIP_ID == 2) {
              editFirstNameMother_foreigner.text = item.FIRST_NAME.toString();
              editLastNameMother_foreigner.text = item.LAST_NAME.toString();

              Map map_title = {
                "TITLE_ID": item.TITLE_ID,
                "TITLE_NAME_TH": item.TITLE_NAME_TH,
                "TITLE_NAME_EN": item.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
                "IS_ACTIVE": 1,
              };
              var body_title = json.encode(map_title);
              sTitleMother_foreigner = ItemsListTitle.fromJson(json.decode(body_title));
              if (sTitleMother_foreigner != null) {
                editTitleNameMother_foreigner.text = sTitleMother_foreigner.TITLE_SHORT_NAME_EN != null ? sTitleMother_foreigner.TITLE_SHORT_NAME_EN.toString() : sTitleMother_foreigner.TITLE_NAME_EN.toString();
                // editTitleNameMother_foreigner.text = sTitleMother_foreigner.TITLE_SHORT_NAME_TH.toString();
              }
            }
          });
        }
        // ------------------------------------- FIRST_NAME Foreigner ---------------------------------------
        editFirstNameSus_foreigner.text = widget.ItemsPerson.FIRST_NAME;
        // --------------------------------------------------------------------------------------------------

        // ------------------------------------- LAST_NAME Foreigner ----------------------------------------
        editLastNameSus_foreigner.text = widget.ItemsPerson.LAST_NAME;
        // --------------------------------------------------------------------------------------------------

        // ------------------------------------- PASSPORT_NO ------------------------------------------------
        editPassportNo.text = widget.ItemsPerson.PASSPORT_NO != null ? widget.ItemsPerson.PASSPORT_NO : "";
        // --------------------------------------------------------------------------------------------------

        // ------------------------------------- CAREER -----------------------------------------------------
        editCareer_foreigner.text = widget.ItemsPerson.CAREER != null ? widget.ItemsPerson.CAREER : "";
        // --------------------------------------------------------------------------------------------------

        if (widget.ItemsPerson.COUNTRY_ID != null) {
          this.onLoadActionCountryMaster_foreigner(widget.ItemsPerson.COUNTRY_ID, true);
        }

        if (widget.ItemsPerson.NATIONALITY_ID != null) {
          this.onLoadActionNationalMaster(true, widget.ItemsPerson.NATIONALITY_ID);
        } else {
          this.onLoadActionNationalMaster(false, null);
        }

        if (widget.ItemsPerson.RACE_ID != null) {
          this.onLoadActionRaceMaster(true, widget.ItemsPerson.RACE_ID);
        } else {
          this.onLoadActionRaceMaster(false, null);
        }
      } else {
        // PERSON_TYPE == 2 > [Company] **************************************************************************
        // ------------------------------------- ID_CARD ----------------------------------------------------
        editIDNo_Company.text = widget.ItemsPerson.ID_CARD != null ? widget.ItemsPerson.ID_CARD.toString() : "";
        // --------------------------------------------------------------------------------------------------

        editExciseRegistrationNo_Company.text = widget.ItemsPerson.EXCISE_REGISTRATION_NO != null ? widget.ItemsPerson.EXCISE_REGISTRATION_NO.toString() : "";
        editCompanyRegistrationNo_Company.text = widget.ItemsPerson.COMPANY_REGISTRATION_NO != null ? widget.ItemsPerson.COMPANY_REGISTRATION_NO.toString() : "";

        // ------------------------------------- TITLE COMPANY ----------------------------------------------
        Map map_title_comp = {
          "TITLE_ID": widget.ItemsPerson.TITLE_ID,
          "TITLE_NAME_TH": widget.ItemsPerson.TITLE_NAME_TH,
          "TITLE_NAME_EN": widget.ItemsPerson.TITLE_NAME_EN,
          "TITLE_SHORT_NAME_TH": widget.ItemsPerson.TITLE_SHORT_NAME_TH,
          "TITLE_SHORT_NAME_EN": widget.ItemsPerson.TITLE_SHORT_NAME_EN,
          "IS_ACTIVE": 1,
        };
        var body_title = json.encode(map_title_comp);
        _itemCompanyTitleValue = ItemsListTitle.fromJson(json.decode(body_title));
        if (_itemCompanyTitleValue != null) {
          editCompanyTitle.text = _itemCompanyTitleValue.TITLE_SHORT_NAME_TH != null ? _itemCompanyTitleValue.TITLE_SHORT_NAME_TH.toString() : _itemCompanyTitleValue.TITLE_NAME_TH.toString();
          // editCompanyTitle.text = _itemCompanyTitleValue.TITLE_SHORT_NAME_TH.toString();
        }
        // --------------------------------------------------------------------------------------------------

        // ------------------------------------- COMPANY_NAME -----------------------------------------------
        editCompanyName.text = widget.ItemsPerson.COMPANY_NAME.toString();
        // --------------------------------------------------------------------------------------------------

        // ------------------------------------- MAS_PERSON_ADDRESS -----------------------------------------
        if (widget.ItemsPerson.MAS_PERSON_ADDRESS.length > 0) {
          int SUB_DISTRICT_ID;
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item) {
            SUB_DISTRICT_ID = item.SUB_DISTRICT_ID;
          });
          if (SUB_DISTRICT_ID != null) {
            this.onLoadActionSubDistinctMaster(null, SUB_DISTRICT_ID, true);
          }
        } else {
          _onSelectCountry(1);
        }
        // --------------------------------------------------------------------------------------------------

        // ------------------------------------- MAS_PERSON_RELATIONSHIP ------------------------------------
        if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length > 0) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            print("RELATIONSHIP_ID : " + item.RELATIONSHIP_ID.toString());
            if (item.RELATIONSHIP_ID == 3) {
              editCompany_agentFirstName.text = item.FIRST_NAME.toString();
              editCompany_agentLastName.text = item.LAST_NAME.toString();

              Map map_title = {
                "TITLE_ID": item.TITLE_ID,
                "TITLE_NAME_TH": item.TITLE_NAME_TH,
                "TITLE_NAME_EN": item.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": item.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": item.TITLE_SHORT_NAME_EN,
                "IS_ACTIVE": 1,
              };
              var body_title = json.encode(map_title);
              sTitleHeadCompany = ItemsListTitle.fromJson(json.decode(body_title));
              if (sTitleHeadCompany != null) {
                editTitleNameAgentCompany.text = sTitleHeadCompany.TITLE_SHORT_NAME_TH != null ? sTitleHeadCompany.TITLE_SHORT_NAME_TH.toString() : sTitleHeadCompany.TITLE_NAME_TH.toString();
                // editTitleNameAgentCompany.text = sTitleHeadCompany.TITLE_SHORT_NAME_TH.toString();
              }
            }
          });
        } else {
          editTitleNameAgentCompany.text = "";
        }
        // --------------------------------------------------------------------------------------------------
        // ------------------------------------- NATIONALITY_ID ---------------------------------------------
        if (widget.ItemsPerson.NATIONALITY_ID != null) {
          this.onLoadActionNationalMaster(true, widget.ItemsPerson.NATIONALITY_ID);
        }
        // --------------------------------------------------------------------------------------------------
        // ------------------------------------- RACE_ID ----------------------------------------------------
        if (widget.ItemsPerson.RACE_ID != null) {
          this.onLoadActionRaceMaster(true, widget.ItemsPerson.RACE_ID);
        }
        // --------------------------------------------------------------------------------------------------
      }
      // ----------------------------------------------------------------------------------------------------

      // ------------------------------------- Set radio ----------------------------------------------------
      if (widget.ItemsPerson.PERSON_TYPE == 2) {
        // Organize
        _suspectCompany = true;
        _suspectThai = false;
        _suspectForeigner = false;
        if (widget.ItemsPerson.ENTITY_TYPE == 1) {
          _entityLegal = true;
          _entityPeople = false;
          entity = widget.ItemsPerson.ENTITY_TYPE;
        } else {
          _entityLegal = false;
          _entityPeople = true;
          entity = widget.ItemsPerson.ENTITY_TYPE;
        }
      } else if (widget.ItemsPerson.PERSON_TYPE == 1 && widget.ItemsPerson.ENTITY_TYPE == 0) {
        // Foreigner
        _suspectForeigner = true;
        _suspectCompany = false;
        _suspectThai = false;
      } else {
        // Thai
        _suspectCompany = false;
        _suspectThai = true;
        _suspectForeigner = false;
      }
    } else {
      // != IsUpdate
      _suspectThai = true;
      _onSelectCountry(1);
      onLoadActionNationalMaster(false, 1);
      onLoadActionRaceMaster(false, 1);
    }
  }

  void _onImageButtonPressed(ImageSource source, mContext) async {
    var _image = await ImagePicker.pickImage(source: source);
    //compare image
    var dir = await getTemporaryDirectory();
    List splits = _image.path.split("/");
    var targetPath = dir.absolute.path + "/" + splits.last;
    var image = await testCompressAndGetFile(_image, targetPath);

    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      if (widget.IsUpdate) {
        _arrItemsImageFileAdd.add(new ItemsListDocument(FILE_CONTENT: image, DOCUMENT_OLD_NAME: image.path));
      }

      _arrItemsImageFile.add(new ItemsListDocument(FILE_CONTENT: image, DOCUMENT_NAME: image.path, DOCUMENT_OLD_NAME: image.path));

      Navigator.pop(mContext);
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      List splits = image.path.split("/");
      isImage = true;
      if (widget.IsUpdate) {
        _arrItemsImageFileAdd.add(new ItemsListDocument(FILE_CONTENT: image, DOCUMENT_OLD_NAME: image.path));
      }

      _arrItemsImageFile.add(new ItemsListDocument(FILE_CONTENT: image, DOCUMENT_NAME: image.path, DOCUMENT_OLD_NAME: image.path));
    });
  }

  void _showDialogPicker() {
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
                  _onImageButtonPressed(ImageSource.camera, context);
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
                  _onImageButtonPressed(ImageSource.gallery, context);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    //node type1
    myFocusNodeIDNo.dispose();
    myFocusNodePassportNo.dispose();
    myFocusNodePassportCountry.dispose();

    myFocusNodeFirstNameSus.dispose();
    myFocusNodeLastNameSus.dispose();

    myFocusNodeFirstNameFather_1.dispose();
    myFocusNodeLastNameFather_1.dispose();
    myFocusNodeFirstNameMother_1.dispose();
    myFocusNodeLastNameMother_1.dispose();

    myFocusNodePlace.dispose();

    // Foreigner
    myFocusNodeFirstNameSus_foreigner.dispose();
    myFocusNodeLastNameSus_foreigner.dispose();
    myFocusNodeFirstNameFather_foreigner.dispose();
    myFocusNodeLastNameFather_foreigner.dispose();
    myFocusNodeFirstNameMother_foreigner.dispose();
    myFocusNodeLastNameMother_foreigner.dispose();
    //node type2
    editIDNo_Company.dispose();
    myFocusNodeEntityNo_Company.dispose();
    myFocusNodeCompanyName.dispose();
    myFocusNodeExciseRegistrationNo_Company.dispose();
    myFocusNodeCompanyNameTitle.dispose();

    myFocusNodeCompany_agentFirstName.dispose();
    myFocusNodeCompany_agentLastName.dispose();

    myFocusNodeFirstNameFather_2.dispose();
    myFocusNodeLastNameFather_2.dispose();
    myFocusNodeFirstNameMother_2.dispose();
    myFocusNodeLastNameMother_2.dispose();

    setDisposeAuto(_textListTitleName);
    setDisposeAuto(_textListTitleNameCompany_agent);
    setDisposeAuto(_textListTitleNameFatherHeadCompany);
    setDisposeAuto(_textListTitleNameMotherHeadCompany);
    setDisposeAuto(_textListTitleNameFather);
    setDisposeAuto(_textListTitleNameMother);
    setDisposeAuto(_textListRace);
    setDisposeAuto(_textListNationality);
    setDisposeAuto(_textListRaceOrganize);
    setDisposeAuto(_textListNationalityCompany);

    setDisposeAuto(_textListCountry_foreigner);
    setDisposeAuto(_textListTitle_foreigner);
    setDisposeAuto(_textListTitleNameFather_foreigner);
    setDisposeAuto(_textListTitleNameMother_foreigner);
    setDisposeAuto(_textListRace_foreigner);
    setDisposeAuto(_textListNationality_foreigner);
  }

  void setDisposeAuto(AutoCompleteTextField item) {
    if (item.textField.focusNode == null) {
      item.textField.focusNode.dispose();
    }
    if (item.textField.controller == null) {
      item.textField.controller.dispose();
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

  // --------------------------- AutoComplete Thai **************************************************
  // --------------------------- AutoCompleteTitle Foreigner ----------------------
  void setAutoCompleteTitle() {
    GlobalKey key_title = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleName = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleName,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListTitleName.textField.controller.text = item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH.toString() : item.TITLE_NAME_TH.toString();
          sTitle = item;
        });
        if (!mounted) return;
      },
      key: key_title,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sTitle == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH.toString() : suggestion.TITLE_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sTitle = null;
        return ((suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH : suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase()));
      },
    );
  }

  // ------------------------------------------------------------------------------
  // --------------------------- AutoCompleteCountry Thai -------------------------
  void setAutoCompleteCountry() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListCountry>>();
    _textListCountry = new AutoCompleteTextField<ItemsListCountry>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editCountry,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListCountry.textField.controller.text = item.COUNTRY_NAME_TH.toString();

          sCountry = item;
          sProvince = null;
          sDistrict = null;
          sSubDistrict = null;
          _onSelectCountry(sCountry.COUNTRY_ID);
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemCountry.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sCountry == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.COUNTRY_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.COUNTRY_ID == b.COUNTRY_ID ? 0 : a.COUNTRY_ID > b.COUNTRY_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sCountry = null;
        return suggestion.COUNTRY_NAME_TH.trim().startsWith(input.trim());
      },
    );
  }

  // ------------------------------------------------------------------------------
  // --------------------------- AutoCompleteProvince Thai ------------------------
  void setAutoCompleteProvince() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListProvince>>();
    _textListProvince = new AutoCompleteTextField<ItemsListProvince>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editProvince,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListProvince.textField.controller.text = item.PROVINCE_NAME_TH.toString();

          sProvince = item;

          editDistrict.text = "";
          editSubDistrict.text = "";
          sDistrict = null;
          sSubDistrict = null;

          _onSelectProvince(sProvince.PROVINCE_ID);
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemProvince.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sProvince == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.PROVINCE_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PROVINCE_ID == b.PROVINCE_ID ? 0 : a.PROVINCE_ID > b.PROVINCE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProvince = null;
        return suggestion.PROVINCE_NAME_TH.trim().startsWith(input.trim());
      },
    );
  }

  // ------------------------------------------------------------------------------
  // --------------------------- AutoCompleteDistrict Thai ------------------------
  void setAutoCompleteDistrict() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListDistict>>();
    _textListDistrict = new AutoCompleteTextField<ItemsListDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editDistrict,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListDistrict.textField.controller.text = item.DISTRICT_NAME_TH.toString();

          sDistrict = item;
          ItemDistrict.RESPONSE_DATA.forEach((f) {
            if (f.DISTRICT_NAME_TH.endsWith(sDistrict.DISTRICT_NAME_TH)) {
              editSubDistrict.text = "";
              sSubDistrict = null;
              _onSelectDistrict(f.DISTRICT_ID);
            }
          });
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sDistrict == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.DISTRICT_NAME_TH, style: textInputStyle),
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

  // ------------------------------------------------------------------------------
  // --------------------------- AutoCompleteSubDistrict Thai ---------------------
  void setAutoCompleteSubDistrict() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListSubDistict>>();
    _textListSubDistrict = new AutoCompleteTextField<ItemsListSubDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editSubDistrict,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListSubDistrict.textField.controller.text = item.SUB_DISTRICT_NAME_TH.toString();

          sSubDistrict = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemSubDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sSubDistrict == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.SUB_DISTRICT_NAME_TH, style: textInputStyle),
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

  // ------------------------------------------------------------------------------
  // --------------------------- AutoCompleteTitleFather Thai ---------------------
  void setAutoCompleteTitleFather() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameFather = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameFather,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListTitleNameFather.textField.controller.text = item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH.toString() : item.TITLE_NAME_TH.toString();
          sTitleFather = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sTitleFather == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH.toString() : suggestion.TITLE_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sTitleFather = null;
        return (suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH : suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  // ------------------------------------------------------------------------------
  // --------------------------- AutoCompleteTitleMother Thai ---------------------
  void setAutoCompleteTitleMother() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameMother = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameMother,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListTitleNameMother.textField.controller.text = item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH.toString() : item.TITLE_NAME_TH.toString();
          sTitleMother = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sTitleMother == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH.toString() : suggestion.TITLE_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sTitleMother = null;
        return (suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH : suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  // ------------------------------------------------------------------------------
  // --------------------------- AutoCompleteNationalty Thai ----------------------
  void setAutoCompleteNationality() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListNational>>();
    _textListNationality = new AutoCompleteTextField<ItemsListNational>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editNationality,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListNationality.textField.controller.text = item.NATIONALITY_NAME_TH.toString();
          sNational = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemNationality.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sNational == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.NATIONALITY_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.NATIONALITY_ID == b.NATIONALITY_ID ? 0 : a.NATIONALITY_ID > b.NATIONALITY_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sNational = null;
        return (suggestion.NATIONALITY_NAME_TH != null ? suggestion.NATIONALITY_NAME_TH : suggestion.NATIONALITY_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  // ------------------------------------------------------------------------------
  // --------------------------- AutoCompleteRace Thai ----------------------------
  void setAutoCompleteRace() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListRace>>();
    _textListRace = new AutoCompleteTextField<ItemsListRace>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editRace,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListRace.textField.controller.text = item.RACE_NAME_TH.toString();
          sRace = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemMasRace.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sRace == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.RACE_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.RACE_ID == b.RACE_ID ? 0 : a.RACE_ID > b.RACE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sRace = null;
        return (suggestion.RACE_NAME_TH != null ? suggestion.RACE_NAME_TH : suggestion.RACE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }
  // ------------------------------------------------------------------------------

  // --------------------------- AutoComplete Foreigner **************************************************
  // --------------------------- AutoCompleteCountry Foreigner --------------------
  void setAutoCompleteCountry_foreigner() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListCountry>>();
    _textListCountry_foreigner = new AutoCompleteTextField<ItemsListCountry>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editCountry_foreigner,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListCountry_foreigner.textField.controller.text = item.COUNTRY_NAME_TH.toString();

          sCountry_foreigner = item;
          _onSelectCountry_foreigner(sCountry_foreigner.COUNTRY_ID);
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemCountry.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sCountry_foreigner == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.COUNTRY_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.COUNTRY_ID == b.COUNTRY_ID ? 0 : a.COUNTRY_ID > b.COUNTRY_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sCountry_foreigner = null;
        // return suggestion.COUNTRY_NAME_TH.trim().startsWith(input.trim());
        return ((suggestion.COUNTRY_NAME_TH != null ? suggestion.COUNTRY_NAME_TH : suggestion.COUNTRY_NAME_EN).toString().toLowerCase().startsWith(input.toLowerCase()));
      },
    );
  }

  // --------------------------- AutoCompleteTitle Foreigner -------------------------
  // ---------------------------------------------------------------------------------
  void setAutoCompleteTitle_foreigner() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitle_foreigner = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleName_foreigner,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListTitle_foreigner.textField.controller.text = item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN.toString() : item.TITLE_NAME_EN.toString();
          sTitle_foreigner = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sTitle_foreigner == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.TITLE_SHORT_NAME_EN != null ? suggestion.TITLE_SHORT_NAME_EN.toString() : suggestion.TITLE_NAME_EN.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sTitle_foreigner = null;
        return ((suggestion.TITLE_SHORT_NAME_EN != null ? suggestion.TITLE_SHORT_NAME_EN : suggestion.TITLE_NAME_EN).toString().toLowerCase().startsWith(input.toLowerCase()));
      },
    );
  }

  // ----------------------------------------------------------------------------------
  // --------------------------- AutoCompleteRace Foreigner ---------------------------
  void setAutoCompleteRace_foreigner() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListRace>>();
    _textListRace_foreigner = new AutoCompleteTextField<ItemsListRace>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editRace_foreigner,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListRace_foreigner.textField.controller.text = item.RACE_NAME_TH.toString();
          sRace_foreigner = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemMasRace.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sRace_foreigner == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.RACE_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.RACE_ID == b.RACE_ID ? 0 : a.RACE_ID > b.RACE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sRace_foreigner = null;
        return (suggestion.RACE_NAME_TH != null ? suggestion.RACE_NAME_TH : suggestion.RACE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  // ---------------------------------------------------------------------------------
  // --------------------------- AutoCompleteNationality Foreigner -------------------
  void setAutoCompleteNationality_foreigner() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListNational>>();
    _textListNationality_foreigner = new AutoCompleteTextField<ItemsListNational>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editNationality_foreigner,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListNationality_foreigner.textField.controller.text = item.NATIONALITY_NAME_TH.toString();
          sNational_foreigner = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemNationality.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sNational_foreigner == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.NATIONALITY_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.NATIONALITY_ID == b.NATIONALITY_ID ? 0 : a.NATIONALITY_ID > b.NATIONALITY_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sNational_foreigner = null;
        return (suggestion.NATIONALITY_NAME_TH != null ? suggestion.NATIONALITY_NAME_TH : suggestion.NATIONALITY_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  // ---------------------------------------------------------------------------------
  // --------------------------- AutoCompleteTitleMother Foreigner -------------------
  void setAutoCompleteTitleMother_foreigner() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameMother_foreigner = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameMother_foreigner,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListTitleNameMother_foreigner.textField.controller.text = item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN.toString() : item.TITLE_NAME_EN.toString();
          sTitleMother_foreigner = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sTitleMother_foreigner == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.TITLE_SHORT_NAME_EN != null ? suggestion.TITLE_SHORT_NAME_EN.toString() : suggestion.TITLE_NAME_EN.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sTitleMother_foreigner = null;
        return (suggestion.TITLE_SHORT_NAME_EN != null ? suggestion.TITLE_SHORT_NAME_EN : suggestion.TITLE_NAME_EN).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  // ---------------------------------------------------------------------------------
  // --------------------------- AutoCompleteTitleFather Foreigner -------------------
  void setAutoCompleteTitleFather_foreigner() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameFather_foreigner = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameFather_foreigner,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListTitleNameFather_foreigner.textField.controller.text = item.TITLE_SHORT_NAME_EN != null ? item.TITLE_SHORT_NAME_EN.toString() : item.TITLE_NAME_EN.toString();
          sTitleFather_foreigner = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sTitleFather_foreigner == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.TITLE_SHORT_NAME_EN != null ? suggestion.TITLE_SHORT_NAME_EN.toString() : suggestion.TITLE_NAME_EN.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sTitleFather_foreigner = null;
        return (suggestion.TITLE_SHORT_NAME_EN != null ? suggestion.TITLE_SHORT_NAME_EN : suggestion.TITLE_NAME_EN).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }
  // ---------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------

  // --------------------------- AutoComplete Company **************************************************
  // --------------------------- AutoCompleteTitleAgent Company ----------------------
  void setAutoCompleteTitleAgentCompany() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListTitleNameCompany_agent = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editTitleNameAgentCompany,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListTitleNameCompany_agent.textField.controller.text = item.TITLE_SHORT_NAME_TH != null ? item.TITLE_SHORT_NAME_TH.toString() : item.TITLE_NAME_TH.toString();
          sTitleHeadCompany = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sTitleHeadCompany == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH.toString() : suggestion.TITLE_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sTitleHeadCompany = null;
        return (suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH : suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteRace_company() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListRace>>();
    _textListRaceOrganize = new AutoCompleteTextField<ItemsListRace>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editRaceOrganize,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListRaceOrganize.textField.controller.text = item.RACE_NAME_TH.toString();
          sRace_company = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemMasRace.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sRace_company == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.RACE_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.RACE_ID == b.RACE_ID ? 0 : a.RACE_ID > b.RACE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sRace_company = null;
        return (suggestion.RACE_NAME_TH != null ? suggestion.RACE_NAME_TH : suggestion.RACE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteNationality_company() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListNational>>();
    _textListNationalityCompany = new AutoCompleteTextField<ItemsListNational>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      controller: editNationality_company,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListNationalityCompany.textField.controller.text = item.NATIONALITY_NAME_TH.toString();
          sNational_company = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemNationality.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sNational_company == null
          ? new Padding(
              child: new ListTile(
                  title: new Text(
                suggestion.NATIONALITY_NAME_TH.toString(),
                style: textInputStyle,
              )),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.NATIONALITY_ID == b.NATIONALITY_ID ? 0 : a.NATIONALITY_ID > b.NATIONALITY_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sNational_company = null;
        return (suggestion.NATIONALITY_NAME_TH != null ? suggestion.NATIONALITY_NAME_TH : suggestion.NATIONALITY_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

//*******************************************************ปิดเพิ่ม********************************************************** */
  //Company Title
  void setAutoCompleteCompanyTitle() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListTitle>>();
    _textListCompanyTitle = new AutoCompleteTextField<ItemsListTitle>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editCompanyTitle,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListCompanyTitle.textField.controller.text = item.TITLE_SHORT_NAME_TH.toString();
          _itemCompanyTitleValue = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemTitle.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => _itemCompanyTitleValue == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.TITLE_SHORT_NAME_TH.toString(), style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.TITLE_ID == b.TITLE_ID ? 0 : a.TITLE_ID > b.TITLE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        _itemCompanyTitleValue = null;
        return (suggestion.TITLE_SHORT_NAME_TH != null ? suggestion.TITLE_SHORT_NAME_TH : suggestion.TITLE_NAME_TH).toLowerCase().startsWith(input.toLowerCase());
      },
    );
  }

  //Address Type 2
  void setAutoCompleteCountry_company() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListCountry>>();
    _textListCountry_company = new AutoCompleteTextField<ItemsListCountry>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editCountry_company,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListCountry_company.textField.controller.text = item.COUNTRY_NAME_TH.toString();

          sCountry_company = item;
          sProvince_company = null;
          sDistrict_company = null;
          sSubDistrict_company = null;
          _onSelectCountry(sCountry_company.COUNTRY_ID);
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: widget.ItemCountry.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sCountry_company == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.COUNTRY_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.COUNTRY_ID == b.COUNTRY_ID ? 0 : a.COUNTRY_ID > b.COUNTRY_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sCountry_company = null;
        // return suggestion.COUNTRY_NAME_TH.trim().startsWith(input.trim());
        return ((suggestion.COUNTRY_NAME_TH != null ? suggestion.COUNTRY_NAME_TH : suggestion.COUNTRY_NAME_EN).toString().toLowerCase().startsWith(input.toLowerCase()));
      },
    );
  }

  void setAutoCompleteProvinceCompany() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListProvince>>();
    _textListProvince2 = new AutoCompleteTextField<ItemsListProvince>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editProvince2,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListProvince2.textField.controller.text = item.PROVINCE_NAME_TH.toString();

          sProvince_company = item;

          editDistrict2.text = "";
          editSubDistrict2.text = "";
          sDistrict_company = null;
          sSubDistrict_company = null;

          print(sProvince_company.PROVINCE_NAME_TH);
          _onSelectProvince(sProvince_company.PROVINCE_ID);
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemProvince.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sProvince_company == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.PROVINCE_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.PROVINCE_ID == b.PROVINCE_ID ? 0 : a.PROVINCE_ID > b.PROVINCE_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sProvince_company = null;
        return suggestion.PROVINCE_NAME_TH.trim().startsWith(input.trim());
      },
    );
  }

  void setAutoCompleteDistrict2() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListDistict>>();
    _textListDistrict2 = new AutoCompleteTextField<ItemsListDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editDistrict2,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListDistrict2.textField.controller.text = item.DISTRICT_NAME_TH.toString();

          sDistrict_company = item;
          ItemDistrict.RESPONSE_DATA.forEach((f) {
            if (f.DISTRICT_NAME_TH.endsWith(sDistrict_company.DISTRICT_NAME_TH)) {
              editSubDistrict2.text = "";
              sSubDistrict_company = null;
              _onSelectDistrict(f.DISTRICT_ID);
            }
          });
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sDistrict_company == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.DISTRICT_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.DISTRICT_ID == b.DISTRICT_ID ? 0 : a.DISTRICT_ID > b.DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sDistrict_company = null;
        return suggestion.DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
  }

  void setAutoCompleteSubDistrict2() {
    GlobalKey key = new GlobalKey<AutoCompleteTextFieldState<ItemsListSubDistict>>();
    _textListSubDistrict2 = new AutoCompleteTextField<ItemsListSubDistict>(
      style: textInputStyle,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
      clearOnSubmit: false,
      controller: editSubDistrict2,
      submitOnSuggestionTap: true,
      itemSubmitted: (item) {
        setState(() {
          _textListSubDistrict2.textField.controller.text = item.SUB_DISTRICT_NAME_TH.toString();

          sSubDistrict_company = item;
        });
        if (!mounted) return;
      },
      key: key,
      suggestions: ItemSubDistrict.RESPONSE_DATA,
      itemBuilder: (context, suggestion) => sSubDistrict_company == null
          ? new Padding(
              child: new ListTile(
                title: new Text(suggestion.SUB_DISTRICT_NAME_TH, style: textInputStyle),
              ),
              padding: EdgeInsets.all(8.0))
          : Container(),
      itemSorter: (a, b) => a.SUB_DISTRICT_ID == b.SUB_DISTRICT_ID ? 0 : a.SUB_DISTRICT_ID > b.SUB_DISTRICT_ID ? -1 : 1,
      itemFilter: (suggestion, input) {
        sSubDistrict_company = null;
        return suggestion.SUB_DISTRICT_NAME_TH.toLowerCase().contains(input.toLowerCase());
      },
    );
  }
  // ---------------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------

  Widget _buildButtonImgPicker() {
    var size = MediaQuery.of(context).size;
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: uploadColor, fontFamily: FontStyles().FontFamily);
    return Container(
      padding: EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Card(
              shape: new RoundedRectangleBorder(side: new BorderSide(color: boxColor, width: 1.5), borderRadius: BorderRadius.circular(42.0)),
              elevation: 0.0,
              child: Container(
                //width: size.width / 2,
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: MaterialButton(
                  onPressed: () {
                    _showDialogPicker();
                    //getImage();
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
                              widget.IsNotice ? "แนบรูปผู้ต้องสงสัย" : "แนบรูปผู้ต้องหา",
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
    TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    return Container(
      padding: EdgeInsets.only(bottom: 22.0),
      child: ListView.builder(
          itemCount: _arrItemsImageFile.length,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(top: 0.3, bottom: 0.3),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Colors.white,
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
                        child: Icon(
                          Icons.delete_outline,
                          size: 32.0,
                          color: Colors.grey[500],
                        ),
                        onPressed: () {
                          setState(() {
                            //print(index.toString());
                            if (widget.IsUpdate) {
                              /*try {
                                _arrItemsImageFileDelete.add(
                                    _arrItemsImageFile[index].DOCUMENT_ID);
                              } catch (e) {
                                _arrItemsImageFileAdd.removeAt(index);
                              }*/
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

  void _onSaved(mContext) async {
    bool IsSuccess = false;
    if (_suspectThai) {
      if (editIDNo.text.isNotEmpty && !checkID(editIDNo.text)) {
        new VerifyDialog(context, "กรุณากรอกรหัสบัตรประชาชนให้ถูกต้อง");
      } else if (sTitle == null) {
        new VerifyDialog(mContext, widget.IsNotice ? "กรุณาเลือกคำนำหน้าชื่อผู้ต้องสงสัย" : 'กรุณาเลือกคำนำหน้าชื่อผู้ต้องหา');
      } else if (editFirstNameSus.text.isEmpty || editLastNameSus.text.isEmpty) {
        new VerifyDialog(mContext, widget.IsNotice ? "กรุณากรอกชื่อผู้ต้องสงสัย" : 'กรุณากรอกชื่อผู้ต้องหา');
      } else {
        IsSuccess = true;
      }
    } else if (_suspectForeigner) {
      if (sTitle_foreigner == null) {
        new VerifyDialog(mContext, widget.IsNotice ? "กรุณาเลือกคำนำหน้าชื่อผู้ต้องสงสัย" : 'กรุณาเลือกคำนำหน้าชื่อผู้ต้องหา');
      } else if (editFirstNameSus_foreigner.text.isEmpty || editLastNameSus_foreigner.text.isEmpty) {
        new VerifyDialog(mContext, widget.IsNotice ? "กรุณากรอกชื่อผู้ต้องสงสัย" : 'กรุณากรอกชื่อผู้ต้องหา');
      } else {
        IsSuccess = true;
      }
    } else {
      if (editIDNo_Company.text.isNotEmpty && !checkID(editIDNo_Company.text)) {
        new VerifyDialog(context, "กรุณากรอกรหัสบัตรประชาชนให้ถูกต้อง");
      } else if (_itemCompanyTitleValue == null) {
        new VerifyDialog(mContext, 'กรุณาเลือกคำนำหน้าชื่อผู้ประกอบการ');
      } else if (editCompanyName.text.isEmpty) {
        new VerifyDialog(mContext, 'กรุณากรอกชื่อผู้ประกอบการ');
      } else {
        IsSuccess = true;
      }
    }

    if (IsSuccess) {
      String firstname, lastname;

      if (_suspectThai) {
        firstname = editFirstNameSus.text;
        lastname = editLastNameSus.text;
      } else if (_suspectForeigner) {
        firstname = editFirstNameSus_foreigner.text;
        lastname = editLastNameSus_foreigner.text;
      } else {
        firstname = _itemCompanyTitleValue.TITLE_NAME_TH;
        lastname = editCompanyName.text;
      }

      // ********************************** Map **********************************
      if (!widget.IsUpdate) {
        List<Map> map_photo = [];
        _arrItemsImageFileAdd.forEach((file) {
          List<int> imageBytes = file.FILE_CONTENT.readAsBytesSync();
          String base64Image = base64Encode(imageBytes);
          map_photo.add({"PHOTO_ID": "", "PERSON_ID": "", "PERSON_RELATIONSHIP_ID": "", "PHOTO": base64Image, "TYPE": "", "IS_ACTIVE": 1});
        });

        // ------------------------------------ Map Thai ------------------------------------
        List<Map> map_relationship = [];
        if (sTitleFather != null) {
          map_relationship.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 1,
            "PERSON_ID": "",
            "TITLE_ID": sTitleFather.TITLE_ID,
            "TITLE_NAME_TH": sTitleFather.TITLE_NAME_TH,
            "TITLE_NAME_EN": sTitleFather.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": sTitleFather.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": sTitleFather.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": editFirstNameFather.text,
            "MIDDLE_NAME": "",
            "LAST_NAME": editLastNameFather.text,
            "OTHER_NAME": "",
            "GENDER_TYPE": 1,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }
        if (sTitleMother != null) {
          map_relationship.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 2,
            "PERSON_ID": "",
            "TITLE_ID": sTitleMother.TITLE_ID,
            "TITLE_NAME_TH": sTitleMother.TITLE_NAME_TH,
            "TITLE_NAME_EN": sTitleMother.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": sTitleMother.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": sTitleMother.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": editFirstNameMother.text,
            "MIDDLE_NAME": "",
            "LAST_NAME": editLastNameMother.text,
            "OTHER_NAME": "",
            "GENDER_TYPE": 2,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }

        Map map = {
          "PERSON_ID": "",
          "COUNTRY_ID": sCountry != null ? sCountry.COUNTRY_ID : 1,
          "NATIONALITY_ID": sNational != null ? sNational.NATIONALITY_ID : "",
          "RACE_ID": sRace != null ? sRace.RACE_ID : "",
          "RELIGION_ID": "",
          "TITLE_ID": sTitle != null ? sTitle.TITLE_ID : "",
          "PERSON_TYPE": 0,
          "ENTITY_TYPE": 0,
          "TITLE_NAME_TH": sTitle != null ? sTitle.TITLE_NAME_TH : "",
          "TITLE_NAME_EN": sTitle != null ? sTitle.TITLE_NAME_EN : "",
          // "TITLE_SHORT_NAME_TH": ItemTitle != null ? ItemTitle.TITLE_SHORT_NAME_TH : _itemCompanyTitleValue,
          "TITLE_SHORT_NAME_TH": sTitle != null ? sTitle.TITLE_SHORT_NAME_TH : "",
          "TITLE_SHORT_NAME_EN": sTitle != null ? sTitle.TITLE_SHORT_NAME_EN : "",
          "FIRST_NAME": editFirstNameSus.text,
          "MIDDLE_NAME": "",
          "LAST_NAME": editLastNameSus.text,
          "OTHER_NAME": "",
          "COMPANY_NAME": "",
          "COMPANY_REGISTRATION_NO": "",
          "COMPANY_FOUND_DATE": "",
          "COMPANY_LICENSE_NO": "",
          "COMPANY_LICENSE_DATE_FROM": "",
          "COMPANY_LICENSE_DATE_TO": "",
          "EXCISE_REGISTRATION_NO": "",
          "GENDER_TYPE": 0,
          "ID_CARD": editIDNo.text,
          "BIRTH_DATE": "",
          "BLOOD_TYPE": "",
          "PASSPORT_NO": "",
          "VISA_TYPE": "",
          "PASSPORT_DATE_IN": "",
          "PASSPORT_DATE_OUT": "",
          "MARITAL_STATUS": 0,
          "CAREER": editCareer.text,
          "PERSON_DESC": "",
          "EMAIL": "",
          "TEL_NO": "",
          "MISTREAT_NO": 0,
          "IS_ILLEGAL": 1,
          "IS_ACTIVE": 1,
          "MAS_PERSON_ADDRESS": sSubDistrict != null
              ? [
                  {
                    "PERSON_ADDRESS_ID": "",
                    "PERSON_ID": "",
                    "SUB_DISTRICT_ID": sSubDistrict.SUB_DISTRICT_ID,
                    "GPS": "",
                    "ADDRESS_NO": "",
                    "VILLAGE_NO": "",
                    "BUILDING_NAME": "",
                    "ROOM_NO": "",
                    "FLOOR": "",
                    "VILLAGE_NAME": "",
                    "ALLEY": "",
                    "LANE": "",
                    "ROAD": "",
                    "ADDRESS_TYPE": 0,
                    "ADDRESS_DESC": "",
                    "ADDRESS_STATUS": 0,
                    "IS_ACTIVE": 1
                  }
                ]
              : [],
          "MAS_PERSON_RELATIONSHIP": map_relationship,
          "MAS_PERSON_PHOTO": map_photo,
        };
        // ---------------------------------------------------------------------------------------

        // ------------------------------------ Map Foreigner ------------------------------------
        List<Map> map_relationship_foreigner = [];
        if (sTitleFather_foreigner != null) {
          map_relationship_foreigner.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 1,
            "PERSON_ID": "",
            "TITLE_ID": sTitleFather_foreigner.TITLE_ID,
            "TITLE_NAME_TH": sTitleFather_foreigner.TITLE_NAME_TH,
            "TITLE_NAME_EN": sTitleFather_foreigner.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": sTitleFather_foreigner.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": sTitleFather_foreigner.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": editFirstNameFather_foreigner.text,
            "MIDDLE_NAME": "",
            "LAST_NAME": editLastNameFather_foreigner.text,
            "OTHER_NAME": "",
            "GENDER_TYPE": 1,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }
        if (sTitleMother_foreigner != null) {
          map_relationship_foreigner.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 2,
            "PERSON_ID": "",
            "TITLE_ID": sTitleMother_foreigner.TITLE_ID,
            "TITLE_NAME_TH": sTitleMother_foreigner.TITLE_NAME_TH,
            "TITLE_NAME_EN": sTitleMother_foreigner.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": sTitleMother_foreigner.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": sTitleMother_foreigner.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": editFirstNameMother_foreigner.text,
            "MIDDLE_NAME": "",
            "LAST_NAME": editLastNameMother_foreigner.text,
            "OTHER_NAME": "",
            "GENDER_TYPE": 2,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }

        Map map_foreigner = {
          "PERSON_ID": "",
          "COUNTRY_ID": sCountry_foreigner != null ? sCountry_foreigner.COUNTRY_ID : "",
          "NATIONALITY_ID": sNational_foreigner != null ? sNational_foreigner.NATIONALITY_ID : "",
          "RACE_ID": sRace_foreigner != null ? sRace_foreigner.RACE_ID : "",
          "RELIGION_ID": "",
          "TITLE_ID": sTitle_foreigner != null ? sTitle_foreigner.TITLE_ID : "",
          "PERSON_TYPE": 1,
          "ENTITY_TYPE": 0,
          "TITLE_NAME_TH": sTitle_foreigner != null ? sTitle_foreigner.TITLE_NAME_TH : "",
          "TITLE_NAME_EN": sTitle_foreigner != null ? sTitle_foreigner.TITLE_NAME_EN : "",
          // "TITLE_SHORT_NAME_TH": ItemTitle != null ? ItemTitle.TITLE_SHORT_NAME_TH : _itemCompanyTitleValue,
          "TITLE_SHORT_NAME_TH": sTitle_foreigner != null ? sTitle_foreigner.TITLE_SHORT_NAME_TH : "",
          "TITLE_SHORT_NAME_EN": sTitle_foreigner != null ? sTitle_foreigner.TITLE_SHORT_NAME_EN : "",
          "FIRST_NAME": editFirstNameSus_foreigner.text,
          "MIDDLE_NAME": "",
          "LAST_NAME": editLastNameSus_foreigner.text,
          "OTHER_NAME": "",
          "COMPANY_NAME": "",
          "COMPANY_REGISTRATION_NO": "",
          "COMPANY_FOUND_DATE": "",
          "COMPANY_LICENSE_NO": "",
          "COMPANY_LICENSE_DATE_FROM": "",
          "COMPANY_LICENSE_DATE_TO": "",
          "EXCISE_REGISTRATION_NO": "",
          "GENDER_TYPE": 0,
          "ID_CARD": "",
          "BIRTH_DATE": "",
          "BLOOD_TYPE": "",
          "PASSPORT_NO": editPassportNo.text,
          "VISA_TYPE": "",
          "PASSPORT_DATE_IN": "",
          "PASSPORT_DATE_OUT": "",
          "MARITAL_STATUS": 0,
          "CAREER": editCareer_foreigner.text,
          "PERSON_DESC": "",
          "EMAIL": "",
          "TEL_NO": "",
          "MISTREAT_NO": 0,
          "IS_ILLEGAL": 1,
          "IS_ACTIVE": 1,
          "MAS_PERSON_ADDRESS": [],
          "MAS_PERSON_RELATIONSHIP": map_relationship_foreigner,
          "MAS_PERSON_PHOTO": map_photo,
        };
        // --------------------------------------------------------------------------------------

        // ------------------------------------ Map Organize ------------------------------------
        Map map_company = {
          "PERSON_ID": "",
          "COUNTRY_ID": sCountry_company != null ? sCountry_company.COUNTRY_ID : "",
          "NATIONALITY_ID": sNational_company != null ? sNational_company.NATIONALITY_ID : "",
          "RACE_ID": sRace_company != null ? sRace_company.RACE_ID : "",
          "RELIGION_ID": "",
          "TITLE_ID": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_ID : "",
          "PERSON_TYPE": 2,
          "ENTITY_TYPE": entity,
          "TITLE_NAME_TH": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_NAME_TH : "",
          "TITLE_NAME_EN": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_NAME_EN : "",
          "TITLE_SHORT_NAME_TH": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_SHORT_NAME_TH : "",
          "TITLE_SHORT_NAME_EN": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_SHORT_NAME_EN : "",
          "FIRST_NAME": "",
          "MIDDLE_NAME": "",
          "LAST_NAME": "",
          "OTHER_NAME": "",
          "COMPANY_NAME": editCompanyName.text,
          "COMPANY_REGISTRATION_NO": editCompanyRegistrationNo_Company.text,
          "COMPANY_FOUND_DATE": "",
          "COMPANY_LICENSE_NO": "",
          "COMPANY_LICENSE_DATE_FROM": "",
          "COMPANY_LICENSE_DATE_TO": "",
          "EXCISE_REGISTRATION_NO": editExciseRegistrationNo_Company.text,
          "GENDER_TYPE": 0,
          "ID_CARD": editIDNo_Company.text,
          "BIRTH_DATE": "",
          "BLOOD_TYPE": "",
          "PASSPORT_NO": "",
          "VISA_TYPE": "",
          "PASSPORT_DATE_IN": "",
          "PASSPORT_DATE_OUT": "",
          "MARITAL_STATUS": 0,
          "CAREER": "",
          "PERSON_DESC": "",
          "EMAIL": "",
          "TEL_NO": "",
          "MISTREAT_NO": 0,
          "IS_ILLEGAL": 1,
          "IS_ACTIVE": 1,
          "MAS_PERSON_ADDRESS": sSubDistrict_company != null
              ? [
                  {
                    "PERSON_ADDRESS_ID": "",
                    "PERSON_ID": "",
                    "SUB_DISTRICT_ID": sSubDistrict_company.SUB_DISTRICT_ID,
                    "GPS": "",
                    "ADDRESS_NO": "",
                    "VILLAGE_NO": "",
                    "BUILDING_NAME": "",
                    "ROOM_NO": "",
                    "FLOOR": "",
                    "VILLAGE_NAME": "",
                    "ALLEY": "",
                    "LANE": "",
                    "ROAD": "",
                    "ADDRESS_TYPE": 0,
                    "ADDRESS_DESC": "",
                    "ADDRESS_STATUS": 0,
                    "IS_ACTIVE": 1
                  }
                ]
              : [],
          "MAS_PERSON_RELATIONSHIP": sTitleHeadCompany != null
              ? [
                  {
                    "PERSON_RELATIONSHIP_ID": "",
                    "RELATIONSHIP_ID": 3,
                    "PERSON_ID": "",
                    "TITLE_ID": sTitleHeadCompany.TITLE_ID,
                    "TITLE_NAME_TH": sTitleHeadCompany.TITLE_NAME_TH,
                    "TITLE_NAME_EN": sTitleHeadCompany.TITLE_NAME_EN,
                    "TITLE_SHORT_NAME_TH": sTitleHeadCompany.TITLE_SHORT_NAME_TH,
                    "TITLE_SHORT_NAME_EN": sTitleHeadCompany.TITLE_SHORT_NAME_EN,
                    "FIRST_NAME": editCompany_agentFirstName.text,
                    "MIDDLE_NAME": "",
                    "LAST_NAME": editCompany_agentLastName.text,
                    "OTHER_NAME": "",
                    "GENDER_TYPE": 0,
                    "ID_CARD": "",
                    "BIRTH_DATE": "",
                    "BLOOD_TYPE": "",
                    "CAREER": "",
                    "PERSON_DESC": "",
                    "EMAIL": "",
                    "TEL_NO": "",
                    "IS_ACTIVE": 1
                  }
                ]
              : [],
          "MAS_PERSON_PHOTO": map_photo,
        };
        // --------------------------------------------------------------------------------------

        // เหลือสร้างเงื่อนไขชื่อ image_name
        String image_name = firstname + "_" + lastname;

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });
        await onLoadActionInsPersonAllMaster(_suspectThai ? map : _suspectForeigner ? map_foreigner : map_company, image_name);
        Navigator.pop(context, _getPersonResponse.RESPONSE_DATA);
      } else {
        // update ***************************************************************************
        // ------------------------------------ Map Thai ------------------------------------
        List<Map> map_relationship = [];
        if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length > 0) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 1) {
              if (sTitleFather != null) {
                map_relationship.add({
                  "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                  "RELATIONSHIP_ID": item.RELATIONSHIP_ID,
                  "PERSON_ID": "",
                  "TITLE_ID": sTitleFather.TITLE_ID,
                  "TITLE_NAME_TH": sTitleFather.TITLE_NAME_TH,
                  "TITLE_NAME_EN": sTitleFather.TITLE_NAME_EN,
                  "TITLE_SHORT_NAME_TH": sTitleFather.TITLE_SHORT_NAME_TH,
                  "TITLE_SHORT_NAME_EN": sTitleFather.TITLE_SHORT_NAME_EN,
                  "FIRST_NAME": editFirstNameFather.text,
                  "MIDDLE_NAME": "",
                  "LAST_NAME": editLastNameFather.text,
                  "OTHER_NAME": "",
                  "GENDER_TYPE": 1,
                  "ID_CARD": "",
                  "BIRTH_DATE": "",
                  "BLOOD_TYPE": "",
                  "CAREER": "",
                  "PERSON_DESC": "",
                  "EMAIL": "",
                  "TEL_NO": "",
                  "IS_ACTIVE": 1
                });
              }
            } else {
              if (sTitleMother != null) {
                map_relationship.add({
                  "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                  "RELATIONSHIP_ID": item.RELATIONSHIP_ID,
                  "PERSON_ID": "",
                  "TITLE_ID": sTitleMother.TITLE_ID,
                  "TITLE_NAME_TH": sTitleMother.TITLE_NAME_TH,
                  "TITLE_NAME_EN": sTitleMother.TITLE_NAME_EN,
                  "TITLE_SHORT_NAME_TH": sTitleMother.TITLE_SHORT_NAME_TH,
                  "TITLE_SHORT_NAME_EN": sTitleMother.TITLE_SHORT_NAME_EN,
                  "FIRST_NAME": editFirstNameMother.text,
                  "MIDDLE_NAME": "",
                  "LAST_NAME": editLastNameMother.text,
                  "OTHER_NAME": "",
                  "GENDER_TYPE": 2,
                  "ID_CARD": "",
                  "BIRTH_DATE": "",
                  "BLOOD_TYPE": "",
                  "CAREER": "",
                  "PERSON_DESC": "",
                  "EMAIL": "",
                  "TEL_NO": "",
                  "IS_ACTIVE": 1
                });
              }
            }
          });
        } else {
          if (sTitleFather != null) {
            map_relationship.add({
              "PERSON_RELATIONSHIP_ID": "",
              "RELATIONSHIP_ID": 1,
              "PERSON_ID": "",
              "TITLE_ID": sTitleFather.TITLE_ID,
              "TITLE_NAME_TH": sTitleFather.TITLE_NAME_TH,
              "TITLE_NAME_EN": sTitleFather.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": sTitleFather.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": sTitleFather.TITLE_SHORT_NAME_EN,
              "FIRST_NAME": editFirstNameFather.text,
              "MIDDLE_NAME": "",
              "LAST_NAME": editLastNameFather.text,
              "OTHER_NAME": "",
              "GENDER_TYPE": 1,
              "ID_CARD": "",
              "BIRTH_DATE": "",
              "BLOOD_TYPE": "",
              "CAREER": "",
              "PERSON_DESC": "",
              "EMAIL": "",
              "TEL_NO": "",
              "IS_ACTIVE": 1
            });
          }
          if (sTitleMother != null) {
            map_relationship.add({
              "PERSON_RELATIONSHIP_ID": "",
              "RELATIONSHIP_ID": 2,
              "PERSON_ID": "",
              "TITLE_ID": sTitleMother.TITLE_ID,
              "TITLE_NAME_TH": sTitleMother.TITLE_NAME_TH,
              "TITLE_NAME_EN": sTitleMother.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": sTitleMother.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": sTitleMother.TITLE_SHORT_NAME_EN,
              "FIRST_NAME": editFirstNameMother.text,
              "MIDDLE_NAME": "",
              "LAST_NAME": editLastNameMother.text,
              "OTHER_NAME": "",
              "GENDER_TYPE": 2,
              "ID_CARD": "",
              "BIRTH_DATE": "",
              "BLOOD_TYPE": "",
              "CAREER": "",
              "PERSON_DESC": "",
              "EMAIL": "",
              "TEL_NO": "",
              "IS_ACTIVE": 1
            });
          }
        }

        List<Map> map_address = [];
        if (widget.ItemsPerson.MAS_PERSON_ADDRESS.length > 0) {
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item) {
            if (sSubDistrict != null) {
              map_address.add({
                "PERSON_ADDRESS_ID": item.PERSON_ADDRESS_ID,
                "PERSON_ID": item.PERSON_ID,
                "SUB_DISTRICT_ID": sSubDistrict.SUB_DISTRICT_ID,
                "GPS": "",
                "ADDRESS_NO": "",
                "VILLAGE_NO": "",
                "BUILDING_NAME": "",
                "ROOM_NO": "",
                "FLOOR": "",
                "VILLAGE_NAME": "",
                "ALLEY": "",
                "LANE": "",
                "ROAD": "",
                "ADDRESS_TYPE": 0,
                "ADDRESS_DESC": "",
                "ADDRESS_STATUS": 0,
                "IS_ACTIVE": 1
              });
            }
          });
        } else {
          if (sSubDistrict != null) {
            map_address.add({
              "PERSON_ADDRESS_ID": "",
              "PERSON_ID": "",
              "SUB_DISTRICT_ID": sSubDistrict.SUB_DISTRICT_ID,
              "GPS": "",
              "ADDRESS_NO": "",
              "VILLAGE_NO": "",
              "BUILDING_NAME": "",
              "ROOM_NO": "",
              "FLOOR": "",
              "VILLAGE_NAME": "",
              "ALLEY": "",
              "LANE": "",
              "ROAD": "",
              "ADDRESS_TYPE": 0,
              "ADDRESS_DESC": "",
              "ADDRESS_STATUS": 0,
              "IS_ACTIVE": 1
            });
          }
        }

        Map map = {
          "PERSON_ID": widget.ItemsPerson.PERSON_ID,
          "COUNTRY_ID": sCountry != null ? sCountry.COUNTRY_ID : 1,
          "NATIONALITY_ID": sNational != null ? sNational.NATIONALITY_ID : "",
          "RACE_ID": sRace != null ? sRace.RACE_ID : "",
          "RELIGION_ID": "",
          "TITLE_ID": sTitle != null ? sTitle.TITLE_ID : "",
          "PERSON_TYPE": 0,
          "ENTITY_TYPE": 0,
          "TITLE_NAME_TH": sTitle != null ? sTitle.TITLE_NAME_TH : "",
          "TITLE_NAME_EN": sTitle != null ? sTitle.TITLE_NAME_EN : "",
          // "TITLE_SHORT_NAME_TH": ItemTitle != null ? ItemTitle.TITLE_SHORT_NAME_TH : _itemCompanyTitleValue,
          "TITLE_SHORT_NAME_TH": sTitle != null ? sTitle.TITLE_SHORT_NAME_TH : "",
          "TITLE_SHORT_NAME_EN": sTitle != null ? sTitle.TITLE_SHORT_NAME_EN : "",
          "FIRST_NAME": editFirstNameSus.text,
          "MIDDLE_NAME": "",
          "LAST_NAME": editLastNameSus.text,
          "OTHER_NAME": "",
          "COMPANY_NAME": "",
          "COMPANY_REGISTRATION_NO": "",
          "COMPANY_FOUND_DATE": "",
          "COMPANY_LICENSE_NO": "",
          "COMPANY_LICENSE_DATE_FROM": "",
          "COMPANY_LICENSE_DATE_TO": "",
          "EXCISE_REGISTRATION_NO": "",
          "GENDER_TYPE": 0,
          "ID_CARD": editIDNo.text,
          "BIRTH_DATE": "",
          "BLOOD_TYPE": "",
          "PASSPORT_NO": "",
          "VISA_TYPE": "",
          "PASSPORT_DATE_IN": "",
          "PASSPORT_DATE_OUT": "",
          "MARITAL_STATUS": 0,
          "CAREER": editCareer.text,
          "PERSON_DESC": "",
          "EMAIL": "",
          "TEL_NO": "",
          "MISTREAT_NO": 0,
          "IS_ILLEGAL": 1,
          "IS_ACTIVE": 1,
          "MAS_PERSON_ADDRESS": map_address,
          "MAS_PERSON_RELATIONSHIP": map_relationship,
          "MAS_PERSON_PHOTO": [],
        };
        // ---------------------------------------------------------------------------------------
        // ------------------------------------ Map Foreigner ------------------------------------
        List<Map> map_relationship_foreigner = [];
        if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length > 0) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 1) {
              if (sTitleFather_foreigner != null) {
                map_relationship_foreigner.add({
                  "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                  "RELATIONSHIP_ID": item.RELATIONSHIP_ID,
                  "PERSON_ID": "",
                  "TITLE_ID": sTitleFather_foreigner.TITLE_ID,
                  "TITLE_NAME_TH": sTitleFather_foreigner.TITLE_NAME_TH,
                  "TITLE_NAME_EN": sTitleFather_foreigner.TITLE_NAME_EN,
                  "TITLE_SHORT_NAME_TH": sTitleFather_foreigner.TITLE_SHORT_NAME_TH,
                  "TITLE_SHORT_NAME_EN": sTitleFather_foreigner.TITLE_SHORT_NAME_EN,
                  "FIRST_NAME": editFirstNameFather_foreigner.text,
                  "MIDDLE_NAME": "",
                  "LAST_NAME": editLastNameFather_foreigner.text,
                  "OTHER_NAME": "",
                  "GENDER_TYPE": 1,
                  "ID_CARD": "",
                  "BIRTH_DATE": "",
                  "BLOOD_TYPE": "",
                  "CAREER": "",
                  "PERSON_DESC": "",
                  "EMAIL": "",
                  "TEL_NO": "",
                  "IS_ACTIVE": 1
                });
              }
            } else {
              if (sTitleMother_foreigner != null) {
                map_relationship_foreigner.add({
                  "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                  "RELATIONSHIP_ID": item.RELATIONSHIP_ID,
                  "PERSON_ID": "",
                  "TITLE_ID": sTitleMother_foreigner.TITLE_ID,
                  "TITLE_NAME_TH": sTitleMother_foreigner.TITLE_NAME_TH,
                  "TITLE_NAME_EN": sTitleMother_foreigner.TITLE_NAME_EN,
                  "TITLE_SHORT_NAME_TH": sTitleMother_foreigner.TITLE_SHORT_NAME_TH,
                  "TITLE_SHORT_NAME_EN": sTitleMother_foreigner.TITLE_SHORT_NAME_EN,
                  "FIRST_NAME": editFirstNameMother_foreigner.text,
                  "MIDDLE_NAME": "",
                  "LAST_NAME": editLastNameMother_foreigner.text,
                  "OTHER_NAME": "",
                  "GENDER_TYPE": 2,
                  "ID_CARD": "",
                  "BIRTH_DATE": "",
                  "BLOOD_TYPE": "",
                  "CAREER": "",
                  "PERSON_DESC": "",
                  "EMAIL": "",
                  "TEL_NO": "",
                  "IS_ACTIVE": 1
                });
              }
            }
          });
        } else {
          if (sTitleFather_foreigner != null) {
            map_relationship_foreigner.add({
              "PERSON_RELATIONSHIP_ID": "",
              "RELATIONSHIP_ID": 1,
              "PERSON_ID": "",
              "TITLE_ID": sTitleFather_foreigner.TITLE_ID,
              "TITLE_NAME_TH": sTitleFather_foreigner.TITLE_NAME_TH,
              "TITLE_NAME_EN": sTitleFather_foreigner.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": sTitleFather_foreigner.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": sTitleFather_foreigner.TITLE_SHORT_NAME_EN,
              "FIRST_NAME": editFirstNameFather_foreigner.text,
              "MIDDLE_NAME": "",
              "LAST_NAME": editLastNameFather_foreigner.text,
              "OTHER_NAME": "",
              "GENDER_TYPE": 1,
              "ID_CARD": "",
              "BIRTH_DATE": "",
              "BLOOD_TYPE": "",
              "CAREER": "",
              "PERSON_DESC": "",
              "EMAIL": "",
              "TEL_NO": "",
              "IS_ACTIVE": 1
            });
          }
          if (sTitleMother_foreigner != null) {
            map_relationship_foreigner.add({
              "PERSON_RELATIONSHIP_ID": "",
              "RELATIONSHIP_ID": 2,
              "PERSON_ID": "",
              "TITLE_ID": sTitleMother_foreigner.TITLE_ID,
              "TITLE_NAME_TH": sTitleMother_foreigner.TITLE_NAME_TH,
              "TITLE_NAME_EN": sTitleMother_foreigner.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": sTitleMother_foreigner.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": sTitleMother_foreigner.TITLE_SHORT_NAME_EN,
              "FIRST_NAME": editFirstNameMother_foreigner.text,
              "MIDDLE_NAME": "",
              "LAST_NAME": editLastNameMother_foreigner.text,
              "OTHER_NAME": "",
              "GENDER_TYPE": 2,
              "ID_CARD": "",
              "BIRTH_DATE": "",
              "BLOOD_TYPE": "",
              "CAREER": "",
              "PERSON_DESC": "",
              "EMAIL": "",
              "TEL_NO": "",
              "IS_ACTIVE": 1
            });
          }
        }

        Map map_foreigner = {
          "PERSON_ID": widget.ItemsPerson.PERSON_ID,
          "COUNTRY_ID": sCountry_foreigner != null ? sCountry_foreigner.COUNTRY_ID : "",
          "NATIONALITY_ID": sNational_foreigner != null ? sNational_foreigner.NATIONALITY_ID : "",
          "RACE_ID": sRace_foreigner != null ? sRace_foreigner.RACE_ID : "",
          "RELIGION_ID": "",
          "TITLE_ID": sTitle_foreigner != null ? sTitle_foreigner.TITLE_ID : "",
          "PERSON_TYPE": 1,
          "ENTITY_TYPE": 0,
          "TITLE_NAME_TH": sTitle_foreigner != null ? sTitle_foreigner.TITLE_NAME_TH : "",
          "TITLE_NAME_EN": sTitle_foreigner != null ? sTitle_foreigner.TITLE_NAME_EN : "",
          // "TITLE_SHORT_NAME_TH": ItemTitle != null ? ItemTitle.TITLE_SHORT_NAME_TH : _itemCompanyTitleValue,
          "TITLE_SHORT_NAME_TH": sTitle_foreigner != null ? sTitle_foreigner.TITLE_SHORT_NAME_TH : "",
          "TITLE_SHORT_NAME_EN": sTitle_foreigner != null ? sTitle_foreigner.TITLE_SHORT_NAME_EN : "",
          "FIRST_NAME": editFirstNameSus_foreigner.text,
          "MIDDLE_NAME": "",
          "LAST_NAME": editLastNameSus_foreigner.text,
          "OTHER_NAME": "",
          "COMPANY_NAME": "",
          "COMPANY_REGISTRATION_NO": "",
          "COMPANY_FOUND_DATE": "",
          "COMPANY_LICENSE_NO": "",
          "COMPANY_LICENSE_DATE_FROM": "",
          "COMPANY_LICENSE_DATE_TO": "",
          "EXCISE_REGISTRATION_NO": "",
          "GENDER_TYPE": 0,
          "ID_CARD": "",
          "BIRTH_DATE": "",
          "BLOOD_TYPE": "",
          "PASSPORT_NO": editPassportNo.text,
          "VISA_TYPE": "",
          "PASSPORT_DATE_IN": "",
          "PASSPORT_DATE_OUT": "",
          "MARITAL_STATUS": 0,
          "CAREER": editCareer_foreigner.text,
          "PERSON_DESC": "",
          "EMAIL": "",
          "TEL_NO": "",
          "MISTREAT_NO": 0,
          "IS_ILLEGAL": 1,
          "IS_ACTIVE": 1,
          "MAS_PERSON_ADDRESS": [],
          "MAS_PERSON_RELATIONSHIP": map_relationship_foreigner,
          "MAS_PERSON_PHOTO": [],
        };
        // --------------------------------------------------------------------------------------
        // ------------------------------------ Map Organize ------------------------------------
        List<Map> map_relationship_company = [];
        if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length > 0) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (sTitleHeadCompany != null) {
              map_relationship_company.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                "RELATIONSHIP_ID": item.RELATIONSHIP_ID,
                "PERSON_ID": "",
                "TITLE_ID": sTitleHeadCompany.TITLE_ID,
                "TITLE_NAME_TH": sTitleHeadCompany.TITLE_NAME_TH,
                "TITLE_NAME_EN": sTitleHeadCompany.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": sTitleHeadCompany.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": sTitleHeadCompany.TITLE_SHORT_NAME_EN,
                "FIRST_NAME": editCompany_agentFirstName.text,
                "MIDDLE_NAME": "",
                "LAST_NAME": editCompany_agentLastName.text,
                "OTHER_NAME": "",
                "GENDER_TYPE": 1,
                "ID_CARD": "",
                "BIRTH_DATE": "",
                "BLOOD_TYPE": "",
                "CAREER": "",
                "PERSON_DESC": "",
                "EMAIL": "",
                "TEL_NO": "",
                "IS_ACTIVE": 1
              });
            }
          });
        } else {
          if (sTitleHeadCompany != null) {
            map_relationship_company.add({
              "PERSON_RELATIONSHIP_ID": "",
              "RELATIONSHIP_ID": 3,
              "PERSON_ID": "",
              "TITLE_ID": sTitleHeadCompany.TITLE_ID,
              "TITLE_NAME_TH": sTitleHeadCompany.TITLE_NAME_TH,
              "TITLE_NAME_EN": sTitleHeadCompany.TITLE_NAME_EN,
              "TITLE_SHORT_NAME_TH": sTitleHeadCompany.TITLE_SHORT_NAME_TH,
              "TITLE_SHORT_NAME_EN": sTitleHeadCompany.TITLE_SHORT_NAME_EN,
              "FIRST_NAME": editCompany_agentFirstName.text,
              "MIDDLE_NAME": "",
              "LAST_NAME": editCompany_agentLastName.text,
              "OTHER_NAME": "",
              "GENDER_TYPE": 1,
              "ID_CARD": "",
              "BIRTH_DATE": "",
              "BLOOD_TYPE": "",
              "CAREER": "",
              "PERSON_DESC": "",
              "EMAIL": "",
              "TEL_NO": "",
              "IS_ACTIVE": 1
            });
          }
        }
        List<Map> map_address_company = [];
        if (widget.ItemsPerson.MAS_PERSON_ADDRESS.length > 0) {
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item) {
            if (sSubDistrict_company != null) {
              map_address_company.add({
                "PERSON_ADDRESS_ID": item.PERSON_ADDRESS_ID,
                "PERSON_ID": item.PERSON_ID,
                "SUB_DISTRICT_ID": sSubDistrict_company.SUB_DISTRICT_ID,
                "GPS": "",
                "ADDRESS_NO": "",
                "VILLAGE_NO": "",
                "BUILDING_NAME": "",
                "ROOM_NO": "",
                "FLOOR": "",
                "VILLAGE_NAME": "",
                "ALLEY": "",
                "LANE": "",
                "ROAD": "",
                "ADDRESS_TYPE": 0,
                "ADDRESS_DESC": "",
                "ADDRESS_STATUS": 0,
                "IS_ACTIVE": 1
              });
            }
          });
        } else {
          if (sSubDistrict_company != null) {
            map_address_company.add({
              "PERSON_ADDRESS_ID": "",
              "PERSON_ID": widget.ItemsPerson.PERSON_ID,
              "SUB_DISTRICT_ID": sSubDistrict_company.SUB_DISTRICT_ID,
              "GPS": "",
              "ADDRESS_NO": "",
              "VILLAGE_NO": "",
              "BUILDING_NAME": "",
              "ROOM_NO": "",
              "FLOOR": "",
              "VILLAGE_NAME": "",
              "ALLEY": "",
              "LANE": "",
              "ROAD": "",
              "ADDRESS_TYPE": 0,
              "ADDRESS_DESC": "",
              "ADDRESS_STATUS": 0,
              "IS_ACTIVE": 1
            });
          }
        }

        Map map_company = {
          "PERSON_ID": widget.ItemsPerson.PERSON_ID,
          "COUNTRY_ID": sCountry_company != null ? sCountry_company.COUNTRY_ID : "",
          "NATIONALITY_ID": sNational_company != null ? sNational_company.NATIONALITY_ID : "",
          "RACE_ID": sRace_company != null ? sRace_company.RACE_ID : "",
          "RELIGION_ID": "",
          "TITLE_ID": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_ID : "",
          "PERSON_TYPE": 2,
          "ENTITY_TYPE": entity,
          "TITLE_NAME_TH": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_NAME_TH : "",
          "TITLE_NAME_EN": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_NAME_EN : "",
          "TITLE_SHORT_NAME_TH": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_SHORT_NAME_TH : "",
          "TITLE_SHORT_NAME_EN": _itemCompanyTitleValue != null ? _itemCompanyTitleValue.TITLE_SHORT_NAME_EN : "",
          "FIRST_NAME": "",
          "MIDDLE_NAME": "",
          "LAST_NAME": "",
          "OTHER_NAME": "",
          "COMPANY_NAME": editCompanyName.text,
          "COMPANY_REGISTRATION_NO": editCompanyRegistrationNo_Company.text,
          "COMPANY_FOUND_DATE": "",
          "COMPANY_LICENSE_NO": "",
          "COMPANY_LICENSE_DATE_FROM": "",
          "COMPANY_LICENSE_DATE_TO": "",
          "EXCISE_REGISTRATION_NO": editExciseRegistrationNo_Company.text,
          "GENDER_TYPE": 0,
          "ID_CARD": editIDNo_Company.text,
          "BIRTH_DATE": "",
          "BLOOD_TYPE": "",
          "PASSPORT_NO": "",
          "VISA_TYPE": "",
          "PASSPORT_DATE_IN": "",
          "PASSPORT_DATE_OUT": "",
          "MARITAL_STATUS": 0,
          "CAREER": "",
          "PERSON_DESC": "",
          "EMAIL": "",
          "TEL_NO": "",
          "MISTREAT_NO": 0,
          "IS_ILLEGAL": 1,
          "IS_ACTIVE": 1,
          "MAS_PERSON_ADDRESS": map_address_company,
          "MAS_PERSON_RELATIONSHIP": map_relationship_company,
          "MAS_PERSON_PHOTO": [],
        };
        // --------------------------------------------------------------------------------------------------------------------
        print('object1:${_suspectThai ? map : _suspectForeigner ? map_foreigner : map_company}');
        // ========================================== Boolean RELATIONSHIP Create || Update || Delete =========================
        //father
        bool IsCreateFather = false;
        bool IsDeleteFather = false;
        bool IsUpdateFather = false;
        //mother
        bool IsCreateMother = false;
        bool IsDeleteMother = false;
        bool IsUpdateMother = false;
        //father Foreigner
        bool IsCreateFatherForeigner = false;
        bool IsDeleteFatherForeigner = false;
        bool IsUpdateFatherForeigner = false;
        //mother Foreigner
        bool IsCreateMotherForeigner = false;
        bool IsDeleteMotherForeigner = false;
        bool IsUpdateMotherForeigner = false;
        //Company
        bool IsCreateCompany = false;
        bool IsDeleteCompany = false;
        bool IsUpdateCompany = false;

        if (_suspectThai) {
          if (widget.ItemsPerson.PERSON_TYPE == 0) {
            if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length > 0) {
              if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length == 1) {
                widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
                  if (item.RELATIONSHIP_ID == 1) {
                    // Father Thai people
                    if (sTitleFather == null || editFirstNameFather.text.isEmpty || editLastNameFather.text.isEmpty) {
                      IsDeleteFather = true;
                    } else {
                      IsUpdateFather = true;
                    }
                    if (sTitleMother != null || editFirstNameMother.text.isNotEmpty || editLastNameMother.text.isNotEmpty) {
                      IsCreateMother = true;
                    }
                  } else if (item.RELATIONSHIP_ID == 2) {
                    // Mother Thai people
                    if (sTitleMother == null || editFirstNameMother.text.isEmpty || editLastNameMother.text.isEmpty) {
                      IsDeleteMother = true;
                    } else {
                      IsUpdateMother = true;
                    }
                    if (sTitleFather != null || editFirstNameFather.text.isNotEmpty || editLastNameFather.text.isNotEmpty) {
                      IsCreateFather = true;
                    }
                  }
                });
              } else {
                widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
                  if (item.RELATIONSHIP_ID == 1) {
                    // Father Thai people
                    if (sTitleFather == null || editFirstNameFather.text.isEmpty || editLastNameFather.text.isEmpty) {
                      IsDeleteFather = true;
                    } else {
                      IsUpdateFather = true;
                    }
                  } else if (item.RELATIONSHIP_ID == 2) {
                    // Mother Thai people
                    if (sTitleMother == null || editFirstNameMother.text.isEmpty || editLastNameMother.text.isEmpty) {
                      IsDeleteMother = true;
                    } else {
                      IsUpdateMother = true;
                    }
                  }
                });
              }
            } else {
              // length = 0 Family Thai people create
              if (sTitleFather != null || editFirstNameFather.text.isNotEmpty || editLastNameFather.text.isNotEmpty) {
                IsCreateFather = true;
              }
              if (sTitleMother != null || editFirstNameMother.text.isNotEmpty || editLastNameMother.text.isNotEmpty) {
                IsCreateMother = true;
              }
            }
          } else {
            // Change person type to Thai people
            // Family Thai people create
            if (sTitleFather != null || editFirstNameFather.text.isNotEmpty || editLastNameFather.text.isNotEmpty) {
              IsCreateFather = true;
            }
            if (sTitleMother != null || editFirstNameMother.text.isNotEmpty || editLastNameMother.text.isNotEmpty) {
              IsCreateMother = true;
            }
            if (sTitleFather_foreigner != null || editFirstNameFather_foreigner.text.isNotEmpty || editLastNameFather_foreigner.text.isNotEmpty) {
              IsDeleteFatherForeigner = true;
            }
            if (sTitleMother_foreigner != null || editFirstNameMother_foreigner.text.isNotEmpty || editLastNameMother_foreigner.text.isNotEmpty) {
              IsDeleteMotherForeigner = true;
            }
            if (sTitleHeadCompany != null && editCompany_agentFirstName.text.isNotEmpty && editCompany_agentLastName.text.isNotEmpty) {
              IsDeleteCompany = true;
            }
          }
        } else if (_suspectForeigner) {
          if (widget.ItemsPerson.PERSON_TYPE == 1) {
            if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length > 0) {
              if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length == 1) {
                widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
                  if (item.RELATIONSHIP_ID == 1) {
                    // Father Foreigner people
                    if (sTitleFather_foreigner == null || editFirstNameFather_foreigner.text.isEmpty || editLastNameFather_foreigner.text.isEmpty) {
                      IsDeleteFatherForeigner = true;
                    } else {
                      IsUpdateFatherForeigner = true;
                    }
                    if (sTitleMother_foreigner != null || editFirstNameMother_foreigner.text.isNotEmpty || editLastNameMother_foreigner.text.isNotEmpty) {
                      IsCreateMotherForeigner = true;
                    }
                  } else if (item.RELATIONSHIP_ID == 2) {
                    // Mother Foreigner people
                    if (sTitleMother_foreigner == null || editFirstNameMother_foreigner.text.isEmpty || editLastNameMother_foreigner.text.isEmpty) {
                      IsDeleteMotherForeigner = true;
                    } else {
                      IsUpdateMotherForeigner = true;
                    }
                    if (sTitleFather_foreigner != null || editFirstNameFather_foreigner.text.isNotEmpty || editLastNameFather_foreigner.text.isNotEmpty) {
                      IsCreateFatherForeigner = true;
                    }
                  }
                });
              } else {
                widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
                  if (item.RELATIONSHIP_ID == 1) {
                    // Father Foreigner people
                    if (sTitleFather_foreigner == null || editFirstNameFather_foreigner.text.isEmpty || editLastNameFather_foreigner.text.isEmpty) {
                      IsDeleteFatherForeigner = true;
                    } else {
                      IsUpdateFatherForeigner = true;
                    }
                  } else if (item.RELATIONSHIP_ID == 2) {
                    // Mother Foreigner people
                    if (sTitleMother_foreigner == null || editFirstNameMother_foreigner.text.isEmpty || editLastNameMother_foreigner.text.isEmpty) {
                      IsDeleteMotherForeigner = true;
                    } else {
                      IsUpdateMotherForeigner = true;
                    }
                  }
                });
              }
            } else {
              // length = 0 Family Foreigner people create
              if (sTitleFather_foreigner != null || editFirstNameFather_foreigner.text.isNotEmpty || editLastNameFather_foreigner.text.isNotEmpty) {
                IsCreateFatherForeigner = true;
              }
              if (sTitleMother_foreigner != null || editFirstNameMother_foreigner.text.isNotEmpty || editLastNameMother_foreigner.text.isNotEmpty) {
                IsCreateMotherForeigner = true;
              }
            }
          } else {
            // Change person type to Foreigner people
            // Family Foreigner people create
            if (sTitleFather_foreigner != null || editFirstNameFather_foreigner.text.isNotEmpty || editLastNameFather_foreigner.text.isNotEmpty) {
              IsCreateFatherForeigner = true;
            }
            if (sTitleMother_foreigner != null || editFirstNameMother_foreigner.text.isNotEmpty || editLastNameMother_foreigner.text.isNotEmpty) {
              IsCreateMotherForeigner = true;
            }
            if (sTitleFather != null || editFirstNameFather.text.isNotEmpty || editLastNameFather.text.isNotEmpty) {
              IsDeleteFather = true;
            }
            if (sTitleMother != null || editFirstNameMother.text.isNotEmpty || editLastNameMother.text.isNotEmpty) {
              IsDeleteMother = true;
            }
            if (sTitleHeadCompany != null && editCompany_agentFirstName.text.isNotEmpty && editCompany_agentLastName.text.isNotEmpty) {
              IsDeleteCompany = true;
            }
          }
        } else {
          if (widget.ItemsPerson.PERSON_TYPE == 1) {
            if (widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.length > 0) {
              widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
                if (item.RELATIONSHIP_ID == 3) {
                  // Company agent name
                  if (sTitleHeadCompany == null || editCompany_agentFirstName.text.isEmpty || editCompany_agentFirstName.text.isEmpty) {
                    IsDeleteCompany = true;
                  } else {
                    IsUpdateCompany = true;
                  }
                }
              });
            } else {
              if (sTitleHeadCompany != null && editCompany_agentFirstName.text.isNotEmpty && editCompany_agentLastName.text.isNotEmpty) {
                IsCreateCompany = true;
              }
            }
          } else {
            // Change person type to Company people
            // Company agent create
            if (sTitleHeadCompany != null && editCompany_agentFirstName.text.isNotEmpty && editCompany_agentLastName.text.isNotEmpty) {
              IsCreateCompany = true;
            }
            if (sTitleFather != null || editFirstNameFather.text.isNotEmpty || editLastNameFather.text.isNotEmpty) {
              IsDeleteFather = true;
            }
            if (sTitleMother != null || editFirstNameMother.text.isNotEmpty || editLastNameMother.text.isNotEmpty) {
              IsDeleteMother = true;
            }
            if (sTitleFather_foreigner != null || editFirstNameFather_foreigner.text.isNotEmpty || editLastNameFather_foreigner.text.isNotEmpty) {
              IsDeleteFatherForeigner = true;
            }
            if (sTitleMother_foreigner != null || editFirstNameMother_foreigner.text.isNotEmpty || editLastNameMother_foreigner.text.isNotEmpty) {
              IsDeleteMotherForeigner = true;
            }
          }
        }
        // ====================================================================================================================
        // ========================================== Boolean ADDRESS Create || Update || Delete ==============================
        // Thai
        bool IsCreateAddress = false;
        bool IsDeleteAddress = false;
        bool IsUpdateAddress = false;
        // Company
        bool IsCreateAddress_company = false;
        bool IsDeleteAddress_company = false;
        bool IsUpdateAddress_company = false;

        if (_suspectThai) {
          if (widget.ItemsPerson.PERSON_TYPE == 0) {
            if (widget.ItemsPerson.MAS_PERSON_ADDRESS.length > 0) {
              if (sProvince == null || sDistrict == null || sSubDistrict == null) {
                IsDeleteAddress = true;
              } else {
                IsUpdateAddress = true;
              }
            } else {
              if (sProvince != null || sDistrict != null || sSubDistrict != null) {
                IsCreateAddress = true;
              }
            }
          } else {
            // Change person type to Thai people
            // Thai create address
            if (sProvince != null || sDistrict != null || sSubDistrict != null) {
              IsCreateAddress = true;
            }
          }
        } else if (_suspectCompany) {
          if (widget.ItemsPerson.PERSON_TYPE == 2) {
            if (widget.ItemsPerson.MAS_PERSON_ADDRESS.length > 0) {
              if (sProvince_company == null || sDistrict_company == null || sSubDistrict_company == null) {
                IsDeleteAddress_company = true;
              } else {
                IsUpdateAddress_company = true;
              }
            } else {
              if (sProvince_company != null || sDistrict_company != null || sSubDistrict_company != null) {
                IsCreateAddress_company = true;
              }
            }
          } else {
            // Change person type to Company
            // Company create address
            if (sProvince_company != null || sDistrict_company != null || sSubDistrict_company != null) {
              IsCreateAddress_company = true;
            }
          }
        }
        // ====================================================================================================================

        // ========================================== List map Create || Update || Delete =====================================
        List<Map> map_add_relation = [];
        List<Map> map_upd_relation = [];
        List<Map> map_del_relation = [];
        List<Map> map_add_address = [];
        List<Map> map_upd_address = [];
        List<Map> map_del_address = [];
        // ========================================== Thai people =============================================================
        // ------------------------------------------ Father ------------------------------------------------------------------
        if (IsCreateFather) {
          map_add_relation.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 1,
            "PERSON_ID": widget.ItemsPerson.PERSON_ID,
            "TITLE_ID": sTitleFather.TITLE_ID,
            "TITLE_NAME_TH": sTitleFather.TITLE_NAME_TH,
            "TITLE_NAME_EN": sTitleFather.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": sTitleFather.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": sTitleFather.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": editFirstNameFather.text,
            "MIDDLE_NAME": "",
            "LAST_NAME": editLastNameFather.text,
            "OTHER_NAME": "",
            "GENDER_TYPE": 1,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }

        if (IsUpdateFather) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 1) {
              map_upd_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                "RELATIONSHIP_ID": item.RELATIONSHIP_ID,
                "PERSON_ID": widget.ItemsPerson.PERSON_ID,
                "TITLE_ID": sTitleFather.TITLE_ID,
                "TITLE_NAME_TH": sTitleFather.TITLE_NAME_TH,
                "TITLE_NAME_EN": sTitleFather.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": sTitleFather.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": sTitleFather.TITLE_SHORT_NAME_EN,
                "FIRST_NAME": editFirstNameFather.text,
                "MIDDLE_NAME": "",
                "LAST_NAME": editLastNameFather.text,
                "OTHER_NAME": "",
                "GENDER_TYPE": 1,
                "ID_CARD": "",
                "BIRTH_DATE": "",
                "BLOOD_TYPE": "",
                "CAREER": "",
                "PERSON_DESC": "",
                "EMAIL": "",
                "TEL_NO": "",
                "IS_ACTIVE": 1
              });
            }
          });
        }
        if (IsDeleteFather) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 1) {
              map_del_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
              });
            }
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Mother ------------------------------------------------------------------
        if (IsCreateMother) {
          map_add_relation.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 2,
            "PERSON_ID": widget.ItemsPerson.PERSON_ID,
            "TITLE_ID": sTitleMother.TITLE_ID,
            "TITLE_NAME_TH": sTitleMother.TITLE_NAME_TH,
            "TITLE_NAME_EN": sTitleMother.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": sTitleMother.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": sTitleMother.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": editFirstNameMother.text,
            "MIDDLE_NAME": "",
            "LAST_NAME": editLastNameMother.text,
            "OTHER_NAME": "",
            "GENDER_TYPE": 2,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }
        if (IsUpdateMother) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 2) {
              map_upd_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                "RELATIONSHIP_ID": item.RELATIONSHIP_ID,
                "PERSON_ID": widget.ItemsPerson.PERSON_ID,
                "TITLE_ID": sTitleMother.TITLE_ID,
                "TITLE_NAME_TH": sTitleMother.TITLE_NAME_TH,
                "TITLE_NAME_EN": sTitleMother.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": sTitleMother.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": sTitleMother.TITLE_SHORT_NAME_EN,
                "FIRST_NAME": editFirstNameMother.text,
                "MIDDLE_NAME": "",
                "LAST_NAME": editLastNameMother.text,
                "OTHER_NAME": "",
                "GENDER_TYPE": 2,
                "ID_CARD": "",
                "BIRTH_DATE": "",
                "BLOOD_TYPE": "",
                "CAREER": "",
                "PERSON_DESC": "",
                "EMAIL": "",
                "TEL_NO": "",
                "IS_ACTIVE": 1
              });
            }
          });
        }
        if (IsDeleteMother) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 2) {
              map_del_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
              });
            }
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // Address
        // ------------------------------------------ Create Address ----------------------------------------------------------
        if (IsCreateAddress) {
          map_add_address.add({
            "PERSON_ADDRESS_ID": "",
            "PERSON_ID": widget.ItemsPerson.PERSON_ID,
            "SUB_DISTRICT_ID": sSubDistrict.SUB_DISTRICT_ID,
            "GPS": "",
            "ADDRESS_NO": "",
            "VILLAGE_NO": "",
            "BUILDING_NAME": "",
            "ROOM_NO": "",
            "FLOOR": "",
            "VILLAGE_NAME": "",
            "ALLEY": "",
            "LANE": "",
            "ROAD": "",
            "ADDRESS_TYPE": 4,
            "ADDRESS_DESC": "",
            "ADDRESS_STATUS": 0,
            "IS_ACTIVE": 1
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Update Address ----------------------------------------------------------
        if (IsUpdateAddress) {
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item) {
            map_upd_address.add({
              "PERSON_ADDRESS_ID": item.PERSON_ADDRESS_ID,
              "PERSON_ID": widget.ItemsPerson.PERSON_ID,
              "SUB_DISTRICT_ID": sSubDistrict.SUB_DISTRICT_ID,
              "GPS": "",
              "ADDRESS_NO": "",
              "VILLAGE_NO": "",
              "BUILDING_NAME": "",
              "ROOM_NO": "",
              "FLOOR": "",
              "VILLAGE_NAME": "",
              "ALLEY": "",
              "LANE": "",
              "ROAD": "",
              "ADDRESS_TYPE": 4,
              "ADDRESS_DESC": "",
              "ADDRESS_STATUS": 0,
              "IS_ACTIVE": 1
            });
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Delete Address ----------------------------------------------------------
        if (IsDeleteAddress) {
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item) {
            map_del_address.add({
              "PERSON_ADDRESS_ID": item.PERSON_ADDRESS_ID,
            });
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ====================================================================================================================
        // ========================================== Foreigner people ========================================================
        // ------------------------------------------ Father ------------------------------------------------------------------
        // ------------------------------------------ Create ------------------------------------------------------------------
        if (IsCreateFatherForeigner) {
          map_add_relation.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 1,
            "PERSON_ID": widget.ItemsPerson.PERSON_ID,
            "TITLE_ID": sTitleFather_foreigner.TITLE_ID,
            "TITLE_NAME_TH": sTitleFather_foreigner.TITLE_NAME_TH,
            "TITLE_NAME_EN": sTitleFather_foreigner.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": sTitleFather_foreigner.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": sTitleFather_foreigner.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": editFirstNameFather_foreigner.text,
            "MIDDLE_NAME": "",
            "LAST_NAME": editLastNameFather_foreigner.text,
            "OTHER_NAME": "",
            "GENDER_TYPE": 1,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Update ------------------------------------------------------------------
        if (IsUpdateFatherForeigner) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 2) {
              map_upd_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                "RELATIONSHIP_ID": item.RELATIONSHIP_ID,
                "PERSON_ID": widget.ItemsPerson.PERSON_ID,
                "TITLE_ID": sTitleFather_foreigner.TITLE_ID,
                "TITLE_NAME_TH": sTitleFather_foreigner.TITLE_NAME_TH,
                "TITLE_NAME_EN": sTitleFather_foreigner.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": sTitleFather_foreigner.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": sTitleFather_foreigner.TITLE_SHORT_NAME_EN,
                "FIRST_NAME": editFirstNameFather_foreigner.text,
                "MIDDLE_NAME": "",
                "LAST_NAME": editLastNameFather_foreigner.text,
                "OTHER_NAME": "",
                "GENDER_TYPE": 1,
                "ID_CARD": "",
                "BIRTH_DATE": "",
                "BLOOD_TYPE": "",
                "CAREER": "",
                "PERSON_DESC": "",
                "EMAIL": "",
                "TEL_NO": "",
                "IS_ACTIVE": 1
              });
            }
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Delete ------------------------------------------------------------------
        if (IsDeleteFatherForeigner) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 2) {
              map_del_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
              });
            }
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Mother ------------------------------------------------------------------
        // ------------------------------------------ Create ------------------------------------------------------------------
        if (IsCreateMotherForeigner) {
          map_add_relation.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 2,
            "PERSON_ID": widget.ItemsPerson.PERSON_ID,
            "TITLE_ID": sTitleMother.TITLE_ID,
            "TITLE_NAME_TH": sTitleMother.TITLE_NAME_TH,
            "TITLE_NAME_EN": sTitleMother.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": sTitleMother.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": sTitleMother.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": editFirstNameMother.text,
            "MIDDLE_NAME": "",
            "LAST_NAME": editLastNameMother.text,
            "OTHER_NAME": "",
            "GENDER_TYPE": 2,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Update ------------------------------------------------------------------
        if (IsUpdateMotherForeigner) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 2) {
              map_upd_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                "RELATIONSHIP_ID": item.RELATIONSHIP_ID,
                "PERSON_ID": widget.ItemsPerson.PERSON_ID,
                "TITLE_ID": sTitleMother_foreigner.TITLE_ID,
                "TITLE_NAME_TH": sTitleMother_foreigner.TITLE_NAME_TH,
                "TITLE_NAME_EN": sTitleMother_foreigner.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": sTitleMother_foreigner.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": sTitleMother_foreigner.TITLE_SHORT_NAME_EN,
                "FIRST_NAME": editFirstNameMother_foreigner.text,
                "MIDDLE_NAME": "",
                "LAST_NAME": editLastNameMother_foreigner.text,
                "OTHER_NAME": "",
                "GENDER_TYPE": 2,
                "ID_CARD": "",
                "BIRTH_DATE": "",
                "BLOOD_TYPE": "",
                "CAREER": "",
                "PERSON_DESC": "",
                "EMAIL": "",
                "TEL_NO": "",
                "IS_ACTIVE": 1
              });
            }
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Delete ------------------------------------------------------------------
        if (IsDeleteMotherForeigner) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 2) {
              map_del_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
              });
            }
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ====================================================================================================================
        // ========================================== Company =================================================================
        // ------------------------------------------ Create ------------------------------------------------------------------
        if (IsCreateCompany) {
          map_add_relation.add({
            "PERSON_RELATIONSHIP_ID": "",
            "RELATIONSHIP_ID": 3,
            "PERSON_ID": widget.ItemsPerson.PERSON_ID,
            "TITLE_ID": sTitleHeadCompany.TITLE_ID,
            "TITLE_NAME_TH": sTitleHeadCompany.TITLE_NAME_TH,
            "TITLE_NAME_EN": sTitleHeadCompany.TITLE_NAME_EN,
            "TITLE_SHORT_NAME_TH": sTitleHeadCompany.TITLE_SHORT_NAME_TH,
            "TITLE_SHORT_NAME_EN": sTitleHeadCompany.TITLE_SHORT_NAME_EN,
            "FIRST_NAME": editCompany_agentFirstName.text,
            "MIDDLE_NAME": "",
            "LAST_NAME": editCompany_agentLastName.text,
            "OTHER_NAME": "",
            "GENDER_TYPE": 0,
            "ID_CARD": "",
            "BIRTH_DATE": "",
            "BLOOD_TYPE": "",
            "CAREER": "",
            "PERSON_DESC": "",
            "EMAIL": "",
            "TEL_NO": "",
            "IS_ACTIVE": 1
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Update ------------------------------------------------------------------
        if (IsUpdateCompany) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 3) {
              map_upd_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
                "PERSON_ID": widget.ItemsPerson.PERSON_ID,
                "TITLE_ID": sTitleHeadCompany.TITLE_ID,
                "TITLE_NAME_TH": sTitleHeadCompany.TITLE_NAME_TH,
                "TITLE_NAME_EN": sTitleHeadCompany.TITLE_NAME_EN,
                "TITLE_SHORT_NAME_TH": sTitleHeadCompany.TITLE_SHORT_NAME_TH,
                "TITLE_SHORT_NAME_EN": sTitleHeadCompany.TITLE_SHORT_NAME_EN,
                "FIRST_NAME": editCompany_agentFirstName.text,
                "MIDDLE_NAME": "",
                "LAST_NAME": editCompany_agentLastName.text,
                "OTHER_NAME": "",
                "GENDER_TYPE": 0,
                "ID_CARD": "",
                "BIRTH_DATE": "",
                "BLOOD_TYPE": "",
                "CAREER": "",
                "PERSON_DESC": "",
                "EMAIL": "",
                "TEL_NO": "",
                "IS_ACTIVE": 1
              });
            }
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Delete ------------------------------------------------------------------
        if (IsDeleteCompany) {
          widget.ItemsPerson.MAS_PERSON_RELATIONSHIP.forEach((item) {
            if (item.RELATIONSHIP_ID == 3) {
              map_del_relation.add({
                "PERSON_RELATIONSHIP_ID": item.PERSON_RELATIONSHIP_ID,
              });
            }
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // Address
        // ------------------------------------------ Create Address ----------------------------------------------------------
        if (IsCreateAddress_company) {
          map_add_address.add({
            "PERSON_ADDRESS_ID": "",
            "PERSON_ID": widget.ItemsPerson.PERSON_ID,
            "SUB_DISTRICT_ID": sSubDistrict_company.SUB_DISTRICT_ID,
            "GPS": "",
            "ADDRESS_NO": "",
            "VILLAGE_NO": "",
            "BUILDING_NAME": "",
            "ROOM_NO": "",
            "FLOOR": "",
            "VILLAGE_NAME": "",
            "ALLEY": "",
            "LANE": "",
            "ROAD": "",
            "ADDRESS_TYPE": 4,
            "ADDRESS_DESC": "",
            "ADDRESS_STATUS": 0,
            "IS_ACTIVE": 1
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Update Address ----------------------------------------------------------
        if (IsUpdateAddress_company) {
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item) {
            map_upd_address.add({
              "PERSON_ADDRESS_ID": item.PERSON_ADDRESS_ID,
              "PERSON_ID": widget.ItemsPerson.PERSON_ID,
              "SUB_DISTRICT_ID": sSubDistrict_company.SUB_DISTRICT_ID,
              "GPS": "",
              "ADDRESS_NO": "",
              "VILLAGE_NO": "",
              "BUILDING_NAME": "",
              "ROOM_NO": "",
              "FLOOR": "",
              "VILLAGE_NAME": "",
              "ALLEY": "",
              "LANE": "",
              "ROAD": "",
              "ADDRESS_TYPE": 4,
              "ADDRESS_DESC": "",
              "ADDRESS_STATUS": 0,
              "IS_ACTIVE": 1
            });
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ------------------------------------------ Delete Address ----------------------------------------------------------
        if (IsDeleteAddress_company) {
          widget.ItemsPerson.MAS_PERSON_ADDRESS.forEach((item) {
            map_del_address.add({
              "PERSON_ADDRESS_ID": item.PERSON_ADDRESS_ID,
            });
          });
        }
        // --------------------------------------------------------------------------------------------------------------------
        // ====================================================================================================================
        print('object2 add_relation:${map_add_relation.toString()}');
        print('object3 upd_relation:${map_upd_relation.toString()}');
        print('object4 add_address:${map_add_address.toString()}');
        print('object5 upd_address:${map_upd_address.toString()}');
        print('object6 del_relation:${map_del_relation.toString()}');
        print('object7 del_address:${map_del_address.toString()}');

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            });

        String image_name = firstname + "_" + lastname;

        await onLoadActionUpdPersonAllMaster(_suspectThai ? map : _suspectForeigner ? map_foreigner : map_company, map_add_relation, map_upd_relation, map_del_relation, map_add_address, map_upd_address, map_del_address, image_name);
        Navigator.pop(context, _getPersonResponse.RESPONSE_DATA);
      }
    }
  }

  void _onSelectCountry_foreigner(int COUNTRY_ID) async {
    await onLoadActionCountryMaster_foreigner(COUNTRY_ID, false);
  }

  Future<bool> onLoadActionCountryMaster_foreigner(int COUNTRY_ID, bool IsUpdate) async {
    Map map = {"TEXT_SEARCH": "", "COUNTRY_ID": ""};
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map).then((onValue) {
      ItemCountry = onValue;
      if (ItemCountry.SUCCESS && ItemCountry.RESPONSE_DATA.length > 0) {
        setAutoCompleteCountry_foreigner();
      }

      if (IsUpdate) {
        ItemCountry.RESPONSE_DATA.forEach((item) {
          if (item.COUNTRY_ID == COUNTRY_ID) {
            sCountry_foreigner = item;
            editCountry_foreigner.text = sCountry_foreigner.COUNTRY_NAME_TH.toString();
          }
        });
      }
    });

    setState(() {});
    return true;
  }
  // ---------------------------------------------------------------------------------

  void _onSelectCountry(int COUNTRY_ID) async {
    await onLoadActionProvinceMaster(COUNTRY_ID, null, false);
  }

  void _onSelectProvince(int PROVINCE_ID) async {
    await onLoadActionDistinctMaster(PROVINCE_ID, null, false);
  }

  void _onSelectDistrict(int DISTRICT_ID) async {
    print("DISTRICT_ID : " + DISTRICT_ID.toString());
    await onLoadActionSubDistinctMaster(DISTRICT_ID, null, false);
  }

  Future<bool> onLoadActionCountryMaster(int COUNTRY_ID) async {
    Map map = {"TEXT_SEARCH": "", "COUNTRY_ID": COUNTRY_ID};
    await new ArrestFutureMaster().apiRequestMasCountrygetByCon(map).then((onValue) {
      setAutoCompleteCountry();
      widget.ItemCountry.RESPONSE_DATA.forEach((item) {
        if (item.COUNTRY_ID == onValue.RESPONSE_DATA[0].COUNTRY_ID) {
          sCountry = item;
          editCountry.text = sCountry.COUNTRY_NAME_TH.toString();
        }
      });
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionProvinceMaster(int COUNTRY_ID, ItemsListSubDistict sub_district, bool IsUpdate) async {
    Map map = {"TEXT_SEARCH": "", "PROVINCE_ID": "", "COUNTRY_ID": COUNTRY_ID};
    await new ArrestFutureMaster().apiRequestMasProvincegetByCon(map).then((onValue) {
      ItemProvince = onValue;
      if (ItemProvince.SUCCESS && ItemProvince.RESPONSE_DATA.length > 0) {
        setAutoCompleteProvinceCompany();
        setAutoCompleteProvince();
      }
      if (IsUpdate) {
        ItemProvince.RESPONSE_DATA.forEach((item) {
          if (item.PROVINCE_ID == sub_district.PROVINCE_ID) {
            if (_suspectCompany) {
              sProvince_company = item;
              editProvince2.text = sProvince_company.PROVINCE_NAME_TH.toString();
            } else {
              sProvince = item;
              editProvince.text = sProvince.PROVINCE_NAME_TH.toString();
            }
            onLoadActionCountryMaster(_suspectCompany ? sProvince_company.COUNTRY_ID : sProvince.COUNTRY_ID);
          }
        });
      } else {
        sDistrict = null;
        this.onLoadActionDistinctMaster(onValue.RESPONSE_DATA[0].PROVINCE_ID, null, IsUpdate);
      }

      this.onLoadActionRaceMaster(false, null);
      this.onLoadActionNationalMaster(false, null);
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionDistinctMaster(int PROVINCE_ID, ItemsListSubDistict sub_district, bool IsUpdate) async {
    Map map = {"TEXT_SEARCH": "", "DISTRICT_ID": "", "PROVINCE_ID": PROVINCE_ID};
    await new ArrestFutureMaster().apiRequestMasDistrictgetByCon(map).then((onValue) {
      ItemDistrict = onValue;
      if (ItemDistrict.SUCCESS && ItemDistrict.RESPONSE_DATA.length > 0) {
        if (_suspectCompany) {
          setAutoCompleteDistrict2();
        } else {
          setAutoCompleteDistrict();
        }
      }
      if (IsUpdate) {
        ItemDistrict.RESPONSE_DATA.forEach((item) {
          if (item.DISTRICT_ID == sub_district.DISTRICT_ID) {
            if (_suspectCompany) {
              sDistrict_company = item;
              editDistrict2.text = sDistrict_company.DISTRICT_NAME_TH.toString();
            } else {
              sDistrict = item;
              editDistrict.text = sDistrict.DISTRICT_NAME_TH.toString();
            }
            onLoadActionProvinceMaster(_suspectCompany ? sDistrict_company.PROVINCE_ID : sDistrict.PROVINCE_ID, sub_district, IsUpdate);
          }
        });
      } else {
        sSubDistrict = null;
        this.onLoadActionSubDistinctMaster(onValue.RESPONSE_DATA[0].DISTRICT_ID, null, false);
      }
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionSubDistinctMaster(int DISTRICT_ID, int SUB_DISTRICT_ID, bool IsUpdate) async {
    Map map = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": SUB_DISTRICT_ID, "DISTRICT_ID": DISTRICT_ID};
    await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map).then((onValue) {
      if (IsUpdate) {
        onValue.RESPONSE_DATA.forEach((item) {
          if (_suspectCompany) {
            sSubDistrict_company = item;
            editSubDistrict2.text = sSubDistrict_company.SUB_DISTRICT_NAME_TH.toString();
          } else {
            sSubDistrict = item;
            editSubDistrict.text = sSubDistrict.SUB_DISTRICT_NAME_TH.toString();
          }
        });
      } else {
        ItemSubDistrict = onValue;
        if (ItemSubDistrict.SUCCESS && ItemSubDistrict.RESPONSE_DATA.length > 0) {
          if (_suspectCompany) {
            setAutoCompleteSubDistrict2();
          } else {
            setAutoCompleteSubDistrict();
          }
        }
      }
    });
    if (IsUpdate) {
      Map map_con = {"TEXT_SEARCH": "", "SUB_DISTRICT_ID": "", "DISTRICT_ID": _suspectCompany ? sSubDistrict_company.DISTRICT_ID : sSubDistrict.DISTRICT_ID};
      await new ArrestFutureMaster().apiRequestMasSubDistrictgetByCon(map_con).then((onValue) {
        ItemSubDistrict = onValue;
        ItemSubDistrict.RESPONSE_DATA.forEach((item) {
          if (item.SUB_DISTRICT_ID == (_suspectCompany ? sSubDistrict_company.DISTRICT_ID : sSubDistrict.DISTRICT_ID)) {
            if (_suspectCompany) {
              sSubDistrict_company = item;
            } else {
              sSubDistrict = item;
            }
          }
        });
        if (ItemSubDistrict.SUCCESS && ItemSubDistrict.RESPONSE_DATA.length > 0) {
          if (_suspectCompany) {
            setAutoCompleteSubDistrict2();
          } else {
            setAutoCompleteSubDistrict();
          }
        }
        onLoadActionDistinctMaster(_suspectCompany ? sSubDistrict_company.PROVINCE_ID : sSubDistrict.PROVINCE_ID, _suspectCompany ? sSubDistrict_company : sSubDistrict, IsUpdate);
      });
    }

    setState(() {});
    return true;
  }

  //เชื้อชาติ
  Future<bool> onLoadActionRaceMaster(bool IsUpdate, int RACE_ID) async {
    Map map = {"TEXT_SEARCH": "", "RACE_ID": ""};
    await new ArrestFutureMaster().apiRequestMasRacegetByCon(map).then((onValue) {
      print(onValue.SUCCESS.toString());
      ItemMasRace = onValue;
      if (ItemMasRace.SUCCESS && ItemMasRace.RESPONSE_DATA.length > 0) {
        setAutoCompleteRace();
        setAutoCompleteRace_foreigner();
        setAutoCompleteRace_company();

        if (!IsUpdate) {
          ItemMasRace.RESPONSE_DATA.forEach((item) {
            if (RACE_ID == item.RACE_ID) {
              sRace = item;
              editRace.text = item.RACE_NAME_TH.toString();
            }
          });
        }

        if (IsUpdate) {
          ItemMasRace.RESPONSE_DATA.forEach((item) {
            if (RACE_ID == item.RACE_ID) {
              if (widget.ItemsPerson.PERSON_TYPE == 0) {
                sRace = item;
                editRace.text = item.RACE_NAME_TH.toString();
              } else if (widget.ItemsPerson.PERSON_TYPE == 1) {
                // foreigner
                sRace_foreigner = item;
                editRace_foreigner.text = item.RACE_NAME_TH.toString();
              } else {
                // Company
                sRace_company = item;
                editRaceOrganize.text = item.RACE_NAME_TH.toString();
              }
            }
          });
        }
      }
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionNationalMaster(bool IsUpdate, int NATIONALITY_ID) async {
    Map map = {"TEXT_SEARCH": "", "NATIONALITY_ID": ""};
    await new ArrestFutureMaster().apiRequestMasNationalitygetByCon(map).then((onValue) {
      ItemNationality = onValue;
      if (ItemNationality.SUCCESS && ItemNationality.RESPONSE_DATA.length > 0) {
        setAutoCompleteNationality();
        setAutoCompleteNationality_foreigner();
        setAutoCompleteNationality_company();

        if (!IsUpdate) {
          ItemNationality.RESPONSE_DATA.forEach((item) {
            if (NATIONALITY_ID == item.NATIONALITY_ID) {
              sNational = item;
              editNationality.text = item.NATIONALITY_NAME_TH.toString();
            }
          });
        }

        if (IsUpdate) {
          ItemNationality.RESPONSE_DATA.forEach((item) {
            if (NATIONALITY_ID == item.NATIONALITY_ID) {
              if (widget.ItemsPerson.PERSON_TYPE == 0) {
                sNational = item;
                editNationality.text = item.NATIONALITY_NAME_TH.toString();
              } else if (widget.ItemsPerson.PERSON_TYPE == 1) {
                // foreigner
                sNational_foreigner = item;
                editNationality_foreigner.text = item.NATIONALITY_NAME_TH.toString();
              } else {
                // Company
                sNational_company = item;
                editNationality_company.text = item.NATIONALITY_NAME_TH.toString();
              }
            }
          });
        }
      }
    });
    setState(() {});
    return true;
  }

  Future<bool> onLoadActionInsPersonAllMaster(Map map_person, String FileName) async {
    print('Save !!!}');

    print('map_person: ${map_person.toString()}');
    int PERSON_ID;
    await new ArrestFutureMaster().apiRequestMasPersoninsAll(map_person).then((onValue) {
      PERSON_ID = onValue.RESPONSE_DATA;
    });
    List<Map> _arrJsonImg = [];
    List<File> _arrFiles = [];
    int index = 0;
    for (int i = 0; i < _arrItemsImageFile.length; i++) {
      File file = _arrItemsImageFile[i].FILE_CONTENT;
      String base64Image = base64Encode(file.readAsBytesSync());
      index++;
      _arrJsonImg.add({
        "DATA_SOURCE": "",
        "DOCUMENT_ID": "",
        "DOCUMENT_NAME": PERSON_ID.toString() + "P00" + index.toString() + ".jpg",
        "DOCUMENT_OLD_NAME": _arrItemsImageFile[i].DOCUMENT_OLD_NAME,
        "DOCUMENT_TYPE": "3",
        "FILE_TYPE": "jpg",
        "FOLDER": "person",
        "IS_ACTIVE": "1",
        "REFERENCE_CODE": PERSON_ID,
        "CONTENT": base64Image
      });
      _arrFiles.add(file);
    }
    /*_arrItemsImageFile.forEach((_file){


      String base64Image = base64Encode(_file.FILE_CONTENT.readAsBytesSync());
      index++;
      _arrJsonImg.add({
        "DATA_SOURCE": "",
        "DOCUMENT_ID": "",
        "DOCUMENT_NAME": FileName+"_"+index.toString(),
        "DOCUMENT_OLD_NAME": _file.DOCUMENT_OLD_NAME,
        "DOCUMENT_TYPE": "3",
        "FILE_TYPE": "jpg",
        "FOLDER": "Person",
        "IS_ACTIVE": "1",
        "REFERENCE_CODE": PERSON_ID,
        "CONTENT":base64Image
      });
    });*/

    for (int i = 0; i < _arrJsonImg.length; i++) {
      await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i], _arrFiles[i]).then((onValue) {
        print("[" + i.toString() + "] : " + onValue.DOCUMENT_ID.toString());
      });
    }

    if (PERSON_ID != null) {
      Map map_person = {"TEXT_SEARCH": "", "PERSON_ID": PERSON_ID};
      print(map_person.toString());
      await new ArrestFutureMaster().apiRequestMasPersongetByCon(map_person).then((onValue) {
        onValue.RESPONSE_DATA.forEach((f) {
          f.IsCreate = true;
        });
        _getPersonResponse = onValue;
        Navigator.pop(context);
      });
    }

    setState(() {});
    return true;
  }

  Future<bool> onLoadActionUpdPersonAllMaster(
      Map map_person, List<Map> map_person_relation_create, List<Map> map_person_relation_update, List<Map> map_person_relation_delete, List<Map> map_person_address_create, List<Map> map_person_address_update, List<Map> map_person_address_delete, String FileName) async {
    if (map_person_relation_create.isNotEmpty) {
      for (int i = 0; i < map_person_relation_create.length; i++) {
        await new ArrestFutureMaster().apiRequestMasPersonRelationshipinsAll(map_person_relation_create[i]).then((onValue) {
          print("Relationship add [" + i.toString() + "] : " + onValue.SUCCESS.toString());
        });
      }
    }
    /*if(map_person_relation_update.isNotEmpty){
      await new ArrestFutureMaster().apiRequestMasPersonRelationshipupdAll(map_person_relation_update).then((onValue) {
        print("Relationship update : "+onValue[0].SUCCESS.toString());
      });
    }*/
    if (map_person_relation_delete.isNotEmpty) {
      await new ArrestFutureMaster().apiRequestMasPersonRelationshipupdDelete(map_person_relation_delete).then((onValue) {
        print("Relationship delete : " + onValue[0].SUCCESS.toString());
      });
    }
    if (map_person_address_create.isNotEmpty) {
      for (int i = 0; i < map_person_address_create.length; i++) {
        await new ArrestFutureMaster().apiRequestMasPersonAddressinsAll(map_person_address_create[i]).then((onValue) {
          print("Address add [" + i.toString() + "] : " + onValue.SUCCESS.toString());
        });
      }
    }
    /*if(map_person_address_update.isNotEmpty){
      await new ArrestFutureMaster().apiRequestMasPersonAddressupdAll(map_person_address_update).then((onValue) {
        print("Address update : "+onValue[0].SUCCESS.toString());
      });
    }*/
    if (map_person_address_delete.isNotEmpty) {
      await new ArrestFutureMaster().apiRequestMasPersonAddressupdDelete(map_person_address_delete).then((onValue) {
        print("Address delete : " + onValue[0].SUCCESS.toString());
      });
    }

    for (int i = 0; i < _arrItemsImageFileDelete.length; i++) {
      Map map = {"DOCUMENT_ID": _arrItemsImageFileDelete[i]};
      print(map);
      await new TransectionFuture().apiRequestDocumentupdDelete(map).then((onValue) {
        print("Delete [" + i.toString() + "] : " + onValue.Msg.toString());
      });
    }

    List<Map> _arrJsonImg = [];
    List<File> _arrFiles = [];
    int index = _arrItemsImageFileAdd.length;

    for (int i = 0; i < _arrItemsImageFileAdd.length; i++) {
      File file = _arrItemsImageFileAdd[i].FILE_CONTENT;
      String base64Image = base64Encode(file.readAsBytesSync());
      index++;
      _arrJsonImg.add({
        "DATA_SOURCE": "",
        "DOCUMENT_ID": "",
        "DOCUMENT_NAME": widget.ItemsPerson.PERSON_ID.toString() + "P00" + index.toString() + ".jpg",
        "DOCUMENT_OLD_NAME": _arrItemsImageFileAdd[i].DOCUMENT_OLD_NAME,
        "DOCUMENT_TYPE": "3",
        "FILE_TYPE": "jpg",
        "FOLDER": "person",
        "IS_ACTIVE": "1",
        "REFERENCE_CODE": widget.ItemsPerson.PERSON_ID,
        "CONTENT": base64Image
      });
      _arrFiles.add(file);
    }

    for (int i = 0; i < _arrJsonImg.length; i++) {
      await new TransectionFuture().apiRequestDocumentinsAll(_arrJsonImg[i], _arrFiles[i]).then((onValue) {
        print("Update Add [" + i.toString() + "] : " + onValue.DOCUMENT_ID.toString());
      });
    }

    await new ArrestFutureMaster().apiRequestMasPersonupdAll(map_person).then((onValue) {
      print("Upd Person All : " + onValue.SUCCESS.toString());
    });

    Map map_get = {"TEXT_SEARCH": "", "PERSON_ID": widget.ItemsPerson.PERSON_ID};
    await new ArrestFutureMaster().apiRequestMasPersongetByCon(map_get).then((onValue) {
      onValue.RESPONSE_DATA.forEach((f) {
        f.IsCreate = true;
      });
      _getPersonResponse = onValue;
      print("_getPersonResponse : " + _getPersonResponse.SUCCESS.toString());
      Navigator.pop(context);
    });

    setState(() {});
    return true;
  }

  //dialog
  TextStyle TitleStyle = TextStyle(fontSize: 16.0, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonAcceptStyle = TextStyle(color: Colors.blue, fontSize: 18.0, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);
  TextStyle ButtonCancelStyle = TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.w600, fontFamily: FontStyles().FontFamily);

  CupertinoAlertDialog _createCupertinoCancelDeleteDialog(int DocumentID) {
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
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      });
                  onLoadActionDocumentupdDelete(DocumentID);
                  Navigator.pop(context);
                });
              },
              child: new Text('ยืนยัน', style: ButtonAcceptStyle)),
        ]);
  }

  void _showDeleteAlertDialog(int DocumentID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _createCupertinoCancelDeleteDialog(DocumentID);
      },
    );
  }

  Future<bool> onLoadActionDocumentupdDelete(int DOCUMENT_ID) async {
    Map map_doc = {"DOCUMENT_ID": DOCUMENT_ID};
    await new TransectionFuture().apiRequestDocumentupdDelete(map_doc).then((onValue) {
      print("Image delete : " + onValue.Msg);
    });
    setState(() {});
    return true;
  }

  //check ID Card.
  bool checkID(PID) {
    if (PID.length != 13) return false;
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      sum += int.parse(PID[i]) * (13 - i);
    }
    if ((11 - (sum % 11)) % 10 == int.parse(PID[12])) return true;
    return false;
  }

  //compress file and get file.
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath,
        quality: 88,
        //quality: 65,
        minHeight: 250,
        minWidth: 250);

    print("A : " + file.lengthSync().toString());
    print("B : " + result.path.toString());

    return result;
  }

  // ********************************** Layout **********************************
  Widget _buildContent(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      //color: Colors.grey[200],
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                  //color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border(
                    //top: BorderSide(color: Colors.grey[300], width: 1.0),
                    bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
              width: size.width,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          widget.IsNotice ? "ประเภทผู้ต้องสงสัย" : "ประเภทผู้กระทำผิด",
                          style: textLabelStyle,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: size.width / 2.5,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _suspectThai = true;
                                      _suspectCompany = false;
                                      _suspectForeigner = false;
                                      editRace.text = "ไทย";
                                      editNationality.text = "ไทย";
                                    });

                                    // if (_suspectThai) {
                                    //   onLoadActionNationalInit();
                                    //   onLoadActionRaceInit();
                                    // }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _suspectThai ? Colors.blue : Colors.white,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: _suspectThai
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
                                    'คนไทย',
                                    style: textStyleSelect,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: size.width / 2.5,
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _suspectThai = false;
                                      _suspectCompany = false;
                                      _suspectForeigner = true;
                                      editRace.text = "";
                                      editNationality.text = "";
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _suspectForeigner ? Colors.blue : Colors.white,
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: _suspectForeigner
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
                                    'คนต่างชาติ',
                                    style: textStyleSelect,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: size.width / 2.5,
                              child: Row(
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _suspectThai = false;
                                        _suspectCompany = true;
                                        _suspectForeigner = false;

                                        // if (_suspectCompany) {
                                        //   onLoadActionNationalInit();
                                        //   onLoadActionRaceInit();
                                        //   onLoadActionProvinceMaster(1, null, false);
                                        // }
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _suspectCompany ? Colors.blue : Colors.white,
                                        border: Border.all(color: Colors.black12),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: _suspectCompany
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
                                      'ผู้ประกอบการ',
                                      style: textStyleSelect,
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                      _suspectThai ? _buildInputThai() : (_suspectCompany ? _buildInputOrganize() : _buildInputForeigner()),
                      Container(
                        height: (size.height * 10) / 100,
                      )
                    ],
                  ),
                ),
              )),
          Container(
            width: size.width,
            child: _buildButtonImgPicker(),
          ),
          _buildDataImage(context),
        ],
      ),
    );
  }

  // *********************************************** Layout Thai people ***********************************************************
  Widget _buildInputThai() {
    var size = MediaQuery.of(context).size;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Row(
                children: <Widget>[
                  Text(
                    "หมายเลขบัตรประชาชน",
                    style: textLabelStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: paddingInputBox,
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(13),
                ],
                focusNode: myFocusNodeIDNo,
                controller: editIDNo,
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
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "คำนำหน้าชื่อ",
                style: textLabelStyle,
              ),
              Text(
                " *",
                style: textStyleStar,
              ),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListTitleName),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                widget.IsNotice ? "ชื่อผู้ต้องสงสัย" : "ชื่อผู้ต้องหา",
                style: textLabelStyle,
              ),
              Text(
                " *",
                style: textStyleStar,
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameSus,
            controller: editFirstNameSus,
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
                widget.IsNotice ? "นามสกุลผู้ต้องสงสัย" : "นามสกุลผู้ต้องหา",
                style: textLabelStyle,
              ),
              Text(
                " *",
                style: textStyleStar,
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameSus,
            controller: editLastNameSus,
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
                "เชื้อชาติ",
                style: textLabelStyle,
              ),
              // Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListRace),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "สัญชาติ",
                style: textLabelStyle,
              ),
              // Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListNationality),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "อาชีพ",
                style: textLabelStyle,
              ),
              // Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCareer,
            controller: editCareer,
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
                "จังหวัด",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: _textListProvince,
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "อำเภอ/เขต",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: _textListDistrict,
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "ตำบล/แขวง",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          //padding: paddingInputBox,
          child: _textListSubDistrict,
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "คำนำหน้าชื่อ",
            style: textLabelStyle,
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListTitleNameFather),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ชื่อบิดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameFather_1,
            controller: editFirstNameFather,
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
            "นามสกุลบิดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameFather_1,
            controller: editLastNameFather,
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
            "คำนำหน้าชื่อ",
            style: textLabelStyle,
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListTitleNameMother),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ชื่อมารดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameMother_1,
            controller: editFirstNameMother,
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
            "นามสกุลมารดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameMother_1,
            controller: editLastNameMother,
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

  // *********************************************** Layout Organize ***********************************************************
  Widget _buildInputOrganize() {
    var size = MediaQuery.of(context).size;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "ลักษณะผู้กระทำผิด",
            style: textLabelStyle,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: size.width / 2.5,
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _entityLegal = true;
                        _entityPeople = false;
                        entity = 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _entityLegal ? Colors.blue : Colors.white,
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: _entityLegal
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
                      'นิติบุคคล',
                      style: textStyleSelect,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width / 2.5,
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _entityLegal = false;
                        _entityPeople = true;
                        entity = 0;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _entityPeople ? Colors.blue : Colors.white,
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: _entityPeople
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
                      'บุคคลธรรมดา',
                      style: textStyleSelect,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "หมายเลขบัตรประชาชน ",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(13),
            ],
            focusNode: myFocusNodeIDNo_Company,
            controller: editIDNo_Company,
            keyboardType: TextInputType.number,
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
                "เลขทะเบียนนิติบุคคล",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusNodeEntityNo_Company,
            controller: editCompanyRegistrationNo_Company,
            keyboardType: TextInputType.number,
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
            "เลขทะเบียนสรรพสามิต",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(17),
            ],
            focusNode: myFocusNodeExciseRegistrationNo_Company,
            controller: editExciseRegistrationNo_Company,
            keyboardType: TextInputType.number,
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
                "คำนำหน้าชื่อผู้ประกอบการ",
                style: textLabelStyle,
              ),
              Text(
                " *",
                style: textStyleStar,
              ),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListCompanyTitle),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "ชื่อผู้ประกอบการ",
                style: textLabelStyle,
              ),
              Text(
                " *",
                style: textStyleStar,
              )
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompanyName,
            controller: editCompanyName,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Row(
                children: <Widget>[
                  Text(
                    "ประเทศ",
                    style: textLabelStyle,
                  ),
                  // Text(
                  //   " *",
                  //   style: textStyleStar,
                  // ),
                ],
              ),
            ),
            Container(
              width: size.width,
              //padding: paddingInputBox,
              child: _textListCountry_company,
            ),
            _buildLine,
          ],
        ),
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "จังหวัด",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListProvince2),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "อำเภอ/เขต",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListDistrict2),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "ตำบล/แขวง",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListSubDistrict2),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "คำนำหน้าชื่อตัวแทน",
            style: textLabelStyle,
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListTitleNameCompany_agent),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "ชื่อตัวแทน",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompany_agentFirstName,
            controller: editCompany_agentFirstName,
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
                "นามสกุลตัวแทน",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCompany_agentLastName,
            controller: editCompany_agentLastName,
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
                "เชื้อชาติ",
                style: textLabelStyle,
              ),
              // Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListRaceOrganize),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "สัญชาติ",
                style: textLabelStyle,
              ),
              // Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListNationalityCompany),
        _buildLine,
      ],
    );
  }

// *********************************************** Layout Foreigner ***********************************************************
  Widget _buildInputForeigner() {
    var size = MediaQuery.of(context).size;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "เลขที่หนังสือเดินทาง",
                style: textLabelStyle,
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            //maxLength: 14,
            focusNode: myFocusNodePassportNo,
            controller: editPassportNo,
            // keyboardType: TextInputType.number,
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
                "คำนำหน้าชื่อ",
                style: textLabelStyle,
              ),
              Text(
                " *",
                style: textStyleStar,
              ),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListTitle_foreigner),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                widget.IsNotice ? "ชื่อผู้ต้องสงสัย" : "ชื่อผู้ต้องหา",
                style: textLabelStyle,
              ),
              Text(
                " *",
                style: textStyleStar,
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameSus_foreigner,
            controller: editFirstNameSus_foreigner,
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
                widget.IsNotice ? "นามสกุลผู้ต้องสงสัย" : "นามสกุลผู้ต้องหา",
                style: textLabelStyle,
              ),
              Text(
                " *",
                style: textStyleStar,
              ),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameSus_foreigner,
            controller: editLastNameSus_foreigner,
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
                "เชื้อชาติ",
                style: textLabelStyle,
              ),
              // Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListRace_foreigner),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "สัญชาติ",
                style: textLabelStyle,
              ),
              // Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListNationality_foreigner),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Row(
            children: <Widget>[
              Text(
                "อาชีพ",
                style: textLabelStyle,
              ),
              // Text(" *", style: textStyleStar,),
            ],
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeCareer_foreigner,
            controller: editCareer_foreigner,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Row(
                children: <Widget>[
                  Text(
                    "ประเทศ",
                    style: textLabelStyle,
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              //padding: paddingInputBox,
              child: _textListCountry_foreigner,
            ),
            _buildLine,
          ],
        ),
        Container(
          padding: paddingLabel,
          child: Text(
            "คำนำหน้าชื่อ",
            style: textLabelStyle,
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListTitleNameFather_foreigner),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ชื่อบิดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameFather_foreigner,
            controller: editFirstNameFather_foreigner,
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
            "นามสกุลบิดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameFather_foreigner,
            controller: editLastNameFather_foreigner,
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
            "คำนำหน้าชื่อ",
            style: textLabelStyle,
          ),
        ),
        Container(
            width: size.width,
            //padding: paddingInputBox,
            child: _textListTitleNameMother_foreigner),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ชื่อมารดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeFirstNameMother_foreigner,
            controller: editFirstNameMother_foreigner,
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
            "นามสกุลมารดา",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeLastNameMother_foreigner,
            controller: editLastNameMother_foreigner,
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

  // Main build layout
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    return new WillPopScope(
      onWillPop: () {
        //
      },
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: new Text(
                  widget.Title,
                  style: styleTextAppbar,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, "back");
                  }),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    _onSaved(context);
                  },
                  child: Text(
                    "บันทึก",
                    style: styleTextAppbar,
                  ),
                ),
              ],
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
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border(
                            top: BorderSide(color: Colors.grey[300], width: 1.0),
                          )),
                    ),
                    Expanded(
                      child: new ConstrainedBox(
                        constraints: const BoxConstraints.expand(),
                        child: SingleChildScrollView(
                            child: Column(
                          children: <Widget>[
                            _buildContent(context),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
