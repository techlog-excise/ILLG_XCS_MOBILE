import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_master_response.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_size.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/master/item_product_unit.dart';
import 'package:prototype_app_pang/model/Issue_Alert.dart';
import 'package:prototype_app_pang/model/SetProductName.dart';
import 'package:prototype_app_pang/model/test/Background.dart';
import 'package:prototype_app_pang/styles/myStyle.dart';

class TabScreenArrest5Created extends StatefulWidget {
  List ItemsData;
  bool IsNotice;
  ItemsMasProductSizeResponse itemsMasProductSize;
  ItemsMasProductUnitResponse itemsMasProductUnit;
  TabScreenArrest5Created({
    Key key,
    @required this.IsNotice,
    @required this.ItemsData,
    @required this.itemsMasProductUnit,
    @required this.itemsMasProductSize,
  }) : super(key: key);
  @override
  _TabScreenArrest5CreateState createState() => new _TabScreenArrest5CreateState();
}

class _TabScreenArrest5CreateState extends State<TabScreenArrest5Created> {
  List<ItemsListArrest5Controller> itemsController = [];

  int _countItem = 0;
  TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  Color labelColor = Color(0xff087de1);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
  TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
  TextStyle textStylePageName = TextStyle(fontSize: 12.0, color: Colors.grey[400], fontFamily: FontStyles().FontFamily);
  TextStyle textStyleStar = Styles.textStyleStar;

  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);
  EdgeInsets paddingLabelTitle = EdgeInsets.only(bottom: 16.0);

  final formatter = new NumberFormat("#,###.###");

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    widget.ItemsData.forEach((item) {
      TextEditingController editSize = new TextEditingController();
      TextEditingController editQauntity = new TextEditingController();
      TextEditingController editVolume = new TextEditingController();
      TextEditingController editQauntityUnit = new TextEditingController();
      TextEditingController editVolumeUnit = new TextEditingController();
      TextEditingController editProductDesc = new TextEditingController();

      FocusNode focusNodeSize = FocusNode();
      FocusNode focusNodeQauntity = FocusNode();
      FocusNode focusNodeVolume = FocusNode();
      FocusNode focusNodeQauntityUnit = FocusNode();
      FocusNode focusNodeVolumeUnit = FocusNode();
      FocusNode focusNodeProductDesc = FocusNode();

      editQauntityUnit.text = item.QUANTITY_UNIT;
      editVolumeUnit.text = item.VOLUMN_UNIT;

      itemsController.add(new ItemsListArrest5Controller(
          editSize,
          editQauntity,
          editVolume,
          editVolumeUnit,
          editQauntityUnit,
          editProductDesc,
          focusNodeSize,
          focusNodeQauntity,
          focusNodeVolume,
          focusNodeQauntityUnit,
          focusNodeVolumeUnit,
          focusNodeProductDesc,
          /*["ลิตร", 'มิลลิลิตร'],
          ["ขวด", 'ลัง']*/
          widget.itemsMasProductSize,
          widget.itemsMasProductUnit,
          null,
          null));
    });
    itemsController.forEach((item) {
      /*item.editSize.text = item.SIZES!=null?item.SIZES.toString():"";
      item.editQuantity.text = item.QUANTITY!=null?item.QUANTITY.toString():"";
      item.editVolume.text = item.VOLUMN!=null?item.VOLUMN.toString():"";

      if(item.dropdownValueSizeUnit!=null){
        item.editVolumeUnit.text = item.dropdownValueSizeUnit.SIZE_NAME_TH;
      }*/
    });
    for (int i = 0; i < widget.ItemsData.length; i++) {
      itemsController[i].editSize.text = widget.ItemsData[i].SIZES != null ? widget.ItemsData[i].SIZES.toString() : "";
      itemsController[i].editQuantity.text = widget.ItemsData[i].QUANTITY != null ? widget.ItemsData[i].QUANTITY.toString() : "";
      itemsController[i].editVolume.text = widget.ItemsData[i].VOLUMN != null ? widget.ItemsData[i].VOLUMN.toString() : "";

      itemsController[i].editQuantityUnit.text = widget.ItemsData[i].QUANTITY_UNIT != null ? widget.ItemsData[i].QUANTITY_UNIT.toString() : "ขวด";
      itemsController[i].editVolumeUnit.text = widget.ItemsData[i].SIZES_UNIT != null ? widget.ItemsData[i].SIZES_UNIT.toString() : "";
      /*if(item.dropdownValueSizeUnit!=null){
        item.editVolumeUnit.text = item.dropdownValueSizeUnit.SIZE_NAME_TH;
      }*/
    }
  }

  @override
  void dispose() {
    super.dispose();
    /*widget.ItemsData.forEach((item){
      item.Arrest6Controller.myFocusNodeSize.dispose();
      item.Arrest6Controller.myFocusNodeQuantity.dispose();
      item.Arrest6Controller.myFocusNodeVolume.dispose();
    });*/
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

  Widget _buildSearchResults() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return ListView.builder(
      itemCount: widget.ItemsData.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        double xSize = 0;
        int yCount = 0;
        double zTotal = 0;

        return Padding(
          // padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
          padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
          child: Container(
            padding: EdgeInsets.all(22.0),
            decoration: BoxDecoration(
                //color: Colors.white,
                shape: BoxShape.rectangle,
                border: Border(
                  // top: BorderSide(color: Colors.grey[300], width: 1.0),
                  // bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                  bottom: BorderSide(color: Colors.grey[100], width: 6.0),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "ชื่อสินค้า",
                        style: textLabelStyle,
                      ),
                      /*Text(" *", style: textStyleStar,),*/
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: paddingLabelTitle,
                        child: Text(
                          widget.ItemsData[index].PRODUCT_DESC.toString(),
                          style: textInputStyleTitle,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: paddingLabel,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "ข้อมูลสินค้าเพิ่มเติม",
                        style: textLabelStyle,
                      ),
                      /*Text(" *", style: textStyleStar,),*/
                    ],
                  ),
                ),
                Padding(
                  padding: paddingInputBox,
                  child: TextField(
                    focusNode: itemsController[index].myFocusNodeProductDesc,
                    controller: itemsController[index].editProductDesc,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    style: textInputStyle,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildLine,
                /*Row(
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
                                Text("ขนาด",
                                  style: textLabelStyle,),
                                */ /*Text(" *", style: textStyleStar,),*/ /*
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: itemsController[index].myFocusNodeSize,
                              controller: itemsController[index].editSize,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (text) {
                                xSize = double.parse(text);
                                zTotal = xSize * yCount;
                                itemsController[index].editVolume.text =
                                    formatter.format(zTotal).toString();
                              },
                            ),
                          ),
                          _buildLine,
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
                            child: Row(
                              children: <Widget>[
                                Text("หน่วย",
                                  style: textLabelStyle,),
                                */ /* Text(" *", style: textStyleStar,),*/ /*
                              ],
                            ),
                          ),
                          Container(
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<ItemsListProductSize>(
                                isExpanded: true,
                                value: itemsController[index]
                                    .dropdownValueSizeUnit,
                                onChanged: (ItemsListProductSize newValue) {
                                  setState(() {
                                    itemsController[index]
                                        .dropdownValueSizeUnit = newValue;
                                    itemsController[index].editVolumeUnit.text =
                                        itemsController[index]
                                            .dropdownValueSizeUnit.SIZE_NAME_TH.toString();
                                  });
                                },
                                items: itemsController[index]
                                    .dropdownItemsSizeUnit.RESPONSE_DATA
                                    .map<DropdownMenuItem<ItemsListProductSize>>((
                                    ItemsListProductSize value) {
                                  return DropdownMenuItem<ItemsListProductSize>(
                                    value: value,
                                    child: Text(value.SIZE_NAME_TH.toString(), style: textInputStyle),
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ),
                          _buildLine,
                        ],
                      ),
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
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "จำนวน",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  widget.IsNotice ? "" : " *",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: itemsController[index].myFocusNodeQuantity,
                              controller: itemsController[index].editQuantity,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              /*onChanged: (text) {
                                xSize=0;
                                if(itemsController[index].editSize.text.isEmpty){
                                  xSize = 0;
                                }else{
                                  xSize = double.parse(itemsController[index].editSize.text);
                                }
                                yCount = int.parse(text);
                                zTotal = xSize * yCount;
                                itemsController[index].editVolume.text =
                                    formatter.format(zTotal).toString();
                              },*/
                            ),
                          ),
                          _buildLine,
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
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "หน่วย",
                                  style: textLabelStyle,
                                ),
                                //Text(" *", style: textStyleStar,),
                              ],
                            ),
                          ),
                          /*Container(
                            width: Width,
                            //padding: paddingInputBox,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<ItemsListProductUnit>(
                                isExpanded: true,
                                value: itemsController[index]
                                    .dropdownValueQuantityUnit,
                                onChanged: (ItemsListProductUnit newValue) {
                                  setState(() {
                                    itemsController[index]
                                        .dropdownValueQuantityUnit = newValue;
                                  });
                                },
                                items: itemsController[index]
                                    .dropdownItemsQuantityUnit.RESPONSE_DATA
                                    .map<DropdownMenuItem<ItemsListProductUnit>>((
                                    ItemsListProductUnit value) {
                                  return DropdownMenuItem<ItemsListProductUnit>(
                                    value: value,
                                    child: Text(value.UNIT_NAME_TH.toString(), style: textInputStyle),
                                  );
                                })
                                    .toList(),
                              ),
                            ),
                          ),
                          _buildLine,*/
                          Container(
                            width: Width,
                            //padding: paddingInputBox,
                            child: TextField(
                              enabled: false,
                              focusNode: itemsController[index].myFocusNodeQuantityUnit,
                              controller: itemsController[index].editQuantityUnit,
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
                                  "ปริมาณสุทธิ",
                                  style: textLabelStyle,
                                ),
                                Text(
                                  widget.IsNotice ? "" : " *",
                                  style: textStyleStar,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: paddingInputBox,
                            child: TextField(
                              focusNode: itemsController[index].myFocusNodeVolume,
                              controller: itemsController[index].editVolume,
                              keyboardType: TextInputType.number,
                              textCapitalization: TextCapitalization.words,
                              style: textInputStyle,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          _buildLine,
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
                              focusNode: itemsController[index].myFocusNodeVolumeUnit,
                              controller: itemsController[index].editVolumeUnit,
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
          ),
        );
      },
    );
  }

  Widget _buildBottom(BuildContext mContext) {
    var size = MediaQuery.of(context).size;

    bool isCheck = false;
    _countItem = 0;
    widget.ItemsData.forEach((item) {
      if (item.IsCheck)
        setState(() {
          isCheck = item.IsCheck;
          _countItem++;
        });
    });
    return Container(
      width: size.width,
      height: 65,
      color: Color(0xff2e76bc),
      child: MaterialButton(
        onPressed: () {
          for (int i = 0; i < widget.ItemsData.length; i++) {
            if (!widget.IsNotice && itemsController[i].editQuantity.text.isEmpty) {
              new VerifyDialog(mContext, 'กรุณากรอกจำนวน');
            } else if (!widget.IsNotice && itemsController[i].editVolume.text.isEmpty) {
              new VerifyDialog(mContext, 'กรุณากรอกปริมาณสุทธิ');
            } else {
              widget.ItemsData[i].SIZES_UNIT_ID = /*itemsController[i].dropdownValueSizeUnit.SIZE_ID*/ null;
              widget.ItemsData[i].QUATITY_UNIT_ID = /*itemsController[i].dropdownValueQuantityUnit.UNIT_ID*/ null;
              widget.ItemsData[i].VOLUMN_UNIT_ID = /*itemsController[i].dropdownValueSizeUnit.SIZE_ID*/ null;
              widget.ItemsData[i].SIZES = itemsController[i].editSize.text.isEmpty ? null : double.parse(itemsController[i].editSize.text.replaceAll(",", ""));
              widget.ItemsData[i].QUANTITY = widget.IsNotice ? (itemsController[i].editQuantity.text.isEmpty ? null : double.parse(itemsController[i].editQuantity.text.replaceAll(",", ""))) : double.parse(itemsController[i].editQuantity.text.replaceAll(",", ""));
              widget.ItemsData[i].VOLUMN = itemsController[i].editVolume.text.isEmpty ? null : double.parse(itemsController[i].editVolume.text.replaceAll(",", ""));
              widget.ItemsData[i].SIZES_UNIT = itemsController[i].editVolumeUnit.text;
              widget.ItemsData[i].QUANTITY_UNIT = itemsController[i].editQuantityUnit.text;
              widget.ItemsData[i].VOLUMN_UNIT = itemsController[i].editVolumeUnit.text.isEmpty ? null : itemsController[i].editVolumeUnit.text;

              widget.ItemsData[i].PRODUCT_DESC = widget.ItemsData[i].PRODUCT_DESC;
              widget.ItemsData[i].REMARK = itemsController[i].editProductDesc.text;
            }
          }

          List item_ops = [];
          widget.ItemsData.forEach((item) {
            item_ops.add(new ItemsListArrestOps(
                item.PRODUCT_MAPPING_ID,
                item.PRODUCT_CODE,
                item.PRODUCT_REF_CODE,
                item.PRODUCT_ID,
                item.PRODUCT_GROUP_ID,
                item.PRODUCT_CATEGORY_ID,
                item.PRODUCT_TYPE_ID,
                item.PRODUCT_SUBTYPE_ID,
                item.PRODUCT_SUBSETTYPE_ID,
                item.PRODUCT_BRAND_ID,
                item.PRODUCT_SUBBRAND_ID,
                item.PRODUCT_MODEL_ID,
                item.PRODUCT_TAXDETAIL_ID,
                item.UNIT_ID,
                item.PRODUCT_GROUP_NAME,
                item.PRODUCT_CATEGORY_NAME,
                item.PRODUCT_TYPE_NAME,
                item.PRODUCT_SUBTYPE_NAME,
                item.PRODUCT_SUBSETTYPE_NAME,
                item.PRODUCT_BRAND_NAME_TH,
                item.PRODUCT_BRAND_NAME_EN,
                null,
                item.PRODUCT_SUBBRAND_NAME_TH,
                item.PRODUCT_SUBBRAND_NAME_EN,
                item.PRODUCT_MODEL_NAME_TH,
                item.PRODUCT_MODEL_NAME_EN,
                item.SIZES_UNIT_ID,
                item.QUANTITY,
                item.VOLUMN_UNIT_ID,
                item.SIZES,
                item.QUATITY_UNIT_ID,
                item.VOLUMN,
                item.SIZES_UNIT,
                item.QUANTITY_UNIT,
                item.VOLUMN_UNIT,
                null,
                item.TAX_VALUE,
                item.TAX_VOLUMN,
                item.TAX_VOLUMN_UNIT,
                item.DEGREE,
                item.SUGAR,
                item.CO2,
                item.PRICE,
                item.PRODUCT_DESC,
                item.COMPANYNAME,
                item.REMARK,
                item.IS_DOMESTIC,
                item.IsCheck,
                item.IsCheckOffence,
                new ItemsListArrest6Controller(
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new TextEditingController(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  new FocusNode(),
                  false,
                  false,
                ),
                item.INDEX));
          });
          //List item_ops = []..addAll(widget.ItemsData);

          ItemsListArrest5Test items_test = new ItemsListArrest5Test(widget.ItemsData, item_ops);
          Navigator.pop(context, items_test);

          //Navigator.pop(context,widget.ItemsData);
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
                "ค้นหาของกลาง",
                style: styleTextAppbar,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, "back");
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
                      top: BorderSide(color: Colors.grey[300], width: 1.0),
                    )),
                    /*child: Column(
                  children: <Widget>[Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new Text('ILG60_B_01_00_31_00',
                          style: textStylePageName,),
                      ),
                    ],
                  ),
                  ],
                )*/
                  ),
                  Expanded(
                    child: new ConstrainedBox(
                      constraints: const BoxConstraints.expand(),
                      child: _buildSearchResults(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottom(context),
      ),
    );
  }
}
