class ItemsListLawsuitPaymentDetail{
  final int PAYMENT_DETAIL_ID;
  final int PAYMENT_ID;
  final int NOTICE_ID;
  final int IS_REQUEST_BRIBE;
  int IS_ACTIVE;
  ItemsListLawsuitPaymentDetail({
    this.PAYMENT_DETAIL_ID,
    this.PAYMENT_ID,
    this.NOTICE_ID,
    this.IS_REQUEST_BRIBE,
    this.IS_ACTIVE,
  });

  factory ItemsListLawsuitPaymentDetail.fromJson(Map<String, dynamic> js) {
    return ItemsListLawsuitPaymentDetail(
        PAYMENT_DETAIL_ID: js['PAYMENT_DETAIL_ID'],
        PAYMENT_ID: js['PAYMENT_ID'],
        NOTICE_ID: js['NOTICE_ID'],
        IS_REQUEST_BRIBE: js['IS_REQUEST_BRIBE'],
        IS_ACTIVE: js['IS_ACTIVE'],
    );
  }
}