
class ItemsListPersonNetForeignerInfor {
  final String PASSPORT_NO;
  final String COUNTRY_NAME_TH;
  final String PASSPORT_DATE_IN;
  final String PASSPORT_DATE_OUT;
  final String VISA_TYPE;

  ItemsListPersonNetForeignerInfor({
    this.PASSPORT_NO,
    this.COUNTRY_NAME_TH,
    this.PASSPORT_DATE_IN,
    this.PASSPORT_DATE_OUT,
    this.VISA_TYPE,
  });

  factory ItemsListPersonNetForeignerInfor.fromJson(Map<String, dynamic> js) {
    return ItemsListPersonNetForeignerInfor(
      PASSPORT_NO: js['PASSPORT_NO'],
      COUNTRY_NAME_TH: js['COUNTRY_NAME_TH'],
      PASSPORT_DATE_IN: js['PASSPORT_DATE_IN'],
      PASSPORT_DATE_OUT: js['PASSPORT_DATE_OUT'],
      VISA_TYPE: js['VISA_TYPE'],
    );
  }
}