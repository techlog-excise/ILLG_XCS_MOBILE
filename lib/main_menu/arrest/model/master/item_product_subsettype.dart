class ItemsListProductSubSetType {
  final int PRODUCT_SUBSETTYPE_ID;
  final int PRODUCT_SUBTYPE_ID;
  final String PRODUCT_SUBSETTYPE_CODE;
  final String PRODUCT_SUBSETTYPE_NAME;
  final int IS_TAX;
  final int IS_ACTIVE;

  ItemsListProductSubSetType({
    this.PRODUCT_SUBSETTYPE_ID,
    this.PRODUCT_SUBTYPE_ID,
    this.PRODUCT_SUBSETTYPE_CODE,
    this.PRODUCT_SUBSETTYPE_NAME,
    this.IS_TAX,
    this.IS_ACTIVE,
  });

  factory ItemsListProductSubSetType.fromJson(Map<String, dynamic> json) {
    return ItemsListProductSubSetType(
      PRODUCT_SUBSETTYPE_ID: json['PRODUCT_SUBSETTYPE_ID'],
      PRODUCT_SUBTYPE_ID: json['PRODUCT_SUBTYPE_ID'],
      PRODUCT_SUBSETTYPE_CODE: json['PRODUCT_SUBSETTYPE_CODE'],
      PRODUCT_SUBSETTYPE_NAME: json['PRODUCT_SUBSETTYPE_NAME'],
      IS_TAX: json['IS_TAX'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}