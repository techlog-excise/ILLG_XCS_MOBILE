
class ItemsListArrestAddressPerson {
  int PERSON_ADDRESS_ID;
  int PERSON_ID;
  int SUB_DISTRICT_ID;
  String GPS;
  String ADDRESS_NO;
  String VILLAGE_NO;
  String BUILDING_NAME;
  String ROOM_NO;
  String FLOOR;
  String ALLEY;
  String LANE;
  String ROAD;
  int ADDRESS_TYPE;
  String ADDRESS_DESC;
  int ADDRESS_STATUS;
  int IS_ACTIVE;
  String SUB_DISTRICT_NAME_TH;
  String SUB_DISTRICT_NAME_EN;
  String DISTRICT_NAME_TH;
  String DISTRICT_NAME_EN;
  String PROVINCE_NAME_TH;
  String PROVINCE_NAME_EN;

  ItemsListArrestAddressPerson({
    this.PERSON_ADDRESS_ID,
    this.PERSON_ID,
    this.SUB_DISTRICT_ID,
    this.GPS,
    this.ADDRESS_NO,
    this.VILLAGE_NO,
    this.BUILDING_NAME,
    this.ROOM_NO,
    this.FLOOR,
    this.ALLEY,
    this.LANE,
    this.ROAD,
    this.ADDRESS_TYPE,
    this.ADDRESS_DESC,
    this.ADDRESS_STATUS,
    this.IS_ACTIVE,
    this.SUB_DISTRICT_NAME_TH,
    this.SUB_DISTRICT_NAME_EN,
    this.DISTRICT_NAME_TH,
    this.DISTRICT_NAME_EN,
    this.PROVINCE_NAME_TH,
    this.PROVINCE_NAME_EN,
  });

  factory ItemsListArrestAddressPerson.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestAddressPerson(
      PERSON_ADDRESS_ID: js['PERSON_ADDRESS_ID'],
      PERSON_ID: js['PERSON_ID'],
      SUB_DISTRICT_ID: js['SUB_DISTRICT_ID'],
      GPS: js['GPS'],
      ADDRESS_NO: js['ADDRESS_NO'],
      VILLAGE_NO: js['VILLAGE_NO'],
      BUILDING_NAME: js['BUILDING_NAME'],
      ROOM_NO: js['ROOM_NO'],
      FLOOR: js['FLOOR'],
      ALLEY: js['ALLEY'],
      LANE: js['LANE'],
      ROAD: js['ROAD'],
      ADDRESS_TYPE: js['ADDRESS_TYPE'],
      ADDRESS_DESC: js['ADDRESS_DESC'],
      ADDRESS_STATUS: js['ADDRESS_STATUS'],
      IS_ACTIVE: js['IS_ACTIVE'],
      SUB_DISTRICT_NAME_TH: js['SUB_DISTRICT_NAME_TH'],
      SUB_DISTRICT_NAME_EN: js['SUB_DISTRICT_NAME_EN'],
      DISTRICT_NAME_TH: js['DISTRICT_NAME_TH'],
      DISTRICT_NAME_EN: js['DISTRICT_NAME_EN'],
      PROVINCE_NAME_TH: js['PROVINCE_NAME_TH'],
      PROVINCE_NAME_EN: js['PROVINCE_NAME_EN'],
    );
  }
}