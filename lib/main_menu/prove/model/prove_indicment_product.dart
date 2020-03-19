
class ItemsProveArrestIndicmentProduct {
  final int PRODUCT_INDICTMENT_ID;
  final int PRODUCT_ID;
  final int INDICTMENT_ID;

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

  final String PRODUCT_DESC;
  final dynamic DEGREE;
  final dynamic SUGAR;
  final dynamic CO2;
  final dynamic SIZES;
  final String SIZES_UNIT;
  final dynamic QUANTITY;
  final String QUANTITY_UNIT;
  final dynamic VOLUMN;
  final String VOLUMN_UNIT;

  double VAT;
  String PRODUCT_CODE;
  String PRODUCT_GROUP_ID;
  String PRODUCT_GROUP_CODE;
  String PRODUCT_CATEGORY_ID;
  String PRODUCT_CATEGORY_CODE;

  String REMARK;

  ItemsProveArrestIndicmentProduct({
    this.PRODUCT_INDICTMENT_ID,
    this.PRODUCT_ID,
    this.INDICTMENT_ID,

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

    this.PRODUCT_DESC,
    this.DEGREE,
    this.SUGAR,
    this.CO2,
    this.SIZES,
    this.SIZES_UNIT,
    this.QUANTITY,
    this.QUANTITY_UNIT,
    this.VOLUMN,
    this.VOLUMN_UNIT,
    this.VAT,


    this.PRODUCT_CATEGORY_CODE,
    this.PRODUCT_GROUP_CODE,
    this.PRODUCT_GROUP_ID,
    this.PRODUCT_CATEGORY_ID,
    this.PRODUCT_CODE,
    this.REMARK

  });

  factory ItemsProveArrestIndicmentProduct.fromJson(Map<String, dynamic> json) {
    return ItemsProveArrestIndicmentProduct(
        PRODUCT_INDICTMENT_ID: json['PRODUCT_INDICTMENT_ID'],
        PRODUCT_ID: json['PRODUCT_ID'],
        INDICTMENT_ID: json['INDICTMENT_ID'],

        PRODUCT_GROUP_NAME: json['PRODUCT_GROUP_NAME'],
        PRODUCT_CATEGORY_NAME: json['PRODUCT_CATEGORY_NAME'],
        PRODUCT_TYPE_NAME: json['PRODUCT_TYPE_NAME'],
        PRODUCT_SUBTYPE_NAME: json['PRODUCT_SUBTYPE_NAME'],
        PRODUCT_BRAND_NAME_TH: json['PRODUCT_BRAND_NAME_TH'],
        PRODUCT_BRAND_NAME_EN: json['PRODUCT_BRAND_NAME_EN'],
        PRODUCT_SUBBRAND_CODE: json['PRODUCT_SUBBRAND_CODE'],
        PRODUCT_SUBBRAND_NAME_TH: json['PRODUCT_SUBBRAND_NAME_TH'],
        PRODUCT_SUBBRAND_NAME_EN: json['PRODUCT_SUBBRAND_NAME_EN'],
        PRODUCT_MODEL_NAME_TH: json['PRODUCT_MODEL_NAME_TH'],
        PRODUCT_MODEL_NAME_EN: json['PRODUCT_MODEL_NAME_EN'],

        PRODUCT_DESC: json['PRODUCT_DESC'],
        DEGREE: json['DEGREE'],
        SUGAR: json['SUGAR'],
        CO2: json['CO2'],
        SIZES: json['SIZES'],
        SIZES_UNIT: json['SIZES_UNIT'],
        QUANTITY: json['QUANTITY'],
        QUANTITY_UNIT: json['QUANTITY_UNIT'],
        VOLUMN: json['VOLUMN'],
        VOLUMN_UNIT: json['VOLUMN_UNIT'],

        VAT: 0.0,
        PRODUCT_CATEGORY_CODE: json['PRODUCT_CATEGORY_CODE'],
        PRODUCT_GROUP_CODE: json['PRODUCT_GROUP_CODE'],
        PRODUCT_GROUP_ID: json['PRODUCT_GROUP_ID'],
        PRODUCT_CATEGORY_ID: json['PRODUCT_CATEGORY_ID'],
        PRODUCT_CODE: json['PRODUCT_CODE'],

        REMARK: json['REMARK']

    );
  }
}