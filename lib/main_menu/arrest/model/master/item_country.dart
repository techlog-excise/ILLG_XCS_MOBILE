class ItemsListCountry {
  final int COUNTRY_ID;
  final String COUNTRY_CODE;
  final String COUNTRY_NAME_TH;
  final String COUNTRY_NAME_EN;
  final String COUNTRY_SHORT_NAME;
  final int IS_ACTIVE;

  ItemsListCountry({
    this.COUNTRY_ID,
    this.COUNTRY_CODE,
    this.COUNTRY_NAME_TH,
    this.COUNTRY_NAME_EN,
    this.COUNTRY_SHORT_NAME,
    this.IS_ACTIVE,
  });

  factory ItemsListCountry.fromJson(Map<String, dynamic> json) {
    return ItemsListCountry(
        COUNTRY_ID: json['COUNTRY_ID'],
        COUNTRY_CODE: json['COUNTRY_CODE'],
        COUNTRY_NAME_TH: json['COUNTRY_NAME_TH'],
        COUNTRY_NAME_EN: json['COUNTRY_NAME_EN'],
        COUNTRY_SHORT_NAME: json['COUNTRY_SHORT_NAME'],
        IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}