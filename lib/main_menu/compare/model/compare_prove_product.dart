import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/compare/model/compare_evidence_controller.dart';

class ItemsCompareListProveProduct {
  int PRODUCT_ID;
  int PROVE_ID;
  int SCIENCE_ID;
  int PRODUCT_MAPPING_ID;
  int PRODUCT_INDICTMENT_ID;
  String PRODUCT_GROUP_NAME;
  String PRODUCT_CATEGORY_NAME;
  String PRODUCT_TYPE_NAME;
  String PRODUCT_SUBTYPE_NAME;
  String PRODUCT_BRAND_NAME_TH;
  String PRODUCT_BRAND_NAME_EN;
  String PRODUCT_SUBBRAND_CODE;
  String PRODUCT_SUBBRAND_NAME_TH;
  String PRODUCT_SUBBRAND_NAME_EN;
  String PRODUCT_MODEL_NAME_TH;
  String PRODUCT_MODEL_NAME_EN;
  double FINE_ESTIMATE;
  int SIZES_UNIT_ID;
  int QUATITY_UNIT_ID;
  int VOLUMN_UNIT_ID;
  double SIZES;
  double QUANTITY;
  double VOLUMN;
  String SIZES_UNIT;
  String QUANTITY_UNIT;
  String VOLUMN_UNIT;


  int IS_TAX_VALUE;
  double TAX_VALUE;
  int IS_TAX_VOLUMN;
  double TAX_VOLUMN;
  String TAX_VOLUMN_UNIT;
  String LICENSE_PLATE;
  String ENGINE_NO;
  String CHASSIS_NO;
  String PRODUCT_DESC;
  double SUGAR;
  double CO2;
  double DEGREE;
  double PRICE;
  double REMAIN_SIZES;
  String REMAIN_SIZES_UNIT;
  double REMAIN_QUANTITY;
  String REMAIN_QUANTITY_UNIT;
  double REMAIN_VOLUMN;
  String REMAIN_VOLUMN_UNIT;
  String REMARK;
  String REMAIN_REMARK;
  String PRODUCT_RESULT;
  String SCIENCE_RESULT_DESC;
  double VAT;
  int IS_DOMESTIC;
  int IS_ILLEGAL;
  int IS_SCIENCE;

   String PRODUCT_CODE;
  int PRODUCT_GROUP_ID;
  String PRODUCT_GROUP_CODE;
  int PRODUCT_CATEGORY_ID;
  String PRODUCT_CATEGORY_CODE;

  bool IsCkecked;
  ItemsCompareEvidenceTaxValue Controller;

  ItemsCompareListProveProduct({
    this.PRODUCT_ID,
    this.PROVE_ID,
    this.SCIENCE_ID,
    this.PRODUCT_MAPPING_ID,
    this.PRODUCT_INDICTMENT_ID,
    this.PRODUCT_GROUP_NAME,
    this.PRODUCT_CATEGORY_NAME,
    this.PRODUCT_TYPE_NAME,
    this.PRODUCT_SUBTYPE_NAME,
    this.PRODUCT_BRAND_NAME_TH,
    this.PRODUCT_BRAND_NAME_EN,
    this.PRODUCT_SUBBRAND_CODE,
    this.PRODUCT_SUBBRAND_NAME_TH,
    this.PRODUCT_SUBBRAND_NAME_EN,
    this.PRODUCT_MODEL_NAME_TH,
    this.PRODUCT_MODEL_NAME_EN,
    this.FINE_ESTIMATE,
    this.SIZES_UNIT_ID,
    this.QUATITY_UNIT_ID,
    this.VOLUMN_UNIT_ID,
    this.SIZES,
    this.QUANTITY,
    this.VOLUMN,
    this.SIZES_UNIT,
    this.QUANTITY_UNIT,
    this.VOLUMN_UNIT,
    this.IS_TAX_VALUE,
    this.TAX_VALUE,
    this.IS_TAX_VOLUMN,
    this.TAX_VOLUMN,
    this.TAX_VOLUMN_UNIT,
    this.LICENSE_PLATE,
    this.ENGINE_NO,
    this.CHASSIS_NO,
    this.PRODUCT_DESC,
    this.SUGAR,
    this.CO2,
    this.DEGREE,
    this.PRICE,
    this.REMAIN_SIZES,
    this.REMAIN_SIZES_UNIT,
    this.REMAIN_QUANTITY,
    this.REMAIN_QUANTITY_UNIT,
    this.REMAIN_VOLUMN,
    this.REMAIN_VOLUMN_UNIT,
    this.REMARK,
    this.REMAIN_REMARK,
    this.PRODUCT_RESULT,
    this.SCIENCE_RESULT_DESC,
    this.VAT,
    this.IS_DOMESTIC,
    this.IS_ILLEGAL,
    this.IS_SCIENCE,
    this.IsCkecked,
    this.Controller,
    this.PRODUCT_CODE,
  this.PRODUCT_GROUP_ID,
  this.PRODUCT_GROUP_CODE,
  this.PRODUCT_CATEGORY_ID,
  this.PRODUCT_CATEGORY_CODE,
  });

  factory ItemsCompareListProveProduct.fromJson(Map<String, dynamic> js) {
    return ItemsCompareListProveProduct(
      PRODUCT_ID: js['PRODUCT_ID'],
      PROVE_ID: js['PROVE_ID'],
      SCIENCE_ID: js['SCIENCE_ID'],
      PRODUCT_MAPPING_ID: js['PRODUCT_MAPPING_ID'],
      PRODUCT_INDICTMENT_ID: js['PRODUCT_INDICTMENT_ID'],
      PRODUCT_CATEGORY_NAME: js['PRODUCT_CATEGORY_NAME'],
      PRODUCT_GROUP_NAME: js['PRODUCT_GROUP_NAME'],
      PRODUCT_TYPE_NAME: js['PRODUCT_TYPE_NAME'],
      PRODUCT_SUBTYPE_NAME: js['PRODUCT_SUBTYPE_NAME'],
      PRODUCT_BRAND_NAME_TH: js['PRODUCT_BRAND_NAME_TH'],
      PRODUCT_BRAND_NAME_EN: js['PRODUCT_BRAND_NAME_EN'],
      PRODUCT_SUBBRAND_CODE: js['PRODUCT_SUBBRAND_CODE'],
      PRODUCT_SUBBRAND_NAME_TH: js['PRODUCT_SUBBRAND_NAME_TH'],
      PRODUCT_SUBBRAND_NAME_EN: js['PRODUCT_SUBBRAND_NAME_EN'],
      PRODUCT_MODEL_NAME_TH: js['PRODUCT_MODEL_NAME_TH'],
      PRODUCT_MODEL_NAME_EN: js['PRODUCT_MODEL_NAME_EN'],
      FINE_ESTIMATE: js['FINE_ESTIMATE'],
      SIZES_UNIT_ID: js['SIZES_UNIT_ID'],
      QUATITY_UNIT_ID: js['QUATITY_UNIT_ID'],
      VOLUMN_UNIT_ID: js['VOLUMN_UNIT_ID'],
      SIZES: js['SIZES'],
      QUANTITY: js['QUANTITY'],
      VOLUMN: js['VOLUMN'],
      SIZES_UNIT: js['SIZES_UNIT'],
      QUANTITY_UNIT: js['QUANTITY_UNIT'],
      VOLUMN_UNIT: js['VOLUMN_UNIT'],
      IS_TAX_VALUE: js['IS_TAX_VALUE'],
      TAX_VALUE: js['TAX_VALUE'],
      IS_TAX_VOLUMN: js['IS_TAX_VOLUMN'],
      TAX_VOLUMN: js['TAX_VOLUMN'],
      TAX_VOLUMN_UNIT: js['TAX_VOLUMN_UNIT'],
      LICENSE_PLATE: js['LICENSE_PLATE'],
      ENGINE_NO: js['ENGINE_NO'],
      CHASSIS_NO: js['CHASSIS_NO'],
      PRODUCT_DESC: js['PRODUCT_DESC'],
      SUGAR: js['SUGAR'],
      CO2: js['CO2'],
      DEGREE: js['DEGREE'],
      PRICE: js['PRICE'],
      REMAIN_SIZES: js['REMAIN_SIZES'],
      REMAIN_SIZES_UNIT: js['REMAIN_SIZES_UNIT'],
      REMAIN_QUANTITY: js['REMAIN_QUANTITY'],
      REMAIN_QUANTITY_UNIT: js['REMAIN_QUANTITY_UNIT'],
      REMAIN_VOLUMN: js['REMAIN_VOLUMN'],
      REMAIN_VOLUMN_UNIT: js['REMAIN_VOLUMN_UNIT'],
      REMARK: js['REMARK'],
      REMAIN_REMARK: js['REMAIN_REMARK'],
      PRODUCT_RESULT: js['PRODUCT_RESULT'],
      SCIENCE_RESULT_DESC: js['SCIENCE_RESULT_DESC'],
      VAT: js['VAT'],
      IS_DOMESTIC: js['IS_DOMESTIC'],
      IS_ILLEGAL: js['IS_ILLEGAL'],
      IS_SCIENCE: js['IS_SCIENCE'],
      IsCkecked: false,

      PRODUCT_CODE: js['PRODUCT_CODE'],
      PRODUCT_GROUP_ID: js['PRODUCT_GROUP_ID'],
      PRODUCT_GROUP_CODE: js['PRODUCT_GROUP_CODE'],
      PRODUCT_CATEGORY_ID: js['PRODUCT_CATEGORY_ID'],
      PRODUCT_CATEGORY_CODE: js['PRODUCT_CATEGORY_CODE'],
      Controller: new ItemsCompareEvidenceTaxValue(
        null,
        null,
        null,
        null,
        new TextEditingController(),
        new ExpandableController(),
        new FocusNode(),
        new TextEditingController(),
        new TextEditingController(),
        new TextEditingController(),
        false
      )
    );
  }
}