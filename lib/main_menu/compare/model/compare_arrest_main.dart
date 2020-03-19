import 'package:prototype_app_pang/main_menu/compare/model/compare_guiltbase_fine.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_indicment_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_prove_product.dart';

import 'compare_indicment_product.dart';

class ItemsCompareArrestMain {
  int LAWSUIT_IS_OUTSIDE;
  int LAWSUIT_ID;
  int INDICTMENT_ID;
  int PROVE_ID;
  int ARREST_ID;
  int SECTION_ID;
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
  // double FINE;
  
  int FINE_TYPE;
  int IS_PROVE;
  int IS_COMPARE;
  int SUBSECTION_RULE_ID;
  String SUBSECTION_NAME;
  String SUBSECTION_DESC;
  int SUBSECTION_ID;
  String SECTION_NAME;

  String FINE_RATE_MIN;
  String FINE_RATE_MAX;
  String FINE_MIN;
  String FINE_MAX;

  String PENALTY_DESC;
   int LAWSUIT_NO;
  // dynamic LAWSUIT_NO;
  String LAWSUIT_NO_YEAR;
  String LAWSUIT_DATE;
  int PROVE_NO;
  String PROVE_NO_YEAR;
  int PROVE_IS_OUTSIDE;
  String RECEIVE_DOC_DATE;
  List<ItemsCompareListIndicmentProduct> CompareArrestIndictmentProduct;
  List<ItemsCompareListProveProduct> CompareProveProduct;
  List<ItemsCompareListIndicmentDetail> CompareArrestIndictmentDetail;
  List<ItemsCompareGuiltbaseFine> CompareGuiltbaseFine;

  ItemsCompareArrestMain({
    this.LAWSUIT_IS_OUTSIDE,
    this.LAWSUIT_ID,
    this.SECTION_ID,
    this.INDICTMENT_ID,
    this.PROVE_ID,
    this.ARREST_ID,
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
    this.FINE_TYPE,
    this.IS_PROVE,
    this.IS_COMPARE,
    this.SUBSECTION_RULE_ID,
    this.SUBSECTION_NAME,
    this.SUBSECTION_DESC,
    this.SUBSECTION_ID,
    this.SECTION_NAME,

    this.FINE_RATE_MIN,
    this.FINE_RATE_MAX,
    this.FINE_MIN,
    this.FINE_MAX,

    this.PENALTY_DESC,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.LAWSUIT_DATE,
    this.PROVE_NO,
    this.PROVE_NO_YEAR,
    this.PROVE_IS_OUTSIDE,
    this.RECEIVE_DOC_DATE,
    this.CompareArrestIndictmentProduct,
    this.CompareProveProduct,
    this.CompareArrestIndictmentDetail,
    this.CompareGuiltbaseFine,
  });

  factory ItemsCompareArrestMain.fromJson(Map<String, dynamic> json) {
    return ItemsCompareArrestMain(
       LAWSUIT_IS_OUTSIDE :json['LAWSUIT_IS_OUTSIDE'],
      SECTION_ID: json['SECTION_ID'],
      LAWSUIT_ID: json['LAWSUIT_ID'],
      INDICTMENT_ID: json['INDICTMENT_ID'],
      PROVE_ID: json['PROVE_ID'],
      ARREST_ID: json['ARREST_ID'],
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
      FINE_TYPE: json['FINE_TYPE'],
      IS_PROVE: json['IS_PROVE'],
      IS_COMPARE: json['IS_COMPARE'],
      SUBSECTION_RULE_ID: json['SUBSECTION_RULE_ID'],
      SUBSECTION_NAME: json['SUBSECTION_NAME'],
      SUBSECTION_DESC: json['SUBSECTION_DESC'],
      SUBSECTION_ID: json['SUBSECTION_ID'],
      SECTION_NAME: json['SECTION_NAME'],

      FINE_RATE_MIN: json['FINE_RATE_MIN'],
      FINE_RATE_MAX: json['FINE_RATE_MAX'],
      FINE_MIN:  json['FINE_MIN'],
      FINE_MAX: json['FINE_MAX'],

      PENALTY_DESC: json['PENALTY_DESC'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],
      LAWSUIT_DATE: json['LAWSUIT_DATE'],
      PROVE_NO: json['PROVE_NO'],
      PROVE_NO_YEAR: json['PROVE_NO_YEAR'],
      PROVE_IS_OUTSIDE: json['PROVE_IS_OUTSIDE'],
      RECEIVE_DOC_DATE: json['RECEIVE_DOC_DATE'],
      CompareArrestIndictmentProduct: List.from(json['CompareArrestIndictmentProduct'].map((m) => ItemsCompareListIndicmentProduct.fromJson(m))),
      CompareProveProduct: List.from(json['CompareProveProduct'].map((m) => ItemsCompareListProveProduct.fromJson(m))),
      CompareArrestIndictmentDetail: List.from(json['CompareArrestIndictmentDetail'].map((m) => ItemsCompareListIndicmentDetail.fromJson(m))),
      CompareGuiltbaseFine: List.from(json['CompareGuiltbaseFine'].map((m) => ItemsCompareGuiltbaseFine.fromJson(m))),
    );
  }
}