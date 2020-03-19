import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawGroupSubSectionRule.dart';

class ItemsMasLawGroupSubSection {
  final int SUBSECTION_ID;
  final int SECTION_ID;
  final String SUBSECTION_NO;
  final String SUBSECTION_NAME;
  final String SUBSECTION_DESC;
  final int IS_ACTIVE;
  List<ItemsMasLawGroupSubSectionRule> MasLawGroupSubSectionRule;

  ItemsMasLawGroupSubSection({
    this.SUBSECTION_ID,
    this.SECTION_ID,
    this.SUBSECTION_NO,
    this.SUBSECTION_NAME,
    this.SUBSECTION_DESC,
    this.IS_ACTIVE,
    this.MasLawGroupSubSectionRule,
  });

  factory ItemsMasLawGroupSubSection.fromJson(Map<String, dynamic> json) {
    return ItemsMasLawGroupSubSection(
      SUBSECTION_ID: json['SUBSECTION_ID'],
      SECTION_ID: json['SECTION_ID'],
      SUBSECTION_NO: json['SUBSECTION_NO'],
      SUBSECTION_NAME: json['SUBSECTION_NAME'],
      SUBSECTION_DESC: json['SUBSECTION_DESC'],
      IS_ACTIVE: json['IS_ACTIVE'],
      MasLawGroupSubSectionRule: List<ItemsMasLawGroupSubSectionRule>.from(json['masLawGroupSubSectionRule'].map((m) => ItemsMasLawGroupSubSectionRule.fromJson(m))),
    );
  }
}
