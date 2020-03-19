
class ItemsProveList {
  final int PROVE_ID;
  final int IS_OUTSIDE;
  final String PROVE_NO;
  final String RECEIVE_DOC_DATE;
  final String RECEIVE_OFFICE_NAME;
  final String PROVE_STAFF_NAME;
  final int ARREST_ID;
  final String ARREST_CODE;
  final String ARREST_DATE;
  final String ARREST_STAFF_NAME;
  final String ARREST_OFFICE_NAME;
  final String SECTION_NAME;
  final String GUILTBASE_NAME;
  final int LAWSUIT_ID;
  final String LAWSUIT_NO;
  final String LAWSUIT_NO_YEAR;
  final String LAWSUIT_DATE;
  final String LAWSUIT_OFFICE_NAME;
  final String LAWSUIT_STAFF_NAME;
  int LAWSUIT_IS_OUTSIDE;
  int GUILTBASE_ID;
  int PROVE_TYPE;


  ItemsProveList({
    this.PROVE_ID,
    this.IS_OUTSIDE,
    this.PROVE_NO,
    this.RECEIVE_DOC_DATE,
    this.RECEIVE_OFFICE_NAME,
    this.PROVE_STAFF_NAME,
    this.ARREST_ID,
    this.ARREST_CODE,
    this.ARREST_DATE,
    this.ARREST_STAFF_NAME,
    this.ARREST_OFFICE_NAME,
    this.SECTION_NAME,
    this.GUILTBASE_NAME,
    this.LAWSUIT_ID,
    this.LAWSUIT_NO,
    this.LAWSUIT_NO_YEAR,
    this.LAWSUIT_DATE,
    this.LAWSUIT_OFFICE_NAME,
    this.LAWSUIT_STAFF_NAME,
    this.LAWSUIT_IS_OUTSIDE,
    this.GUILTBASE_ID,
    this.PROVE_TYPE,
  });

  factory ItemsProveList.fromJson(Map<String, dynamic> json) {
    return ItemsProveList(
      LAWSUIT_IS_OUTSIDE: json['LAWSUIT_IS_OUTSIDE'],
      PROVE_ID: json['PROVE_ID'],
      IS_OUTSIDE: json['IS_OUTSIDE'],
      PROVE_NO: json['PROVE_NO'],
      RECEIVE_DOC_DATE: json['RECEIVE_DOC_DATE'],
      RECEIVE_OFFICE_NAME: json['RECEIVE_OFFICE_NAME'],
      PROVE_STAFF_NAME: json['PROVE_STAFF_NAME'],
      ARREST_ID: json['ARREST_ID'],
      ARREST_CODE: json['ARREST_CODE'],
      ARREST_DATE: json['ARREST_DATE'],
      ARREST_STAFF_NAME: json['ARREST_STAFF_NAME'],
      ARREST_OFFICE_NAME: json['ARREST_OFFICE_NAME'],
      SECTION_NAME: json['SECTION_NAME'],
      GUILTBASE_NAME: json['GUILTBASE_NAME'],
      LAWSUIT_ID: json['LAWSUIT_ID'],
      LAWSUIT_NO: json['LAWSUIT_NO'],
      LAWSUIT_NO_YEAR: json['LAWSUIT_NO_YEAR'],
      LAWSUIT_DATE: json['LAWSUIT_DATE'],
      LAWSUIT_OFFICE_NAME: json['LAWSUIT_OFFICE_NAME'],
      LAWSUIT_STAFF_NAME: json['LAWSUIT_STAFF_NAME'],
      GUILTBASE_ID: json['GUILTBASE_ID'],
      PROVE_TYPE: json['PROVE_TYPE'],
    );
  }
}