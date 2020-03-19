import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/check_evidence_detail_controller.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

class EvidenceInventoryList {
  /*final int LAWSUIT_ID;
  final String EVIDENCE_IN_ITEM_CODE;
  final String PRODUCT_DESC;
  final double BALANCE_QTY;
  final String BALANCE_QTY_UNIT;
  final String EVIDENCE_IN_TYPE;
  final int EVIDENCE_IN_ID;
  final String OPERATION_OFFICE_CODE;
  final String OPERATION_OFFICE_NAME;
  final String DELIVERY_NO;
  final String TITLE_NAME_TH;
  final String FIRST_NAME;
  final String LAST_NAME;
  final String OPREATION_POS_NAME;
  final int CONTRIBUTOR_ID;
  final int STOCK_ID;*/

  int LAWSUIT_ID;
  String EVIDENCE_IN_ITEM_CODE;
  String PRODUCT_DESC;

  double DELIVERY_QTY;
  double DAMAGE_QTY;

  double BALANCE_QTY;
  String BALANCE_QTY_UNIT;
  String EVIDENCE_IN_TYPE;
  int EVIDENCE_IN_ID;
  String OPERATION_OFFICE_CODE;
  String OPERATION_OFFICE_NAME;
  String DELIVERY_NO;
  String TITLE_NAME_TH;
  String FIRST_NAME;
  String LAST_NAME;
  String OPREATION_POS_NAME;
  int CONTRIBUTOR_ID;
  int STOCK_ID;

  String LAWSUIT_NO;
  String LAWSUIT_NO_YEAR;
  int IS_OUTSIDE;
  // String LAWSUIT_DATE_START;
  // String LAWSUIT_DATE_END;

  ItemsCheckEvidenceDetailController ItemsController;
  bool IsCkecked;

  EvidenceInventoryList({
    this.LAWSUIT_ID,
    this.EVIDENCE_IN_ITEM_CODE,
    this.PRODUCT_DESC,
    this.DELIVERY_QTY,
    this.DAMAGE_QTY,
    this.BALANCE_QTY,
    this.BALANCE_QTY_UNIT,
    this.EVIDENCE_IN_TYPE,
    this.EVIDENCE_IN_ID,
    this.OPERATION_OFFICE_CODE,
    this.OPERATION_OFFICE_NAME,
    this.DELIVERY_NO,
    this.TITLE_NAME_TH,
    this.FIRST_NAME,
    this.LAST_NAME,
    this.OPREATION_POS_NAME,
    this.CONTRIBUTOR_ID,
    this.STOCK_ID,
    this.ItemsController,
    this.IsCkecked,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.IS_OUTSIDE,
    // this.LAWSUIT_DATE_START,
    // this.LAWSUIT_DATE_END,
  });

  factory EvidenceInventoryList.fromJson(Map<String, dynamic> json) {
    return EvidenceInventoryList(
        LAWSUIT_ID: json['LAWSUIT_ID'],
        EVIDENCE_IN_ITEM_CODE: json['EVIDENCE_IN_ITEM_CODE'],
        PRODUCT_DESC: json['PRODUCT_DESC'],
        DELIVERY_QTY: 0,
        DAMAGE_QTY: 0,
        BALANCE_QTY: json['BALANCE_QTY'],
        BALANCE_QTY_UNIT: json['BALANCE_QTY_UNIT'],
        EVIDENCE_IN_TYPE: json['EVIDENCE_IN_TYPE'],
        EVIDENCE_IN_ID: json['EVIDENCE_IN_ID'],
        OPERATION_OFFICE_CODE: json['OPERATION_OFFICE_CODE'],
        OPERATION_OFFICE_NAME: json['OPERATION_OFFICE_NAME'],
        DELIVERY_NO: json['DELIVERY_NO'],
        TITLE_NAME_TH: json['TITLE_NAME_TH'],
        FIRST_NAME: json['FIRST_NAME'],
        LAST_NAME: json['LAST_NAME'],
        OPREATION_POS_NAME: json['OPREATION_POS_NAME'],
        CONTRIBUTOR_ID: json['CONTRIBUTOR_ID'],
        STOCK_ID: json['STOCK_ID'],
        ItemsController: new ItemsCheckEvidenceDetailController(
          new ExpandableController(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          null,
          null,
          null,
          null,
        ),
        IsCkecked: false);
  }
}
