import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

import 'evidence_out_group_subsection.dart';

class ItemsEvidenceOutGroupSubsectionRule {
  final int SUBSECTION_RULE_ID;
  final int SUBSECTION_ID;
  final int SECTION_ID;
  final int FINE_TYPE;
  final int IS_ACTIVE;
  final ItemsEvidenceOutGroupSubsection EvidenceOutGroupSubsection;

  ItemsEvidenceOutGroupSubsectionRule({
    this.SUBSECTION_RULE_ID,
    this.SUBSECTION_ID,
    this.SECTION_ID,
    this.FINE_TYPE,
    this.IS_ACTIVE,
    this.EvidenceOutGroupSubsection,
  });

  factory ItemsEvidenceOutGroupSubsectionRule.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceOutGroupSubsectionRule(
      SUBSECTION_RULE_ID: json['SUBSECTION_RULE_ID'],
      SUBSECTION_ID: json['SUBSECTION_ID'],
      SECTION_ID: json['SECTION_ID'],
      FINE_TYPE: json['FINE_TYPE'],
      IS_ACTIVE: json['IS_ACTIVE'],
      EvidenceOutGroupSubsection: ItemsEvidenceOutGroupSubsection.fromJson(json['EvidenceOutGroupSubsection']),
    );
  }
}