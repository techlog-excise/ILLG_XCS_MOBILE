import 'package:prototype_app_pang/main_menu/tracking/model/data_api/tracking_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/tracking/model/data_api/tracking_product.dart';

class ItemsTrackingCase {
  List<ItemsTrackingList> CASE_STATUS_LIST;
  ItemsTrackingCase({
    this.CASE_STATUS_LIST
  });
  factory ItemsTrackingCase.fromJson(Map<String, dynamic> json) {
    return ItemsTrackingCase(
      CASE_STATUS_LIST: List.from(
            json['CASE_STATUS_LIST'].map((m) =>
                ItemsTrackingList.fromJson(m))),
    );
  }
}

//keyword
class ItemsTrackingCaseByKeyword {
  List<ItemsTrackingList> CaseStatusList;
  ItemsTrackingCaseByKeyword({
    this.CaseStatusList
  });
  factory ItemsTrackingCaseByKeyword.fromJson(Map<String, dynamic> json) {
    return ItemsTrackingCaseByKeyword(
      CaseStatusList: List.from(
          json['CaseStatusList'].map((m) =>
              ItemsTrackingList.fromJson(m))),
    );
  }
}
//byCon
class ItemsTrackingCaseByCon {
  List<ItemsTrackingList> CASE_STATUS;
  ItemsTrackingCaseByCon({
    this.CASE_STATUS
  });
  factory ItemsTrackingCaseByCon.fromJson(Map<String, dynamic> json) {
    return ItemsTrackingCaseByCon(
      CASE_STATUS: List.from(
          json['CASE_STATUS'].map((m) =>
              ItemsTrackingList.fromJson(m))),
    );
  }
}

class ItemsTrackingList {
  final String ARREST_ID;
  final String ARREST_CODE;
  final String OCCURRENCE_DATE;
  final String LOCATION;
  final List<ItemsTrackingLawbreker> LawbreakerList;
  final String ARREST_STAFF_NAME;
  final String SUBSECTION_NAME;
  final List<ItemsTrackingProductGroup> ProductList;
  final String LAWSUIT_NO; //เลขที่คดีรับคำกล่าวโทษ
  final String LAWSUIT_STAFF_NAME;
  final String LAWSUIT_DATE;
  final String LAWSUIT_OFFICE_NAME;
  final String PROVE_NO;
  final String PROVE_STAFF_NAME;
  final String PROVE_DATE;
  final String COMPARE_NO;
  final String COMPARE_STAFF_NAME;
  final String COMPARE_DATE;
  final String CASE_STATUS;
  final String RECEIPT_BOOK_NO;
  final String RECEIPT_NO;

  ItemsTrackingList({
    this.ARREST_ID,
    this.ARREST_CODE,
    this.OCCURRENCE_DATE,
    this.LOCATION,
    this.LawbreakerList,
    this.ARREST_STAFF_NAME,
    this.SUBSECTION_NAME,
    this.ProductList,
    this.LAWSUIT_NO,
    this.LAWSUIT_STAFF_NAME,
    this.LAWSUIT_DATE,
    this.LAWSUIT_OFFICE_NAME,
    this.PROVE_NO,
    this.PROVE_STAFF_NAME,
    this.PROVE_DATE,
    this.COMPARE_NO,
    this.COMPARE_STAFF_NAME,
    this.COMPARE_DATE,
    this.CASE_STATUS,
    this.RECEIPT_BOOK_NO,
    this.RECEIPT_NO,
  });

  factory ItemsTrackingList.fromJson(Map<String, dynamic> json) {
    return ItemsTrackingList(
        ARREST_ID: json['ARREST_ID'],
        ARREST_CODE: json['ARREST_CODE'],
        OCCURRENCE_DATE: json['OCCURRENCE_DATE'],
        LOCATION: json['LOCATION'],
        LawbreakerList: json['LawbreakerList']!=null
            ?List.from(json['LawbreakerList'].map((m) => ItemsTrackingLawbreker.fromJson(m)))
            :[],
        ARREST_STAFF_NAME: json['ARREST_STAFF_NAME'],
        SUBSECTION_NAME: json['SUBSECTION_NAME'],
        ProductList: json['ProductList']!=null
            ?List.from(json['ProductList'].map((m) => ItemsTrackingProductGroup.fromJson(m)))
            :[],
        LAWSUIT_NO: json['LAWSUIT_NO'],
        LAWSUIT_STAFF_NAME: json['LAWSUIT_STAFF_NAME'],
        LAWSUIT_DATE: json['LAWSUIT_DATE'],
        LAWSUIT_OFFICE_NAME: json['LAWSUIT_OFFICE_NAME'],
        PROVE_NO: json['PROVE_NO'],
        PROVE_STAFF_NAME: json['PROVE_STAFF_NAME'],
        PROVE_DATE: json['PROVE_DATE'],
        COMPARE_NO: json['COMPARE_NO'],
        COMPARE_STAFF_NAME: json['COMPARE_STAFF_NAME'],
        COMPARE_DATE: json['COMPARE_DATE'],
        CASE_STATUS: json['CASE_STATUS'],
        RECEIPT_BOOK_NO: json['RECEIPT_BOOK_NO'],
        RECEIPT_NO: json['RECEIPT_NO']
    );
  }
}


