class ItemsListDistict {
  final int DISTRICT_ID;
  final int PROVINCE_ID;
  final String DISTRICT_CODE;
  final String DISTRICT_NAME_TH;
  final String DISTRICT_NAME_EN;
  final int IS_ACTIVE;

  ItemsListDistict({
    this.DISTRICT_ID,
    this.PROVINCE_ID,
    this.DISTRICT_CODE,
    this.DISTRICT_NAME_TH,
    this.DISTRICT_NAME_EN,
    this.IS_ACTIVE,
  });

  factory ItemsListDistict.fromJson(Map<String, dynamic> json) {
    return ItemsListDistict(
      DISTRICT_ID: json['DISTRICT_ID'],
      PROVINCE_ID: json['PROVINCE_ID'],
      DISTRICT_CODE: json['DISTRICT_CODE'],
      DISTRICT_NAME_TH: json['DISTRICT_NAME_TH'],
      DISTRICT_NAME_EN: json['DISTRICT_NAME_EN'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}