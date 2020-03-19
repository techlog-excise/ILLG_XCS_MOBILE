class ItemsNoticeLocale {
  final int LOCALE_ID;
  final int NOTICE_ID;
  final int SUB_DISTRICT_ID;
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
  final int ADDRESS_TYPE;
  final int ADDRESS_STATUS;
  final String POLICE_STATION;
  final String LOCATION;
  final int IS_ACTIVE;

  ItemsNoticeLocale({
    this.LOCALE_ID,
    this.NOTICE_ID,
    this.SUB_DISTRICT_ID,
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
    this.ADDRESS_TYPE,
    this.ADDRESS_STATUS,
    this.POLICE_STATION,
    this.LOCATION,
    this.IS_ACTIVE,
  });

  factory ItemsNoticeLocale.fromJson(Map<String, dynamic> js) {
    return ItemsNoticeLocale(
      LOCALE_ID: js['LOCALE_ID'],
      NOTICE_ID: js['NOTICE_ID'],
      SUB_DISTRICT_ID: js['SUB_DISTRICT_ID'],
      GPS: js['GPS'],
      ADDRESS_NO: js['ADDRESS_NO'],
      VILLAGE_NO: js['VILLAGE_NO'],
      BUILDING_NAME: js['BUILDING_NAME'],
      ROOM_NO: js['ROOM_NO'],
      FLOOR: js['FLOOR'],
      VILLAGE_NAME: js['VILLAGE_NAME'],
      ALLEY: js['ALLEY'],
      LANE: js['LANE'],
      ROAD: js['ROAD'],
      ADDRESS_TYPE: js['ADDRESS_TYPE'],
      ADDRESS_STATUS: js['ADDRESS_STATUS'],
      POLICE_STATION: js['POLICE_STATION'],
      LOCATION: js['LOCATION'],
      IS_ACTIVE: js['IS_ACTIVE'],
    );
  }
}