class ItemsListProductGROUPCategorySRP {
  final String GROUP_ID;
  final String GROUP_NAME;
  final String GROUP_STATUS;
  final String SUP_GROUP_ID;
  final String BEGIN_DATE;
  final String UPD_USERID;
  final String UPD_DATE;

  ItemsListProductGROUPCategorySRP({
    this.GROUP_ID,
    this.GROUP_NAME,
    this.GROUP_STATUS,
    this.SUP_GROUP_ID,
    this.BEGIN_DATE,
    this.UPD_USERID,
    this.UPD_DATE,
  });

  factory ItemsListProductGROUPCategorySRP.fromJson(Map<String, dynamic> json) {
    return ItemsListProductGROUPCategorySRP(
      GROUP_ID: json['GROUP_ID'],
      GROUP_NAME: json['GROUP_NAME'],
      GROUP_STATUS: json['GROUP_STATUS'],
      SUP_GROUP_ID: json['SUP_GROUP_ID'],
      BEGIN_DATE: json['BEGIN_DATE'],
      UPD_USERID: json['UPD_USERID'],
      UPD_DATE: json['UPD_DATE'],
    );
  }
}
