
class ItemsLawsuitNotice {
  int NOTICE_ID;
  int ARREST_ID;

  ItemsLawsuitNotice({
    this.NOTICE_ID,
    this.ARREST_ID,
  });

  factory ItemsLawsuitNotice.fromJson(Map<String, dynamic> json) {
    return ItemsLawsuitNotice(
        NOTICE_ID: json['NOTICE_ID'],
        ARREST_ID: json['ARREST_ID'],
    );
  }
}