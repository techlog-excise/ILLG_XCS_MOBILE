class ItemsEvidenceProductDetailList {
  final int EVIDENCE_IN_ITEM_ID;
  final String EVIDENCE_IN_ITEM_CODE;
  final String EVIDENCE_IN_DATE;
  final String PRODUCT_NAME;

  ItemsEvidenceProductDetailList({
    this.EVIDENCE_IN_ITEM_ID,
    this.EVIDENCE_IN_ITEM_CODE,
    this.EVIDENCE_IN_DATE,
    this.PRODUCT_NAME,
  });

  factory ItemsEvidenceProductDetailList.fromJson(Map<String, dynamic> json) {
    return ItemsEvidenceProductDetailList(
      EVIDENCE_IN_ITEM_ID: json['EVIDENCE_IN_ITEM_ID'],
      EVIDENCE_IN_ITEM_CODE: json['EVIDENCE_IN_ITEM_CODE'],
      EVIDENCE_IN_DATE: json['EVIDENCE_IN_DATE'],
      PRODUCT_NAME: json['PRODUCT_NAME'],
    );
  }
}
