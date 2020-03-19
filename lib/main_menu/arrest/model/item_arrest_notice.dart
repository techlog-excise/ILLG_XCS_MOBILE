class ItemsListArrestNotice {
  final int NOTICE_ID;
  final String NOTICE_CODE;
  final String STAFF_TITLE_SHORT_NAME_TH;
  final String STAFF_FIRST_NAME;
  final String STAFF_LAST_NAME;

  ItemsListArrestNotice({
    this.NOTICE_ID,
    this.NOTICE_CODE,
    this.STAFF_TITLE_SHORT_NAME_TH,
    this.STAFF_FIRST_NAME,
    this.STAFF_LAST_NAME,
  });

  factory ItemsListArrestNotice.fromJson(Map<String, dynamic> js) {
    return ItemsListArrestNotice(
      NOTICE_ID: js['NOTICE_ID'],
      NOTICE_CODE: js['NOTICE_CODE'],
      STAFF_TITLE_SHORT_NAME_TH: js['STAFF_TITLE_SHORT_NAME_TH'],
      STAFF_FIRST_NAME: js['STAFF_FIRST_NAME'],
      STAFF_LAST_NAME: js['STAFF_LAST_NAME'],
    );
  }
}