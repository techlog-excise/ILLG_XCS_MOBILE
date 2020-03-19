class ItemsEvidenceCountBalance {
  final int BALANCE_QTY;
  ItemsEvidenceCountBalance({
    this.BALANCE_QTY,
  });

  factory ItemsEvidenceCountBalance.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceCountBalance(
      BALANCE_QTY: json['BALANCE_QTY'],
    );
  }
}
