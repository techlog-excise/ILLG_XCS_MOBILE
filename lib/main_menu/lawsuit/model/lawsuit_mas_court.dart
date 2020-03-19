
class ItemsLawsuitMasCourt {
  final int COURT_ID;
  final String COURT_CODE;
  final String COURT_NAME;
  final String EFFECTIVE_DATE;
  final String EXPIRE_DATE;
  final int IS_ACTIVE;
  final String PROVINCE_NAME;

  ItemsLawsuitMasCourt({
    this.COURT_ID,
    this.COURT_CODE,
    this.COURT_NAME,
    this.EFFECTIVE_DATE,
    this.EXPIRE_DATE,
    this.IS_ACTIVE,
    this.PROVINCE_NAME,
  });

  factory ItemsLawsuitMasCourt.fromJson(Map<String, dynamic> js) {
    return ItemsLawsuitMasCourt(
      COURT_ID: js['COURT_ID'],
      COURT_CODE: js['COURT_CODE'],
      COURT_NAME:  js['COURT_NAME'],
      EFFECTIVE_DATE: js['EFFECTIVE_DATE'],
      EXPIRE_DATE: js['EXPIRE_DATE'],
      IS_ACTIVE: js['IS_ACTIVE'],
      PROVINCE_NAME: js['PROVINCE_NAME'],
    );
  }
}