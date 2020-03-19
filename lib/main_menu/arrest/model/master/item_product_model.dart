class ItemsListProductModel {
  final int PRODUCT_MODEL_ID;
  final String PRODUCT_MODEL_CODE;
  final String PRODUCT_MODEL_NAME_TH;
  final String PRODUCT_MODEL_NAME_EN;
  final int IS_ACTIVE;

  ItemsListProductModel({
    this.PRODUCT_MODEL_ID,
    this.PRODUCT_MODEL_CODE,
    this.PRODUCT_MODEL_NAME_TH,
    this.PRODUCT_MODEL_NAME_EN,
    this.IS_ACTIVE,
  });

  factory ItemsListProductModel.fromJson(Map<String, dynamic> json) {
    return ItemsListProductModel(
      PRODUCT_MODEL_ID: json['PRODUCT_MODEL_ID'],
      PRODUCT_MODEL_CODE: json['PRODUCT_MODEL_CODE'],
      PRODUCT_MODEL_NAME_TH: json['PRODUCT_MODEL_NAME_TH'],
      PRODUCT_MODEL_NAME_EN: json['PRODUCT_MODEL_NAME_EN'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}