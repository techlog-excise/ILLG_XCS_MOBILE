class ItemsListProductSize {
  /*final int SIZE_ID;
  final String SIZE_NAME_TH;
  final String SIZE_NAME_EN;
  final String SIZE_SHORT_NAME;
  final int IS_ACTIVE;*/
  int SIZE_ID;
  String SIZE_NAME_TH;
  String SIZE_NAME_EN;
  String SIZE_SHORT_NAME;
  int IS_ACTIVE;

  ItemsListProductSize({
    this.SIZE_ID,
    this.SIZE_NAME_TH,
    this.SIZE_NAME_EN,
    this.SIZE_SHORT_NAME,
    this.IS_ACTIVE,
  });

  factory ItemsListProductSize.fromJson(Map<String, dynamic> json) {
    return ItemsListProductSize(
      SIZE_ID: json['SIZE_ID'],
      SIZE_NAME_TH: json['SIZE_NAME_TH'],
      SIZE_NAME_EN: json['SIZE_NAME_EN'],
      SIZE_SHORT_NAME: json['SIZE_SHORT_NAME'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}