class ItemsListProductCategory {
  final int PRODUCT_CATEGORY_ID;
  final int PRODUCT_GROUP_ID;
  final String PRODUCT_CATEGORY_CODE;
  final String PRODUCT_CATEGORY_NAME;
  final int IS_TAX;
  final int IS_ACTIVE;

  ItemsListProductCategory({
    this.PRODUCT_CATEGORY_ID,
    this.PRODUCT_GROUP_ID,
    this.PRODUCT_CATEGORY_CODE,
    this.PRODUCT_CATEGORY_NAME,
    this.IS_TAX,
    this.IS_ACTIVE,
  });

  factory ItemsListProductCategory.fromJson(Map<String, dynamic> json) {
    return ItemsListProductCategory(
      PRODUCT_CATEGORY_ID: json['PRODUCT_CATEGORY_ID'],
      PRODUCT_GROUP_ID: json['PRODUCT_GROUP_ID'],
      PRODUCT_CATEGORY_CODE: json['PRODUCT_CATEGORY_CODE'],
      PRODUCT_CATEGORY_NAME: json['PRODUCT_CATEGORY_NAME'],
      IS_TAX: json['IS_TAX'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}