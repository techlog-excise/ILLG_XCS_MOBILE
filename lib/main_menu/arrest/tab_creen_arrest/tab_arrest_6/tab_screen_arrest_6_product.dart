import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_size.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_unit.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class TabScreenArrest6Product extends StatefulWidget {
  var ItemsProduct;
  var ItemsProductEdit;
  bool IsComplete;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  TabScreenArrest6Product({
    Key key,
    @required this.ItemsProduct,
    @required this.ItemsProductEdit,
    @required this.IsComplete,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
  }) : super(key: key);
  @override
  _TabScreenArrest6EditAddState createState() => new _TabScreenArrest6EditAddState();
}

class _TabScreenArrest6EditAddState extends State<TabScreenArrest6Product> {
  var ItemsProduct;
  var ItemsProductEdit;

  final formatter = new NumberFormat("#,###.###");
  final formatter_money = new NumberFormat("#,###");
  final formatter_product = new NumberFormat("#,##0.000");

  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = Styles.textStyleStar;

  final FocusNode myFocusNodeSize = FocusNode();
  final FocusNode myFocusNodeSizeUnit = FocusNode();
  final FocusNode myFocusNodeQuantity = FocusNode();
  final FocusNode myFocusNodeQuantityUnit = FocusNode();
  final FocusNode myFocusNodeVolumn = FocusNode();
  final FocusNode myFocusNodeVolumeUnit = FocusNode();
  TextEditingController editSize = new TextEditingController();
  TextEditingController editSizeUnit = new TextEditingController();
  TextEditingController editQuantity = new TextEditingController();
  TextEditingController editQuantityUnit = new TextEditingController();
  TextEditingController editVolume = new TextEditingController();
  TextEditingController editVolumeUnit = new TextEditingController();

  double xSize = 0;
  int yCount = 0;
  double zTotal = 0;

  String PRODUCT_NAME_DESCE;

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    if (widget.IsComplete) {
      ItemsProduct = widget.ItemsProduct;

      try {
        print(ItemsProduct.PRODUCT_DESC);
        PRODUCT_NAME_DESCE = ItemsProduct.PRODUCT_DESC;
      } catch (_) {
        PRODUCT_NAME_DESCE = new SetProductName(ItemsProduct).PRODUCT_NAME.toString();
      }
    } else {
      ItemsProductEdit = widget.ItemsProductEdit;

      if (ItemsProductEdit.PRODUCT_GROUP_ID == 13 || ItemsProductEdit.PRODUCT_GROUP_ID == 2) {
        editSize.text = formatter_product.format(ItemsProductEdit.SIZES).toString();
        editVolume.text = formatter_product.format(ItemsProductEdit.VOLUMN).toString();
      } else {
        editSize.text = ItemsProductEdit.SIZES.toString();
        editVolume.text = ItemsProductEdit.VOLUMN.toString();
      }

      editQuantity.text = (ItemsProductEdit.QUANTITY.toInt()).toString();
      editVolumeUnit.text = ItemsProductEdit.VOLUMN_UNIT.toString();

      editSizeUnit.text = ItemsProductEdit.SIZES_UNIT.toString();
      editQuantityUnit.text = ItemsProductEdit.QUANTITY_UNIT.toString();

      try {
        print(ItemsProductEdit.PRODUCT_DESC);
        PRODUCT_NAME_DESCE = ItemsProductEdit.PRODUCT_DESC;
      } catch (_) {
        PRODUCT_NAME_DESCE = new SetProductName(ItemsProductEdit).PRODUCT_NAME.toString();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    editSize.dispose();
    editQuantity.dispose();
    editVolume.dispose();
    editVolumeUnit.dispose();
    editQuantityUnit.dispose();
    editSize.dispose();
  }

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(bottom: MediaQuery.of(context).viewInsets.bottom, right: 0.0, left: 0.0, child: InputDoneView());
    });

    overlayState.insert(overlayEntry);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  Widget _buildContent(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );

    return Padding(
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Container(
          height: size.height,
          padding: EdgeInsets.all(22.0),
          decoration: BoxDecoration(
              //color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                //top: BorderSide(color: Colors.grey[300], width: 1.0),
                bottom: BorderSide(color: Colors.grey[300], width: 1.0),
              )),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /* Container(
                    padding: paddingLabel,
                    child: Text("ชื่อของกลาง", style: textLabelStyle,),
                  ),*/
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: paddingInputBox,
                          child: Text(
                            PRODUCT_NAME_DESCE.toString(),
                            style: textInputStyleTitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "ขนาด",
                                    style: textLabelStyle,
                                  ),
                                  Text(
                                    " *",
                                    style: textStyleStar,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: myFocusNodeSize,
                                controller: editSize,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  xSize = double.parse(text);
                                  zTotal = xSize * yCount;
                                  editVolume.text = formatter.format(zTotal).toString();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หน่วย",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: myFocusNodeSizeUnit,
                                controller: editSizeUnit,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "จำนวน",
                                    style: textLabelStyle,
                                  ),
                                  Text(
                                    " *",
                                    style: textStyleStar,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: myFocusNodeQuantity,
                                controller: editQuantity,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (text) {
                                  yCount = int.parse(text);
                                  zTotal = xSize * yCount;
                                  editVolume.text = formatter.format(zTotal).toString();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หน่วย",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: myFocusNodeQuantityUnit,
                                controller: editQuantityUnit,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "ปริมาณสุทธิ",
                                style: textLabelStyle,
                              ),
                            ),
                            Padding(
                              padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: myFocusNodeVolumn,
                                controller: editVolume,
                                keyboardType: TextInputType.number,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หน่วย",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              width: Width,
                              //padding: paddingInputBox,
                              child: TextField(
                                enabled: false,
                                focusNode: myFocusNodeVolumeUnit,
                                controller: editVolumeUnit,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: textInputStyle,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildContent_saved(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );

    return Padding(
      padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Container(
          height: size.height,
          padding: EdgeInsets.all(22.0),
          decoration: BoxDecoration(
              //color: Colors.white,
              shape: BoxShape.rectangle,
              border: Border(
                  //top: BorderSide(color: Colors.grey[300], width: 1.0),
                  //bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  )),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: paddingInputBox,
                          child: Text(
                            PRODUCT_NAME_DESCE.toString(),
                            style: textInputStyleTitle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  /*Row(
                    children: <Widget>[
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          "ค่าปรับประมาณการ : ", style: textLabelStyle,),
                      ),
                      Container(
                        padding: paddingLabel,
                        child: Text(
                          formatter_money.format(ItemsProduct.FINE_ESTIMATE)
                              .toString() + " บาท",
                          style: textInputStyle,),
                      ),
                    ],
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "ขนาด",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                (ItemsProduct.PRODUCT_GROUP_ID == 13 || ItemsProduct.PRODUCT_GROUP_ID == 2 ? formatter_product : formatter).format(ItemsProduct.SIZES).toString(),
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หน่วย",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                ItemsProduct.SIZES_UNIT != null ? ItemsProduct.SIZES_UNIT : "",
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "จำนวน",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                (ItemsProduct.QUANTITY.toInt()).toString(),
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หน่วย",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                ItemsProduct.QUANTITY_UNIT == null ? "" : ItemsProduct.QUANTITY_UNIT.toString(),
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "ปริมาณสุทธิ",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                (ItemsProduct.PRODUCT_GROUP_ID == 13 || ItemsProduct.PRODUCT_GROUP_ID == 2 ? formatter_product : formatter).format(ItemsProduct.VOLUMN).toString(),
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: ((size.width * 75) / 100) / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "หน่วย",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                ItemsProduct.VOLUMN_UNIT != null ? ItemsProduct.VOLUMN_UNIT : "",
                                style: textInputStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildBottom() {
    TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
    var size = MediaQuery.of(context).size;
    return widget.IsComplete
        ? null
        : Container(
            width: size.width,
            height: 65,
            color: Color(0xff2e76bc),
            child: MaterialButton(
              onPressed: () {
                widget.ItemsProductEdit.SIZES = double.parse(editSize.text.replaceAll(",", ""));
                widget.ItemsProductEdit.QUANTITY = double.parse(editQuantity.text.replaceAll(",", ""));
                widget.ItemsProductEdit.VOLUMN = double.parse(editVolume.text.replaceAll(",", ""));
                /*widget.ItemsProductEdit.SIZES_UNIT = editSizeUnit.text;
          widget.ItemsProductEdit.QUANTITY_UNIT = editQuantityUnit.text;
          widget.ItemsProductEdit.VOLUMN_UNIT = editVolumeUnit.text;

          widget.ItemsProductEdit.SIZES_UNIT_ID = dropdownValueSizeUnit.SIZE_ID;
          widget.ItemsProductEdit.QUATITY_UNIT_ID = dropdownValueQuantityUnit.UNIT_ID;
          widget.ItemsProductEdit.VOLUMN_UNIT_ID = dropdownValueSizeUnit.SIZE_ID;*/

                Navigator.pop(context, widget.ItemsProductEdit);
              },
              child: Center(
                child: Text(
                  'ตกลง',
                  style: textStyleButton,
                ),
              ),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () {
          //
        },
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), // here the desired height
            child: AppBar(
              title: new Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: new Text(
                  !widget.IsComplete ? "งานจับกุม" : "ของกลาง",
                  style: styleTextAppbar,
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context, ItemsProduct);
                  }),
            ),
          ),
          body: Stack(
            children: <Widget>[
              BackgroundContent(),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //height: 34.0,
                      decoration: BoxDecoration(
                          //color: Colors.grey[200],
                          border: Border(
                              //top: BorderSide(color: Colors.grey[300], width: 1.0),
                              )),
                      /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_31_00',
                          style: TextStyle(color: Colors.grey[400],fontSize: 12.0,fontFamily: FontStyles().FontFamily),),
                      ),
                    ],
                  ),
                  ],
                )*/
                    ),
                    Expanded(
                      child: new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: SingleChildScrollView(
                            child: widget.IsComplete ? _buildContent_saved(context) : _buildContent(context),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // bottomNavigationBar: _buildBottom(),
        ));
  }
}
