class ItemsListProductType {
  final int PRODUCT_TYPE_ID;
  final int PRODUCT_CATEGORY_ID;
  final String PRODUCT_TYPE_CODE;
  final String PRODUCT_TYPE_NAME;
  final int IS_TAX;
  final int IS_ACTIVE;

  ItemsListProductType({
    this.PRODUCT_TYPE_ID,
    this.PRODUCT_CATEGORY_ID,
    this.PRODUCT_TYPE_CODE,
    this.PRODUCT_TYPE_NAME,
    this.IS_TAX,
    this.IS_ACTIVE,
  });

  factory ItemsListProductType.fromJson(Map<String, dynamic> json) {
    return ItemsListProductType(
      PRODUCT_TYPE_ID: json['PRODUCT_TYPE_ID'],
      PRODUCT_CATEGORY_ID: json['PRODUCT_CATEGORY_ID'],
      PRODUCT_TYPE_CODE: json['PRODUCT_TYPE_CODE'],
      PRODUCT_TYPE_NAME: json['PRODUCT_TYPE_NAME'],
      IS_TAX: json['IS_TAX'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}