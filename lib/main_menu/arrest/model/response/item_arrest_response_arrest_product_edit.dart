class ItemsArrestResponseProductEdit {
  final String IsSuccess;
  final String Msg;
  final List<ItemsResponseArrestProduct> ArrestProduct;

  ItemsArrestResponseProductEdit({
    this.IsSuccess,
    this.Msg,
    this.ArrestProduct,
  });

  factory ItemsArrestResponseProductEdit.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseProductEdit(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      ArrestProduct: List<ItemsResponseArrestProduct>.from(json['ArrestProduct'].map((m) => ItemsResponseArrestProduct.fromJson(m))),
    );
  }
}

class ItemsResponseArrestProduct {
  final int PRODUCT_ID;
  final int PRODUCT_MAPPING_ID;
  final String PRODUCT_REF_CODE;

  ItemsResponseArrestProduct({
    this.PRODUCT_ID,
    this.PRODUCT_MAPPING_ID,
    this.PRODUCT_REF_CODE,
  });

  factory ItemsResponseArrestProduct.fromJson(Map<String, dynamic> json) {
    return ItemsResponseArrestProduct(
      PRODUCT_ID: json['PRODUCT_ID'],
      PRODUCT_MAPPING_ID: json['PRODUCT_MAPPING_ID'],
      PRODUCT_REF_CODE: json['PRODUCT_REF_CODE'],
    );
  }
}
