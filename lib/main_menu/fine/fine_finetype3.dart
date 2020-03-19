import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:decimal/decimal.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_group.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawGroupSubSection.dart';
import 'package:prototype_app_pang/main_menu/fine/fine_finetype3_addPerson.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_fineIndex.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_finePeoplePage2.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_fineProduct.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_finrProductInitForEdit.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_tempProductPage2.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class FineFineType3 extends StatefulWidget {
  ItemsMasLawGroupSubSection itemsLaw;
  List itemProduct;
  List itemData;
  List itemDataPenalty;
  bool onEdit;
  List<ItemsFineIndex> itemAll;
  @override
  FineFineType3({
    Key key,
    @required this.itemsLaw,
    @required this.itemProduct,
    @required this.itemData,
    @required this.itemDataPenalty,
    @required this.onEdit,
    @required this.itemAll,
  }) : super(key: key);
  _FineFineType3 createState() => new _FineFineType3();
}

class _FineFineType3 extends State<FineFineType3> {
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

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabelMain = EdgeInsets.only(top: 24.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  final formatter = new NumberFormat("#,##0.0000");

  List<TextEditingController> _controllersFineType3 = new List();

  List _itemsProductType = [];
  List tempItemDataGuiltbaseFine = [];
  List _newItemProduct = [];
  List _listProductID = [];

  List tempItemDataPenalty = [];
  double fine_min = 0.0;
  double fine_max = 0.0;

  List<ItemsFineProduct> tempItemsFineProduct = [];

  List<ItemsFineProductInitForEdit> tempItemsFineProductInitForEdit = [];

  List<ItemsFinePeoplePage2> itemsPeoplePrevious = [];
  List<ItemsFineProductPage2> itemsPrevious = [];

  // List<String> nameOldDropD = [];
  // List<String> nameNewDropD = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    (widget.itemDataPenalty[0]).forEach((f) {
      tempItemDataPenalty.add(f);
    });

    (widget.itemData[0]).forEach((f) {
      tempItemDataGuiltbaseFine.add(f);
    });
    tempItemDataGuiltbaseFine.forEach((f) {
      _listProductID.add(f.PRODUCT_GROUP_ID);
    });
    tempItemDataPenalty.forEach((f) {
      fine_min = f.FINE_MIN;
      fine_max = f.FINE_MAX;
    });

    if (widget.onEdit) {
      print("onEdit");
      widget.itemProduct.forEach((item) {
        if (item.PRODUCT_GROUP_ID != 88) {
          _newItemProduct.add(item);
        }
      });

      widget.itemAll[0].itemsFinePeople[0].itemsFineProduct.forEach((f) {
        print("TIMES init: ${f.TIMES}");

        tempItemsFineProduct.add(new ItemsFineProduct(f.PRODUCT_GROUP_ID, f.PRODUCT_GROUP_NAME, f.TAX, f.TIMES, f.FINE_RATE, f.FINE_AMOUNT));
        tempItemsFineProductInitForEdit.add(new ItemsFineProductInitForEdit(f.PRODUCT_GROUP_ID, f.PRODUCT_GROUP_NAME, f.TAX, 1, 0, 0.0));
        // nameOldDropD.add(f.PRODUCT_GROUP_NAME);

        widget.itemProduct.forEach((item) {
          if (f.PRODUCT_GROUP_ID == item.PRODUCT_GROUP_ID) {
            _itemsProductType.add(item);
          }
        });
      });

      List<ItemsFinePeoplePage2> tempPeople = [];
      List<ItemsFineProductPage2> tempProduct = [];
      List<ItemsFinePeoplePage2> tempPeople2 = [];
      for (var i = 0; i < widget.itemAll[0].itemsFinePeople.length; i++) {
        tempProduct = [];
        tempPeople2 = [];
        widget.itemAll[0].itemsFinePeople[i].itemsFineProduct.forEach((f) {
          tempProduct.add(new ItemsFineProductPage2(f.PRODUCT_GROUP_ID, f.PRODUCT_GROUP_NAME, f.TAX, f.TIMES, f.FINE_RATE, f.FINE_AMOUNT));
        });
        tempPeople2.add(new ItemsFinePeoplePage2(widget.itemAll[0].itemsFinePeople[i].FINE_TOTAL, tempProduct));
        tempPeople += tempPeople2;
      }
      itemsPeoplePrevious = tempPeople;
      // ===================================================================================
    } else {
      widget.itemProduct.forEach((item) {
        if (item.PRODUCT_GROUP_ID != 88) {
          _newItemProduct.add(item);
        }
        if (item.PRODUCT_GROUP_ID == 13) {
          _itemsProductType.add(item);
          // nameOldDropD.add(item.PRODUCT_GROUP_NAME);
        }
      });
      for (var i = 0; i < tempItemDataGuiltbaseFine.length; i++) {
        if (tempItemDataGuiltbaseFine[i].PRODUCT_GROUP_ID == 13) {
          for (var j = 0; j < _itemsProductType.length; j++) {
            if (tempItemDataGuiltbaseFine[i].PRODUCT_GROUP_ID == _itemsProductType[j].PRODUCT_GROUP_ID) {
              tempItemsFineProduct.add(new ItemsFineProduct(tempItemDataGuiltbaseFine[i].PRODUCT_GROUP_ID, _itemsProductType[j].PRODUCT_GROUP_NAME, 0.0, 1, tempItemDataGuiltbaseFine[i].FINE_RATE.round(), 0.0));
              break;
            }
          }
        }
      }
    }
  }

  _navigateFineType3AddPerson(BuildContext mContext, List<ItemsFineProduct> item) async {
    final result = await Navigator.push(
      mContext,
      MaterialPageRoute(
          builder: (context) => FineFineType3AddPerson(
                itemsLaw: widget.itemsLaw,
                itemDataProduct: item,
                itemDataGuiltbaseFine: widget.itemData,
                itemDataPenalty: widget.itemDataPenalty,
                onEdit: widget.onEdit,
              )),
    );
    if (result != "back") {
      Navigator.pop(context, result);
    }
  }

  _navigateFineType3AddPersonEdit(BuildContext mContext, List<ItemsFinePeoplePage2> item) async {
    final result = await Navigator.push(
      mContext,
      MaterialPageRoute(
          builder: (context) => FineFineType3AddPerson(
                itemsLaw: widget.itemsLaw,
                itemDataGuiltbaseFine: widget.itemData,
                itemDataPenalty: widget.itemDataPenalty,
                onEdit: true,
                itemProductInit: tempItemsFineProductInitForEdit,
                itemPeoplePage2: item,
              )),
    );
    if (result != "back") {
      Navigator.pop(context, result);
    }
  }

  @override
  void dispose() {
    _controllersFineType3.forEach((v) {
      v.dispose();
    });
    // TODO: implement dispose
    super.dispose();
  }

  // ==================================== build layout content1 ====================================
  Widget _buildContent1(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;

    return Container(
      padding: EdgeInsets.only(top: 20.0),
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
              tempItemsFineProduct.length > 0
                  ? _buildContentFineType3(context)
                  : Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
                        child: Text(
                          "กรุณาเพิ่มของกลาง",
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
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );

    return new Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 40.0),
        child: ListView.builder(
          itemCount: tempItemsFineProduct.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            tempItemsFineProduct.forEach((str) {
              _controllersFineType3.add(new TextEditingController(text: formatter.format(num.parse(str.TAX.toString()))));
            });
            // textyy.add(new MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',', precision: 1));

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
                            'ของกลางลำดับที่ ${index + 1}',
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
                              tempItemsFineProduct.removeAt(index);
                              _itemsProductType.removeAt(index);
                              if (widget.onEdit) {
                                tempItemsFineProductInitForEdit.removeAt(index);
                                for (var i = 0; i < itemsPeoplePrevious.length; i++) {
                                  itemsPeoplePrevious[i].itemsFineProduct.removeAt(index);
                                }
                              }
                            });
                            _controllersFineType3.clear();
                            _controllersFineType3.forEach((v) {
                              v.dispose();
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
                  Container(
                    // padding: paddingLabel,
                    child: Text(
                      'ประเภทของกลาง',
                      style: textStyleTitle,
                    ),
                  ),
                  Container(
                    width: Width,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ItemsListProductGroup>(
                        isExpanded: true, //
                        value: _itemsProductType[index],
                        onChanged: (ItemsListProductGroup newValue) {
                          // !nameOldDropD.contains(newValue.PRODUCT_GROUP_NAME) ?
                          setState(() {
                            _itemsProductType[index] = newValue;
                            for (var i = 0; i < tempItemsFineProduct.length; i++) {
                              if (i == index) {
                                tempItemsFineProduct[i].PRODUCT_GROUP_ID = newValue.PRODUCT_GROUP_ID;
                                tempItemsFineProduct[i].PRODUCT_GROUP_NAME = newValue.PRODUCT_GROUP_NAME;
                                break;
                              }
                            }

                            // // Check disable dropdown
                            // nameNewDropD = [];
                            // for (var i = 0; i < tempItemsFineProduct.length; i++) {
                            //   nameNewDropD.add(tempItemsFineProduct[i].PRODUCT_GROUP_NAME);
                            // }

                            // Check FINE_RATE
                            if (_listProductID.contains(newValue.PRODUCT_GROUP_ID)) {
                              for (var i = 0; i < tempItemDataGuiltbaseFine.length; i++) {
                                if (tempItemDataGuiltbaseFine[i].PRODUCT_GROUP_ID == newValue.PRODUCT_GROUP_ID) {
                                  tempItemsFineProduct[index].FINE_RATE = tempItemDataGuiltbaseFine[i].FINE_RATE.round();
                                  print("FINE_RATE ::${tempItemsFineProduct[index].FINE_RATE}");
                                  break;
                                }
                              }
                            } else {
                              for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                if (tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 1) {
                                  tempItemsFineProduct[index].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                  print("FINE_RATE ETC ::${tempItemsFineProduct[index].FINE_RATE}");
                                  break;
                                }
                              }
                            }
                            for (var i = 0; i < tempItemsFineProduct.length; i++) {
                              if (i == index) {
                                double sum = 0.0;
                                // sum = tempItemsFineProduct[i].TAX * num.parse(tempItemsFineProduct[i].FINE_RATE);
                                sum = double.parse((Decimal.parse(tempItemsFineProduct[i].TAX.toString()) * Decimal.parse(tempItemsFineProduct[i].FINE_RATE.toString())).toStringAsFixed(2));

                                if (fine_min > fine_max) {
                                  if (fine_min > sum) {
                                    tempItemsFineProduct[i].FINE_AMOUNT = fine_min;
                                  } else {
                                    tempItemsFineProduct[i].FINE_AMOUNT = sum;
                                  }
                                } else {
                                  tempItemsFineProduct[i].FINE_AMOUNT = sum;
                                }
                                print("FINE_AMOUNT_1: ${tempItemsFineProduct[i].FINE_AMOUNT}");
                                break;
                              }
                            }
                            // ============================ for onEdit =========================================
                            if (widget.onEdit) {
                              // ============================ for product init edit ============================
                              for (var i = 0; i < tempItemsFineProductInitForEdit.length; i++) {
                                if (i == index) {
                                  tempItemsFineProductInitForEdit[i].PRODUCT_GROUP_ID = newValue.PRODUCT_GROUP_ID;
                                  tempItemsFineProductInitForEdit[i].PRODUCT_GROUP_NAME = newValue.PRODUCT_GROUP_NAME;
                                  break;
                                }
                              }
                              // Check FINE_RATE
                              for (var a = 0; a < itemsPeoplePrevious.length; a++) {
                                for (var b = 0; b < itemsPeoplePrevious[a].itemsFineProduct.length; b++) {
                                  for (var c = 0; c < tempItemsFineProduct.length; c++) {
                                    // print("a :${a}, b :${b}, c :${c}");
                                    if (b == c) {
                                      if (itemsPeoplePrevious[a].itemsFineProduct[b].PRODUCT_GROUP_ID == tempItemsFineProduct[c].PRODUCT_GROUP_ID) {
                                        tempItemsFineProduct[c].TIMES = itemsPeoplePrevious[a].itemsFineProduct[b].TIMES;
                                        tempItemsFineProduct[c].FINE_RATE = itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE;
                                        // print("FINE_RATE IF1::${tempItemsFineProduct[c].TIMES}");
                                        // print("FINE_RATE IF2::${tempItemsFineProduct[c].FINE_RATE}");
                                      } else {
                                        tempItemsFineProduct[c].TIMES = 1;
                                        if (_listProductID.contains(tempItemsFineProduct[c].PRODUCT_GROUP_ID)) {
                                          for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                            if (tempItemsFineProduct[c].PRODUCT_GROUP_ID == tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID) {
                                              if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && 1 >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                tempItemsFineProduct[c].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                print("FINE_RATE 1::${tempItemsFineProduct[c].FINE_RATE}");
                                                break;
                                              } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 0 && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == 0) {
                                                tempItemsFineProduct[c].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                print("FINE_RATE 2::${tempItemsFineProduct[c].FINE_RATE}");
                                                break;
                                              } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 1 && 1 == tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO) {
                                                tempItemsFineProduct[c].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                print("FINE_RATE 3::${tempItemsFineProduct[c].FINE_RATE}");
                                                break;
                                              }
                                            }
                                          }
                                        } else {
                                          for (var k = 0; k < tempItemDataGuiltbaseFine.length; k++) {
                                            if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO == 1 && tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO == 1 && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                              tempItemsFineProduct[c].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                              print("FINE_RATE ETC 1::${tempItemsFineProduct[c].FINE_RATE}");
                                              break;
                                            } else if (tempItemDataGuiltbaseFine[k].MISTREAT_START_NO > tempItemDataGuiltbaseFine[k].MISTREAT_TO_NO && tempItemDataGuiltbaseFine[k].PRODUCT_GROUP_ID == 0) {
                                              if (1 >= tempItemDataGuiltbaseFine[k].MISTREAT_START_NO) {
                                                tempItemsFineProduct[c].FINE_RATE = tempItemDataGuiltbaseFine[k].FINE_RATE.round();
                                                print("FINE_RATE ETC 3::${tempItemsFineProduct[c].FINE_RATE}");
                                                break;
                                              }
                                            }
                                          }
                                        }
                                        if (fine_min > fine_max) {
                                          if (tempItemsFineProduct[c].TAX == 0.0) {
                                            tempItemsFineProduct[c].FINE_AMOUNT = fine_min;
                                          } else {
                                            double sumIF1 = 0.0;
                                            // sumIF1 = tempItemsFineProduct[c].TAX * num.parse(tempItemsFineProduct[c].FINE_RATE);
                                            sumIF1 = double.parse((Decimal.parse(tempItemsFineProduct[c].TAX.toString()) * Decimal.parse(tempItemsFineProduct[c].FINE_RATE.toString())).toStringAsFixed(2));

                                            if (fine_min > sumIF1) {
                                              tempItemsFineProduct[c].FINE_AMOUNT = fine_min;
                                            } else {
                                              tempItemsFineProduct[c].FINE_AMOUNT = sumIF1;
                                            }
                                          }
                                        } else {
                                          if (tempItemsFineProduct[c].TAX == 0.0) {
                                            tempItemsFineProduct[c].FINE_AMOUNT = fine_min;
                                          } else {
                                            if (tempItemsFineProduct[c].TAX > fine_max) {
                                              tempItemsFineProduct[c].FINE_AMOUNT = fine_max;
                                            } else {
                                              if (tempItemsFineProduct[c].TAX <= fine_max && tempItemsFineProduct[c].TAX < fine_min) {
                                                tempItemsFineProduct[c].FINE_AMOUNT = fine_min;
                                              } else {
                                                double sumIF2 = 0.0;
                                                // sumIF2 = tempItemsFineProduct[c].TAX * num.parse(tempItemsFineProduct[c].FINE_RATE);
                                                sumIF2 = double.parse((Decimal.parse(tempItemsFineProduct[c].TAX.toString()) * Decimal.parse(tempItemsFineProduct[c].FINE_RATE.toString())).toStringAsFixed(2));

                                                if (fine_min > sumIF2) {
                                                  tempItemsFineProduct[c].FINE_AMOUNT = fine_min;
                                                } else {
                                                  tempItemsFineProduct[c].FINE_AMOUNT = sumIF2;
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                  break;
                                }
                              }
                              // Add product init FINE_RATE
                              for (var i = 0; i < tempItemsFineProductInitForEdit.length; i++) {
                                if (i == index) {
                                  double sumEdit = 0.0;
                                  // sumEdit = tempItemsFineProductInitForEdit[i].TAX * num.parse(tempItemsFineProductInitForEdit[i].FINE_RATE);
                                  sumEdit = double.parse((Decimal.parse(tempItemsFineProductInitForEdit[i].TAX.toString()) * Decimal.parse(tempItemsFineProductInitForEdit[i].FINE_RATE.toString())).toStringAsFixed(2));

                                  if (fine_min > fine_max) {
                                    if (fine_min > sumEdit) {
                                      tempItemsFineProductInitForEdit[i].FINE_AMOUNT = fine_min;
                                    } else {
                                      tempItemsFineProductInitForEdit[i].FINE_AMOUNT = sumEdit;
                                    }
                                  } else {
                                    tempItemsFineProductInitForEdit[i].FINE_AMOUNT = sumEdit;
                                  }
                                  break;
                                }
                              }
                            }
                            // ===============================================================================
                            // nameOldDropD = nameNewDropD;
                          });
                          // : null;
                        },
                        items: _newItemProduct.map<DropdownMenuItem<ItemsListProductGroup>>((value) {
                          // bool isDisabled(String valueDropDownMenu) {
                          //   if (widget.onEdit) {
                          //   } else {
                          //     nameOldDropD = nameNewDropD;
                          //   }
                          //   for (var item in nameOldDropD) {
                          //     if (valueDropDownMenu == item) {
                          //       if (valueDropDownMenu == _itemsProductType[index].PRODUCT_GROUP_NAME) {
                          //         return false;
                          //       } else {
                          //         return true;
                          //       }
                          //     }
                          //   }
                          //   return false;
                          // }

                          return DropdownMenuItem<ItemsListProductGroup>(
                            value: value,
                            child: Text(
                              value.PRODUCT_GROUP_NAME,
                              overflow: TextOverflow.ellipsis,
                              style: textInputStyle,
                            ),
                            // child: CustomText(value.PRODUCT_GROUP_NAME, isDisabled: isDisabled(value.PRODUCT_GROUP_NAME)),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  _buildLine,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "มูลค่าภาษี",
                                style: textStyleTitle,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _controllersFineType3[index],
                                    style: textInputStyle,
                                    // keyboardType: TextInputType.number,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    // inputFormatters: <TextInputFormatter>[
                                    //   WhitelistingTextInputFormatter.digitsOnly,
                                    // ],
                                    // decoration: InputDecoration(
                                    //   contentPadding: EdgeInsets.only(bottom: 6.0),
                                    //   isDense: true,
                                    // ),
                                    onChanged: (str) {
                                      if (str.trim().isEmpty) {
                                        tempItemsFineProduct[index].TAX = 0.0;
                                      } else {
                                        str = str.replaceAll(new RegExp(r'[!@#$%^&*()+?":{}|<>-]'), "");

                                        // setState(() {
                                        String resultString = "";
                                        if (str[0] == ",") {
                                          String temp = "";
                                          for (var i = 1; i < str.length; i++) {
                                            temp += str[i];
                                          }
                                          str = temp;
                                        } else {
                                          if (str[0] == ".") {
                                            str = "0" + str;
                                          }
                                        }
                                        if (str.toString().contains(",") && str.toString().contains(".")) {
                                          List listCommaString = str.split(",").toList();
                                          List listDotString = [];
                                          String dot1 = "";
                                          String dot2 = "";
                                          String sumString = "";
                                          listCommaString.forEach((f) {
                                            sumString += f;
                                          });
                                          listDotString = sumString.split(".").toList();
                                          dot1 = listDotString[0];

                                          if (listDotString[1].length < 4) {
                                            dot2 = listDotString[1];
                                          } else {
                                            dot2 = listDotString[1].substring(0, 4);
                                          }

                                          resultString = dot1 + "." + dot2;
                                        } else {
                                          if (str.toString().contains(",")) {
                                            List listString = str.split(",").toList();
                                            String sumString = "";

                                            listString.forEach((f) {
                                              sumString += f;
                                            });

                                            resultString = sumString;
                                          } else if (str.toString().contains(".")) {
                                            List listString = str.split(".").toList();

                                            String listStringIndex1 = "";
                                            String stringIndex2 = "";

                                            listStringIndex1 = listString[1];

                                            if (listStringIndex1.length < 4) {
                                              stringIndex2 = listStringIndex1;
                                            } else {
                                              stringIndex2 = listStringIndex1.substring(0, 4);
                                            }

                                            resultString = listString[0] + "." + stringIndex2;
                                          } else {
                                            resultString = str;
                                          }
                                        }

                                        tempItemsFineProduct[index].TAX = double.parse(resultString);
                                      }
                                      // });
                                    },
                                    onSubmitted: (string) {
                                      setState(() {
                                        double checkSum = 0.0;
                                        double numParse = 0.0;
                                        String tempString = "";
                                        tempString = tempItemsFineProduct[index].TAX.toString();
                                        numParse = double.parse(num.parse(tempString).toStringAsFixed(4));
                                        checkSum = checkSum + numParse;
                                        if (checkSum == 0) {
                                          new EmptyDialog(context, "กรุณากรอกจำนวนเงิน");
                                        } else {
                                          double sum = 0.0;
                                          sum = double.parse((Decimal.parse(tempItemsFineProduct[index].TAX.toString()) * Decimal.parse(tempItemsFineProduct[index].FINE_RATE.toString())).toStringAsFixed(2));

                                          if (fine_min > fine_max) {
                                            if (fine_min > sum) {
                                              tempItemsFineProduct[index].FINE_AMOUNT = fine_min;
                                            } else {
                                              tempItemsFineProduct[index].FINE_AMOUNT = sum;
                                            }
                                          } else {
                                            tempItemsFineProduct[index].FINE_AMOUNT = sum;
                                          }
                                          // ===============================================================================
                                          if (widget.onEdit) {
                                            // ============================ for product init edit ============================
                                            tempItemsFineProductInitForEdit[index].TAX = tempItemsFineProduct[index].TAX;
                                            double sumEdit = 0.0;
                                            // sumEdit = tempItemsFineProductInitForEdit[i].TAX * num.parse(tempItemsFineProductInitForEdit[i].FINE_RATE);
                                            sumEdit = double.parse((Decimal.parse(tempItemsFineProductInitForEdit[index].TAX.toString()) * Decimal.parse(tempItemsFineProductInitForEdit[index].FINE_RATE.toString())).toStringAsFixed(2));

                                            if (fine_min > fine_max) {
                                              if (fine_min > sumEdit) {
                                                tempItemsFineProductInitForEdit[index].FINE_AMOUNT = fine_min;
                                              } else {
                                                tempItemsFineProductInitForEdit[index].FINE_AMOUNT = sumEdit;
                                              }
                                            } else {
                                              tempItemsFineProductInitForEdit[index].FINE_AMOUNT = sumEdit;
                                            }
                                            // ===============================================================================
                                          }
                                        }

                                        for (var i = 0; i < tempItemsFineProduct.length; i++) {
                                          _controllersFineType3[i].text = formatter.format(num.parse(tempItemsFineProduct[i].TAX.toString()));
                                        }
                                        // _controllersFineType3[index].text = formatter.format(num.parse(tempItemsFineProduct[index].TAX.toString()));
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0, right: 8.0),
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
                    ],
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
                tempItemsFineProduct.forEach((f) {
                  if (fine_min > fine_max) {
                    if (fine_min > f.FINE_AMOUNT) {
                      f.FINE_AMOUNT = fine_min;
                    }
                  }
                });
                List<ItemsFineProduct> _temp = [];
                for (var i = 0; i < tempItemsFineProduct.length; i++) {
                  _temp.add(tempItemsFineProduct[i]);
                }

                // ============================ for item people previous =========================
                if (widget.onEdit) {
                  List _tempProDGIDPrevious = [];
                  List _tempProDGIDNew = [];
                  List _tempProDGIDAdd = [];
                  List _tempProDGIDDel = [];
                  List _indexDel = [];
                  List _indexChange = [];
                  List testja = [];

                  for (var i = 0; i < itemsPeoplePrevious[0].itemsFineProduct.length; i++) {
                    _tempProDGIDPrevious.add(itemsPeoplePrevious[0].itemsFineProduct[i].PRODUCT_GROUP_ID);
                  }
                  for (var i = 0; i < tempItemsFineProduct.length; i++) {
                    _tempProDGIDNew.add(tempItemsFineProduct[i].PRODUCT_GROUP_ID);
                  }

                  print("old: ${_tempProDGIDPrevious.toString()}");
                  print("new: ${_tempProDGIDNew.toString()}");

                  for (var a = 0; a < itemsPeoplePrevious.length; a++) {
                    for (var b = 0; b < itemsPeoplePrevious[a].itemsFineProduct.length; b++) {
                      for (var c = 0; c < tempItemsFineProduct.length; c++) {
                        if (b == c) {
                          if (itemsPeoplePrevious[a].itemsFineProduct[b].PRODUCT_GROUP_ID != tempItemsFineProduct[c].PRODUCT_GROUP_ID) {
                            _indexChange.add(c);
                          }
                        }
                      }
                      //break;
                    }
                  }
                  print("_indexChange: ${_indexChange.toString()}");
                  for (var a = 0; a < itemsPeoplePrevious.length; a++) {
                    for (var b = 0; b < itemsPeoplePrevious[a].itemsFineProduct.length; b++) {
                      if (_indexChange.length > 0) {
                        for (var c = 0; c < _indexChange.length; c++) {
                          print(true);
                          if (b == _indexChange[c]) {
                            print("PRODUCT_GROUP_NAME 1: ${itemsPeoplePrevious[a].itemsFineProduct[b].PRODUCT_GROUP_NAME}");
                            print("PRODUCT_GROUP_NAME 2: ${tempItemsFineProduct[_indexChange[c]].PRODUCT_GROUP_NAME}");

                            itemsPeoplePrevious[a].itemsFineProduct[b].PRODUCT_GROUP_ID = tempItemsFineProduct[_indexChange[c]].PRODUCT_GROUP_ID;
                            itemsPeoplePrevious[a].itemsFineProduct[b].PRODUCT_GROUP_NAME = tempItemsFineProduct[_indexChange[c]].PRODUCT_GROUP_NAME;
                            itemsPeoplePrevious[a].itemsFineProduct[b].TAX = tempItemsFineProduct[_indexChange[c]].TAX;
                            itemsPeoplePrevious[a].itemsFineProduct[b].TIMES = 1;
                            itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE = tempItemsFineProduct[_indexChange[c]].FINE_RATE;
                            itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = tempItemsFineProduct[_indexChange[c]].FINE_AMOUNT;
                          } else {
                            print(true);
                            for (var k = 0; k < tempItemsFineProduct.length; k++) {
                              if (k != _indexChange[c]) {
                                print("TIMES end1: ${itemsPeoplePrevious[a].itemsFineProduct[b].TAX}");
                                itemsPeoplePrevious[a].itemsFineProduct[b].TAX = tempItemsFineProduct[k].TAX;

                                if (fine_min > fine_max) {
                                  if (itemsPeoplePrevious[a].itemsFineProduct[b].TAX == 0.0) {
                                    itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                                  } else {
                                    double sumIF1 = 0.0;
                                    // sumIF1 = itemsPeoplePrevious[a].itemsFineProduct[b].TAX * num.parse(itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE);
                                    sumIF1 = double.parse((Decimal.parse(itemsPeoplePrevious[a].itemsFineProduct[b].TAX.toString()) * Decimal.parse(itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE.toString())).toStringAsFixed(2));

                                    if (fine_min > sumIF1) {
                                      itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                                    } else {
                                      itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = sumIF1;
                                    }
                                  }
                                } else {
                                  if (itemsPeoplePrevious[a].itemsFineProduct[b].TAX == 0.0) {
                                    itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                                  } else {
                                    if (itemsPeoplePrevious[a].itemsFineProduct[b].TAX > fine_max) {
                                      itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_max;
                                    } else {
                                      if (itemsPeoplePrevious[a].itemsFineProduct[b].TAX <= fine_max && itemsPeoplePrevious[a].itemsFineProduct[b].TAX < fine_min) {
                                        itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                                      } else {
                                        double sumIF2 = 0.0;
                                        // sumIF2 = itemsPeoplePrevious[a].itemsFineProduct[b].TAX * num.parse(itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE);
                                        sumIF2 = double.parse((Decimal.parse(itemsPeoplePrevious[a].itemsFineProduct[b].TAX.toString()) * Decimal.parse(itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE.toString())).toStringAsFixed(2));

                                        if (fine_min > sumIF2) {
                                          itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                                        } else {
                                          itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = sumIF2;
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      } else {
                        for (var k = 0; k < tempItemsFineProduct.length; k++) {
                          print("TIMES end2: ${itemsPeoplePrevious[a].itemsFineProduct[b].TAX}");
                          if (b == k) {
                            itemsPeoplePrevious[a].itemsFineProduct[b].TAX = tempItemsFineProduct[k].TAX;
                            if (fine_min > fine_max) {
                              if (itemsPeoplePrevious[a].itemsFineProduct[b].TAX == 0.0) {
                                itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                              } else {
                                double sumIF1 = 0.0;
                                // sumIF1 = itemsPeoplePrevious[a].itemsFineProduct[b].TAX * num.parse(itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE);
                                sumIF1 = double.parse((Decimal.parse(itemsPeoplePrevious[a].itemsFineProduct[b].TAX.toString()) * Decimal.parse(itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE.toString())).toStringAsFixed(2));

                                if (fine_min > sumIF1) {
                                  itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                                } else {
                                  itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = sumIF1;
                                }
                              }
                            } else {
                              if (itemsPeoplePrevious[a].itemsFineProduct[b].TAX == 0.0) {
                                itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                              } else {
                                if (itemsPeoplePrevious[a].itemsFineProduct[b].TAX > fine_max) {
                                  itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_max;
                                } else {
                                  if (itemsPeoplePrevious[a].itemsFineProduct[b].TAX <= fine_max && itemsPeoplePrevious[a].itemsFineProduct[b].TAX < fine_min) {
                                    itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                                  } else {
                                    double sumIF2 = 0.0;
                                    // sumIF2 = itemsPeoplePrevious[a].itemsFineProduct[b].TAX * num.parse(itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE);
                                    sumIF2 = double.parse((Decimal.parse(itemsPeoplePrevious[a].itemsFineProduct[b].TAX.toString()) * Decimal.parse(itemsPeoplePrevious[a].itemsFineProduct[b].FINE_RATE.toString())).toStringAsFixed(2));

                                    if (fine_min > sumIF2) {
                                      itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = fine_min;
                                    } else {
                                      itemsPeoplePrevious[a].itemsFineProduct[b].FINE_AMOUNT = sumIF2;
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                  // test
                  for (var i = 0; i < itemsPeoplePrevious.length; i++) {
                    for (var j = 0; j < itemsPeoplePrevious[i].itemsFineProduct.length; j++) {
                      testja.add(itemsPeoplePrevious[i].itemsFineProduct[j].PRODUCT_GROUP_ID);
                    }
                  }
                  print("test: ${testja.toString()}}");

                  List<ItemsFinePeoplePage2> _tempPeople = [];
                  for (var i = 0; i < itemsPeoplePrevious.length; i++) {
                    _tempPeople.add(itemsPeoplePrevious[i]);
                  }

                  List<double> sumList = [];

                  for (var i = 0; i < _tempPeople.length; i++) {
                    for (var j = 0; j < _tempPeople[i].itemsFineProduct.length; j++) {
                      double checkSum = 0.0;
                      double numParse = 0.0;
                      String tempString = "";
                      tempString = _tempPeople[i].itemsFineProduct[j].TAX.toString();
                      numParse = double.parse(num.parse(tempString).toStringAsFixed(4));
                      checkSum = checkSum + numParse;
                      sumList.add(checkSum);

                      _controllersFineType3[j].text = formatter.format(num.parse(_tempPeople[i].itemsFineProduct[j].TAX.toString()));
                    }
                  }
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (!sumList.contains(0)) {
                    _navigateFineType3AddPersonEdit(context, _tempPeople);
                  } else {
                    new EmptyDialog(context, "กรุณากรอกจำนวนเงิน");
                  }
                  // _navigateFineType3AddPersonEdit(context, _tempPeople);
                } else {
                  List<double> sumList = [];

                  for (var i = 0; i < _temp.length; i++) {
                    double checkSum = 0.0;
                    double numParse = 0.0;
                    String tempString = "";
                    tempString = _temp[i].TAX.toString();
                    numParse = double.parse(num.parse(tempString).toStringAsFixed(4));
                    checkSum = checkSum + numParse;
                    sumList.add(checkSum);

                    _controllersFineType3[i].text = formatter.format(num.parse(_temp[i].TAX.toString()));
                  }
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (!sumList.contains(0)) {
                    _navigateFineType3AddPerson(context, _temp);
                  } else {
                    new EmptyDialog(context, "กรุณากรอกจำนวนเงิน");
                  }
                  // _navigateFineType3AddPerson(context, _temp);
                }
                // ===============================================================================
              },
              child: Text('ถัดไป', style: appBarStyle)),
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
            "เพิ่มของกลาง",
            style: styleTextAppbar,
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, "back");
              }),
          actions: tempItemsFineProduct.length > 0 ? btnSave : null,
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
                                          setState(() {
                                            widget.itemProduct.forEach((item) {
                                              if (item.PRODUCT_GROUP_ID == 13) {
                                                _itemsProductType.add(item);
                                              }
                                            });
                                            for (var i = 0; i < tempItemDataGuiltbaseFine.length; i++) {
                                              if (tempItemDataGuiltbaseFine[i].PRODUCT_GROUP_ID == 13) {
                                                for (var j = 0; j < _itemsProductType.length; j++) {
                                                  if (tempItemDataGuiltbaseFine[i].PRODUCT_GROUP_ID == _itemsProductType[j].PRODUCT_GROUP_ID) {
                                                    tempItemsFineProduct.add(new ItemsFineProduct(tempItemDataGuiltbaseFine[i].PRODUCT_GROUP_ID, _itemsProductType[j].PRODUCT_GROUP_NAME, 0.0, 1, tempItemDataGuiltbaseFine[i].FINE_RATE.round(), 0.0));
                                                    if (widget.onEdit) {
                                                      tempItemsFineProductInitForEdit.add(new ItemsFineProductInitForEdit(tempItemDataGuiltbaseFine[i].PRODUCT_GROUP_ID, _itemsProductType[j].PRODUCT_GROUP_NAME, 0.0, 1, tempItemDataGuiltbaseFine[i].FINE_RATE.round(), 0.0));
                                                      for (var k = 0; k < itemsPeoplePrevious.length; k++) {
                                                        itemsPeoplePrevious[k].itemsFineProduct.add(new ItemsFineProductPage2(tempItemDataGuiltbaseFine[i].PRODUCT_GROUP_ID, _itemsProductType[j].PRODUCT_GROUP_NAME, 0.0, 1, tempItemDataGuiltbaseFine[i].FINE_RATE.round(), 0.0));
                                                      }
                                                    }
                                                    break;
                                                  }
                                                }
                                              }
                                            }
                                            // // Check disable dropdown
                                            // nameNewDropD = [];
                                            // for (var i = 0; i < tempItemsFineProduct.length; i++) {
                                            //   nameNewDropD.add(tempItemsFineProduct[i].PRODUCT_GROUP_NAME);
                                            // }
                                          });
                                          _controllersFineType3.clear();
                                          _controllersFineType3.forEach((v) {
                                            v.dispose();
                                          });
                                        },
                                        splashColor: Colors.grey,
                                        child: Center(
                                          child: Text(
                                            "เพิ่มของกลาง",
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
