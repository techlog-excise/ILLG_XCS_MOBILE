import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_address.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_photo.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_person_relationship.dart';
import 'dart:convert';

class ItemsListArrestLawbreaker {
  int INDICTMENT_DETAIL_ID;

  int LAWBREAKER_ID;
  int ARREST_ID;
  int PERSON_ID;
  int COUNTRY_ID;

  int NATIONALITY_ID;
  int RACE_ID;

  int PERSON_TYPE;
  int ENTITY_TYPE;
  String ID_CARD;
  String PASSPORT_NO;
  String COMPANY_NAME;
  String EXCISE_REGISTRATION_NO;
  String COMPANY_REGISTRATION_NO;
  int TITLE_ID;
  String TITLE_NAME_TH;
  String TITLE_NAME_EN;
  String TITLE_SHORT_NAME_TH;
  String TITLE_SHORT_NAME_EN;
  String FIRST_NAME;
  String MIDDLE_NAME;
  String LAST_NAME;
  String OTHER_NAME;
  String CAREER;
  int MISTREAT_NO;
  int AGE;
  List<ItemsListArrestPersonRelationShip> MAS_PERSON_RELATIONSHIP;
  List<ItemsListArrestAddressPerson> MAS_PERSON_ADDRESS;
  List<ItemsListArrestPhotoPerson> MAS_PERSON_PHOTO;
  bool IsCheck;
  bool IsCheckOffence;
  int INDEX;
  bool IsCreate;
  //ItemsListArrest6Controller Arrest6Controller;
  //double FINE_ESTIMATE;
  ExpandableController expController;
  TextEditingController editFine;
  FocusNode myFocusNodeFine;

  int REF_CODE;
  double CONFIDENCE;

  ItemsListArrestLawbreaker(
      {this.INDICTMENT_DETAIL_ID,
      this.LAWBREAKER_ID,
      this.ARREST_ID,
      this.PERSON_ID,
      this.COUNTRY_ID,
      this.NATIONALITY_ID,
      this.RACE_ID,
      this.PERSON_TYPE,
      this.ENTITY_TYPE,
      this.ID_CARD,
      this.PASSPORT_NO,
      this.COMPANY_NAME,
      this.EXCISE_REGISTRATION_NO,
      this.COMPANY_REGISTRATION_NO,
      this.TITLE_ID,
      this.TITLE_NAME_TH,
      this.TITLE_NAME_EN,
      this.TITLE_SHORT_NAME_TH,
      this.TITLE_SHORT_NAME_EN,
      this.FIRST_NAME,
      this.MIDDLE_NAME,
      this.LAST_NAME,
      this.OTHER_NAME,
      this.CAREER,
      this.MISTREAT_NO,
      this.AGE,
      this.MAS_PERSON_RELATIONSHIP,
      this.MAS_PERSON_ADDRESS,
      this.MAS_PERSON_PHOTO,
      this.IsCheck,
      this.IsCheckOffence,
      this.INDEX,
      this.IsCreate,

      //this.FINE_ESTIMATE,
      this.expController,
      this.editFine,
      this.myFocusNodeFine,
      //this.Arrest6Controller,

      this.REF_CODE,
      this.CONFIDENCE});

  factory ItemsListArrestLawbreaker.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestLawbreaker(
      INDICTMENT_DETAIL_ID: js['INDICTMENT_DETAIL_ID'],
      LAWBREAKER_ID: js['LAWBREAKER_ID'],
      ARREST_ID: js['ARREST_ID'],
      PERSON_ID: js['PERSON_ID'],
      COUNTRY_ID: js['COUNTRY_ID'],

      NATIONALITY_ID: js['NATIONALITY_ID'],
      RACE_ID: js['RACE_ID'],

      PERSON_TYPE: js['PERSON_TYPE'],
      ENTITY_TYPE: js['ENTITY_TYPE'],
      ID_CARD: js['ID_CARD'],
      PASSPORT_NO: js['PASSPORT_NO'],

      COMPANY_NAME: js['COMPANY_NAME'],
      EXCISE_REGISTRATION_NO: js['EXCISE_REGISTRATION_NO'],

      COMPANY_REGISTRATION_NO: js['COMPANY_REGISTRATION_NO'],
      TITLE_ID: js['TITLE_ID'],
      // TITLE_NAME_TH: js['PERSON_TYPE'] == 0 ? js['TITLE_NAME_TH'] : js['TITLE_NAME_EN'],
      TITLE_NAME_TH: js['PERSON_TYPE'] == 1 ? js['TITLE_NAME_EN'] : js['TITLE_NAME_TH'],
      TITLE_NAME_EN: js['TITLE_NAME_EN'],
      // TITLE_SHORT_NAME_TH: js['PERSON_TYPE'] == 0 ? js['TITLE_SHORT_NAME_TH'] : js['TITLE_SHORT_NAME_EN'],
      TITLE_SHORT_NAME_TH: js['PERSON_TYPE'] == 1 ? js['TITLE_SHORT_NAME_EN'] : js['TITLE_SHORT_NAME_TH'],
      TITLE_SHORT_NAME_EN: js['TITLE_SHORT_NAME_EN'],
      FIRST_NAME: js['FIRST_NAME'],
      MIDDLE_NAME: js['MIDDLE_NAME'],
      LAST_NAME: js['LAST_NAME'],
      OTHER_NAME: js['OTHER_NAME'],
      CAREER: js['CAREER'],
      MISTREAT_NO: js['MISTREAT_NO'],
      AGE: js['AGE'],
      //MAS_PERSON_RELATIONSHIP: [],
      MAS_PERSON_ADDRESS: js['MAS_PERSON_ADDRESS'] != null ? List<ItemsListArrestAddressPerson>.from(js['MAS_PERSON_ADDRESS'].map((m) => ItemsListArrestAddressPerson.fromJson(m))) : [],
      MAS_PERSON_PHOTO: [],
      //MAS_PERSON_RELATIONSHIP:List<ItemsListArrestPersonRelationShip>.from(js['MAS_PERSON_RELATIONSHIP'].map((m) => ItemsListArrestPersonRelationShip.fromJson(m))),
      MAS_PERSON_RELATIONSHIP: js['ArrestMasPersonRelationship'] == null
          ? (js['MAS_PERSON_RELATIONSHIP'] == null ? [] : List<ItemsListArrestPersonRelationShip>.from(js['MAS_PERSON_RELATIONSHIP'].map((m) => ItemsListArrestPersonRelationShip.fromJson(m))))
          : List<ItemsListArrestPersonRelationShip>.from(js['ArrestMasPersonRelationship'].map((m) => ItemsListArrestPersonRelationShip.fromJson(m))),
      //FINE_ESTIMATE: null,
      IsCheck: false,
      IsCheckOffence: false,
      INDEX: null,
      IsCreate: false,
      /*Arrest6Controller: new ItemsListArrest6Controller(
          new ExpandableController(),
          null,
          null,
          null,
          null,
          null,
          null
      ),*/
      expController: new ExpandableController(),
      editFine: new TextEditingController(),
      myFocusNodeFine: new FocusNode(),

      REF_CODE: null,
      CONFIDENCE: null,
    );
  }
}
