import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawGroupSubSection.dart';

class ItemsFindLawResponse {
  final int SECTION_ID;
  final int LAW_GROUP_ID;
  final String SECTION_NAME;
  final String SECTION_DESC_1;
  final String SECTION_DESC_2;
  final String SECTION_DESC_3;
  final int IS_ACTIVE;
  final String EFFECTIVE_DATE;
  final String EXPIRE_DATE;
  List<ItemsMasLawGroupSubSection> MasLawGroupSubSection;

  ItemsFindLawResponse({
    this.SECTION_ID,
    this.LAW_GROUP_ID,
    this.SECTION_NAME,
    this.SECTION_DESC_1,
    this.SECTION_DESC_2,
    this.SECTION_DESC_3,
    this.IS_ACTIVE,
    this.EFFECTIVE_DATE,
    this.EXPIRE_DATE,
    this.MasLawGroupSubSection,
  });

  factory ItemsFindLawResponse.fromJson(Map<String, dynamic> json) {
    return ItemsFindLawResponse(
      SECTION_ID: json['SECTION_ID'],
      LAW_GROUP_ID: json['LAW_GROUP_ID'],
      SECTION_NAME: json['SECTION_NAME'],
      SECTION_DESC_1: json['SECTION_DESC_1'],
      SECTION_DESC_2: json['SECTION_DESC_2'],
      SECTION_DESC_3: json['SECTION_DESC_3'],
      IS_ACTIVE: json['IS_ACTIVE'],
      EFFECTIVE_DATE: json['EFFECTIVE_DATE'],
      EXPIRE_DATE: json['EXPIRE_DATE'],
      MasLawGroupSubSection: List<ItemsMasLawGroupSubSection>.from(json['masLawGroupSubSection'].map((m) => ItemsMasLawGroupSubSection.fromJson(m))),
    );
  }
}
