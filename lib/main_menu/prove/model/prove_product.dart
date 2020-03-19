import 'package:prototype_app_pang/main_menu/arrest/model/master/item_document.dart';
class ItemsProveProduct {
  final int PRODUCT_ID;
  final int PROVE_ID;
  final int SCIENCE_ID;
  final int PRODUCT_MAPPING_ID;
  final int PRODUCT_INDICTMENT_ID;
  final int PRODUCT_MAPPING_REF_ID;
  final String PRODUCT_CODE;
  final String PRODUCT_REF_CODE;
  final int PRODUCT_GROUP_ID;
  final int PRODUCT_CATEGORY_ID;
  final int PRODUCT_TYPE_ID;
  final int PRODUCT_SUBTYPE_ID;
  final int PRODUCT_SUBSETTYPE_ID;
  final int PRODUCT_BRAND_ID;
  final int PRODUCT_SUBBRAND_ID;
  final int PRODUCT_MODEL_ID;
  final int PRODUCT_TAXDETAIL_ID;
  final int SIZES_UNIT_ID;
  final int QUATITY_UNIT_ID;
  final int VOLUMN_UNIT_ID;
  final int REMAIN_SIZES_UNIT_ID;
  final int REMAIN_QUATITY_UNIT_ID;
  final int REMAIN_VOLUMN_UNIT_ID;
  final String PRODUCT_GROUP_CODE;
  final String PRODUCT_GROUP_NAME;
  final String PRODUCT_CATEGORY_CODE;
  final String PRODUCT_CATEGORY_NAME;
  final String PRODUCT_TYPE_CODE;
  final String PRODUCT_TYPE_NAME;
  final String PRODUCT_SUBTYPE_CODE;
  final String PRODUCT_SUBTYPE_NAME;
  final String PRODUCT_SUBSETTYPE_CODE;
  final String PRODUCT_SUBSETTYPE_NAME;
  final String PRODUCT_BRAND_CODE;
  final String PRODUCT_BRAND_NAME_TH;
  final String PRODUCT_BRAND_NAME_EN;
  final String PRODUCT_SUBBRAND_CODE;
  final String PRODUCT_SUBBRAND_NAME_TH;
  final String PRODUCT_SUBBRAND_NAME_EN;
  final String PRODUCT_MODEL_CODE;
  final String PRODUCT_MODEL_NAME_TH;
  final String PRODUCT_MODEL_NAME_EN;
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
  double SIZES;
  String SIZES_UNIT;
  double QUANTITY;
  String QUANTITY_UNIT;
  double VOLUMN;
  String VOLUMN_UNIT;
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
  bool IS_PROVE;
  bool IS_CHECK;


  List<ItemsListDocument> itemsListDocument;

  ItemsProveProduct({
    this.PRODUCT_ID,
    this.PROVE_ID,
    this.SCIENCE_ID,
    this.PRODUCT_MAPPING_ID,
    this.PRODUCT_INDICTMENT_ID,
    this.PRODUCT_MAPPING_REF_ID,
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
    this.SIZES_UNIT_ID,
    this.QUATITY_UNIT_ID,
    this.VOLUMN_UNIT_ID,
    this.REMAIN_SIZES_UNIT_ID,
    this.REMAIN_QUATITY_UNIT_ID,
    this.REMAIN_VOLUMN_UNIT_ID,
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
    this.SIZES,
    this.SIZES_UNIT,
    this.QUANTITY,
    this.QUANTITY_UNIT,
    this.VOLUMN,
    this.VOLUMN_UNIT,
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
    this.IS_PROVE,
    this.IS_CHECK,


    this.itemsListDocument,
  });

  factory ItemsProveProduct.fromJson(Map<String, dynamic> json) {
    return ItemsProveProduct(
        PRODUCT_ID: json['PRODUCT_ID'],
        PROVE_ID: json['PROVE_ID'],
        SCIENCE_ID: json['SCIENCE_ID'],
        PRODUCT_MAPPING_ID: json['PRODUCT_MAPPING_ID'],
        PRODUCT_INDICTMENT_ID: json['PRODUCT_INDICTMENT_ID'],
        PRODUCT_MAPPING_REF_ID: json['PRODUCT_MAPPING_REF_ID'],
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
        SIZES_UNIT_ID: json['SIZES_UNIT_ID'],
        QUATITY_UNIT_ID: json['QUATITY_UNIT_ID'],
        VOLUMN_UNIT_ID: json['VOLUMN_UNIT_ID'],
        REMAIN_SIZES_UNIT_ID: json['REMAIN_SIZES_UNIT_ID'],
        REMAIN_QUATITY_UNIT_ID: json['REMAIN_QUATITY_UNIT_ID'],
        REMAIN_VOLUMN_UNIT_ID: json['REMAIN_VOLUMN_UNIT_ID'],
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
        IS_TAX_VALUE: json['IS_TAX_VALUE'],
        TAX_VALUE: json['TAX_VALUE'],
        IS_TAX_VOLUMN: json['IS_TAX_VOLUMN'],
        TAX_VOLUMN: json['TAX_VOLUMN'],
        TAX_VOLUMN_UNIT: json['TAX_VOLUMN_UNIT'],
        LICENSE_PLATE: json['LICENSE_PLATE'],
        ENGINE_NO: json['ENGINE_NO'],
        CHASSIS_NO: json['CHASSIS_NO'],
        PRODUCT_DESC: json['PRODUCT_DESC'],
        SUGAR: json['SUGAR'],
        CO2: json['CO2'],
        DEGREE: json['DEGREE'],
        PRICE: json['PRICE'],
        SIZES: json['SIZES'],
        SIZES_UNIT: json['SIZES_UNIT'],
        QUANTITY: json['QUANTITY'],
        QUANTITY_UNIT: json['QUANTITY_UNIT'],
        VOLUMN: json['VOLUMN'],
        VOLUMN_UNIT: json['VOLUMN_UNIT'],
        REMAIN_SIZES: json['REMAIN_SIZES'],
        REMAIN_SIZES_UNIT: json['REMAIN_SIZES_UNIT'],
        REMAIN_QUANTITY: json['REMAIN_QUANTITY'],
        REMAIN_QUANTITY_UNIT: json['REMAIN_QUANTITY_UNIT'],
        REMAIN_VOLUMN: json['REMAIN_VOLUMN'],
        REMAIN_VOLUMN_UNIT: json['REMAIN_VOLUMN_UNIT'],
        REMARK: json['REMARK'],
        REMAIN_REMARK: json['REMAIN_REMARK'],
        PRODUCT_RESULT: json['PRODUCT_RESULT'],
        SCIENCE_RESULT_DESC: json['SCIENCE_RESULT_DESC'],
        VAT: json['VAT'],
        IS_DOMESTIC: json['IS_DOMESTIC'],
        IS_ILLEGAL: json['IS_ILLEGAL'],
        IS_SCIENCE: json['IS_SCIENCE'],
        //IS_PROVE: json['IS_PROVE'],
        IS_PROVE: true,
        IS_CHECK: false,


        itemsListDocument: [],
    );
  }
}