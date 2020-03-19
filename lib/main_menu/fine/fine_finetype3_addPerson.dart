import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawGroupSubSection.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_finePeople.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_finePeoplePage2.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_fineProduct.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_fineProduct2.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_finrProductInitForEdit.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_tempFinePeople.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_tempFineProduct.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class FineFineType3AddPerson extends StatefulWidget {
  ItemsMasLawGroupSubSection itemsLaw;
  List itemDataProduct;
  List itemDataGuiltbaseFine;
  List itemDataPenalty;
  bool onEdit;
  List<ItemsFineProductInitForEdit> itemProductInit;
  List<ItemsFinePeoplePage2> itemPeoplePage2;
  @override
  FineFineType3AddPerson({
    Key key,
    @required this.itemsLaw,
    @required this.itemDataProduct,
    @required this.itemDataGuiltbaseFine,
    @required this.itemDataPenalty,
    @required this.onEdit,
    @required this.itemProductInit,
    @required this.itemPeoplePage2,
  }) : super(key: key);
  _FineFineType3AddPerson createState() => new _FineFineType3AddPerson();
}

class _FineFineType3AddPerson extends State<FineFineType3AddPerson> {
  Color labelColor = Color(0xff087de1);

  TextStyle appBarStyle = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleTitle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyleSub = Styles.textStyleData;
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textTitleContent2Black = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily, fontWeight: FontWeight.w600);
  TextStyle textTitleContent2Blue = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily, fontWeight: FontWeight.w600);

  TextStyle textSumStyle = TextStyle(fontSize: 20.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textLabelDelete = TextStyle(fontSize: 16.0, color: Colors.red, fontFamily: FontStyles().FontFamily);

  EdgeInsets paddingLabelMain = EdgeInsets.only(top: 24.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 0.0, bottom: 0.0);

  final formatter = new NumberFormat("#,##0.0000");
  final formatterFineRate = new NumberFormat("#,##0.00");
  final formatTime = new NumberFormat("#,##0");

  GlobalKey<ScaffoldState> _key;

  ItemsMasLawGroupSubSection _itemInit;

  List tempItemDataGuiltbaseFine = [];
  List tempItemDataPenalty = [];
  List _listProductID = [];
  double fine_min = 0.0;
  double fine_max = 0.0;
  int fineRate_min = 0;
  int fineRate_max = 0;
  double sumTotal = 0.0;
  bool listExpandContent1 = false;

  List<ItemsFinePeople> tempItemsFinePeople = [];
  List<ItemsFineProduct> productFromPrevious = [];

  List<bool> listExpand = [];

  List<ItemsTempFinePeople> itemPeople = [];
  List<ItemsTempFineProduct> itemProduct = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // When user press arrow down keyboard
    _key = GlobalKey<ScaffoldState>();
    KeyboardVisibilityNotification().addNewListener(onHide: () {
      if (itemPeople.length > 0) {
        itemPeople.forEach((f) {
          double sumTotal = 0.0;

          for (var i = 0; i < f.itemsFineProduct.length; i++) {
            if (f.itemsFineProduct[i].FINE_RATE >= fineRate_min && fineRate_max >= f.itemsFineProduct[i].FINE_RATE) {
              f.itemsFineProduct[i].FINE_RATE = f.itemsFineProduct[i].FINE_RATE;

              double sum = 0.0;
              sum = double.parse((Decimal.parse(f.itemsFineProduct[i].TAX.toString()) * Decimal.parse(f.itemsFineProduct[i].FINE_RATE.toString())).toStringAsFixed(2));

              if (fine_min > fine_max) {
                if (fine_min > sum) {
                  f.itemsFineProduct[i].FINE_AMOUNT = fine_min;
                } else {
                  f.itemsFineProduct[i].FINE_AMOUNT = sum;
                }
              } else {
                f.itemsFineProduct[i].FINE_AMOUNT = sum;
              }
            } else {
              new EmptyDialog(context, "จำนวนค่าปรับเท่าต้องอยู่ในระหว่างอัตราโทษ");
              f.itemsFineProduct[i].TIMES = 1;
              f.itemsFineProduct[i].CONTROLLER_TIMES.text = "1";

              if (_listProductID.contains(f.itemsFineProduct[i].PRODUCT_GROUP_ID)) {
                for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                  if (f.itemsFineProduct[i].PRODUCT_GROUP_ID == tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID) {
                    if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && f.itemsFineProduct[i].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                      f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                      // print("FINE_RATE 1::${f.itemsFineProduct[i].FINE_RATE}");
                      break;
                    } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == 0) {
                      f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                      // print("FINE_RATE 2::${f.itemsFineProduct[i].FINE_RATE}");
                      break;
                    } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == f.itemsFineProduct[i].TIMES && f.itemsFineProduct[i].TIMES == tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO) {
                      f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                      // print("FINE_RATE 3::${f.itemsFineProduct[i].FINE_RATE}");
                      break;
                    }
                    // print("FINE_RATE: ${f.itemsFineProduct[i].FINE_RATE}");
                  }
                }
              } else {
                for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                  if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == f.itemsFineProduct[i].TIMES && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == f.itemsFineProduct[i].TIMES && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                    f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                    // print("FINE_RATE ETC 1::${f.itemsFineProduct[i].FINE_RATE}");
                    break;
                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                    if (f.itemsFineProduct[i].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                      f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                      // print("FINE_RATE ETC 3::${f.itemsFineProduct[i].FINE_RATE}");
                      break;
                    }
                  }
                }
              }

              // f.itemsFineProduct[i].FINE_RATE = fineRate_min;
              f.itemsFineProduct[i].CONTROLLER_FINE_RATE.text = fineRate_min.toString();
              f.itemsFineProduct[i].CONTROLLER_FINE_RATE.selection = TextSelection.fromPosition(TextPosition(offset: f.itemsFineProduct[i].CONTROLLER_FINE_RATE.text.length));
              f.itemsFineProduct[i].CONTROLLER_TIMES.selection = TextSelection.fromPosition(TextPosition(offset: f.itemsFineProduct[i].CONTROLLER_TIMES.text.length));

              double sum = 0.0;
              sum = f.itemsFineProduct[i].TAX * f.itemsFineProduct[i].FINE_RATE;
              if (fine_min > fine_max) {
                if (fine_min > sum) {
                  f.itemsFineProduct[i].FINE_AMOUNT = fine_min;
                } else {
                  f.itemsFineProduct[i].FINE_AMOUNT = sum;
                }
              } else {
                f.itemsFineProduct[i].FINE_AMOUNT = sum;
              }
            }

            f.itemsFineProduct[i].CONTROLLER_FINE_RATE.text = formatTime.format(num.parse(f.itemsFineProduct[i].FINE_RATE.toString()));
            f.itemsFineProduct[i].CONTROLLER_TIMES.text = formatTime.format(num.parse(f.itemsFineProduct[i].TIMES.toString()));
            f.itemsFineProduct[i].CONTROLLER_FINE_RATE.selection = TextSelection.fromPosition(TextPosition(offset: f.itemsFineProduct[i].CONTROLLER_FINE_RATE.text.length));
            f.itemsFineProduct[i].CONTROLLER_TIMES.selection = TextSelection.fromPosition(TextPosition(offset: f.itemsFineProduct[i].CONTROLLER_TIMES.text.length));
            setState(() {
              sumTotal = sumTotal + f.itemsFineProduct[i].FINE_AMOUNT;
              f.FINE_TOTAL = sumTotal;
            });
          }
        });
      }
    });

    _itemInit = widget.itemsLaw;
    // ======================= Add data GuiltbaseFine from widget =================
    (widget.itemDataGuiltbaseFine[0]).forEach((f) {
      tempItemDataGuiltbaseFine.add(f);
    });
    tempItemDataGuiltbaseFine.forEach((f) {
      _listProductID.add(f.PRODUCT_GROUP_ID);
    });
    // ============================================================================
    // ======================= Add data Penalty from widget =======================
    (widget.itemDataPenalty[0]).forEach((f) {
      tempItemDataPenalty.add(f);
    });
    tempItemDataPenalty.forEach((f) {
      fineRate_min = f.FINE_RATE_MIN.round();
      fineRate_max = f.FINE_RATE_MAX.round();
      fine_min = f.FINE_MIN;
      fine_max = f.FINE_MAX;
    });
    // ============================================================================
    if (widget.onEdit) {
      List<ItemsFinePeoplePage2> tempPeoplePage2 = [];

      List<ItemsTempFinePeople> tempPeople = [];
      List<ItemsTempFineProduct> tempProduct = [];

      for (var i = 0; i < widget.itemPeoplePage2.length; i++) {
        tempPeoplePage2.add(widget.itemPeoplePage2[i]);
      }

      for (var i = 0; i < tempPeoplePage2.length; i++) {
        tempProduct = [];
        itemPeople = [];
        sumTotal = 0.0;
        tempPeoplePage2[i].itemsFineProduct.forEach((f) {
          tempProduct.add(new ItemsTempFineProduct(
            f.PRODUCT_GROUP_ID,
            f.PRODUCT_GROUP_NAME,
            f.TAX,
            f.TIMES,
            f.FINE_RATE,
            f.FINE_AMOUNT,
            new TextEditingController(text: formatTime.format(num.parse(f.TIMES.toString()))),
            // new TextEditingController(text: formatterFineRate.format(num.parse(f.FINE_RATE.toString()))),
            new TextEditingController(text: f.FINE_RATE.toString()),
            new FocusNode(),
            new FocusNode(),
          ));
          sumTotal = sumTotal + f.FINE_AMOUNT;
        });
        itemPeople.add(new ItemsTempFinePeople(sumTotal, tempProduct));
        tempPeople += itemPeople;

        tempProduct.forEach((f) {
          f.FOCUS.addListener(_onFocusChange);
          f.FOCUS_FINE_RATE.addListener(_onFocusChange);
        });
      }

      itemPeople = tempPeople;
      for (var i = 0; i < itemPeople.length; i++) {
        if (i == 0) {
          listExpand.add(true);
        } else {
          listExpand.add(false);
        }
      }
    } else {
      // ======================= Add data product from widget =======================
      widget.itemDataProduct.forEach((f) {
        productFromPrevious.add(f);
      });

      for (var i = 0; i < productFromPrevious.length; i++) {
        itemProduct.add(new ItemsTempFineProduct(
          productFromPrevious[i].PRODUCT_GROUP_ID,
          productFromPrevious[i].PRODUCT_GROUP_NAME,
          productFromPrevious[i].TAX,
          productFromPrevious[i].TIMES,
          productFromPrevious[i].FINE_RATE,
          productFromPrevious[i].FINE_AMOUNT,
          new TextEditingController(text: formatTime.format(num.parse(productFromPrevious[i].TIMES.toString()))),
          // new TextEditingController(text: formatterFineRate.format(num.parse(productFromPrevious[i].FINE_RATE.toString()))),
          new TextEditingController(text: productFromPrevious[i].FINE_RATE.toString()),
          new FocusNode(),
          new FocusNode(),
        ));
        sumTotal = sumTotal + productFromPrevious[i].FINE_AMOUNT;
      }

      itemProduct.forEach((f) {
        f.FOCUS.addListener(_onFocusChange);
        f.FOCUS_FINE_RATE.addListener(_onFocusChange);
      });

      itemPeople.add(new ItemsTempFinePeople(sumTotal, itemProduct));
      listExpand.add(true);
      // ============================================================================
    }
  }

  void _onFocusChange() {
    itemPeople.forEach((f) {
      double sumTotal = 0.0;

      for (var i = 0; i < f.itemsFineProduct.length; i++) {
        if (f.itemsFineProduct[i].FINE_RATE >= fineRate_min && fineRate_max >= f.itemsFineProduct[i].FINE_RATE) {
          f.itemsFineProduct[i].FINE_RATE = f.itemsFineProduct[i].FINE_RATE;

          double sum = 0.0;
          sum = double.parse((Decimal.parse(f.itemsFineProduct[i].TAX.toString()) * Decimal.parse(f.itemsFineProduct[i].FINE_RATE.toString())).toStringAsFixed(2));

          if (fine_min > fine_max) {
            if (fine_min > sum) {
              f.itemsFineProduct[i].FINE_AMOUNT = fine_min;
            } else {
              f.itemsFineProduct[i].FINE_AMOUNT = sum;
            }
          } else {
            f.itemsFineProduct[i].FINE_AMOUNT = sum;
          }
        } else {
          new EmptyDialog(context, "จำนวนค่าปรับเท่าต้องอยู่ในระหว่างอัตราโทษ");
          f.itemsFineProduct[i].TIMES = 1;
          f.itemsFineProduct[i].CONTROLLER_TIMES.text = "1";

          if (_listProductID.contains(f.itemsFineProduct[i].PRODUCT_GROUP_ID)) {
            for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
              if (f.itemsFineProduct[i].PRODUCT_GROUP_ID == tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID) {
                if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && f.itemsFineProduct[i].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                  f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                  // print("FINE_RATE 1::${f.itemsFineProduct[i].FINE_RATE}");
                  break;
                } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == 0) {
                  f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                  // print("FINE_RATE 2::${f.itemsFineProduct[i].FINE_RATE}");
                  break;
                } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == f.itemsFineProduct[i].TIMES && f.itemsFineProduct[i].TIMES == tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO) {
                  f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                  // print("FINE_RATE 3::${f.itemsFineProduct[i].FINE_RATE}");
                  break;
                }
                // print("FINE_RATE: ${f.itemsFineProduct[i].FINE_RATE}");
              }
            }
          } else {
            for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
              if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == f.itemsFineProduct[i].TIMES && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == f.itemsFineProduct[i].TIMES && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                // print("FINE_RATE ETC 1::${f.itemsFineProduct[i].FINE_RATE}");
                break;
              } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                if (f.itemsFineProduct[i].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                  f.itemsFineProduct[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                  // print("FINE_RATE ETC 3::${f.itemsFineProduct[i].FINE_RATE}");
                  break;
                }
              }
            }
          }

          f.itemsFineProduct[i].CONTROLLER_FINE_RATE.text = fineRate_min.toString();
          // f.itemsFineProduct[i].FINE_RATE = fineRate_min;
          f.itemsFineProduct[i].CONTROLLER_FINE_RATE.selection = TextSelection.fromPosition(TextPosition(offset: f.itemsFineProduct[i].CONTROLLER_FINE_RATE.text.length));
          f.itemsFineProduct[i].CONTROLLER_TIMES.selection = TextSelection.fromPosition(TextPosition(offset: f.itemsFineProduct[i].CONTROLLER_TIMES.text.length));

          double sum = 0.0;
          sum = f.itemsFineProduct[i].TAX * f.itemsFineProduct[i].FINE_RATE;
          if (fine_min > fine_max) {
            if (fine_min > sum) {
              f.itemsFineProduct[i].FINE_AMOUNT = fine_min;
            } else {
              f.itemsFineProduct[i].FINE_AMOUNT = sum;
            }
          } else {
            f.itemsFineProduct[i].FINE_AMOUNT = sum;
          }
        }

        f.itemsFineProduct[i].CONTROLLER_FINE_RATE.text = formatTime.format(num.parse(f.itemsFineProduct[i].FINE_RATE.toString()));
        f.itemsFineProduct[i].CONTROLLER_TIMES.text = formatTime.format(num.parse(f.itemsFineProduct[i].TIMES.toString()));
        f.itemsFineProduct[i].CONTROLLER_FINE_RATE.selection = TextSelection.fromPosition(TextPosition(offset: f.itemsFineProduct[i].CONTROLLER_FINE_RATE.text.length));
        f.itemsFineProduct[i].CONTROLLER_TIMES.selection = TextSelection.fromPosition(TextPosition(offset: f.itemsFineProduct[i].CONTROLLER_TIMES.text.length));
        setState(() {
          sumTotal = sumTotal + f.itemsFineProduct[i].FINE_AMOUNT;
          f.FINE_TOTAL = sumTotal;
        });
      }
    });
  }

  @override
  void dispose() {
    itemPeople.forEach((f) {
      f.itemsFineProduct.forEach((f2) {
        f2.CONTROLLER_TIMES.dispose();
        f2.CONTROLLER_FINE_RATE.dispose();
        f2.FOCUS.dispose();
        f2.FOCUS_FINE_RATE.dispose();
      });
    });

    // TODO: implement dispose
    super.dispose();
  }

  // ==================================== build layout content1 ================================
  Widget _buildContent1(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    return Container(
      width: size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 14.0, bottom: 0.0),
          width: Width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  'ข้อมูลมาตรา',
                  style: textTitleContent2Black,
                ),
              ),
              Container(
                padding: paddingLabel,
                child: Text(
                  'บทลงโทษมาตรา',
                  style: textStyleTitle,
                ),
              ),
              Padding(
                padding: paddingInputBox,
                child: Text(
                  _itemInit.MasLawGroupSubSectionRule.first.MasLawPenalty.first.SECTION_ID.toString(),
                  // '101',
                  style: textInputStyleSub,
                ),
              ),
              listExpandContent1
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              'อัตราโทษ',
                              style: textStyleTitle,
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              _itemInit.MasLawGroupSubSectionRule.first.MasLawPenalty.first.PENALTY_DESC,
                              // '101',
                              style: textInputStyleSub,
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              'อัตราที่กำหนดให้ปรับ',
                              style: textStyleTitle,
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: Text(
                              _itemInit.MasLawGroupSubSectionRule.first.MasLawLawGuiltbase.first.FINE == null ? "-" : _itemInit.MasLawGroupSubSectionRule.first.MasLawLawGuiltbase.first.FINE,
                              // '101',
                              style: textInputStyleSub,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              Container(
                transform: Matrix4.translationValues(0.0, -18.0, 0.0),
                child: Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            listExpandContent1 = !listExpandContent1;
                          });
                        },
                        child: Text(
                          listExpandContent1 ? "ย่อ..." : "ดูเพิ่มเติม...",
                          style: textStyleTitle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // ===========================================================================================

  // ==================================== build layout content2 ================================
  Widget _buildContent2(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;

    return Container(
      padding: EdgeInsets.only(top: 14.0),
      width: size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 4.0),
          width: Width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: paddingLabel,
                child: Text(
                  'ข้อมูลของกลาง',
                  style: textTitleContent2Black,
                ),
              ),
              itemPeople.length > 0
                  ? _buildContentFineType3(context)
                  : Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                        child: Text(
                          "กรุณาเพิ่มผู้ต้องหา",
                          style: textInputStyle,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
  // ===========================================================================================

  Widget _buildContentFineType3(BuildContext context) {
    return new Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.0),
        child: ListView.builder(
          itemCount: itemPeople.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: index == 0 ? paddingLabel : paddingLabelMain,
                          child: Text(
                            'ผู้ต้องหาลำดับที่ ${index + 1}',
                            style: textTitleContent2Blue,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        // child: Center(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              itemPeople.removeAt(index);
                              listExpand.removeAt(index);
                              for (var i = 0; i < listExpand.length; i++) {
                                if (i == (listExpand.length - 1)) {
                                  listExpand[i] = true;
                                }
                              }
                            });
                          },
                          child: Container(
                              padding: index == 0 ? paddingLabel : paddingLabelMain,
                              child: Text(
                                "ลบ",
                                style: textLabelDelete,
                              )),
                        ),
                        // ),
                      ),
                    ],
                  ),
                  listExpand[index]
                      ? Container(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 40.0),
                            child: ListView.builder(
                              itemCount: itemPeople[index].itemsFineProduct.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index2) {
                                return Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: index2 == 0 ? 0 : 12.0),
                                        child: Text(
                                          'ของกลางลำดับที่ ${index2 + 1}',
                                          style: textTitleContent2Blue,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_NAME.toString(),
                                          style: textInputStyle,
                                        ),
                                      ),
                                      // ============================= Layout Row 1 =============================
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          // ============================= Layout TAX ===========================
                                          Container(
                                            //padding: paddingLabel,
                                            width: MediaQuery.of(context).size.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "มูลค่าภาษี",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: textStyleTitle,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        formatter.format(num.parse(itemPeople[index].itemsFineProduct[index2].TAX.toString())),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: textInputStyle,
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                                                      child: Text(
                                                        "บาท",
                                                        style: textInputStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ========================================================================
                                          // ============================= Layout TIMES =============================
                                          Container(
                                            //padding: paddingLabel,
                                            width: MediaQuery.of(context).size.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "จำนวนครั้งกระทำผิด",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: textStyleTitle,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: TextField(
                                                        focusNode: itemPeople[index].itemsFineProduct[index2].FOCUS,
                                                        controller: itemPeople[index].itemsFineProduct[index2].CONTROLLER_TIMES,
                                                        style: textInputStyle,
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: <TextInputFormatter>[
                                                          WhitelistingTextInputFormatter.digitsOnly,
                                                        ],
                                                        decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.only(bottom: 6.0),
                                                          isDense: true,
                                                        ),
                                                        onChanged: (str) {
                                                          if (str.trim().isEmpty) {
                                                            itemPeople[index].itemsFineProduct[index2].TIMES = 1;
                                                            if (_listProductID.contains(itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID)) {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID == tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID) {
                                                                  if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && itemPeople[index].itemsFineProduct[index2].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == 0) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 2::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == itemPeople[index].itemsFineProduct[index2].TIMES && itemPeople[index].itemsFineProduct[index2].TIMES == tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                }
                                                              }
                                                            } else {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == itemPeople[index].itemsFineProduct[index2].TIMES &&
                                                                    tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == itemPeople[index].itemsFineProduct[index2].TIMES &&
                                                                    tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                  // print("FINE_RATE ETC 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                  break;
                                                                } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  if (itemPeople[index].itemsFineProduct[index2].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE ETC 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            str = str.replaceAll(new RegExp(r'[!@#$%^&*().+?":{}|<>-]'), "");

                                                            // setState(() {
                                                            String resultString = "";
                                                            if (str[0] == "0") {
                                                              str = "1";
                                                            } else if (str[0] == ",") {
                                                              String temp = "";
                                                              for (var i = 1; i < str.length; i++) {
                                                                temp += str[i];
                                                              }
                                                              str = temp;
                                                            }
                                                            resultString = str;

                                                            itemPeople[index].itemsFineProduct[index2].TIMES = int.parse(resultString);

                                                            if (_listProductID.contains(itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID)) {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID == tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID) {
                                                                  if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && int.parse(resultString) >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == 0) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 2::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == int.parse(resultString) && int.parse(resultString) == tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                  // print("FINE_RATE: ${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                }
                                                              }
                                                            } else {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == int.parse(resultString) && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == int.parse(resultString) && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                  // print("FINE_RATE ETC 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                  break;
                                                                } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  if (int.parse(resultString) >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE ETC 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }

                                                          // ====================================================================
                                                          // ======================== sum FINE_AMOUNT ===========================
                                                          double sum = 0.0;
                                                          // sum = itemPeople[index].itemsFineProduct[index2].TAX * num.parse(itemPeople[index].itemsFineProduct[index2].FINE_RATE);
                                                          sum = double.parse((Decimal.parse(itemPeople[index].itemsFineProduct[index2].TAX.toString()) * Decimal.parse(itemPeople[index].itemsFineProduct[index2].FINE_RATE.toString())).toStringAsFixed(2));

                                                          if (fine_min > fine_max) {
                                                            if (fine_min > sum) {
                                                              itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = fine_min;
                                                            } else {
                                                              itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = sum;
                                                            }
                                                          } else {
                                                            itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = sum;
                                                          }
                                                          // ====================================================================
                                                          // ======================== sum FINE_TOTAL ============================
                                                          double sumTotal = 0.0;
                                                          for (var k = 0; k < itemPeople[index].itemsFineProduct.length; k++) {
                                                            sumTotal = sumTotal + itemPeople[index].itemsFineProduct[k].FINE_AMOUNT;
                                                          }
                                                          itemPeople[index].FINE_TOTAL = sumTotal;
                                                          // ====================================================================
                                                          // });
                                                        },
                                                        onSubmitted: (str) {
                                                          // ======================== dispose controller ========================
                                                          // itemPeople[index].itemsFineProduct[index2].CONTROLLER_TIMES.clear();
                                                          // itemPeople[index].itemsFineProduct[index2].CONTROLLER_FINE_RATE.clear();
                                                          // ====================================================================
                                                          setState(() {
                                                            itemPeople[index].itemsFineProduct[index2].CONTROLLER_TIMES.text = formatTime.format(num.parse(itemPeople[index].itemsFineProduct[index2].TIMES.toString()));
                                                            itemPeople[index].itemsFineProduct[index2].CONTROLLER_FINE_RATE.text = formatTime.format(num.parse(itemPeople[index].itemsFineProduct[index2].FINE_RATE.toString()));

                                                            if (_listProductID.contains(itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID)) {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID == tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID) {
                                                                  if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && itemPeople[index].itemsFineProduct[index2].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == 0) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 2::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == itemPeople[index].itemsFineProduct[index2].TIMES && itemPeople[index].itemsFineProduct[index2].TIMES == tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                }
                                                              }
                                                            } else {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == itemPeople[index].itemsFineProduct[index2].TIMES &&
                                                                    tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == itemPeople[index].itemsFineProduct[index2].TIMES &&
                                                                    tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                  // print("FINE_RATE ETC 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                  break;
                                                                } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  if (itemPeople[index].itemsFineProduct[index2].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE ETC 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                                                      child: Text(
                                                        "ครั้ง",
                                                        style: textInputStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ========================================================================
                                        ],
                                      ),
                                      // ========================================================================
                                      // ============================= Layout Row 2 =============================
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          // ============================= Layout TAX ===========================
                                          Container(
                                            padding: paddingLabel,
                                            width: MediaQuery.of(context).size.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "จำนวนค่าปรับเท่า",
                                                    style: textStyleTitle,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: TextField(
                                                        focusNode: itemPeople[index].itemsFineProduct[index2].FOCUS_FINE_RATE,
                                                        controller: itemPeople[index].itemsFineProduct[index2].CONTROLLER_FINE_RATE,
                                                        style: textInputStyle,
                                                        // keyboardType: TextInputType.number,
                                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                        decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.only(bottom: 6.0),
                                                          isDense: true,
                                                        ),
                                                        onChanged: (string) {
                                                          if (string.trim().isEmpty) {
                                                            // itemPeople[index].itemsFineProduct[index2].TIMES = 1;
                                                            if (_listProductID.contains(itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID)) {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID == tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID) {
                                                                  if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && itemPeople[index].itemsFineProduct[index2].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == 0) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 2::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == itemPeople[index].itemsFineProduct[index2].TIMES && itemPeople[index].itemsFineProduct[index2].TIMES == tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                }
                                                              }
                                                            } else {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == itemPeople[index].itemsFineProduct[index2].TIMES &&
                                                                    tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == itemPeople[index].itemsFineProduct[index2].TIMES &&
                                                                    tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                  // print("FINE_RATE ETC 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                  break;
                                                                } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  if (itemPeople[index].itemsFineProduct[index2].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE ETC 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            string = string.replaceAll(new RegExp(r'[!@#$%^&*()+?":{}|<>-]'), "");
                                                            String resultString = "";
                                                            if (string[0] == "0") {
                                                              string = "1";
                                                            } else if (string[0] == ",") {
                                                              String temp = "";
                                                              for (var i = 1; i < string.length; i++) {
                                                                temp += string[i];
                                                              }
                                                              string = temp;
                                                            }

                                                            resultString = string;
                                                            itemPeople[index].itemsFineProduct[index2].FINE_RATE = int.parse(resultString);
                                                          }
                                                          setState(() {
                                                            double sum = 0.0;
                                                            sum = double.parse((Decimal.parse(itemPeople[index].itemsFineProduct[index2].TAX.toString()) * Decimal.parse(itemPeople[index].itemsFineProduct[index2].FINE_RATE.toString())).toStringAsFixed(2));
                                                            itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = sum;

                                                            // ======================== sum FINE_TOTAL ============================
                                                            double sumTotal = 0.0;
                                                            for (var k = 0; k < itemPeople[index].itemsFineProduct.length; k++) {
                                                              sumTotal = sumTotal + itemPeople[index].itemsFineProduct[k].FINE_AMOUNT;
                                                            }
                                                            itemPeople[index].FINE_TOTAL = sumTotal;
                                                            // ====================================================================
                                                          });
                                                        },
                                                        onSubmitted: (string) {
                                                          // ======================== dispose controller ========================
                                                          itemPeople[index].itemsFineProduct[index2].CONTROLLER_FINE_RATE.clear();
                                                          // ====================================================================
                                                          // itemPeople[index].itemsFineProduct[index2].CONTROLLER_FINE_RATE.text = formatterFineRate.format(num.parse(itemPeople[index].itemsFineProduct[index2].FINE_RATE.toString()));
                                                          itemPeople[index].itemsFineProduct[index2].CONTROLLER_FINE_RATE.text = itemPeople[index].itemsFineProduct[index2].FINE_RATE.toString();

                                                          if (itemPeople[index].itemsFineProduct[index2].FINE_RATE >= fineRate_min && fineRate_max >= itemPeople[index].itemsFineProduct[index2].FINE_RATE) {
                                                            itemPeople[index].itemsFineProduct[index2].FINE_RATE = itemPeople[index].itemsFineProduct[index2].FINE_RATE;

                                                            double sum = 0.0;
                                                            // sum = itemPeople[index].itemsFineProduct[index2].TAX * num.parse(itemPeople[index].itemsFineProduct[index2].FINE_RATE);
                                                            sum = double.parse((Decimal.parse(itemPeople[index].itemsFineProduct[index2].TAX.toString()) * Decimal.parse(itemPeople[index].itemsFineProduct[index2].FINE_RATE.toString())).toStringAsFixed(2));

                                                            if (fine_min > fine_max) {
                                                              if (fine_min > sum) {
                                                                itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = fine_min;
                                                              } else {
                                                                itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = sum;
                                                              }
                                                            } else {
                                                              itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = sum;
                                                            }

                                                            // ======================== sum FINE_TOTAL ============================
                                                            double sumTotal = 0.0;
                                                            for (var k = 0; k < itemPeople[index].itemsFineProduct.length; k++) {
                                                              sumTotal = sumTotal + itemPeople[index].itemsFineProduct[k].FINE_AMOUNT;
                                                            }
                                                            itemPeople[index].FINE_TOTAL = sumTotal;
                                                            // ====================================================================
                                                          } else {
                                                            // new EmptyDialog(context, "จำนวนค่าปรับเท่าที่ระบุเกินจากอัตราโทษ");
                                                            new EmptyDialog(context, "จำนวนค่าปรับเท่าต้องอยู่ในระหว่างอัตราโทษ");
                                                            itemPeople[index].itemsFineProduct[index2].TIMES = 1;
                                                            itemPeople[index].itemsFineProduct[index2].CONTROLLER_TIMES.text = "1";

                                                            if (_listProductID.contains(itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID)) {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (itemPeople[index].itemsFineProduct[index2].PRODUCT_GROUP_ID == tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID) {
                                                                  if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && itemPeople[index].itemsFineProduct[index2].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == 0) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 2::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == itemPeople[index].itemsFineProduct[index2].TIMES && itemPeople[index].itemsFineProduct[index2].TIMES == tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                }
                                                              }
                                                            } else {
                                                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                                if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == itemPeople[index].itemsFineProduct[index2].TIMES &&
                                                                    tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == itemPeople[index].itemsFineProduct[index2].TIMES &&
                                                                    tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                  // print("FINE_RATE ETC 1::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                  break;
                                                                } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                                                  if (itemPeople[index].itemsFineProduct[index2].TIMES >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                                    itemPeople[index].itemsFineProduct[index2].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                                    // print("FINE_RATE ETC 3::${itemPeople[index].itemsFineProduct[index2].FINE_RATE}");
                                                                    break;
                                                                  }
                                                                }
                                                              }
                                                            }

                                                            itemPeople[index].itemsFineProduct[index2].CONTROLLER_FINE_RATE.text = fineRate_min.toString();
                                                            // itemPeople[index].itemsFineProduct[index2].FINE_RATE = fineRate_min;

                                                            double sum = 0.0;
                                                            sum = itemPeople[index].itemsFineProduct[index2].TAX * itemPeople[index].itemsFineProduct[index2].FINE_RATE;
                                                            if (fine_min > fine_max) {
                                                              if (fine_min > sum) {
                                                                itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = fine_min;
                                                              } else {
                                                                itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = sum;
                                                              }
                                                            } else {
                                                              itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT = sum;
                                                            }
                                                            // ======================== sum FINE_TOTAL ============================
                                                            double sumTotal = 0.0;
                                                            for (var k = 0; k < itemPeople[index].itemsFineProduct.length; k++) {
                                                              sumTotal = sumTotal + itemPeople[index].itemsFineProduct[k].FINE_AMOUNT;
                                                            }
                                                            itemPeople[index].FINE_TOTAL = sumTotal;
                                                            // ====================================================================
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                                                      child: Text(
                                                        "เท่า",
                                                        style: textInputStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ========================================================================
                                          // ============================= Layout FINE_AMOUNT =======================
                                          Container(
                                            padding: paddingLabel,
                                            width: MediaQuery.of(context).size.width / 2.5,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  child: Text(
                                                    "ค่าปรับ",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: textStyleTitle,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        formatterFineRate.format(num.parse(itemPeople[index].itemsFineProduct[index2].FINE_AMOUNT.toString())),
                                                        overflow: TextOverflow.ellipsis,
                                                        style: textInputStyle,
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets.only(left: 10.0, right: 4.0),
                                                      child: Text(
                                                        "บาท",
                                                        style: textInputStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // ========================================================================
                                        ],
                                      ),
                                      // ========================================================================
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Container(),
                  !listExpand[index]
                      ? Container(
                          //padding: paddingLabel,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "รวมค่าปรับคดี",
                                  style: textInputStyleSub,
                                ),
                              ),
                              Center(
                                child: Container(
                                  padding: EdgeInsets.only(left: 16.0, right: 16.0),
                                  child: Text(
                                    formatterFineRate.format(num.parse(itemPeople[index].FINE_TOTAL.toString())),
                                    style: textStyleTitle,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  " บาท",
                                  style: textInputStyleSub,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  Container(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              listExpand[index] = !listExpand[index];
                            });
                          },
                          child: Text(
                            listExpand[index] ? "ย่อ..." : "ดูเพิ่มเติม...",
                            style: textStyleTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
                    // width: width,
                    height: 1.0,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ==================================== build layout main ====================================
  @override
  Widget build(BuildContext context) {
    final List<Widget> btnSave = <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          new FlatButton(
              onPressed: () {
                List<ItemsFinePeople> tempPeople = [];
                List<ItemsFineProduct2> tempProduct = [];

                for (var i = 0; i < itemPeople.length; i++) {
                  tempProduct = [];
                  tempItemsFinePeople = [];
                  itemPeople[i].itemsFineProduct.forEach((f) {
                    tempProduct.add(new ItemsFineProduct2(f.PRODUCT_GROUP_ID, f.PRODUCT_GROUP_NAME, f.TAX, f.TIMES, f.FINE_RATE, f.FINE_AMOUNT));
                  });
                  tempItemsFinePeople.add(new ItemsFinePeople(itemPeople[i].FINE_TOTAL, tempProduct));
                  tempPeople += tempItemsFinePeople;
                }

                Navigator.pop(context, tempPeople);
              },
              child: Text('บันทึก', style: appBarStyle)),
        ],
      )
    ];
    // TODO: implement build
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            "เพิ่มผู้ต้องหา",
            style: styleTextAppbar,
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, "back");
              }),
          actions: itemPeople.length > 0 ? btnSave : null,
        ),
        body: Stack(
          children: <Widget>[
            BackgroundContent(),
            new Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      //color: Colors.grey[200],
                      border: Border(
                    top: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
                ),
                Expanded(
                  child: new ConstrainedBox(
                    constraints: const BoxConstraints.expand(),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: _buildContent1(context),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                //color: Colors.grey[200],
                                border: Border(
                              top: BorderSide(color: Colors.grey[100], width: 8.0),
                            )),
                          ),
                          Container(
                            child: _buildContent2(context),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 40.0, right: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                new Card(
                                    shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                                    elevation: 0.0,
                                    child: Container(
                                      width: 140.0,
                                      child: MaterialButton(
                                        onPressed: () {
                                          // _navigateSearch(context);
                                          setState(() {
                                            sumTotal = 0.0;
                                            List<ItemsTempFineProduct> tempProduct = [];
                                            List<ItemsFineProductInitForEdit> tempProductForEdit1 = [];
                                            List<ItemsFineProductInitForEdit> tempProductForEdit2 = [];

                                            if (widget.onEdit) {
                                              tempProductForEdit1 = widget.itemProductInit;
                                              tempProductForEdit1.forEach((f) {
                                                tempProductForEdit2.add(new ItemsFineProductInitForEdit(f.PRODUCT_GROUP_ID, f.PRODUCT_GROUP_NAME, f.TAX, 1, 0, 0.0));
                                              });
                                              // ============================ Set init product for edit ============================
                                              for (var i = 0; i < tempProductForEdit2.length; i++) {
                                                double sum = 0.0;
                                                // Check FINE_RATE
                                                if (_listProductID.contains(tempProductForEdit2[i].PRODUCT_GROUP_ID)) {
                                                  for (var a = 0; a < tempItemDataGuiltbaseFine.length; a++) {
                                                    if (tempItemDataGuiltbaseFine[a].PRODUCT_GROUP_ID == tempProductForEdit2[i].PRODUCT_GROUP_ID) {
                                                      tempProductForEdit2[i].FINE_RATE = tempItemDataGuiltbaseFine[a].FINE_RATE.round();
                                                      break;
                                                    }
                                                  }
                                                } else {
                                                  for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                                    if (tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 1) {
                                                      tempProductForEdit2[i].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                      break;
                                                    }
                                                  }
                                                }
                                                // Check FINE_AMOUNT
                                                sum = tempProductForEdit2[i].TAX * tempProductForEdit2[i].FINE_RATE;
                                                if (fine_min > fine_max) {
                                                  if (fine_min > sum) {
                                                    tempProductForEdit2[i].FINE_AMOUNT = fine_min;
                                                  } else {
                                                    tempProductForEdit2[i].FINE_AMOUNT = sum;
                                                  }
                                                } else {
                                                  tempProductForEdit2[i].FINE_AMOUNT = sum;
                                                }
                                              }
                                              // ===================================================================================
                                              for (var i = 0; i < tempProductForEdit2.length; i++) {
                                                tempProduct.add(new ItemsTempFineProduct(
                                                  tempProductForEdit2[i].PRODUCT_GROUP_ID,
                                                  tempProductForEdit2[i].PRODUCT_GROUP_NAME,
                                                  tempProductForEdit2[i].TAX,
                                                  tempProductForEdit2[i].TIMES,
                                                  tempProductForEdit2[i].FINE_RATE,
                                                  tempProductForEdit2[i].FINE_AMOUNT,
                                                  new TextEditingController(text: tempProductForEdit2[i].TIMES.toString()),
                                                  new TextEditingController(text: formatTime.format(num.parse(tempProductForEdit2[i].FINE_RATE.toString()))),
                                                  new FocusNode(),
                                                  new FocusNode(),
                                                ));
                                                sumTotal = sumTotal + tempProductForEdit2[i].FINE_AMOUNT;
                                              }
                                              tempProduct.forEach((f) {
                                                f.FOCUS.addListener(_onFocusChange);
                                                f.FOCUS_FINE_RATE.addListener(_onFocusChange);
                                              });
                                            } else {
                                              for (var i = 0; i < productFromPrevious.length; i++) {
                                                tempProduct.add(new ItemsTempFineProduct(
                                                  productFromPrevious[i].PRODUCT_GROUP_ID,
                                                  productFromPrevious[i].PRODUCT_GROUP_NAME,
                                                  productFromPrevious[i].TAX,
                                                  productFromPrevious[i].TIMES,
                                                  productFromPrevious[i].FINE_RATE,
                                                  productFromPrevious[i].FINE_AMOUNT,
                                                  new TextEditingController(text: productFromPrevious[i].TIMES.toString()),
                                                  new TextEditingController(text: formatTime.format(num.parse(productFromPrevious[i].FINE_RATE.toString()))),
                                                  new FocusNode(),
                                                  new FocusNode(),
                                                ));
                                                sumTotal = sumTotal + productFromPrevious[i].FINE_AMOUNT;
                                              }
                                              tempProduct.forEach((f) {
                                                f.FOCUS.addListener(_onFocusChange);
                                                f.FOCUS_FINE_RATE.addListener(_onFocusChange);
                                              });
                                            }
                                            itemPeople.add(new ItemsTempFinePeople(sumTotal, tempProduct));
                                            // ======================================================
                                            // ===================== Add Expand =====================
                                            listExpand.add(true);
                                            for (var i = 0; i < listExpand.length; i++) {
                                              if (i != (listExpand.length - 1)) {
                                                listExpand[i] = false;
                                              }
                                            }
                                            // ======================================================
                                          });
                                        },
                                        splashColor: Colors.grey,
                                        child: Center(
                                          child: Text(
                                            "เพิ่มผู้ต้องหา",
                                            style: textLabelStyle,
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // ===========================================================================================
}
