class ItemsArrestResponseEvidence {
  final String IsSuccess;
  final String Msg;
  final int EVIDENCE_IN_ID;

  ItemsArrestResponseEvidence({
    this.IsSuccess,
    this.Msg,
    this.EVIDENCE_IN_ID,
  });

  factory ItemsArrestResponseEvidence.fromJson(
      Map<String, dynamic> json) {
    return ItemsArrestResponseEvidence(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      EVIDENCE_IN_ID: json['EVIDENCE_IN_ID'],
    );
  }
}
