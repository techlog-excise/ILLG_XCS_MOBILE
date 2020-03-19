
class ItemsListPersonNetLawbreakerDetail {
  final int ARREST_ID;
  final String ARREST_CODE;
  final int LAWSUIT_ID;
  final int LAWSUIT_NO;
  final String LAWSUIT_NO_YEAR;
  final String OCCURRENCE_DATE;
  final int SECTION_ID;
  final String GUILTBASE_NAME;
  final String LOCALE_ADDRESS;
  final String PRODUCT_GROUP_NAME;
  final String ARREST_STAFF_NAME;
  final String ARREST_STAFF_OFFICE_NAME;
  final String LAWSUIT_STAFF_NAME;
  final String LAWSUIT_STAFF_OFFICE_NAME;
  final dynamic PAYMENT_FINE;
  final int COMPARE_NO;
  final String COMPARE_NO_YEAR;
  final String LAWSUIT_END;

  final String COMPARE_IS_OUTSIDE;
  final String LAWSUIT_IS_OUTSIDE;
  final dynamic  SUBSECTION_NAME;

  ItemsListPersonNetLawbreakerDetail({
    this.ARREST_ID,
    this.ARREST_CODE,
    this.LAWSUIT_ID,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.OCCURRENCE_DATE,
    this.SECTION_ID,
    this.GUILTBASE_NAME,
    this.LOCALE_ADDRESS,
    this.PRODUCT_GROUP_NAME,
    this.ARREST_STAFF_NAME,
    this.ARREST_STAFF_OFFICE_NAME,
    this.LAWSUIT_STAFF_NAME,
    this.LAWSUIT_STAFF_OFFICE_NAME,
    this.PAYMENT_FINE,
    this.COMPARE_NO,
    this.COMPARE_NO_YEAR,
    this.LAWSUIT_END,

    this.COMPARE_IS_OUTSIDE,
    this.LAWSUIT_IS_OUTSIDE,
    this.SUBSECTION_NAME
  });

  factory ItemsListPersonNetLawbreakerDetail.fromJson(Map<String, dynamic> js) {
    return ItemsListPersonNetLawbreakerDetail(
      ARREST_ID: js['ARREST_ID'],
      ARREST_CODE: js['ARREST_CODE'],
      LAWSUIT_ID: js['LAWSUIT_ID'],
      LAWSUIT_NO: js['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: js['LAWSUIT_NO_YEAR'],
      OCCURRENCE_DATE: js['OCCURRENCE_DATE'],
      SECTION_ID: js['SECTION_ID'],
      GUILTBASE_NAME: js['GUILTBASE_NAME'],
      LOCALE_ADDRESS: js['LOCALE_ADDRESS'],
      PRODUCT_GROUP_NAME: js['PRODUCT_GROUP_NAME'],
      ARREST_STAFF_NAME: js['ARREST_STAFF_NAME'],
      ARREST_STAFF_OFFICE_NAME: js['ARREST_STAFF_OFFICE_NAME'],
      LAWSUIT_STAFF_NAME: js['LAWSUIT_STAFF_NAME'],
      LAWSUIT_STAFF_OFFICE_NAME: js['LAWSUIT_STAFF_OFFICE_NAME'],
      PAYMENT_FINE: js['PAYMENT_FINE'],
      COMPARE_NO: js['COMPARE_NO'],
      COMPARE_NO_YEAR:  js['COMPARE_NO_YEAR'],
      LAWSUIT_END:  js['LAWSUIT_END'],

      COMPARE_IS_OUTSIDE: js['COMPARE_IS_OUTSIDE'],
      LAWSUIT_IS_OUTSIDE:  js['LAWSUIT_IS_OUTSIDE'],
      SUBSECTION_NAME: js['SUBSECTION_NAME'],
    );
  }
}