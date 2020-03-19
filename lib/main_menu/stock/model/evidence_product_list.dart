class ItemsEvidenceProductList {
  final int EVIDENCE_OUT_ID;
  final String EVIDENCE_OUT_CODE;
  final String EVIDENCE_OUT_DATE;

  ItemsEvidenceProductList({
    this.EVIDENCE_OUT_ID,
    this.EVIDENCE_OUT_CODE,
    this.EVIDENCE_OUT_DATE,
  });

  factory ItemsEvidenceProductList.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceProductList(
      EVIDENCE_OUT_ID: json['EVIDENCE_OUT_ID'],
      EVIDENCE_OUT_CODE: json['EVIDENCE_OUT_CODE'],
      EVIDENCE_OUT_DATE: json['EVIDENCE_OUT_DATE'],
    );
  }
}
