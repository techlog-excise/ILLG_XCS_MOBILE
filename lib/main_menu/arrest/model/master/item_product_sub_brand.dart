class ItemsListProductSubBrand {
  final int PRODUCT_SUBBRAND_ID;
  final String PRODUCT_SUBBRAND_CODE;
  final String PRODUCT_SUBBRAND_NAME_TH;
  final String PRODUCT_SUBBRAND_NAME_EN;
  final int IS_ACTIVE;

  ItemsListProductSubBrand({
    this.PRODUCT_SUBBRAND_ID,
    this.PRODUCT_SUBBRAND_CODE,
    this.PRODUCT_SUBBRAND_NAME_TH,
    this.PRODUCT_SUBBRAND_NAME_EN,
    this.IS_ACTIVE,
  });

  factory ItemsListProductSubBrand.fromJson(Map<String, dynamic> json) {
    return ItemsListProductSubBrand(
      PRODUCT_SUBBRAND_ID: json['PRODUCT_SUBBRAND_ID'],
      PRODUCT_SUBBRAND_CODE: json['PRODUCT_SUBBRAND_CODE'],
      PRODUCT_SUBBRAND_NAME_TH: json['PRODUCT_SUBBRAND_NAME_TH'],
      PRODUCT_SUBBRAND_NAME_EN: json['PRODUCT_SUBBRAND_NAME_EN'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}