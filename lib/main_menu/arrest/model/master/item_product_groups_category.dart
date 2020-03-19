class ItemsListProductGroupCategory {
  final String CATEGORY_GROUP_DESC;
  final String CATEGORY_GROUP_CODE;
  final String PRODUCT_CODE;
  final int IS_ACTIVE;

  ItemsListProductGroupCategory({
    this.CATEGORY_GROUP_DESC,
    this.CATEGORY_GROUP_CODE,
    this.PRODUCT_CODE,
    this.IS_ACTIVE,
  });

  factory ItemsListProductGroupCategory.fromJson(Map<String, dynamic> json) {
    return ItemsListProductGroupCategory(
      CATEGORY_GROUP_DESC: json['CATEGORY_GROUP_DESC'],
      CATEGORY_GROUP_CODE: json['CATEGORY_GROUP_CODE'],
      PRODUCT_CODE: json['PRODUCT_CODE'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}