class ItemsComparePayment {
  final int PAYMENT_DETAIL_ID;
  final int PAYMENT_ID;
  final int NOTICE_ID;
  final double IS_REQUEST_BRIBE;
  final int IS_ACTIVE;

  ItemsComparePayment({
    this.PAYMENT_DETAIL_ID,
    this.PAYMENT_ID,
    this.NOTICE_ID,
    this.IS_REQUEST_BRIBE,
    this.IS_ACTIVE,
  });

  factory ItemsComparePayment.fromJson(Map<String, dynamic> json) {
    return ItemsComparePayment(
      PAYMENT_DETAIL_ID: json['PAYMENT_DETAIL_ID'],
      PAYMENT_ID: json['PAYMENT_ID'],
      NOTICE_ID: json['NOTICE_ID'],
      IS_REQUEST_BRIBE: json['IS_REQUEST_BRIBE'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}