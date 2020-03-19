import 'package:prototype_app_pang/main_menu/compare/model/compare_detail_fine.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_detail_payment.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_payment.dart';

class ItemsCompareDetail {
  final int COMPARE_DETAIL_ID;
  final int COMPARE_MAPPING_ID;
  final int RECEIPT_OFFICE_ID;
  final int APPROVE_OFFICE_ID;
  final int MISTREAT_NO;
  final double OLD_PAYMENT_FINE;
  final double PAYMENT_FINE;
  final double DIFFERENCE_PAYMENT_FINE;
  final double TREASURY_MONEY;
  final double BRIBE_MONEY;
  final double REWARD_MONEY;
  final String PAYMENT_FINE_DUE_DATE;
  final String PAYMENT_VAT_DUE_DATE;
  final String INSURANCE;
  final String GAURANTEE;
  final String PAYMENT_DATE;
  final int RECEIPT_TYPE;
  final int RECEIPT_BOOK_NO;
  final int RECEIPT_NO;
  final String RECEIPT_OFFICE_CODE;
  final String RECEIPT_OFFICE_NAME;
  final String APPROVE_OFFICE_CODE;
  final String APPROVE_OFFICE_NAME;
  final String APPROVE_DATE;
  final int APPROVE_TYPE;
  final String COMMAND_NO;
  final String COMMAND_DATE;
  final String REMARK_NOT_AGREE;
  final String REMARK_NOT_APPROVE;
  final String FACT;
  final String COMPARE_REASON;
  final String ADJUST_REASON;
  final int COMPARE_TYPE;
  final int IS_REQUEST;
  final int IS_TEMP_RELEASE;
  final int IS_INSURANCE;
  final int IS_GAURANTEE;
  final int IS_PAYMENT;
  final int IS_REVENUE;
  final int AGREE;
  final int APPROVE;
  final int AUTHORITY;
  final int ACTIVE;

  final List<ItemsCompareDetailPayment> CompareDetailPayment;
  final List<ItemsCompareDetailFine> CompareDetailFine;
  final List<ItemsComparePayment> ComparePayment;

  ItemsCompareDetail({
    this.COMPARE_DETAIL_ID,
    this.COMPARE_MAPPING_ID,
    this.RECEIPT_OFFICE_ID,
    this.APPROVE_OFFICE_ID,
    this.MISTREAT_NO,
    this.OLD_PAYMENT_FINE,
    this.PAYMENT_FINE,
    this.DIFFERENCE_PAYMENT_FINE,
    this.TREASURY_MONEY,
    this.BRIBE_MONEY,
    this.REWARD_MONEY,
    this.PAYMENT_FINE_DUE_DATE,
    this.PAYMENT_VAT_DUE_DATE,
    this.INSURANCE,
    this.GAURANTEE,
    this.PAYMENT_DATE,
    this.RECEIPT_TYPE,
    this.RECEIPT_BOOK_NO,
    this.RECEIPT_NO,
    this.RECEIPT_OFFICE_CODE,
    this.RECEIPT_OFFICE_NAME,
    this.APPROVE_OFFICE_CODE,
    this.APPROVE_OFFICE_NAME,
    this.APPROVE_DATE,
    this.APPROVE_TYPE,
    this.COMMAND_NO,
    this.COMMAND_DATE,
    this.REMARK_NOT_AGREE,
    this.REMARK_NOT_APPROVE,
    this.FACT,
    this.COMPARE_REASON,
    this.ADJUST_REASON,
    this.COMPARE_TYPE,
    this.IS_REQUEST,
    this.IS_TEMP_RELEASE,
    this.IS_INSURANCE,
    this.IS_GAURANTEE,
    this.IS_PAYMENT,
    this.IS_REVENUE,
    this.AGREE,
    this.APPROVE,
    this.AUTHORITY,
    this.ACTIVE,
    this.CompareDetailPayment,
    this.CompareDetailFine,
    this.ComparePayment,
  });

  factory ItemsCompareDetail.fromJson(Map<String, dynamic> json) {
    return ItemsCompareDetail(
      COMPARE_DETAIL_ID: json['COMPARE_DETAIL_ID'],
      COMPARE_MAPPING_ID: json['COMPARE_MAPPING_ID'],
      RECEIPT_OFFICE_ID: json['RECEIPT_OFFICE_ID'],
      APPROVE_OFFICE_ID: json['APPROVE_OFFICE_ID'],
      MISTREAT_NO: json['MISTREAT_NO'],
      OLD_PAYMENT_FINE: json['OLD_PAYMENT_FINE'],
      PAYMENT_FINE: json['PAYMENT_FINE'],
      DIFFERENCE_PAYMENT_FINE: json['DIFFERENCE_PAYMENT_FINE'],
      TREASURY_MONEY: json['TREASURY_MONEY'],
      BRIBE_MONEY: json['BRIBE_MONEY'],
      REWARD_MONEY: json['REWARD_MONEY'],
      PAYMENT_FINE_DUE_DATE: json['PAYMENT_FINE_DUE_DATE'],
      PAYMENT_VAT_DUE_DATE: json['PAYMENT_VAT_DUE_DATE'],
      INSURANCE: json['INSURANCE'],
      GAURANTEE: json['GAURANTEE'],
      PAYMENT_DATE: json['PAYMENT_DATE'],
      RECEIPT_TYPE: json['RECEIPT_TYPE'],
      RECEIPT_BOOK_NO: json['RECEIPT_BOOK_NO'],
      RECEIPT_NO: json['RECEIPT_NO'],
      RECEIPT_OFFICE_CODE: json['RECEIPT_OFFICE_CODE'],
      RECEIPT_OFFICE_NAME: json['RECEIPT_OFFICE_NAME'],
      APPROVE_OFFICE_CODE: json['APPROVE_OFFICE_CODE'],
      APPROVE_OFFICE_NAME: json['APPROVE_OFFICE_NAME'],
      APPROVE_DATE: json['APPROVE_DATE'],
      APPROVE_TYPE: json['APPROVE_TYPE'],
      COMMAND_NO: json['COMMAND_NO'],
      COMMAND_DATE: json['COMMAND_DATE'],
      REMARK_NOT_AGREE: json['REMARK_NOT_AGREE'],
      REMARK_NOT_APPROVE: json['REMARK_NOT_APPROVE'],
      FACT: json['FACT'],
      COMPARE_REASON: json['COMPARE_REASON'],
      ADJUST_REASON: json['ADJUST_REASON'],
      COMPARE_TYPE: json['COMPARE_TYPE'],
      IS_REQUEST: json['IS_REQUEST'],
      IS_TEMP_RELEASE: json['IS_TEMP_RELEASE'],
      IS_INSURANCE: json['IS_INSURANCE'],
      IS_GAURANTEE: json['IS_GAURANTEE'],
      IS_PAYMENT: json['IS_PAYMENT'],
      IS_REVENUE: json['IS_REVENUE'],
      AGREE: json['AGREE'],
      APPROVE: json['APPROVE'],
      AUTHORITY: json['AUTHORITY'],
      ACTIVE: json['ACTIVE'],
      CompareDetailPayment: List.from(json['CompareDetailPayment'].map((m) => ItemsCompareDetailPayment.fromJson(m))),
      CompareDetailFine: List.from(json['CompareDetailFine'].map((m) => ItemsCompareDetailFine.fromJson(m))),
      ComparePayment: List.from(json['ComparePayment'].map((m) => ItemsComparePayment.fromJson(m))),
    );
  }
}