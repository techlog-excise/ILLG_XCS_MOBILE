class ItemsListProductUnit {
  final int UNIT_ID;
  final String UNIT_NAME_TH;
  final String UNIT_NAME_EN;
  final String UNIT_SHORT_NAME;
  final int IS_ACTIVE;

  ItemsListProductUnit({
    this.UNIT_ID,
    this.UNIT_NAME_TH,
    this.UNIT_NAME_EN,
    this.UNIT_SHORT_NAME,
    this.IS_ACTIVE,
  });


  factory ItemsListProductUnit.fromJson(Map<String, dynamic> json) {
    return ItemsListProductUnit(
      UNIT_ID: json['UNIT_ID'],
      UNIT_NAME_TH: json['UNIT_NAME_TH'],
      UNIT_NAME_EN: json['UNIT_NAME_EN'],
      UNIT_SHORT_NAME: json['UNIT_SHORT_NAME'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}