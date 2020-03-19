class ItemsListServiceUAT100Response {
  final String ResponseCode;
  final String ResponseMessage;
  final List<ItemsListResponseData> ResponseData;

  ItemsListServiceUAT100Response({
    this.ResponseCode,
    this.ResponseMessage,
    this.ResponseData,
  });
  factory ItemsListServiceUAT100Response.fromJson(Map<String, dynamic> js) {
    return ItemsListServiceUAT100Response(
      ResponseCode: js['ResponseCode'],
      ResponseMessage: js['ResponseMessage'],
      ResponseData: js['ResponseMessage'].toString().trim().endsWith("ไม่พบข้อมูลตามเงื่อนไขที่ระบุ") ? [] : List<ItemsListResponseData>.from(js['ResponseData'].map((m) => ItemsListResponseData.fromJson(m))),
    );
  }
}

class ItemsListResponseData {
  final ItemsListCustomerInfo CustomerInfo;
  final List<ItemsListFactoryInfo100> ListFactoryInfo;

  ItemsListResponseData({this.CustomerInfo, this.ListFactoryInfo});

  factory ItemsListResponseData.fromJson(Map<String, dynamic> js) {
    return ItemsListResponseData(
      CustomerInfo: ItemsListCustomerInfo.fromJson(js['CustomerInfo']),
      ListFactoryInfo: List<ItemsListFactoryInfo100>.from(js['FactoryEntry']['FactoryInfo'].map((m) => ItemsListFactoryInfo100.fromJson(m))),
    );
  }
}

class ItemsListCustomerInfo {
  final String CusId;
  final String CusSeq;
  final String TitleCode;
  final String FirstName;
  final String SurName;
  final String Name;
  final String ClientType;
  final String Tin;
  final String NitiId;

  ItemsListCustomerInfo({
    this.CusId,
    this.CusSeq,
    this.TitleCode,
    this.FirstName,
    this.SurName,
    this.Name,
    this.ClientType,
    this.Tin,
    this.NitiId,
  });
  factory ItemsListCustomerInfo.fromJson(Map<String, dynamic> js) {
    return ItemsListCustomerInfo(
      CusId: js['CusId'],
      CusSeq: js['CusSeq'],
      TitleCode: js['TitleCode'],
      FirstName: js['FirstName'],
      SurName: js['SurName'],
      Name: js['Name'],
      ClientType: js['ClientType'],
      Tin: js['Tin'],
      NitiId: js['NitiId'],
    );
  }
}

class ItemsListFactoryInfo100 {
  final String FacId;
  final String RegId;
  final String NewregId;
  final String TitleCode;
  final String Name;
  final String Email;
  final String HomeOffice;
  final String TaxpayerClass;
  final String ActiveFlag;
  bool IsCheck;

  ItemsListFactoryInfo100({
    this.FacId,
    this.RegId,
    this.NewregId,
    this.TitleCode,
    this.Name,
    this.Email,
    this.HomeOffice,
    this.TaxpayerClass,
    this.ActiveFlag,
    this.IsCheck,
  });
  factory ItemsListFactoryInfo100.fromJson(Map<String, dynamic> js) {
    return ItemsListFactoryInfo100(FacId: js['FacId'], RegId: js['RegId'], NewregId: js['NewregId'], TitleCode: js['TitleCode'], Name: js['Name'], Email: js['Email'], HomeOffice: js['HomeOffice'], TaxpayerClass: js['TaxpayerClass'], IsCheck: false);
  }
}
