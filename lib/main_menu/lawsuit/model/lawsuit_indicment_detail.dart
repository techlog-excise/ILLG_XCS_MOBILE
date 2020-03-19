
class ItemsLawsuitListIndicmentDetail {
  final int INDICTMENT_DETAIL_ID;
  final int INDICTMENT_ID;
  final int LAWBREAKER_ID;
  final int PERSON_ID;
  final String TITLE_SHORT_NAME_TH;
  final String FIRST_NAME;
  final String MIDDLE_NAME;
  final String LAST_NAME;
  final String OTHER_NAME;
  final int MISTREAT_NO;

  final int PERSON_TYPE;
  final int ENTITY_TYPE;


  ItemsLawsuitListIndicmentDetail({
    this.INDICTMENT_DETAIL_ID,
    this.INDICTMENT_ID,
    this.LAWBREAKER_ID,
    this.PERSON_ID,
    this.TITLE_SHORT_NAME_TH,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
    this.MISTREAT_NO,

    this.PERSON_TYPE,
    this.ENTITY_TYPE,
  });

  factory ItemsLawsuitListIndicmentDetail.fromJson(Map<String, dynamic> js) {
    return ItemsLawsuitListIndicmentDetail(
      INDICTMENT_DETAIL_ID: js['INDICTMENT_DETAIL_ID'],
      INDICTMENT_ID: js['INDICTMENT_ID'],
      LAWBREAKER_ID: js['LAWBREAKER_ID'],
      PERSON_ID: js['PERSON_ID'],
      TITLE_SHORT_NAME_TH: js['PERSON_TYPE']==0
          ?(js['TITLE_SHORT_NAME_TH']==null?"":js['TITLE_SHORT_NAME_TH'])
          :(js['TITLE_SHORT_NAME_EN']==null?"":js['TITLE_SHORT_NAME_EN']),
      FIRST_NAME: js['FIRST_NAME']==null?"":js['FIRST_NAME'],
      MIDDLE_NAME: js['MIDDLE_NAME'],
      LAST_NAME: js['LAST_NAME']==null?"":js['LAST_NAME'],
      OTHER_NAME: js['OTHER_NAME'],
      MISTREAT_NO: js['MISTREAT_NO'],

      PERSON_TYPE: js['PERSON_TYPE'],
      ENTITY_TYPE: js['ENTITY_TYPE']
    );
  }
}