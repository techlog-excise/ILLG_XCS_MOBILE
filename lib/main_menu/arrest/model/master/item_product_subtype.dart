class ItemsListProductSubType {
  final int PRODUCT_SUBTYPE_ID;
  final int PRODUCT_TYPE_ID;
  final String PRODUCT_SUBTYPE_CODE;
  final String PRODUCT_SUBTYPE_NAME;
  final int IS_TAX;
  final int IS_ACTIVE;

  ItemsListProductSubType({
    this.PRODUCT_SUBTYPE_ID,
    this.PRODUCT_TYPE_ID,
    this.PRODUCT_SUBTYPE_CODE,
    this.PRODUCT_SUBTYPE_NAME,
    this.IS_TAX,
    this.IS_ACTIVE,
  });

  factory ItemsListProductSubType.fromJson(Map<String, dynamic> json) {
    return ItemsListProductSubType(
      PRODUCT_SUBTYPE_ID: json['PRODUCT_SUBTYPE_ID'],
      PRODUCT_TYPE_ID: json['PRODUCT_TYPE_ID'],
      PRODUCT_SUBTYPE_CODE: json['PRODUCT_SUBTYPE_CODE'],
      PRODUCT_SUBTYPE_NAME: json['PRODUCT_SUBTYPE_NAME'],
      IS_TAX: json['IS_TAX'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}