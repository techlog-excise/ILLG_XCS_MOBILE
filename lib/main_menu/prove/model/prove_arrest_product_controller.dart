import 'package:flutter/cupertino.dart';

class ItemsProveArrestProductController {
  TextEditingController editQuantity;
  TextEditingController editVolume;
  FocusNode myFocusNodeQuantity;
  FocusNode myFocusNodeVolume;
  double Quantity;
  double Volume;
  ItemsProveArrestProductController(
      this.editQuantity,
      this.editVolume,
      this.myFocusNodeQuantity,
      this.myFocusNodeVolume,
      this.Quantity,
      this.Volume,
      );
}