import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

class ItemsEvidenceOutGroupSubsection {
  final int SUBSECTION_ID;
  final int SECTION_ID;
  final String SUBSECTION_NO;
  final String SUBSECTION_NAME;
  final String SUBSECTION_DESC;
  final int IS_ACTIVE;

  ItemsEvidenceOutGroupSubsection({
    this.SUBSECTION_ID,
    this.SECTION_ID,
    this.SUBSECTION_NO,
    this.SUBSECTION_NAME,
    this.SUBSECTION_DESC,
    this.IS_ACTIVE,
  });

  factory ItemsEvidenceOutGroupSubsection.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceOutGroupSubsection(
      SUBSECTION_ID: json['SUBSECTION_ID'],
      SECTION_ID: json['SECTION_ID'],
      SUBSECTION_NO: json['SUBSECTION_NO'],
      SUBSECTION_NAME: json['SUBSECTION_NAME'],
      SUBSECTION_DESC: json['SUBSECTION_DESC'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}