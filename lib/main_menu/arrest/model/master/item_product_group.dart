class ItemsListProductGroup {
  final int PRODUCT_GROUP_ID;
  final String PRODUCT_GROUP_CODE;
  final String PRODUCT_GROUP_NAME;
  final int IS_ACTIVE;

  ItemsListProductGroup({
    this.PRODUCT_GROUP_ID,
    this.PRODUCT_GROUP_CODE,
    this.PRODUCT_GROUP_NAME,
    this.IS_ACTIVE,
  });

  factory ItemsListProductGroup.fromJson(Map<String, dynamic> json) {
    return ItemsListProductGroup(
      PRODUCT_GROUP_ID: json['PRODUCT_GROUP_ID'],
      PRODUCT_GROUP_CODE: json['PRODUCT_GROUP_CODE'],
      PRODUCT_GROUP_NAME: json['PRODUCT_GROUP_NAME'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}