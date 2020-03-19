import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_lawbreaker.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_country.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_distinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_brand.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_category.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_subsettype.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_subtype.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_type.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_province.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_subdistinct.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_title.dart';

import 'item_division_rate.dart';
import 'item_nationality.dart';
import 'item_product_model.dart';
import 'item_product_size.dart';
import 'item_product_sub_brand.dart';
import 'item_product_unit.dart';
import 'item_race.dart';
import 'item_warehouse.dart';

class ItemsMasterTitleResponse {
  final List<ItemsListTitle> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterTitleResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterTitleResponse.fromJson(Map<String, dynamic> js) {
    return ItemsMasterTitleResponse(
      RESPONSE_DATA: List<ItemsListTitle>.from(
          js['RESPONSE_DATA'].map((m) => ItemsListTitle.fromJson(m))),
      SUCCESS: js['SUCCESS'],
    );
  }
}
class ItemsMasterCountryResponse {
  final List<ItemsListCountry> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterCountryResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterCountryResponse.fromJson(Map<String, dynamic> js) {
    return ItemsMasterCountryResponse(
      RESPONSE_DATA: List<ItemsListCountry>.from(
          js['RESPONSE_DATA'].map((m) => ItemsListCountry.fromJson(m))),
      SUCCESS: js['SUCCESS'],
    );
  }
}
class ItemsMasterProvinceResponse {
  final List<ItemsListProvince> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProvinceResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProvinceResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProvinceResponse(
      RESPONSE_DATA: List<ItemsListProvince>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProvince.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterDistictResponse {
  final List<ItemsListDistict> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterDistictResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterDistictResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterDistictResponse(
      RESPONSE_DATA: List<ItemsListDistict>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListDistict.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterSubDistictResponse {
  final List<ItemsListSubDistict> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterSubDistictResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterSubDistictResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterSubDistictResponse(
      RESPONSE_DATA: List<ItemsListSubDistict>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListSubDistict.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterPersonResponseData {
  final int RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterPersonResponseData({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterPersonResponseData.fromJson(Map<String, dynamic> json) {
    return ItemsMasterPersonResponseData(
      RESPONSE_DATA: json['RESPONSE_DATA'],
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterPersonResponseEmpty {
  final dynamic RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterPersonResponseEmpty({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterPersonResponseEmpty.fromJson(Map<String, dynamic> json) {
    return ItemsMasterPersonResponseEmpty(
      RESPONSE_DATA: json['RESPONSE_DATA'],
      SUCCESS: json['SUCCESS'],
    );
  }
}

class ItemsMasterGetPersonResponse {
  final List<ItemsListArrestLawbreaker>  RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterGetPersonResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterGetPersonResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterGetPersonResponse(
      RESPONSE_DATA: List<ItemsListArrestLawbreaker>.from(json['RESPONSE_DATA'].map((m) => ItemsListArrestLawbreaker.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}


//product
class ItemsMasterProductGroupResponse {
  final List<ItemsListProductGroup> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductGroupResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductGroupResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductGroupResponse(
      RESPONSE_DATA: List<ItemsListProductGroup>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductGroup.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterProductCategoryResponse {
  final List<ItemsListProductCategory> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductCategoryResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductCategoryResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductCategoryResponse(
      RESPONSE_DATA: List<ItemsListProductCategory>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductCategory.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterProductTypeResponse {
  final List<ItemsListProductType> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductTypeResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductTypeResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductTypeResponse(
      RESPONSE_DATA: List<ItemsListProductType>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductType.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterProductSubTypeResponse {
  final List<ItemsListProductSubType> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductSubTypeResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductSubTypeResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductSubTypeResponse(
      RESPONSE_DATA: List<ItemsListProductSubType>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductSubType.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterProductSubSetTypeResponse {
  final List<ItemsListProductSubSetType> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductSubSetTypeResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductSubSetTypeResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductSubSetTypeResponse(
      RESPONSE_DATA: List<ItemsListProductSubSetType>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductSubSetType.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterProductBrandResponse {
  final List<ItemsListProductBrand> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductBrandResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductBrandResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductBrandResponse(
      RESPONSE_DATA: List<ItemsListProductBrand>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductBrand.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}

class ItemsMasterProductSubBrandResponse {
  final List<ItemsListProductSubBrand> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductSubBrandResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductSubBrandResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductSubBrandResponse(
      RESPONSE_DATA: List<ItemsListProductSubBrand>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductSubBrand.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}

class ItemsMasterProductModelResponse {
  final List<ItemsListProductModel> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductModelResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductModelResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductModelResponse(
      RESPONSE_DATA: List<ItemsListProductModel>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductModel.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}

class ItemsMasterProductMappingResponse {
  final List RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductMappingResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductMappingResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductMappingResponse(
      RESPONSE_DATA: List.from(
          json['RESPONSE_DATA'].map((m) => ItemsListArrestProductMapping.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}

class ItemsMasterProductResponse {
  final int RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterProductResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterProductResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterProductResponse(
      RESPONSE_DATA:json['RESPONSE_DATA'],
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasterDivisionRateResponse {
  final List<ItemsListDivisionRate> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasterDivisionRateResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasterDivisionRateResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasterDivisionRateResponse(
      RESPONSE_DATA:List<ItemsListDivisionRate>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListDivisionRate.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}

/*class ItemsGetMasterProductMappingResponse {
  final String IsSuccess;
  final String Msg;
  final int PRODUCT_MAPPING_ID;

  ItemsGetMasterProductMappingResponse({
    this.IsSuccess,
    this.Msg,
    this.PRODUCT_MAPPING_ID,
  });

  factory ItemsGetMasterProductMappingResponse.fromJson(Map<String, dynamic> json) {
    return ItemsGetMasterProductMappingResponse(
      IsSuccess:json['IsSuccess'],
      Msg: json['Msg'],
      PRODUCT_MAPPING_ID: json['PRODUCT_MAPPING_ID'],
    );
  }
}*/

class ItemsMasProductSizeResponse {
  /*final List<ItemsListProductSize> RESPONSE_DATA;
  final bool SUCCESS;*/
  List<ItemsListProductSize> RESPONSE_DATA;
  bool SUCCESS;

  ItemsMasProductSizeResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasProductSizeResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasProductSizeResponse(
      RESPONSE_DATA:List<ItemsListProductSize>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductSize.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasProductUnitResponse {
  final List<ItemsListProductUnit> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasProductUnitResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasProductUnitResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasProductUnitResponse(
      RESPONSE_DATA:List<ItemsListProductUnit>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListProductUnit.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}

class ItemsMasNationalityResponse {
  final List<ItemsListNational> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasNationalityResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasNationalityResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasNationalityResponse(
      RESPONSE_DATA:List<ItemsListNational>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListNational.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}
class ItemsMasRaceResponse {
  final List<ItemsListRace> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasRaceResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasRaceResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasRaceResponse(
      RESPONSE_DATA:List<ItemsListRace>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListRace.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}


class ItemsMasWarehouseResponse {
  final List<ItemsListWarehouse> RESPONSE_DATA;
  final bool SUCCESS;

  ItemsMasWarehouseResponse({
    this.RESPONSE_DATA,
    this.SUCCESS,
  });

  factory ItemsMasWarehouseResponse.fromJson(Map<String, dynamic> json) {
    return ItemsMasWarehouseResponse(
      RESPONSE_DATA:List<ItemsListWarehouse>.from(
          json['RESPONSE_DATA'].map((m) => ItemsListWarehouse.fromJson(m))),
      SUCCESS: json['SUCCESS'],
    );
  }
}

