
class ItemsCountOffenseArea {
  final String SUPOFFCODE;
  final String OFFCODE;
  final String OFFNAME;
  final int LAWSUIT_AMOUNT;
  final double PAYMENT_FINE;
  final double FINE;
  final double FINE_ESTIMATE;
  final double BRIBE_MONEY;
  final double REWARD_MONEY;
  final double TREASURY_MONEY;

  ItemsCountOffenseArea({
    this.SUPOFFCODE,
    this.OFFCODE,
    this.OFFNAME,
    this.LAWSUIT_AMOUNT,
    this.PAYMENT_FINE,
    this.FINE,
    this.FINE_ESTIMATE,
    this.BRIBE_MONEY,
    this.REWARD_MONEY,
    this.TREASURY_MONEY,
  });

  factory ItemsCountOffenseArea.fromJson(Map<String, dynamic> json) {
    return ItemsCountOffenseArea(
      SUPOFFCODE:json['SUPOFFCODE'],
      OFFCODE: json['OFFCODE'],
      OFFNAME: json['OFFNAME'],
      LAWSUIT_AMOUNT: json['LAWSUIT_AMOUNT'],
      PAYMENT_FINE: json['PAYMENT_FINE'],
      FINE:json['FINE'],
      FINE_ESTIMATE: json['FINE_ESTIMATE'],
      BRIBE_MONEY: json['BRIBE_MONEY'],
      REWARD_MONEY: json['REWARD_MONEY'],
      TREASURY_MONEY: json['TREASURY_MONEY'],
    );
  }
}