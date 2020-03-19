class ItemsListWarehouse {
  final int WAREHOUSE_ID;
  final int SUB_DISTRICT_ID;
  final String OFFICE_CODE;
  final String WAREHOUSE_CODE;
  final int WAREHOUSE_TYPE;
  final String WAREHOUSE_NAME;
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
  final String REMARK;
  final String EFFECTIVE_DATE;
  final String EFEXPIRE_DATE;
  final int IS_ACTIVE;
  final String OFFICE_NAME;

  ItemsListWarehouse({
    this.WAREHOUSE_ID,
    this.SUB_DISTRICT_ID,
    this.OFFICE_CODE,
    this.WAREHOUSE_CODE,
    this.WAREHOUSE_TYPE,
    this.WAREHOUSE_NAME,
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
    this.REMARK,
    this.EFFECTIVE_DATE,
    this.EFEXPIRE_DATE,
    this.IS_ACTIVE,
    this.OFFICE_NAME,
  });

  factory ItemsListWarehouse.fromJson(Map<String, dynamic> json) {
    return ItemsListWarehouse(
      WAREHOUSE_ID: json['WAREHOUSE_ID'],
      SUB_DISTRICT_ID: json['SUB_DISTRICT_ID'],
      OFFICE_CODE: json['OFFICE_CODE'],
      WAREHOUSE_CODE: json['WAREHOUSE_CODE'],
      WAREHOUSE_TYPE: json['WAREHOUSE_TYPE'],
      WAREHOUSE_NAME: json['WAREHOUSE_NAME'],
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
      REMARK: json['REMARK'],
      EFFECTIVE_DATE: json['EFFECTIVE_DATE'],
      EFEXPIRE_DATE: json['EFEXPIRE_DATE'],
      IS_ACTIVE: json['IS_ACTIVE'],
      OFFICE_NAME: json['OFFICE_NAME'],
    );
  }
}