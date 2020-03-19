class ItemsListRace {
  final int RACE_ID;
  final String RACE_NAME_TH;
  final String RACE_NAME_EN;
  final int IS_ACTIVE;

  ItemsListRace({
    this.RACE_ID,
    this.RACE_NAME_TH,
    this.RACE_NAME_EN,
    this.IS_ACTIVE,
  });

  factory ItemsListRace.fromJson(Map<String, dynamic> json) {
    return ItemsListRace(
      RACE_ID: json['RACE_ID'],
      RACE_NAME_TH: json['RACE_NAME_TH'],
      RACE_NAME_EN: json['RACE_NAME_EN'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}