class ItemsListProductGROUPCategory {

  final int PRODUCT_GROUP_ID;
  final String PRODUCT_GROUP_CODE;
  final String PRODUCT_GROUP_NAME;
  final int PRODUCT_CATEGORY_ID;
  final String PRODUCT_CATEGORY_CODE;
  final String PRODUCT_CATEGORY_NAME;

  ItemsListProductGROUPCategory({
    this.PRODUCT_GROUP_ID,
    this.PRODUCT_GROUP_CODE,
    this.PRODUCT_GROUP_NAME,
    this.PRODUCT_CATEGORY_ID,
    this.PRODUCT_CATEGORY_CODE,
    this.PRODUCT_CATEGORY_NAME,
  });

  factory ItemsListProductGROUPCategory.fromJson(Map<String, dynamic> json) {
    return ItemsListProductGROUPCategory(
      PRODUCT_GROUP_ID: json['PRODUCT_GROUP_ID'],
      PRODUCT_GROUP_CODE: json['PRODUCT_GROUP_CODE'],
      PRODUCT_GROUP_NAME: json['PRODUCT_GROUP_NAME'],
      PRODUCT_CATEGORY_ID: json['PRODUCT_CATEGORY_ID'],
      PRODUCT_CATEGORY_CODE: json['PRODUCT_CATEGORY_CODE'],
      PRODUCT_CATEGORY_NAME: json['PRODUCT_CATEGORY_NAME'],
    );
  }
}