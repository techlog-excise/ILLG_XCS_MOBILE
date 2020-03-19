class ItemsListProductCategoryRDB {

  final String PRODUCT_CODE;
  final String CATEGORY_GROUP_CODE;
  final String CATEGORY_GROUP_DESC;
  final String CATEGORY_CODE;
  final String CATEGORY_DESC;

  ItemsListProductCategoryRDB({
    this.PRODUCT_CODE,
    this.CATEGORY_GROUP_CODE,
    this.CATEGORY_GROUP_DESC,
    this.CATEGORY_CODE,
    this.CATEGORY_DESC,
  });

  factory ItemsListProductCategoryRDB.fromJson(Map<String, dynamic> json) {
    return ItemsListProductCategoryRDB(
      PRODUCT_CODE: json['PRODUCT_CODE'],
      CATEGORY_GROUP_CODE: json['CATEGORY_GROUP_CODE'],
      CATEGORY_GROUP_DESC: json['CATEGORY_GROUP_DESC'],
      CATEGORY_CODE: json['CATEGORY_CODE'],
      CATEGORY_DESC: json['CATEGORY_DESC'],
    );
  }
}