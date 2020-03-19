
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';

class ItemsListArrest6Controller {
  TextEditingController editFine;
  TextEditingController editQuantity;
  TextEditingController editVolume;
  TextEditingController editQuantityUnit;
  TextEditingController editVolumeUnit;
  FocusNode myFocusNodeFine;
  FocusNode myFocusNodeQuantity;
  FocusNode myFocusNodeVolume;
  FocusNode myFocusNodeQuantityUnit;
  FocusNode myFocusNodeVolumeUnit;

  //adding19072019
  bool isErrorQuantity;
  bool isErrorVolume;

  ItemsListArrest6Controller(
      this.editFine,
      this.editQuantity,
      this.editVolume,
      this.editQuantityUnit,
      this.editVolumeUnit,
      this.myFocusNodeFine,
      this.myFocusNodeQuantity,
      this.myFocusNodeVolume,
      this.myFocusNodeQuantityUnit,
      this.myFocusNodeVolumeUnit,

      this.isErrorQuantity,
      this.isErrorVolume,
      );
}