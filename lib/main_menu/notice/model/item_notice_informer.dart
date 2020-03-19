class ItemsNoticeInformer {
  final int INFORMER_ID;
  final int NOTICE_ID;
  final int TITLE_ID;
  final int SUB_DISTRICT_ID;
  final int INFORMER_STATUS;
  final String TITLE_NAME_TH;
  final String TITLE_NAME_EN;
  final String TITLE_SHORT_NAME_TH;
  final String TITLE_SHORT_NAME_EN;
  final String FIRST_NAME;
  final String MIDDLE_NAME;
  final String LAST_NAME;
  final String OTHER_NAME;
  final String ID_CARD;
  final int AGE;
  final String CAREER;
  final String POSITION;
  final String PERSON_DESC;
  final String EMAIL;
  final String TEL_NO;
  final String INFORMER_INFO;
  final String GPS;
  final String ADDRESS_NO;
  final String VILLAGE_NO;
  final String BUILDING_NAME;
  final String ROOM_NO;
  final String FLOOR;
  final String VILLAGE_NAME;
  final String ALLEY;
  final String LANE;
  final String ROAD;
  final String INFORMER_PHOTO;
  final String INFORMER_FINGER_PRINT;
  final int IS_ACTIVE;

  ItemsNoticeInformer({
    this.INFORMER_ID,
    this.NOTICE_ID,
    this.TITLE_ID,
    this.SUB_DISTRICT_ID,
    this.INFORMER_STATUS,
    this.TITLE_NAME_TH,
    this.TITLE_NAME_EN,
    this.TITLE_SHORT_NAME_TH,
    this.TITLE_SHORT_NAME_EN,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,
    this.ID_CARD,
    this.AGE,
    this.CAREER,
    this.POSITION,
    this.PERSON_DESC,
    this.EMAIL,
    this.TEL_NO,
    this.INFORMER_INFO,
    this.GPS,
    this.ADDRESS_NO,
    this.VILLAGE_NO,
    this.BUILDING_NAME,
    this.ROOM_NO,
    this.FLOOR,
    this.VILLAGE_NAME,
    this.ALLEY,
    this.LANE,
    this.ROAD,
    this.INFORMER_PHOTO,
    this.INFORMER_FINGER_PRINT,
    this.IS_ACTIVE,
  });

  factory ItemsNoticeInformer.fromJson(Map<String, dynamic> json) {
    return ItemsNoticeInformer(
      INFORMER_ID: json['INFORMER_ID'],
      NOTICE_ID: json['NOTICE_ID'],
      TITLE_ID: json['TITLE_ID'],
      SUB_DISTRICT_ID: json['SUB_DISTRICT_ID'],
      INFORMER_STATUS: json['INFORMER_STATUS'],
      TITLE_NAME_TH: json['TITLE_NAME_TH'],
      TITLE_NAME_EN: json['TITLE_NAME_EN'],
      TITLE_SHORT_NAME_TH: json['TITLE_SHORT_NAME_TH'],
      TITLE_SHORT_NAME_EN: json['TITLE_SHORT_NAME_EN'],
      FIRST_NAME: json['FIRST_NAME'],
      MIDDLE_NAME: json['MIDDLE_NAME'],
      LAST_NAME: json['LAST_NAME'],
      OTHER_NAME: json['OTHER_NAME'],
      ID_CARD: json['ID_CARD'],
      AGE: json['AGE'],
      CAREER: json['CAREER'],
      POSITION: json['POSITION'],
      PERSON_DESC: json['PERSON_DESC'],
      EMAIL: json['EMAIL'],
      TEL_NO: json['TEL_NO'],
      INFORMER_INFO: json['INFORMER_INFO'],
      GPS: json['GPS'],
      ADDRESS_NO: json['ADDRESS_NO'],
      VILLAGE_NO: json['VILLAGE_NO'],
      BUILDING_NAME: json['BUILDING_NAME'],
      ROOM_NO: json['ROOM_NO'],
      FLOOR: json['FLOOR'],
      VILLAGE_NAME: json['VILLAGE_NAME'],
      ALLEY: json['ALLEY'],
      LANE: json['LANE'],
      ROAD: json['ROAD'],
      INFORMER_PHOTO: json['INFORMER_PHOTO'],
      INFORMER_FINGER_PRINT: json['INFORMER_FINGER_PRINT'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}