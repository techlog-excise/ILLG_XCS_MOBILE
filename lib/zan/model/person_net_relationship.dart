
class ItemsListPersonNetRelationship {
  final String RELATIONSHIP_NAME;
  final String TITLE_NAME_TH;
  final String FIRST_NAME;
  final String MIDDLE_NAME;
  final String LAST_NAME;
  final String OTHER_NAME;
  final String ID_CARD;
  final String BIRTH_DATE;
  final String BLOOD_TYPE;
  final String CAREER;
  final String TEL_NO;
  final String EMAIL;

  ItemsListPersonNetRelationship({
    this.RELATIONSHIP_NAME,
    this.TITLE_NAME_TH,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
    this.ID_CARD,
    this.BIRTH_DATE,
    this.BLOOD_TYPE,
    this.CAREER,
    this.TEL_NO,
    this.EMAIL,
  });

  factory ItemsListPersonNetRelationship.fromJson(Map<String, dynamic> js) {
    return ItemsListPersonNetRelationship(
      RELATIONSHIP_NAME: js['RELATIONSHIP_NAME'],
      TITLE_NAME_TH: js['TITLE_NAME_TH'],
      FIRST_NAME: js['FIRST_NAME'],
      MIDDLE_NAME: js['MIDDLE_NAME'],
      LAST_NAME: js['LAST_NAME'],
      OTHER_NAME: js['OTHER_NAME'],
      ID_CARD: js['ID_CARD'],
      BIRTH_DATE: js['BIRTH_DATE'],
      BLOOD_TYPE: js['BLOOD_TYPE'],
      CAREER: js['CAREER'],
      TEL_NO: js['TEL_NO'],
      EMAIL: js['EMAIL'],
    );
  }
}