class ItemsArrestResponse {
  final String IsSuccess;
  final String Msg;
  final int ARREST_ID;
  final List<ItemsArrestResponseArrestStaff> ArrestStaff;
  final List<ItemsArrestResponseArrestLocale> ArrestLocale;
  final List<ItemsArrestResponseArrestLawbreaker> ArrestLawbreaker;
  final List<ItemsArrestResponseArrestProduct> ArrestProduct;

  ItemsArrestResponse({
    this.IsSuccess,
    this.Msg,
    this.ARREST_ID,
    this.ArrestStaff,
    this.ArrestLocale,
    this.ArrestLawbreaker,
    this.ArrestProduct,
  });

  factory ItemsArrestResponse.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponse(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      ARREST_ID: json['ARREST_ID'],
      ArrestStaff: json['IsSuccess'].toString().endsWith("True")
          ?List<ItemsArrestResponseArrestStaff>.from(json['ArrestStaff'].map((m) => ItemsArrestResponseArrestStaff.fromJson(m)))
          :[],
      ArrestLocale: json['IsSuccess'].toString().endsWith("True")
          ?List<ItemsArrestResponseArrestLocale>.from(json['ArrestLocale'].map((m) => ItemsArrestResponseArrestLocale.fromJson(m)))
          :[],
      ArrestLawbreaker: json['IsSuccess'].toString().endsWith("True")
          ?List<ItemsArrestResponseArrestLawbreaker>.from(json['ArrestLawbreaker'].map((m) => ItemsArrestResponseArrestLawbreaker.fromJson(m)))
          :[],
      ArrestProduct: json['IsSuccess'].toString().endsWith("True")
          ?List<ItemsArrestResponseArrestProduct>.from(json['ArrestProduct'].map((m) => ItemsArrestResponseArrestProduct.fromJson(m)))
          :[],
    );
  }
}
class ItemsArrestResponseArrestStaff {
  final int STAFF_ID;

  ItemsArrestResponseArrestStaff({
    this.STAFF_ID,
  });

  factory ItemsArrestResponseArrestStaff.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseArrestStaff(
      STAFF_ID: json['STAFF_ID'],
    );
  }
}
class ItemsArrestResponseArrestLocale {
  final int LOCALE_ID;

  ItemsArrestResponseArrestLocale({
    this.LOCALE_ID,
  });

  factory ItemsArrestResponseArrestLocale.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseArrestLocale(
      LOCALE_ID: json['LOCALE_ID'],
    );
  }
}
class ItemsArrestResponseArrestLawbreaker {
  final int LAWBREAKER_ID;

  ItemsArrestResponseArrestLawbreaker({
    this.LAWBREAKER_ID,
  });

  factory ItemsArrestResponseArrestLawbreaker.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseArrestLawbreaker(
      LAWBREAKER_ID: json['LAWBREAKER_ID'],
    );
  }
}
class ItemsArrestResponseArrestProduct {
  final int PRODUCT_ID;
  List<ItemsArrestResponseArrestProductMapping> ArrestProductMapping;

  ItemsArrestResponseArrestProduct({
    this.PRODUCT_ID,
    this.ArrestProductMapping,
  });

  factory ItemsArrestResponseArrestProduct.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseArrestProduct(
      PRODUCT_ID: json['PRODUCT_ID'],
      ArrestProductMapping: List<ItemsArrestResponseArrestProductMapping>.from(json['ArrestProductMapping'].map((m) => ItemsArrestResponseArrestProductMapping.fromJson(m)))
    );
  }
}
class ItemsArrestResponseArrestProductMapping {
  final int PRODUCT_MAPPING_ID;

  ItemsArrestResponseArrestProductMapping({
    this.PRODUCT_MAPPING_ID,
  });

  factory ItemsArrestResponseArrestProductMapping.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseArrestProductMapping(
      PRODUCT_MAPPING_ID: json['PRODUCT_MAPPING_ID'],
    );
  }
}