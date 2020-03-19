class ItemsResponseEvidenceOut {
  final String IsSuccess;
  final String Msg;
  final int EVIDENCE_OUT_ID;

  ItemsResponseEvidenceOut({
    this.IsSuccess,
    this.Msg,
    this.EVIDENCE_OUT_ID,
  });

  factory ItemsResponseEvidenceOut.fromJson(
      Map<String, dynamic> json) {
    return ItemsResponseEvidenceOut(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      EVIDENCE_OUT_ID: json['EVIDENCE_OUT_ID'],
    );
  }
}
