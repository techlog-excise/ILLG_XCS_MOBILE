

class ItemsArrestResponseProveinsAll {
  final String IsSuccess;
  final String Msg;
  final int PROVE_ID ;

  ItemsArrestResponseProveinsAll({
    this.IsSuccess,
    this.Msg,
    this.PROVE_ID ,
  });

  factory ItemsArrestResponseProveinsAll.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseProveinsAll(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      PROVE_ID : json['PROVE_ID'],
    );
  }
}
class ItemsArrestResponseProveStaffinsAll {
  final String IsSuccess;
  final String Msg;
  final int STAFF_ID ;

  ItemsArrestResponseProveStaffinsAll({
    this.IsSuccess,
    this.Msg,
    this.STAFF_ID ,
  });

  factory ItemsArrestResponseProveStaffinsAll.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseProveStaffinsAll(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      STAFF_ID : json['STAFF_ID'],
    );
  }
}

class ItemsArrestResponseProveScienceinsAll {
  final String IsSuccess;
  final String Msg;
  final int SCIENCE_ID;

  ItemsArrestResponseProveScienceinsAll({
    this.IsSuccess,
    this.Msg,
    this.SCIENCE_ID,
  });

  factory ItemsArrestResponseProveScienceinsAll.fromJson(
      Map<String, dynamic> json) {
    return ItemsArrestResponseProveScienceinsAll(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      SCIENCE_ID: json['SCIENCE_ID'],
    );
  }
}
class ItemsArrestResponseProveProductAll {
  final String IsSuccess;
  final String Msg;
  final int PRODUCT_ID;

  ItemsArrestResponseProveProductAll({
    this.IsSuccess,
    this.Msg,
    this.PRODUCT_ID,
  });

  factory ItemsArrestResponseProveProductAll.fromJson(
      Map<String, dynamic> json) {
    return ItemsArrestResponseProveProductAll(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      PRODUCT_ID: json['PRODUCT_ID'],
    );
  }
}

class ItemsArrestResponseProveLawbreakerinsAll {
  final String IsSuccess;
  final String Msg;
  final int LAWBREAKER_ID;

  ItemsArrestResponseProveLawbreakerinsAll({
    this.IsSuccess,
    this.Msg,
    this.LAWBREAKER_ID,
  });

  factory ItemsArrestResponseProveLawbreakerinsAll.fromJson(
      Map<String, dynamic> json) {
    return ItemsArrestResponseProveLawbreakerinsAll(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      LAWBREAKER_ID: json['LAWBREAKER_ID'],
    );
  }
}

class ItemsArrestResponseProveMessage {
  final String IsSuccess;
  final String Msg;

  ItemsArrestResponseProveMessage({
    this.IsSuccess,
    this.Msg,
  });

  factory ItemsArrestResponseProveMessage.fromJson(
      Map<String, dynamic> json) {
    return ItemsArrestResponseProveMessage(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
    );
  }
}

class ItemsArrestResponseProveEvidence {
  final String IsSuccess;
  final String Msg;
  final int EVIDENCE_IN_ID;

  ItemsArrestResponseProveEvidence({
    this.IsSuccess,
    this.Msg,
    this.EVIDENCE_IN_ID,
  });

  factory ItemsArrestResponseProveEvidence.fromJson(
      Map<String, dynamic> json) {
    return ItemsArrestResponseProveEvidence(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      EVIDENCE_IN_ID: json['EVIDENCE_IN_ID'],
    );
  }
}
