class ItemsListArrestLocale {
  final int LOCALE_ID;
  final int ARREST_ID;
  final String ADDRESS_NO;
  final String VILLAGE_NO;
  final String BUILDING_NAME;
  final String FLOOR;
  final String VILLAGE_NAME;
  final String ALLEY;
  final String LANE;
  final String ROAD;
  final String DISTRICT_NAME_TH;
  final String SUB_DISTRICT_NAME_TH;
  final String PROVINCE_NAME_TH;
  final int SUB_DISTRICT_ID;
  final String GPS;
  final String POLICE_STATION;
  final String LOCATION;

  ItemsListArrestLocale({
    this.LOCALE_ID,
    this.ARREST_ID,
    this.ADDRESS_NO,
    this.VILLAGE_NO,
    this.BUILDING_NAME,
    this.FLOOR,
    this.VILLAGE_NAME,
    this.ALLEY,
    this.LANE,
    this.ROAD,
    this.DISTRICT_NAME_TH,
    this.SUB_DISTRICT_NAME_TH,
    this.SUB_DISTRICT_ID,
    this.PROVINCE_NAME_TH,
    this.GPS,
    this.POLICE_STATION,
    this.LOCATION
  });

  factory ItemsListArrestLocale.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestLocale(
      LOCALE_ID: js['LOCALE_ID'],
      ARREST_ID: js['ARREST_ID'],
      ADDRESS_NO: js['ADDRESS_NO'],
      VILLAGE_NO: js['VILLAGE_NO'],
      BUILDING_NAME: js['BUILDING_NAME'],
      FLOOR: js['FLOOR'],
      VILLAGE_NAME: js['VILLAGE_NAME'],
      ALLEY: js['ALLEY'],
      LANE: js['LANE'],
      ROAD: js['ROAD'],
      DISTRICT_NAME_TH: js['DISTRICT_NAME_TH'],
      SUB_DISTRICT_NAME_TH: js['SUB_DISTRICT_NAME_TH'],
      PROVINCE_NAME_TH: js['PROVINCE_NAME_TH'],
      SUB_DISTRICT_ID: js['SUB_DISTRICT_ID'],
      GPS: js['GPS'],
      POLICE_STATION: js['POLICE_STATION'],
      LOCATION: js['LOCATION']
    );
  }
}