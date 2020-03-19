class ItemsMasLawGuiltbase {
  final int GUILTBASE_ID;
  final int SUBSECTION_RULE_ID;
  final String GUILTBASE_NAME;
  final String FINE;
  final int IS_PROVE;
  final int IS_COMPARE;
  final String REMARK;
  final int IS_ACTIVE;

  ItemsMasLawGuiltbase({
    this.GUILTBASE_ID,
    this.SUBSECTION_RULE_ID,
    this.GUILTBASE_NAME,
    this.FINE,
    this.IS_PROVE,
    this.IS_COMPARE,
    this.REMARK,
    this.IS_ACTIVE,
  });

  factory ItemsMasLawGuiltbase.fromJson(Map<String, dynamic> json) {
    return ItemsMasLawGuiltbase(
      GUILTBASE_ID: json['GUILTBASE_ID'],
      SUBSECTION_RULE_ID: json['SUBSECTION_RULE_ID'],
      GUILTBASE_NAME: json['GUILTBASE_NAME'],
      FINE: json['FINE'],
      IS_PROVE: json['IS_PROVE'],
      IS_COMPARE: json['IS_COMPARE'],
      REMARK: json['REMARK'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}
