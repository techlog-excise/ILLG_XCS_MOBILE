class ItemsListDivisionRate {
  final int DIVISIONRATE_ID;
  final dynamic TREASURY_RATE;
  final dynamic BRIBE_RATE;
  final dynamic REWARD_RATE;
  final dynamic BRIBE_MAX_MONEY;
  final dynamic REWARD_MAX_MONEY;
  final String EFFECTIVE_DATE;
  final String EXPIRE_DATE;
  final int IS_ACTIVE;

  ItemsListDivisionRate({
    this.DIVISIONRATE_ID,
    this.TREASURY_RATE,
    this.BRIBE_RATE,
    this.REWARD_RATE,
    this.BRIBE_MAX_MONEY,
    this.REWARD_MAX_MONEY,
    this.EFFECTIVE_DATE,
    this.EXPIRE_DATE,
    this.IS_ACTIVE,
  });

  factory ItemsListDivisionRate.fromJson(Map<String, dynamic> json) {
    return ItemsListDivisionRate(
      DIVISIONRATE_ID: json['DIVISIONRATE_ID'],
      TREASURY_RATE: json['TREASURY_RATE'],
      BRIBE_RATE: json['BRIBE_RATE'],
      REWARD_RATE: json['REWARD_RATE'],
      BRIBE_MAX_MONEY: json['BRIBE_MAX_MONEY'],
      REWARD_MAX_MONEY: json['REWARD_MAX_MONEY'],
      EFFECTIVE_DATE: json['EFFECTIVE_DATE'],
      EXPIRE_DATE: json['EXPIRE_DATE'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}