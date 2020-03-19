
class ItemsProveLawbreaker {
  final int LAWBREAKER_ID;
  final int PROVE_ID;
  final int PERSON_ID;
  final int TITLE_ID;
  final int PERSON_TYPE;
  final int ENTITY_TYPE;
  final String TITLE_NAME_TH;
  final String TITLE_NAME_EN;
  final String TITLE_SHORT_NAME_TH;
  final String TITLE_SHORT_NAME_EN;
  final String FIRST_NAME;
  final String MIDDLE_NAME;
  final String LAST_NAME;
  final String OTHER_NAME;
  final String COMPANY_REGISTRATION_NO;
  final String EXCISE_REGISTRATION_NO;
  final String ID_CARD;
  final int AGE;
  final String PASSPORT_NO;
  final String CAREER;
  final String PERSON_DESC;
  final String EMAIL;
  final String TEL_NO;
  final int MISTREAT_NO;
  final int IS_ACTIVE;

  ItemsProveLawbreaker({
    this.LAWBREAKER_ID,
    this.PROVE_ID,
    this.PERSON_ID,
    this.TITLE_ID,
    this.PERSON_TYPE,
    this.ENTITY_TYPE,
    this.TITLE_NAME_TH,
    this.TITLE_NAME_EN,
    this.TITLE_SHORT_NAME_TH,
    this.TITLE_SHORT_NAME_EN,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
    this.COMPANY_REGISTRATION_NO,
    this.EXCISE_REGISTRATION_NO,
    this.ID_CARD,
    this.AGE,
    this.PASSPORT_NO,
    this.CAREER,
    this.PERSON_DESC,
    this.EMAIL,
    this.TEL_NO,
    this.MISTREAT_NO,
    this.IS_ACTIVE,
  });

  factory ItemsProveLawbreaker.fromJson(Map<String, dynamic> json) {
    return ItemsProveLawbreaker(
      LAWBREAKER_ID: json['SCIENCE_ID'],
      PROVE_ID: json['SCIENCE_ID'],
      PERSON_ID: json['SCIENCE_ID'],
      TITLE_ID: json['SCIENCE_ID'],
      PERSON_TYPE: json['SCIENCE_ID'],
      ENTITY_TYPE: json['SCIENCE_ID'],
      TITLE_NAME_TH: json['SCIENCE_ID'],
      TITLE_NAME_EN: json['SCIENCE_ID'],
      TITLE_SHORT_NAME_TH: json['SCIENCE_ID'],
      TITLE_SHORT_NAME_EN: json['SCIENCE_ID'],
      FIRST_NAME: json['SCIENCE_ID'],
      MIDDLE_NAME: json['SCIENCE_ID'],
      LAST_NAME: json['SCIENCE_ID'],
      OTHER_NAME: json['SCIENCE_ID'],
      COMPANY_REGISTRATION_NO: json['SCIENCE_ID'],
      EXCISE_REGISTRATION_NO: json['SCIENCE_ID'],
      ID_CARD: json['SCIENCE_ID'],
      AGE: json['SCIENCE_ID'],
      PASSPORT_NO: json['SCIENCE_ID'],
      CAREER: json['SCIENCE_ID'],
      PERSON_DESC: json['SCIENCE_ID'],
      EMAIL: json['SCIENCE_ID'],
      TEL_NO: json['SCIENCE_ID'],
      MISTREAT_NO: json['SCIENCE_ID'],
      IS_ACTIVE: json['SCIENCE_ID'],
    );
  }
}