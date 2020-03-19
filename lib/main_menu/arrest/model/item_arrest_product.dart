import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';

class ItemsListArrestProduct {
  int PRODUCT_ID;
  String PRODUCT_CATEGORY_NAME;
  String PRODUCT_GROUP_NAME;
  String PRODUCT_TYPE_NAME;
  String PRODUCT_SUBTYPE_NAME;
  String PRODUCT_BRAND_NAME_TH;
  String PRODUCT_BRAND_NAME_EN;
  String PRODUCT_SUBBRAND_CODE;
  String PRODUCT_SUBBRAND_NAME_TH;
  String PRODUCT_SUBBRAND_NAME_EN;
  String PRODUCT_MODEL_NAME_TH;
  String PRODUCT_MODEL_NAME_EN;
  dynamic SIZES;
  dynamic QUANTITY;
  dynamic VOLUMN;
  String SIZES_UNIT;
  String QUANTITY_UNIT;
  String VOLUMN_UNIT;
  //dynamic FINE_ESTIMATE;

  dynamic TAX_VALUE;
  dynamic TAX_VOLUMN;
  String TAX_VOLUMN_UNIT;

  dynamic DEGREE;
  String PRODUCT_DESC;
  String REMARK;
  int IS_DOMESTIC;
  bool IsCheck;
  bool IsCheckOffence;
  ItemsListArrest6Controller Arrest6Controller;
  int INDEX;

  ItemsListArrestProduct({
    this.PRODUCT_ID,
    this.PRODUCT_CATEGORY_NAME,
    this.PRODUCT_GROUP_NAME,
    this.PRODUCT_TYPE_NAME,
    this.PRODUCT_SUBTYPE_NAME,
    this.PRODUCT_BRAND_NAME_TH,
    this.PRODUCT_BRAND_NAME_EN,
    this.PRODUCT_SUBBRAND_CODE,
    this.PRODUCT_SUBBRAND_NAME_TH,
    this.PRODUCT_SUBBRAND_NAME_EN,
    this.PRODUCT_MODEL_NAME_TH,
    this.PRODUCT_MODEL_NAME_EN,

    //this.FINE_ESTIMATE,
    this.TAX_VALUE,
    this.TAX_VOLUMN,
    this.TAX_VOLUMN_UNIT,

    this.DEGREE,
    this.PRODUCT_DESC,
    this.REMARK,
    this.IS_DOMESTIC,

    this.SIZES,
    this.QUANTITY,
    this.VOLUMN,
    this.SIZES_UNIT,
    this.QUANTITY_UNIT,
    this.VOLUMN_UNIT,
    this.IsCheck,
    this.IsCheckOffence,
    this.Arrest6Controller,
    this.INDEX,
  });

  factory ItemsListArrestProduct.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestProduct(
        PRODUCT_ID: js['PRODUCT_ID'],
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
        SIZES: js['SIZES'],
        QUANTITY: js['QUANTITY'],
        VOLUMN: js['VOLUMN'],
        SIZES_UNIT: js['SIZES_UNIT'],
        QUANTITY_UNIT: js['QUANTITY_UNIT'],
        VOLUMN_UNIT: js['VOLUMN_UNIT'],

        //FINE_ESTIMATE: null,
        TAX_VALUE: js['TAX_VALUE'],
        TAX_VOLUMN: js['TAX_VOLUMN'],
        TAX_VOLUMN_UNIT: js['TAX_VOLUMN_UNIT'],

        DEGREE: js['DEGREE'],
        PRODUCT_DESC: js['PRODUCT_DESC'],
        REMARK: js['REMARK'],
        IS_DOMESTIC: js['IS_DOMESTIC'],

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
        INDEX: null
    );
  }
}