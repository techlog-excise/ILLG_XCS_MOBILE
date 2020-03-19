import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

import 'evidence_out_arrest.dart';
import 'evidence_out_guiltbase.dart';

class ItemsEvidenceOutLawsuit {
  final int LAWSUIT_ID;
  final int INDICTMENT_ID;
  final int OFFICE_ID;
  final String OFFICE_CODE;
  final String OFFICE_NAME;
  final int IS_LAWSUIT;
  final String REMARK_NOT_LAWSUIT;
  final int LAWSUIT_NO;
  final String LAWSUIT_NO_YEAR;
  final String LAWSUIT_DATE;
  final String TESTIMONY;
  final String DELIVERY_DOC_NO_1;
  final String DELIVERY_DOC_NO_2;
  final String DELIVERY_DOC_DATE;
  final int IS_OUTSIDE;
  final int IS_SEIZE;
  ItemsEvidenceOutArrest EvidenceOutArrest;
  ItemsEvidenceOutGuiltbase EvidenceOutGuiltbase;

  ItemsEvidenceOutLawsuit({
    this.LAWSUIT_ID,
    this.INDICTMENT_ID,
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
    this.EvidenceOutArrest,
    this.EvidenceOutGuiltbase
  });

  factory ItemsEvidenceOutLawsuit.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceOutLawsuit(
      LAWSUIT_ID: json['LAWSUIT_ID'],
      INDICTMENT_ID: json['INDICTMENT_ID'],
      OFFICE_ID: json['OFFICE_ID'],
      OFFICE_CODE: json['OFFICE_CODE'],
      OFFICE_NAME: json['OFFICE_NAME'],
      IS_LAWSUIT: json['IS_LAWSUIT'],
      REMARK_NOT_LAWSUIT: json['REMARK_NOT_LAWSUIT'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],
      LAWSUIT_DATE: json['LAWSUIT_DATE'],
      TESTIMONY: json['TESTIMONY'],
      DELIVERY_DOC_NO_1: json['DELIVERY_DOC_NO_1'],
      DELIVERY_DOC_NO_2: json['DELIVERY_DOC_NO_2'],
      DELIVERY_DOC_DATE: json['DELIVERY_DOC_DATE'],
      IS_OUTSIDE: json['IS_OUTSIDE'],
      IS_SEIZE: json['IS_SEIZE'],
      EvidenceOutArrest: ItemsEvidenceOutArrest.fromJson(json['EvidenceOutArrest']),
      EvidenceOutGuiltbase: ItemsEvidenceOutGuiltbase.fromJson(json['EvidenceOutGuiltbase']),
    );
  }
}