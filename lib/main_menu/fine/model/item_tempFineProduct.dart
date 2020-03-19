import 'package:flutter/material.dart';

class ItemsTempFineProduct {
  int PRODUCT_GROUP_ID;
  String PRODUCT_GROUP_NAME;
  double TAX;
  int TIMES;
  // double FINE_RATE;
  // String FINE_RATE;
  int FINE_RATE;
  double FINE_AMOUNT;
  TextEditingController CONTROLLER_TIMES;
  TextEditingController CONTROLLER_FINE_RATE;
  FocusNode FOCUS;
  FocusNode FOCUS_FINE_RATE;

  ItemsTempFineProduct(
    this.PRODUCT_GROUP_ID,
    this.PRODUCT_GROUP_NAME,
    this.TAX,
    this.TIMES,
    this.FINE_RATE,
    this.FINE_AMOUNT,
    this.CONTROLLER_TIMES,
    this.CONTROLLER_FINE_RATE,
    this.FOCUS,
    this.FOCUS_FINE_RATE,
  );
}
