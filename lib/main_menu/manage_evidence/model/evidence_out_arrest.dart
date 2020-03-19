import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

class ItemsEvidenceOutArrest {
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

  ItemsEvidenceOutArrest({
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
  });

  factory ItemsEvidenceOutArrest.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceOutArrest(
      ARREST_ID: json['INDICTMENT_ID'],
      OFFICE_ID: json['INDICTMENT_ID'],
      ARREST_CODE: json['INDICTMENT_ID'],
      OFFICE_CODE: json['INDICTMENT_ID'],
      OFFICE_NAME: json['INDICTMENT_ID'],
      ARREST_DATE: json['INDICTMENT_ID'],
      OCCURRENCE_DATE: json['INDICTMENT_ID'],
      BEHAVIOR_1: json['INDICTMENT_ID'],
      BEHAVIOR_2: json['INDICTMENT_ID'],
      BEHAVIOR_3: json['INDICTMENT_ID'],
      BEHAVIOR_4: json['INDICTMENT_ID'],
      BEHAVIOR_5: json['INDICTMENT_ID'],
      TESTIMONY: json['INDICTMENT_ID'],
      IS_REQUEST: json['INDICTMENT_ID'],
      REQUEST_DESC: json['INDICTMENT_ID'],
      IS_LAWSUIT_COMPLETE: json['INDICTMENT_ID'],
    );
  }
}