class ItemsListProductBrand {
  final int PRODUCT_BRAND_ID;
  final String PRODUCT_BRAND_CODE;
  final String PRODUCT_BRAND_NAME_TH;
  final String PRODUCT_BRAND_NAME_EN;
  final int IS_ACTIVE;

  ItemsListProductBrand({
    this.PRODUCT_BRAND_ID,
    this.PRODUCT_BRAND_CODE,
    this.PRODUCT_BRAND_NAME_TH,
    this.PRODUCT_BRAND_NAME_EN,
    this.IS_ACTIVE,
  });

  factory ItemsListProductBrand.fromJson(Map<String, dynamic> json) {
    return ItemsListProductBrand(
      PRODUCT_BRAND_ID: json['PRODUCT_BRAND_ID'],
      PRODUCT_BRAND_CODE: json['PRODUCT_BRAND_CODE'],
      PRODUCT_BRAND_NAME_TH: json['PRODUCT_BRAND_NAME_TH'],
      PRODUCT_BRAND_NAME_EN: json['PRODUCT_BRAND_NAME_EN'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}