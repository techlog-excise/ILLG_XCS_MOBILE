import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

import 'evidence_out_group_subsection_rule.dart';

class ItemsEvidenceOutGuiltbase {
  final int GUILTBASE_ID;
  final int SUBSECTION_RULE_ID;
  final String GUILTBASE_NAME;
  final String FINE;
  final int IS_PROVE;
  final int IS_COMPARE;
  final String REMARK;
  final int IS_ACTIVE;
  final ItemsEvidenceOutGroupSubsectionRule EvidenceOutGroupSubsectionRule;

  ItemsEvidenceOutGuiltbase({
    this.GUILTBASE_ID,
    this.SUBSECTION_RULE_ID,
    this.GUILTBASE_NAME,
    this.FINE,
    this.IS_PROVE,
    this.IS_COMPARE,
    this.REMARK,
    this.IS_ACTIVE,
    this.EvidenceOutGroupSubsectionRule
  });

  factory ItemsEvidenceOutGuiltbase.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceOutGuiltbase(
      GUILTBASE_ID: json['GUILTBASE_ID'],
      SUBSECTION_RULE_ID: json['SUBSECTION_RULE_ID'],
      GUILTBASE_NAME: json['GUILTBASE_NAME'],
      FINE: json['FINE'],
      IS_PROVE: json['IS_PROVE'],
      IS_COMPARE: json['IS_COMPARE'],
      REMARK: json['REMARK'],
      IS_ACTIVE: json['IS_ACTIVE'],
      EvidenceOutGroupSubsectionRule: ItemsEvidenceOutGroupSubsectionRule.fromJson(json['EvidenceOutGroupSubsectionRule']),
    );
  }
}