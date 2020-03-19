import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawGuiltbase.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawGuiltbaseFine.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawPenalty.dart';

class ItemsMasLawGroupSubSectionRule {
  final int SUBSECTION_RULE_ID;
  final int SUBSECTION_ID;
  final int SECTION_ID;
  final int FINE_TYPE;
  final int IS_ACTIVE;
  List<ItemsMasLawGuiltbase> MasLawLawGuiltbase;
  List<ItemsMasLawPenalty> MasLawPenalty;
  List<ItemsMasLawGuiltbaseFine> MasLawGuiltbaseFine;

  ItemsMasLawGroupSubSectionRule({
    this.SUBSECTION_RULE_ID,
    this.SUBSECTION_ID,
    this.SECTION_ID,
    this.FINE_TYPE,
    this.IS_ACTIVE,
    this.MasLawLawGuiltbase,
    this.MasLawPenalty,
    this.MasLawGuiltbaseFine,
  });

  factory ItemsMasLawGroupSubSectionRule.fromJson(Map<String, dynamic> json) {
    return ItemsMasLawGroupSubSectionRule(
      SUBSECTION_RULE_ID: json['SUBSECTION_RULE_ID'],
      SUBSECTION_ID: json['SUBSECTION_ID'],
      SECTION_ID: json['SECTION_ID'],
      FINE_TYPE: json['FINE_TYPE'],
      IS_ACTIVE: json['IS_ACTIVE'],
      MasLawLawGuiltbase: List<ItemsMasLawGuiltbase>.from(json['masLawGuiltbase'].map((m) => ItemsMasLawGuiltbase.fromJson(m))),
      MasLawPenalty: List<ItemsMasLawPenalty>.from(json['masLawPenalty'].map((m) => ItemsMasLawPenalty.fromJson(m))),
      MasLawGuiltbaseFine: List<ItemsMasLawGuiltbaseFine>.from(json['masLawGuiltbaseFine'].map((m) => ItemsMasLawGuiltbaseFine.fromJson(m))),
    );
  }
}
