
class ItemsListPersonNetAddress {
  final String ADDRESS_TYPE;
  final String LATITUDE;
  final String LONGITUDE;
  final String ADDRESS_NO;
  final String VILLAGE_NO;
  final String BUILDING_NAME;
  final String ROOM_NO;
  final String FLOOR;
  final String VILLAGE_NAME;
  final String ALLEY;
  final String LANE;
  final String ROAD;
  final String ADDRESS;
  final String ADDRESS_STATUS;

  ItemsListPersonNetAddress({
    this.ADDRESS_TYPE,
    this.LATITUDE,
    this.LONGITUDE,
    this.ADDRESS_NO,
    this.VILLAGE_NO,
    this.BUILDING_NAME,
    this.ROOM_NO,
    this.FLOOR,
    this.VILLAGE_NAME,
    this.ALLEY,
    this.LANE,
    this.ROAD,
    this.ADDRESS,
    this.ADDRESS_STATUS,
  });

  factory ItemsListPersonNetAddress.fromJson(Map<String, dynamic> js) {
    return ItemsListPersonNetAddress(
      ADDRESS_TYPE: js['ADDRESS_TYPE'],
      LATITUDE: js['LATITUDE'],
      LONGITUDE: js['LONGITUDE'],
      ADDRESS_NO: js['ADDRESS_NO'],
      VILLAGE_NO: js['VILLAGE_NO'],
      BUILDING_NAME: js['BUILDING_NAME'],
      ROOM_NO: js['ROOM_NO'],
      FLOOR: js['FLOOR'],
      VILLAGE_NAME: js['VILLAGE_NAME'],
      ALLEY: js['ALLEY'],
      LANE: js['LANE'],
      ROAD: js['ROAD'],
      ADDRESS: js['ADDRESS'],
      ADDRESS_STATUS: js['ADDRESS_STATUS'],
    );
  }
}