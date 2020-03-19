class ItemsResponseNotice {
  final String IsSuccess;
  final String Msg;
  final int NOTICE_ID;

  ItemsResponseNotice({
    this.IsSuccess,
    this.Msg,
    this.NOTICE_ID
  });

  factory ItemsResponseNotice.fromJson(Map<String, dynamic> json) {
    return ItemsResponseNotice(
      IsSuccess: json['IsSuccess'],
      Msg: json['v'],
      NOTICE_ID: json['NOTICE_ID'],
    );
  }
}