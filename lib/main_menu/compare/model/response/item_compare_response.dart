
class ItemsArrestResponseInsAll {
  final String IsSuccess;
  final String Msg;
  final int COMPARE_ID;
  final List<ItemsArrestResponseCompareMapping> CompareMapping;
  final List<ItemsArrestResponseCompareStaff> CompareStaff;

  ItemsArrestResponseInsAll({
    this.IsSuccess,
    this.Msg,
    this.COMPARE_ID,
    this.CompareMapping,
    this.CompareStaff,
  });

  factory ItemsArrestResponseInsAll.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseInsAll(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      COMPARE_ID: json['COMPARE_ID'],
      CompareMapping: List<ItemsArrestResponseCompareMapping>.from(json['CompareMapping'].map((m) => ItemsArrestResponseCompareMapping.fromJson(m))),
      CompareStaff: List<ItemsArrestResponseCompareStaff>.from(json['CompareStaff'].map((m) => ItemsArrestResponseCompareStaff.fromJson(m))),
    );
  }
}

class ItemsArrestResponseCompareMapping {
  final int COMPARE_MAPPING_ID;
  final List<ItemsArrestResponseCompareDetail> CompareDetail;
  ItemsArrestResponseCompareMapping({
    this.CompareDetail,
    this.COMPARE_MAPPING_ID,
  });
  factory ItemsArrestResponseCompareMapping.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseCompareMapping(
      COMPARE_MAPPING_ID: json['COMPARE_MAPPING_ID'],
      CompareDetail: List<ItemsArrestResponseCompareDetail>.from(json['CompareDetail'].map((m) => ItemsArrestResponseCompareDetail.fromJson(m))),
    );
  }
}
class ItemsArrestResponseCompareDetail {
  final int COMPARE_DETAIL_ID;
  final List<ItemsArrestResponseCompareDetailPayment> CompareDetailPayment;
  final List<ItemsArrestResponseCompareDetailFine> CompareDetailFine;
  final List<ItemsArrestResponseComparePayment> ComparePayment;
  ItemsArrestResponseCompareDetail({
    this.COMPARE_DETAIL_ID,
    this.CompareDetailPayment,
    this.CompareDetailFine,
    this.ComparePayment,
  });
  factory ItemsArrestResponseCompareDetail.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseCompareDetail(
      COMPARE_DETAIL_ID: json['COMPARE_DETAIL_ID'],
      CompareDetailPayment: List<ItemsArrestResponseCompareDetailPayment>.from(json['CompareDetailPayment'].map((m) => ItemsArrestResponseCompareDetailPayment.fromJson(m))),
      CompareDetailFine: List<ItemsArrestResponseCompareDetailFine>.from(json['CompareDetailFine'].map((m) => ItemsArrestResponseCompareDetailFine.fromJson(m))),
      ComparePayment: List<ItemsArrestResponseComparePayment>.from(json['ComparePayment'].map((m) => ItemsArrestResponseComparePayment.fromJson(m))),
    );
  }
}
class ItemsArrestResponseCompareDetailPayment {
  final int PAYMENT_ID;
  ItemsArrestResponseCompareDetailPayment({
    this.PAYMENT_ID,
  });
  factory ItemsArrestResponseCompareDetailPayment.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseCompareDetailPayment(
      PAYMENT_ID: json['PAYMENT_ID'],
    );
  }
}
class ItemsArrestResponseCompareDetailFine {
  final int FINE_ID;
  ItemsArrestResponseCompareDetailFine({
    this.FINE_ID,
  });
  factory ItemsArrestResponseCompareDetailFine.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseCompareDetailFine(
      FINE_ID: json['FINE_ID'],
    );
  }
}
class ItemsArrestResponseComparePayment {
  final int PAYMENT_ID;
  final List<ItemsArrestResponseComparePaymentDetail> ComparePaymentDetail;
  ItemsArrestResponseComparePayment({
    this.PAYMENT_ID,
    this.ComparePaymentDetail,
  });
  factory ItemsArrestResponseComparePayment.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseComparePayment(
      PAYMENT_ID: json['PAYMENT_ID'],
      //ComparePaymentDetail: List<ItemsArrestResponseComparePaymentDetail>.from(json['ComparePaymentDetail'].map((m) => ItemsArrestResponseComparePaymentDetail.fromJson(m))),
    );
  }
}
class ItemsArrestResponseComparePaymentDetail {
  final int PAYMENT_DETAIL_ID;
  ItemsArrestResponseComparePaymentDetail({
    this.PAYMENT_DETAIL_ID,
  });
  factory ItemsArrestResponseComparePaymentDetail.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseComparePaymentDetail(
      PAYMENT_DETAIL_ID: json['PAYMENT_DETAIL_ID'],
    );
  }
}


class ItemsArrestResponseCompareStaff {
  final int STAFF_ID;
  ItemsArrestResponseCompareStaff({
    this.STAFF_ID,
  });
  factory ItemsArrestResponseCompareStaff.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseCompareStaff(
      STAFF_ID: json['STAFF_ID'],
    );
  }
}


class ItemsArrestResponseMessageCompareDetailPayment {
  final String IsSuccess;
  final String Msg;
  final List<ItemsArrestResponseCompareDetailPayment> CompareDetailPayment;
  ItemsArrestResponseMessageCompareDetailPayment({
    this.IsSuccess,
    this.Msg,
    this.CompareDetailPayment,
  });
  factory ItemsArrestResponseMessageCompareDetailPayment.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseMessageCompareDetailPayment(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      CompareDetailPayment: List<ItemsArrestResponseCompareDetailPayment>.from(json['CompareDetailPayment'].map((m) => ItemsArrestResponseCompareDetailPayment.fromJson(m))),
    );
  }
}
class ItemsArrestResponseMessageCompareDetailFine {
  final String IsSuccess;
  final String Msg;
  final List<ItemsArrestResponseCompareDetailFine> CompareDetailFine;
  ItemsArrestResponseMessageCompareDetailFine({
    this.IsSuccess,
    this.Msg,
    this.CompareDetailFine,
  });
  factory ItemsArrestResponseMessageCompareDetailFine.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseMessageCompareDetailFine(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      CompareDetailFine: List<ItemsArrestResponseCompareDetailFine>.from(json['CompareDetailFine'].map((m) => ItemsArrestResponseCompareDetailFine.fromJson(m))),
    );
  }
}
class ItemsArrestResponseMessageComparePayment {
  final String IsSuccess;
  final String Msg;
  final List<ItemsArrestResponseComparePayment> ComparePayment;
  ItemsArrestResponseMessageComparePayment({
    this.IsSuccess,
    this.Msg,
    this.ComparePayment,
  });
  factory ItemsArrestResponseMessageComparePayment.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseMessageComparePayment(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      ComparePayment: List<ItemsArrestResponseComparePayment>.from(json['ComparePayment'].map((m) => ItemsArrestResponseComparePayment.fromJson(m))),
    );
  }
}


