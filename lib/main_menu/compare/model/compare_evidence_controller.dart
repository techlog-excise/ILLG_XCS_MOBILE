import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';

class ItemsCompareEvidenceTaxValue {
  double TaxValue;
  double FineValue;
  double Payment;
  double Total;
  TextEditingController editTaxValueDouble;
  ExpandableController expController;
  FocusNode myFocusNodeTaxValueDouble;
  TextEditingController editTaxValue;
  TextEditingController editFineValue;
  TextEditingController editPayment;
  bool IsErrorFineRate;

  //มูลค่าภาษี

  ItemsCompareEvidenceTaxValue(
      this.TaxValue,
      this.FineValue,
      this.Payment,
      this.Total,
      this.editTaxValueDouble,
      this.expController,
      this.myFocusNodeTaxValueDouble,
      this.editTaxValue,
      this.editFineValue,
      this.editPayment,
      this.IsErrorFineRate,
      );
}