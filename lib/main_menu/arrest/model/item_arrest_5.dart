import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';

class ItemsListArrest5Test {
  List ItemsListArrest5Mas;
  List ItemsListArrest5Ops;

  ItemsListArrest5Test(
    this.ItemsListArrest5Mas,
    this.ItemsListArrest5Ops,
  );
}

class ItemsListArrest5 {
  /*List ItemsListArrest5Mas;
  List ItemsListArrest5Ops;

  ItemsListArrest5(
      this.ItemsListArrest5Mas,
      this.ItemsListArrest5Ops,
      );*/

  int PRODUCT_MAPPING_ID;
  String PRODUCT_CODE;
  String PRODUCT_REF_CODE;
  int PRODUCT_ID;

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

  String PRODUCT_CATEGORY_NAME;
  String PRODUCT_GROUP_NAME;
  String PRODUCT_TYPE_NAME;
  String PRODUCT_SUBTYPE_NAME;
  String PRODUCT_SUBSETTYPE_NAME;
  String PRODUCT_BRAND_NAME_TH;
  String PRODUCT_BRAND_NAME_EN;
  String PRODUCT_SUBBRAND_CODE;
  String PRODUCT_SUBBRAND_NAME_TH;
  String PRODUCT_SUBBRAND_NAME_EN;
  String PRODUCT_MODEL_NAME_TH;
  String PRODUCT_MODEL_NAME_EN;
  int SIZES_UNIT_ID;
  int QUATITY_UNIT_ID;
  int VOLUMN_UNIT_ID;
  double SIZES;
  double QUANTITY;
  double VOLUMN;
  String SIZES_UNIT;
  String QUANTITY_UNIT;
  String VOLUMN_UNIT;
  double FINE_ESTIMATE;

  dynamic DEGREE;
  dynamic SUGAR;
  dynamic CO2;
  dynamic PRICE;
  String PRODUCT_DESC;
  String REMARK;
  int IS_DOMESTIC;

  bool IsCheck;
  bool IsCheckOffence;
  ItemsListArrest6Controller Arrest6Controller;
  int INDEX;

  ItemsListArrest5(
    this.PRODUCT_MAPPING_ID,
    this.PRODUCT_CODE,
    this.PRODUCT_REF_CODE,
    this.PRODUCT_ID,
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
    this.PRODUCT_GROUP_NAME,
    this.PRODUCT_CATEGORY_NAME,
    this.PRODUCT_TYPE_NAME,
    this.PRODUCT_SUBTYPE_NAME,
    this.PRODUCT_SUBSETTYPE_NAME,
    this.PRODUCT_BRAND_NAME_TH,
    this.PRODUCT_BRAND_NAME_EN,
    this.PRODUCT_SUBBRAND_CODE,
    this.PRODUCT_SUBBRAND_NAME_TH,
    this.PRODUCT_SUBBRAND_NAME_EN,
    this.PRODUCT_MODEL_NAME_TH,
    this.PRODUCT_MODEL_NAME_EN,
    this.SIZES_UNIT_ID,
    this.QUANTITY,
    this.VOLUMN_UNIT_ID,
    this.SIZES,
    this.QUATITY_UNIT_ID,
    this.VOLUMN,
    this.SIZES_UNIT,
    this.QUANTITY_UNIT,
    this.VOLUMN_UNIT,
    this.FINE_ESTIMATE,
    this.DEGREE,
    this.SUGAR,
    this.CO2,
    this.PRICE,
    this.PRODUCT_DESC,
    this.REMARK,
    this.IS_DOMESTIC,
    this.IsCheck,
    this.IsCheckOffence,
    this.Arrest6Controller,
    this.INDEX,
  );
}

class ItemsListArrestMas {
  int PRODUCT_MAPPING_ID;
  String PRODUCT_CODE;
  String PRODUCT_REF_CODE;
  int PRODUCT_ID;

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

  String PRODUCT_CATEGORY_NAME;
  String PRODUCT_GROUP_NAME;
  String PRODUCT_TYPE_NAME;
  String PRODUCT_SUBTYPE_NAME;
  String PRODUCT_SUBSETTYPE_NAME;
  String PRODUCT_BRAND_NAME_TH;
  String PRODUCT_BRAND_NAME_EN;
  String PRODUCT_SUBBRAND_CODE;
  String PRODUCT_SUBBRAND_NAME_TH;
  String PRODUCT_SUBBRAND_NAME_EN;
  String PRODUCT_MODEL_NAME_TH;
  String PRODUCT_MODEL_NAME_EN;
  int SIZES_UNIT_ID;
  int QUATITY_UNIT_ID;
  int VOLUMN_UNIT_ID;
  double SIZES;
  double QUANTITY;
  double VOLUMN;
  String SIZES_UNIT;
  String QUANTITY_UNIT;
  String VOLUMN_UNIT;
  double FINE_ESTIMATE;

  dynamic TAX_VALUE;
  dynamic TAX_VOLUMN;
  String TAX_VOLUMN_UNIT;

  dynamic DEGREE;
  dynamic SUGAR;
  dynamic CO2;
  dynamic PRICE;
  String PRODUCT_DESC;
  String REMARK;
  int IS_DOMESTIC;

  bool IsCheck;
  bool IsCheckOffence;
  ItemsListArrest6Controller Arrest6Controller;
  int INDEX;

  ItemsListArrestMas(
    this.PRODUCT_MAPPING_ID,
    this.PRODUCT_CODE,
    this.PRODUCT_REF_CODE,
    this.PRODUCT_ID,
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
    this.PRODUCT_GROUP_NAME,
    this.PRODUCT_CATEGORY_NAME,
    this.PRODUCT_TYPE_NAME,
    this.PRODUCT_SUBTYPE_NAME,
    this.PRODUCT_SUBSETTYPE_NAME,
    this.PRODUCT_BRAND_NAME_TH,
    this.PRODUCT_BRAND_NAME_EN,
    this.PRODUCT_SUBBRAND_CODE,
    this.PRODUCT_SUBBRAND_NAME_TH,
    this.PRODUCT_SUBBRAND_NAME_EN,
    this.PRODUCT_MODEL_NAME_TH,
    this.PRODUCT_MODEL_NAME_EN,
    this.SIZES_UNIT_ID,
    this.QUANTITY,
    this.VOLUMN_UNIT_ID,
    this.SIZES,
    this.QUATITY_UNIT_ID,
    this.VOLUMN,
    this.SIZES_UNIT,
    this.QUANTITY_UNIT,
    this.VOLUMN_UNIT,
    this.FINE_ESTIMATE,
    this.TAX_VALUE,
    this.TAX_VOLUMN,
    this.TAX_VOLUMN_UNIT,
    this.DEGREE,
    this.SUGAR,
    this.CO2,
    this.PRICE,
    this.PRODUCT_DESC,
    this.REMARK,
    this.IS_DOMESTIC,
    this.IsCheck,
    this.IsCheckOffence,
    this.Arrest6Controller,
    this.INDEX,
  );
}

class ItemsListArrestOps {
  int PRODUCT_MAPPING_ID;
  String PRODUCT_CODE;
  String PRODUCT_REF_CODE;
  int PRODUCT_ID;

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

  String PRODUCT_CATEGORY_NAME;
  String PRODUCT_GROUP_NAME;
  String PRODUCT_TYPE_NAME;
  String PRODUCT_SUBTYPE_NAME;
  String PRODUCT_SUBSETTYPE_NAME;
  String PRODUCT_BRAND_NAME_TH;
  String PRODUCT_BRAND_NAME_EN;
  String PRODUCT_SUBBRAND_CODE;
  String PRODUCT_SUBBRAND_NAME_TH;
  String PRODUCT_SUBBRAND_NAME_EN;
  String PRODUCT_MODEL_NAME_TH;
  String PRODUCT_MODEL_NAME_EN;
  int SIZES_UNIT_ID;
  int QUATITY_UNIT_ID;
  int VOLUMN_UNIT_ID;
  double SIZES;
  double QUANTITY;
  double VOLUMN;
  String SIZES_UNIT;
  String QUANTITY_UNIT;
  String VOLUMN_UNIT;
  double FINE_ESTIMATE;

  dynamic TAX_VALUE;
  dynamic TAX_VOLUMN;
  String TAX_VOLUMN_UNIT;

  dynamic DEGREE;
  dynamic SUGAR;
  dynamic CO2;
  dynamic PRICE;
  String PRODUCT_DESC;
  String COMPANYNAME;
  String REMARK;
  int IS_DOMESTIC;

  bool IsCheck;
  bool IsCheckOffence;
  ItemsListArrest6Controller Arrest6Controller;
  int INDEX;

  ItemsListArrestOps(
    this.PRODUCT_MAPPING_ID,
    this.PRODUCT_CODE,
    this.PRODUCT_REF_CODE,
    this.PRODUCT_ID,
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
    this.PRODUCT_GROUP_NAME,
    this.PRODUCT_CATEGORY_NAME,
    this.PRODUCT_TYPE_NAME,
    this.PRODUCT_SUBTYPE_NAME,
    this.PRODUCT_SUBSETTYPE_NAME,
    this.PRODUCT_BRAND_NAME_TH,
    this.PRODUCT_BRAND_NAME_EN,
    this.PRODUCT_SUBBRAND_CODE,
    this.PRODUCT_SUBBRAND_NAME_TH,
    this.PRODUCT_SUBBRAND_NAME_EN,
    this.PRODUCT_MODEL_NAME_TH,
    this.PRODUCT_MODEL_NAME_EN,
    this.SIZES_UNIT_ID,
    this.QUANTITY,
    this.VOLUMN_UNIT_ID,
    this.SIZES,
    this.QUATITY_UNIT_ID,
    this.VOLUMN,
    this.SIZES_UNIT,
    this.QUANTITY_UNIT,
    this.VOLUMN_UNIT,
    this.FINE_ESTIMATE,
    this.TAX_VALUE,
    this.TAX_VOLUMN,
    this.TAX_VOLUMN_UNIT,
    this.DEGREE,
    this.SUGAR,
    this.CO2,
    this.PRICE,
    this.PRODUCT_DESC,
    this.COMPANYNAME,
    this.REMARK,
    this.IS_DOMESTIC,
    this.IsCheck,
    this.IsCheckOffence,
    this.Arrest6Controller,
    this.INDEX,
  );
}
