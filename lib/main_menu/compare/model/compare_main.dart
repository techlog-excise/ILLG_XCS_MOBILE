import 'package:prototype_app_pang/main_menu/compare/model/compare_staff.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_detail.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_detail_fine.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_detail_payment.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_mapping.dart';

class ItemsCompareMain {
  final int COMPARE_ID;
  final int LAWSUIT_ID;
  final int OFFICE_ID;
  final double TREASURY_RATE;
  final double BRIBE_RATE;
  final double REWARD_RATE;
  final String OFFICE_CODE;
  final String OFFICE_NAME;
  final int COMPARE_NO;
  final String COMPARE_NO_YEAR;
  final String COMPARE_DATE;
  final String CREATE_DATE;
  final int CREATE_USER_ACCOUNT_ID;
  final int IS_OUTSIDE;
  final int IS_ACTIVE;
  final int IS_BRIBE;
  final int IS_AWARD;
  final List<ItemsCompareMapping> CompareMapping;
  final List<ItemsListCompareStaff> CompareStaff;

  ItemsCompareMain({
    this.COMPARE_ID,
    this.LAWSUIT_ID,
    this.OFFICE_ID,
    this.TREASURY_RATE,
    this.BRIBE_RATE,
    this.REWARD_RATE,
    this.OFFICE_CODE,
    this.OFFICE_NAME,
    this.COMPARE_NO,
    this.COMPARE_NO_YEAR,
    this.COMPARE_DATE,
    this.CREATE_DATE,
    this.CREATE_USER_ACCOUNT_ID,
    this.IS_OUTSIDE,
    this.IS_ACTIVE,
    this.IS_AWARD,
    this.IS_BRIBE,
    this.CompareMapping,
    this.CompareStaff,
  });

  factory ItemsCompareMain.fromJson(Map<String, dynamic> json) {
    return ItemsCompareMain(
      COMPARE_ID: json['COMPARE_ID'],
      LAWSUIT_ID: json['LAWSUIT_ID'],
      OFFICE_ID: json['OFFICE_ID'],
      TREASURY_RATE: json['TREASURY_RATE'],
      BRIBE_RATE: json['BRIBE_RATE'],
      REWARD_RATE: json['REWARD_RATE'],
      OFFICE_CODE: json['OFFICE_CODE'],
      OFFICE_NAME: json['OFFICE_NAME'],
      COMPARE_NO: json['COMPARE_NO'],
      COMPARE_NO_YEAR: json['COMPARE_NO_YEAR'],
      COMPARE_DATE: json['COMPARE_DATE'],
      CREATE_DATE: json['CREATE_DATE'],
      CREATE_USER_ACCOUNT_ID: json['CREATE_USER_ACCOUNT_ID'],
      IS_OUTSIDE: json['IS_OUTSIDE'],
      IS_ACTIVE: json['IS_ACTIVE'],
      IS_BRIBE: json['IS_BRIBE'],
      IS_AWARD: json['IS_AWARD'],
      CompareMapping: List.from(json['CompareMapping'].map((m) => ItemsCompareMapping.fromJson(m))),
      CompareStaff: List.from(json['CompareStaff'].map((m) => ItemsListCompareStaff.fromJson(m))),
    );
  }
}
