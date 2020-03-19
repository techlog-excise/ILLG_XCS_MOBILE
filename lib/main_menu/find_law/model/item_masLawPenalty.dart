class ItemsMasLawPenalty {
  final int PENALTY_ID;
  final int SECTION_ID;
  final String PENALTY_DESC;
  final int IS_FINE_PRISON;
  final int IS_FINE;
  final double FINE_RATE_MIN;
  final double FINE_RATE_MAX;
  final double FINE_MIN;
  final double FINE_MAX;
  final int IS_IMPRISON;
  final double PRISON_RATE_MIN;
  final double PRISON_RATE_MAX;
  final int IS_TAX_PAID;
  final int IS_ACTIVE;

  ItemsMasLawPenalty({
    this.PENALTY_ID,
    this.SECTION_ID,
    this.PENALTY_DESC,
    this.IS_FINE_PRISON,
    this.IS_FINE,
    this.FINE_RATE_MIN,
    this.FINE_RATE_MAX,
    this.FINE_MIN,
    this.FINE_MAX,
    this.IS_IMPRISON,
    this.PRISON_RATE_MIN,
    this.PRISON_RATE_MAX,
    this.IS_TAX_PAID,
    this.IS_ACTIVE,
  });

  factory ItemsMasLawPenalty.fromJson(Map<String, dynamic> json) {
    return ItemsMasLawPenalty(
      PENALTY_ID: json['PENALTY_ID'],
      SECTION_ID: json['SECTION_ID'],
      PENALTY_DESC: json['PENALTY_DESC'],
      IS_FINE_PRISON: json['IS_FINE_PRISON'],
      IS_FINE: json['IS_FINE'],
      FINE_RATE_MIN: json['FINE_RATE_MIN'],
      FINE_RATE_MAX: json['FINE_RATE_MAX'],
      FINE_MIN: json['FINE_MIN'],
      FINE_MAX: json['FINE_MAX'],
      IS_IMPRISON: json['IS_IMPRISON'],
      PRISON_RATE_MIN: json['PRISON_RATE_MIN'],
      PRISON_RATE_MAX: json['PRISON_RATE_MAX'],
      IS_TAX_PAID: json['IS_TAX_PAID'],
      IS_ACTIVE: json['IS_ACTIVE'],
    );
  }
}
