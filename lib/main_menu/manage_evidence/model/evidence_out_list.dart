import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';
import 'package:prototype_app_pang/main_menu/manage_evidence/model/evidence_out_staff.dart';

import 'evidence_out_staff.dart';

class ItemsEvidenceOutList {
  final int EVIDENCE_OUT_ID;
  final String EVIDENCE_OUT_CODE;
  final int EVIDENCE_OUT_TYPE;
  final String EVIDENCE_OUT_DATE;
  final String EVIDENCE_OUT_NO;
  final String EVIDENCE_OUT_NO_DATE;
  final int WAREHOUSE_ID;
  final List<ItemsEvidenceOutStaff> EvidenceOutStaff;

  ItemsEvidenceOutList({
    this.EVIDENCE_OUT_ID,
    this.EVIDENCE_OUT_CODE,
    this.EVIDENCE_OUT_TYPE,
    this.EVIDENCE_OUT_DATE,
    this.EVIDENCE_OUT_NO,
    this.EVIDENCE_OUT_NO_DATE,
    this.WAREHOUSE_ID,
    this.EvidenceOutStaff,
  });

  factory ItemsEvidenceOutList.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceOutList(
      EVIDENCE_OUT_ID: json['EVIDENCE_OUT_ID'],
      EVIDENCE_OUT_CODE: json['EVIDENCE_OUT_CODE'],
      EVIDENCE_OUT_TYPE: json['EVIDENCE_OUT_TYPE'],
      EVIDENCE_OUT_DATE: json['EVIDENCE_OUT_DATE'],
      EVIDENCE_OUT_NO: json['EVIDENCE_OUT_NO'],
      EVIDENCE_OUT_NO_DATE: json['EVIDENCE_OUT_NO_DATE'],
      WAREHOUSE_ID: json['WAREHOUSE_ID'],
      EvidenceOutStaff: List<ItemsEvidenceOutStaff>.from(
          json['EvidenceOutStaff'].map((m) =>
              ItemsEvidenceOutStaff.fromJson(m))),
    );
  }
}