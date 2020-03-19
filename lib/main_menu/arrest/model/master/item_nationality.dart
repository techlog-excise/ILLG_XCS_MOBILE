class ItemsListNational {
  final int NATIONALITY_ID;
  final String NATIONALITY_NAME_TH;
  final String NATIONALITY_NAME_EN;
  final int IS_ACTIVE;

  ItemsListNational({
    this.NATIONALITY_ID,
    this.NATIONALITY_NAME_TH,
    this.NATIONALITY_NAME_EN,
    this.IS_ACTIVE,
  });

  factory ItemsListNational.fromJson(Map<String, dynamic> json) {
    return ItemsListNational(
      NATIONALITY_ID: json['NATIONALITY_ID'],
      NATIONALITY_NAME_TH: json['NATIONALITY_NAME_TH'],
      NATIONALITY_NAME_EN: json['NATIONALITY_NAME_EN'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}