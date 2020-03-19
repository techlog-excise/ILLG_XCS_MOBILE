class ItemsEvidenceCountWareHouse {

  final int INSIDE;
  final int DESTROY;
  final int SELL;
  final int LEND;
  final int KEEP;
  final int DONATE;
  final int TRANSFER;

  ItemsEvidenceCountWareHouse({
    this.INSIDE,
    this.DESTROY,
    this.SELL,
    this.LEND,
    this.KEEP,
    this.DONATE,
    this.TRANSFER,
  });

  factory ItemsEvidenceCountWareHouse.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceCountWareHouse(
      INSIDE: json['INSIDE'],
      DESTROY: json['DESTROY'],
      SELL: json['SELL'],
      LEND: json['LEND'],
      KEEP: json['KEEP'],
      DONATE: json['DONATE'],
      TRANSFER: json['TRANSFER'],
    );
  }
}
