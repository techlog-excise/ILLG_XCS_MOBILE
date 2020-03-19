class ItemsListSubDistict {
  final int SUB_DISTRICT_ID;
  final int DISTRICT_ID;
  final int PROVINCE_ID;
  final String OFFICE_CODE;
  final String SUB_DISTRICT_CODE;
  final String SUB_DISTRICT_NAME_TH;
  final String SUB_DISTRICT_NAME_EN;
  final String ZIP_CODE;
  final int IS_ACTIVE;

  ItemsListSubDistict({
    this.SUB_DISTRICT_ID,
    this.DISTRICT_ID,
    this.PROVINCE_ID,
    this.OFFICE_CODE,
    this.SUB_DISTRICT_CODE,
    this.SUB_DISTRICT_NAME_TH,
    this.SUB_DISTRICT_NAME_EN,
    this.ZIP_CODE,
    this.IS_ACTIVE,
  });

  factory ItemsListSubDistict.fromJson(Map<String, dynamic> json) {
    return ItemsListSubDistict(
      SUB_DISTRICT_ID: json['SUB_DISTRICT_ID'],
      DISTRICT_ID: json['DISTRICT_ID'],
      PROVINCE_ID: json['PROVINCE_ID'],
      OFFICE_CODE: json['OFFICE_CODE'],
      SUB_DISTRICT_CODE: json['SUB_DISTRICT_CODE'],
      SUB_DISTRICT_NAME_TH: json['SUB_DISTRICT_NAME_TH'],
      SUB_DISTRICT_NAME_EN: json['SUB_DISTRICT_NAME_EN'],
      ZIP_CODE: json['ZIP_CODE'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}