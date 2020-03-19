import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:prototype_app_pang/component/input_done_view.dart';
import 'package:prototype_app_pang/font_family/font_style.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_controller.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_6_section.dart';
import 'package:prototype_app_pang/main_menu/arrest/model/item_arrest_product_mapping.dart';
import 'package:prototype_app_pang/main_menu/arrest/tab_creen_arrest/tab_arrest_6/tab_screen_arrest_6_product.dart';
import 'package:prototype_app_pang/model/test/Background.dart';

class TabScreenArrest6Mapping extends StatefulWidget {
  String Title;
  ItemsListArrest6Section ItemsData;
  TabScreenArrest6Mapping({
    Key key,
    @required this.Title,
    @required this.ItemsData,
  }) : super(key: key);
  @override
  _TabScreenArrest6EvidenceState createState() => new _TabScreenArrest6EvidenceState();
}

class _TabScreenArrest6EvidenceState extends State<TabScreenArrest6Mapping> {
  ItemsListArrest6Section _itemsInit;
  //ItemsListArrest6Section _itemsDataSelect;
  List _itemsDataSelect_pro = [];
  List _itemsDataSelect_delt = [];
  int _countItem = 0;
  bool isCheckAll = false;

  TextStyle textInputTitleStyle = TextStyle(fontSize: 18.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textInputStyle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  TextStyle textLabelStyle = TextStyle(fontSize: 16.0, color: Color(0xff087de1), fontFamily: FontStyles().FontFamily);
  TextStyle textDataSubStyle = TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
  EdgeInsets paddingInputBox = EdgeInsets.only(top: 4.0, bottom: 0.0);
  EdgeInsets paddingLabel = EdgeInsets.only(top: 12.0);

  double xFine = 0;
  List<ItemsListArrest6Controller> itemsController = [];

  OverlayEntry overlayEntry;

  @override
  void initState() {
    super.initState();

    _itemsInit = widget.ItemsData;

    /*if(_itemsInit.ArrestIndictmentDetail.length!=0){
      _itemsInit.ArrestIndictmentDetail.forEach((x){
        _itemsInit.ArrestIndictmentProduct.forEach((y) {
          itemsController.add(new ItemsListArrest6Controller(
              new TextEditingController(),
              null,
              null,
              null,
              null,
              new FocusNode(),
              null,
              null,
              null,
              null));
        });
      });
    }*/
    print(itemsController.length);
  }

  @override
  void dispose() {
    super.dispose();

    /*if(_itemsInit.ArrestIndictmentDetail!=null){
      _itemsInit.ArrestIndictmentDetail.forEach((item){
        item.myFocusNodeFine.dispose();
      });
    }

    if(_itemsInit.ArrestIndictmentProduct!=null) {
      _itemsInit.ArrestIndictmentProduct.forEach((item) {
        item.Arrest6Controller.myFocusNodeFine.dispose();
        item.Arrest6Controller.myFocusNodeProductUnit.dispose();
        item.Arrest6Controller.myFocusNodeVolumeUnit.dispose();
      });
    }*/
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
    TextStyle textLabelEditNonCheckStyle = TextStyle(fontSize: 16.0, color: Colors.red[100], fontFamily: FontStyles().FontFamily);
    TextStyle textInputStyleTitle = TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: FontStyles().FontFamily);
    EdgeInsets paddingLabel = EdgeInsets.only(top: 0.0);
    var size = MediaQuery.of(context).size;
    final double Width = (size.width * 40) / 100;

    buildCollapsed(index) {
      if (xFine > 0) {
        _itemsInit.ArrestIndictmentDetail[index].editFine.text = xFine.toString();
      }

      return Padding(
        padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text(
                _itemsInit.ArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH.toString() + '' + _itemsInit.ArrestIndictmentDetail[index].FIRST_NAME + " " + _itemsInit.ArrestIndictmentDetail[index].LAST_NAME,
                style: textInputTitleStyle,
              ),
            ),
            Container(
              padding: paddingLabel,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _itemsInit.ArrestIndictmentProduct.length > 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                "ของกลางA",
                                style: textLabelStyle,
                              ),
                            ),
                            Container(
                              padding: paddingLabel,
                              child: Text(
                                _itemsInit.ArrestIndictmentProduct.length > 0 ? _itemsInit.ArrestIndictmentProduct.length.toString() + " รายการ" : "-",
                                style: textDataSubStyle,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  Container(
                    padding: paddingLabel,
                    child: Text(
                      "ค่าปรับประมาณการ",
                      style: textLabelStyle,
                    ),
                  ),
                  Container(
                    width: size.width,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: Width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: paddingInputBox,
                                child: TextField(
                                  onTap: () {
                                    FocusScope.of(context).requestFocus(new FocusNode());
                                    _itemsInit.ArrestIndictmentDetail[index].expController.toggle();
                                  },
                                  style: textInputStyle,
                                  focusNode: _itemsInit.ArrestIndictmentDetail[index].myFocusNodeFine,
                                  controller: _itemsInit.ArrestIndictmentDetail[index].editFine,
                                  keyboardType: TextInputType.number,
                                  textCapitalization: TextCapitalization.words,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
                                height: 1.0,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: paddingLabel,
                          child: Text(
                            "\t\tบาท",
                            style: textLabelStyle,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    buildExpanded(index) {
      var size = MediaQuery.of(context).size;
      return Padding(
        padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: paddingLabel,
              child: Text(
                _itemsInit.ArrestIndictmentDetail[index].TITLE_SHORT_NAME_TH.toString() + '' + _itemsInit.ArrestIndictmentDetail[index].FIRST_NAME + " " + _itemsInit.ArrestIndictmentDetail[index].LAST_NAME,
                style: textInputTitleStyle,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: paddingLabel,
                  child: Text(
                    "ของกลางB",
                    style: textLabelStyle,
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // new
                  itemCount: _itemsInit.ArrestIndictmentProduct.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int j) {
                    TextEditingController editFine = _itemsInit.ArrestIndictmentProduct[j].Arrest6Controller.editFine;
                    FocusNode focusFine = _itemsInit.ArrestIndictmentProduct[j].Arrest6Controller.myFocusNodeFine;

                    return Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: paddingInputBox,
                            child: Text(
                              (j + 1).toString() +
                                  ". " +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_GROUP_NAME != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_GROUP_NAME.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_CATEGORY_NAME != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_CATEGORY_NAME.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_TYPE_NAME != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_TYPE_NAME.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_TH != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_TH.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_EN != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_EN.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_TH != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_TH.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_EN != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_EN.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_TH != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_TH.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_EN != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_EN.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].DEGREE != null ? (_itemsInit.ArrestIndictmentProduct[j].DEGREE.toString() + ' ดีกรี ') : ' ') +
                                  _itemsInit.ArrestIndictmentProduct[j].SIZES.toString() +
                                  ' ' +
                                  _itemsInit.ArrestIndictmentProduct[j].SIZES_UNIT.toString(),
                              style: textInputStyle,
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ค่าปรับประมาณการ",
                              style: textLabelStyle,
                            ),
                          ),
                          Container(
                            width: size.width,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: Width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingInputBox,
                                        child:
                                            /*TextField(
                                          style: textInputStyle,
                                          focusNode: _itemsInit
                                              .ArrestIndictmentProduct[j]
                                              .Arrest6Controller
                                              .myFocusNodeFine,
                                          controller: _itemsInit
                                              .ArrestIndictmentProduct[j]
                                              .Arrest6Controller
                                              .editFine,
                                          keyboardType: TextInputType.number,
                                          textCapitalization: TextCapitalization
                                              .words,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          onSubmitted: (text){
                                            setState(() {
                                              xFine=0;
                                              _itemsInit
                                                  .ArrestIndictmentProduct.forEach((item){

                                                xFine += double.parse(item.Arrest6Controller
                                                    .editFine.text);
                                              });

                                            });
                                          },
                                        ),*/
                                            TextField(
                                          style: textInputStyle,
                                          focusNode: focusFine,
                                          controller: editFine,
                                          keyboardType: TextInputType.number,
                                          textCapitalization: TextCapitalization.words,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          onSubmitted: (text) {
                                            setState(() {
                                              /*xFine=0;
                                              _itemsInit
                                                  .ArrestIndictmentProduct.forEach((item){

                                                xFine += double.parse(item.Arrest6Controller
                                                    .editFine.text);
                                              });*/
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "\t\tบาท",
                                    style: textLabelStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "จำนวน", style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: TextField(
                                    focusNode: _itemsInit
                                        .ArrestIndictmentProduct[j]
                                        .Arrest6Controller
                                        .myFocusNodeProductUnit,
                                    controller: _itemsInit
                                        .ArrestIndictmentProduct[j]
                                        .Arrest6Controller
                                        .editProductUnit,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textInputStyle,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, bottom: 4.0),
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "หน่วย", style: textLabelStyle,),
                                ),
                                Container(
                                  width: Width,
                                  padding: paddingInputBox,
                                  child: Text(_itemsInit
                                      .ArrestIndictmentProduct[j]
                                      .QUANTITY_UNIT,
                                    style: textInputStyle,),
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
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text("ปริมาณสุทธิ",
                                    style: textLabelStyle,),
                                ),
                                Padding(
                                  padding: paddingInputBox,
                                  child: TextField(
                                    focusNode: _itemsInit
                                        .ArrestIndictmentProduct[j]
                                        .Arrest6Controller
                                        .myFocusNodeVolumeUnit,
                                    controller: _itemsInit
                                        .ArrestIndictmentProduct[j]
                                        .Arrest6Controller.editVolumeUnit,
                                    keyboardType: TextInputType.number,
                                    textCapitalization: TextCapitalization
                                        .words,
                                    style: textInputStyle,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 0.0, bottom: 4.0),
                                  height: 1.0,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: ((size.width * 75) / 100) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start,
                              children: <Widget>[
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "หน่วย", style: textLabelStyle,),
                                ),
                                Container(
                                  width: Width,
                                  padding: paddingInputBox,
                                  child: Text(_itemsInit
                                      .ArrestIndictmentProduct[j]
                                      .VOLUMN_UNIT,
                                    style: textInputStyle,),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),*/
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      );
    }

    return _itemsInit.ArrestIndictmentDetail.length == 0
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            // new
            itemCount: _itemsInit.ArrestIndictmentProduct.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int j) {
              return Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                child: Container(
                    padding: EdgeInsets.all(22.0),
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border(
                          //top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )),
                    child: Container(
                      padding: paddingLabel,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: paddingInputBox,
                            child: Text(
                              (j + 1).toString() +
                                  ". " +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_GROUP_NAME != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_GROUP_NAME.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_CATEGORY_NAME != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_CATEGORY_NAME.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_TYPE_NAME != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_TYPE_NAME.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_TH != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_TH.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_EN != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_BRAND_NAME_EN.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_TH != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_TH.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_EN != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_SUBBRAND_NAME_EN.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_TH != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_TH.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_EN != null ? (_itemsInit.ArrestIndictmentProduct[j].PRODUCT_MODEL_NAME_EN.toString() + ' ') : '') +
                                  (_itemsInit.ArrestIndictmentProduct[j].DEGREE != null ? (_itemsInit.ArrestIndictmentProduct[j].DEGREE.toString() + ' ดีกรี ') : ' ') +
                                  _itemsInit.ArrestIndictmentProduct[j].SIZES.toString() +
                                  ' ' +
                                  _itemsInit.ArrestIndictmentProduct[j].SIZES_UNIT.toString(),
                              style: textInputStyle,
                            ),
                          ),
                          Container(
                            padding: paddingLabel,
                            child: Text(
                              "ค่าปรับประมาณการ",
                              style: textLabelStyle,
                            ),
                          ),
                          Container(
                            width: size.width,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: Width,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: paddingInputBox,
                                        child: TextField(
                                          style: textInputStyle,
                                          focusNode: _itemsInit.ArrestIndictmentProduct[j].Arrest6Controller.myFocusNodeFine,
                                          controller: _itemsInit.ArrestIndictmentProduct[j].Arrest6Controller.editFine,
                                          keyboardType: TextInputType.number,
                                          textCapitalization: TextCapitalization.words,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 0.0, bottom: 4.0),
                                        height: 1.0,
                                        color: Colors.grey[300],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: paddingLabel,
                                  child: Text(
                                    "\t\tบาท",
                                    style: textLabelStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
          )
        : ListView.builder(
            itemCount: _itemsInit.ArrestIndictmentDetail.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                child: Container(
                    padding: EdgeInsets.all(22.0),
                    decoration: BoxDecoration(
                        //color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border(
                          //top: BorderSide(color: Colors.grey[300], width: 1.0),
                          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
                        )),
                    child: ExpandableNotifier(
                      controller: _itemsInit.ArrestIndictmentDetail[index].expController,
                      child: Stack(
                        children: <Widget>[
                          Expandable(collapsed: buildCollapsed(index), expanded: buildExpanded(index)),
                          Align(
                            alignment: Alignment.topRight,
                            child: Builder(
                              builder: (context) {
                                var exp = ExpandableController.of(context);
                                return _itemsInit.ArrestIndictmentProduct.length > 0
                                    ? IconButton(
                                        onPressed: () {
                                          exp.toggle();
                                        },
                                        icon: Icon(
                                          exp.expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                          size: 32,
                                          color: Colors.grey[400],
                                        ))
                                    : Container();
                              },
                            ),
                          ),
                          /*Align(
                      alignment: Alignment.bottomLeft,
                      child: Text('LEFT'),
                    )*/
                        ],
                      ),
                    )),
              );
            },
          );
  }

  _navigateEdit(BuildContext context, item) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TabScreenArrest6Product(
                ItemsProductEdit: item,
                IsComplete: false,
              )),
    );
    setState(() {
      //_itemsDataSelect = result;
    });
  }

  Widget _buildBottom() {
    var size = MediaQuery.of(context).size;
    TextStyle textStyleButton = TextStyle(color: Colors.white, fontSize: 18.0, fontFamily: FontStyles().FontFamily);
    bool isCheck = false;
    bool IsLawbreaker = false;
    if (widget.ItemsData.ArrestIndictmentDetail.length > 0 || widget.ItemsData.ArrestIndictmentProduct.length > 0) {
      IsLawbreaker = true;
      isCheck = true;
    }
    /*_countItem = 0;
    _itemsInit.forEach((item) {
      if (item.IsCheckOffence)
        setState(() {
          isCheck = item.IsCheckOffence;
          _countItem++;
        });
    });*/
    return isCheck
        ? Container(
            width: size.width,
            height: 65,
            color: Color(0xff2e76bc),
            child: MaterialButton(
              onPressed: () {
                double fine_pro = 0, fine_detail = 0;
                _itemsDataSelect_pro = [];
                for (int i = 0; i < _itemsInit.ArrestIndictmentProduct.length; i++) {
                  if (_itemsInit.ArrestIndictmentProduct[i].IsCheckOffence) {
                    if (_itemsInit.ArrestIndictmentProduct[i].Arrest6Controller.editFine.text.isEmpty) {
                      fine_pro = 0;
                    } else {
                      fine_pro = double.parse(_itemsInit.ArrestIndictmentProduct[i].Arrest6Controller.editFine.text);
                    }
                    _itemsInit.ArrestIndictmentProduct[i].FINE_ESTIMATE = fine_pro;
                    _itemsInit.ArrestIndictmentProduct[i].INDEX = i;
                    _itemsDataSelect_pro.add(_itemsInit.ArrestIndictmentProduct[i]);
                  }
                }
                for (int i = 0; i < _itemsInit.ArrestIndictmentDetail.length; i++) {
                  if (_itemsInit.ArrestIndictmentDetail[i].IsCheckOffence) {
                    if (_itemsInit.ArrestIndictmentDetail[i].editFine.text.isEmpty) {
                      fine_detail = 0;
                    } else {
                      fine_detail = double.parse(_itemsInit.ArrestIndictmentDetail[i].editFine.text);
                    }
                    _itemsInit.ArrestIndictmentDetail[i].FINE_ESTIMATE = fine_detail;
                    _itemsInit.ArrestIndictmentDetail[i].INDEX = i;
                    _itemsDataSelect_delt.add(_itemsInit.ArrestIndictmentDetail[i]);

                    print(widget.ItemsData.ArrestIndictmentDetail[i].FINE_ESTIMATE);
                  }
                }
                widget.ItemsData.ArrestIndictmentDetail = _itemsDataSelect_delt;
                Navigator.pop(context, widget.ItemsData);
              },
              child: Center(
                child: Text(
                  'ตกลง',
                  style: textStyleButton,
                ),
              ),
            ),
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextAppbar = TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: FontStyles().FontFamily);
    Color labelColor = Color(0xff2e76bc);
    TextStyle textInputStyleCheckAll = TextStyle(fontSize: 16.0, color: labelColor, fontFamily: FontStyles().FontFamily);
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
                widget.Title,
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
                        child: new Text('ILG60_B_01_00_26_00',
                          style: TextStyle(color: Colors.grey[400],fontFamily: FontStyles().FontFamily,fontSize: 12.0),),
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
        bottomNavigationBar: _buildBottom(),
      ),
    );
  }
}
