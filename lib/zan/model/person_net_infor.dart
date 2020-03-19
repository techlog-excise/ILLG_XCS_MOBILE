
class ItemsListPersonNetInfor {
  final String PERSON_TYPE;
  final String ENTITY_TYPE;
  final String GENDER_TYPE;
  final String ID_CARD;
  final String TITLE_NAME_TH;
  final String FIRST_NAME;
  final String MIDDLE_NAME;
  final String LAST_NAME;
  final String OTHER_NAME;
  final String BIRTH_DATE;
  final String BLOOD_TYPE;
  final String RACE_NAME_TH;
  final String NATIONALITY_NAME_TH;
  final String MARITAL_STATUS;
  final String RELIGION_NAME_TH;
  final String CAREER;
  final String TEL_NO;
  final String EMAIL;
  final int MISTREAT_NO;
  int REF_CODE;

  ItemsListPersonNetInfor({
    this.PERSON_TYPE,
    this.ENTITY_TYPE,
    this.GENDER_TYPE,
    this.ID_CARD,
    this.TITLE_NAME_TH,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
    this.BIRTH_DATE,
    this.BLOOD_TYPE,
    this.RACE_NAME_TH,
    this.NATIONALITY_NAME_TH,
    this.MARITAL_STATUS,
    this.RELIGION_NAME_TH,
    this.CAREER,
    this.TEL_NO,
    this.EMAIL,
    this.MISTREAT_NO,
    this.REF_CODE,
  });

  factory ItemsListPersonNetInfor.fromJson(Map<String, dynamic> js) {
    return ItemsListPersonNetInfor(
      PERSON_TYPE: js['PERSON_TYPE'],
      ENTITY_TYPE: js['ENTITY_TYPE'],
      GENDER_TYPE: js['GENDER_TYPE'],
      ID_CARD: js['ID_CARD'],
      TITLE_NAME_TH: js['TITLE_NAME_TH'],
      FIRST_NAME: js['FIRST_NAME'],
      MIDDLE_NAME: js['MIDDLE_NAME'],
      LAST_NAME: js['LAST_NAME'],
      OTHER_NAME: js['OTHER_NAME'],
      BIRTH_DATE: js['BIRTH_DATE'],
      BLOOD_TYPE: js['BLOOD_TYPE'],
      RACE_NAME_TH: js['RACE_NAME_TH'],
      NATIONALITY_NAME_TH: js['NATIONALITY_NAME_TH'],
      MARITAL_STATUS: js['MARITAL_STATUS'],
      RELIGION_NAME_TH: js['RELIGION_NAME_TH'],
      CAREER: js['CAREER'],
      TEL_NO: js['TEL_NO'],
      EMAIL: js['EMAIL'],
      MISTREAT_NO: js['MISTREAT_NO'],
      REF_CODE: null
    );
  }
}