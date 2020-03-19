
class ItemsArrestResponseArrestProduct {
  final String IsSuccess;
  final String Msg;
  final List<ItemsResponseArrestProduct> ArrestProduct;

  ItemsArrestResponseArrestProduct({
    this.IsSuccess,
    this.Msg,
    this.ArrestProduct,
  });

  factory ItemsArrestResponseArrestProduct.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseArrestProduct(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      ArrestProduct: List<ItemsResponseArrestProduct>.from(
          json['ArrestProduct'].map((m) =>
              ItemsResponseArrestProduct.fromJson(m))),
    );
  }
}
class ItemsResponseArrestProduct {
  final int PRODUCT_ID;
  final List<ItemsResponseArrestProductMapping> ArrestProductMapping;

  ItemsResponseArrestProduct({
    this.PRODUCT_ID,
    this.ArrestProductMapping,
  });

  factory ItemsResponseArrestProduct.fromJson(Map<String, dynamic> json) {
    return ItemsResponseArrestProduct(
      PRODUCT_ID: json['PRODUCT_ID'],
      ArrestProductMapping: List<ItemsResponseArrestProductMapping>.from(
          json['ArrestProductMapping'].map((m) =>
              ItemsResponseArrestProductMapping.fromJson(m))),
    );
  }
}
class ItemsResponseArrestProductMapping {
  final int PRODUCT_MAPPING_ID;

  ItemsResponseArrestProductMapping({
    this.PRODUCT_MAPPING_ID,
  });

  factory ItemsResponseArrestProductMapping.fromJson(Map<String, dynamic> json) {
    return ItemsResponseArrestProductMapping(
      PRODUCT_MAPPING_ID: json['PRODUCT_MAPPING_ID'],
    );
  }
}