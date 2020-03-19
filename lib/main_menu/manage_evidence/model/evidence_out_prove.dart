import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

import 'evidence_out_lawsuit.dart';

class ItemsEvidenceOutProve {
  final int PROVE_ID;
  final int LAWSUIT_ID;
  final int DELIVERY_OFFICE_ID;
  final int RECEIVE_OFFICE_ID;
  final int PROVE_TYPE;
  final String DELIVERY_DOC_NO_1;
  final String DELIVERY_DOC_NO_2;
  final String DELIVERY_DOC_DATE;
  final String DELIVERY_OFFICE_CODE;
  final String DELIVERY_OFFICE_NAME;
  final String RECEIVE_OFFICE_CODE;
  final String RECEIVE_OFFICE_NAME;
  final String PROVE_NO;
  final String PROVE_NO_YEAR;
  final String RECEIVE_DOC_DATE;
  final String COMMAND;
  final String LAWSUIT_NO;
  final String LAWSUIT_NO_YEAR;
  final String OCCURRENCE_DATE;
  final String OUT_OFFICE_NAME;
  final int IS_OUTSIDE;
  final int IS_SCIENCE;
  final int IS_RECEIVE;
  final int IS_ACTIVE;
  final String PROVE_DATE;
  final String DELIVERY_PROVE_DOC_NO_1;
  final String DELIVERY_PROVE_DOC_NO_2;
  ItemsEvidenceOutLawsuit EvidenceOutLawsuit;

  ItemsEvidenceOutProve({
    this.PROVE_ID,
    this.LAWSUIT_ID,
    this.DELIVERY_OFFICE_ID,
    this.RECEIVE_OFFICE_ID,
    this.PROVE_TYPE,
    this.DELIVERY_DOC_NO_1,
    this.DELIVERY_DOC_NO_2,
    this.DELIVERY_DOC_DATE,
    this.DELIVERY_OFFICE_CODE,
    this.DELIVERY_OFFICE_NAME,
    this.RECEIVE_OFFICE_CODE,
    this.RECEIVE_OFFICE_NAME,
    this.PROVE_NO,
    this.PROVE_NO_YEAR,
    this.RECEIVE_DOC_DATE,
    this.COMMAND,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.OCCURRENCE_DATE,
    this.OUT_OFFICE_NAME,
    this.IS_OUTSIDE,
    this.IS_SCIENCE,
    this.IS_RECEIVE,
    this.IS_ACTIVE,
    this.PROVE_DATE,
    this.DELIVERY_PROVE_DOC_NO_1,
    this.DELIVERY_PROVE_DOC_NO_2,
    this.EvidenceOutLawsuit,
  });

  factory ItemsEvidenceOutProve.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceOutProve(
      PROVE_ID: json['PROVE_ID'],
      LAWSUIT_ID: json['LAWSUIT_ID'],
      DELIVERY_OFFICE_ID: json['DELIVERY_OFFICE_ID'],
      RECEIVE_OFFICE_ID: json['RECEIVE_OFFICE_ID'],
      DELIVERY_DOC_NO_1: json['DELIVERY_DOC_NO_1'],
      DELIVERY_DOC_NO_2: json['DELIVERY_DOC_NO_2'],
      DELIVERY_DOC_DATE: json['DELIVERY_DOC_DATE'],
      DELIVERY_OFFICE_CODE: json['DELIVERY_OFFICE_CODE'],
      DELIVERY_OFFICE_NAME: json['DELIVERY_OFFICE_NAME'],
      RECEIVE_OFFICE_CODE: json['RECEIVE_OFFICE_CODE'],
      RECEIVE_OFFICE_NAME: json['RECEIVE_OFFICE_NAME'],
      PROVE_NO: json['PROVE_NO'],
      PROVE_NO_YEAR: json['PROVE_NO_YEAR'],
      RECEIVE_DOC_DATE: json['RECEIVE_DOC_DATE'],
      COMMAND: json['COMMAND'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],
      OCCURRENCE_DATE: json['OCCURRENCE_DATE'],
      OUT_OFFICE_NAME: json['OUT_OFFICE_NAME'],
      IS_OUTSIDE: json['IS_OUTSIDE'],
      IS_SCIENCE: json['IS_SCIENCE'], IS_RECEIVE: json['IS_RECEIVE'],
      IS_ACTIVE: json['IS_ACTIVE'],
      PROVE_DATE: json['PROVE_DATE'],
      DELIVERY_PROVE_DOC_NO_1: json['DELIVERY_PROVE_DOC_NO_1'],
      DELIVERY_PROVE_DOC_NO_2: json['DELIVERY_PROVE_DOC_NO_2'],
      EvidenceOutLawsuit: ItemsEvidenceOutLawsuit.fromJson(json['EvidenceOutLawsuit']),
    );
  }
}