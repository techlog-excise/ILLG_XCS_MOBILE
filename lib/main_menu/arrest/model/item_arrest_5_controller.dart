
import 'package:flutter/cupertino.dart';

import 'master/item_master_response.dart';
import 'master/item_product_size.dart';
import 'master/item_product_unit.dart';

class ItemsListArrest5Controller {
  TextEditingController editSize;
  TextEditingController editQuantity;
  TextEditingController editVolume;
  TextEditingController editQuantityUnit;
  TextEditingController editVolumeUnit;
  TextEditingController editProductDesc;
  FocusNode myFocusNodeSize;
  FocusNode myFocusNodeQuantity;
  FocusNode myFocusNodeVolume;
  FocusNode myFocusNodeQuantityUnit;
  FocusNode myFocusNodeVolumeUnit;
  FocusNode myFocusNodeProductDesc;

  ItemsMasProductSizeResponse dropdownItemsSizeUnit;
  ItemsMasProductUnitResponse dropdownItemsQuantityUnit;
  ItemsListProductSize dropdownValueSizeUnit;
  ItemsListProductUnit dropdownValueQuantityUnit;
  /*List<String> dropdownItemsSizeUnit;
  List<String> dropdownItemsQuantityUnit;
  String dropdownValueSizeUnit;
  String dropdownValueQuantityUnit;*/
  ItemsListArrest5Controller(
      this.editSize,
      this.editQuantity,
      this.editVolume,
      this.editQuantityUnit,
      this.editVolumeUnit,
      this.editProductDesc,

      this.myFocusNodeSize,
      this.myFocusNodeQuantity,
      this.myFocusNodeVolume,
      this.myFocusNodeQuantityUnit,
      this.myFocusNodeVolumeUnit,
      this.myFocusNodeProductDesc,

      this.dropdownItemsSizeUnit,
      this.dropdownItemsQuantityUnit,
      this.dropdownValueSizeUnit,
      this.dropdownValueQuantityUnit,
      );
}