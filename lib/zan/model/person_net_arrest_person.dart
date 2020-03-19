
class ItemsListPersonNetArrestPerson {
  final int LAWBREAKER_ID;
  final int PERSON_ID;
  final String PHOTO;
  final String ARREST_LAWBREAKER_NAME;
  final int ARREST_ID;
  final String ARREST_CODE;
  final String OCCURRENCE_DATE;
  final String ADDRESS_NO;
  final String VILLAGE_NO;
  final String BUILDING_NAME;
  final String ROOM_NO;
  final String FLOOR;
  final String VILLAGE_NAME;
  final String ALLEY;
  final String LANE;
  final String ROAD;
  final String LOCATION;
  final String SECTION_NAME;
  final String GUILTBASE_NAME;
  final String PRODUCT_GROUP_NAME;
  final int DOCUMENT_ID;
  final String FILE_PATH;

  ItemsListPersonNetArrestPerson({
    this.LAWBREAKER_ID,
    this.PERSON_ID,
    this.PHOTO,
    this.ARREST_LAWBREAKER_NAME,
    this.ARREST_ID,
    this.ARREST_CODE,
    this.OCCURRENCE_DATE,
    this.ADDRESS_NO,
    this.VILLAGE_NO,
    this.BUILDING_NAME,
    this.ROOM_NO,
    this.FLOOR,
    this.VILLAGE_NAME,
    this.ALLEY,
    this.LANE,
    this.ROAD,
    this.LOCATION,
    this.SECTION_NAME,
    this.GUILTBASE_NAME,
    this.PRODUCT_GROUP_NAME,
    this.DOCUMENT_ID,
    this.FILE_PATH,
  });

  factory ItemsListPersonNetArrestPerson.fromJson(Map<String, dynamic> js) {
    return ItemsListPersonNetArrestPerson(
      LAWBREAKER_ID: js['LAWBREAKER_ID'],
      PERSON_ID: js['PERSON_ID'],
      PHOTO: js['PHOTO'],
      ARREST_LAWBREAKER_NAME: js['ARREST_LAWBREAKER_NAME'],
      ARREST_ID: js['ARREST_ID'],
      ARREST_CODE: js['ARREST_CODE'],
      OCCURRENCE_DATE: js['OCCURRENCE_DATE'],
      ADDRESS_NO: js['ADDRESS_NO'],
      VILLAGE_NO: js['VILLAGE_NO'],
      BUILDING_NAME: js['BUILDING_NAME'],
      ROOM_NO: js['ROOM_NO'],
      FLOOR: js['FLOOR'],
      VILLAGE_NAME: js['VILLAGE_NAME'],
      ALLEY: js['ALLEY'],
      LANE: js['LANE'],
      ROAD: js['ROAD'],
      LOCATION: js['LOCATION'],
      SECTION_NAME: js['SECTION_NAME'],
      GUILTBASE_NAME: js['GUILTBASE_NAME'],
      PRODUCT_GROUP_NAME: js['PRODUCT_GROUP_NAME'],
      DOCUMENT_ID: js['DOCUMENT_ID'],
      FILE_PATH: js['FILE_PATH'],
    );
  }
}