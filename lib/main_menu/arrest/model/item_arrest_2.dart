class ItemsList {
  final int NOTICE_ID;
  final String NOTICE_CODE;
  final int IS_ARREST;
  final String TITLE_NAME;
  final String TITLE_NAME_TH;
  final String TITLE_SHORT_NAME_TH;
  final String FIRST_NAME;
  final String LAST_NAME;
  final String SUSPECT_TITLE_SHORT_NAME_TH;
  final String SUSPECT_FIRST_NAME;
  final String SUSPECT_MIDDLE_NAME;
  final String SUSPECT_LAST_NAME;
  final String SUSPECT_OTHER_NAME;
  final String NOTICE_DATE;
  bool IsCheck;

  ItemsList(
      {this.NOTICE_ID,
      this.NOTICE_CODE,
      this.IS_ARREST,
      this.TITLE_NAME,
      this.TITLE_NAME_TH,
      this.TITLE_SHORT_NAME_TH,
      this.FIRST_NAME,
      this.LAST_NAME,
      this.SUSPECT_TITLE_SHORT_NAME_TH,
      this.SUSPECT_FIRST_NAME,
      this.SUSPECT_MIDDLE_NAME,
      this.SUSPECT_LAST_NAME,
      this.SUSPECT_OTHER_NAME,
      this.NOTICE_DATE,
      this.IsCheck});

  factory ItemsList.fromJson(Map<String, dynamic> json) {
    return ItemsList(
        NOTICE_ID: json['NOTICE_ID'],
        NOTICE_CODE: json['NOTICE_CODE'],
        IS_ARREST: json['IS_ARREST'],
        TITLE_NAME: json['TITLE_NAME'],
        TITLE_NAME_TH: json['TITLE_NAME_TH'],
        TITLE_SHORT_NAME_TH: json['TITLE_SHORT_NAME_TH'],
        FIRST_NAME: json['FIRST_NAME'],
        LAST_NAME: json['LAST_NAME'],
        SUSPECT_TITLE_SHORT_NAME_TH: json['SUSPECT_TITLE_SHORT_NAME_TH'],
        SUSPECT_FIRST_NAME: json['SUSPECT_FIRST_NAME'],
        SUSPECT_MIDDLE_NAME: json['SUSPECT_MIDDLE_NAME'],
        SUSPECT_LAST_NAME: json['SUSPECT_LAST_NAME'],
        SUSPECT_OTHER_NAME: json['SUSPECT_OTHER_NAME'],
        NOTICE_DATE: json['NOTICE_DATE'],
        IsCheck: false);
  }
}
