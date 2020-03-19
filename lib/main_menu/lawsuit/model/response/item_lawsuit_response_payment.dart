

class ItemsArrestResponsePaymentMessage {
  final String IsSuccess;
  final String Msg;
  final List<ItemsArrestLawsuitPayment> LawsuitPayment;

  ItemsArrestResponsePaymentMessage({
    this.IsSuccess,
    this.Msg,
    this.LawsuitPayment,
  });

  factory ItemsArrestResponsePaymentMessage.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponsePaymentMessage(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      LawsuitPayment: List.from(json['LawsuitPayment'].map((m) => ItemsArrestLawsuitPayment.fromJson(m))),
    );
  }
}
class ItemsArrestLawsuitPayment {
  final int PAYMENT_ID ;
  final List<ItemsArrestLawsuitPaymentDetail> LawsuitPaymentDetail;

  ItemsArrestLawsuitPayment({
    this.PAYMENT_ID,
    this.LawsuitPaymentDetail,
  });

  factory ItemsArrestLawsuitPayment.fromJson(Map<String, dynamic> json) {
    return ItemsArrestLawsuitPayment(
      PAYMENT_ID: json['PAYMENT_ID'],
      LawsuitPaymentDetail: List.from(json['LawsuitPaymentDetail'].map((m) => ItemsArrestLawsuitPaymentDetail.fromJson(m))),
    );
  }
}
class ItemsArrestLawsuitPaymentDetail {
  final int PAYMENT_DETAIL_ID ;

  ItemsArrestLawsuitPaymentDetail({
    this.PAYMENT_DETAIL_ID,
  });

  factory ItemsArrestLawsuitPaymentDetail.fromJson(Map<String, dynamic> json) {
    return ItemsArrestLawsuitPaymentDetail(
      PAYMENT_DETAIL_ID: json['PAYMENT_DETAIL_ID'],
    );
  }
}
