import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/check_evidence/model/evidence_stock_balance.dart';

import 'check_evidence_detail_controller.dart';


class ItemsEvidenceInItem {
  int EVIDENCE_IN_ITEM_ID;
  String EVIDENCE_IN_ITEM_CODE;
  int EVIDENCE_IN_ID;

  int PRODUCT_MAPPING_ID;
  String PRODUCT_CODE;
  String PRODUCT_REF_CODE;
  int PRODUCT_GROUP_ID;
  int PRODUCT_CATEGORY_ID;
  int PRODUCT_TYPE_ID;
  int PRODUCT_SUBTYPE_ID;
  int PRODUCT_SUBSETTYPE_ID;
  int PRODUCT_BRAND_ID;
  int PRODUCT_SUBBRAND_ID;
  int PRODUCT_MODEL_ID;
  int PRODUCT_TAXDETAIL_ID;

  int PRODUCT_GROUP_CODE;
  String PRODUCT_GROUP_NAME;
  int PRODUCT_CATEGORY_CODE;
  String PRODUCT_CATEGORY_NAME;
  int PRODUCT_TYPE_CODE;
  String PRODUCT_TYPE_NAME;
  int PRODUCT_SUBTYPE_CODE;
  String PRODUCT_SUBTYPE_NAME;
  int PRODUCT_SUBSETTYPE_CODE;
  String PRODUCT_SUBSETTYPE_NAME;
  int PRODUCT_BRAND_CODE;
  String PRODUCT_BRAND_NAME_TH;
  String PRODUCT_BRAND_NAME_EN;
  int PRODUCT_SUBBRAND_CODE;
  String PRODUCT_SUBBRAND_NAME_TH;
  String PRODUCT_SUBBRAND_NAME_EN;
  int PRODUCT_MODEL_CODE;
  String PRODUCT_MODEL_NAME_TH;
  String PRODUCT_MODEL_NAME_EN;

  String LICENSE_PLATE;
  String ENGINE_NO;
  String CHASSIS_NO;
  String PRODUCT_DESC;
  dynamic SUGAR;
  dynamic CO2;
  dynamic DEGREE;
  double PRICE;
  double DELIVERY_QTY;
  String DELIVERY_QTY_UNIT;
  double DELIVERY_SIZE;
  String DELIVERY_SIZE_UNIT;
  double DELIVERY_NET_VOLUMN;
  String DELIVERY_NET_VOLUMN_UNIT;
  double DAMAGE_QTY;
  String DAMAGE_QTY_UNIT;
  double DAMAGE_SIZE;
  String DAMAGE_SIZE_UNIT;
  double DAMAGE_NET_VOLUMN;
  String DAMAGE_NET_VOLUMN_UNIT;
  int IS_DOMESTIC;int IS_ACTIVE;
  List<ItemsEvidenceStockBalance> EvidenceOutStockBalance;
  ItemsCheckEvidenceDetailController ItemsController;
  bool IsCkecked;

  ItemsEvidenceInItem({
    this.EVIDENCE_IN_ITEM_ID,
    this.EVIDENCE_IN_ITEM_CODE,
    this.EVIDENCE_IN_ID,
    this.PRODUCT_MAPPING_ID,
    this.PRODUCT_CODE,
    this.PRODUCT_REF_CODE,
    this.PRODUCT_GROUP_ID,
    this.PRODUCT_CATEGORY_ID,
    this.PRODUCT_TYPE_ID,
    this.PRODUCT_SUBTYPE_ID,
    this.PRODUCT_SUBSETTYPE_ID,
    this.PRODUCT_BRAND_ID,
    this.PRODUCT_SUBBRAND_ID,
    this.PRODUCT_MODEL_ID,
    this.PRODUCT_TAXDETAIL_ID,
    this.PRODUCT_GROUP_CODE,
    this.PRODUCT_GROUP_NAME,
    this.PRODUCT_CATEGORY_CODE,
    this.PRODUCT_CATEGORY_NAME,
    this.PRODUCT_TYPE_CODE,
    this.PRODUCT_TYPE_NAME,
    this.PRODUCT_SUBTYPE_CODE,
    this.PRODUCT_SUBTYPE_NAME,
    this.PRODUCT_SUBSETTYPE_CODE,
    this.PRODUCT_SUBSETTYPE_NAME,
    this.PRODUCT_BRAND_CODE,
    this.PRODUCT_BRAND_NAME_TH,
    this.PRODUCT_BRAND_NAME_EN,
    this.PRODUCT_SUBBRAND_CODE,
    this.PRODUCT_SUBBRAND_NAME_TH,
    this.PRODUCT_SUBBRAND_NAME_EN,
    this.PRODUCT_MODEL_CODE,
    this.PRODUCT_MODEL_NAME_TH,
    this.PRODUCT_MODEL_NAME_EN,
    this.LICENSE_PLATE,
    this.ENGINE_NO,
    this.CHASSIS_NO,
    this.PRODUCT_DESC,
    this.SUGAR,
    this.CO2,
    this.DEGREE,
    this.PRICE,
    this.DELIVERY_QTY,
    this.DELIVERY_QTY_UNIT,
    this.DELIVERY_SIZE,
    this.DELIVERY_SIZE_UNIT,
    this.DELIVERY_NET_VOLUMN,
    this.DELIVERY_NET_VOLUMN_UNIT,
    this.DAMAGE_QTY,
    this.DAMAGE_QTY_UNIT,
    this.DAMAGE_SIZE,
    this.DAMAGE_SIZE_UNIT,
    this.DAMAGE_NET_VOLUMN,
    this.DAMAGE_NET_VOLUMN_UNIT,
    this.IS_DOMESTIC,
    this.IS_ACTIVE,
    this.EvidenceOutStockBalance,
    this.ItemsController,
    this.IsCkecked
  });

  factory ItemsEvidenceInItem.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceInItem(
      EVIDENCE_IN_ITEM_ID: json['EVIDENCE_IN_ITEM_ID'],
      EVIDENCE_IN_ITEM_CODE: json['EVIDENCE_IN_ITEM_CODE'],
      EVIDENCE_IN_ID: json['EVIDENCE_IN_ID'],

      PRODUCT_MAPPING_ID: json['PRODUCT_MAPPING_ID'],
      PRODUCT_CODE: json['PRODUCT_CODE'],
      PRODUCT_REF_CODE: json['PRODUCT_REF_CODE'],
      PRODUCT_GROUP_ID: json['PRODUCT_GROUP_ID'],
      PRODUCT_CATEGORY_ID: json['PRODUCT_CATEGORY_ID'],
      PRODUCT_TYPE_ID: json['PRODUCT_TYPE_ID'],
      PRODUCT_SUBTYPE_ID: json['PRODUCT_SUBTYPE_ID'],
      PRODUCT_SUBSETTYPE_ID: json['PRODUCT_SUBSETTYPE_ID'],
      PRODUCT_BRAND_ID: json['PRODUCT_BRAND_ID'],
      PRODUCT_SUBBRAND_ID: json['PRODUCT_SUBBRAND_ID'],
      PRODUCT_MODEL_ID: json['PRODUCT_MODEL_ID'],
      PRODUCT_TAXDETAIL_ID: json['PRODUCT_TAXDETAIL_ID'],

      PRODUCT_GROUP_CODE: json['PRODUCT_GROUP_CODE'],
      PRODUCT_GROUP_NAME: json['PRODUCT_GROUP_NAME'],
      PRODUCT_CATEGORY_CODE: json['PRODUCT_CATEGORY_CODE'],
      PRODUCT_CATEGORY_NAME: json['PRODUCT_CATEGORY_NAME'],
      PRODUCT_TYPE_CODE: json['PRODUCT_TYPE_CODE'],
      PRODUCT_TYPE_NAME: json['PRODUCT_TYPE_NAME'],
      PRODUCT_SUBTYPE_CODE: json['PRODUCT_SUBTYPE_CODE'],
      PRODUCT_SUBTYPE_NAME: json['PRODUCT_SUBTYPE_NAME'],
      PRODUCT_SUBSETTYPE_CODE: json['PRODUCT_SUBSETTYPE_CODE'],
      PRODUCT_SUBSETTYPE_NAME: json['PRODUCT_SUBSETTYPE_NAME'],
      PRODUCT_BRAND_CODE: json['PRODUCT_BRAND_CODE'],
      PRODUCT_BRAND_NAME_TH: json['PRODUCT_BRAND_NAME_TH'],
      PRODUCT_BRAND_NAME_EN: json['PRODUCT_BRAND_NAME_EN'],
      PRODUCT_SUBBRAND_CODE: json['PRODUCT_SUBBRAND_CODE'],
      PRODUCT_SUBBRAND_NAME_TH: json['PRODUCT_SUBBRAND_NAME_TH'],
      PRODUCT_SUBBRAND_NAME_EN: json['PRODUCT_SUBBRAND_NAME_EN'],
      PRODUCT_MODEL_CODE: json['PRODUCT_MODEL_CODE'],
      PRODUCT_MODEL_NAME_TH: json['PRODUCT_MODEL_NAME_TH'],
      PRODUCT_MODEL_NAME_EN: json['PRODUCT_MODEL_NAME_EN'],

      LICENSE_PLATE: json['LICENSE_PLATE'],
      ENGINE_NO: json['ENGINE_NO'],
      CHASSIS_NO: json['CHASSIS_NO'],
      PRODUCT_DESC: json['PRODUCT_DESC'],
      SUGAR: json['SUGAR'],
      CO2: json['CO2'],
      DEGREE: json['DEGREE'],
      PRICE: json['PRICE'],

      DELIVERY_QTY: json['DELIVERY_QTY'],
      DELIVERY_QTY_UNIT: json['DELIVERY_QTY_UNIT'],
      DELIVERY_SIZE: json['DELIVERY_SIZE'],
      DELIVERY_SIZE_UNIT: json['DELIVERY_SIZE_UNIT'],
      DELIVERY_NET_VOLUMN: json['DELIVERY_NET_VOLUMN'],
      DELIVERY_NET_VOLUMN_UNIT: json['DELIVERY_NET_VOLUMN_UNIT'],
      DAMAGE_QTY: json['DAMAGE_QTY'],
      DAMAGE_QTY_UNIT: json['DAMAGE_QTY_UNIT'],
      DAMAGE_SIZE: json['DAMAGE_SIZE'],
      DAMAGE_SIZE_UNIT: json['DAMAGE_SIZE_UNIT'],
      DAMAGE_NET_VOLUMN: json['DAMAGE_NET_VOLUMN'],
      DAMAGE_NET_VOLUMN_UNIT: json['DAMAGE_NET_VOLUMN_UNIT'],
      IS_DOMESTIC: json['IS_DOMESTIC'],
      IS_ACTIVE: json['IS_ACTIVE'],
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
          null),
      EvidenceOutStockBalance: List<ItemsEvidenceStockBalance>.from(
          json['EvidenceOutStockBalance'].map((m) =>
              ItemsEvidenceStockBalance.fromJson(m))),

      IsCkecked: false
    );
  }
}