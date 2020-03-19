class ItemsMasLawGuiltbaseFine {
  final int FINE_ID;
  final int SUBSECTION_RULE_ID;
  final int PRODUCT_GROUP_ID;
  final int MISTREAT_START_NO;
  final int MISTREAT_TO_NO;
  final int IS_FINE;
  final double FINE_RATE;
  final String MISTREAT_DESC;
  final double MISTREAT_START_VOLUMN;
  final double MISTREAT_TO_VOLUMN;
  final double FINE_AMOUNT;
  final double FINE_TAX;
  final int IS_ACTIVE;
  // final int MISTREAT_START_UNIT;
  // final int MISTREAT_TO_UNIT;
  // final int STATUS_VOLUMN;

  ItemsMasLawGuiltbaseFine({
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
    // this.MISTREAT_START_UNIT,
    // this.MISTREAT_TO_UNIT,
    // this.STATUS_VOLUMN,
  });

  factory ItemsMasLawGuiltbaseFine.fromJson(Map<String, dynamic> json) {
    return ItemsMasLawGuiltbaseFine(
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
      // MISTREAT_START_UNIT: json['MISTREAT_START_UNIT'],
      // MISTREAT_TO_UNIT: json['MISTREAT_TO_UNIT'],
      // STATUS_VOLUMN: json['STATUS_VOLUMN'],
    );
  }
}
