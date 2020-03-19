

class ItemsArrestResponseLawsuitinsAll {
  final String IsSuccess;
  final String Msg;
  final int LAWSUIT_ID;
  final List<ItemsArrestResponseLawsuitLawsuitStaff> LawsuitStaff;
  final List<ItemsArrestResponseLawsuitLawsuitDetail> LawsuitDetail;

  ItemsArrestResponseLawsuitinsAll({
    this.IsSuccess,
    this.Msg,
    this.LAWSUIT_ID,
    this.LawsuitStaff,
    this.LawsuitDetail,
  });

  factory ItemsArrestResponseLawsuitinsAll.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseLawsuitinsAll(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      LAWSUIT_ID: json['IsSuccess'].toString().endsWith("True")
          ?json['LAWSUIT_ID']
          :null,
      LawsuitStaff: json['IsSuccess'].toString().endsWith("True")
          ?List.from(json['LawsuitStaff'].map((m) => ItemsArrestResponseLawsuitLawsuitStaff.fromJson(m)))
          :null,
      LawsuitDetail: json['IsSuccess'].toString().endsWith("True")
          ?List.from(json['LawsuitDetail'].map((m) => ItemsArrestResponseLawsuitLawsuitDetail.fromJson(m)))
          :null,
    );
  }
}

class ItemsArrestResponseLawsuitLawsuitStaff {
  final int STAFF_ID;

  ItemsArrestResponseLawsuitLawsuitStaff({
    this.STAFF_ID,
  });

  factory ItemsArrestResponseLawsuitLawsuitStaff.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseLawsuitLawsuitStaff(
      STAFF_ID: json['STAFF_ID'],
    );
  }
}

class ItemsArrestResponseLawsuitLawsuitDetail {
  final int LAWSUIT_DETAIL_ID;

  ItemsArrestResponseLawsuitLawsuitDetail({
    this.LAWSUIT_DETAIL_ID,
  });

  factory ItemsArrestResponseLawsuitLawsuitDetail.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseLawsuitLawsuitDetail(
      LAWSUIT_DETAIL_ID: json['LAWSUIT_DETAIL_ID'],
    );
  }
}

class ItemsArrestResponseLawsuitMistreatNoupdByCon {
  final String IsSuccess;
  final String Msg;
  final int MISTREAT_NO;

  ItemsArrestResponseLawsuitMistreatNoupdByCon({
    this.IsSuccess,
    this.Msg,
    this.MISTREAT_NO,
  });

  factory ItemsArrestResponseLawsuitMistreatNoupdByCon.fromJson(Map<String, dynamic> json) {
    return ItemsArrestResponseLawsuitMistreatNoupdByCon(
      IsSuccess: json['IsSuccess'],
      Msg: json['Msg'],
      MISTREAT_NO: json['MISTREAT_NO'],
    );
  }
}