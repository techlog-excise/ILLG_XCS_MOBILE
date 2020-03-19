class ItemsListOffice {
  final int OFFICE_ID;
  final String OFFICE_CODE;
  final String OFFICE_NAME;
  final String OFFICE_SHORT_NAME;
  final int IS_ACTIVE;

  ItemsListOffice({
    this.OFFICE_ID,
    this.OFFICE_CODE,
    this.OFFICE_NAME,
    this.OFFICE_SHORT_NAME,
    this.IS_ACTIVE,
  });

  factory ItemsListOffice.fromJson(Map<String, dynamic> json) {
    return ItemsListOffice(
      OFFICE_ID: json['OFFICE_ID'],
      OFFICE_CODE: json['OFFICE_CODE'],
      OFFICE_NAME: json['OFFICE_NAME'],
      OFFICE_SHORT_NAME: json['OFFICE_SHORT_NAME'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}
