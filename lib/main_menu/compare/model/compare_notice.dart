class ItemsCompareNotice {
  final int NOTICE_ID;
  final int ARREST_ID;

  ItemsCompareNotice({
    this.NOTICE_ID,
    this.ARREST_ID,
  });

  factory ItemsCompareNotice.fromJson(Map<String, dynamic> json) {
    return ItemsCompareNotice(
      NOTICE_ID: json['NOTICE_ID'],
      ARREST_ID: json['ARREST_ID'],
    );
  }
}