class ItemsInfoPrcInq {
  final String ProductCode;
  final String BrandMainCode;
  final String BrandMainTha;
  final String BrandMainEng;
  final String BrandSecondCode;
  final String BrandSecondNameTha;
  final String BrandSecondNameEng;
  final String ModelCode;
  final String ModelName;
  final String SizeCode;
  final String SizeDesc;
  final String SizeUnit;
  final String DegreeCode;
  final String Degree;
  final String UnitCode;
  final String UnitName;
  final String Barcode;
  final String RetailPrice;
  final String ExciseProductCode;
  final String ProductName;
  final String ExciseRegistrationNo;
  final String CompanyName;
  final String ProductGroupCode;
  final String ProductGroupName;
  final String ProductCategoryCode;
  final String ProductCategoryName;
  final String SugarQuantity;
  final String Co2Quantity;
  final String Weight;
  final String TypeSellCode;
  final String EffectiveDate;

  ItemsInfoPrcInq({
    this.ProductCode,
    this.BrandMainCode,
    this.BrandMainTha,
    this.BrandMainEng,
    this.BrandSecondCode,
    this.BrandSecondNameTha,
    this.BrandSecondNameEng,
    this.ModelCode,
    this.ModelName,
    this.SizeCode,
    this.SizeDesc,
    this.SizeUnit,
    this.DegreeCode,
    this.Degree,
    this.UnitCode,
    this.UnitName,
    this.Barcode,
    this.RetailPrice,
    this.ExciseProductCode,
    this.ProductName,
    this.ExciseRegistrationNo,
    this.CompanyName,
    this.ProductGroupCode,
    this.ProductGroupName,
    this.ProductCategoryCode,
    this.ProductCategoryName,
    this.SugarQuantity,
    this.Co2Quantity,
    this.Weight,
    this.TypeSellCode,
    this.EffectiveDate,
  });
  factory ItemsInfoPrcInq.fromJson(Map<String, dynamic> js) {
    return ItemsInfoPrcInq(
      ProductCode: js['ProductCode'],
      BrandMainCode: js['BrandMainCode'],
      BrandMainTha: js['BrandMainTha'],
      BrandMainEng: js['BrandMainEng'],
      BrandSecondCode: js['BrandSecondCode'],
      BrandSecondNameTha: js['BrandSecondNameTha'],
      BrandSecondNameEng: js['BrandSecondNameEng'],
      ModelCode: js['ModelCode'],
      ModelName: js['ModelName'],
      SizeCode: js['SizeCode'],
      SizeDesc: js['SizeDesc'],
      SizeUnit: js['SizeUnit'],
      DegreeCode: js['DegreeCode'],
      Degree: js['Degree'],
      UnitCode: js['UnitCode'],
      UnitName: js['UnitName'],
      Barcode: js['Barcode'],
      RetailPrice: js['RetailPrice'],
      ExciseProductCode: js['ExciseProductCode'],
      ProductName: js['ProductName'],
      ExciseRegistrationNo: js['ExciseRegistrationNo'],
      CompanyName: js['CompanyName'],
      ProductGroupCode: js['ProductGroupCode'],
      ProductGroupName: js['ProductGroupName'],
      ProductCategoryCode: js['ProductCategoryCode'],
      ProductCategoryName: js['ProductCategoryName'],
      SugarQuantity: js['SugarQuantity'],
      Co2Quantity: js['Co2Quantity'],
      Weight: js['Weight'],
      TypeSellCode: js['TypeSellCode'],
      EffectiveDate: js['EffectiveDate'],
    );
  }
}
