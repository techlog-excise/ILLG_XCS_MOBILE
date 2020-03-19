class ItemsListProductMapping{
  final int PRODUCT_MAPPING_ID;
  final int PRODUCT_CODE;
  final String PRODUCT_REF_CODE;
  final String PRODUCT_GROUP_ID;
  final int IS_ACTIVE;

  ItemsListProductMapping({
    this.PRODUCT_MAPPING_ID,
    this.PRODUCT_CODE,
    this.PRODUCT_REF_CODE,
    this.PRODUCT_GROUP_ID,
    this.IS_ACTIVE,
  });

  factory ItemsListProductMapping.fromJson(Map<String, dynamic> json) {
    return ItemsListProductMapping(
      PRODUCT_MAPPING_ID: json['PRODUCT_MAPPING_ID'],
      PRODUCT_CODE: json['PRODUCT_CODE'],
      PRODUCT_REF_CODE: json['PRODUCT_REF_CODE'],
      PRODUCT_GROUP_ID: json['PRODUCT_GROUP_ID'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}