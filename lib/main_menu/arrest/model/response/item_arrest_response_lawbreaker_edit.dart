class ItemsArrestResponseLawbreakerEdit {
  final String IsSuccess;
  final String Msg;
  final List<ItemsArrestLawbreaker> ArrestLawbreaker;

  ItemsArrestResponseLawbreakerEdit({
    this.IsSuccess,
    this.Msg,
    this.ArrestLawbreaker,
  });

  factory ItemsArrestResponseLawbreakerEdit.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseLawbreakerEdit(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      ArrestLawbreaker: List<ItemsArrestLawbreaker>.from(json['ArrestLawbreaker'].map((m) => ItemsArrestLawbreaker.fromJson(m))),
    );
  }
}

class ItemsArrestLawbreaker {
  final int LAWBREAKER_ID;
  final int PERSON_ID;

  ItemsArrestLawbreaker({
    this.LAWBREAKER_ID,
    this.PERSON_ID,
  });

  factory ItemsArrestLawbreaker.fromJson(Map<String, dynamic> json) {
    return ItemsArrestLawbreaker(
      LAWBREAKER_ID: json['LAWBREAKER_ID'],
      PERSON_ID: json['PERSON_ID'],
    );
  }
}
