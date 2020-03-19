class ItemsListArrestPersonRelationShip {
  int PERSON_RELATIONSHIP_ID;
  int RELATIONSHIP_ID;
  int PERSON_ID;
  String RELATIONSHIP_NAME;
  int TITLE_ID;
  String TITLE_NAME_TH;
  String TITLE_NAME_EN;
  String TITLE_SHORT_NAME_TH;
  String TITLE_SHORT_NAME_EN;
  String FIRST_NAME;
  String MIDDLE_NAME;
  String LAST_NAME;
  String OTHER_NAME;

  ItemsListArrestPersonRelationShip({
    this.PERSON_RELATIONSHIP_ID,
    this.RELATIONSHIP_ID,
    this.PERSON_ID,
    this.RELATIONSHIP_NAME,
    this.TITLE_ID,
    this.TITLE_NAME_TH,
    this.TITLE_NAME_EN,
    this.TITLE_SHORT_NAME_TH,
    this.TITLE_SHORT_NAME_EN,
    this.FIRST_NAME,
    this.MIDDLE_NAME,
    this.LAST_NAME,
    this.OTHER_NAME,});

  factory ItemsListArrestPersonRelationShip.fromJson(Map<String, dynamic> json) {
    return ItemsListArrestPersonRelationShip(
      PERSON_RELATIONSHIP_ID: json['PERSON_RELATIONSHIP_ID'],
      RELATIONSHIP_ID: json['RELATIONSHIP_ID'],
      PERSON_ID: json['PERSON_ID'],
      RELATIONSHIP_NAME: json['RELATIONSHIP_NAME'],
      TITLE_ID: json['TITLE_ID'],
      TITLE_NAME_TH: json['TITLE_NAME_TH'],
      TITLE_NAME_EN: json['TITLE_NAME_EN'],
      TITLE_SHORT_NAME_TH: json['TITLE_SHORT_NAME_TH'],
      TITLE_SHORT_NAME_EN: json['TITLE_SHORT_NAME_EN'],
      FIRST_NAME: json['FIRST_NAME'],
      MIDDLE_NAME: json['MIDDLE_NAME'],
      LAST_NAME: json['LAST_NAME'],
      OTHER_NAME: json['OTHER_NAME'],
    );
  }
}