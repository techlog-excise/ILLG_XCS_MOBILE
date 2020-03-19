import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_5.dart';

class TabScreenArrest6Edit extends StatefulWidget {
  List<ItemsListArrest5> ItemsData;
  TabScreenArrest6Edit({
    Key key,
    @required this.ItemsData,
  }) : super(key: key);
  @override
  _TabScreenArrest6EditAddState createState() => new _TabScreenArrest6EditAddState();
}

class _TabScreenArrest6EditAddState extends State<TabScreenArrest6Edit> {
  List<ItemsListArrest5> _itemsData = [];

  final FocusNode myFocusNodeMainBrand = FocusNode();
  final FocusNode myFocusNodeSecondaryBrand = FocusNode();
  final FocusNode myFocusNodeProductModel = FocusNode();
  final FocusNode myFocusNodeProductValue = FocusNode();
  final FocusNode myFocusNodeVolumn = FocusNode();

  TextEditingController editMainBrand = new TextEditingController();
  TextEditingController editSecondaryBrand = new TextEditingController();
  TextEditingController editProductModel = new TextEditingController();
  TextEditingController editProductValue = new TextEditingController();
  TextEditingController editVolumn = new TextEditingController();

  List<String> dropdownItemsUnit = ["ขวด", 'ลัง', 'ลิตร'];
  List<String> dropdownItemsProductGroup = ["สุรา", 'เบียร์'];
  List<String> dropdownItemsProductCategory = ["สุราแช่"];
  List<String> dropdownItemsProductType = ["ชนิดเบียร์"];
  List<String> dropdownItemsSubProductType = [];
  List<String> dropdownItemsSubSetProductType = [];

  String dropdownProductUnit;
  String dropdownVolumnUnit;
  String dropdownValueProductGroup;
  String dropdownValueProductCategory = "สุราแช่";
  String dropdownValueProductType;
  String dropdownValueSubProductType = "";
  String dropdownValueSubSetProductType = "";

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    widget.ItemsData.forEach((item) {
      editMainBrand.text = item.PRODUCT_BRAND_NAME_TH;
      editProductModel.text = item.PRODUCT_MODEL_NAME_TH;
      editSecondaryBrand.text = item.PRODUCT_SUBBRAND_NAME_TH;

      editVolumn.text = item.VOLUMN.toString();
      editProductValue.text = item.QUANTITY.toString();
      dropdownProductUnit = item.QUANTITY_UNIT;
      dropdownVolumnUnit = item.VOLUMN_UNIT;
      dropdownValueProductGroup = item.PRODUCT_GROUP_NAME;
      //dropdownValueProductCategory = item.ProductCategory;
      dropdownValueProductType = item.PRODUCT_TYPE_NAME;
    });
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
    Color labelColor = Color(0xff087de1);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 85) / 100;
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border(
              top: BorderSide(color: Colors.grey[300], width: 1.0),
              bottom: BorderSide(color: Colors.grey[300], width: 1.0),
            )),
        width: size.width,
        child: Center(
          child: Container(
            padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
            width: Width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildInput(),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: _buildButtonImgPicker(),
                      ),
                      new Card(
                          shape: new RoundedRectangleBorder(side: new BorderSide(color: labelColor, width: 1.5), borderRadius: BorderRadius.circular(12.0)),
                          elevation: 0.0,
                          child: Container(
                            width: 100.0,
                            child: MaterialButton(
                              onPressed: () {
                                widget.ItemsData.forEach((item) {
                                  item.PRODUCT_GROUP_NAME = dropdownValueProductGroup;
                                  item.PRODUCT_CATEGORY_NAME = dropdownValueProductCategory;
                                  item.PRODUCT_TYPE_NAME = dropdownValueProductType;
                                  item.PRODUCT_SUBTYPE_NAME = dropdownValueSubProductType;
                                  item.PRODUCT_SUBSETTYPE_NAME = dropdownValueSubSetProductType;
                                  item.PRODUCT_BRAND_NAME_TH = editMainBrand.text;
                                  item.PRODUCT_SUBBRAND_NAME_TH = editSecondaryBrand.text;
                                  item.PRODUCT_MODEL_NAME_TH = editProductModel.text;
                                  item.QUANTITY = double.parse(editProductValue.text);
                                  item.QUANTITY_UNIT = dropdownProductUnit;
                                  item.VOLUMN = double.parse(editVolumn.text);
                                  item.VOLUMN_UNIT = dropdownVolumnUnit;
                                });
                                Navigator.pop(context, widget.ItemsData);
                              },
                              splashColor: Colors.grey,
                              child: Center(
                                child: Text(
                                  "บันทึก",
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
        ));
  }

  Widget _buildButtonImgPicker() {
    var size = MediaQuery.of(context).size;
    Color labelColor = Color(0xff087de1);
    Color boxColor = Colors.grey[300];
    Color uploadColor = Color(0xff31517c);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: uploadColor, fontFamily: FontStyles().FontFamily);
    return Container(
      //padding: EdgeInsets.all(18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Card(
              shape: new RoundedRectangleBorder(side: new BorderSide(color: boxColor, width: 1.5), borderRadius: BorderRadius.circular(42.0)),
              elevation: 0.0,
              child: Container(
                width: size.width / 2,
                child: MaterialButton(
                  onPressed: () {},
                  splashColor: Colors.grey,
                  child: Container(
                      padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.file_upload,
                              size: 32,
                              color: uploadColor,
                            ),
                          ),
                          Container(
                            //padding: EdgeInsets.all(4.0),
                            child: Text(
                              "แนบรูปของกลาง",
                              style: textLabelStyle,
                            ),
                          ),
                        ],
                      )),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildInput() {
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 100) / 100;
    Color labelColor = Color(0xff087de1);
    TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 4.0);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

    Widget _buildLine = Container(
      padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
      width: Width,
      height: 1.0,
      color: Colors.grey[300],
    );
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: paddingLabel,
          child: Text(
            "หมวดหมู่สินค้า",
            style: textLabelStyle,
          ),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueProductGroup,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueProductGroup = newValue;
                });
              },
              items: dropdownItemsProductGroup.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textInputStyle),
                );
              }).toList(),
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "กลุ่มสินค้า",
            style: textLabelStyle,
          ),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueProductCategory,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueProductCategory = newValue;
                });
              },
              items: dropdownItemsProductCategory.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textInputStyle),
                );
              }).toList(),
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ประเภทสินค้า",
            style: textLabelStyle,
          ),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueProductType,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueProductType = newValue;
                });
              },
              items: dropdownItemsProductType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textInputStyle),
                );
              }).toList(),
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ประเภทย่อยสินค้า",
            style: textLabelStyle,
          ),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueSubProductType,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueSubProductType = newValue;
                });
              },
              items: dropdownItemsSubSetProductType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textInputStyle),
                );
              }).toList(),
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "เซตประเภทย่อยสินค้า",
            style: textLabelStyle,
          ),
        ),
        Container(
          width: Width,
          //padding: paddingInputBox,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: dropdownValueSubSetProductType,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueSubSetProductType = newValue;
                });
              },
              items: dropdownItemsSubSetProductType.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: textInputStyle),
                );
              }).toList(),
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ยี่ห้อหลักสินค้า",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeMainBrand,
            controller: editMainBrand,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "ยี่ห้อรองสินค้า",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeSecondaryBrand,
            controller: editSecondaryBrand,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
        Container(
          padding: paddingLabel,
          child: Text(
            "รุ่นสินค้า",
            style: textLabelStyle,
          ),
        ),
        Padding(
          padding: paddingInputBox,
          child: TextField(
            focusNode: myFocusNodeProductModel,
            controller: editProductModel,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            style: textInputStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        _buildLine,
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
                  Padding(
                    padding: paddingInputBox,
                    child: TextField(
                      focusNode: myFocusNodeProductValue,
                      controller: editProductValue,
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownProductUnit,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownProductUnit = newValue;
                          });
                        },
                        items: dropdownItemsUnit.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: textInputStyle),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  _buildLine,
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
                  Padding(
                    padding: paddingInputBox,
                    child: TextField(
                      focusNode: myFocusNodeVolumn,
                      controller: editVolumn,
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
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownVolumnUnit,
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownVolumnUnit = newValue;
                          });
                        },
                        items: dropdownItemsUnit.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: textInputStyle),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  _buildLine,
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
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
                "แก้ไขของกลาง",
                style: styleTextAppbar,
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context, widget.ItemsData);
                }),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                //height: 34.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
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
                        child: new Text('ILG60_B_01_00_01_00',
                          style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily),),
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
                      child: _buildContent(context),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
