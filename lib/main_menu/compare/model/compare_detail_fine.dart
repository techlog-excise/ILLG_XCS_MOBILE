
class ItemsCompareDetailFine{
  final int FINE_ID;
  final int COMPARE_DETAIL_ID;
  final int PRODUCT_ID;
  final double FINE_RATE;
  final double VAT;
  final double FINE;
  final double NET_FINE;
  final double OLD_PAYMENT_FINE;
  final double PAYMENT_FINE;
  final double DIFFERENCE_PAYMENT_FINE;
  final double TREASURY_MONEY;
  final double BRIBE_MONEY;
  final double REWARD_MONEY;
  final int IS_ACTIVE;
  final String PRODUCT_GROUP_NAME;
  final String PRODUCT_CATEGORY_NAME;
  final String PRODUCT_TYPE_NAME;
  final String PRODUCT_SUBTYPE_NAME;
  final String PRODUCT_SUBSETTYPE_NAME;
  final String PRODUCT_BRAND_NAME_TH;
  final String PRODUCT_BRAND_NAME_EN;
  final String PRODUCT_SUBBRAND_NAME_TH;
  final String PRODUCT_SUBBRAND_NAME_EN;
  final String PRODUCT_MODEL_NAME_TH;
  final String PRODUCT_MODEL_NAME_EN;
  final double SIZES;
  final String SIZES_UNIT;
  final double QUANTITY;
  final String QUANTITY_UNIT;
  final double VOLUMN;
  final String VOLUMN_UNIT;

  ItemsCompareDetailFine({
    this.FINE_ID,
    this.COMPARE_DETAIL_ID,
    this.PRODUCT_ID,
    this.FINE_RATE,
    this.VAT,
    this.FINE,
    this.NET_FINE,
    this.OLD_PAYMENT_FINE,
    this.PAYMENT_FINE,
    this.DIFFERENCE_PAYMENT_FINE,
    this.TREASURY_MONEY,
    this.BRIBE_MONEY,
    this.REWARD_MONEY,
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
    this.SIZES,
    this.SIZES_UNIT,
    this.QUANTITY,
    this.QUANTITY_UNIT,
    this.VOLUMN,
    this.VOLUMN_UNIT,
  });

  factory ItemsCompareDetailFine.fromJson(Map<String, dynamic> json) {
    return ItemsCompareDetailFine(
      FINE_ID: json['FINE_ID'],
      COMPARE_DETAIL_ID: json['COMPARE_DETAIL_ID'],
      PRODUCT_ID: json['PRODUCT_ID'],
      FINE_RATE: json['FINE_RATE'],
      VAT: json['VAT'],
      FINE: json['FINE'],
      NET_FINE: json['NET_FINE'],
      OLD_PAYMENT_FINE: json['OLD_PAYMENT_FINE'],
      PAYMENT_FINE: json['PAYMENT_FINE'],
      DIFFERENCE_PAYMENT_FINE: json['DIFFERENCE_PAYMENT_FINE'],
      TREASURY_MONEY: json['TREASURY_MONEY'],
      BRIBE_MONEY: json['BRIBE_MONEY'],
      REWARD_MONEY: json['REWARD_MONEY'],
      IS_ACTIVE: json['IS_ACTIVE'],
      PRODUCT_GROUP_NAME: json['PRODUCT_GROUP_NAME'],
      PRODUCT_CATEGORY_NAME: json['PRODUCT_CATEGORY_NAME'],
      PRODUCT_TYPE_NAME: json['PRODUCT_TYPE_NAME'],
      PRODUCT_SUBTYPE_NAME: json['PRODUCT_SUBTYPE_NAME'],
      PRODUCT_SUBSETTYPE_NAME: json['PRODUCT_SUBSETTYPE_NAME'],
      PRODUCT_BRAND_NAME_TH: json['PRODUCT_BRAND_NAME_TH'],
      PRODUCT_BRAND_NAME_EN: json['PRODUCT_BRAND_NAME_EN'],
      PRODUCT_SUBBRAND_NAME_TH: json['PRODUCT_SUBBRAND_NAME_TH'],
      PRODUCT_SUBBRAND_NAME_EN: json['PRODUCT_SUBBRAND_NAME_EN'],
      PRODUCT_MODEL_NAME_TH: json['PRODUCT_MODEL_NAME_TH'],
      PRODUCT_MODEL_NAME_EN: json['PRODUCT_MODEL_NAME_EN'],
      SIZES: json['SIZES'],
      SIZES_UNIT: json['SIZES_UNIT'],
      QUANTITY: json['QUANTITY'],
      QUANTITY_UNIT: json['QUANTITY_UNIT'],
      VOLUMN: json['VOLUMN'],
      VOLUMN_UNIT: json['VOLUMN_UNIT'],
    );
  }
}