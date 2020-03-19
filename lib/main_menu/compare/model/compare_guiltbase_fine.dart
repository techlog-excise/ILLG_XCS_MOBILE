
class ItemsCompareGuiltbaseFine {
  int FINE_ID;
  int SUBSECTION_RULE_ID;
  int PRODUCT_GROUP_ID;
  int MISTREAT_START_NO;
  int MISTREAT_TO_NO;
  int IS_FINE;
  double FINE_RATE;
  String MISTREAT_DESC;
  double MISTREAT_START_VOLUMN;
  double MISTREAT_TO_VOLUMN;
  double FINE_AMOUNT;
  double FINE_TAX;
  int IS_ACTIVE;

  ItemsCompareGuiltbaseFine({
    this.FINE_ID,
    this.SUBSECTION_RULE_ID,
    this.PRODUCT_GROUP_ID,
    this.MISTREAT_START_NO,
    this.MISTREAT_TO_NO,
    this.IS_FINE,
    this.FINE_RATE,
    this.MISTREAT_DESC,
    this.MISTREAT_START_VOLUMN,
    this.MISTREAT_TO_VOLUMN,
    this.FINE_AMOUNT,
    this.FINE_TAX,
    this.IS_ACTIVE,
  });
  factory ItemsCompareGuiltbaseFine.fromJson(Map<String, dynamic> json) {
    return ItemsCompareGuiltbaseFine(
      FINE_ID: json['FINE_ID'],
      SUBSECTION_RULE_ID: json['SUBSECTION_RULE_ID'],
      PRODUCT_GROUP_ID: json['PRODUCT_GROUP_ID'],
      MISTREAT_START_NO: json['MISTREAT_START_NO'],
      MISTREAT_TO_NO: json['MISTREAT_TO_NO'],
      IS_FINE: json['IS_FINE'],
      FINE_RATE: json['FINE_RATE'],
      MISTREAT_DESC: json['MISTREAT_DESC'],
      MISTREAT_START_VOLUMN: json['MISTREAT_START_VOLUMN'],
      MISTREAT_TO_VOLUMN: json['MISTREAT_TO_VOLUMN'],
      FINE_AMOUNT: json['FINE_AMOUNT'],
      FINE_TAX: json['FINE_TAX'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}