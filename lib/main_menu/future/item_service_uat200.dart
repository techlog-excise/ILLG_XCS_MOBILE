
class ItemsListServiceUAT200Response {
  final String ResponseCode;
  final String ResponseMessage;
  final ItemsListFactoryInfo ResponseData;

  ItemsListServiceUAT200Response({
    this.ResponseCode,
    this.ResponseMessage,
    this.ResponseData,
  });
  factory ItemsListServiceUAT200Response.fromJson(Map<String, dynamic> js) {
    return ItemsListServiceUAT200Response(
      ResponseCode: js['ResponseCode'],
      ResponseMessage: js['ResponseMessage'],
      ResponseData: js['ResponseMessage'].toString().trim().endsWith("ไม่พบข้อมูลตามเงื่อนไขที่ระบุ")
          ?null
          :ItemsListFactoryInfo.fromJson(js['ResponseData']['FactoryInfo']),
    );
  }
}
class ItemsListFactoryInfo {
  final String NewregId;
  final FirstName;
  final String Name;
  final String Pin;
  final List<ItemsListAddress> Address;

  ItemsListFactoryInfo({
    this.NewregId,
    this.FirstName,
    this.Name,
    this.Pin,
    this.Address,
  });
  factory ItemsListFactoryInfo.fromJson(Map<String, dynamic> js) {
    return ItemsListFactoryInfo(
      NewregId: js['NewregId'],
      FirstName: js['FirstName'],
      Name: js['Name'],
      Pin: js['Pin'],
      Address: List<ItemsListAddress>.from(js['Address'].map((m) => ItemsListAddress.fromJson(m))),
    );
  }
}

class ItemsListAddress {
  final String BuildingName;
  final String RoomIdentifier;
  final String FloorIdentifier;
  final String VillageName;
  final String MooIdentifier;
  final String SoiName;
  final String StreetName;
  final String SubDistrictCode;

  ItemsListAddress({
    this.BuildingName,
    this.RoomIdentifier,
    this.FloorIdentifier,
    this.VillageName,
    this.MooIdentifier,
    this.SoiName,
    this.StreetName,
    this.SubDistrictCode,
  });

  factory ItemsListAddress.fromJson(Map<String, dynamic> js) {
    return ItemsListAddress(
      BuildingName: js['BuildingName'],
      RoomIdentifier: js['RoomIdentifier'],
      FloorIdentifier: js['FloorIdentifier'],
      VillageName: js['VillageName'],
      MooIdentifier: js['MooIdentifier'],
      SoiName: js['SoiName'],
      StreetName: js['StreetName'],
      SubDistrictCode: js['SubDistrictCode'],
    );
  }
}