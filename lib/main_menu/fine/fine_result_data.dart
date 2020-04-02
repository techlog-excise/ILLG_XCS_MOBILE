import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:decimal/decimal.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/future_main/login_future.dart';
import 'package:prototype_app_pang/future_production/fine_future_production.dart';
import 'package:prototype_app_pang/future_production/login_future_production.dart';
import 'package:prototype_app_pang/main_menu/arrest/future/arrest_future_master.dart';
import 'package:prototype_app_pang/main_menu/find_law/model/item_masLawGroupSubSection.dart';
import 'package:prototype_app_pang/main_menu/fine/fine_finetype3.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_finePeople.dart';
import 'package:prototype_app_pang/main_menu/fine/model/item_fineIndex.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

Color labelColor = Color(0xff087de1);
TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
TextStyle textStyleTitle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
TextStyle textInputStyleSub = Styles.textStyleData;
TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
TextStyle textTitleContent2Black = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily, fontWeight: FontWeight.w600);
TextStyle textTitleContent2Blue = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily, fontWeight: FontWeight.w600);

TextStyle textSumStyle = TextStyle(fontSize: 20.0, color: labelColor, fontFamily: FontStyles().FontFamily);
TextStyle textLabelDelete = TextStyle(fontSize: 16.0, color: Colors.red, fontFamily: FontStyles().FontFamily);

class FineScreenResultData extends StatefulWidget {
  ItemsMasLawGroupSubSection ItemsData;
  String Title;
  int FineType;
  @override
  FineScreenResultData({
    Key key,
    @required this.ItemsData,
    @required this.Title,
    @required this.FineType,
  }) : super(key: key);
  _FineScreenResultData createState() => new _FineScreenResultData();
}

class _FineScreenResultData extends State<FineScreenResultData> {
  TextEditingController editLawsuit = new TextEditingController();
  TextEditingController editMistake = new TextEditingController();

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 0.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  final _buildLine = Container(
    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
    // width: width,
    height: 1.0,
    color: Colors.grey[300],
  );

  GlobalKey<ScaffoldState> _key;

  ItemsMasLawGroupSubSection _itemInit;
  List itemsFineType0 = [];
  List itemsFineType1 = [];
  List itemsFineType2 = [];
  List itemsFineType3 = [];

  List<double> itemsFineType0_fineAmount = [];
  List itemsFineType1_fineAmountAll = [];
  List<double> itemsFineType1_fineAmount = [];
  List itemsFineType2_volumnAll = [];
  List itemsFineType2_fineAmountAll = [];
  List<double> itemsFineType2_fineAmount = [];

  List<int> itemsFineType1_times = [1];
  List<double> itemsFineType2_volumn = [1];

  List itemsFineType1MasLawGuiFine = [];
  List itemsFineType2MasLawGuiFine = [];
  List itemsFineType3MasLawGuiFine = [];
  List itemsFineType3MasLawPenalty = [];

  List<TextEditingController> _controllersFineType0 = new List();
  List<FocusNode> _focusFineType0 = new List();
  List<TextEditingController> _controllersFineType1 = new List();
  List<FocusNode> _focusFineType1 = new List();
  // List<MoneyMaskedTextController> textyy = new List();
  List<TextEditingController> _controllersFineType1Times = new List();
  List<FocusNode> _focusFineType1Times = new List();
  List<TextEditingController> _controllersFineType2 = new List();
  List<FocusNode> _focusFineType2 = new List();
  List<TextEditingController> _controllersFineType2Volumn = new List();
  List<FocusNode> _focusFineType2Volumn = new List();

  List _itemsDataProduct = [];

  double sum = 0.0;
  double sumType0 = 0.0;
  double sumType1 = 0.0;
  double sumType2 = 0.0;
  double sumType3 = 0.0;

  double maxFineType0 = 0.0;
  double minFineType0 = 0.0;
  double maxFineType1 = 0.0;
  double minFineType1 = 0.0;
  double maxFineType2 = 0.0;
  double minFineType2 = 0.0;
  double maxFineType3 = 0.0;
  double minFineType3 = 0.0;

  double initFineType0 = 0.0;
  double initFineType1 = 0.0;
  double initFineType2 = 0.0;

  bool isHaveGBF = false;
  int isCompare = 0;

  List<ItemsFineIndex> itemFineType3Index = [];
  List<ItemsFinePeople> itemFineType3People = [];

  final formatter = new NumberFormat("#,##0.00");
  final formatVolumn = new NumberFormat("#,##0.000");
  final formatTime = new NumberFormat("#,##0");

  final test = new NumberFormat.currency(decimalDigits: 0, customPattern: "#,##0");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // When user press arrow down keyboard
    _key = GlobalKey<ScaffoldState>();
    KeyboardVisibilityNotification().addNewListener(
      onHide: () {
        // _key.currentState.showSnackBar(
        //   SnackBar(
        //     content: Text("Keyboard closed"),
        //   ),
        // );
        if (itemsFineType0_fineAmount.length > 0) {
          for (var i = 0; i < _controllersFineType0.length; i++) {
            for (var j = 0; j < itemsFineType0_fineAmount.length; j++) {
              if (itemsFineType0_fineAmount[j] > maxFineType0 || itemsFineType0_fineAmount[j] < minFineType0) {
                new EmptyDialog(context, "จำนวนเงินที่ระบุเกินจากอัตราโทษ");
                itemsFineType0_fineAmount[j] = initFineType0;
              }
              double checkSum = 0.0;
              double numParse = 0.0;
              String tempString = "";
              tempString = itemsFineType0_fineAmount[j].toString();
              numParse = double.parse(num.parse(tempString).toStringAsFixed(2));
              checkSum = checkSum + numParse;
              if (checkSum == 0) {
                new EmptyDialog(context, "กรุณากรอกจำนวนเงิน");
                itemsFineType0_fineAmount[j] = initFineType0;
              }

              if (i == j) {
                _controllersFineType0[i].text = formatter.format(num.parse(itemsFineType0_fineAmount[j].toString()));
                _controllersFineType0[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType0[i].text.length));
              }
            }
          }

          sum = 0;
          sumType0 = 0;
          for (var i = 0; i < itemsFineType0_fineAmount.length; i++) {
            sumType0 = sumType0 + itemsFineType0_fineAmount[i];
          }

          setState(() {
            sum = sumType0;
          });
        } else if (itemsFineType1_fineAmount.length > 0) {
          for (var i = 0; i < _controllersFineType1.length; i++) {
            for (var j = 0; j < itemsFineType1_fineAmount.length; j++) {
              double checkSum = 0.0;
              double numParse = 0.0;
              String tempString = "";
              tempString = itemsFineType1_fineAmount[j].toString();
              numParse = double.parse(num.parse(tempString).toStringAsFixed(2));
              checkSum = checkSum + numParse;

              if (itemsFineType1_fineAmount[j] > maxFineType1 || itemsFineType1_fineAmount[j] < minFineType1 || checkSum == 0) {
                new EmptyDialog(context, checkSum == 0 ? "กรุณากรอกจำนวนเงิน" : "จำนวนเงินที่ระบุเกินจากอัตราโทษ");
                if (itemsFineType1_times[j] == 1) {
                  itemsFineType1_fineAmount[j] = initFineType1;
                  _controllersFineType1[j].text = formatter.format(num.parse(initFineType1.toString()));
                } else {
                  itemsFineType1MasLawGuiFine[0].forEach((f1) {
                    if (f1.MISTREAT_START_NO == itemsFineType1_times[j]) {
                      itemsFineType1_fineAmount[j] = f1.FINE_AMOUNT;
                      _controllersFineType1[j].text = formatter.format(num.parse(f1.FINE_AMOUNT.toString()));
                    } else if (f1.MISTREAT_START_NO != itemsFineType1_times[j] && f1.MISTREAT_TO_NO == 0) {
                      itemsFineType1_fineAmount[j] = f1.FINE_AMOUNT;
                      _controllersFineType1[j].text = formatter.format(num.parse(f1.FINE_AMOUNT.toString()));
                    }
                  });
                }
              }
              if (i == j) {
                _controllersFineType1[i].text = formatter.format(num.parse(itemsFineType1_fineAmount[j].toString()));
                _controllersFineType1[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType1[i].text.length));
              }
            }
          }
          for (var i = 0; i < _controllersFineType1Times.length; i++) {
            for (var j = 0; j < itemsFineType1_times.length; j++) {
              if (i == j) {
                _controllersFineType1Times[i].text = formatTime.format(int.parse(itemsFineType1_times[j].toString()));
                _controllersFineType1Times[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType1Times[i].text.length));
              }
            }
          }

          sum = 0;
          sumType1 = 0;
          for (var i = 0; i < itemsFineType1_fineAmount.length; i++) {
            sumType1 = sumType1 + itemsFineType1_fineAmount[i];
          }
          setState(() {
            sum = sumType1;
          });
        } else if (itemsFineType2_fineAmount.length > 0) {
          for (var j = 0; j < itemsFineType2_fineAmount.length; j++) {
            double checkSum = 0.0;
            double numParse = 0.0;
            String tempString = "";
            tempString = itemsFineType2_fineAmount[j].toString();
            numParse = double.parse(num.parse(tempString).toStringAsFixed(2));
            checkSum = checkSum + numParse;
            // print("checkSum: ${checkSum}");
            if (checkSum == 0) {
              // print("checkSum2: ${itemsFineType2_fineAmount[j]}");
              new EmptyDialog(context, "กรุณากรอกจำนวนเงิน");
              itemsFineType2_volumn[j] = double.parse("1");
              itemsFineType2_fineAmount[j] = initFineType2;
              _controllersFineType2[j].text = formatter.format(num.parse(itemsFineType2_fineAmount[j].toString()));
              _controllersFineType2Volumn[j].text = formatVolumn.format(num.parse(itemsFineType2_volumn[j].toString()));
            }
          }
          for (var j = 0; j < itemsFineType2_volumn.length; j++) {
            double checkSum = 0.0;
            double numParse = 0.0;
            String tempString = "";
            tempString = itemsFineType2_volumn[j].toString();
            numParse = double.parse(num.parse(tempString).toStringAsFixed(3));
            checkSum = checkSum + numParse;
            // print("checkSum: ${checkSum}");
            if (checkSum == 0) {
              // print("checkSum2: ${itemsFineType2_volumn[j]}");
              new EmptyDialog(context, "กรุณาใส่ปริมาณของกลาง");
              itemsFineType2_volumn[j] = double.parse("1");
              itemsFineType2_fineAmount[j] = initFineType2;
              _controllersFineType2[j].text = formatter.format(num.parse(itemsFineType2_fineAmount[j].toString()));
              _controllersFineType2Volumn[j].text = formatVolumn.format(num.parse(itemsFineType2_volumn[j].toString()));
            }
          }

          for (var i = 0; i < _controllersFineType2.length; i++) {
            for (var j = 0; j < itemsFineType2_fineAmount.length; j++) {
              if (i == j) {
                _controllersFineType2[i].text = formatter.format(num.parse(itemsFineType2_fineAmount[j].toString()));
                _controllersFineType2[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType2[i].text.length));
              }
            }
          }
          for (var i = 0; i < _controllersFineType2Volumn.length; i++) {
            for (var j = 0; j < itemsFineType2_volumn.length; j++) {
              if (i == j) {
                _controllersFineType2Volumn[i].text = formatVolumn.format(num.parse(itemsFineType2_volumn[j].toString()));
                _controllersFineType2Volumn[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType2Volumn[i].text.length));
              }
            }
          }

          sum = 0;
          sumType2 = 0;
          for (var i = 0; i < itemsFineType2_fineAmount.length; i++) {
            sumType2 = sumType2 + itemsFineType2_fineAmount[i];
          }
          setState(() {
            sum = sumType2;
          });
        }
      },
    );

    _itemInit = widget.ItemsData;
    if (widget.FineType == 0) {
      itemsFineType0.add(widget.ItemsData);
      itemsFineType0.forEach((f) {
        if (f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine.length > 0 && f.MasLawGroupSubSectionRule[0].MasLawLawGuiltbase[0].IS_COMPARE == 1) {
          // print("test: ${f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine[0].FINE_AMOUNT}");
          itemsFineType0_fineAmount.add(f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine[0].FINE_AMOUNT);
          maxFineType0 = f.MasLawGroupSubSectionRule[0].MasLawPenalty[0].FINE_MAX;
          minFineType0 = f.MasLawGroupSubSectionRule[0].MasLawPenalty[0].FINE_MIN;
          // print("maxFineType0: ${maxFineType0}");
          // print("minFineType0: ${minFineType0}");
          initFineType0 = f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine[0].FINE_AMOUNT;
          sumType0 = sumType0 + f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine[0].FINE_AMOUNT;

          isHaveGBF = true;
        } else {
          // print("object: ${f.MasLawGroupSubSectionRule[0].MasLawLawGuiltbase[0].IS_COMPARE}");
          isHaveGBF = false;
          isCompare = f.MasLawGroupSubSectionRule[0].MasLawLawGuiltbase[0].IS_COMPARE;
        }

        if (isHaveGBF != false) {
          _controllersFineType0.add(new TextEditingController(text: formatter.format(num.parse(itemsFineType0_fineAmount[0].toString()))));
          _focusFineType0.add(new FocusNode());
          _focusFineType0[0].addListener(_onFocusChangeFineType0);
        }
      });
    } else if (widget.FineType == 1) {
      itemsFineType1.add(widget.ItemsData);
      itemsFineType1.forEach((f) {
        maxFineType1 = f.MasLawGroupSubSectionRule[0].MasLawPenalty[0].FINE_MAX;
        minFineType1 = f.MasLawGroupSubSectionRule[0].MasLawPenalty[0].FINE_MIN;
        // print("maxFineType1: ${maxFineType1}");
        // print("minFineType1: ${minFineType1}");
        itemsFineType1MasLawGuiFine.add(f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine);
        List _temp = [];
        f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine.forEach((f) {
          // print("All fine amount type 1: ${f.FINE_AMOUNT}");
          _temp.add(f);
          if (f.MISTREAT_START_NO == 1) {
            itemsFineType1_fineAmount.add(f.FINE_AMOUNT);
            sumType1 = f.FINE_AMOUNT;
            initFineType1 = f.FINE_AMOUNT;
          }
        });
        itemsFineType1_fineAmountAll.add(_temp);
      });

      itemsFineType1_fineAmount.forEach((i) {
        _controllersFineType1.add(new TextEditingController(text: formatter.format(num.parse(i.toString()))));
        _focusFineType1.add(new FocusNode());
        _focusFineType1[0].addListener(_onFocusChangeFineType1);
      });
      itemsFineType1_times.forEach((i) {
        _controllersFineType1Times.add(new TextEditingController(text: formatTime.format(num.parse(i.toString()))));
        _focusFineType1Times.add(new FocusNode());
        _focusFineType1Times[0].addListener(_onFocusChangeFineType1);
      });
    } else if (widget.FineType == 2) {
      itemsFineType2.add(widget.ItemsData);
      itemsFineType2.forEach((f) {
        maxFineType2 = f.MasLawGroupSubSectionRule[0].MasLawPenalty[0].FINE_MAX;
        minFineType2 = f.MasLawGroupSubSectionRule[0].MasLawPenalty[0].FINE_MIN;
        // print("maxFineType2: ${maxFineType2}");
        // print("minFineType2: ${minFineType2}");

        itemsFineType2MasLawGuiFine.add(f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine);
        List _temp = [];
        List<double> compareFine = [];
        f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine.forEach((f) {
          // print("All fine amount type 2: ${f.FINE_AMOUNT}");
          _temp.add(f);
          compareFine.add(f.FINE_AMOUNT);
          if (f.MISTREAT_START_VOLUMN > f.MISTREAT_TO_NO) {
            if (f.MISTREAT_START_VOLUMN == 1) {
              itemsFineType2_fineAmount.add(f.FINE_AMOUNT);
              sumType2 = f.FINE_AMOUNT;
              initFineType2 = f.FINE_AMOUNT;
            }
          } else {
            if (f.MISTREAT_START_VOLUMN == 1 && f.MISTREAT_TO_NO == 1) {
              itemsFineType2_fineAmount.add(f.FINE_AMOUNT);
              sumType2 = f.FINE_AMOUNT;
              initFineType2 = f.FINE_AMOUNT;
            }
          }
        });

        itemsFineType2_fineAmountAll.add(_temp);

        _controllersFineType2.add(new TextEditingController(text: formatter.format(num.parse(itemsFineType2_fineAmount[0].toString()))));
        _focusFineType2.add(new FocusNode());
        _focusFineType2[0].addListener(_onFocusChangeFineType2);

        _controllersFineType2Volumn.add(new TextEditingController(text: formatVolumn.format(num.parse(itemsFineType2_volumn[0].toString()))));
        _focusFineType2Volumn.add(new FocusNode());
        _focusFineType2Volumn[0].addListener(_onFocusChangeFineType2);
      });
    } else if (widget.FineType == 3) {
      itemsFineType3.add(widget.ItemsData);
      itemsFineType3.forEach((f) {
        itemsFineType3MasLawGuiFine.add(f.MasLawGroupSubSectionRule[0].MasLawGuiltbaseFine);
        itemsFineType3MasLawPenalty.add(f.MasLawGroupSubSectionRule[0].MasLawPenalty);
      });
    }
    sum = widget.FineType == 0 ? sumType0 : widget.FineType == 1 ? sumType1 : widget.FineType == 2 ? sumType2 : widget.FineType == 3 ? sumType3 : 0;
  }

  void _onFocusChangeFineType0() {
    for (var i = 0; i < _controllersFineType0.length; i++) {
      for (var j = 0; j < itemsFineType0_fineAmount.length; j++) {
        // setState(() async {
        if (itemsFineType0_fineAmount[j] > maxFineType0 || itemsFineType0_fineAmount[j] < minFineType0) {
          new EmptyDialog(context, "จำนวนเงินที่ระบุเกินจากอัตราโทษ");
          itemsFineType0_fineAmount[j] = initFineType0;
        }
        // });

        double checkSum = 0.0;
        double numParse = 0.0;
        String tempString = "";
        tempString = itemsFineType0_fineAmount[j].toString();
        numParse = double.parse(num.parse(tempString).toStringAsFixed(2));
        checkSum = checkSum + numParse;
        if (checkSum == 0) {
          new EmptyDialog(context, "กรุณากรอกจำนวนเงิน");
          itemsFineType0_fineAmount[j] = initFineType0;
        }

        if (i == j) {
          _controllersFineType0[i].text = formatter.format(num.parse(itemsFineType0_fineAmount[j].toString()));
          _controllersFineType0[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType0[i].text.length));
        }
      }
    }

    sum = 0;
    sumType0 = 0;
    for (var i = 0; i < itemsFineType0_fineAmount.length; i++) {
      sumType0 = sumType0 + itemsFineType0_fineAmount[i];
    }

    setState(() {
      sum = sumType0;
    });
  }

  void _onFocusChangeFineType1() {
    for (var i = 0; i < _controllersFineType1.length; i++) {
      for (var j = 0; j < itemsFineType1_fineAmount.length; j++) {
        double checkSum = 0.0;
        double numParse = 0.0;
        String tempString = "";
        tempString = itemsFineType1_fineAmount[j].toString();
        numParse = double.parse(num.parse(tempString).toStringAsFixed(2));
        checkSum = checkSum + numParse;

        if (itemsFineType1_fineAmount[j] > maxFineType1 || itemsFineType1_fineAmount[j] < minFineType1 || checkSum == 0) {
          new EmptyDialog(context, checkSum == 0 ? "กรุณากรอกจำนวนเงิน" : "จำนวนเงินที่ระบุเกินจากอัตราโทษ");
          if (itemsFineType1_times[j] == 1) {
            itemsFineType1_fineAmount[j] = initFineType1;
            _controllersFineType1[j].text = formatter.format(num.parse(initFineType1.toString()));
          } else {
            itemsFineType1MasLawGuiFine[0].forEach((f1) {
              if (f1.MISTREAT_START_NO == itemsFineType1_times[j]) {
                itemsFineType1_fineAmount[j] = f1.FINE_AMOUNT;
                _controllersFineType1[j].text = formatter.format(num.parse(f1.FINE_AMOUNT.toString()));
              } else if (f1.MISTREAT_START_NO != itemsFineType1_times[j] && f1.MISTREAT_TO_NO == 0) {
                itemsFineType1_fineAmount[j] = f1.FINE_AMOUNT;
                _controllersFineType1[j].text = formatter.format(num.parse(f1.FINE_AMOUNT.toString()));
              }
            });
          }
        }

        if (i == j) {
          _controllersFineType1[i].text = formatter.format(num.parse(itemsFineType1_fineAmount[j].toString()));
          _controllersFineType1[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType1[i].text.length));
        }
      }
    }
    for (var i = 0; i < _controllersFineType1Times.length; i++) {
      for (var j = 0; j < itemsFineType1_times.length; j++) {
        if (i == j) {
          _controllersFineType1Times[i].text = formatTime.format(int.parse(itemsFineType1_times[j].toString()));
          _controllersFineType1Times[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType1Times[i].text.length));
        }
      }
    }
    // // ======================== sum ========================
    sum = 0;
    sumType1 = 0;
    for (var i = 0; i < itemsFineType1_fineAmount.length; i++) {
      sumType1 = sumType1 + itemsFineType1_fineAmount[i];
    }
    setState(() {
      sum = sumType1;
    });
  }

  void _onFocusChangeFineType2() {
    for (var j = 0; j < itemsFineType2_fineAmount.length; j++) {
      double checkSum = 0.0;
      double numParse = 0.0;
      String tempString = "";
      tempString = itemsFineType2_fineAmount[j].toString();
      numParse = double.parse(num.parse(tempString).toStringAsFixed(3));
      checkSum = checkSum + numParse;
      // print("checkSum: ${checkSum}");
      if (checkSum == 0) {
        // print("checkSum2: ${itemsFineType2_fineAmount[j]}");
        new EmptyDialog(context, "กรุณากรอกจำนวนเงิน");
        itemsFineType2_volumn[j] = double.parse("1");
        itemsFineType2_fineAmount[j] = initFineType2;
        _controllersFineType2[j].text = formatter.format(num.parse(itemsFineType2_fineAmount[j].toString()));
        _controllersFineType2Volumn[j].text = formatVolumn.format(num.parse(itemsFineType2_volumn[j].toString()));
      }
    }
    for (var j = 0; j < itemsFineType2_volumn.length; j++) {
      double checkSum = 0.0;
      double numParse = 0.0;
      String tempString = "";
      tempString = itemsFineType2_volumn[j].toString();
      numParse = double.parse(num.parse(tempString).toStringAsFixed(3));
      checkSum = checkSum + numParse;
      // print("checkSum: ${checkSum}");
      if (checkSum == 0) {
        // print("checkSum2: ${itemsFineType2_volumn[j]}");
        new EmptyDialog(context, "กรุณาใส่ปริมาณของกลาง");
        itemsFineType2_volumn[j] = double.parse("1");
        itemsFineType2_fineAmount[j] = initFineType2;
        _controllersFineType2[j].text = formatter.format(num.parse(itemsFineType2_fineAmount[j].toString()));
        _controllersFineType2Volumn[j].text = formatVolumn.format(num.parse(itemsFineType2_volumn[j].toString()));
      }
    }

    for (var i = 0; i < _controllersFineType2.length; i++) {
      for (var j = 0; j < itemsFineType2_fineAmount.length; j++) {
        if (i == j) {
          _controllersFineType2[i].text = formatter.format(num.parse(itemsFineType2_fineAmount[j].toString()));
          _controllersFineType2[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType2[i].text.length));
        }
      }
    }
    for (var i = 0; i < _controllersFineType2Volumn.length; i++) {
      for (var j = 0; j < itemsFineType2_volumn.length; j++) {
        if (i == j) {
          _controllersFineType2Volumn[i].text = formatVolumn.format(num.parse(itemsFineType2_volumn[j].toString()));
          _controllersFineType2Volumn[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType2Volumn[i].text.length));
        }
      }
    }
    // // ======================== sum ========================
    sum = 0;
    sumType2 = 0;
    for (var i = 0; i < itemsFineType2_fineAmount.length; i++) {
      sumType2 = sumType2 + itemsFineType2_fineAmount[i];
    }
    setState(() {
      sum = sumType2;
    });
  }

  // ==================== Navigate Add item FineType 3 ====================
  _navigateFineType3(BuildContext mContext) async {
    Map map = {
      "PRODUCT_GROUP_ID": "",
    };
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        });
    // await onLoadActionMasProductGroupgetByCon();
    await onLoadOAG(map);
    Navigator.pop(context);

    if (_itemsDataProduct != null) {
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) => FineFineType3(
                  itemsLaw: _itemInit,
                  itemProduct: _itemsDataProduct,
                  itemData: itemsFineType3MasLawGuiFine,
                  itemDataPenalty: itemsFineType3MasLawPenalty,
                  onEdit: false,
                )),
      );
      // if (result.toString() != "back") {
      //   itemFineType3Index += result;
      //   sum = 0;
      //   for (var i = 0; i < itemFineType3Index.length; i++) {
      //     for (var j = 0; j < itemFineType3Index[i].itemsFinePeople.length; j++) {
      //       sum += itemFineType3Index[i].itemsFinePeople[j].FINE_TOTAL;
      //     }
      //   }
      // }
      if (result.toString() != "back") {
        itemFineType3Index.add(new ItemsFineIndex(result));
        sum = 0;
        for (var i = 0; i < itemFineType3Index[0].itemsFinePeople.length; i++) {
          sum += itemFineType3Index[0].itemsFinePeople[i].FINE_TOTAL;
        }
      }
    }
  }

  // ======================================================================
  // ==================== Navigate Add item FineType 3 ====================
  _navigateFineType3Edit(BuildContext mContext) async {
    Map map = {
      "PRODUCT_GROUP_ID": "",
    };
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          );
        });
    // await onLoadActionMasProductGroupgetByCon();
    await onLoadOAG(map);
    Navigator.pop(context);

    if (_itemsDataProduct != null) {
      final result = await Navigator.push(
        mContext,
        MaterialPageRoute(
            builder: (context) => FineFineType3(
                  itemsLaw: _itemInit,
                  itemProduct: _itemsDataProduct,
                  itemData: itemsFineType3MasLawGuiFine,
                  itemDataPenalty: itemsFineType3MasLawPenalty,
                  itemAll: itemFineType3Index,
                  onEdit: true,
                )),
      );
      if (result.toString() != "back") {
        itemFineType3Index = [];
        itemFineType3Index.add(new ItemsFineIndex(result));
        sum = 0;
        for (var i = 0; i < itemFineType3Index.length; i++) {
          for (var j = 0; j < itemFineType3Index[i].itemsFinePeople.length; j++) {
            sum += itemFineType3Index[i].itemsFinePeople[j].FINE_TOTAL;
          }
        }
      }
    }
  }

  // ======================================================================
  // ==================== api get product =================================
  // Future<bool> onLoadActionMasProductGroupgetByCon() async {
  //   Map map = {
  //     "PRODUCT_GROUP_ID": "",
  //   };
  //   print(map);
  //   await new ArrestFutureMaster().apiRequestMasProductGroupgetByCon(map).then((onValue) {
  //     List _items = [];
  //     onValue.forEach((item) {
  //       _items.add(item);
  //     });
  //     _itemsDataProduct = _items;
  //   });
  //   setState(() {});
  //   return true;
  // }
  // ======================================================================

  // =========================== OAG ======================================
  Future<bool> onLoadOAG(map) async {
    String bodyText = "client_id=56e40953-db9d-477b-954e-73f3ec357190&client_secret=71ebae10-1726-4477-8719-2f5dac68281f&grant_source=int_ldap&grant_type=password&password=train01&scope=resource.READ&username=train01";
    String resToken = "";

    //await new LoginFuture().apiRequestOAG(bodyText).then((onValue) async {
    await new LoginFutureProduction().apiRequestProduction().then((onValue) async {
      resToken = onValue;
      print("Response: ${resToken.toString()}");
    });

    //await new LoginFuture().apiRequestMasProductGroupgetByCon(resToken, map).then((onValue) async {
    await new FineFutureProduction().apiRequestProductionMasProductGroupgetByCon(resToken, map).then((onValue) async {
      List _items = [];
      onValue.forEach((item) {
        _items.add(item);
      });
      _itemsDataProduct = _items;
    });
  }
  // ======================================================================

  @override
  void dispose() {
    _controllersFineType0.forEach((v) {
      v.dispose();
    });
    _controllersFineType1.forEach((v) {
      v.dispose();
    });
    _controllersFineType1Times.forEach((v) {
      v.dispose();
    });
    _controllersFineType2.forEach((v) {
      v.dispose();
    });
    _focusFineType0.forEach((v) {
      v.dispose();
    });
    _focusFineType1.forEach((v) {
      v.dispose();
    });
    _focusFineType1Times.forEach((v) {
      v.dispose();
    });
    _focusFineType2.forEach((v) {
      v.dispose();
    });
    _focusFineType2Volumn.forEach((v) {
      v.dispose();
    });
    // TODO: implement dispose
    super.dispose();
  }

  Widget _buildContent1(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    return Container(
      width: size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 40.0),
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
        ),
      ),
    );
  }

  Widget _buildContent2(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );

    return Container(
      width: size.width,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 4.0, bottom: 80.0),
          width: Width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              widget.FineType == 3
                  ? Container(
                      padding: paddingLabel,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'ทดลองคำนวณค่าปรับ',
                              style: textTitleContent2Black,
                            ),
                          ),
                          itemFineType3Index.length > 0
                              ? Container(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _navigateFineType3Edit(context);
                                            });
                                          },
                                          child: Container(
                                              child: Text(
                                            "แก้ไข",
                                            style: textLabelDelete,
                                          )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 40.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              itemFineType3Index.removeAt(0);
                                              sum = 0;
                                            });
                                          },
                                          child: Container(
                                              child: Text(
                                            "ลบ",
                                            style: textLabelDelete,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    )
                  : Container(
                      padding: paddingLabel,
                      child: Text(
                        'ทดลองคำนวณค่าปรับ',
                        style: textTitleContent2Black,
                      ),
                    ),
              widget.FineType == 0
                  ? isHaveGBF == true ? _buildContentFineType0(context) : _buildContentFineType0_2(context)
                  : widget.FineType == 1 ? _buildContentFineType1(context) : widget.FineType == 2 ? _buildContentFineType2(context) : widget.FineType == 3 ? itemFineType3Index.length > 0 ? _buildContentFineType3(context) : Container() : Container(),
              widget.FineType == 0 && isHaveGBF == false
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(top: 12.0, bottom: widget.FineType == 3 ? itemFineType3Index.length > 0 ? 30.0 : 6.0 : 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "รวมค่าปรับคดี",
                              style: textInputStyleSub,
                            ),
                          ),
                          Container(
                            child: Text(
                              // sum.toStringAsFixed(2),
                              formatter.format(num.parse(sum.toString())),
                              style: textSumStyle,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              " บาท",
                              style: textInputStyleSub,
                            ),
                          ),
                        ],
                      ),
                    ),
              // ============================ Add new ============================
              widget.FineType == 3
                  ? itemFineType3Index.length > 0
                      ? Container()
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: new Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: FloatingActionButton(
                              backgroundColor: Color(0xff087de1),
                              onPressed: () {
                                setState(() {
                                  _navigateFineType3(context);
                                  sumType3 = 0;
                                  sum = 0;
                                  if (itemFineType3Index.length > 0) {
                                    for (var i = 0; i < itemFineType3Index[0].itemsFinePeople.length; i++) {
                                      sumType3 += itemFineType3Index[0].itemsFinePeople[i].FINE_TOTAL;
                                    }
                                  }
                                  sum = sumType3;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              mini: false,
                              child: new Icon(Icons.add),
                            ),
                          ),
                        )
                  : widget.FineType == 0 && isHaveGBF == false
                      ? Container()
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: new Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: FloatingActionButton(
                              backgroundColor: Color(0xff087de1),
                              onPressed: () {
                                setState(() {
                                  if (widget.FineType == 0) {
                                    itemsFineType0_fineAmount.add(initFineType0);

                                    _controllersFineType0.add(new TextEditingController(text: formatter.format(num.parse(initFineType0.toString()))));
                                    _focusFineType0.add(new FocusNode());
                                    _focusFineType0[_focusFineType0.length - 1].addListener(_onFocusChangeFineType0);
                                    sumType0 = 0;
                                    itemsFineType0_fineAmount.forEach((item) {
                                      sumType0 = sumType0 + item;
                                    });
                                  } else if (widget.FineType == 1) {
                                    itemsFineType1_fineAmount.add(initFineType1);
                                    itemsFineType1_times.add(int.parse("1"));

                                    _controllersFineType1.add(new TextEditingController(text: formatter.format(num.parse(initFineType1.toString()))));
                                    _focusFineType1.add(new FocusNode());
                                    _focusFineType1[_focusFineType1.length - 1].addListener(_onFocusChangeFineType1);

                                    _controllersFineType1Times.add(new TextEditingController(text: formatTime.format(num.parse("1"))));
                                    _focusFineType1Times.add(new FocusNode());
                                    _focusFineType1Times[_focusFineType1Times.length - 1].addListener(_onFocusChangeFineType1);
                                    sumType1 = 0;
                                    for (var i = 0; i < itemsFineType1_fineAmount.length; i++) {
                                      sumType1 = sumType1 + itemsFineType1_fineAmount[i];
                                    }
                                  } else if (widget.FineType == 2) {
                                    itemsFineType2_fineAmount.add(initFineType2);
                                    itemsFineType2_volumn.add(double.parse("1"));

                                    _controllersFineType2.add(new TextEditingController(text: formatter.format(num.parse(initFineType2.toString()))));
                                    _focusFineType2.add(new FocusNode());
                                    _focusFineType2[_focusFineType2.length - 1].addListener(_onFocusChangeFineType2);

                                    _controllersFineType2Volumn.add(new TextEditingController(text: formatVolumn.format(num.parse("1"))));
                                    _focusFineType2Volumn.add(new FocusNode());
                                    _focusFineType2Volumn[_focusFineType2Volumn.length - 1].addListener(_onFocusChangeFineType2);

                                    sumType2 = 0;
                                    for (var i = 0; i < itemsFineType2_fineAmount.length; i++) {
                                      sumType2 = sumType2 + itemsFineType2_fineAmount[i];
                                    }
                                    sum = 0;
                                    sum = sumType2;
                                  }
                                  sum = 0;
                                  sum = widget.FineType == 0 ? sumType0 : widget.FineType == 1 ? sumType1 : widget.FineType == 2 ? sumType2 : 0;
                                });
                                FocusScope.of(context).unfocus();
                              },
                              mini: false,
                              child: new Icon(Icons.add),
                            ),
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================================
  // ==================================== Fine Type = 0 ========================================
  Widget _buildContentFineType0(BuildContext context) {
    return new Container(
      child: Padding(
        padding: itemsFineType0_fineAmount.length > 0 ? EdgeInsets.only(bottom: 20.0) : EdgeInsets.all(0.0),
        child: ListView.builder(
          itemCount: itemsFineType0_fineAmount.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            // itemsFineType0_fineAmount.forEach((str) {
            //   _controllersFineType0.add(new TextEditingController(text: formatter.format(num.parse(str.toString()))));
            // });
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ค่าปรับผู้ต้องหาคนที่ ${index + 1}",
                      style: textStyleTitle,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: paddingInputBox,
                          child: TextField(
                            controller: _controllersFineType0[index],
                            focusNode: _focusFineType0[index],
                            style: textInputStyle,
                            // keyboardType: TextInputType.number,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(bottom: 6.0),
                              isDense: true,
                            ),
                            onChanged: (string) {
                              if (string.trim().isEmpty) {
                                itemsFineType0_fineAmount[index] = initFineType0;
                              } else {
                                string = string.replaceAll(new RegExp(r'[!@#$%^&*()+?":{}|<>-]'), "");

                                String resultString = "";
                                if (string[0] == ",") {
                                  String temp = "";
                                  for (var i = 1; i < string.length; i++) {
                                    temp += string[i];
                                  }
                                  string = temp;
                                } else if (string[0] == ".") {
                                  string = "0" + string;
                                }

                                if (string.toString().contains(",") && string.toString().contains(".")) {
                                  List listCommaString = string.split(",").toList();
                                  List listDotString = [];
                                  String dot1 = "";
                                  String dot2 = "";
                                  String sumString = "";
                                  listCommaString.forEach((f) {
                                    sumString += f;
                                  });
                                  listDotString = sumString.split(".").toList();
                                  dot1 = listDotString[0];

                                  if (listDotString[1].length < 2) {
                                    dot2 = listDotString[1];
                                  } else {
                                    dot2 = listDotString[1].substring(0, 2);
                                  }

                                  resultString = dot1 + "." + dot2;
                                } else {
                                  if (string.toString().contains(",")) {
                                    List listString = string.split(",").toList();
                                    String sumString = "";

                                    listString.forEach((f) {
                                      sumString += f;
                                    });

                                    resultString = sumString;
                                  } else if (string.toString().contains(".")) {
                                    List listString = string.split(".").toList();

                                    String listStringIndex1 = "";
                                    String stringIndex2 = "";

                                    listStringIndex1 = listString[1];

                                    if (listStringIndex1.length < 2) {
                                      stringIndex2 = listStringIndex1;
                                    } else {
                                      stringIndex2 = listStringIndex1.substring(0, 2);
                                    }

                                    resultString = listString[0] + "." + stringIndex2;
                                  } else {
                                    resultString = string;
                                  }
                                }

                                itemsFineType0_fineAmount[index] = double.parse(resultString);
                              }
                              // ======================== sum ========================
                              sum = 0;
                              sumType0 = 0;
                              itemsFineType0_fineAmount.forEach((item) {
                                sumType0 = sumType0 + item;
                              });

                              setState(() {
                                sum = sumType0;
                              });
                              // =====================================================
                            },
                            onSubmitted: (string) {
                              // _controllersFineType0.clear();
                              setState(() {
                                if (itemsFineType0_fineAmount[index] > maxFineType0 || itemsFineType0_fineAmount[index] < minFineType0) {
                                  new EmptyDialog(context, "จำนวนเงินที่ระบุเกินจากอัตราโทษ");
                                  itemsFineType0_fineAmount[index] = initFineType0;
                                  _controllersFineType0[index].text = formatter.format(num.parse(initFineType0.toString()));
                                  _controllersFineType0[index].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType0[index].text.length));
                                }

                                double checkSum = 0.0;
                                double numParse = 0.0;
                                String tempString = "";
                                tempString = itemsFineType0_fineAmount[index].toString();
                                numParse = double.parse(num.parse(tempString).toStringAsFixed(2));
                                checkSum = checkSum + numParse;
                                if (checkSum == 0) {
                                  new EmptyDialog(context, "กรุณากรอกจำนวนเงิน");
                                  itemsFineType0_fineAmount[index] = initFineType0;
                                }

                                sum = 0;
                                sumType0 = 0;
                                itemsFineType0_fineAmount.forEach((item) {
                                  sumType0 = sumType0 + item;
                                });
                                sum = sumType0;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "บาท",
                          style: textInputStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                itemsFineType0_fineAmount.removeAt(index);
                                _controllersFineType0.removeAt(index);
                                _focusFineType0.removeAt(index);

                                sum = 0;
                                sumType0 = 0;
                                itemsFineType0_fineAmount.forEach((item) {
                                  sumType0 = sumType0 + item;
                                });
                                sum = sumType0;

                                for (var i = 0; i < _controllersFineType0.length; i++) {
                                  for (var j = 0; j < itemsFineType0_fineAmount.length; j++) {
                                    if (i == j) {
                                      _controllersFineType0[i].text = formatter.format(num.parse(itemsFineType0_fineAmount[j].toString()));
                                      _controllersFineType0[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType0[i].text.length));
                                    }
                                  }
                                }
                              });
                            },
                            child: Container(
                                child: Text(
                              "ลบ",
                              style: textLabelDelete,
                            )),
                          ),
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

  // ===========================================================================================
  // ==================================== Fine Type = 0 ========================================
  Widget _buildContentFineType0_2(BuildContext context) {
    return new Container(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Text(
          isCompare == 0 ? "ไม่สามารถเปรียบเทียบคดีได้ตาม มาตรา 137 วรรคหนึ่ง" : isCompare == 2 ? "อยู่ในอำนาจ คดด. เปรียบเทียบคดีตาม ม. 137 ว. หนึ่ง (2)" : "-",
          style: TextStyle(fontSize: 16.0, color: Colors.red, fontFamily: FontStyles().FontFamily, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  // ===========================================================================================

  // ==================================== Fine Type = 1 ========================================
  Widget _buildContentFineType1(BuildContext context) {
    return new Container(
      child: Padding(
        padding: itemsFineType1_fineAmount.length > 0 ? EdgeInsets.only(bottom: 20.0) : EdgeInsets.all(0.0),
        child: ListView.builder(
          itemCount: itemsFineType1_fineAmount.length,
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
                          padding: paddingLabel,
                          child: Text(
                            "ผู้ต้องหาคนที่ ${index + 1}",
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
                              itemsFineType1_fineAmount.removeAt(index);
                              itemsFineType1_times.removeAt(index);
                              _controllersFineType1.removeAt(index);
                              _controllersFineType1Times.removeAt(index);
                              _focusFineType1Times.removeAt(index);
                              _focusFineType1.removeAt(index);

                              sumType1 = 0;
                              for (var i = 0; i < itemsFineType1_fineAmount.length; i++) {
                                sumType1 = sumType1 + itemsFineType1_fineAmount[i];
                              }
                              sum = 0;
                              sum = sumType1;
                            });
                            for (var i = 0; i < _controllersFineType1.length; i++) {
                              for (var j = 0; j < itemsFineType1_fineAmount.length; j++) {
                                if (i == j) {
                                  _controllersFineType1[i].text = formatter.format(num.parse(itemsFineType1_fineAmount[j].toString()));
                                  _controllersFineType1[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType1[i].text.length));
                                }
                              }
                            }
                            for (var i = 0; i < _controllersFineType1Times.length; i++) {
                              for (var j = 0; j < itemsFineType1_times.length; j++) {
                                if (i == j) {
                                  _controllersFineType1Times[i].text = formatTime.format(int.parse(itemsFineType1_times[j].toString()));
                                  _controllersFineType1Times[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType1Times[i].text.length));
                                }
                              }
                            }
                          },
                          child: Container(
                              padding: paddingLabel,
                              child: Text(
                                "ลบ",
                                style: textLabelDelete,
                              )),
                        ),
                        // ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "จำนวนครั้งกระทำผิด",
                                style: textStyleTitle,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _controllersFineType1Times[index],
                                    focusNode: _focusFineType1Times[index],
                                    style: textInputStyle,
                                    keyboardType: TextInputType.number,
                                    // inputFormatters: <TextInputFormatter>[
                                    //   WhitelistingTextInputFormatter.digitsOnly,
                                    // ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 6.0),
                                      isDense: true,
                                    ),
                                    onChanged: (string) {
                                      if (string.trim().isEmpty) {
                                        itemsFineType1_times[index] = 1;
                                        itemsFineType1_fineAmount[index] = initFineType1;
                                      } else {
                                        string = string.replaceAll(new RegExp(r'[!@#$%^&*().+?":{}|<>-]'), "");

                                        // setState(() {
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
                                        itemsFineType1_times[index] = int.parse(resultString);

                                        // if (itemsFineType1_fineAmount[index] < minFineType1 || itemsFineType1_fineAmount[index] > maxFineType1) {
                                        itemsFineType1MasLawGuiFine[0].forEach((f1) {
                                          if (f1.MISTREAT_START_NO > f1.MISTREAT_TO_NO && int.parse(resultString) >= f1.MISTREAT_START_NO) {
                                            // print("f1.MISTREAT_START_NO: ${f1.MISTREAT_START_NO}");
                                            itemsFineType1_fineAmount[index] = f1.FINE_AMOUNT;
                                            _controllersFineType1[index].text = formatter.format(num.parse(itemsFineType1_fineAmount[index].toString()));
                                          } else if (f1.MISTREAT_START_NO == 0 && f1.MISTREAT_TO_NO == 0) {
                                            itemsFineType1_fineAmount[index] = f1.FINE_AMOUNT;
                                            _controllersFineType1[index].text = formatter.format(num.parse(itemsFineType1_fineAmount[index].toString()));
                                          } else if (f1.MISTREAT_START_NO == int.parse(resultString) && int.parse(resultString) == f1.MISTREAT_TO_NO) {
                                            itemsFineType1_fineAmount[index] = f1.FINE_AMOUNT;
                                            _controllersFineType1[index].text = formatter.format(num.parse(itemsFineType1_fineAmount[index].toString()));
                                          }
                                        });
                                        // }
                                      }
                                      // ======================== sum ========================
                                      sum = 0;
                                      sumType1 = 0;
                                      for (var i = 0; i < itemsFineType1_fineAmount.length; i++) {
                                        for (var j = 0; j < itemsFineType1_times.length; j++) {
                                          if (i == j) {
                                            if (itemsFineType1_times[j] == 1) {
                                              sumType1 = sumType1 + itemsFineType1_fineAmount[i];
                                            }
                                            if (itemsFineType1_times[j] > 1) {
                                              sumType1 = sumType1 + itemsFineType1_fineAmount[i];
                                            }
                                          }
                                        }
                                      }

                                      setState(() {
                                        itemsFineType1_times[index] = itemsFineType1_times[index];
                                        sum = sumType1;
                                      });
                                      // =====================================================
                                      // });
                                    },
                                    onSubmitted: (string) {
                                      setState(() {
                                        _controllersFineType1[index].text = formatter.format(num.parse(itemsFineType1_fineAmount[index].toString()));
                                        _controllersFineType1Times[index].text = formatTime.format(num.parse(itemsFineType1_times[index].toString()));
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0, right: 8.0),
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
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "ค่าปรับ",
                                style: textStyleTitle,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _controllersFineType1[index],
                                    focusNode: _focusFineType1[index],
                                    style: textInputStyle,
                                    // keyboardType: TextInputType.number,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 6.0),
                                      isDense: true,
                                    ),
                                    onChanged: (string) {
                                      if (string.trim().isEmpty) {
                                        itemsFineType1_times[index] = 1;
                                        itemsFineType1_fineAmount[index] = initFineType1;
                                      } else {
                                        string = string.replaceAll(new RegExp(r'[!@#$%^&*()+?":{}|<>-]'), "");

                                        String resultString = "";
                                        if (string[0] == ",") {
                                          String temp = "";
                                          for (var i = 1; i < string.length; i++) {
                                            temp += string[i];
                                          }
                                          string = temp;
                                        } else if (string[0] == ".") {
                                          string = "0" + string;
                                        }

                                        if (string.toString().contains(",") && string.toString().contains(".")) {
                                          List listCommaString = string.split(",").toList();
                                          List listDotString = [];
                                          String dot1 = "";
                                          String dot2 = "";
                                          String sumString = "";
                                          listCommaString.forEach((f) {
                                            sumString += f;
                                          });
                                          listDotString = sumString.split(".").toList();
                                          dot1 = listDotString[0];

                                          if (listDotString[1].length < 2) {
                                            dot2 = listDotString[1];
                                          } else {
                                            dot2 = listDotString[1].substring(0, 2);
                                          }

                                          resultString = dot1 + "." + dot2;
                                        } else {
                                          if (string.toString().contains(",")) {
                                            List listString = string.split(",").toList();
                                            String sumString = "";

                                            listString.forEach((f) {
                                              sumString += f;
                                            });

                                            resultString = sumString;
                                          } else if (string.toString().contains(".")) {
                                            List listString = string.split(".").toList();

                                            String listStringIndex1 = "";
                                            String stringIndex2 = "";

                                            listStringIndex1 = listString[1];

                                            if (listStringIndex1.length < 2) {
                                              stringIndex2 = listStringIndex1;
                                            } else {
                                              stringIndex2 = listStringIndex1.substring(0, 2);
                                            }

                                            resultString = listString[0] + "." + stringIndex2;
                                          } else {
                                            resultString = string;
                                          }
                                        }
                                        itemsFineType1_fineAmount[index] = double.parse(resultString);
                                      }
                                      // ======================== sum ========================
                                      sum = 0;
                                      sumType1 = 0;
                                      for (var i = 0; i < itemsFineType1_fineAmount.length; i++) {
                                        sumType1 = sumType1 + itemsFineType1_fineAmount[i];
                                      }

                                      setState(() {
                                        sum = sumType1;
                                      });
                                    },
                                    onSubmitted: (string) {
                                      setState(() {
                                        double checkSum = 0.0;
                                        double numParse = 0.0;
                                        String tempString = "";
                                        tempString = itemsFineType1_fineAmount[index].toString();
                                        numParse = double.parse(num.parse(tempString).toStringAsFixed(2));
                                        checkSum = checkSum + numParse;

                                        if (itemsFineType1_fineAmount[index] > maxFineType1 || itemsFineType1_fineAmount[index] < minFineType1 || checkSum == 0) {
                                          new EmptyDialog(context, checkSum == 0 ? "กรุณาใส่จำนวนเงิน" : "จำนวนเงินที่ระบุเกินจากอัตราโทษ");
                                          if (itemsFineType1_times[index] == 1) {
                                            itemsFineType1_fineAmount[index] = initFineType1;
                                            _controllersFineType1[index].text = formatter.format(num.parse(initFineType1.toString()));
                                          } else {
                                            itemsFineType1MasLawGuiFine[0].forEach((f1) {
                                              if (f1.MISTREAT_START_NO == itemsFineType1_times[index]) {
                                                itemsFineType1_fineAmount[index] = f1.FINE_AMOUNT;
                                                _controllersFineType1[index].text = formatter.format(num.parse(f1.FINE_AMOUNT.toString()));
                                              } else if (f1.MISTREAT_START_NO != itemsFineType1_times[index] && f1.MISTREAT_TO_NO == 0) {
                                                itemsFineType1_fineAmount[index] = f1.FINE_AMOUNT;
                                                _controllersFineType1[index].text = formatter.format(num.parse(f1.FINE_AMOUNT.toString()));
                                              }
                                            });
                                          }
                                        }

                                        // ======================== sum ========================
                                        sum = 0;
                                        sumType1 = 0;
                                        for (var i = 0; i < itemsFineType1_fineAmount.length; i++) {
                                          sumType1 = sumType1 + itemsFineType1_fineAmount[i];
                                        }
                                        sum = sumType1;
                                        // =====================================================
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0),
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

  // ===========================================================================================
  // ==================================== Fine Type = 2 ========================================
  Widget _buildContentFineType2(BuildContext context) {
    return new Container(
      child: Padding(
        padding: itemsFineType2_fineAmount.length > 0 ? EdgeInsets.only(bottom: 20.0) : EdgeInsets.all(0.0),
        child: ListView.builder(
          itemCount: itemsFineType2_fineAmount.length,
          // scrollDirection: Axis.vertical,
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
                          padding: paddingLabel,
                          child: Text(
                            "ผู้ต้องหาคนที่ ${index + 1}",
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
                              itemsFineType2_fineAmount.removeAt(index);
                              itemsFineType2_volumn.removeAt(index);
                              _controllersFineType2.removeAt(index);
                              _controllersFineType2Volumn.removeAt(index);
                              _focusFineType2Volumn.removeAt(index);
                              _focusFineType2.removeAt(index);

                              sumType2 = 0;
                              for (var i = 0; i < itemsFineType2_fineAmount.length; i++) {
                                sumType2 = sumType2 + itemsFineType2_fineAmount[i];
                              }
                              sum = 0;
                              sum = sumType2;
                            });
                            for (var i = 0; i < _controllersFineType2.length; i++) {
                              for (var j = 0; j < itemsFineType2_fineAmount.length; j++) {
                                if (i == j) {
                                  _controllersFineType2[i].text = formatter.format(num.parse(itemsFineType2_fineAmount[j].toString()));
                                  _controllersFineType2[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType2[i].text.length));
                                }
                              }
                            }
                            for (var i = 0; i < _controllersFineType2Volumn.length; i++) {
                              for (var j = 0; j < itemsFineType2_volumn.length; j++) {
                                if (i == j) {
                                  _controllersFineType2Volumn[i].text = formatVolumn.format(int.parse(itemsFineType2_volumn[j].toString()));
                                  _controllersFineType2Volumn[i].selection = TextSelection.fromPosition(TextPosition(offset: _controllersFineType2Volumn[i].text.length));
                                }
                              }
                            }
                          },
                          child: Container(
                              padding: paddingLabel,
                              child: Text(
                                "ลบ",
                                style: textLabelDelete,
                              )),
                        ),
                        // ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "ปริมาณของกลาง",
                                style: textStyleTitle,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _controllersFineType2Volumn[index],
                                    focusNode: _focusFineType2Volumn[index],
                                    style: textInputStyle,
                                    // keyboardType: TextInputType.number,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 6.0),
                                      isDense: true,
                                    ),
                                    onChanged: (string) {
                                      if (string.trim().isEmpty) {
                                        itemsFineType2_volumn[index] = double.parse("1");
                                        itemsFineType2_fineAmount[index] = initFineType2;
                                      } else {
                                        string = string.replaceAll(new RegExp(r'[!@#$%^&*()+?":{}|<>-]'), "");

                                        // setState(() {
                                        String resultString = "";
                                        if (string[0] == ",") {
                                          String temp = "";
                                          for (var i = 1; i < string.length; i++) {
                                            temp += string[i];
                                          }
                                          string = temp;
                                        } else if (string[0] == ".") {
                                          string = "0" + string;
                                        }

                                        if (string.toString().contains(",") && string.toString().contains(".")) {
                                          List listCommaString = string.split(",").toList();
                                          List listDotString = [];
                                          String dot1 = "";
                                          String dot2 = "";
                                          String sumString = "";
                                          listCommaString.forEach((f) {
                                            sumString += f;
                                          });
                                          listDotString = sumString.split(".").toList();
                                          dot1 = listDotString[0];

                                          if (listDotString[1].length < 3) {
                                            dot2 = listDotString[1];
                                          } else {
                                            dot2 = listDotString[1].substring(0, 3);
                                          }

                                          resultString = dot1 + "." + dot2;
                                        } else {
                                          if (string.toString().contains(",")) {
                                            List listString = string.split(",").toList();
                                            String sumString = "";

                                            listString.forEach((f) {
                                              sumString += f;
                                            });

                                            resultString = sumString;
                                          } else if (string.toString().contains(".")) {
                                            List listString = string.split(".").toList();

                                            String listStringIndex1 = "";
                                            String stringIndex2 = "";

                                            listStringIndex1 = listString[1];

                                            if (listStringIndex1.length < 3) {
                                              stringIndex2 = listStringIndex1;
                                            } else {
                                              stringIndex2 = listStringIndex1.substring(0, 3);
                                            }

                                            resultString = listString[0] + "." + stringIndex2;
                                          } else {
                                            resultString = string;
                                          }
                                        }

                                        itemsFineType2_volumn[index] = double.parse(num.parse(resultString).toStringAsFixed(3));

                                        for (var i = 0; i < itemsFineType2MasLawGuiFine[0].length; i++) {
                                          if ((double.parse(resultString) < itemsFineType2MasLawGuiFine[0][i].MISTREAT_TO_VOLUMN) && (double.parse(resultString) >= itemsFineType2MasLawGuiFine[0][i].MISTREAT_START_VOLUMN)) {
                                            itemsFineType2_fineAmount[index] = itemsFineType2MasLawGuiFine[0][i].FINE_AMOUNT;
                                            _controllersFineType2[index].text = formatter.format(num.parse(itemsFineType2_fineAmount[index].toString()));
                                            break;
                                          } else {
                                            if (itemsFineType2MasLawGuiFine[0][i].MISTREAT_START_VOLUMN > itemsFineType2MasLawGuiFine[0][i].MISTREAT_TO_VOLUMN) {
                                              itemsFineType2_fineAmount[index] = itemsFineType2MasLawGuiFine[0][i].FINE_AMOUNT;
                                              _controllersFineType2[index].text = formatter.format(num.parse(itemsFineType2_fineAmount[index].toString()));
                                              break;
                                            }
                                          }
                                        }
                                      }
                                      // ======================== sum ========================
                                      sum = 0;
                                      sumType2 = 0;
                                      itemsFineType2_fineAmount.forEach((item) {
                                        sumType2 = sumType2 + item;
                                      });

                                      setState(() {
                                        itemsFineType2_volumn[index] = itemsFineType2_volumn[index];
                                        sum = sumType2;
                                      });
                                      // =====================================================
                                      // });
                                    },
                                    onSubmitted: (string) {
                                      double checkSum = 0.0;
                                      double numParse = 0.0;
                                      String tempString = "";
                                      tempString = _controllersFineType2Volumn[index].toString();
                                      numParse = double.parse(num.parse(tempString).toStringAsFixed(3));
                                      checkSum = checkSum + numParse;
                                      setState(() {
                                        if (checkSum == 0) {
                                          new EmptyDialog(context, "กรุณาใส่ปริมาณของกลาง");
                                          itemsFineType2_volumn[index] = double.parse("1");
                                          itemsFineType2_fineAmount[index] = initFineType2;
                                        }
                                        // _controllersFineType2[index].text = formatter.format(num.parse(itemsFineType2_fineAmount[index].toString()));
                                        // _controllersFineType2Volumn[index].text = formatVolumn.format(num.parse(itemsFineType2_volumn[index].toString()));
                                        sum = sumType2;
                                      });
                                      sum = 0;
                                      sumType2 = 0;
                                      for (var i = 0; i < itemsFineType2_fineAmount.length; i++) {
                                        sumType2 = sumType2 + itemsFineType2_fineAmount[i];
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0, right: 8.0),
                                  child: Text(
                                    "ลิตร",
                                    style: textInputStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "ค่าปรับ",
                                style: textStyleTitle,
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    controller: _controllersFineType2[index],
                                    focusNode: _focusFineType2[index],
                                    style: textInputStyle,
                                    // keyboardType: TextInputType.number,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(bottom: 6.0),
                                      isDense: true,
                                    ),
                                    onChanged: (string) {
                                      if (string.trim().isEmpty) {
                                        itemsFineType2_volumn[index] = double.parse("1");
                                        itemsFineType2_fineAmount[index] = initFineType2;
                                      } else {
                                        string = string.replaceAll(new RegExp(r'[!@#$%^&*()+?":{}|<>-]'), "");

                                        // setState(() {
                                        String resultString = "";
                                        if (string[0] == ",") {
                                          String temp = "";
                                          for (var i = 1; i < string.length; i++) {
                                            temp += string[i];
                                          }
                                          string = temp;
                                        } else if (string[0] == ".") {
                                          string = "0" + string;
                                        }

                                        if (string.toString().contains(",") && string.toString().contains(".")) {
                                          List listCommaString = string.split(",").toList();
                                          List listDotString = [];
                                          String dot1 = "";
                                          String dot2 = "";
                                          String sumString = "";
                                          listCommaString.forEach((f) {
                                            sumString += f;
                                          });
                                          listDotString = sumString.split(".").toList();
                                          dot1 = listDotString[0];

                                          if (listDotString[1].length < 2) {
                                            dot2 = listDotString[1];
                                          } else {
                                            dot2 = listDotString[1].substring(0, 2);
                                          }

                                          resultString = dot1 + "." + dot2;
                                        } else {
                                          if (string.toString().contains(",")) {
                                            List listString = string.split(",").toList();
                                            String sumString = "";

                                            listString.forEach((f) {
                                              sumString += f;
                                            });

                                            resultString = sumString;
                                          } else if (string.toString().contains(".")) {
                                            List listString = string.split(".").toList();

                                            String listStringIndex1 = "";
                                            String stringIndex2 = "";

                                            listStringIndex1 = listString[1];

                                            if (listStringIndex1.length < 2) {
                                              stringIndex2 = listStringIndex1;
                                            } else {
                                              stringIndex2 = listStringIndex1.substring(0, 2);
                                            }

                                            resultString = listString[0] + "." + stringIndex2;
                                          } else {
                                            resultString = string;
                                          }
                                        }

                                        itemsFineType2_fineAmount[index] = double.parse(resultString);
                                      }
                                      // ======================== sum ========================
                                      sum = 0;
                                      sumType2 = 0;
                                      itemsFineType2_fineAmount.forEach((item) {
                                        sumType2 = sumType2 + item;
                                      });

                                      setState(() {
                                        itemsFineType2_fineAmount[index] = itemsFineType2_fineAmount[index];
                                        sum = sumType2;
                                      });
                                      // =====================================================
                                      // });
                                    },
                                    onSubmitted: (string) {
                                      double checkSum = 0.0;
                                      double numParse = 0.0;
                                      String tempString = "";
                                      tempString = itemsFineType2_fineAmount[index].toString();
                                      numParse = double.parse(num.parse(tempString).toStringAsFixed(3));
                                      checkSum = checkSum + numParse;
                                      setState(() {
                                        if (itemsFineType2_fineAmount[index] > maxFineType2 || itemsFineType2_fineAmount[index] < minFineType2 || checkSum == 0) {
                                          new EmptyDialog(context, checkSum == 0 ? "กรุณาใส่จำนวนเงิน" : "จำนวนเงินที่ระบุเกินจากอัตราโทษ");
                                          for (var i = 0; i < itemsFineType2MasLawGuiFine[0].length; i++) {
                                            if ((itemsFineType2_volumn[index] < itemsFineType2MasLawGuiFine[0][i].MISTREAT_TO_VOLUMN) && (itemsFineType2_volumn[index] >= itemsFineType2MasLawGuiFine[0][i].MISTREAT_START_VOLUMN)) {
                                              itemsFineType2_fineAmount[index] = itemsFineType2MasLawGuiFine[0][i].FINE_AMOUNT;
                                              // _controllersFineType2[index].text = formatter.format(num.parse(itemsFineType2_fineAmount[index].toString()));
                                              break;
                                            } else {
                                              if (itemsFineType2MasLawGuiFine[0][i].MISTREAT_START_VOLUMN > itemsFineType2MasLawGuiFine[0][i].MISTREAT_TO_VOLUMN) {
                                                itemsFineType2_fineAmount[index] = itemsFineType2MasLawGuiFine[0][i].FINE_AMOUNT;
                                                // _controllersFineType2[index].text = formatter.format(num.parse(itemsFineType2_fineAmount[index].toString()));
                                                break;
                                              }
                                            }
                                          }
                                          // ======================== sum ========================
                                          sum = 0;
                                          sumType2 = 0;
                                          itemsFineType2_fineAmount.forEach((item) {
                                            sumType2 = sumType2 + item;
                                          });
                                          sum = sumType2;
                                          // =====================================================
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10.0),
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

  // ===========================================================================================
  // ==================================== Fine Type = 3 ========================================
  Widget _buildContentFineType3(BuildContext context) {
    return new Container(
      child: Padding(
        padding: EdgeInsets.all(0.0),
        child: ListView.builder(
            itemCount: itemFineType3Index[0].itemsFinePeople.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              // =========================== build layout 2 =====================
              List<Widget> ListMyWidgets(int indexIndex) {
                List<Widget> list = new List();
                for (var i = 0; i < itemFineType3Index[0].itemsFinePeople[indexIndex].itemsFineProduct.length; i++) {
                  list.add(
                    new Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      itemFineType3Index[0].itemsFinePeople[indexIndex].itemsFineProduct[i].PRODUCT_GROUP_NAME,
                                      overflow: TextOverflow.ellipsis,
                                      style: textInputStyle,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 18.0),
                                  child: Text(
                                    formatter.format(num.parse(itemFineType3Index[0].itemsFinePeople[indexIndex].itemsFineProduct[i].FINE_AMOUNT.toString())),
                                    style: textStyleTitle,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Text(
                                    "บาท",
                                    style: textInputStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return list;
              }

              // ================================================================
              // =========================== main build =========================
              return Container(
                padding: EdgeInsets.only(top: index != 0 ? 8.0 : 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: paddingLabel,
                            child: Text(
                              "ผู้ต้องหาคนที่ ${index + 1}",
                              style: textTitleContent2Blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // =========================== layout 2 ===========================
                    Container(
                      padding: EdgeInsets.only(bottom: 12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // =========================== layout 2 ===========================
                          Column(children: ListMyWidgets(index)),
                          // ================================================================
                          // =========================== layout 3 ===========================
                          Container(
                            padding: paddingLabel,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "ค่าปรับรวมรายคน",
                                    style: textInputStyle,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    formatter.format(num.parse(itemFineType3Index[0].itemsFinePeople[index].FINE_TOTAL.toString())),
                                    style: textStyleTitle,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Text(
                                    "บาท",
                                    style: textInputStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // ================================================================
                        ],
                      ),
                    ),
                    Container(
                      // width: width,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                    // ================================================================
                  ],
                ),
              );
            }),
      ),
    );
  }

  // ==================================== build layout main ====================================
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: _key,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          widget.Title,
          style: styleTextAppbar,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context, "back");
            }),
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // ===========================================================================================
}
