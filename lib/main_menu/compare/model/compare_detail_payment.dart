
class ItemsCompareDetailPayment {
  final int PAYMENT_ID;
  final int COMPARE_DETAIL_ID;
  final int PAYMENT_TYPE;
  final double PAYMENT_FINE;
  final String REFFERENCE_NO;
  final int IS_ACTIVE;

  ItemsCompareDetailPayment({
    this.PAYMENT_ID,
    this.COMPARE_DETAIL_ID,
    this.PAYMENT_TYPE,
    this.PAYMENT_FINE,
    this.REFFERENCE_NO,
    this.IS_ACTIVE,
  });

  factory ItemsCompareDetailPayment.fromJson(Map<String, dynamic> json) {
    return ItemsCompareDetailPayment(
      PAYMENT_ID: json['PAYMENT_ID'],
      COMPARE_DETAIL_ID: json['COMPARE_DETAIL_ID'],
      PAYMENT_TYPE: json['PAYMENT_TYPE'],
      PAYMENT_FINE: json['PAYMENT_FINE'],
      REFFERENCE_NO: json['REFFERENCE_NO'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}