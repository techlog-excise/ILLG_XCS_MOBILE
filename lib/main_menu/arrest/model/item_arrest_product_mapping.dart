import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';

class ItemsListArrestProductMapping {
  int PRODUCT_ID;
  int PRODUCT_INDICTMENT_ID;
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
  int UNIT_ID;
  dynamic SIZES;
  String SIZES_UNIT;
  dynamic DEGREE;
  dynamic SUGAR;
  dynamic CO2;
  dynamic PRICE;
  String PRODUCT_DESC;
  int IS_DOMESTIC;
  int IS_ACTIVE;
  String PRODUCT_GROUP_NAME;
  String PRODUCT_CATEGORY_NAME;
  String PRODUCT_TYPE_NAME;
  String PRODUCT_SUBTYPE_NAME;
  String PRODUCT_SUBSETTYPE_NAME;
  String PRODUCT_BRAND_NAME_TH;
  String PRODUCT_BRAND_NAME_EN;
  String PRODUCT_SUBBRAND_NAME_TH;
  String PRODUCT_SUBBRAND_NAME_EN;
  String PRODUCT_MODEL_NAME_TH;
  String PRODUCT_MODEL_NAME_EN;

  double QUANTITY;
  double VOLUMN;
  String QUANTITY_UNIT;
  String VOLUMN_UNIT;

  int SIZES_UNIT_ID;
  int QUATITY_UNIT_ID;
  int VOLUMN_UNIT_ID;

  //double FINE_ESTIMATE;
  dynamic TAX_VALUE;
  dynamic TAX_VOLUMN;
  String TAX_VOLUMN_UNIT;

  String COMPANYNAME;

  String REMARK;
  bool IsCheck;
  bool IsCheckOffence;
  ItemsListArrest6Controller Arrest6Controller;
  int INDEX;
  int INDICTMENT_DETAIL_ID;

  ItemsListArrestProductMapping({
    this.PRODUCT_INDICTMENT_ID,
    this.PRODUCT_ID,
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
    this.UNIT_ID,
    this.SIZES,
    this.SIZES_UNIT,
    this.DEGREE,
    this.SUGAR,
    this.CO2,
    this.PRICE,
    this.PRODUCT_DESC,
    this.IS_DOMESTIC,
    this.IS_ACTIVE,
    this.PRODUCT_GROUP_NAME,
    this.PRODUCT_CATEGORY_NAME,
    this.PRODUCT_TYPE_NAME,
    this.PRODUCT_SUBTYPE_NAME,
    this.PRODUCT_SUBSETTYPE_NAME,
    this.PRODUCT_BRAND_NAME_TH,
    this.PRODUCT_BRAND_NAME_EN,
    this.PRODUCT_SUBBRAND_NAME_TH,
    this.PRODUCT_SUBBRAND_NAME_EN,
    this.PRODUCT_MODEL_NAME_TH,
    this.PRODUCT_MODEL_NAME_EN,
    this.QUANTITY,
    this.VOLUMN,
    this.QUANTITY_UNIT,
    this.VOLUMN_UNIT,
    this.SIZES_UNIT_ID,
    this.VOLUMN_UNIT_ID,
    this.QUATITY_UNIT_ID,

    //this.FINE_ESTIMATE,
    this.TAX_VALUE,
    this.TAX_VOLUMN,
    this.TAX_VOLUMN_UNIT,
    this.COMPANYNAME,
    this.REMARK,
    this.IsCheck,
    this.IsCheckOffence,
    this.Arrest6Controller,
    this.INDEX,
    this.INDICTMENT_DETAIL_ID,
  });

  factory ItemsListArrestProductMapping.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestProductMapping(
        PRODUCT_INDICTMENT_ID: null,
        PRODUCT_ID: js['PRODUCT_ID'],
        PRODUCT_MAPPING_ID: js['PRODUCT_MAPPING_ID'],
        PRODUCT_CODE: js['PRODUCT_CODE'],
        PRODUCT_REF_CODE: js['PRODUCT_REF_CODE'],
        PRODUCT_GROUP_ID: js['PRODUCT_GROUP_ID'],
        PRODUCT_CATEGORY_ID: js['PRODUCT_CATEGORY_ID'],
        PRODUCT_TYPE_ID: js['PRODUCT_TYPE_ID'],
        PRODUCT_SUBTYPE_ID: js['PRODUCT_SUBTYPE_ID'],
        PRODUCT_SUBSETTYPE_ID: js['PRODUCT_SUBSETTYPE_ID'],
        PRODUCT_BRAND_ID: js['PRODUCT_BRAND_ID'],
        PRODUCT_SUBBRAND_ID: js['PRODUCT_SUBBRAND_ID'],
        PRODUCT_MODEL_ID: js['PRODUCT_MODEL_ID'],
        PRODUCT_TAXDETAIL_ID: js['PRODUCT_TAXDETAIL_ID'],
        UNIT_ID: js['UNIT_ID'],
        SIZES: js['SIZES'],
        SIZES_UNIT: js['SIZES_UNIT'],
        DEGREE: js['DEGREE'],
        SUGAR: js['SUGAR'],
        CO2: js['CO2'],
        PRICE: js['PRICE'],
        PRODUCT_DESC: js['PRODUCT_NAME_DESC'] == null ? js['PRODUCT_DESC'] : js['PRODUCT_NAME_DESC'],
        IS_DOMESTIC: js['IS_DOMESTIC'],
        IS_ACTIVE: js['IS_ACTIVE'],
        PRODUCT_GROUP_NAME: js['PRODUCT_GROUP_NAME'],
        PRODUCT_CATEGORY_NAME: js['PRODUCT_CATEGORY_NAME'],
        PRODUCT_TYPE_NAME: js['PRODUCT_TYPE_NAME'],
        PRODUCT_SUBTYPE_NAME: js['PRODUCT_SUBTYPE_NAME'],
        PRODUCT_SUBSETTYPE_NAME: js['PRODUCT_SUBSETTYPE_NAME'],
        PRODUCT_BRAND_NAME_TH: js['PRODUCT_BRAND_NAME_TH'],
        PRODUCT_BRAND_NAME_EN: js['PRODUCT_BRAND_NAME_EN'],
        PRODUCT_SUBBRAND_NAME_TH: js['PRODUCT_SUBBRAND_NAME_TH'],
        PRODUCT_SUBBRAND_NAME_EN: js['PRODUCT_SUBBRAND_NAME_EN'],
        PRODUCT_MODEL_NAME_TH: js['PRODUCT_MODEL_NAME_TH'],
        PRODUCT_MODEL_NAME_EN: js['PRODUCT_MODEL_NAME_EN'],
        QUANTITY: js['QUANTITY'],
        VOLUMN: js['VOLUMN'],
        QUANTITY_UNIT: js['QUANTITY_UNIT'],
        VOLUMN_UNIT: js['VOLUMN_UNIT'],
        SIZES_UNIT_ID: js['SIZES_UNIT_ID'],
        QUATITY_UNIT_ID: js['QUATITY_UNIT_ID'],
        VOLUMN_UNIT_ID: js['VOLUMN_UNIT_ID'],

        //FINE_ESTIMATE: null,
        TAX_VALUE: js['TAX_VALUE'],
        TAX_VOLUMN: js['TAX_VOLUMN'],
        TAX_VOLUMN_UNIT: js['TAX_VOLUMN_UNIT'],
        COMPANYNAME: js['COMPANYNAME'],
        REMARK: js['REMARK'],
        IsCheck: false,
        IsCheckOffence: false,
        Arrest6Controller: new ItemsListArrest6Controller(
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new TextEditingController(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          new FocusNode(),
          false,
          false,
        ),
        INDEX: null);
  }
}
