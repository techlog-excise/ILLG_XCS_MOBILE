
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_indictment.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_locale.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_notice.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_staff.dart';

class ItemsListArrestMain {
  final int ARREST_ID;
  final int OFFICE_ID;
  final String ARREST_CODE;
  final String OFFICE_CODE;
  final String OFFICE_NAME;
  final String ARREST_DATE;
  final String OCCURRENCE_DATE;
  final String BEHAVIOR_1;
  final String BEHAVIOR_2;
  final String BEHAVIOR_3;
  final String BEHAVIOR_4;
  final String BEHAVIOR_5;
  final String TESTIMONY;
  final int IS_REQUEST;
  final String REQUEST_DESC;
  final int IS_LAWSUIT_COMPLETE;
  final int IS_ACTIVE;
  final String CREATE_DATE;
  final int CREATE_USER_ACCOUNT_ID;
  final String UPDATE_DATE;
  final int UPDATE_USER_ACCOUNT_ID;

  List ArrestStaff;
  List<ItemsListArrestLocale> ArrestLocale;
  List ArrestLawbreaker;
  List ArrestProduct;
  List ArrestIndictment;
  List/*<ItemsListArrestNotice>*/ ArrestNotice;
  //ArrestPurityCert
  //ArrestSearchWarrant

  ItemsListArrestMain({
    this.ARREST_ID,
    this.OFFICE_ID,
    this.ARREST_CODE,
    this.OFFICE_CODE,
    this.OFFICE_NAME,
    this.ARREST_DATE,
    this.OCCURRENCE_DATE,
    this.BEHAVIOR_1,
    this.BEHAVIOR_2,
    this.BEHAVIOR_3,
    this.BEHAVIOR_4,
    this.BEHAVIOR_5,
    this.TESTIMONY,
    this.IS_REQUEST,
    this.REQUEST_DESC,
    this.IS_LAWSUIT_COMPLETE,
    this.IS_ACTIVE,
    this.CREATE_DATE,
    this.CREATE_USER_ACCOUNT_ID,
    this.UPDATE_DATE,
    this.UPDATE_USER_ACCOUNT_ID,
    this.ArrestStaff,
    this.ArrestLocale,
    this.ArrestNotice,
    this.ArrestLawbreaker,
    this.ArrestProduct,
    this.ArrestIndictment,
  });

  factory ItemsListArrestMain.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestMain(
      ARREST_ID: js['ARREST_ID'],
      OFFICE_ID: js['OFFICE_ID'],
      ARREST_CODE: js['ARREST_CODE'],
      OFFICE_CODE: js['OFFICE_CODE'],
      OFFICE_NAME: js['OFFICE_NAME'],
      ARREST_DATE: js['ARREST_DATE'],
      OCCURRENCE_DATE: js['OCCURRENCE_DATE'],
      BEHAVIOR_1: js['BEHAVIOR_1'],
      BEHAVIOR_2: js['BEHAVIOR_2'],
      BEHAVIOR_3: js['BEHAVIOR_3'],
      BEHAVIOR_4: js['BEHAVIOR_4'],
      BEHAVIOR_5: js['BEHAVIOR_5'],
      TESTIMONY: js['TESTIMONY'],
      IS_REQUEST: js['IS_REQUEST'],
      REQUEST_DESC: js['REQUEST_DESC'],
      IS_LAWSUIT_COMPLETE: js['IS_LAWSUIT_COMPLETE'],
      IS_ACTIVE: js['IS_ACTIVE'],
      CREATE_DATE: js['CREATE_DATE'],
      CREATE_USER_ACCOUNT_ID: js['CREATE_USER_ACCOUNT_ID'],
      UPDATE_DATE: js['UPDATE_DATE'],
      UPDATE_USER_ACCOUNT_ID: js['UPDATE_USER_ACCOUNT_ID'],
      ArrestStaff:  List.from(js['ArrestStaff'].map((m) => ItemsListArrestStaff.fromJson(m))),
      ArrestLawbreaker:  List.from(js['ArrestLawbreaker'].map((m) => ItemsListArrestLawbreaker.fromJson(m))),
      ArrestLocale: List<ItemsListArrestLocale>.from(js['ArrestLocale'].map((m) => ItemsListArrestLocale.fromJson(m))),
      ArrestNotice: List/*<ItemsListArrestNotice>*/.from(js['ArrestNotice'].map((m) => ItemsListArrestNotice.fromJson(m))),
      ArrestProduct: List.from(js['ArrestProduct'].map((m) => ItemsListArrestProductMapping.fromJson(m))),
      ArrestIndictment: List.from(js['ArrestIndictment'].map((m) => ItemsListArrestIndictment.fromJson(m))),
    );
  }
}