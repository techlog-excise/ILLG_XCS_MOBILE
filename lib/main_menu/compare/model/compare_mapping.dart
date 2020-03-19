import 'package:prototype_app_pang/main_menu/compare/model/compare_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_indicment_detail.dart';

class ItemsCompareMapping {
  final int COMPARE_MAPPING_ID;
  final int COMPARE_ID;
  final int INDICTMENT_DETAIL_ID;
  final int PAST_LAWSUIT_ID;
  final int IS_EVER_WRONG;
  final int IS_ACTIVE;
  final List<ItemsCompareDetail> CompareDetail;
  final List<ItemsCompareListIndicmentDetail> CompareArrestIndictmentDetail;

  ItemsCompareMapping({
    this.COMPARE_MAPPING_ID,
    this.COMPARE_ID,
    this.INDICTMENT_DETAIL_ID,
    this.PAST_LAWSUIT_ID,
    this.IS_EVER_WRONG,
    this.IS_ACTIVE,
    this.CompareDetail,
    this.CompareArrestIndictmentDetail,
  });

  factory ItemsCompareMapping.fromJson(Map<String, dynamic> json) {
    return ItemsCompareMapping(
      COMPARE_MAPPING_ID: json['COMPARE_MAPPING_ID'],
      COMPARE_ID: json['COMPARE_ID'],
      INDICTMENT_DETAIL_ID: json['INDICTMENT_DETAIL_ID'],
      PAST_LAWSUIT_ID: json['PAST_LAWSUIT_ID'],
      IS_EVER_WRONG: json['IS_EVER_WRONG'],
      IS_ACTIVE: json['IS_ACTIVE'],
      CompareDetail: List.from(json['CompareDetail'].map((m) => ItemsCompareDetail.fromJson(m))),
      CompareArrestIndictmentDetail: List.from(json['CompareArrestIndictmentDetail'].map((m) => ItemsCompareListIndicmentDetail.fromJson(m))),
    );
  }
}