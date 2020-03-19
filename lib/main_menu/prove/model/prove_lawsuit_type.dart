class ItemsProveLawsuitType {
  final int LAWSUIT_TYPE;

  ItemsProveLawsuitType({
    this.LAWSUIT_TYPE,
  });

  factory ItemsProveLawsuitType.fromJson(Map<String, dynamic> json) {
    return ItemsProveLawsuitType(
      LAWSUIT_TYPE: json['LAWSUIT_TYPE'],
    );
  }
}
