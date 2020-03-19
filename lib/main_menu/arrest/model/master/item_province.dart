class ItemsListProvince {
  final int PROVINCE_ID;
  final int COUNTRY_ID;
  final String PROVINCE_CODE;
  final String PROVINCE_NAME_TH;
  final String PROVINCE_NAME_EN;
  final int IS_ACTIVE;

  ItemsListProvince({
    this.PROVINCE_ID,
    this.COUNTRY_ID,
    this.PROVINCE_CODE,
    this.PROVINCE_NAME_TH,
    this.PROVINCE_NAME_EN,
    this.IS_ACTIVE,
  });

  factory ItemsListProvince.fromJson(Map<String, dynamic> json) {
    return ItemsListProvince(
      PROVINCE_ID: json['PROVINCE_ID'],
      COUNTRY_ID: json['COUNTRY_ID'],
      PROVINCE_CODE: json['PROVINCE_CODE'],
      PROVINCE_NAME_TH: json['PROVINCE_NAME_TH'],
      PROVINCE_NAME_EN: json['PROVINCE_NAME_EN'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}