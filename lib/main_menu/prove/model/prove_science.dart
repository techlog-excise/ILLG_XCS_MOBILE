
class ItemsProveScience {
  final int SCIENCE_ID;
  final int PROVE_ID;
  final String SCIENCE_CODE;
  final String DELIVERY_DOC_NO_1;
  final String DELIVERY_DOC_NO_2;
  final String DELIVERY_DOC_DATE;
  final String REQUEST_DOC_NO;
  final String REQUEST_DOC_DATE;
  final String RESULT_DOC_NO;
  final String RESULT_DOC_DATE;
  final String SCIENCE_RESULT_DESC;
  final int IS_ACTIVE;

  ItemsProveScience({
    this.SCIENCE_ID,
    this.PROVE_ID,
    this.SCIENCE_CODE,
    this.DELIVERY_DOC_NO_1,
    this.DELIVERY_DOC_NO_2,
    this.DELIVERY_DOC_DATE,
    this.REQUEST_DOC_NO,
    this.REQUEST_DOC_DATE,
    this.RESULT_DOC_NO,
    this.RESULT_DOC_DATE,
    this.SCIENCE_RESULT_DESC,
    this.IS_ACTIVE,
  });

  factory ItemsProveScience.fromJson(Map<String, dynamic> json) {
    return ItemsProveScience(
      SCIENCE_ID: json['SCIENCE_ID'],
      PROVE_ID: json['PROVE_ID'],
      SCIENCE_CODE: json['SCIENCE_CODE'],
      DELIVERY_DOC_NO_1: json['DELIVERY_DOC_NO_1'],
      DELIVERY_DOC_NO_2: json['DELIVERY_DOC_NO_2'],
      DELIVERY_DOC_DATE: json['DELIVERY_DOC_DATE'],
      REQUEST_DOC_NO: json['REQUEST_DOC_NO'],
      REQUEST_DOC_DATE: json['REQUEST_DOC_DATE'],
      RESULT_DOC_NO: json['RESULT_DOC_NO'],
      RESULT_DOC_DATE: json['RESULT_DOC_DATE'],
      SCIENCE_RESULT_DESC: json['SCIENCE_RESULT_DESC'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}