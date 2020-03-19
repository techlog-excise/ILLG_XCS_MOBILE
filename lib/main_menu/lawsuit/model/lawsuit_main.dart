import 'dart:convert';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_office.dart';

import 'item_lawsuit_deatail.dart';
import 'item_lawsuit_staff.dart';

class ItemsLawsuitMain {
  int LAWSUIT_ID;
  int INDICTMENT_ID;
  ItemsListOffice OFFICE;
  int OFFICE_ID;
  String OFFICE_CODE;
  String OFFICE_NAME;
  int IS_LAWSUIT;
  String REMARK_NOT_LAWSUIT;
  int LAWSUIT_NO;
  String LAWSUIT_NO_YEAR;
  String LAWSUIT_DATE;
  String TESTIMONY;
  String DELIVERY_DOC_NO_1;
  String DELIVERY_DOC_NO_2;
  String DELIVERY_DOC_DATE;
  int IS_OUTSIDE;
  int IS_SEIZE;
  int IS_ACTIVE;

  String CREATE_DATE;
  int CREATE_USER_ACCOUNT_ID;
  String UPDATE_DATE;
  int UPDATE_USER_ACCOUNT_ID;

  List<ItemsListLawsuitStaff> LawsuitStaff;
  List<ItemsListLawsuitDetail> LawsuitDetail;

  ItemsLawsuitMain({
    this.LAWSUIT_ID,
    this.INDICTMENT_ID,
    this.OFFICE,
    this.OFFICE_ID,
    this.OFFICE_CODE,
    this.OFFICE_NAME,
    this.IS_LAWSUIT,
    this.REMARK_NOT_LAWSUIT,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.LAWSUIT_DATE,
    this.TESTIMONY,
    this.DELIVERY_DOC_NO_1,
    this.DELIVERY_DOC_NO_2,
    this.DELIVERY_DOC_DATE,
    this.IS_OUTSIDE,
    this.IS_SEIZE,
    this.IS_ACTIVE,
    this.CREATE_DATE,
    this.CREATE_USER_ACCOUNT_ID,
    this.UPDATE_DATE,
    this.UPDATE_USER_ACCOUNT_ID,
    this.LawsuitStaff,
    this.LawsuitDetail,
  });

  factory ItemsLawsuitMain.fromJson(Map<String, dynamic> js) {
    Map map_office = {
      "OFFICE_ID": js['OFFICE_ID'],
      "OFFICE_CODE": js['OFFICE_CODE'],
      "OFFICE_NAME": js['OFFICE_NAME'],
      "IS_ACTIVE": 1
    };
    var body_office = json.encode(map_office);
    return ItemsLawsuitMain(
      LAWSUIT_ID: js['LAWSUIT_ID'],
      INDICTMENT_ID: js['INDICTMENT_ID'],
      OFFICE:  ItemsListOffice.fromJson(json.decode(body_office)),
      OFFICE_ID: js['OFFICE_ID'],
      OFFICE_CODE: js['OFFICE_CODE'],
      OFFICE_NAME: js['OFFICE_NAME'],
      IS_LAWSUIT: js['IS_LAWSUIT'],
      REMARK_NOT_LAWSUIT: js['REMARK_NOT_LAWSUIT'],
      LAWSUIT_NO: js['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: js['LAWSUIT_NO_YEAR'],
      LAWSUIT_DATE: js['LAWSUIT_DATE'],
      TESTIMONY: js['TESTIMONY'],
      DELIVERY_DOC_NO_1: js['DELIVERY_DOC_NO_1'],
      DELIVERY_DOC_NO_2: js['DELIVERY_DOC_NO_2'],
      DELIVERY_DOC_DATE: js['DELIVERY_DOC_DATE'],
      IS_OUTSIDE: js['IS_OUTSIDE'],
      IS_SEIZE: js['IS_SEIZE'],
      IS_ACTIVE: js['IS_ACTIVE'],
      CREATE_DATE: js['CREATE_DATE'],
      CREATE_USER_ACCOUNT_ID: js['CREATE_USER_ACCOUNT_ID'],
      UPDATE_DATE: js['UPDATE_DATE'],
      UPDATE_USER_ACCOUNT_ID: js['UPDATE_USER_ACCOUNT_ID'],
      LawsuitStaff: List.from(js['LawsuitStaff'].map((m) => ItemsListLawsuitStaff.fromJson(m))),
      LawsuitDetail: List.from(js['LawsuitDetail'].map((m) => ItemsListLawsuitDetail.fromJson(m))),
    );
  }
}