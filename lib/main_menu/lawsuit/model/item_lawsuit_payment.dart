
import 'item_lawsuit_payment_detail.dart';

class ItemsListLawsuitPayment{
  final int PAYMENT_ID;
  final int LAWSUIT_DETAIL_ID;
  final int COMPARE_DETAIL_ID;
  final int FINE_TYPE;
  final double FINE;
  final int PAYMENT_PERIOD_NO;
  final String PAYMENT_DATE;
  final int IS_REQUEST_REWARD;
  final int IS_ACTIVE;
  final List<ItemsListLawsuitPaymentDetail> LawsuitPaymentDetail;
  ItemsListLawsuitPayment({
    this.PAYMENT_ID,
    this.LAWSUIT_DETAIL_ID,
    this.COMPARE_DETAIL_ID,
    this.FINE_TYPE,
    this.FINE,
    this.PAYMENT_PERIOD_NO,
    this.PAYMENT_DATE,
    this.IS_REQUEST_REWARD,
    this.IS_ACTIVE,
    this.LawsuitPaymentDetail,
  });

  factory ItemsListLawsuitPayment.fromJson(Map<String, dynamic> js) {
    return ItemsListLawsuitPayment(
        PAYMENT_ID: js['PAYMENT_ID'],
        LAWSUIT_DETAIL_ID: js['LAWSUIT_DETAIL_ID'],
        COMPARE_DETAIL_ID: js['COMPARE_DETAIL_ID'],
        FINE_TYPE: js['FINE_TYPE'],
        FINE: js['FINE'],
        PAYMENT_PERIOD_NO: js['PAYMENT_PERIOD_NO'],
        PAYMENT_DATE: js['PAYMENT_DATE'],
        IS_REQUEST_REWARD: js['IS_REQUEST_REWARD'],
        IS_ACTIVE: js['IS_ACTIVE'],
        LawsuitPaymentDetail: List.from(js['LawsuitPaymentDetail'].map((m) => ItemsListLawsuitPaymentDetail.fromJson(m))),
    );
  }
}