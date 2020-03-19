class ItemsListTitle {
  final int TITLE_ID;
  final String TITLE_NAME_TH;
  final String TITLE_NAME_EN;
  final String TITLE_SHORT_NAME_TH;
  final String TITLE_SHORT_NAME_EN;
  final int TITLE_TYPE;
  final int IS_ACTIVE;

  ItemsListTitle({
    this.TITLE_ID,
    this.TITLE_NAME_TH,
    this.TITLE_NAME_EN,
    this.TITLE_SHORT_NAME_TH,
    this.TITLE_SHORT_NAME_EN,
    this.TITLE_TYPE,
    this.IS_ACTIVE,
  });

  factory ItemsListTitle.fromJson(Map<String, dynamic> json) {
    return ItemsListTitle(
      TITLE_ID: json['TITLE_ID'],
      TITLE_NAME_TH: json['TITLE_NAME_TH'],
      TITLE_NAME_EN: json['TITLE_NAME_EN'],
      TITLE_SHORT_NAME_TH: json['TITLE_SHORT_NAME_TH'],
      TITLE_SHORT_NAME_EN: json['TITLE_SHORT_NAME_EN'],
      TITLE_TYPE: json['TITLE_TYPE'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}