
class ItemsArrestResponseIndicment {
  final String IsSuccess;
  final String Msg;
  final List<ItemsArrestIndictment> ArrestIndictment;

  ItemsArrestResponseIndicment({
    this.IsSuccess,
    this.Msg,
    this.ArrestIndictment,
  });

  factory ItemsArrestResponseIndicment.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseIndicment(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      ArrestIndictment: json['IsSuccess']=="True"
          ?List<ItemsArrestIndictment>.from(
          json['ArrestIndictment'].map((m) =>
              ItemsArrestIndictment.fromJson(m)))
          :null,
    );
  }
}
class ItemsArrestIndictment {
  final int INDICTMENT_ID;
  final List<ItemsArrestIndictmentProduct>ArrestIndictmentProduct;
  final List<ItemsArrestIndictmentDetail> ArrestIndictmentDetail;

  ItemsArrestIndictment({
    this.INDICTMENT_ID,
    this.ArrestIndictmentProduct,
    this.ArrestIndictmentDetail,
  });

  factory ItemsArrestIndictment.fromJson(Map<String, dynamic> json) {
    return ItemsArrestIndictment(
      INDICTMENT_ID: json['INDICTMENT_ID'],
      ArrestIndictmentProduct: json['ArrestIndictmentProduct']!=null
          ?List<ItemsArrestIndictmentProduct>.from(json['ArrestIndictmentProduct'].map((m) => ItemsArrestIndictmentProduct.fromJson(m))):[],
      ArrestIndictmentDetail: List<ItemsArrestIndictmentDetail>.from(
          json['ArrestIndictmentDetail'].map((m) =>
              ItemsArrestIndictmentDetail.fromJson(m))),
    );
  }
}
class ItemsArrestIndictmentProduct {
  final int PRODUCT_INDICTMENT_ID;

  ItemsArrestIndictmentProduct({
    this.PRODUCT_INDICTMENT_ID,
  });

  factory ItemsArrestIndictmentProduct.fromJson(Map<String, dynamic> json) {
    return ItemsArrestIndictmentProduct(
      PRODUCT_INDICTMENT_ID: json['PRODUCT_INDICTMENT_ID'],
    );
  }
}
class ItemsArrestIndictmentDetail {
  final int INDICTMENT_DETAIL_ID;

  ItemsArrestIndictmentDetail({
    this.INDICTMENT_DETAIL_ID,
  });

  factory ItemsArrestIndictmentDetail.fromJson(Map<String, dynamic> json) {
    return ItemsArrestIndictmentDetail(
      INDICTMENT_DETAIL_ID: json['INDICTMENT_DETAIL_ID'],
    );
  }
}


class ItemsArrestResponseIndicmentDetail {
  final String IsSuccess;
  final String Msg;
  final List<ItemsArrestIndictmentDetail> ArrestIndictmentDetail;

  ItemsArrestResponseIndicmentDetail({
    this.IsSuccess,
    this.Msg,
    this.ArrestIndictmentDetail,
  });

  factory ItemsArrestResponseIndicmentDetail.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseIndicmentDetail(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      ArrestIndictmentDetail: json['IsSuccess']=="True"
          ?List<ItemsArrestIndictmentDetail>.from(
          json['ArrestIndictmentDetail'].map((m) =>
              ItemsArrestIndictmentDetail.fromJson(m)))
          :null,
    );
  }
}