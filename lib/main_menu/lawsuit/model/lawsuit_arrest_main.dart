
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_locale.dart';

import 'lawsuit_indicment_detail.dart';
import 'lawsuit_indicment_product.dart';
import 'lawsuit_notice.dart';

class ItemsLawsuitArrestMain {
  int ARREST_ID;  

  int INDICTMENT_ID;
  String ARREST_CODE;
  String OCCURRENCE_DATE;
  String ARREST_OFFICE_NAME;
  String ACCUSER_TITLE_NAME_TH;
  String ACCUSER_FIRST_NAME;
  String ACCUSER_LAST_NAME;
  String ACCUSER_OPERATION_POS_CODE;
  String ACCUSER_OPREATION_POS_NAME;
  String ACCUSER_OPERATION_POS_LEVEL_NAME;
  String ACCUSER_OPERATION_OFFICE_NAME;
  String ACCUSER_OPERATION_OFFICE_SHORT_NAME;
  String GUILTBASE_NAME;
  String FINE;
  int IS_PROVE;
  int IS_COMPARE;

  String SUBSECTION_NAME;
  String SUBSECTION_DESC;
  String SECTION_NAME;
  String PENALTY_DESC;
  List<ItemsLawsuitListIndicmentProduct> LawsuitArrestIndictmentProduct;
  List<ItemsLawsuitListIndicmentDetail> LawsuitArrestIndictmentDetail;
  List<ItemsListArrestLocale> LawsuitLocale;
  List<ItemsLawsuitNotice> LawsuitNotice;

  ItemsLawsuitArrestMain({
    this.ARREST_ID,

    this.INDICTMENT_ID,
    this.ARREST_CODE,
    this.OCCURRENCE_DATE,
    this.ARREST_OFFICE_NAME,
    this.ACCUSER_TITLE_NAME_TH,
    this.ACCUSER_FIRST_NAME,
    this.ACCUSER_LAST_NAME,
    this.ACCUSER_OPERATION_POS_CODE,
    this.ACCUSER_OPREATION_POS_NAME,
    this.ACCUSER_OPERATION_POS_LEVEL_NAME,
    this.ACCUSER_OPERATION_OFFICE_NAME,
    this.ACCUSER_OPERATION_OFFICE_SHORT_NAME,
    this.GUILTBASE_NAME,
    this.FINE,
    this.IS_PROVE,
    this.IS_COMPARE,
    this.SUBSECTION_NAME,
    this.SUBSECTION_DESC,
    this.SECTION_NAME,
    this.PENALTY_DESC,
    this.LawsuitArrestIndictmentProduct,
    this.LawsuitArrestIndictmentDetail,
    this.LawsuitLocale,
    this.LawsuitNotice,
  });

  factory ItemsLawsuitArrestMain.fromJson(Map<String, dynamic> json) {
    return ItemsLawsuitArrestMain(
    
      ARREST_ID: json['ARREST_ID'],
      INDICTMENT_ID: json['INDICTMENT_ID'],
      ARREST_CODE: json['ARREST_CODE'],
      OCCURRENCE_DATE: json['OCCURRENCE_DATE'],
      ARREST_OFFICE_NAME: json['ARREST_OFFICE_NAME'],
      ACCUSER_TITLE_NAME_TH: json['ACCUSER_TITLE_NAME_TH'],
      ACCUSER_FIRST_NAME: json['ACCUSER_FIRST_NAME'],
      ACCUSER_LAST_NAME: json['ACCUSER_LAST_NAME'],
      ACCUSER_OPERATION_POS_CODE: json['ACCUSER_OPERATION_POS_CODE'],
      ACCUSER_OPREATION_POS_NAME: json['ACCUSER_OPREATION_POS_NAME'],
      ACCUSER_OPERATION_POS_LEVEL_NAME: json['ACCUSER_OPERATION_POS_LEVEL_NAME'],
      ACCUSER_OPERATION_OFFICE_NAME: json['ACCUSER_OPERATION_OFFICE_NAME'],
      ACCUSER_OPERATION_OFFICE_SHORT_NAME: json['ACCUSER_OPERATION_OFFICE_SHORT_NAME'],
      GUILTBASE_NAME: json['GUILTBASE_NAME'],
      FINE: json['FINE'],
      IS_PROVE: json['IS_PROVE'],
      IS_COMPARE: json['IS_COMPARE'],
      SUBSECTION_NAME: json['SUBSECTION_NAME'],
      SUBSECTION_DESC: json['SUBSECTION_DESC'],
      SECTION_NAME: json['SECTION_NAME'],
      PENALTY_DESC: json['PENALTY_DESC'],
      LawsuitArrestIndictmentProduct: List.from(json['LawsuitArrestIndictmentProduct'].map((m) => ItemsLawsuitListIndicmentProduct.fromJson(m))),
      LawsuitArrestIndictmentDetail: List.from(json['LawsuitArrestIndictmentDetail'].map((m) => ItemsLawsuitListIndicmentDetail.fromJson(m))),
      LawsuitLocale: List.from(json['LawsuitLocale'].map((m) => ItemsListArrestLocale.fromJson(m))),
      LawsuitNotice: List.from(json['LawsuitNotice'].map((m) => ItemsLawsuitNotice.fromJson(m))),
    );
  }
}